# Two executable models of the platform hypothesis, kept apart

Both are hypotheses (`f-bu-audit.md`, hypothesis P), not reconstructions.
Neither models arithmetic: nothing in them says what a motion does to a
number.

| | `scripts/platform_model.py` | `scripts/mech_sim.py` |
|---|---|---|
| What it is | A predictor, scored against the charts | A stateful simulator of mechanical transitions |
| Input | B/U labels and F/013's platform table | A sequence of transitions |
| B | predicts the displacement of the part in the next row | changes attachment state (`attach`) |
| U | pairs with a B (`bu_bracket.py`) | changes attachment state (`detach`) |
| Platform motion | not modelled | propagates to every attached axis |
| Return | checked separately against the double-headed arrows | follows from the platform's return to its neutral point |
| Retention | none | a locking plate holds an axis at a fixed point (`hold`, `release`) |
| Lift per axis | one per platform, from F/013's heads | a per-run ratio per axis (default 1): F/013's table is one configuration, and Vol XIII (6 Oct 1835) has "one platform move axes to various [?heights]" |

## The simulator's rules

Entities: axes (height, platform attached to, held or not), travelling
platforms (height; 0 is the neutral point), and locking plates (an axis's
`held` state). Each transition cites its source in the program:

| Transition | Source |
|---|---|
| attach an axis to a platform | Vol XIII image 89 (5 Mar 1835), "locking axes to travelling platforms"; image 90, barrels "bolted the necessary axes to travelling platforms" |
| raise a platform | Vol XIII image 90; Vol II p 17 (1 Dec 1835), "Raise travelling platforms" |
| detach | Vol XIII image 89, "unlock an axis after raising it" |
| hold at a fixed point (locking plate) | Vol XIII image 89, "leave it locked to a fixed point for a certain time" |
| release | Vol XIII image 89, "then to unlock it" |
| reattach | Vol XIII image 89, "relock it to a travelling platform" |
| platform to its neutral point | Vol II p 17, "Travelling platforms to neutral point" |

What no source settles is refused, not filled in:
- an axis neither attached nor held has no defined motion; the simulator
  marks it unconstrained and refuses any later step that depends on its
  height;
- an axis held at a fixed point while attached to a platform that moves is a
  conflict, and the run stops.

## The March 1835 sequence (`python3 scripts/mech_sim.py`)

Executed: attach X to P1; P1 rises; a locking plate holds X; X is detached;
P1 returns to neutral without it; P2 rises; X is attached to P2; the locking
plate releases X; P2 returns, and X with it. X ends at its starting height.

Choices in this run, not in the source:
- **The order.** Babbage's sentence reads "unlock an axis after raising it,
  then … leave it locked to a fixed point". Executed in that order the axis
  would be free for an instant with no defined height, which the simulator
  refuses (shown by `detach_first`). The run holds before it detaches, and
  attaches before it releases. The prose order may not be the mechanical
  order; the sources do not settle it.
- **P2 rising to meet X**, and every height, are illustrative. The source
  says "relock it to a travelling platform", not which or where.

## Not yet done

- Driving the simulator from a time chart (B → attach, U → detach, platform
  motion from a schedule) and comparing the heights it gives each column with
  the chart's arrows. The platform schedule would have to come from a source
  other than the arrows being predicted.
- Locking plates on the January 1836 charts: F/013's Lock columns (U and L)
  may be the locking plates; untested.
