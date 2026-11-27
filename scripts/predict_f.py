"""Predictions for held-out test 2, VERSION 2: an implementation revision.

Version 1 (scripts/predict_f_v1.py, output docs/predictions/held-out-2-
predictions.md, frozen at 64ca93e) is kept unchanged and is scored too. This
version changes the implementation only, not the rules
(docs/predictions/held-out-2-rules.md, dc3bf1d) or the protocol
(held-out-2-protocol.md, 1833752). It was written before any part arrow of
these sheets had been seen by anyone preparing the predictions. Changes:

  1. coverage: a label cell that yields no token fails the run, as does an
     unparsed token;
  2. a bare "B" (no figure) attaches the part to an unknown platform: it ends
     any earlier attachment and predicts no motion (no figure, no lift);
  3. a bare "U" detaches (as in v1), and R3 applies to it (no motion), which
     is what the protocol says; v1's prose said bare U had no prediction;
  4. conflicts (a B while already attached, with no U between) are written in
     the coverage report;
  5. persistence (M1) applies to an attached part with no B and no U of its
     own in that band, whatever else its cell holds (v1 required no label at
     all);
  6. every negative prediction is enumerated: for each labelled column and
     band, the state (attached k, attached ?, detached, unknown) and what R4
     as written, R4u, M0 and M1 predict;
  7. F/033's mid-band labels ("U-mid", "L-mid", at about row 11) are a
     separate category: they predict a motion in the row after the label, not
     in the band's first motion row, and are scored apart.

Output: docs/predictions/held-out-2-predictions-v2.md.

  python3 scripts/predict_f.py
"""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
INPUTS = ROOT / "sources/notes/F021-F033-inputs.md"
OUT = ROOT / "docs/predictions/held-out-2-predictions-v2.md"

LIFT = {1: 1.1, 2: .6, 3: 1.1, 4: .6, 5: .4, 6: .2, 7: -.2, 8: -.4, 9: -.6, 10: -1.1, 11: -.6, 12: -1.1}
LONG = {1, 2, 11, 12}
DESIGN = {"F/021": "division without table", "F/022": "division without table", "F/023": "division without table",
          "F/024": "division without table", "F/026": "square root", "F/027": "square root",
          "F/028": "square root", "F/029": "square root", "F/032": "ordinary cycle", "F/033": "carriage"}


