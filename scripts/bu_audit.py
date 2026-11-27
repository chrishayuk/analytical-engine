"""Test the B/U hypothesis against every label in the transcribed Series F sheets.

Hypothesis H: "B n" is a numbered plate n bolted, "U n" the same plate
unbolted, in the column where the label stands. The script reads only the
transcriptions in mechanical/*.txt (no person has checked them) and gives no
mark a meaning beyond these predictions:

  P1  every "U n" follows a "B n" of the same figure in the same column,
      with no other U of that figure between;
  P2  no column has a "B n" while n is already bolted there;
  P3  in the time charts, every "B n" stands over an arrow in the next row of
      its column, and a U standing alone does not (a compound "U5 B6" stands
      over its B's arrow, so it is reported apart);
  P4  if the figure names one physical plate, no figure is bolted in two
      columns at once.

Every occurrence is accounted for: parsed as B/U, set aside as another use of
the letter (the "U" and "L" of the Lock columns), or not parsed. Each test
reports how many occurrences it could test and how many it could not.

  python3 scripts/bu_audit.py
"""

import copy
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "mechanical"

SHEETS = {
    "F013": ["F013-cycle1.txt", "F013-cycle2.txt", "F013-cycle3.txt", "F013-cycle4.txt", "F013-cycle5.txt"],
    "F014": ["F014-plates.txt"],
    "F018-019": ["F018-cycle1.txt", "F018-cycle2.txt", "F018-cycle3.txt",
                 "F019-cycle4.txt", "F019-cycle5.txt", "F019-cycle6.txt"],
    "F020": ["F020-plates.txt"],
}

TEXT = re.compile(r'(?:words|label) "([^"]*)"')
# One label: B or U, optionally "N.o", then a figure or a prime; or U&B.
TOKEN = re.compile(r"U&B|([BU])\s*(?:N\.o\s*)?(′|\d+)?")


def parse_label(text):
    """The B/U tokens of a label, or None if the text is not only B/U labels."""
    t = text.strip().rstrip(".")
    if not re.fullmatch(r"(?:\s*(?:U&B|[BU]\s*(?:N\.o\s*)?(?:′|\d+)?)\s*)+", t):
        return None
    out = []
    for m in TOKEN.finditer(t):
        if m.group(0) == "U&B":
            out.append(("U&B", ""))
        elif m.group(1):
            out.append((m.group(1), m.group(2) or ""))
    return out


def column_id(col):
    m = re.match(r"([a-z]\d+)", col.strip())
    return m.group(1) if m else col.strip()


# The order of rows within a band, as each sheet numbers them.
def row_order(row):
    r = row.strip()
    if r.startswith("top-"):
        return (0, int(r[4:]))
    m = re.match(r"b(\d+)\.l(\d+)", r)
    if m:
        return (1, int(m.group(1)) * 100 + int(m.group(2)))
    if r == "2/3":                       # F/013: opens every band
        return (2, 0)
    if r == "1/3":                       # F/013: closes every band
        return (2, 99)
    m = re.match(r"~?(\d+)", r)
    return (2, int(m.group(1))) if m else (3, 0)


def after(row, k):
    """The k-th row after `row`, or None."""
    r = row
    for _ in range(k):
        r = next_row(r) if r else None
    return r


def next_row(row):
    """The row after `row` in the same band, or None if the sheet gives none."""
    r = row.strip()
    if r == "2/3":
        return "1"
    if r.startswith("top-") and r[4:].isdigit():
        return f"top-{int(r[4:]) + 1}"
    if r.isdigit():
        return str(int(r) + 1)
    return None


def read(files):
    """Labels in sheet order, arrows by (file, row, column), and every B/U-like text."""
    labels, arrows, seen = [], {}, []
    for band, name in enumerate(files):
        rows = []
        for ln in (ROOT / name).read_text().splitlines():
            if ln.startswith("%") or ln.startswith("rows") or "|" not in ln:
                continue
            parts = [p.strip() for p in ln.split("|")]
            if len(parts) < 3 or parts[1].startswith("across"):
                continue
            row, col, mark = parts[0], parts[1], parts[2]
            c = column_id(col)
            if "arrow" in mark or "stepped shaft" in mark:
                start = row.split("-")[0] if re.match(r"\d+-\d", row) else row
                arrows.setdefault((name, start, c), []).append(mark + (" | " + parts[3] if len(parts) > 3 else ""))
            m = TEXT.match(mark)
            if not m:
                continue
            text = m.group(1)
            if not re.search(r"(?<![A-Za-z])[BU](?![a-z])", text):
                continue
            toks = parse_label(text)
            lock = "Lock" in col
            seen.append((name, row, c, col, text, toks, lock))
            if toks is None or lock:
                continue
            for k, (kind, fig) in enumerate(toks):
                rows.append((row_order(row), k, c, kind, fig, row, name, len(toks) > 1))
        rows.sort(key=lambda r: (r[0], r[1]))
        for r in rows:
            labels.append(((band,) + r[0] + (r[1],),) + r[2:])
    labels.sort(key=lambda e: e[0])
    return labels, arrows, seen


def coverage(files):
    _, _, seen = read(files)
    parsed = sum(1 for s in seen if s[5] is not None and not s[6])
    lock = [s for s in seen if s[6]]
    unparsed = [s for s in seen if s[5] is None and not s[6]]
    print(f"  texts with a standalone B or U: {len(seen)}; parsed as B/U labels: {parsed};"
          f" in Lock columns (set aside): {len(lock)}; not parsed: {len(unparsed)}")
    for s in unparsed:
        print(f"      not parsed: {s[0]} row {s[1]} {s[2]} \"{s[4]}\"")
    if lock:
        kinds = Counter(s[4] for s in lock)
        print(f"      Lock columns: {dict(kinds)}")


