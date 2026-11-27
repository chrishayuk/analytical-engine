"""Predictions for held-out test 2, from the inputs only.

Rules: docs/predictions/held-out-2-rules.md (dc3bf1d) and
docs/predictions/held-out-2-protocol.md (1833752). Inputs:
sources/notes/F021-F033-inputs.md (labels, heads and platform motions; no part
arrows). Output: docs/predictions/held-out-2-predictions.md, with a coverage
report; the script exits non-zero if any label cell yields nothing it can
classify.

  python3 scripts/predict_f.py
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INPUTS = ROOT / "sources/notes/F021-F033-inputs.md"
OUT = ROOT / "docs/predictions/held-out-2-predictions.md"

# None of these sheets writes platform lifts, so every lift is F/013's
# (the protocol's fallback), reported as such.
LIFT = {1: 1.1, 2: .6, 3: 1.1, 4: .6, 5: .4, 6: .2, 7: -.2, 8: -.4, 9: -.6, 10: -1.1, 11: -.6, 12: -1.1}
LONG = {1, 2, 11, 12}          # F/013's "Long time" platforms (exploratory E2 only)

DESIGN = {"F/021": "division without table", "F/022": "division without table", "F/023": "division without table",
          "F/024": "division without table", "F/026": "square root", "F/027": "square root",
          "F/028": "square root", "F/029": "square root", "F/032": "ordinary cycle", "F/033": "carriage"}


def tables(text):
    """(sheet, [(band, column, cell)]) for every label table, in order."""
    out, sheet = [], None
    lines = text.splitlines()
    for i, ln in enumerate(lines):
        m = re.match(r"#+ .*?(F/0\d\d)", ln)
        if m:
            sheet = m.group(1)
        if ln.startswith("| Band | Column | Label as written |"):
            rows = []
            for r in lines[i + 2:]:
                if not r.startswith("|"):
                    break
                cells = [c.strip() for c in r.strip("|").split("|")]
                if len(cells) >= 3:
                    rows.append((cells[0], cells[1], cells[2]))
            out.append((sheet, rows))
    return out


def tokens(cell):
    """The labels in a cell, in order (top first for stacked labels)."""
    toks, notes = [], []
    for q in re.findall(r'"([^"]*)"', cell):
        if "~~" in q:
            notes.append("struck figure")
        q = re.sub(r"~~[^~]*~~", "", q)
        if "[?" in q:
            notes.append("uncertain figure")
        q = q.replace("[?", "").replace("]", "")
        q = re.sub(r"N\.[ºo]\s*", "", q)
        t = q.strip().rstrip(".")
        if re.fullmatch(r"(?:B&U|U&B)", t):
            toks.append(("UB", None))
            continue
        found = re.findall(r"([BUL])\s*\.?\s*(\d+)?", t)
        if not found or re.sub(r"[BUL]\s*\.?\s*(\d+)?", "", t).strip():
            toks.append(("?", q))
            continue
        for kind, fig in found:
            toks.append((kind, int(fig) if fig else None))
    return toks, notes


def main():
    text = INPUTS.read_text()
    report, preds, bad = [], [], 0
    for sheet, rows in tables(text):
        state = {}              # column -> platform k (attached), "detached", or absent (unknown)
        order = []
        for band, col, cell in rows:
            if band not in order:
                order.append(band)
        bands = {b: [r for r in rows if r[0] == b] for b in order}
        report.append(f"\n### {sheet} ({DESIGN.get(sheet, '?')})\n")
        report.append("| Band | Column | Cell | Tokens | Notes |\n|---|---|---|---|---|")
        for band in order:
            fresh = {}
            lone_u = set()
            for _, col, cell in bands[band]:
                toks, notes = tokens(cell)
                lock_col = col.lower().startswith("lock")
                shown = " ".join(f"{k}{'' if f is None else f}" for k, f in toks)
                if any(k == "?" for k, _ in toks):
                    bad += 1
                    notes.append("UNPARSED")
                if lock_col:
                    notes.append("Lock column: set aside (U/L of the locks)")
                report.append(f"| {band} | {col} | {cell} | {shown} | {'; '.join(notes)} |")
                if lock_col:
                    continue
                for kind, fig in toks:
                    if kind == "U":
                        state[col] = "detached"
                        fresh.pop(col, None)
                    elif kind == "B" and fig is not None:
                        if isinstance(state.get(col), int):
                            notes.append("conflict: second B with no U")
                        state[col] = fig
                        fresh[col] = (fig, notes[:])
                    elif kind == "L" and fig is not None:
                        preds.append((sheet, band, col, "E1 (L as B)", fig))
                if toks and all(k == "U" for k, _ in toks):
                    lone_u.add(col)
            for col, (k, notes) in fresh.items():
                preds.append((sheet, band, col, "R1/M0/M1 fresh B", k, "; ".join(notes)))
            for col in lone_u:
                preds.append((sheet, band, col, "R3 lone U: no motion", None, ""))
            # Persistence: attached, no fresh label in this band.
            labelled = {c for _, c, _ in bands[band]}
            for col, k in state.items():
                if isinstance(k, int) and col not in labelled:
                    preds.append((sheet, band, col, "M1 persistent, no fresh B", k, ""))
    lines = ["# Held-out test 2: the predictions, frozen before the part arrows are read\n",
             "Generated by `scripts/predict_f.py` from `sources/notes/F021-F033-inputs.md`, under",
             "`held-out-2-rules.md` (dc3bf1d) and `held-out-2-protocol.md` (1833752). Committed",
             "before any part arrow of these sheets is transcribed. Every lift is F/013's",
             "table (none of these sheets writes platform lifts): the protocol's fallback.\n",
             "## Standing predictions\n",
             "- **R1 / M0 / M1, fresh B.** Each row below marked \"fresh B\": the part moves in the",
             "  band's first motion row, in the direction of F/013's lift for k, by that lift.",
             "- **M1, persistent.** Each row marked \"persistent\": the part has no label in the band",
             "  but is attached to k from an earlier B with no U since; M1 predicts the motion of",
             "  k, M0 predicts no motion. These are the cases that separate the models.",
             "- **R3.** Each row marked \"lone U\": no motion in the first motion row.",
             "- **R4 as written.** Every column of the sheet with no fresh B in a band and not",
             "  attached (unknown or detached): no motion. **R4u**: the same, but a column in the",
             "  unknown state (no B or U so far on its sheet) makes no prediction.",
             "- **R2 / M2.** Untestable on every sheet: F/021–024, F/028–029 and F/033 have no",
             "  platform columns, and F/026, F/027 and F/032 do not number theirs.",
             "- Bare \"B\"/\"U\" (no figure), \"B&U\"/\"U&B\" and the Lock columns' U/L: no prediction.\n",
             "## Exploratory, scored apart from the rules\n",
             "- **E1, \"L k\" read as \"B k\".** F/032 writes \"L 4\", \"L N.º 3\", \"L 3\" where B",
             "  labels stand on the other sheets (Vol II p 42, Dec 1835: \"Lock … to Pl. 4\"). E1",
             "  predicts the motion of platform k for those parts. Not a rule; reported separately.",
             "- **E2, F/032's timing by F/013's grouping.** A part on platform k returns in the row",
             "  of F/032's \"Long time\" platforms (row 15, into the 1/3 row) if k is 1, 2, 11 or 12,",
             "  and of its \"Short time\" platforms (row 12) if k is 3–10; in bands 1–2 only",
             "  (band 3 has no platform return). Not a rule; reported separately.\n",
             "## The predictions\n",
             "| Sheet | Design | Band | Column | Prediction | k | Direction | Lift | E2 return | Notes |",
             "|---|---|---|---|---|---|---|---|---|---|"]
    for p in preds:
        sheet, band, col, kind, k = p[:5]
        note = p[5] if len(p) > 5 else ""
        if k is None:
            d = l = e2 = "—"
        else:
            d = "up" if LIFT[k] > 0 else "down"
            l = f"{abs(LIFT[k]):g}"
            e2 = ("row 15 / 1/3" if k in LONG else "row 12") if sheet == "F/032" and band in ("1", "2") else "—"
        lines.append(f"| {sheet} | {DESIGN.get(sheet, '?')} | {band} | {col} | {kind} | {k if k else '—'} | {d} | {l} | {e2} | {note} |")
    counts = {}
    for p in preds:
        counts[p[3]] = counts.get(p[3], 0) + 1
    lines.append("\n**Counts:** " + "; ".join(f"{k}: {v}" for k, v in counts.items()))
    lines.append("\n## Coverage report\n")
    lines.append("Every label cell read from the inputs, and the tokens taken from it. Any cell")
    lines.append("marked UNPARSED fails the run.")
    lines.extend(report)
    OUT.write_text("\n".join(lines) + "\n")
    print(f"{len(preds)} predictions; counts {counts}; unparsed cells: {bad}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
