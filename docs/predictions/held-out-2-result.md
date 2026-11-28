# Held-out test 2: the result

Scored on 28 November 2026 by `scripts/score_heldout2.py`. Its full output,
with every miss listed, is `held-out-2-scores.md`. The inputs are:

- the rules, frozen at dc3bf1d;
- the protocol, frozen at 1833752;
- the predictions, v1 (64ca93e) and v2 (1732e2f, an implementation revision made before any part arrow was seen);
- the blind transcription, `sources/notes/F021-F033-arrows.md`.

The transcription was made by one reader who was not shown the predictions, rules or labels. No person has checked it.

Ten sheets were read:

| Design | Sheets |
|---|---|
| Division without table | F/021–024 |
| Square root | F/026–029 |
| Ordinary cycle | F/032 |
| Carriage | F/033 |

The reader recorded 2,306 cells, each one column in one band. Cropped and unreadable cells are counted, not scored.

## Disclosures

- **Peeking before scoring.** While the reader was still working, I opened its F/021 working notes to check its progress. Both prediction versions had already been committed, so they could not change.
- **Scoring choices made after the transcription was seen.** None of them changes a prediction:
  - **Two column names** are matched to the reader's spelling: "cs (T2)" is the reader's "T2 cs", and "′g3 [? ″g3]" is the reader's "″g3".
  - **F/033's mid-band labels** (about row 11) are scored on the single-headed arrows the reader put under "Other" in rows 11–13.
  - **F/033's band-closing label rows are not scored.** The inputs note lists them as rows of their own ("L12", "L2 (one row lower)", "U2 (one row lower)"); they are 65 v2 predictions and 28 v1. Both extractors treated each as a band, but such a row has no motion row of its own.
  - **The Lock, platform and bolting columns** are not counted as parts.

## 1. Fresh "B k" (R1; M0, M1, R4 and R4u all predict this motion)

| | All | Division | Square root | Ordinary cycle | Carriage |
|---|---|---|---|---|---|
| Motion seen | **173 / 173** | 68/68 | 85/85 | 4/4 | 16/16 |
| Direction | **168 / 173** | 67 | 83 | 4 | 14 |
| Lift, of those with a figure | **145 / 150** | 67/68 | 60/62 | 4/4 | 14/16 |

- **The 4 uncertain lifts:** 4 of the 145 lifts counted right were read as uncertain.
- **No figure:** 23, almost all in square-root band 4, where the paper ends inside row 1.
- **Direction misses (5):**
  - F/024 band 3, Axis B Ver, B5: a stroke with no head.
  - F/029 band 4, QA Ver, B7, and S1, B9: up arrows, where down was predicted.
  - F/033 L2, "x" a10, labelled "U 9 B 4": a down arrow, where up was predicted.
  - F/033 L2, "y" a10, labelled "U 4 B 9": an up arrow, where down was predicted.
  - On "x" and "y" the motion goes the way of the U's platform, not the B's. That is noted here, not tested.
- **Lift misses (5):**
  - point missing (2): F/021 band 3, g, B4, read "6"; F/028 band 3, Axis A Ver, B8, read "4";
  - wrong figure (3): F/028 band 3, QA Ver, B8, read ".2"; F/033 "x" and "y", read ".3".

**Returns.** R2 (the row of the return) can't be tested: no sheet numbers its platform columns.

| Return check | Result |
|---|---|
| Direction opposite to the motion | 123 / 124 |
| Figure equal to the lift | 105 / 109 |
| Not scored | 41 cropped, 8 with no return transcribed, 15 without a figure |

- **Direction miss (1):** F/022 band 1, Axis A Ver, B6: the motion is up and the return is also up.
- **Figure misses (4):** 3 points missing and 1 wrong figure (F/028 band 3, QA Ver, ".2").

## 2. Persistence: the comparison that matters (M1 against M0)

These are parts that the extractor had attached by an earlier "B k" (no U since), that have no B or U of their own in the band. M1 predicts motion; M0, R4 and R4u don't (R4 and R4u abstain, because platform motion can't be read on these sheets).

| | All | Division | Square root | Carriage |
|---|---|---|---|---|
| Testable (cropped) | 43 (4) | 16 | 24 (4) | 3 |
| **Moved: M1 right, M0 wrong** | **37** | 14 | 21 | 2 |
| Did not move: M0 right, M1 wrong | 6 | 2 | 3 | 1 |
| Direction of those that moved | 37 / 37 | 14/14 | 21/21 | 2/2 |
| Lift, of those with a figure | 28 / 29 | 13/14 | 13/13 | 2/2 |

The 6 that did not move:

| Sheet, band | Column |
|---|---|
| F/023 band 3 | Axis B Ver |
| F/029 band 3 | Axis C Ver, ″p″p and cp |
| F/033 U2 | Change fig Add→Sub — a Ver |

(The table counts the F/033 case under carriage.)

The reader found labels on F/029 that the inputs note had missed: "U 6", "U" and "U 4", written over exactly those three F/029 columns in band 2's 1/3 row. Read that way, all three parts were detached before band 3. They are scored as frozen: M1 misses, M0 hits.

There are 17 more attached parts whose platform is unknown (an earlier bare "B"). M1 predicts motion, M0 none: **14 moved** and 3 didn't. All 3 are at the end of an F/033 table.

**Persistence holds.** 37 of 43 parts with no fresh label moved, each in the direction and by the lift of the platform that an earlier B had attached them to. A stateless reading of B, in which only a fresh label moves a part, fails on them.

## 3. No-motion predictions

