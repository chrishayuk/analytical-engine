# Series F, BAB/F/001–002: symbol concordance and cross-cycle comparison

**No person has checked the transcriptions this is built from**
(`sources/notes/F001.md`, `sources/notes/F002.md`,
`mechanical/F00{1,2}-cycle*.txt`). Every count and occurrence below is from
those files. Where a reading is uncertain there, it is uncertain here.

Scope: the six complete bands of the two sheets, numbered by the pencil figure
in the right margin of each: cycles **1–3 on F/001** (216/275–276) and
**4–6 on F/002** (216/304–305), plus F/001's three partial rows above cycle 1
("top", rows 11–13) and F/002's one partial row after cycle 6 ("after-1").

Column ids are F/001's **c01–c56**. F/002 has no heads. Its d-columns are
identified with F/001's c-columns by the ruling (`F002.md` section 2). That
identification is an inference, and so is every cross-sheet statement below
that depends on it.

**Rules for this document.** Readings are stated as readings. Every proposed
meaning is labelled **HYPOTHESIS**, with the evidence for and against it. None
of them is adopted. A source is cited only where it speaks to the mark, and
none of the sources describes an 1835 sheet (`F001.md` section 4).

Sources cited: **B1826** Babbage, *Phil. Trans.* 116 (1826) pp. 250–265;
**S2020** Swade, *DE2 Technical Description* (2020) pp. 6–8, 20–22;
**Br1982** Bromley, *Annals* 4(3) (1982) pp. 199–207; **F/002 notes**, the
three notes Babbage wrote under F/002's table (`F002.md` section 3).

## 0. Babbage's notes on F/002 (reading, a source internal to the sheets)

- Under **c07–c14** (S, the four feeders, gathering-up tooth, cam for
  lowering the feeder, X): "These columns belong to the method of multiplying
  by means of Snails and feelers which distinguish each figure, or which have
  ten angular positions."
- Under **c36–c52** (single tooth, cam, Feeder, starting teeth, P, the
  multiplier wheels, Y, U, C<sup>1</sup>): "These columns belong to the method
  of multiplying without snails, and with a feeler which has only two angular
  positions."
- Under **c53–c56** (complements): "N.B. The comp.<sup>ts</sup> are proposed to
  be used for the purpose of avoiding the necessity of making U[?1 / ↑] move in
  two directions."

These notes are on F/002 only. Whether they apply to F/001's identical columns
depends on the identification above. They are the strongest evidence below,
because they are Babbage's.

## 1. Cross-cycle comparison

"Arrows in motion" counts, for each time unit 1–13, the columns holding a mark
that `src/mechanical.rs` classes as `Arrow` (short, long and dashed arrows,
the staggered up pair). This is the pilot's measure. The second line adds the
marks the parser classes as `Unknown` but which are drawn as arrows: stepped
shafts S16, Y marks S3/S4, double arrows S6/S7/S22.

| | Cycle 1 (F/001) | Cycle 2 (F/001) | Cycle 3 (F/001) | Cycle 4 (F/002) | Cycle 5 (F/002) | Cycle 6 (F/002) |
|---|---|---|---|---|---|---|
| Multiplier digits, row 2, n … n–3 | 1 0 2 1 | 0 0 2 1 (↓ at n, faint) | 0 0 2 1 | 0 0 1 1 (↓ at n–2) | 0 0 0 1 (↓ at n–2) | 0 0 0 0 (↓ at n–3) |
| Complement digits, row 2 | 9 0 8 9 | 0 0 8 9 (↓ at n) | 0 0 8 9 | 0 0 9 9 (↓ at n–2) | 0 0 0 9 (↓ at n–2) | 0 0 0 0 (↓ at n–3) |
| Feeder lowered, rows 7–10 | c11 "Feeder of 4th fig.s": "lowered upon 1." | c10 "Feeder of 3 figures": "lowered upon 0." | c09 "Feeder of 2 fig.s": "lowered upon 2." | none | c08 "Feeder of units fig.": "lowered upon 1." | none |
| c40 Feeder "Feels upon …", rows 9–10 | n. | n–1. | n–2. | "Rest." | n–3. | none |
| c44 P "Gears with …" / c18–c24 "Gears with …" | n. / n … n–3 | n–1. / n–1 … n–4 | n–2. / n–2 … n–5 | none / none | n–3. / n–3 … n–6 | "Put out of gear." / "Put out of gear." |
| Lower central wheels with stepped shafts (S16) | none | c26–c29 (n … n–3) | c27–c30 (n–1 … n–4) | c28–c31 (n–2 … n–5) | c28–c31 | c29–c32 (n–3 … n–6) |
| S16 in c19/c21/c23/c25 and c33 | no | yes | **no** | yes | yes | yes |
| c36 single tooth, row 4 | dashed | solid | solid | **dashed** | solid | solid |
| c37 cam, row 4 / row 12 | ↓ / ↑ "Inactive." | ↓ "active." / ↑ "In-active." | ↓ "Active." / ↑ "In-active." | "Inactive." (no arrow) / none | ↓ "active." / ↑ "In-active." | ↓ "Active." / ↑ "In-active." |
| c06 C<sup>1</sup>, row 11 / row 13 | S6 + IF / ↓ "In gear." | ↑ "Put out." / none | none / ↓ "In." | ↑ "Out." / ↓ "In." | ↑ "Out." / ↓ "In." | ↑ "Out." / S6 + IF |
| c52 C<sup>1</sup>., row 11 / row 13 | none / ↓ ".5" | ⇑ ".5" / none | none / ↓ ".5" | ⇑ ".5" / ↓ ".5" | ⇑ ".5" / ↓ ".5" | ⇑ ".5" / none |
| Columns with any mark (of c01–c56) | 32 | 47 | 42 | 39 | 47 | 46 |
| Arrows in motion, units 1–13 (parser) | 3 1 1 3 1 2 4 2 4 10 5 7 9 | 3 6 1 7 4 4 6 4 4 7 6 9 6 | 3 1 1 6 4 4 6 5 4 10 5 8 8 | 3 4 1 2 2 1 1 1 2 2 1 2 4 | 3 6 1 7 4 4 6 4 4 10 6 9 8 | 3 6 1 7 4 4 6 4 3 7 7 9 5 |
| … with S16, S3/S4, S6/S7/S22 | 3 1 1 3 4 2 4 2 4 10 6 7 9 | 14 17 12 18 18 15 17 15 15 7 7 9 6 | 9 7 7 12 12 10 13 11 10 10 5 8 8 | 14 15 12 13 14 12 12 12 13 2 2 2 4 | 14 17 12 18 18 15 18 15 15 10 7 9 8 | 14 17 12 18 18 15 17 15 14 7 8 9 6 |
| Marks with no source meaning (S3, S4, S6, S7, S10–S12, S16, S19, S21–S24) | IF ×13, Y ×2 (+pair), S6, S10 ×4 | S10 ×4, S16 ×11, Y ×2 (+pair), S21, S22 | S10 ×4, S16 ×6, Y ×3, S23 | S10 ×4, S16 ×11, Y ×1, S22 | S10 ×4, S16 ×11, Y ×3 (+pair), S21, S22 | IF ×3, S6, S16 ×11, Y ×2 (+pair), S21, S22 |
| Marks in the file (incl. margin figure) | 70 (+17 top) | 90 | 78 | 61 | 97 | 84 (+1 after) |

