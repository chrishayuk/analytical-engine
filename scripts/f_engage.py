"""From bolting to gearing: which figure wheel gives off, read from the B/U state.

Rules: docs/f-engage-rules.md (E0-E2), committed before this was written.

  1. The test. On the held-out sheets, the attachment of each two-wheel axis's
     Ver column (and of S1/SS) in each band, by persistence, predicts whether
     the axis gives off and which wheel; scored against the words "Zeros" and
     "Figs" in the blind transcription (sources/notes/F021-F033-arrows.md).
  2. The link. On F/018-019, f_mill.py run with its engagements chosen from
     the B/U state (variant E) instead of the stepped shafts.

  python3 scripts/f_engage.py [--md OUT] [--json OUT]
"""

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from predict_f import INPUTS, tables, tokens          # noqa: E402
from score_heldout2 import observations                # noqa: E402
import f_mill                                          # noqa: E402

ROOT = Path(__file__).resolve().parent.parent

# Two-wheel axes of the held-out sheets: (name, Ver column, [(wheel column, number)], S1, SS)
DIV = [("A", "Axis A Ver", [("Figure wh. N.º 1", 1), ("Figure wh. N.º 2", 2)], None, None),
       ("A₂", "A₂ Ver", [("Figure wheels (A₂) N.º 3", 3), ("Figure wheels (A₂) N.º 4", 4)], "S1", "SS")]
SQ = [("D-C", "D-C Ver", [("D-Fig wh. 1", 1), ("D-Fig wh. 2", 2)], None, None),
      ("QA", "QA Ver", [("Figure wheels (QA) N.º 3", 3), ("Figure wheels (QA) N.º 4", 4)], "S1", "SS")]
AXES = {**{f"F/0{n}": DIV for n in (21, 22, 23, 24)}, **{f"F/0{n}": SQ for n in (26, 27, 28, 29)},
        "F/032": [("A", "Axis A Ver", [("Figure wheel N.º 1", 1), ("Figure wheel N.º 2", 2)], None, None)]}

# Seen before the rules were written (docs/f-engage-rules.md section 3)
SEEN = {("F/021", b, "A") for b in "123"} | {("F/022", b, "A") for b in "123"} | {("F/022", "2", "A₂")}


def states(rows):
    """The attachment of every labelled column after each band's label row, by
    persistence (hypothesis P): 'P5', '?' (bare B), None (detached), or absent
    from the dict while in the unknown state (labelled only later)."""
    order, out, st = [], {}, {}
    for b, _, _ in rows:
        if b not in order:
            order.append(b)
    labelled = {col for _, col, _ in rows}
    for band in order:
        for b, col, cell in rows:
            if b != band:
                continue
            for kind, k in tokens(cell)[0]:
                if kind == "U":
                    st[col] = None
                elif kind == "B":
                    st[col] = f"P{k}" if k is not None else "?"
        out[band] = dict(st)
    return order, out, labelled


def predict(state, labelled, ver, s1, ss, lo, hi):
    """E0-E2 for one axis in one band: ('none' | 'unresolved' | giver wheel number, why)."""
    if ver not in labelled:
        v = "never"
    elif ver not in state:
        return "unresolved", "Ver in the unknown state"
    else:
        v = state[ver]
    if v == "never" or v is None:
        e0 = "none"
    elif v in ("P5", "P6"):
        e0 = "gives"
    else:
        return "unresolved", f"Ver attached to {v}"
    if e0 == "none":
        return "none", "Ver " + ("never labelled" if v == "never" else "detached")
    g1 = lo if v == "P5" else hi
    why = f"Ver on {v} (E1: N.o {g1} gives)"
    for col, giver, name in ((s1, lo, "S1"), (ss, hi, "SS")):
        if col and state.get(col):
            why += f"; {name} attached (E2: N.o {giver} gives)"
            if giver != g1:
                return "conflict", why
    return g1, why


