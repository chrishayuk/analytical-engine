"""The test of docs/predictions/platform-timing.md (written before this script),
excursions compared only with those that begin in the same row of the same band:
on F/018-019, does a part bolted to a long-time platform (B 1, B 2) return later
than one bolted to a short-time platform (B 3 - B 6) in the same cycle? A
return is the first double-headed arrow in the part's column after its B.
Reads the transcriptions only. Run: python3 scripts/bu_timing.py"""

import sys
from collections import defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import bu_audit as A

files = A.SHEETS["F018-019"]
restate = ("F019-cycle4.txt",)
labels, arrows, _ = A.read(files)
labels = [e for e in labels if not (e[5] in restate and e[4].startswith("top-"))]

returns = defaultdict(list)  # column -> [(order, file, row)]
for (name, row, c), marks in arrows.items():
    if name in restate and row.startswith("top-"):
        continue
    if any("double head" in m for m in marks):
        returns[c].append(((files.index(name),) + A.row_order(row), name, row))
for c in returns:
    returns[c].sort()

by_cycle = defaultdict(list)
for order, col, kind, fig, row, name, comp in labels:
    if kind != "B" or not fig.isdigit() or int(fig) > 6:
        continue
    pos = (files.index(name),) + A.row_order(row)
    later = [r for r in returns.get(col, []) if r[0] > pos]
    ret = later[0] if later else None
    group = "long" if int(fig) <= 2 else "short"
    # An excursion begins with the motion in the row after its B; compare
    # only excursions that begin in the same row of the same band.
    by_cycle[f"{name} motion row {A.next_row(row)}"].append((group, fig, col, row, ret))

against = tested = 0
for name in sorted(by_cycle, key=lambda k: (files.index(k.split()[0]), k)):
    items = by_cycle[name]
    longs = [i for i in items if i[0] == "long" and i[4]]
    shorts = [i for i in items if i[0] == "short" and i[4]]
    def show(i):
        return f"B{i[1]} {i[2]} (B row {i[3]}) returns {i[4][1]} row {i[4][2]}" if i[4] else f"B{i[1]} {i[2]}: no return found"
    print(f"== excursions beginning in {name}: {len(longs)} long-time, {len(shorts)} short-time parts with a return")
    for i in items:
        print("   ", i[0], show(i))
    if not longs or not shorts:
        print("    untestable: no long-time or no short-time part")
        continue
    tested += 1
    bad = [(l, s) for l in longs for s in shorts if not l[4][0] > s[4][0]]
    if bad:
        against += 1
        print(f"    AGAINST the prediction: {len(bad)} pair(s), e.g. {show(bad[0][0])} vs {show(bad[0][1])}")
    else:
        print("    as predicted: every long-time return is later than every short-time return")
print(f"\ngroups of excursions tested: {tested}; against the prediction: {against}")