| Case | Moved | Did not move | Cropped |
|---|---|---|---|
| U in this band (R3, lone U) | **0** | **123** | 28 |
| Detached, no label | **0** | **75** | 25 |
| Bare "B" in this band (v2: no motion) | **37** | 0 | — |
| Unknown state, column labelled later on the sheet | 34 | 128 | — |
| Never labelled on its sheet | 72 | 1,297 | — |

- **U holds without exception.** No part moved in a band where it carried a U or had been detached: 198 of 198.
- **v2's bare-B prediction fails, 0 / 37.** I added "a bare B predicts no motion" as an implementation choice before the outcomes were seen; the rules as written make no prediction for a bare B. Every bare-B part moved, mostly by lifts that aren't in F/013's twelve-platform table: ".45" (the T and O columns), ".3" (the a10 columns), and once "1.1". A reading, not tested: a bare B attaches to a platform outside F/013's numbering.
- **R4 as written fails on unlabelled parts: 106 missed movements.** It says a part with no attachment and no B doesn't move. But parts move with no label anywhere on their sheet:
  - ap, T2 and T3 in every band of F/022–024 (on F/021 they carry labels);
  - D-″P and D-″g on F/027;
  - ′g on F/022 and F/024;
  - T3 ′cs on F/027–029.

  The protocol starts every sheet with every part in the unknown state. These sheets continue one another, which is why the unknown-aware variant R4u was frozen beside R4.

## 4. Movement detection, model by model

One case is one part in one band. "Identical cases" are those all four models make a prediction for (fresh B, U this band, detached): 371.

| Model | Population | Predicts | Motion predicted and seen | **False movements** | **Missed movements** | Neither | Accuracy |
|---|---|---|---|---|---|---|---|
| M0 stateless | identical | 371 | 173 | 0 | 0 | 198 | 1.000 |
| M1 persistent | identical | 371 | 173 | 0 | 0 | 198 | 1.000 |
| R4 as written | identical | 371 | 173 | 0 | 0 | 198 | 1.000 |
| R4u | identical | 371 | 173 | 0 | 0 | 198 | 1.000 |
| M0 | own coverage | 1,999 | 173 | 0 | **194** | 1,632 | 0.903 |
| M1 | own coverage | 431 | 224 | **9** | 0 | 198 | 0.979 |
| R4 | own coverage | 1,902 | 173 | 0 | **106** | 1,623 | 0.944 |
| R4u | own coverage | 371 | 173 | 0 | 0 | 198 | 1.000 |

On the cases they share, the models can't be told apart. They differ only where one predicts and another abstains:

- **M1 adds 51 motions, 42 of them right.** Its 9 false movements are the 6 persistence misses above plus the 3 F/033 unknown-platform cases.
- **M0 and R4 predict no motion everywhere else and miss 194 and 106 motions.** These are bare B, persistent and unlabelled parts.
- **R4u is never wrong, but it predicts only 371 of 1,999 cases.**

Per design, the same pattern holds on every sheet type: `held-out-2-scores.md`, end.

Direction, lift and returns are reported separately above (sections 1 and 2).

## 5. F/033's mid-band labels (v2 change 7), and v1 against v2

- **The five mid-band "B k" labels** (about row 11) predict a motion just after the label:
  - **Motion seen:** 4 of 5 have a single-headed arrow in rows 11–12. "y" a10 ("B 4") has only a return.
  - **Direction:** 1 of 4 by F/013's table. Three "B 7"s go up by ".2", where the table's platform 7 goes down by ".2".
  - **Lift:** 2 right, 1 point missing, 1 wrong ("x" "B 9": ".3").
  - On this sheet F/013's table fails for these mid-band labels. In F/033's first motion row, "B 7" goes down, as the table says.
- **v1's extra 14 persistence cases** came from treating the mid-band rows as bands of their own. 13 of the 14 show no fresh motion there: those parts' rows 11–12 hold their returns. v2 removed them before the outcomes were seen.
- **Otherwise v1 and v2 score the same:**
  - fresh B: the same 173;
  - persistence: the same 37 of 43;
  - lone U: 123 of 123.

## 6. Exploratory (not rules)

- **E1, "L k" on F/032 read as "B k":**

  | Check | Result |
  |---|---|
  | Motion | 5 / 5 |
  | Direction | 5 / 5 |
  | Lift | 5 / 5 |
  | Return direction | 5 / 5 |
  | Return figure | 5 / 5 |

  On F/032, "L k" behaves exactly as "B k" does elsewhere.
- **E2, F/032's return row by F/013's Long/Short grouping: 5 / 6.**
  - Carr. pin. ′g1, "L 3", returns in rows 15 to 1/3 ("long time"), where platform 3 is "short time" in F/013.
- **R2 and M2 can't be tested**, as frozen: no sheet numbers its platform columns.

## What this means for the hypothesis

| Part of the hypothesis | Verdict |
|---|---|
| "B k" attaches a part to platform k, which moves it, and the attachment persists until a "U" | Supported on held-out sheets: 173/173 fresh motions, 37/43 persistent, 0 motions in 198 detached or lone-U cases |
| Direction and lift come from F/013's table | Mostly holds (168/173, 145/150); fails on F/033's mid-band and its "x"/"y" levers, and on two F/029 band-4 parts |
| A part never moves without a label | Fails: parts move with no label on their sheet, and bare-B parts move by lifts outside the table |
| The timing of returns | Not tested |

None of this changes the frozen rules. Next:

- the stateful simulator, driven from the charts;
- the Series F notebook, with these failures included.
