# The B/U labels of Series F, tested against every occurrence

The labels "B3", "U5", "U5 B6" stand in Babbage's multiplication sheets of
January 1836: the time charts F/013 (by table) and F/018–019 (without table),
and the schedules F/014 and F/020 ("Bolting plates for multiplication by
table", "… to multiply without table"). No sheet says what B, U or the figure
means. The working hypothesis (`f-concordance.md`, S41) is:

**H.** "B n" is a numbered plate n bolted, and "U n" the same plate unbolted,
in the column where the label stands.

`scripts/bu_audit.py` reads every label in the transcriptions
(`mechanical/*.txt`, no person has checked them) and tests four predictions
of H. It prints every counterexample. This page records what it found, as
observation, reading and hypothesis. Nothing here gives a mark a mechanical
meaning; it tests what H predicts.

## The predictions

- **P1.** Every "U n" follows a "B n" of the same figure in the same column,
  with no other U of that figure between.
- **P2.** No column has a "B n" while n is already bolted there.
- **P3.** In the time charts, every "B n" stands over an up arrow in the next
  row of its column.
- **P4.** If the figure names one physical plate, no figure is bolted in two
  columns at once.

## What the audit found

### Observations

| Sheet | Labels | P1 | P2 | P3 | P4 |
|---|---|---|---|---|---|
| F/018–019, every label as an event | 63 | 3 fail | 6 fail | **0 fail** | 20 fail |
| F/018–019, F/019's top row as a restatement (below) | 54 | **0 fail** | **0 fail** | **0 fail** | 17 fail |
| F/013 | 43 | 22 fail | 0 fail | **0 fail** | 2 fail |
| F/014 | 74 | 0 fail | 0 fail | no arrows | 12 fail |
| F/020, in order | 103 | 2 fail | 3 fail | no arrows | 33 fail |

- **F/019 opens by restating F/018's last row.** Its partial top row 15 has,
  column for column, the labels of F/018 cycle 3's row 15 (all but one, U4 in
  e06; and the head of e24 is read 'g3 on F/019, 'g2 on F/018). Every P1 and
  P2 failure in F/018–019 is in that row. Read as a restatement of the state
  at the foot of the previous sheet, F/018–019 satisfies P1, P2 and P3
  without exception.
- **P3 holds everywhere it can be tested.** Every "B n" in F/013 and
  F/018–019 stands over an up arrow in the next row; no "U n" does.
- **P4 fails on every sheet.** The same figure is "bolted" in several columns
  at once (for instance B3 in e34, e40, e05 and e19 of F/018 cycle 1).
- **F/013's P1 failures** are of two kinds: "U" with no figure (columns t28–t30,
  in every band), and "U n" in band 2 or later whose B would be in band 1,
  which carries few labels. F/014 has the band-1 labels F/013 lacks
  (`f-cycles.md`, "The bolting-plate sheets").
- **F/020's failures**: block 3 unbolts in f11 and f12 what block 2 has
  already unbolted, with no B between (P1); and three B's come while their
  figure is already bolted in the column, at b2.l5 f04, b3.l3 f14 and b3.l5
  f10 (P2). Reading the
  blocks as alternatives that each start from the end of block 1 makes this
  worse (three U's with no B), so that reading is not taken.
- **Some B's are never followed by a U**: 8 on each sheet, among them the
  figureless "B" and "B′" of the columns 02 and 03.

### Readings

- **The figure is relative to its column.** P4 fails on every sheet, so if B/U
  is bolting, "n" does not name one physical plate of the mill. It names
  something of that axis or column: one of its own plates, a position, or a
  setting. Which of these the sheets do not say.
- **B and its up arrow are one event.** P3 without exception supports B
  marking the moment a part is raised or engaged, written as a label over the
  arrow; U has no arrow, so it marks something that the arrow notation does
  not show, or shows elsewhere.
- **F/020 is a pattern, not one run.** Block 3's repeated unbolts fit a sheet
  that sets out the schedule for one figure of the multiplier, to be gone
  through again, rather than a single run (as `f-cycles.md` already infers).

### Hypotheses, not adopted

- **H as stated** survives P1–P3 on the time charts and fails P4. Restated with
  the figure relative to its column ("plate n of that axis"), it survives all
  four on F/018–019. On F/013 it needs F/014's band-1 labels; on F/020 it
  needs the pattern reading.
- **U without a figure** (F/013, t28–t30) is not explained by H.

## What would settle it

A page that describes bolting plates or platforms in the mill of 1835–1836,
a drawing of Series A that shows numbered plates on the axes, or Babbage's
own definition of the notation. The archival search for these is in
`sources/notes/bolting-plates-sources.md`.
