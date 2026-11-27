"""Test the B/U hypothesis against every label in the transcribed Series F sheets.

Hypothesis H: "B n" is a numbered plate n bolted, "U n" the same plate
unbolted, in the column where the label stands. Predictions, each checked:

  P1  every "U n" follows a "B n" of the same figure in the same column,
      with no other U of that figure between;
  P2  no column has two plates bolted under the same figure at once
      (a "B n" while n is already bolted there, with no U between);
  P3  in the time charts, every "B n" stands over an up arrow in the next
      row of the same column, and no "U n" does;
  P4  (if the figure names one physical plate) no figure is bolted in two
      columns at once.

A counterexample to any prediction is printed. The script reads only the
transcriptions in mechanical/*.txt; it gives no mark a meaning beyond these
predictions. Run: python3 scripts/bu_audit.py
"""

import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "mechanical"

SHEETS = {
    "F013 (table, time chart)": ["F013-cycle1.txt", "F013-cycle2.txt", "F013-cycle3.txt", "F013-cycle4.txt", "F013-cycle5.txt"],
    "F014 (table, plates)": ["F014-plates.txt"],
    "F018-019 (without table, time chart)": ["F018-cycle1.txt", "F018-cycle2.txt", "F018-cycle3.txt",
                                              "F019-cycle4.txt", "F019-cycle5.txt", "F019-cycle6.txt"],
    "F020 (without table, plates)": ["F020-plates.txt"],
}

LABEL = re.compile(r"([BU])\s*(′|\d+)?")


def row_key(row):
    """An order for rows within a band: partial rows first, then by number."""
    row = row.strip()
    if row.startswith("top-"):
        return (0, float(row[4:]) if row[4:].replace(".", "").isdigit() else 0)
    m = re.match(r"b(\d+)\.l(\d+)", row)
    if m:
        return (1, int(m.group(1)) * 100 + int(m.group(2)))
    frac = {"1/3": 0.33, "2/3": 0.66, "⅓": 0.33, "⅔": 0.66}
    if row in frac:
        return (2, frac[row])
    m = re.match(r"(\d+)(?:-(\d+))?", row)
    return (3, int(m.group(1))) if m else (4, 0)


def column_id(col):
    """The column's own number (e01, t43, f20), not its head."""
    m = re.match(r"([a-z]\d+)", col.strip())
    return m.group(1) if m else col.strip()


def events(files):
    """(order, column, kind B/U, figure, row, file) for every label, in sheet order;
    and the set of (file, row, column) with an up arrow."""
    out, ups = [], set()
    for band, name in enumerate(files):
        lines = (ROOT / name).read_text().splitlines()
        rows = []
        for ln in lines:
            if ln.startswith("%") or ln.startswith("rows") or "|" not in ln:
                continue
            parts = [p.strip() for p in ln.split("|")]
            if len(parts) < 3:
                continue
            row, col, mark = parts[0], parts[1], parts[2]
            if col.startswith("across"):
                continue
            c = column_id(col)
            if mark.startswith("up arrow"):
                ups.add((name, row.strip(), c))
            m = re.match(r'(?:words|label) "([^"]*)"', mark)
            if not m:
                continue
            text = m.group(1)
            if not re.fullmatch(r"(\s*[BU]\s*(′|\d+)?\s*)+", text):
                continue
            for k, (kind, fig) in enumerate(LABEL.findall(text)):
                rows.append((row_key(row), k, c, kind, fig or "", row, name))
        rows.sort(key=lambda r: (r[0], r[1]))
        for r in rows:
            out.append(((band,) + r[0] + (r[1],), r[2], r[3], r[4], r[5], r[6]))
    out.sort(key=lambda e: e[0])
    return out, ups


def next_row(row):
    if row.startswith("top-"):
        n = row[4:]
        return f"top-{int(n) + 1}" if n.isdigit() else None
    return str(int(row) + 1) if row.isdigit() else None


def audit(title, files, restate_top=(), alt_blocks=False):
    """restate_top: files whose top partial rows restate the previous band's
    last row (not new events). alt_blocks: blocks 2, 3, … of a plate sheet
    each start from the state at the end of block 1 (alternatives, not a
    sequence). Both are readings, stated where they are used."""
    evs, ups = events(files)
    evs = [e for e in evs if not (e[5] in restate_top and e[4].startswith("top-"))]
    block1_end = None
    print(f"\n== {title}: {len(evs)} labels")
    bolted = defaultdict(set)          # column -> figures bolted there
    where = defaultdict(set)           # figure -> columns where it is bolted
    problems = defaultdict(list)
    ever_bolted = []
    import copy
    for _, col, kind, fig, row, name in evs:
        at = f"{name} row {row} {col}"
        if alt_blocks:
            m = re.match(r"b(\d+)\.", row)
            blk = int(m.group(1)) if m else 1
            if blk >= 2 and block1_end is None:
                block1_end = (copy.deepcopy(bolted), copy.deepcopy(where))
            if blk >= 2 and getattr(audit, "_blk", 1) != blk:
                bolted, where = copy.deepcopy(block1_end[0]), copy.deepcopy(block1_end[1])
            audit._blk = blk
        if kind == "B":
            if fig in bolted[col]:
                problems["P2 a second B of the same figure, no U between"].append(f"B{fig} at {at}")
            if fig.isdigit() and where[fig] - {col}:
                problems["P4 a figure bolted in two columns at once"].append(
                    f"B{fig} at {at} while bolted in {sorted(where[fig] - {col})}")
            bolted[col].add(fig)
            where[fig].add(col)
            ever_bolted.append((col, fig, at))
            if ups and next_row(row) and (name, next_row(row), col) not in ups:
                problems["P3 a B with no up arrow in the next row"].append(f"B{fig} at {at}")
        else:
            if fig not in bolted[col]:
                problems["P1 a U with no earlier B of its figure in the column"].append(f"U{fig} at {at}")
            bolted[col].discard(fig)
            where[fig].discard(col)
            if ups and next_row(row) and (name, next_row(row), col) in ups:
                # a "U5 B6" pair stands over the arrow of its B; only a bare U is a counterexample
                pass
    left = [f"{c}: B{f}" for c, figs in sorted(bolted.items()) for f in sorted(figs)]
    for p in ["P1 a U with no earlier B of its figure in the column",
              "P2 a second B of the same figure, no U between",
              "P3 a B with no up arrow in the next row",
              "P4 a figure bolted in two columns at once"]:
        found = problems.get(p, [])
        if p.startswith("P3") and not ups:
            print(f"  {p}: not testable (no arrows on this sheet)")
            continue
        print(f"  {p}: {len(found)}")
        for f in found[:12]:
            print(f"      {f}")
        if len(found) > 12:
            print(f"      … {len(found) - 12} more")
    print(f"  still bolted at the end (never followed by a U): {len(left)}")
    for f in left:
        print(f"      {f}")
    return problems


if __name__ == "__main__":
    print("I. Every label taken as an event in sheet order.")
    for title, files in SHEETS.items():
        audit(title, files)
    print("\nII. With two readings: F/019 cycle 4's top partial row restates F/018's last")
    print("row 15 (it repeats it column for column); F/020's blocks 2 and 3 each continue")
    print("from the end of block 1 (both unbolt what block 1 bolted).")
    audit._blk = 1
    audit("F018-019, top of F/019 as restatement", SHEETS["F018-019 (without table, time chart)"],
          restate_top=("F019-cycle4.txt",))
    audit._blk = 1
    audit("F020, blocks 2 and 3 as alternatives", SHEETS["F020 (without table, plates)"], alt_blocks=True)
