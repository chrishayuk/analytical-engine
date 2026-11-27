"""Between each "B n" and the "U n" that follows it in the same column, which
motions of that columnx27s part does the time chart record? (A return is an
arrow with a double head.) Reads the transcriptions only; gives no mark a
meaning. Run: python3 scripts/bu_bracket.py"""

import sys
sys.path.insert(0, "scripts")
import bu_audit as A
from collections import Counter
for title in ["F013", "F018-019"]:
    files = A.SHEETS[title]
    labels, arrows, _ = A.read(files)
    restate = ("F019-cycle4.txt",) if title == "F018-019" else ()
    labels = [e for e in labels if not (e[5] in restate and e[4].startswith("top-"))]
    # every motion mark as an event in sheet order
    events = []
    for (name, row, c), marks in arrows.items():
        if name in restate and row.startswith("top-"):
            continue
        for m in marks:
            kind = "return" if "double head" in m else "motion"
            events.append(((files.index(name),) + A.row_order(row) + (9,), c, kind))
    for order, col, kind, fig, row, name, comp in labels:
        events.append((order, col, "B" if kind == "B" else ("U" if kind == "U" else "UB"), fig, comp))
    events.sort(key=lambda e: e[0])
    stats, examples = Counter(), []
    open_b = {}
    for e in events:
        col = e[1]
        if e[2] == "B":
            open_b[(col, e[3])] = []
        elif e[2] in ("motion", "return"):
            for (c, f), seq in open_b.items():
                if c == col:
                    seq.append(e[2])
        elif e[2] == "U" and (col, e[3]) in open_b:
            seq = open_b.pop((col, e[3]))
            key = "B..U contains a return" if "return" in seq else ("B..U: motion, no return" if seq else "B..U: no motion between")
            stats[key] += 1
            if "return" not in seq:
                examples.append((col, e[3], seq))
    print(title, dict(stats), examples[:6])
