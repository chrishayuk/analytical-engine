"""A provisional platform model of Series F: A HYPOTHESIS, NOT A RECONSTRUCTION.

Hypothesis P (docs/f-bu-audit.md): "B k" bolts the part in that column to
travelling platform k; "U k" unbolts it; platform k moves by a fixed signed
lift and returns, carrying every part bolted to it.

The model takes, as its only inputs,
  - the B/U labels of a time chart (mechanical/*.txt), and
  - F/013's head table of platforms and lifts (sources/notes/F013.md §2),
and predicts, for each "B k", the motion of the part in the next row:
direction and lift. It also predicts that a return falls between the B and
its U. It then scores those predictions against the arrows the charts record.
The arrows are not an input. Nothing else (what the part is, what it does to
a number) is modelled: no arithmetic is inferred from the motions.

On F/013 the table comes from the same sheet's heads, so that score is a
consistency check. On F/018-019 the table comes from another sheet; the lifts
there were seen before the model was written, so that score is not blind.

  python3 scripts/platform_model.py
"""

import re
import sys
from collections import Counter
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import bu_audit as A

# F/013's heads over t31-t42 (sources/notes/F013.md §2): platform -> signed lift.
PLATFORMS = {1: +1.1, 2: +0.6, 3: +1.1, 4: +0.6, 5: +0.4, 6: +0.2,
             7: -0.2, 8: -0.4, 9: -0.6, 10: -1.1, 11: -0.6, 12: -1.1}


def figure_value(text):
    """A written figure (".4", "1.1", "[?.6]") as a number, and whether it is certain."""
    m = re.search(r"(\d*\.\d+|\d+)", text)
    if not m:
        return None, False
    return float(m.group(1)), "?" not in text


def score(title, restate=()):
    files = A.SHEETS[title]
    labels, arrows, _ = A.read(files)
    labels = [e for e in labels if not (e[5] in restate and e[4].startswith("top-"))]
    nums = {}
    for name in files:
        for ln in (A.ROOT / name).read_text().splitlines():
            if ln.startswith("%") or "|" not in ln:
                continue
            p = [x.strip() for x in ln.split("|")]
            if len(p) >= 3 and p[2].startswith("number"):
                m = re.search(r'"([^"]*)"', p[2])
                if m:
                    nums[(name, p[0], A.column_id(p[1]))] = m.group(1)
    tally, misses = Counter(), []
    for order, col, kind, fig, row, name, comp in labels:
        if kind != "B":
            continue
        if not fig.isdigit():
            tally["B with no figure: no prediction"] += 1
            continue
        k = int(fig)
        lift = PLATFORMS.get(k)
        nr = A.next_row(row)
        motion = arrows.get((name, nr, col)) if nr else None
        if not nr:
            tally["next row not given: untestable"] += 1
            continue
        if not motion:
            later = arrows.get((name, A.after(row, 2), col)) if A.after(row, 2) else None
            tally["no arrow in the next row (stepped shaft later)" if later else "no motion at all"] += 1
            if not later:
                misses.append(f"B{k} {name} row {row} {col}: no motion")
            continue
        up = any(a.startswith("up") for a in motion)
        dir_ok = (lift > 0) == up
        tally["direction right" if dir_ok else "direction WRONG"] += 1
        if not dir_ok:
            misses.append(f"B{k} {name} row {row} {col}: predicted {'up' if lift > 0 else 'down'}, chart {motion}")
        written = nums.get((name, nr, col))
        if written is None:
            tally["lift: no figure written (untestable)"] += 1
            continue
        val, sure = figure_value(written)
        if val is None:
            tally["lift: figure unreadable"] += 1
        elif abs(val - abs(lift)) < 1e-9:
            tally["lift right" + ("" if sure else " (uncertain reading)")] += 1
        else:
            tally["lift WRONG" + ("" if sure else " (uncertain reading)")] += 1
            misses.append(f"B{k} {name} row {row} {col}: predicted {abs(lift)}, chart \"{written}\"")
    print(f"== {title}" + (f" (top rows of {', '.join(restate)} as restatement)" if restate else ""))
    for k, v in sorted(tally.items()):
        print(f"   {k}: {v}")
    for m in misses:
        print(f"   miss: {m}")


if __name__ == "__main__":
    print(__doc__.split("\n\n")[0])
    score("F013")
    score("F018-019", restate=("F019-cycle4.txt",))
    print("\nReturns between B and U: scripts/bu_bracket.py; return timing: scripts/bu_timing.py.")
