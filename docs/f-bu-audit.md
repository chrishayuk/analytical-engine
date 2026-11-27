# The B/U labels of Series F, tested against every occurrence

The labels "B3", "U5", "U5 B6", "B N.o 9" stand in Babbage's multiplication
sheets of January 1836: the time charts F/013 (by table) and F/018–019
(without table), and the schedules F/014 and F/020 ("Bolting plates for
multiplication by table", "… to multiply without table"). No sheet says what
B, U or the figure means. The working hypothesis (`f-concordance.md`, S41):

**H.** "B n" is a numbered plate n bolted, and "U n" the same plate unbolted,
in the column where the label stands.

Two scripts read every label in the transcriptions (`mechanical/*.txt`; no
person has checked them) and test what H predicts. They print every
counterexample and every occurrence they could not test. This page records
what they found, as observation, reading and hypothesis. **Nothing here gives
a mark a mechanical meaning.**

- `scripts/bu_audit.py`: coverage, and predictions P1–P4.
- `scripts/bu_bracket.py`: what each column's part does between a B and its U.
- `scripts/bu_platforms.py`: whether each figure carries one motion, as the
  platform reading predicts (below).

*Corrected 27 Nov 2026.* The first version of `bu_audit.py` never recorded a
U standing over an arrow, did not parse "B N.o 9", "U&B" or "U2.", and could
not find the row after F/013's "2/3", so F/013 was not tested at all on
arrows. This page was written from the first version and said otherwise; it
is rewritten from the corrected one.

## Coverage

| Sheet | Texts with a standalone B or U | Parsed as B/U labels | Set aside | Not parsed |
|---|---|---|---|---|
| F/013 | 56 | 38 | 18 "U" in the Lock columns (below) | 0 |
| F/014 | 65 | 65 | 0 | 0 |
| F/018–019 | 59 | 59 | 0 | 0 |
| F/020 | 95 | 95 | 0 | 0 |

**The Lock columns of F/013** (t28 Lock Cen.l, t29 Lock Fig wh, t30 Lock
Carr.e) carry a "U" with no figure in row 1 of every band, standing on an up
arrow transcribed "with letter U", and a down arrow "with letter L" in row 10
or 10–11. *Hypothesis, not adopted:* U and L are unlock and lock there. They
are another use of the letter, not tested as B/U.

## The predictions

- **P1.** Every "U n" follows a "B n" of the same figure in the same column,
  with no other U of that figure between.
- **P2.** No column has a "B n" while n is already bolted there.
- **P3.** On the time charts, every "B n" stands at the start of a motion of
  its column's part, and a U standing alone does not. (A compound label such
  as "U5 B6" stands over its B's motion, so its U is not a test.)
- **P4.** If the figure names one physical plate, no figure is bolted in two
  columns at once.

## Observations

### P1, P2, P4

| Sheet | B/U tokens | P1 fails | P2 fails | P4 fails |
|---|---|---|---|---|
| F/013 | 44 | 4 | 0 | 7 |
| F/014 | 74 | 0 | 0 | 12 |
| F/018–019, every label as an event | 64 | 3 | 6 | 20 |
| F/018–019, F/019's top row as a restatement (below) | 55 | 0 | 0 | 17 |
| F/020, in order | 103 | 2 | 3 | 33 |

- **F/013's P1 failures** are four "U n" in band 2 (t07, t16, t23, t25) whose
  B would be in band 1, which carries few labels. F/014 has the band-1 labels
  F/013 lacks (`f-cycles.md`, "The bolting-plate sheets").
- **F/019's top row 15 against F/018's last row 15.** Nine labels are the same
  in both. F/018's U4 in e06 is not on F/019. Column e24 is headed 'g2 on
  F/018 and 'g3 on F/019. Every P1 and P2 failure on F/018–019 is in that
  top row; *reading* it as a restatement of the state at the foot of F/018
  (with those two differences), F/018–019 has none.
- **F/020's failures**: block 3 unbolts in f11 and f12 what block 2 has
  already unbolted, with no B between (P1); and three B's come while their
  figure is already bolted in the column, at b2.l5 f04, b3.l3 f14 and b3.l5
  f10 (P2). Reading the blocks as alternatives that each start from the end of
  block 1 gives more failures, not fewer.
- **P4 fails on every sheet.** The same figure stands "bolted" in several
  columns at once (B3 in e34, e40, e05 and e19 of F/018 cycle 1).
- **Never followed by a U**: 4 on F/013, 8 on F/014, 7 on F/018–019 (with the
  restatement), 8 on F/020, among them the figureless "B" and "B′".

### P3 (the time charts only)

| | F/013 | F/018–019 (restatement) |
|---|---|---|
| B over an up arrow in the next row | 11 | 31 |
| B over a down arrow in the next row | 4 | 0 |
| B over a stepped shaft beginning one row later (Cir columns t11, t24) | 4 | 0 |
| B over no motion | **0** | **0** |
| B whose next row the sheet does not give (untestable) | 1 | 0 |
| U standing alone over no motion | 14 | 19 |
| U standing alone over a motion | **0** | **0** |
| U in a compound label (not a test) | 6 | 5 |
| "U&B" (F/013's "Bolt to platforms" column; not tested) | 4 | 0 |

F/014 and F/020 have no arrows and no rows, so P3 cannot be tested on them:
all 74 and 103 of their tokens are untestable.

### Between a B and its U

| | F/013 | F/018–019 |
|---|---|---|
| Matched B…U pairs | 16 | 24 |
| A return (double-headed arrow) between B and U | 12 | **24** |
| A motion but no return (the stepped shafts of t11, t24) | 4 | 0 |
| The U in the band after its B | 16 | 19 (2 two bands on, 3 in the same band) |

## Readings

- **A B stands at the start of a motion of its part, in either direction.**
  P3 holds on both time charts without exception once motion is read as any
  of the column's motion marks (up arrow, down arrow, stepped shaft), not only
  an up arrow. A U standing alone never does.
- **B and U bracket a whole excursion.** On F/018–019 every B…U encloses the
  part's motion and its return, in order B, motion, return, U, and the U comes
  in a later band. On F/013 the same holds wherever the column draws a
  return.
- **P4 tests the wrong thing.** It assumes one plate per part. The archival
  search (below) finds Babbage locking two different parts to the same
  numbered platform in one sequence, so several columns bolted to one figure
  at once is what the platform reading predicts. The earlier reading here,
  that the figure belongs to its column, is withdrawn.

## Hypotheses, not adopted

- **H, with the figure relative to its column** ("plate n of that axis"), fits
  P1–P4 on F/018–019 under the restatement reading, and P2–P4 on F/013; F/013's
  P1 needs F/014's band-1 labels.
- **Transient motion against persistent configuration.** The arrows record a
  motion that goes out and comes back; B and U open before it and close after
  it, and the closing U falls in a later band. That fits B/U recording a
  state that lasts across the motion (a part connected, or held) and the
  arrows recording the motion itself. It is a pattern in the sheets, not a
  mechanism; nothing on them says what is connected or held.
- **F/020 as a pattern for one figure of the multiplier**, gone through again
  for each, rather than a single run: it would explain block 3's repeated
  unbolts. It is not established; other explanations (a slip, a sheet copied
  from another) are not excluded.
- **Local component, position or setting** for the figure: not distinguished.
  On F/013 the Cir columns write "B 3" over "Gears with N.o 1 in bottom Cage",
  "B 4" over "Gears with 2 in bottom Cage", "B 10" over "Gears with N.o 4 in
  Top Cage" and "B 9" over "Gears with 3 in Top Cage": the B figure and the
  gear number are not the same, so the figure is not the gear named.

## The platform reading, from the sources

`sources/notes/bolting-plates-sources.md` (read at full resolution; no person
has checked it) finds no definition of B or U, but:
- **Vol II p 42 (between 21 and 23 Dec 1835)** writes a multiplication by
  table as parts locked to and unlocked from numbered platforms: "Lock —
  centre pinion ⟨to N.o 3⟩ — carr. pin.s — on platform N.o 1 … Lock — the 2
  centre pin.ns to Pl. 4 … Unlock — the 2 cent. pinion from P[?l]. 2". The verb
  there is lock, and two parts go to Pl. 4 in one sequence.
- **Vol II p 7 (Nov 1835)**: "Pin.s 1.1 .6 −.6 −1.1 / Axis .4 .2 −.2 −.4", the
  lifts in F/013's platform heads; **pp 23–24 (5 Dec 1835)**: "Lock or Unlock
  to Travell. Platforms 2/3", and every B/U label on F/013 is in its row "2/3".
- **BAB/A/029**, titled "Method of bolting to platforms for vertical motion of
  Axes. 4 Feb.y 1836", names the same axes as the F sheets' column heads.
- **BAB/N/002, Feb 1835**: "Barrels to bolt axes to travelling platforms".

**Hypothesis P.** "B k" is the part in that column bolted to travelling
platform k; "U k" unbolted from it. Platform k has a fixed lift, which every
part bolted to it shares.

### The test of P (`scripts/bu_platforms.py`)

P predicts that a figure means the same motion wherever it stands. Observed,
for each B k over a motion with a written figure:

| k | F/013 | F/018–019 |
|---|---|---|
| 1 | — | up 1.1 |
| 2 | — | up .6 |
| 3 | up 1.1 (and one "[?.6]", an uncertain reading) | up 1.1 |
| 4 | up .6 | up .6 (one transcribed "6") |
| 5 | up .4 | up .4 |
| 6 | up .2 | up .2 |
| 7 | down .2 | — |
| 8 | down .4 | — |
| 9 | down .6 | — |

- Where two or more parts are bolted to the same figure and move in the same
  row, they move alike: 7 of 7 groups on F/018–019; on F/013, 1 of 2, the
  other differing only by the uncertain "[?.6]".
- Each figure has one direction and one lift, and the lifts are those of
  Vol II p 7. Figures 3–6 carry the same lift on both sheets (1.1, .6, .4,
  .2). F/018–019 also uses 1 and 2 (1.1 and .6 again: two platforms of each
  of the pinions' lifts); F/013 also uses 7–9 (the downward lifts −.2, −.4,
  −.6). So one numbering of platforms fits both sheets, so far.

**Reading.** P survives a test it could have failed: the figure predicts the
size and direction of the part's motion. With B and U bracketing the
excursion (above), the picture is a part bolted to a platform before the
platform rises or falls, carried with it and back, and unbolted after.
**Not adopted as established**: no source spells out B or U; in Dec 1835 the
verb is lock; F/014 and F/020 say "plates", and Babbage also had "locking
plates"; the figureless "B" and "B′", the B's never unbolted and F/020's
repeated U's are not explained; and the transcriptions are unchecked.

## What would settle it

A page that describes bolting plates or platforms in the mill of 1835–1836,
a drawing of Series A that shows numbered plates on an axis, or Babbage's own
definition of the notation. The archival search for these is in
`sources/notes/bolting-plates-sources.md`.
