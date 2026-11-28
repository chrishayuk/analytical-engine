"""A stateful mechanical simulator driven by the Series F charts.

A HYPOTHESIS, NOT A RECONSTRUCTION. It reads the B/U labels of a chart
(sources/notes/F021-F033-inputs.md) and executes them as transitions of a
mechanical state, band by band. It is kept apart from the predictor
(scripts/predict_f.py, frozen) and the scorer (scripts/score_heldout2.py); it
uses only the predictor's label parsing.

What it represents, each separately:

  Component         a part (a column): its attachment and its height
  MotionResource    a numbered travelling platform k, or an UNKNOWN resource
                    (a bare "B": attached, to what is not known)
  Attachment        component -> resource; persists until an explicit U
  state "unknown"   the initial configuration of every component on a sheet
  Displacement      a property of the resource in a CONFIGURATION (F/013's
                    table is one; the carriage sheet has none adopted)
  Event             a timed transition: (sheet, band, row, kind, ...)
  mid-band change   a label at about row 11 (F/033), applied there
  LockingMechanism  the Lock columns' U/L: recorded, no effect on motion

Every event carries a status:

  supported     tested on held-out sheets (held-out-2-result.md): fresh B,
                persistence, U, detachment
  unresolved    the simulator does not know: bare B (unknown resource), a
                carriage displacement, a component in the unknown state, a
                Lock mechanism's effect
  unverified    the return's timing (the return-with-platform hypothesis is
                untested), and E1 ("L k" read as "B k", exploratory)

An unresolved motion leaves the component's height unknown (None); nothing
is filled in. No arithmetic is modelled: nothing here says what a motion does
to a number.

  python3 scripts/f_sim.py [SHEET]         print a sheet's event trace
  python3 scripts/f_sim.py --json OUT      write every sheet's trace as JSON
"""

import json
import sys
from dataclasses import dataclass, field, asdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from predict_f import INPUTS, DESIGN, tables, tokens  # label parsing only

F013 = {1: 1.1, 2: .6, 3: 1.1, 4: .6, 5: .4, 6: .2, 7: -.2, 8: -.4, 9: -.6, 10: -1.1, 11: -.6, 12: -1.1}

# Displacement configurations by design. F/013's table is the fallback for the
# designs whose sheets write no platform heads; for the carriage sheet it is not
# adopted (held-out-2-result.md section 5: its mid-band B 7 goes the other way).
CONFIG = {
    "division without table": ("F/013 fallback", F013),
    "square root": ("F/013 fallback", F013),
    "ordinary cycle": ("F/013 fallback", F013),
    "carriage": ("none adopted", None),
}


@dataclass
class Resource:
    id: str                       # "P3" or "?F/021:1:T2"
    kind: str                     # "platform" | "unknown"
    k: int | None = None


@dataclass
class Component:
    name: str
    state: str = "unknown"        # unknown | attached | detached
    resource: str | None = None
    height: float | None = 0.0    # None: not known
    exploratory: bool = False     # attached by an "L k" (E1)


@dataclass
class Event:
    sheet: str
    band: str
    row: str
    kind: str
    component: str
    detail: str
    status: str
    height: float | None = None


@dataclass
class Sheet:
    sheet: str
    design: str
    config: str
    components: dict = field(default_factory=dict)
    resources: dict = field(default_factory=dict)
    locks: dict = field(default_factory=dict)
    events: list = field(default_factory=list)

    def ev(self, band, row, kind, comp, detail, status):
        c = self.components.get(comp)
        self.events.append(Event(self.sheet, band, row, kind, comp, detail, status,
                                 None if c is None or c.height is None else round(c.height, 3)))

    def resource(self, rid, kind, k=None):
        return self.resources.setdefault(rid, Resource(rid, kind, k))

    def displacement(self, r):
        table = CONFIG[self.design][1]
        if r.kind != "platform" or table is None:
            return None
        return table.get(r.k)

    # transitions
    def detach(self, band, row, col):
        c = self.components[col]
        c.state, c.resource = "detached", None
        self.ev(band, row, "detach", col, "U: released from its resource", "supported")

    def attach(self, band, row, col, k, via="B"):
        c = self.components[col]
        if c.state == "attached":
            self.ev(band, row, "conflict", col, f"{via} while attached to {c.resource}, no U between", "unresolved")
        if k is None:
            r = self.resource(f"?{self.sheet}:{band}:{col}", "unknown")
            status = "unresolved"
        else:
            r = self.resource(f"P{k}", "platform", k)
            status = "unverified" if via == "L" else "supported"
        c.state, c.resource, c.exploratory = "attached", r.id, via == "L"
        self.ev(band, row, "attach", col, f"{via}{'' if k is None else ' ' + str(k)}: attached to {r.id}", status)

    def motion(self, band, row, col):
        c = self.components[col]
        r = self.resources[c.resource]
        d = self.displacement(r)
        if d is None:
            c.height = None
            why = "bare B: unknown resource" if r.kind == "unknown" else f"no displacement adopted ({self.config})"
            self.ev(band, row, "motion", col, f"moves with {r.id}; displacement unknown ({why})", "unresolved")
            return
        if c.height is not None:
            c.height += d
        self.ev(band, row, "motion", col, f"moves with {r.id} by {d:+g}",
                "unverified" if c.exploratory else "supported")

    def ret(self, band, col):
        c = self.components[col]
        r = self.resources[c.resource]
        d = self.displacement(r)
        if d is not None and c.height is not None:
            c.height -= d
        self.ev(band, "12–1/3", "return", col, f"returns with {r.id}" + (f" by {-d:+g}" if d is not None else ""),
                "unverified")