def observed(obs, sheet, band, wheels):
    words = {}
    for col, n in wheels:
        o = obs.get((sheet, band, col))
        if o is None:
            return "untranscribed"
        text = " ".join(x or "" for x in o)
        if re.search(r"cropped|not photographed", text):
            return "cropped"
        z, f = re.search(r"\bZeros\b", o[3] or ""), re.search(r"\bFig(s|ures)\b", o[3] or "")
        words[n] = "Zeros" if z and not f else "Figs" if f and not z else "both" if z and f else None
    givers = [n for n, w in words.items() if w == "Zeros"]
    if not any(words.values()):
        return "none"
    if len(givers) == 1 and all(w in ("Zeros", "Figs") for w in words.values()):
        return givers[0]
    return "irregular: " + ", ".join(f"N.o {n} {w}" for n, w in words.items())


def test():
    obs = observations()
    cases = []
    for sheet, rows in tables(INPUTS.read_text()):
        if sheet not in AXES:
            continue
        order, st, labelled = states(rows)
        for band in order:
            if not re.fullmatch(r"\d+", band):
                continue
            for name, ver, wheels, s1, ss in AXES[sheet]:
                lo, hi = wheels[0][1], wheels[1][1]
                pred, why = predict(st[band], labelled, ver, s1, ss, lo, hi)
                seen = observed(obs, sheet, band, wheels)
                cases.append({"sheet": sheet, "band": band, "axis": name, "predicted": pred, "why": why,
                              "observed": seen, "exposure": "seen" if (sheet, band, name) in SEEN else "unseen"})
    return cases


def score(cases):
    out = {}
    for exp in ("unseen", "seen", "all"):
        cs = [c for c in cases if exp == "all" or c["exposure"] == exp]
        sc = [c for c in cs if c["observed"] not in ("cropped", "untranscribed")]
        e0 = [c for c in sc if c["predicted"] not in ("unresolved", "conflict")]
        e0_ok = [c for c in e0 if (c["predicted"] == "none") == (c["observed"] == "none")]
        e1 = [c for c in sc if isinstance(c["predicted"], int) and isinstance(c["observed"], int)]
        e1_ok = [c for c in e1 if c["predicted"] == c["observed"]]
        out[exp] = {"cases": len(cs), "scorable": len(sc), "E0": (len(e0_ok), len(e0)), "E1": (len(e1_ok), len(e1)),
                    "unresolved": sum(c["predicted"] in ("unresolved", "conflict") for c in sc),
                    "irregular": sum(str(c["observed"]).startswith("irregular") for c in sc)}
    return out


# ---------------------------------------------------------------- the link, on F/018-019

GROUPS = {"A": ("e01", None, None), "B": ("e14", "e27", "e26"), "C": ("e35", "e40", "e39")}  # Ver, S1, SS


def f018_states():
    """Attachment of the Ver and S columns during rows 1-9 of each band of F/018-019:
    labels written in row 15 (and the rows above band 1) act on the next band."""
    st, per = {}, {}
    for sheet, n in f_mill.BANDS:
        if n == 1:
            src = f_mill.band_file(sheet, n).read_text().splitlines()
            for line in src:
                if line.startswith("top-15") and "words" in line:
                    _, col, mark, *_ = [x.strip() for x in line.split("|")]
                    apply(st, col.split()[0], mark)
        per[n] = dict(st)
        for line in f_mill.band_file(sheet, n).read_text().splitlines():
            if line.split("|")[0].strip() == "15" and "words" in line:
                _, col, mark, *_ = [x.strip() for x in line.split("|")]
                apply(st, col.split()[0], mark)
    return per


def apply(st, col, mark):
    for kind, k in tokens(mark.replace("words ", ""))[0]:
        st[col] = None if kind == "U" else f"P{k}" if k is not None else "?"