def audit(title, files, restate_top=()):
    labels, arrows, _ = read(files)
    labels = [e for e in labels if not (e[5] in restate_top and e[4].startswith("top-"))]
    print(f"\n== {title}: {len(labels)} B/U tokens" + (f" (top rows of {', '.join(restate_top)} read as a restatement)" if restate_top else ""))
    bolted, where = defaultdict(set), defaultdict(set)
    fails = defaultdict(list)
    p3 = Counter()
    for _, col, kind, fig, row, name, compound in labels:
        at = f"{name} row {row} {col}"
        nr = next_row(row)
        below = arrows.get((name, nr, col), []) if nr else None
        # A motion that begins one row later (F/013's stepped shafts in the
        # Cir columns begin in row 2, after the label's 2/3 and row 1).
        later = arrows.get((name, after(row, 2), col), []) if after(row, 2) else []
        if kind in ("B", "U&B"):
            if kind == "B" and fig in bolted[col]:
                fails["P2"].append(f"B{fig} at {at}")
            if kind == "B" and fig.isdigit() and where[fig] - {col}:
                fails["P4"].append(f"B{fig} at {at} while bolted in {sorted(where[fig] - {col})}")
        if kind == "B":
            bolted[col].add(fig)
            where[fig].add(col)
            if not any(arrows.get((name, r, col)) for r in (nr,) if r) and nr is None:
                p3["B: next row not given by the sheet (untestable)"] += 1
            elif not arrows and nr:
                p3["B: no arrows on this sheet (untestable)"] += 1
            elif below:
                up = any(a.startswith("up") for a in below)
                p3["B over an up arrow" if up else "B over a down arrow"] += 1
                if not up:
                    fails["P3 (B over a down arrow, not up)"].append(f"B{fig} at {at}: {below}")
            elif later:
                p3["B over a motion one row later (" + later[0].split(",")[0] + ")"] += 1
                fails["P3 (B over a motion one row later)"].append(f"B{fig} at {at}: {later}")
            else:
                p3["B over no motion"] += 1
                fails["P3 (B over no motion)"].append(f"B{fig} at {at}")
        elif kind == "U":
            if fig not in bolted[col]:
                fails["P1"].append(f"U{fig} at {at}")
            bolted[col].discard(fig)
            where[fig].discard(col)
            if nr is None:
                p3["U: next row not given (untestable)"] += 1
            elif not arrows:
                p3["U: no arrows on this sheet (untestable)"] += 1
            elif compound:
                p3["U in a compound label (its B's arrow; not a test)"] += 1
            elif below or later:
                p3["U alone over a motion"] += 1
                fails["P3 (U alone over a motion)"].append(f"U{fig} at {at}: {below or later}")
            else:
                p3["U alone over no motion"] += 1
        else:  # U&B
            p3["U&B: not tested"] += 1
    print("  P3 counts: " + "; ".join(f"{k} {v}" for k, v in sorted(p3.items())))
    for k in ["P1", "P2", "P3 (B over no motion)", "P3 (B over a down arrow, not up)",
              "P3 (B over a motion one row later)", "P3 (U alone over a motion)", "P4"]:
        f = fails.get(k, [])
        print(f"  {k}: {len(f)}")
        for x in f[:8]:
            print(f"      {x}")
        if len(f) > 8:
            print(f"      … {len(f) - 8} more")
    left = [f"{c}: B{f}" for c, fs in sorted(bolted.items()) for f in sorted(fs)]
    print(f"  bolted at the end, never followed by a U: {len(left)}: {', '.join(left)}")


def restatement(prev_file, next_file):
    """Compare the last row 15 of one band with the top row 15 of the next sheet."""
    _, _, s1 = read([prev_file])
    _, _, s2 = read([next_file])
    a = {(c, t) for (_, r, c, _, t, _, _) in s1 if r == "15"}
    b = {(c, t) for (_, r, c, _, t, _, _) in s2 if r == "top-15"}
    heads1 = {c: h for (_, r, c, h, _, _, _) in s1 if r == "15"}
    heads2 = {c: h for (_, r, c, h, _, _, _) in s2 if r == "top-15"}
    print(f"\n== {next_file} top row 15 against {prev_file} row 15")
    print(f"  in both: {len(a & b)}; only in {prev_file}: {sorted(a - b)}; only in {next_file}: {sorted(b - a)}")
    for c in sorted(set(heads1) & set(heads2)):
        if heads1[c].split()[1:] != heads2[c].split()[1:]:
            print(f"  column {c} headed {heads1[c]!r} on {prev_file}, {heads2[c]!r} on {next_file}")


if __name__ == "__main__":
    print("Coverage")
    for title, files in SHEETS.items():
        print(f" {title}")
        coverage(files)
    print("\nI. Every label as an event, in sheet order.")
    for title, files in SHEETS.items():
        audit(title, files)
    restatement("F018-cycle3.txt", "F019-cycle4.txt")
    print("\nII. Reading F/019's top row as a restatement of the foot of F/018 (a reading;")
    print("the two rows differ as shown above).")
    audit("F018-019", SHEETS["F018-019"], restate_top=("F019-cycle4.txt",))