def run(sheet, rows):
    design = DESIGN.get(sheet, "?")
    s = Sheet(sheet, design, CONFIG.get(design, ("none", None))[0])
    order = []
    for b, _, _ in rows:
        if b not in order:
            order.append(b)
    for b, col, _ in rows:
        if col.lower().startswith("lock"):
            s.locks.setdefault(col, "unknown")
        else:
            s.components.setdefault(col, Component(col))
    pending = []  # returns of the current band: logged when the next band (not a mid-band row) begins

    def flush(b):
        for name in pending:
            if s.components[name].state == "attached":
                s.ret(b, name)
            else:
                s.ev(b, "12–1/3", "return", name, "returns (its resource released it at a closing label)", "unverified")
        pending.clear()

    last = None
    for band in order:
        mid = "mid" in band
        if not mid:
            flush(last)
        last = band if not mid and "one row lower" not in band and not band.startswith("L12") else last
        closing = band.startswith("L12") or "one row lower" in band
        row = "≈11" if mid else "end" if closing else "label"
        cells = [(col, cell) for b, col, cell in rows if b == band]
        for col, cell in cells:
            toks, _ = tokens(cell)
            if col in s.locks:
                for kind, _ in toks:
                    s.locks[col] = {"U": "unlocked", "L": "locked"}.get(kind, s.locks[col])
                    s.ev(band, row, "lock", col, f"{kind}: {s.locks[col]} (effect on motion not modelled)", "unresolved")
                continue
            for kind, k in toks:
                if kind == "U":
                    s.detach(band, row, col)
                elif kind == "B":
                    s.attach(band, row, col, k)
                elif kind == "L" and k is not None:
                    s.attach(band, row, col, k, via="L")
                elif kind == "UB":
                    s.ev(band, row, "label", col, "B&U: not interpreted", "unresolved")
        if closing:
            continue
        motion_row = "after ≈11" if mid else "1"
        movers = [c for c in s.components.values() if c.state == "attached"]
        if mid:  # only the components whose label changed here move in the mid-band row
            changed = {col for col, _ in cells}
            movers = [c for c in movers if c.name in changed]
        for c in movers:
            s.motion(band, motion_row, c.name)
        if not mid:
            for c in s.components.values():
                if c.state == "unknown":
                    s.ev(band, "1", "no prediction", c.name, "initial configuration unknown", "unresolved")
        pending.extend(c.name for c in movers if c.name not in pending)
    flush(last)
    return s


def all_sheets():
    out, seen = [], {}
    for sheet, rows in tables(INPUTS.read_text()):
        n = seen[sheet] = seen.get(sheet, 0) + 1
        s = run(sheet, rows)
        if sheet == "F/033":
            s.sheet = f"F/033 {'upper' if n == 1 else 'lower'}"
            for e in s.events:
                e.sheet = s.sheet
        out.append(s)
    return out


_OBS = None


def observed(e):
    """The blind transcription's row-1 mark for a simulated motion or no-prediction
    event (sources/notes/F021-F033-arrows.md), for display beside it. These sheets
    have been seen: this is a comparison after the fact, not a test; the test is
    docs/predictions/held-out-2-result.md."""
    global _OBS
    if e.kind not in ("motion", "no prediction"):
        return None
    if _OBS is None:
        from score_heldout2 import observations
        _OBS = observations()
    band = {"U-mid": "U1", "L-mid": "L1"}.get(e.band.split(" ")[0], e.band)
    o = _OBS.get((e.sheet[:5], band, e.component))
    if o is None:
        return None
    other = o[3] if e.row.startswith("after") else ""
    return {"row1": o[0], "figure": o[1], "returns": o[2], "other": other}


def summary(s):
    from collections import Counter
    c = Counter((e.kind, e.status) for e in s.events)
    return ", ".join(f"{k} {st} {n}" for (k, st), n in sorted(c.items()))


if __name__ == "__main__":
    sheets = all_sheets()
    if len(sys.argv) > 2 and sys.argv[1] == "--json":
        Path(sys.argv[2]).write_text(json.dumps([{
            "sheet": s.sheet, "design": s.design, "config": s.config,
            "resources": [asdict(r) for r in s.resources.values()],
            "events": [dict(asdict(e), observed=observed(e)) for e in s.events]} for s in sheets],
            ensure_ascii=False, indent=1) + "\n")
        print(f"wrote {sys.argv[2]}")
    elif len(sys.argv) > 1:
        for s in sheets:
            if s.sheet == sys.argv[1]:
                for e in s.events:
                    print(f"{e.band:>6} {e.row:>8} {e.kind:<13} {e.component:<32} {e.detail:<58} {e.status:<11} h={e.height}")
    else:
        for s in sheets:
            print(f"{s.sheet} ({s.design}; displacement: {s.config}): {summary(s)}")