def engage_from_state(per):
    def engage(b, mill, variant):
        state, pairs, notes = per[b["band"]], [], []
        givers = {}
        for ax, (ver, s1, ss) in GROUPS.items():
            v = state.get(ver)
            if v in ("P5", "P6"):
                g = 1 if v == "P5" else 2
                for col, gg, nm in ((s1, 1, "S1"), (ss, 2, "SS")):
                    if col and state.get(col) and gg != g:
                        notes.append(f"{ax}: {nm} conflicts with Ver on {v}")
                step = bool((s1 and state.get(s1)) or (ss and state.get(ss)))
                givers[ax] = g
                pairs.append(((ax, g), (ax, 3 - g), "step" if step else 0))
                notes.append(f"{ax} Ver on {v}{' with S bolted (a step)' if step else ''}: N.o {g} gives")
        # the receiver on another axis is kept from the words (f-engage-rules.md section 4)
        if "A" in givers and re.search(r"Add to N\.os one", b["words"].get("B", "")):
            pairs.append((("A", givers["A"]), ("B", 1), 0))
        return pairs, "B/U state (E0-E2)", notes
    return engage


def link():
    per = f018_states()
    r = f_mill.run("E", engage=engage_from_state(per))
    w = f_mill.run("W")
    rows = []
    for be, bw in zip(r["bands"], w["bands"]):
        rows.append({"band": be["band"], "state": {k: v for k, v in per[be["band"]].items()
                                                    if k in ("e01", "e14", "e35", "e26", "e27", "e39", "e40")},
                     "E": [f"{e['gives']}→{e['receives']}{' +1' if e['cage_offset'] else ''}" for e in be["engagements"]],
                     "W": [f"{e['gives']}→{e['receives']}{' +1' if e['cage_offset'] else ''}" for e in bw["engagements"]],
                     "upon_B": be["upon"]["B"], "recorded_B": be["recorded"].get("B"), "match": be["match"].get("B")})
    return rows


NAMES = {"e01": "A Ver", "e14": "B Ver", "e35": "C Ver", "e26": "′S′S", "e27": "′S1", "e39": "″S″S", "e40": "″S1"}


def acts(obs, sheet, band, wheels):
    """Supplementary observables, kept apart: does a wheel of the axis give off ("Zeros", or the
    words "Give off"), and does one receive ("Figs", or "Receive")? Both words in one cell count
    for both, and are flagged."""
    give = recv = both = False
    for col, _ in wheels:
        o = obs.get((sheet, band, col))
        if o is None:
            return None
        if re.search(r"cropped|not photographed", " ".join(x or "" for x in o)):
            return None
        t = o[3] or ""
        g = bool(re.search(r"\bZeros?\b|Give off", t))
        r = bool(re.search(r"\bFig(s|ures)\b|Receive", t))
        give, recv, both = give or g, recv or r, both or (g and r)
    return give, recv, both


def supplementary(cases):
    obs = observations()
    rows, ok, n = [], 0, 0
    for c in cases:
        if c["predicted"] in ("unresolved", "conflict"):
            continue
        wheels = next(w for name, _, w, _, _ in AXES[c["sheet"]] if name == c["axis"])
        a = acts(obs, c["sheet"], c["band"], wheels)
        if a is None:
            continue
        give, recv, both = a
        pred_give = c["predicted"] != "none"
        n += 1
        ok += pred_give == give
        if pred_give != give or recv != give:
            rows.append(f"| {c['sheet']} | {c['band']} | {c['axis']} | {c['exposure']} | "
                        f"{'gives' if pred_give else 'does not give'} | {'yes' if give else 'no'} | "
                        f"{'yes' if recv else 'no'}{' (one cell holds both words)' if both else ''} | "
                        f"{'✓' if pred_give == give else '✗'} |")
    return ["", "## 1a. Supplementary: giving off and receiving, apart", "",
            "Not the frozen score, which counted either word as a give-off. Here \"gives off\" is a \"Zeros\" "
            "(or the words \"Give off\") on one of the axis's wheels, and \"receives\" a \"Figs\" (or \"Receive\"); "
            "E0 is scored against giving off alone, on every case where E0 predicts, seen and unseen together.", "",
            f"**E0 against giving off: {ok} / {n}.** The cases where E0 misses, or where an axis receives "
            "without giving or gives without receiving:", "",
            "| Sheet | Band | Axis | Exposure | E0 | Gives off | Receives | |", "|---|---|---|---|---|---|---|---|"] + rows + [
            "", "Where the reader wrote \"Figs\" and \"Zeros\" in one cell, which wheel each belongs to is not "
            "read, and the cell counts as both giving and receiving.", "",
            "## 1b. Those cells re-read (after scoring)", "",
            "`sources/notes/F027-F029-dc-wheels.md` re-read the D-C cells of F/026–029 at full resolution (one "
            "of them, F/028 band 1, checked again on the image). The two words always stand in separate columns, "
            "one per wheel. In bands 1–3 of F/026, F/028 and F/029, and bands 1–2 of F/027, **only one D wheel has "
            "a shaft**, under \"Figs\", pointing down; the other carries \"Zeros\" (or \"0\") with no shaft, and "
            "D-C Cir has no arrow. No wheel there gives off to zero. What the stepped \"Figs\" wheel does is not "
            "settled: a down shaft is the giving direction on F/018 (T1), and reading it as receiving is an "
            "interpretation. Only F/027 band 3 and "
            "F/028 band 3 have a shaft on both wheels and a Cir arrow, and there the Ver is bolted to 5 and 6 "
            "and the giving wheel is the one E1 names (both already scored above).", "",
            "Read so, \"gives off\" meaning a \"Zeros\" wheel with its own shaft, the five D-C misses of E0 "
            "become hits: **E0 against giving off, re-read: 33 / 34**, the remaining miss F/032 band 3. This is "
            "a re-reading and a redefinition made after scoring; the frozen 21 / 29 and the 28 / 34 above stand. "
            "", ""]