def tables(text):
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
        if t in ("B&U", "U&B"):
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
    report, rows_out, bad = [], [], 0
    for sheet, rows in tables(INPUTS.read_text()):
        state = {}                 # col -> int k | "?" (attached, platform unknown) | "detached"
        cols = []
        for _, c, _ in rows:
            if c not in cols and not c.lower().startswith("lock"):
                cols.append(c)
        order = []
        for b, _, _ in rows:
            if b not in order:
                order.append(b)
        report.append(f"\n### {sheet} ({DESIGN.get(sheet, '?')})\n")
        report.append("| Band | Column | Cell | Tokens | Notes |\n|---|---|---|---|---|")
        for band in order:
            mid = "mid" in band
            cells = {c: cell for b, c, cell in rows if b == band}
            fresh, touched = {}, set()
            for col, cell in cells.items():
                toks, notes = tokens(cell)
                lock = col.lower().startswith("lock")
                if not toks:
                    bad += 1
                    notes.append("FAILS: no token")
                if any(k == "?" for k, _ in toks):
                    bad += 1
                    notes.append("FAILS: unparsed")
                if not lock:
                    for kind, fig in toks:
                        if kind == "U":
                            state[col] = "detached"
                            fresh.pop(col, None)
                            touched.add(col)
                        elif kind == "B":
                            if isinstance(state.get(col), int) or state.get(col) == "?":
                                notes.append("conflict: B while attached, no U between")
                            state[col] = fig if fig is not None else "?"
                            touched.add(col)
                            if fig is not None:
                                fresh[col] = (fig, list(notes))
                            else:
                                fresh.pop(col, None)
                        elif kind == "L" and fig is not None:
                            rows_out.append((sheet, band, col, "E1 L as B (exploratory)", fig, "", ""))
                else:
                    notes.append("Lock column: set aside")
                shown = " ".join(f"{k}{'' if f is None else f}" for k, f in toks)
                report.append(f"| {band} | {col} | {cell} | {shown} | {'; '.join(notes)} |")
            if mid:
                for col, (k, notes) in fresh.items():
                    rows_out.append((sheet, band, col, "MID-BAND B: motion in the row after the label", k, "attached", "; ".join(notes)))
                continue
            for col in cols:
                st = state.get(col)
                sname = ("unknown" if st is None else "detached" if st == "detached"
                         else "attached ?" if st == "?" else f"attached {st}")
                if col in fresh:
                    k, notes = fresh[col]
                    rows_out.append((sheet, band, col, "FRESH B: R1, M0, M1 motion", k, sname, "; ".join(notes)))
                elif col in touched:
                    kinds = cells.get(col, "")
                    if st == "detached":
                        rows_out.append((sheet, band, col, "U this band: R3/R4/R4u/M0/M1 no motion", None, sname, ""))
                    else:
                        rows_out.append((sheet, band, col, "bare B this band: no motion predicted (no figure)", None, sname, ""))
                elif isinstance(st, int):
                    rows_out.append((sheet, band, col, "PERSISTENT: M1 motion; M0, R4 and R4u no motion", st, sname, ""))
                elif st == "?":
                    rows_out.append((sheet, band, col, "attached to unknown platform: M1 motion of unknown lift (direction/lift untestable); M0/R4 no motion", None, sname, ""))
                elif st == "detached":
                    rows_out.append((sheet, band, col, "detached, no label: R4/R4u/M0/M1 no motion", None, sname, ""))
                else:
                    rows_out.append((sheet, band, col, "unknown, no label: R4/M0 no motion; R4u and M1 abstain", None, sname, ""))
    lines = [
        "# Held-out test 2: predictions, VERSION 2 (implementation revision)\n",
        "Generated by `scripts/predict_f.py` (v2). Version 1 (`held-out-2-predictions.md`,",
        "64ca93e, from `scripts/predict_f_v1.py`) is kept unchanged and is scored too;",
        "every case where the two disagree is reported. The rules (dc3bf1d) and the",
        "protocol (1833752) are unchanged. Written before any part arrow of these sheets",
        "had been seen by anyone preparing predictions. What v2 changes is listed in the",
        "script's docstring. Lifts are F/013's (fallback). R2/M2 untestable as frozen.\n",
        "**Columns not in this table** (never labelled on their sheet) are in the unknown",
        "state throughout: R4 as written and M0 predict no motion; R4u and M1 abstain.\n",
        "| Sheet | Design | Band | Column | Prediction | k | Direction | Lift | State before | Notes |",
        "|---|---|---|---|---|---|---|---|---|---|"]
    counts = {}
    for sheet, band, col, kind, k, sname, note in rows_out:
        d = l = "—"
        if isinstance(k, int):
            d = "up" if LIFT[k] > 0 else "down"
            l = f"{abs(LIFT[k]):g}"
        key = kind.split(":")[0]
        counts[key] = counts.get(key, 0) + 1
        lines.append(f"| {sheet} | {DESIGN.get(sheet, '?')} | {band} | {col} | {kind} | {k if isinstance(k, int) else '—'} | {d} | {l} | {sname} | {note} |")
    lines.append("\n**Counts:** " + "; ".join(f"{k}: {v}" for k, v in counts.items()))
    lines.append("\n## Coverage report\n\nA cell with no token or an unparsed token fails the run.")
    lines.extend(report)
    OUT.write_text("\n".join(lines) + "\n")
    print(f"{len(rows_out)} rows; {counts}; failing cells: {bad}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
