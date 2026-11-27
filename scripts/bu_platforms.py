"""The platform reading (sources/notes/bolting-plates-sources.md): "B k" is a
part bolted to travelling platform k, which several parts can share. Test:
does each figure k carry one motion (direction and lift) wherever it stands,
and do parts bolted to the same k in the same row move alike? Reads the
transcriptions only. Run: python3 scripts/bu_platforms.py"""

import sys, re
sys.path.insert(0, "scripts")
import bu_audit as A
from collections import defaultdict
from pathlib import Path
for title in ["F013", "F018-019"]:
    files = A.SHEETS[title]
    labels, arrows, _ = A.read(files)
    # the figure written with a motion: "number" marks at (file,row,col)
    nums = {}
    for name in files:
        for ln in (A.ROOT / name).read_text().splitlines():
            if ln.startswith("%") or "|" not in ln: continue
            p = [x.strip() for x in ln.split("|")]
            if len(p) >= 3 and p[2].startswith("number"):
                m = re.search(r'"([^"]*)"', p[2])
                if m: nums[(name, p[0], A.column_id(p[1]))] = m.group(1)
    groups = defaultdict(list)
    for order, col, kind, fig, row, name, comp in labels:
        if kind != "B" or not fig.isdigit(): continue
        nr = A.next_row(row)
        if not nr: continue
        mv = arrows.get((name, nr, col))
        if not mv: continue
        d = "up" if any(a.startswith("up") for a in mv) else "down"
        groups[(name, nr, fig)].append((col, d, nums.get((name, nr, col), "-")))
    same = diff = 0
    lift = defaultdict(set)
    for (name, nr, fig), g in sorted(groups.items()):
        vals = {(d, v) for _, d, v in g}
        for _, d, v in g: lift[fig].add((d, v))
        if len(g) > 1:
            if len(vals) == 1: same += 1
            else:
                diff += 1; print("  differs:", name, nr, "B"+fig, g)
    print(title, "groups of 2+ parts bolted to the same figure moving in one row:", same + diff, "same motion and figure:", same, "different:", diff)
    print("  motion by figure:", {k: sorted(v) for k, v in sorted(lift.items(), key=lambda x: int(x[0]))})