Observations from the table (reading, not interpretation):

- In row 2, the one multiplier wheel and the one complement wheel with a short
  down arrow beside their digit are, in every cycle, the wheels whose digit
  differs from the cycle before. Cycle 3 has no change and no arrow.
- The feeders are used right to left across c11 → c10 → c09 → c08, against
  digits n, n–1, n–2, n–3. The figure each is "lowered upon" equals that
  digit as it stood in cycle 1 (1, 0, 2, 1).
- Cycle 4 has no feeder, no "Feels upon", no "Gears with" and no cam arrow
  (c13 or c37). It has nine "Rest" words, and both of the sheets' dashed
  shafts in the multiplication group (c36, c38).
- The first and last cycles (1 and 6), and the partial rows before cycle 1,
  are the only places with IF (S11) and with the double arrows S6 and S7.

## 2. Concordance by mark

Each entry gives the form, the total count, where it occurs, what accompanies
it, whether it recurs cycle by cycle, and the candidate meanings. Occurrence
lists are `column: cycle:row`. Cycle "top" means F/001's partial rows 11–13.
F/002's cycles 4–6 use d-columns and are listed under the matching c-id. The
complete lists are in section 3.

### S1 short down arrow / S2 short up arrow (71 / 59)

**Form.** A short vertical stroke with an open V head, at the lower end (S1)
or the upper end (S2), or mid-shaft. It is drawn in every cycle.

**Where (patterns).**
- Fixed cells, every cycle: c04 row 1 ↑ and row 13 ↓ (cycles 1–5; top); c05
  row 1 ↑, row 12 ↓ "Carry", row 13 ↑ (all cycles); c07 row 6 ↓ (all except
  4, where there is "Rest.").
- Paired with "Put in." (↓) and "Put out." (↑) in c41, c43, c50, c51, c17 and
  c14 (where c14 has an arrow; see S3). Paired with "active."/"Active." (↓) and
  "In-active." (↑) in c37.
- Beside a changed digit in row 2 (c46, c48, c49, c53, c55, c56).
- c52 ↓ with ".5" in row 13 (cycles 1, 3, 4, 5).

**Varies with the cycle.** Where a cycle has no arrow in one of these cells,
the cell holds "Rest", "Rest in.", "Rest out." or nothing (cycle 4
throughout; c50/c51 row 10 in cycle 2; c45 row 2 in cycle 3).