def report(cases, sc, rows):
    L = ["# From bolting to gearing: the result", "",
         "Generated by `python3 scripts/f_engage.py --md docs/f-engage-result.md`, under the rules of "
         "[`f-engage-rules.md`](f-engage-rules.md) (committed first, 5c3f8c2).", "",
         "## 1. The test on the held-out sheets", "",
         "| Cases | Scorable | E0: gives off or not | E1/E2: which wheel gives | No prediction | Irregular marks |",
         "|---|---|---|---|---|---|"]
    for exp in ("unseen", "seen", "all"):
        s = sc[exp]
        L.append(f"| **{exp}** {s['cases']} | {s['scorable']} | {s['E0'][0]} / {s['E0'][1]} | {s['E1'][0]} / {s['E1'][1]} | "
                 f"{s['unresolved']} | {s['irregular']} |")
    L += ["", "Cropped bands and untranscribed columns are not scorable. \"No prediction\": the Ver column "
          "attached to a platform other than 5 or 6, by a bare B, or in the unknown state.", "",
          "| Sheet | Band | Axis | Exposure | Predicted | Why | Observed |", "|---|---|---|---|---|---|---|"]
    for c in cases:
        p, o = c["predicted"], c["observed"]
        mark = ""
        if o not in ("cropped", "untranscribed") and p not in ("unresolved", "conflict"):
            ok = (p == o) if isinstance(p, int) and isinstance(o, int) else ((p == "none") == (o == "none"))
            mark = " ✓" if ok else " **✗**"
        pp = f"N.o {p} gives" if isinstance(p, int) else p
        oo = f"N.o {o} Zeros" if isinstance(o, int) else o
        L.append(f"| {c['sheet']} | {c['band']} | {c['axis']} | {c['exposure']} | {pp} | {c['why']} | {oo}{mark} |")
    L += ["", "**Read after scoring (not part of the score):**", "",
          "- **Coverage of E1.** Of 60 unseen cases, 44 are scorable; E1 is scored only where it predicts a "
          "giving wheel and the marks show one, which is **6 cases**, all right: F/023 bands 1 and 3 and F/024 "
          "bands 1 and 2 (division, Axis A), F/027 band 3 and F/028 band 3 (square root, D-C). Platform 5 went "
          "with the lower-numbered wheel giving off, 6 with the higher, in each. No A₂, QA or ordinary-cycle "
          "case is among them. The 5 seen cases are division, Axis A.",
          "- **E0 fails on square root's D-C axis (6 of the 8 misses).** Its wheels carry \"Figs\" and "
          "\"Zeros\" in bands where its Ver is detached or never labelled. The reader wrote both words in one "
          "cell (\"Figs\" \"Zeros\"), as if across the two columns, so these are scored \"irregular\" and "
          "which wheel gives is not read. Something other than a Ver bolted to 5 or 6 can drive a give-off.",
          "- **F/032 band 2** (scored an E0 miss, and not an E1 case): no \"Zeros\"/\"Figs\", but \"Give "
          "off\" is written on N.<sup>o</sup> 2 and \"Receive\" on N.<sup>o</sup> 1, which is what E1 would "
          "predict from Ver on 6. This is corroboration outside the frozen target, not a passing case. **F/032 band 3**: Ver on 5 and no give-off marked; a "
          "real miss.",
          "- **Platforms 7 and 8** (no prediction under the rules): with A₂ and QA a give-off is marked every "
          "time, the lower-numbered wheel on 7 (3 cases) and the higher on 8 (2 cases), the pattern of 5 and 6; "
          "with Axis A on 7 or 8 nothing is marked (3 cases). Exploratory, seen after scoring.",
          "- **E2 (S1/SS) is not tested**: in no scorable held-out band is an S1 or SS attached while its axis's "
          "Ver is on 5 or 6. On the held-out sheets S1 goes with platforms 7–9, outside E1.", "",
          ] + supplementary(cases) + [
          "## 2. The link on F/018–019 (fitted)", "",
          "`f_mill.py` run with its engagements chosen from the B/U state by E0–E2 (variant E). The product "
          "axis's receiving wheel in an add band (B N.<sup>o</sup> 1) is still taken from the words \"Add to "
          "N.<sup>os</sup> one\".", "",
          "| Band | Bolted (row 1–9) | Engagements from the state (E) | From the stepped shafts (W) | Upon B (E) | Recorded |",
          "|---|---|---|---|---|---|"]
    for r in rows:
        stt = ", ".join(f"{NAMES[k]} {v}" for k, v in r["state"].items() if v)
        L.append(f"| {r['band']} | {stt or '—'} | {'; '.join(r['E']) or '—'} | {'; '.join(r['W']) or '—'} | "
                 f"{r['upon_B']} {'✓' if r['match'] else '✗'} | {r['recorded_B']} |")
    n = sum(r["match"] for r in rows[1:])
    same = sum(sorted(r["E"]) == sorted(r["W"]) for r in rows)
    L += ["", f"Products after bands 2–6: **{n}/5**. The engagements from the state equal those read from the "
          f"stepped shafts and words in {same} of 6 bands. This is fitted: E0–E2 were read off these bands. "
          "In band 6, where the sheet has no stepped shafts, the state gives the engagement the words describe "
          "without choosing the giving wheel by its contents (rule T7 is not needed).", "",
          "## 3. What is still taken from the words", "",
          "- The product's receiving wheel in an addition (B N.<sup>o</sup> 1). Exploratory, not a rule: ′p′p is "
          "bolted in exactly the three add bands of F/018–019, and F/020 pairs ′P B4 with \"Add to N.<sup>os</sup> two\".",
          "- The order of bands, and so the number of additions (missing transition M1 of `f-mill-rules.md`).",
          "- How a lift by platform 5 rather than 6 puts one wheel rather than the other into gear: the rule is a "
          "correlation between labels and marks, not a mechanism.", ""]
    return "\n".join(L)


if __name__ == "__main__":
    cases = test()
    sc = score(cases)
    rows = link()
    args = sys.argv[1:]
    if "--md" in args:
        Path(args[args.index("--md") + 1]).write_text(report(cases, sc, rows))
    if "--json" in args:
        Path(args[args.index("--json") + 1]).write_text(json.dumps({"test": cases, "score": sc, "link": rows},
                                                                    ensure_ascii=False, indent=1) + "\n")
    for k, v in sc.items():
        print(k, v)
    for r in rows:
        print(r["band"], r["E"], r["upon_B"], r["recorded_B"], r["match"])
