"""Figure wheels driven by the chart: BAB/F/018-019, multiplication without table.

A HYPOTHESIS, NOT A RECONSTRUCTION. The rules are docs/f-mill-rules.md,
committed before this was first run against the numbers Babbage wrote on the
sheets. It reads the transcription (mechanical/F018-cycle*.txt,
F019-cycle*.txt) band by band, finds in each band which figure wheels give
off and which receive (from the Cir arrows, the stepped shafts and the
words), and turns wheels one tooth at a time over rows 1-9. Carriage is a
warning set when a product wheel passes from 9 to 0, acted on in row 13 where
the chart writes "Carry".

Nothing here adds or multiplies numbers. The only operation on a figure is
`turn`: one wheel, one tooth. The numbers written in "Figures upon Axis A/B"
are targets, compared after each band; the start state is the operands (from
the cover and the rows above band 1) and zeros where the sheet says nothing
(assumed; docs/f-mill-rules.md section 3).

  python3 scripts/f_mill.py                  print the run, both variants
  python3 scripts/f_mill.py --json OUT       also write the trace as JSON
  python3 scripts/f_mill.py --md OUT         write the result document
"""

import json
import re
import sys
from copy import deepcopy
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BANDS = [("F/018", 1), ("F/018", 2), ("F/018", 3), ("F/019", 4), ("F/019", 5), ("F/019", 6)]
CAGES = 6
GROUP = {"Multiplicand": "A", "Product": "B", "Multiplier": "C"}


# ---------------------------------------------------------------- the chart

def band_file(sheet, n):
    return ROOT / "mechanical" / f"{sheet.replace('/', '')}-cycle{n}.txt"


def read_band(sheet, n):
    """The marks of one band that the rules use: Cir arrows, stepped shafts,
    words by group, Carry, and the numbers at row 14."""
    b = {"sheet": sheet, "band": n, "cir": set(), "shaft": {}, "fig": {}, "words": {}, "carry": False,
         "carriage_zeros": False, "recorded": {}, "notes": []}
    for line in band_file(sheet, n).read_text().splitlines():
        if line.startswith("%") or line.startswith("rows") or "|" not in line:
            continue
        row, col, mark, *note = [x.strip() for x in line.split("|")]
        note = note[0] if note else ""
        if row.startswith("top"):
            continue  # the partial rows above a sheet's first band repeat the previous band
        name = re.search(r"\[([^\]]*)\]", col)
        name = name.group(1) if name else col
        m = re.match(r"Axis ([ABC]) Cir", name)
        if m and "long arrow down" in mark:
            b["cir"].add(m.group(1))
        m = re.match(r"Axis ([ABC]) Fig wheel No([12])", name)
        if m:
            key = (m.group(1), int(m.group(2)))
            if mark.startswith("stepped shaft"):
                b["shaft"][key] = "down" if "down" in mark else "up"
            elif mark.startswith("word"):
                b["fig"][key] = mark.split('"')[1]
        if name in GROUP and mark.startswith("words"):
            b["words"][GROUP[name]] = mark.split('"')[1]
        if name.startswith("Carriage b") and "Carry" in mark:
            b["carry"] = True
        if name.startswith("Carriage 'b") and "Zeros" in mark:
            b["carriage_zeros"] = True
        m = re.match(r"Figures upon Axis ([AB])", name)
        if m and mark.startswith("number"):
            if row == "14":
                b["recorded"][m.group(1)] = mark.split('"')[1]
            else:
                b["notes"].append(f"row {row}, Figures upon Axis {m.group(1)}: {mark} ({note})")
    return b


# ---------------------------------------------------------------- the wheels