**HYPOTHESIS A** (S2020 p. 22; Br1982 p. 207): an arrow is a motion, and its
direction is the direction of motion. *For:* the words beside them are verbs
of motion ("Put in", "Put out", "lowered", "Moved to the inactive
position"). The "Rest" words stand where the arrow is absent, which fits
B1826 p. 259, "Dotted lines imply rest", in spirit if not in form. *Against:*
both sources are later (1838 and 1848) and describe other machines. Here a
down arrow goes with "Put in." in c41, c43, c50 and c51, but in c17 "Put in."
goes with a Y mark, and in c14 "Put out." goes with a Y mark in cycles 3 and 5
but with an up arrow and "IF." in cycles 1 and 6. So on this sheet the
direction of the arrow is not one-to-one with the word.

**HYPOTHESIS B:** a down arrow beside a digit means the wheel was turned back
by one or more steps. *For:* it appears exactly where the digit has changed.
*Against:* the multiplier change is −1 (2→1, 1→0) but the complement change is
+1 (8→9) or 9→0, and both get a down arrow. So the arrow's direction is not the
direction of the change in the figure. Unknown.

### S3 Y mark (14), S4 two staggered Y marks (4)

**Form.** A short vertical stroke with a V at its upper end, opening upward
(S3), or two of them offset diagonally (S4).

**Where.** c12 gathering-up tooth, row 5, every cycle: S4 in cycles 1, 2, 5, 6
and S3 in 3, 4. c14 X, row 5 with "Put in" (cycles 1, 2, 5, 6) and row 7 with
"Put out." (cycles 3, 5). c17 starting tooth, row 5, with "IF." (cycle 1) or
"Put in." (2, 3, 5, 6). Top row 13, c01. Never in the c36–c56 group, and never
with a long shaft.

**Varies with the cycle.**
- In c12 the number of Y marks matches the number of up arrows in the feeder
  column on the same row (S21 below): a pair where the feeder column has a
  pair (cycles 2, 5, 6), one where it has one (cycles 3, 4).
- The words beside c12's marks are "Last." / "Single" for a pair, "Single."
  for one in cycle 3, and "last but 1." for one in cycle 4. In cycle 1 the pair
  has only "IF.".
- In cycle 4, c17 has no Y mark, only "Rem.<sup>d</sup> out.", and c14 row 5 is
  empty.

**HYPOTHESIS A** (S2020 pp. 7–8, 22: "Tail- and head-variants of arrows
indicate direction and nature of motion"): the Y is a variant arrow, a head at
the top or a tail, for a different kind of motion from S1/S2. *For:* it occurs
only in a few parts (c12, c14, c17), consistently. *Against:* S2020 gives no
key to the variants, and its sheet is from 1848.

**HYPOTHESIS B:** the Y is an arrow pointing down with its head at the top
(motion begins at once). *For:* the row-7 feeder arrows of cycles 1–5 (c11,
c10, c09, c08) are drawn with their heads at the top and are read "[?Y-type]".
*Against:* in c14 row 7 the same cell has Y with "Put out." in cycles 3 and 5
and an up arrow with "IF." in cycles 1 and 6. If "Put out." means the same
thing in both, Y would be an up-motion there, so the direction cannot be read
from the mark.

**HYPOTHESIS C (count):** the number of marks in c12 is a count of something
per cycle, which is why it agrees with the feeder column's S21 pair or single
arrow. *For:* the agreement holds in cycles 2–6, and the words "Last.",
"Single.", "last but 1." are ordinal or counting words. *Against:* in cycle 1
c12 has a pair with no feeder arrow beside it. Unknown.

### S5 long vertical arrow (47)

**Form.** One shaft spanning several rows, with one head part-way down or at
the lower end.

**Where (fixed spans).** c02 rows 1–10 (all cycles; the head is in row 5 in
cycles 1 and 4, and row 6 in 2, 3, 5, 6); c13 rows 7–11 (all except 4); c18,
c20, c22, c24 rows 10–13 (all except 4); c38 rows 9–10 (all; dashed in 4);
c39 rows 5–8 (2, 3, 5, 6); c40 rows 9–10 (1, 3, 5; one row in 2); c44
rows 5–8 (2, 3, 5, 6; words only, no arrow, in 1).

**HYPOTHESIS** (S2020 p. 22; Br1982 p. 207): the length is the duration of
the motion. *For:* the same part always spans the same rows, and a span is
absent exactly in the cycle (4) whose words say the part is at rest. *Against:*
the sources are later. The head's position within the shaft (row 5 or 6 for
c02) changes between cycles with no other change in that column, which the
sources do not explain. Unknown.

### S6 converging double arrow (3) / S7 diverging double arrow (1)

**Form.** One shaft with two heads. In S6 both point inward; in S7 both point
outward.

**Where.** Only in **c06 C<sup>1</sup> Ver. Mo.**, and always with "IF": top
row 11 (S6), top row 13 (S7), cycle 1 row 11 (S6), cycle 6 row 13 (S6).

**Against the other cycles.** In the same cells, other cycles have:
- row 11: ↑ "Put out." / "Out." (cycles 2, 4, 5, 6) or nothing (3);
- row 13: ↓ "In gear." / "In." (1, 3, 4, 5) or nothing (2).

The second C<sup>1</sup> column, c52, has ⇑ ".5" in row 11 exactly in cycles
2, 4, 5, 6, and ↓ ".5" in row 13 exactly in cycles 1, 3, 4, 5. That is, c52 has
a mark wherever c06 has a single arrow with words. **Where c06 has S6 or S7,
c52 has nothing** (top, cycle 1 row 11, cycle 6 row 13).

**HYPOTHESIS A** (Br1982 p. 207: "double arrowheads indicate a return to the
inactive position"): S6/S7 is a return to rest. *For:* both are in the
partial rows before the first cycle and at the end of the last cycle, where a
return to a starting state would be expected. *Against:* Bromley's double
heads are not described in form (stacked or opposed), and the stacked double
head S22 also exists on these sheets. c52 shows no displacement at S6/S7
cells, which sits ill with a motion.

**HYPOTHESIS B:** S6/S7 + IF marks a motion that the pattern would call for at
that point but which does not take place (only at the beginning or end of the
whole operation). *For:* the c52 absences; and the in/out sequence of c06 in
cycles 1–6 is consistent with the part being out before cycle 1 and left out
after cycle 6. *Against:* cycles 2 (row 13) and 3 (row 11) also omit the
motion, and leave the cell blank rather than drawing S6. Unknown.

**Bearing on the pilot's question 8** (are c06 and c52 the same part?): in rows 11
and 13 over cycles 1–6 (12 cell-cycles, both sheets), c06 and c52 agree in
10: both marked in 8 (c06's words, c52's ".5" arrow) and both blank in 2. The
two exceptions are the S6 cells (cycle 1 row 11, cycle 6 row 13). The top
rows also have S6/S7 in c06 and nothing in c52. **HYPOTHESIS:** c06 and c52 are the same part,
recorded twice: once with words in the snail group, once with displacements
in the feeler group (see section 0). *Against:* nothing on the sheets says so.

### S8 arrow with a dashed shaft (3)

**Where.** c36 single tooth row 4, cycles 1 and 4 (solid in 2, 3, 5, 6); c38
cam Cir. rows 9–10, cycle 4 (solid in 1, 2, 3, 5, 6).

**What differs.**
- Cycles 1 and 4 are the two cycles in which c41 and c43 (the starting teeth
  for lowering the multiplying pinions and the registering tooth) are not put
  in at row 4: they are blank in cycle 1 and "Rest out." in cycle 4. In cycles
  2, 3, 5 and 6 they are ↓ "Put in."/"Put into gear".
- Cycle 4 is the one cycle where c37, the cam for lowering the Feeder, is
  "Inactive." at row 4 with no arrow. In that cycle c38 is dashed.

**HYPOTHESIS** (S2020 p. 22: "A dotted arrow shaft indicates conditional
motion – whether or not motion occurs throughout the time window of the arrow,
only for part, or not at all"; Br1982 p. 207: "might occupy only part of the
available time interval"; B1826 p. 254, for transmission: a piece driven "and
yet not always move when the latter moves"): the part turns but drives nothing
in that cycle. *For:* the dashed cycles are exactly those in which the parts it
would act on are out or inactive. *Against:* the sources are of other dates.
In cycle 1 the cam c37 is not inactive (↓ at row 4), yet c36 is dashed. Unknown.

### S9 dotted line, no head (4)

**Where.** Under the row-7 arrow of the feeder that is lowered, rows 8–11 or
8–12, beside "lowered upon …": c11 (cycle 1), c10 (2), c09 (3), c08 (5). It is
absent in cycles 4 and 6, which lower no feeder. In cycle 5 it is a double
column of dots with one last dot in row 13.

**HYPOTHESIS** (B1826 p. 259, rule 8: "Dotted lines imply rest"; rule 9: for a
click, bolt or valve, the side of the line shows in or out of action): the
feeder rests, lowered, until row 11 or 12. *For:* it always follows the
lowering arrow and the words "lowered upon". *Against:* B1826's dotted lines
belong to a different layout (lines beside an indicating line), and the double
column of cycle 5 is not explained.

### S10 hatched marks: struck-through arrows (24)

**Form.** An arrow with a visible head, crossed by 2–4 oblique strokes.

**Where.** Always the same four cells: c04 row 11 (up), c03 row 12 (up), c04
rows 12–13 (down), c03 row 13 (down). They occur in the top rows and in
cycles 1, 2, 3, 4 and 5, four per cycle. **They are absent only in cycle 6.**

**Neighbours.** The same hatching strikes c03's sub-head "Ver. Mo." and c04's
"B" (`F001.md` section 2), and an "IF" in top row 12. In every cycle that has
them, c04 also has a plain ↓ in row 13 and a ↑ in row 1 of the next cycle. In
cycle 6 the c04 row-13 ↓ is also absent, and the partial row after cycle 6 has
no c04 ↑ (only c05's). Cycle 6 instead has a ↑ in c01 row 11, the only c01
mark after cycle 1.

**HYPOTHESIS A** (the pilot's): cancellation. The motions of c03 (axis wheels,
vertical) were drawn, then struck out when that motion was abandoned. *For:*
the heads are struck with the same hatching. *Against:* the struck arrows were
copied fresh into every cycle of both sheets, which is odd for a cancellation.
They are also absent precisely where a hand-over to a next cycle is not needed.

**HYPOTHESIS B:** a motion of the axes that carries the result from one cycle
to the next (for example a stepping by one cage; the cover of F/001 says the
pinions "were [?lowered] one cage at a time"). The hatching marks a motion of
a different kind, not a cancellation. *For:* the marks occur in the top rows
before cycle 1 and after each of cycles 1–5, and not after the last. *Against:*
no source describes hatched arrows, and the struck heads in c03/c04 are
evidence of deletion. Unknown.

### S11 "IF" glyph (20) / S12 struck IF (1)

**Form.** Two stems sharing a top bar and a foot, with F's arms on the right
stem ("I F" or a double-stroke F). It sometimes has a full stop.

**Where.**
- Top rows: c01 r13, c05 r12, c06 r11, c06 r13, and struck in c03 r12.
- Cycle 1 (13): c02 r6; c05 r13; c06 r11; c07 r6; c12 r5; c14 r5; c14 r7;
  c17 r5; c17 r12; c18, c20, c22, c24 r10.
- Cycle 6 (3): c06 r13; c07 r6; c14 r7.
- **None in cycles 2–5.**

**Against the other cycles** (same cell, other cycles):
- c14 r5 "Put in" + IF. (1) → "Put in." (2, 5, 6);
- c17 r5 IF. (1) → "Put in." (2, 3, 5, 6);
- c17 r12 IF. (1) → "Put out." (2, 3, 5, 6);
- c14 r7 ↑ IF. (1, 6) → Y "Put out." (3, 5), "Rem.<sup>d</sup> in." (2),
  "Rem.<sup>d</sup> out." (4);
- c12 r5 IF. (1) → "Last."/"Single." (2, 3, 5, 6), "last but 1." (4);
- c07 r6 ↓ IF. (1, 6) → bare ↓ (2, 3, 5), "Rest." (4);
- c18–c24 r10 IF. (1) → nothing (2, 3, 5), "Put out of gear." from row 10 (6);
- c02 r6 and c05 r13 IF (1) → nothing in any other cycle;
- c06 r11 / r13 IF (1, 6) → see S6.

**HYPOTHESIS A:** a word or abbreviation standing in for the words written in
later cycles. *For:* in cycle 1, IF stands in cells that later cycles fill
with "Put in."/"Put out."/"Last.", and cycle 1 has far fewer words (13) than
cycles 2–6 (17–26). *Against:* in cycle 1 c14 r5 has both "Put in" and IF.,
so IF is not simply a replacement for those words.

**HYPOTHESIS B:** a mark of the boundary of the operation (first or last
cycle). *For:* it occurs only in the top rows, cycle 1 and cycle 6. *Against:*
cycle 6 has it in only three of the cells where cycle 1 has it.

**HYPOTHESIS C:** a label of a part, letter plus Roman numeral (the form noted
as unexplained in `docs/literature-mechanical-notation.md`, gap 3). *For:*
S2020 p. 7 says parts were named by capitals in several typeface families.
*Against:* it stands in thirteen different columns in one cycle. S2020 p. 22's
lock signs (a backwards F, "Free"; L, "Locked", 1848) are not this form.
Unknown.

### S13 words (125)

All of Babbage's words, by kind:
- Motion: "Put in.", "Put out.", "Put into gear", "Put out of gear.", "Out.",
  "In.", "In gear.", "lowered upon N.", "Feels upon n–k.", "Gears with n–k.",
  "Moved to the inactive position", "Carry".
- State: "active."/"Active.", "Inactive."/"In-active.", "Rest.", "Rest in.",
  "Rest out.".
- Abbreviated: "Rem.<sup>d</sup> in.", "Rem.<sup>d</sup> out." [?Rem.<sup>d</sup>].
- Order: "Last.", "Single.", "last but 1.".

The "n–k" in "Gears with" advances by one per cycle in which there is gearing:
n … n–3 (cycle 1), n–1 … n–4 (2), n–2 … n–5 (3), n–3 … n–6 (5). c44 P has the
first of the four. Cycle 4 has no gearing; cycle 6 has "Put out of gear."

"Rest" words are concentrated in cycle 4 (9 of its 17 words). Elsewhere they
appear where one cycle omits the arrow another cycle has (c45 r2 cycle 3;
c50/c51 r10 cycle 2). **HYPOTHESIS** (cf. B1826 p. 259): "Rest in/out" means
the part stays in (or out) with no motion. *For:* the positions. *Against:*
none found. It is a plain-English reading, still labelled.

"Rem.<sup>d</sup>": the reading itself is uncertain. HYPOTHESIS: "Remained".

### S14 digits (48)

Four multiplier and four complement digits in row 2 of every cycle. The
complement of each digit as written is: 1→9, 2→8, 0→0 (not 10−0). The
sequence is in section 1.

**Source (F/002 N.B.):** the complements "are proposed to be used for the
purpose of avoiding the necessity of making U[?1] move in two directions."
The c51 head on F/001 names U as the "Starting tooth of wheel which drives
Registering tooth".

**HYPOTHESIS:** the multiplier wheels are counted down to zero, one step per
addition: 1021 → 0021 → 0021 → 0011 → 0001 → 0000. Taking the digits in
order n, n–1, n–2, n–3, that is 1 + 0 + 2 + 1 additions over cycles 1–6.
*For:* the digit sequence; the down arrows at the changed wheels; and the
stepped shafts in the lower-pinion Cir. columns and c33 appear in cycles 2, 4,
5, 6. That is the cycle after each of the four non-zero steps, and not cycle
3, which follows the 0. *Against:* it is arithmetic assigned to marks, which
the pilot set out not to do. The complement wheels change in step with the
multiplier wheels, and their role is stated only as "proposed".

### S15 ".5" (8)

Only in c52, beside ⇑ (row 11) or ↓ (row 13). **Source:** S2020 p. 22 (1848):
numbers beside short vertical arrows are displacements in inches. Status: the
form matches; the date does not.

### S16 stepped broken shaft (50)

**Where.**
- Rows 1–9, in cycles 2–6 only, never in cycle 1.
- c15 (upper central wheels) and c16 (upper multiplying pinions) in every
  cycle 2–6.
- c19, c21, c23, c25, the **Cir. M.** halves of the four lower multiplying
  pinions, and c33 (figure wheels for product), in cycles 2, 4, 5, 6, not 3.
- Four consecutive lower central wheels, one place further right each time
  except 4→5: c26–29, c27–30, c28–31, c28–31, c29–32.

They are **only ever in columns headed circular** ("Cir." or the group
"Lower Central wheels. Circular motion."), never in a "Ver." column.

**HYPOTHESIS A:** S16 is a circular motion (rotation), and the stepped form is
its sign. *For:* the column heads, every one of them; Br1982 p. 207 says
circular motion was shown by "an arc attached to the arrow" in 1838, so a
distinct sign for rotation is attested later. *Against:* no source describes
a stepped shaft.

**HYPOTHESIS B:** the steps count something (teeth or figures). *For:* the
shafts have about 9 offset segments. *Against:* the count was not taken
segment by segment, and it does not vary visibly between cycles. Unknown.

The dot ending the c31 shaft in cycles 4 and 5 (S24) is unexplained.

### S19 erased mark (1), S20 pencil margin figure (6)

S19: top row 11, c01, illegible.

S20 (revised): pencil figures right of c56, one per band: "/" ([?1]), 2, 3
(F/001), 4, 5, 6 (F/002). **HYPOTHESIS:** a later numbering of the cycles
(whose hand is unknown). *For:* the sequence runs across the two sheets.
*Against:* none. The form differs from the ink.

### S21 two staggered up arrows (3) — new

The mirror image of S4. Row 5, in the column of the feeder lowered in the
cycle before: c11 in cycle 2 (after c11 in 1); c09 in cycle 5 (after c09 in 3,
with 4 between); c08 in cycle 6 (after c08 in 5). A single up arrow (S2)
stands in the same position in cycle 3 (c10, after c10 in 2) and cycle 4 (c09,
after c09 in 3).

**HYPOTHESIS:** the feeder is raised again, a pair meaning two steps or two
motions. *For:* the position; and the count matches c12's Y marks in the same
row (S3/S4). *Against:* a pair follows "lowered upon 1." (cycles 1, 5) but
also follows cycle 4, which lowered nothing, while one arrow follows
"lowered upon 0." and "lowered upon 2." So the count does not follow the digit.
Unknown.

### S22 up arrow with two stacked heads (4) — new

Only c52 row 11, with ".5", in cycles 2, 4, 5, 6. The down arrow of c52
row 13 has one head.

**HYPOTHESIS** (Br1982 p. 207, "double arrowheads indicate a return to the
inactive position"): this is that sign, and C<sup>1</sup> is raised back out of
gear. *For:* c06's words in the same cells are "Out."/"Put out."; and of all
the double-headed forms on the sheets, this stacked form fits "double
arrowheads" most literally. *Against:* the sign is from 1838, and S6/S7 are
another double-headed form.

### S23 ink dot (1) — new

Cycle 3, c05 row 6, a round dot mid-cell. Probably a blot; it has no parallel.

## 3. Every occurrence

Generated from the `mechanical/*.txt` files. Format `column: cycle:row`, with
the text for words, figures and margin figures. Top = F/001's partial rows.
F/002 marks (cycles 4–6) are listed under the c-id their d-id is identified
with. The parser kind is in brackets.


**S1 short down arrow [Arrow]: 71** (by cycle: top 2 · 1 9 · 2 14 · 3 11 · 4 8 · 5 16 · 6 11)

- c01: 1:13
- c04: top:13; 1:13; 2:13; 3:13; 4:13; 5:13
- c05: top:12; 1:12; 2:12; 3:12; 4:12; 5:12; 6:12
- c06: 1:13; 3:13; 4:13; 5:13
- c07: 1:6; 2:6; 3:6; 5:6; 6:6
- c08: 5:7
- c09: 3:7-8
- c10: 2:7
- c11: 1:7
- c33: 2:12; 4:12; 5:12; 6:12
- c36: 2:4; 3:4; 5:4; 6:4
- c37: 1:4; 2:4; 3:4; 5:4; 6:4
- c40: 2:9
- c41: 2:4; 3:4; 5:4; 6:4
- c43: 2:4; 3:4; 5:4; 6:4
- c45: 2:2; 4:2; 5:2; 6:2
- c46: 2:2
- c48: 4:2; 5:2
- c49: 6:2
- c50: 2:2; 5:2; 6:2
- c51: 1:10; 3:10; 5:10
- c52: 1:13; 3:13; 4:13; 5:13
- c53: 2:2
- c55: 4:2; 5:2
- c56: 6:2

**S2 short up arrow [Arrow]: 59** (by cycle: top 1 · 1 7 · 2 11 · 3 10 · 4 5 · 5 12 · 6 13)

- c01: 6:11
- c04: 1:1; 2:1; 3:1; 4:1; 5:1; 6:1
- c05: top:13; 1:1; 1:13; 2:1; 2:13; 3:1; 3:13; 4:1; 4:13; 5:1; 5:13; 6:1; 6:13
- c06: 2:11; 4:11; 5:11; 6:11
- c09: 4:5
- c10: 3:5
- c14: 1:7; 6:7
- c17: 1:12; 2:12; 3:12; 5:12; 6:12
- c37: 1:12; 2:12; 3:12; 5:12; 6:12
- c40: 2:2; 2:4; 3:4; 5:2; 5:4; 6:2; 6:4
- c41: 2:12; 3:12; 5:12; 6:12
- c43: 2:7; 3:7; 5:7; 6:7
- c50: 1:10; 3:10; 5:10
- c51: 2:4; 5:4; 6:4

**S3 Y mark [Unknown]: 14** (by cycle: top 1 · 1 2 · 2 2 · 3 3 · 4 1 · 5 3 · 6 2)

- c01: top:13
- c12: 3:5; 4:5
- c14: 1:5; 2:5; 3:7; 5:5; 5:7; 6:5
- c17: 1:5; 2:5; 3:5; 5:5; 6:5

**S4 two staggered Y marks [Unknown]: 4** (by cycle: top 0 · 1 1 · 2 1 · 3 0 · 4 0 · 5 1 · 6 1)

- c12: 1:5; 2:5; 5:5; 6:5

**S5 long vertical arrow [Arrow]: 47** (by cycle: top 0 · 1 8 · 2 9 · 3 10 · 4 1 · 5 10 · 6 9)

- c02: 1:1-10; 2:1-10; 3:1-10; 4:1-10; 5:1-10; 6:1-10
- c13: 1:7-11; 2:7-11; 3:7-11; 5:7-11; 6:7-11
- c18: 1:10-13; 2:10-13; 3:10-13; 5:10-13; 6:10-13
- c20: 1:10-13; 2:10-13; 3:10-13; 5:10-13; 6:10-13
- c22: 1:10-13; 2:10-13; 3:10-13; 5:10-13; 6:10-13
- c24: 1:10-13; 2:10-13; 3:10-13; 5:10-13; 6:10-13
- c38: 1:9-10; 2:9-10; 3:9-10; 5:9-10; 6:9-10
- c39: 2:5-8; 3:5-8; 5:5-8; 6:5-8
- c40: 1:9-10; 3:9-10; 5:9-10
- c44: 2:5-8; 3:5-8; 5:5-8; 6:5-8

**S6 converging double arrow [Unknown]: 3** (by cycle: top 1 · 1 1 · 2 0 · 3 0 · 4 0 · 5 0 · 6 1)

- c06: top:11; 1:11; 6:13

**S7 diverging double arrow [Unknown]: 1** (by cycle: top 1 · 1 0 · 2 0 · 3 0 · 4 0 · 5 0 · 6 0)

- c06: top:13

**S8 dashed-shaft arrow [Arrow]: 3** (by cycle: top 0 · 1 1 · 2 0 · 3 0 · 4 2 · 5 0 · 6 0)

- c36: 1:4; 4:4
- c38: 4:9-10

**S9 dotted line [Rest]: 4** (by cycle: top 0 · 1 1 · 2 1 · 3 1 · 4 0 · 5 1 · 6 0)

- c08: 5:8-11
- c09: 3:8-11
- c10: 2:8-11
- c11: 1:8-12

**S10 hatched (struck-through) arrow [Unknown]: 24** (by cycle: top 4 · 1 4 · 2 4 · 3 4 · 4 4 · 5 4 · 6 0)

- c03: top:12; top:13; 1:12; 1:13; 2:12; 2:13; 3:12; 3:13; 4:12; 4:13; 5:12; 5:13
- c04: top:11; top:12; 1:11; 1:12; 2:11; 2:12; 3:11; 3:12; 4:11; 4:12; 5:11; 5:12

**S11 IF glyph [Unknown]: 20** (by cycle: top 4 · 1 13 · 2 0 · 3 0 · 4 0 · 5 0 · 6 3)

- c01: top:13
- c02: 1:6
- c05: top:12; 1:13
- c06: top:11; top:13; 1:11; 6:13
- c07: 1:6; 6:6
- c12: 1:5
- c14: 1:5; 1:7; 6:7
- c17: 1:5; 1:12
- c18: 1:10
- c20: 1:10
- c22: 1:10
- c24: 1:10

**S12 struck IF [Unknown]: 1** (by cycle: top 1 · 1 0 · 2 0 · 3 0 · 4 0 · 5 0 · 6 0)

- c03: top:12

**S13 words [Words]: 125** (by cycle: top 1 · 1 13 · 2 25 · 3 22 · 4 17 · 5 26 · 6 21)

- c05: top:12 “Carry”; 1:12 “Carry”; 2:12 “Carry.”; 3:12 “Carry.”; 4:12 “Carry.”; 5:12 “Carry.”; 6:12 “Carry”
- c06: 1:13 “In gear.”; 2:11 “Put out.”; 3:13 “In.”; 4:11 “Out.”; 4:13 “In.”; 5:11 “Out.”; 5:13 “In.”; 6:11 “Out.”
- c07: 4:5 “Rest.”
- c08: 5:8-10 “lowered upon 1.”
- c09: 3:7-10 “lowered upon 2.”
- c10: 2:7-10 “lowered upon 0.”
- c11: 1:7-10 “lowered upon 1.”
- c12: 2:5 “Last.”; 2:5 “Single”; 3:5 “Single.”; 4:5 “last but 1.”; 5:5 “Last.”; 5:5 “Single.”; 6:5 “Last.”; 6:5 “Single.”
- c14: 1:5 “Put in”; 2:5 “Put in.”; 2:7 “Rem.d in.”; 3:7 “Put out.”; 4:7 “Rem.d out.”; 5:5 “Put in.”; 5:7 “Put out.”; 6:5 “Put in.”
- c17: 2:5 “Put in.”; 2:12 “Put out.”; 3:5 “Put in.”; 3:12 “Put out.”; 4:5 “Rem.d out.”; 5:5 “Put in.”; 5:12 “Put out.”; 6:5 “Put in.”; 6:12 “Put out.”
- c18: 1:11-13 “Gears with n.”; 2:11-13 “Gears with n-1.”; 3:11-13 “Gears with n-2.”; 5:11-13 “Gears with n-3.”; 6:10-13 “Put out of gear.”
- c20: 1:11-13 “Gears with n-1.”; 2:11-13 “Gears with n-2.”; 3:11-13 “Gears with n-3.”; 5:11-13 “Gears with n-4.”; 6:10-13 “Put out of gear.”
- c22: 1:11-13 “Gears with n-2.”; 2:11-13 “Gears with n-3.”; 3:11-13 “Gears with n-4.”; 5:11-13 “Gears with n-5.”; 6:10-13 “Put out of gear.”
- c24: 1:11-13 “Gears with n-3.”; 2:11-13 “Gears with n-4.”; 3:11-13 “Gears with n-5”; 5:11-13 “Gears with n-6.”; 6:10-13 “Put out of gear.”
- c37: 1:12 “Inactive.”; 2:4 “active.”; 2:12 “In-active.”; 3:4 “Active.”; 3:12 “In-active.”; 4:4 “Inactive.”; 5:4 “active.”; 5:12 “In-active.”; 6:4 “Active.”; 6:12 “In-active.”
- c39: 6:5-8 “Moved to the inactive position”
- c40: 1:9-10 “Feels upon n.”; 2:9-10 “Feels upon n-1.”; 3:9-10 “Feels upon n-2.”; 4:4 “Rest.”; 4:9 “Rest.”; 5:9-10 “Feels upon n-3.”
- c41: 2:4 “Put into gear.”; 2:12 “Put out.”; 3:4 “Put in.”; 3:12 “Put out.”; 4:4 “Rest out.”; 4:12 “Rest out.”; 5:4 “Put in.”; 5:12 “Put out.”; 6:4 “Put in.”; 6:12 “Put out.”
- c43: 2:4 “Put into gear”; 2:7 “Put out.”; 3:4 “Put in.”; 3:7 “Put out.”; 4:4 “Rest out.”; 5:4 “Put in.”; 5:7 “Put out.”; 6:4 “Put in.”; 6:7 “Put out.”
- c44: 1:5-7 “Gears with n.”; 2:5-8 “Gears with n-1.”; 3:5-8 “Gears with n-2.”; 5:5-8 “Gears with n-3.”; 6:5-8 “Put out of gear.”
- c45: 3:2 “Rest.”
- c50: 1:10 “Put out.”; 2:2 “Put in.”; 2:10 “Rest in.”; 3:10 “Put out.”; 4:2 “Rest out.”; 4:10 “Rest.”; 5:2 “Put in.”; 5:10 “Put out.”; 6:2 “Put in.”
- c51: 1:10 “Put in.”; 2:4 “Put out.”; 2:10 “Rest out.”; 3:10 “Put in.”; 4:4 “Rest in.”; 4:10 “Rest.”; 5:4 “Put out.”; 5:10 “Put in.”; 6:4 “Put out.”

**S14 digits [Figure]: 48** (by cycle: top 0 · 1 8 · 2 8 · 3 8 · 4 8 · 5 8 · 6 8)

- c46: 1:2 “1”; 2:2 “0”; 3:2 “0”; 4:2 “0”; 5:2 “0”; 6:2 “0”
- c47: 1:2 “0”; 2:2 “0”; 3:2 “0”; 4:2 “0”; 5:2 “0”; 6:2 “0”
- c48: 1:2 “2”; 2:2 “2”; 3:2 “2”; 4:2 “1”; 5:2 “0”; 6:2 “0”
- c49: 1:2 “1”; 2:2 “1”; 3:2 “1”; 4:2 “1”; 5:2 “1”; 6:2 “0”
- c53: 1:2 “9”; 2:2 “0”; 3:2 “0”; 4:2 “0”; 5:2 “0”; 6:2 “0”
- c54: 1:2 “0”; 2:2 “0”; 3:2 “0”; 4:2 “0”; 5:2 “0”; 6:2 “0”
- c55: 1:2 “8”; 2:2 “8”; 3:2 “8”; 4:2 “9”; 5:2 “0”; 6:2 “0”
- c56: 1:2 “9”; 2:2 “9”; 3:2 “9”; 4:2 “9”; 5:2 “9”; 6:2 “0”

**S15 ".5" [Figure]: 8** (by cycle: top 0 · 1 1 · 2 1 · 3 1 · 4 2 · 5 2 · 6 1)

- c52: 1:13 “.5”; 2:11 “.5”; 3:13 “.5”; 4:11 “.5”; 4:13 “.5”; 5:11 “.5”; 5:13 “.5”; 6:11 “.5”

**S16 stepped broken shaft [Unknown]: 50** (by cycle: top 0 · 1 0 · 2 11 · 3 6 · 4 11 · 5 11 · 6 11)

- c15: 2:1-9; 3:1-9; 4:1-9; 5:1-9; 6:1-9
- c16: 2:1-9; 3:1-9; 4:1-9; 5:1-9; 6:1-9
- c19: 2:1-9; 4:1-9; 5:1-9; 6:1-9
- c21: 2:1-9; 4:1-9; 5:1-9; 6:1-9
- c23: 2:1-9; 4:1-9; 5:1-9; 6:1-9
- c25: 2:1-9; 4:1-9; 5:1-9; 6:1-9
- c26: 2:1-9
- c27: 2:1-9; 3:1-9
- c28: 2:1-9; 3:1-9; 4:1-9; 5:1-9
- c29: 2:1-9; 3:1-9; 4:1-9; 5:1-9; 6:1-9
- c30: 3:1-9; 4:1-9; 5:1-9; 6:1-9
- c31: 4:1-9; 5:1-9; 6:1-9
- c32: 6:1-9
- c33: 2:1-9; 4:1-9; 5:1-9; 6:1-9

**S19 erased mark [Unknown]: 1** (by cycle: top 1 · 1 0 · 2 0 · 3 0 · 4 0 · 5 0 · 6 0)

- c01: top:11

**S20 pencil margin figure [Stray]: 6** (by cycle: top 0 · 1 1 · 2 1 · 3 1 · 4 1 · 5 1 · 6 1)

- margin: 1:~7 “/”; 2:~8 “2”; 3:~6 “3”; 4:~6 “4”; 5:~7 “5”; 6:~7 “6”

**S21 two staggered up arrows [Arrow]: 3** (by cycle: top 0 · 1 0 · 2 1 · 3 0 · 4 0 · 5 1 · 6 1)

- c08: 6:5
- c09: 5:5
- c11: 2:5

**S22 up arrow, two stacked heads [Unknown]: 4** (by cycle: top 0 · 1 0 · 2 1 · 3 0 · 4 1 · 5 1 · 6 1)

- c52: 2:11; 4:11; 5:11; 6:11

**S23 ink dot [Unknown]: 1** (by cycle: top 0 · 1 0 · 2 0 · 3 1 · 4 0 · 5 0 · 6 0)

- c05: 3:6

Not counted above: the partial row after cycle 6 (d05 ↑, 1 mark; commented
out in `mechanical/F002-cycle6.txt`), and the structural marks S17 (heavy
rules) and S18 (dashed rules).

## 4. What would test these hypotheses

- **The snail/feeler drawings** (F/002 notes): with them, S3/S4 in c12 and the
  S21 arrows in c08–c11 could be checked against a mechanism.
- **The drawing of the C<sup>1</sup> axis**: it would settle whether c06 and
  c52 are one part (S6/S22).
- **Later sheets of 1835** (F/003 onward) that use IF, S16 or hatching with a
  different multiplier. These would separate the "boundary" hypothesis for IF
  from the "abbreviation" one, and the "rotation" reading of S16 from others.
- **The unpublished keys** listed in `F001.md` section 6, item 3.