def digits(n, cages=CAGES):
    return [(n // 10 ** i) % 10 for i in range(cages)]


def top_aligned(n, cages=CAGES):
    """The figures of n with its first figure in the top cage (assumed, for the multiplier)."""
    return [int(c) for c in reversed(str(n).ljust(cages, "0"))]


def value(w):
    return "".join(str(d) for d in reversed(w))


class Mill:
    def __init__(self):
        self.w = {(x, k): [0] * CAGES for x in "ABC" for k in (1, 2)}
        self.w[("A", 1)] = digits(1028)
        self.w[("C", 1)] = top_aligned(201)
        self.warn = [False] * CAGES
        self.out = []          # figures that left an axis by its top cage: (band, axis, figure)
        self.turns = 0         # wheel-teeth turned, to show the work is done tooth by tooth
        self.log = []

    def turn(self, key, cage, by):
        """The one operation: wheel `key`, cage `cage`, one tooth forward (+1) or back (-1).
        Returns True when a forward turn passes from 9 to 0."""
        self.turns += 1
        old = self.w[key][cage]
        self.w[key][cage] = (old + by) % 10
        return by > 0 and old == 9

    def upon(self, axis):
        a, b = value(self.w[(axis, 1)]), value(self.w[(axis, 2)])
        nz = [v for v in (a, b) if int(v)]
        if len(nz) == 2:
            return f"{a} | {b}"
        return nz[0] if nz else "0" * CAGES


def engagements(b, mill, variant):
    """Givers and receivers of a band, from its marks (T1-T3) or, in variant W
    where an axis's words stand with no marks, from its words (T7)."""
    pairs, notes = [], []
    givers = {x: k for (x, k), d in b["shaft"].items() if d == "down" and x in b["cir"]}
    receivers = [(x, k) for (x, k), d in b["shaft"].items() if d == "up"]
    source = "marks"
    if variant == "W" and not givers and "A" in b["words"] and "Give off" in b["words"]["A"]:
        held = [k for k in (1, 2) if int(value(mill.w[("A", k)]))]
        if len(held) == 1:
            g = held[0]
            givers = {"A": g}
            receivers = [("A", 3 - g)]
            if "B" in b["words"] and re.search(r"Add to N\.os one", b["words"]["B"]):
                receivers.append(("B", 1))
            source = "words (T7): giver chosen by state"
            notes.append(f"no marks; executed from the words, A N.o {g} gives off because it alone is not at zero")
    for (x, k) in receivers:
        if x in givers:
            step = "Step up" in b["words"].get(x, "")
            pairs.append(((x, givers[x]), (x, k), "step" if step else 0))
        else:
            others = [(gx, gk) for gx, gk in givers.items() if (gx, 3 - gk) in receivers]
            if len(others) == 1:
                pairs.append((others[0], (x, k), 0))
            else:
                notes.append(f"{x} N.o {k} receives, but its giver is ambiguous ({others}); not executed")
    return pairs, source, notes


def run(variant="W", step=1, retain=True, carriage=True):
    """step, retain, carriage: set to 0/False to take that rule away (an ablation)."""
    mill = Mill()
    bands = []
    for sheet, n in BANDS:
        b = read_band(sheet, n)
        before = deepcopy(mill.w)
        pairs, source, notes = engagements(b, mill, variant)
        pairs = [(g, r, step if off == "step" else off) for g, r, off in pairs
                 if retain or g[0] != r[0] or off == "step"]
        checks = []
        by_rule = source != "marks"  # T7 chose the giver by state: its checks hold by construction
        for g, r, off in pairs:
            if g[0] == r[0] and not by_rule:
                checks.append((f"{g[0]} N.o {g[1]} gives off and holds the axis's number",
                               int(value(before[g])) != 0))
                checks.append((f"{r[0]} N.o {r[1]} stands at zero before it receives", int(value(before[r])) == 0))
                words = b["words"].get(g[0], "")
                m = re.search(r"from (one|two) to (one|two)", words)
                if m:
                    num = {"one": 1, "two": 2}
                    checks.append((f"the words \"{words}\" name the same giver and receiver as the marks",
                                   (num[m.group(1)], num[m.group(2)]) == (g[1], r[1])))
        if re.search(r"Add to N\.os one", b["words"].get("B", "")):
            checks.append(("\"Add to N.os one\" finds the product on B N.o 1",
                           int(value(before[("B", 2)])) == 0))
        # rows 1-9: one tooth per row
        givers = sorted({g for g, _, _ in pairs})
        for row in range(1, 10):
            for g in givers:
                for cage in range(CAGES):
                    if mill.w[g][cage] == 0:
                        continue
                    mill.turn(g, cage, -1)
                    for g2, r, off in pairs:
                        if g2 != g:
                            continue
                        j = cage + off
                        if j >= CAGES:
                            mill.out.append((n, g[0], 1))
                            continue
                        if mill.turn(r, j, +1) and r[0] == "B":
                            mill.warn[j] = True
        # figures out of the top cage, as figures
        outs = sum(f for (bn, ax, f) in mill.out if bn == n and ax == "C")
        # row 13: carriage
        carried, steps = [], 0
        if b["carry"] and carriage:
            target = ("B", 1)
            while any(mill.warn):
                steps += 1
                pending = [j for j in range(CAGES) if mill.warn[j]]
                mill.warn = [False] * CAGES
                for j in pending:
                    carried.append(j)
                    if j + 1 < CAGES and mill.turn(target, j + 1, +1):
                        mill.warn[j + 1] = True
        elif any(mill.warn):
            notes.append(f"warnings set on cages {[j for j in range(CAGES) if mill.warn[j]]} with no Carry in this band")
        rec = b["recorded"]
        got = {x: mill.upon(x) for x in "AB"}
        bands.append({
            "sheet": sheet, "band": n, "source": source, "words": b["words"],
            "engagements": [{"gives": f"{g[0]} N.o {g[1]}", "receives": f"{r[0]} N.o {r[1]}",
                             "cage_offset": off} for g, r, off in pairs],
            "carry_marked": b["carry"], "carried_from_cages": carried, "carry_steps": steps,
            "carriage_zeros_marked": b["carriage_zeros"],
            "multiplier_figure_out": outs if any(g[0] == "C" and off for g, _, off in pairs) else None,
            "wheels": {f"{x} N.o {k}": value(mill.w[(x, k)]) for x in "ABC" for k in (1, 2)},
            "upon": got, "recorded": rec,
            "match": {x: (got[x].lstrip("0") or "0") == (rec[x].lstrip("0") or "0") for x in rec},
            "checks": [{"check": c, "holds": ok} for c, ok in checks], "notes": notes + b["notes"],
        })
    return {"variant": variant, "ablation": {"step": step, "retain": retain, "carriage": carriage},
            "turns": mill.turns, "bands": bands}


def adds_after_steps(r):
    """Exploratory: the figure the multiplier gives out of its top cage at each
    multiplier step, against the number of Add bands before its next step."""
    rows, cur = [], None
    for b in r["bands"]:
        if b["multiplier_figure_out"] is not None:
            cur = {"band": b["band"], "figure_out": b["multiplier_figure_out"], "adds": 0}
            rows.append(cur)
        elif cur is not None and "Add" in b["words"].get("B", ""):
            cur["adds"] += 1
    return rows


def report(runs):
    W, M = runs["W"], runs["M"]
    lines = ["# Figure wheels from the chart: the run (F/018–019)", "",
             "Generated by `python3 scripts/f_mill.py --md docs/f-mill-f018.md`, under the rules of "
             "[`f-mill-rules.md`](f-mill-rules.md) (committed first, 20d5fba). **Not a blind test**: "
             "the recorded products were known when the rules were written.", "",
             f"Every figure below was produced by turning single wheels one tooth at a time "
             f"({W['turns']} turns in variant W); no step adds or multiplies numbers.", "",
             "## 1. The numbers upon each axis after each band", "",
             "| Band | Sheet | What the band does (engagements) | Upon A | Recorded | Upon B (W) | Upon B (M) | Recorded |",
             "|---|---|---|---|---|---|---|---|"]
    for bw, bm in zip(W["bands"], M["bands"]):
        eng = "; ".join(f"{e['gives']} → {e['receives']}" + (" one cage up" if e["cage_offset"] else "")
                        for e in bw["engagements"]) or "nothing on A or B"
        if bw["source"] != "marks":
            eng += " *(from the words)*"
        tick = lambda ok: "✓" if ok else "✗"
        lines.append(f"| {bw['band']} | {bw['sheet']} | {eng} | {bw['upon']['A']} {tick(bw['match'].get('A', False))} | "
                     f"{bw['recorded'].get('A', '—')} | {bw['upon']['B']} {tick(bw['match'].get('B', False))} | "
                     f"{bm['upon']['B']} {tick(bm['match'].get('B', False))} | {bw['recorded'].get('B', '—')} |")
    nW = sum(b["match"].get("B", False) for b in W["bands"][1:])
    nM = sum(b["match"].get("B", False) for b in M["bands"][1:])
    nA = sum(b["match"].get("A", False) for b in W["bands"])
    lines += ["", f"Product targets (bands 2–6; band 1's 000000 equals the start): **W {nW}/5, M {nM}/5**. "
              f"Multiplicand retained: {nA}/6.", "",
              "Variant M executes only the marks. Band 6 has the words \"Give off and retain\" and "
              "\"Add to N.<sup>os</sup> one\" and no Cir arrow or stepped shaft (re-read at full resolution), "
              "so under M nothing happens and the product stays 205600. Variant W executes band 6's words, "
              "choosing the giving wheel as the one not at zero (rule T7): that choice is this project's.", "",
              "## 2. Carriage", ""]
    for b in W["bands"]:
        if b["carry_marked"]:
            lines.append(f"- Band {b['band']}: \"Carry\" marked; warned cages {b['carried_from_cages'] or 'none'}"
                         f" ({b['carry_steps']} carriage step(s)).")
    chain = any(b["carry_steps"] > 1 for b in W["bands"])
    lines += ["", ("A carry met a 9 on this run." if chain else
                   "No carry meets a 9 on this run, so anticipating and successive carriage give the same numbers: "
                   "the sheets cannot tell them apart."), "",
              "## 3. Take a rule away", "",
              "Each inferred rule, removed in turn (variant W otherwise). A rule whose removal changes nothing "
              "is not tested by these sheets.", "",
              "| Removed | Product after bands 2–6 | Targets met |", "|---|---|---|"]
    for name, r in runs["ablations"].items():
        got = [b["upon"]["B"] for b in r["bands"][1:]]
        met = sum(b["match"].get("B", False) for b in r["bands"][1:])
        lines.append(f"| {name} | {', '.join(got)} | {met}/5 |")
    lines += ["",
              "## 4. State checks the marks could have failed", "",
              "In band 6 (variant W) the giving wheel was chosen by rule T7 as the one holding the number, so "
              "the two checks of giver and receiver would hold by construction; they are left out.", "",
              "| Band | Check | Holds |", "|---|---|---|"]
    for b in W["bands"]:
        for c in b["checks"]:
            lines.append(f"| {b['band']} | {c['check']} | {'yes' if c['holds'] else '**no**'} |")
    ok = sum(c["holds"] for b in W["bands"] for c in b["checks"])
    tot = sum(1 for b in W["bands"] for c in b["checks"])
    lines += ["", f"{ok} of {tot} hold.", "",
              "## 5. Exploratory: the multiplier (fitted, not evidence)", "",
              "201 is placed with its first figure in the top cage of C N.<sup>o</sup> 1 (assumed, knowing the "
              "sequence). Each multiplier step moves C's figures one cage up and the top figure out of the axis (T4).", "",
              "| Multiplier step in band | Figure out of the top | Add bands before the next step |", "|---|---|---|"]
    for r in adds_after_steps(W):
        lines.append(f"| {r['band']} | {r['figure_out']} | {r['adds']} |")
    lines += ["", "They agree, but only because of the placement chosen. How the figure counts the additions "
              "is not on the sheets (missing transition M1).", "",
              "## 6. What this shows and what it does not", "",
              "- **Shown, on these two sheets only:** reading the stepped shafts as wheels giving off to zero and "
              "receiving tooth for tooth, \"Step up\" as one cage higher (Vol II p 42), and \"Carry\" as a warning "
              "acted on in row 13, the wheel states reproduce the five products Babbage wrote after band 1 "
              "(four from the marks alone, the fifth only when band 6's words are executed), and the multiplicand is "
              "retained in every band. The state checks also hold: each band's marked giving wheel is the one "
              "holding the number, and \"Add to N.<sup>os</sup> one\" always finds the product on N.<sup>o</sup> 1.",
              "- **Not shown:** that this is how the engine of January 1836 worked. The rules were written knowing "
              "the answers; the engagements are read from Babbage's words and the stepped shafts, which already say "
              "at the level of numbers what each band does.",
              "- **Missing, not simulated:** M1 (how the multiplier's figure fixes the number of additions: the "
              "simulator takes the order of bands from the chart); M2 (how the B/U bolting and the lifts of the Ver "
              "columns put wheels into gear; nothing here uses them); M3 (\"Carriage 'b … Zeros\"; how a warning is "
              "held); M4 (the roles of R2, pp, ap, g, g1, the ′ and ″ parts).",
              "- **Band 6** is executed from its words, not its marks. Under the marks alone the last product fails.",
              "- **Assumed:** six cages on A and C; every wheel the sheet does not mention starts at zero; cage *i* "
              "of the multiplicand gives to cage *i* of the product.", "",
              "A test would apply these rules, unchanged, to a sheet whose numbers have not been read: see the "
              "division sheets, whose numbers are already transcribed (`sources/notes/F021-F033-arrows.md`), so "
              "that test would not be blind either.", ""]
    return "\n".join(lines)


if __name__ == "__main__":
    runs = {"W": run("W"), "M": run("M"), "ablations": {
        "T3, the cage higher on a step (a step gives to the same cage)": run("W", step=0),
        "T2 on the same axis (nothing is retained)": run("W", retain=False),
        "T6, carriage": run("W", carriage=False)}}
    args = sys.argv[1:]
    if "--json" in args:
        Path(args[args.index("--json") + 1]).write_text(json.dumps(runs, ensure_ascii=False, indent=1) + "\n")
    if "--md" in args:
        Path(args[args.index("--md") + 1]).write_text(report(runs))
    for v in ("W", "M"):
        r = runs[v]
        print(f"variant {v} ({r['turns']} tooth turns)")
        for b in r["bands"]:
            eng = ", ".join(f"{e['gives']}->{e['receives']}{'+1' if e['cage_offset'] else ''}" for e in b["engagements"])
            print(f"  band {b['band']}: A {b['upon']['A']} (rec {b['recorded'].get('A')}), "
                  f"B {b['upon']['B']} (rec {b['recorded'].get('B')})  [{eng}] carry {b['carried_from_cages']}"
                  f"{' out ' + str(b['multiplier_figure_out']) if b['multiplier_figure_out'] is not None else ''}")
            for c in b["checks"]:
                if not c["holds"]:
                    print(f"     CHECK FAILS: {c['check']}")
            for n_ in b["notes"]:
                print(f"     note: {n_}")
