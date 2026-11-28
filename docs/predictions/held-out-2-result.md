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
  - **The Lock, platform and bolting columns** are not counted as parts anywhere; among never-labelled columns, nor are the unheaded, circular-motion (Cir), figure-wheel and carry columns, which take no B/U label on any sheet.
  - **Cells read "nothing (in the visible part)"** (F/026–029 band 4, where the paper ends inside row 1) are scored both ways: dropped as cropped, and counted as empty, as the arrows seen in the same row are counted. Both results are given.
- **Corrected after an independent review of the scorer (28 November 2026).** A reviewer, shown the code and the frozen documents but not this write-up, reproduced every count with code of their own. It found that the model comparison in the first version of this document (cdb7aac, 4747440) did not score what the frozen v2 file says: it made R4 and R4u abstain on persistent and unknown-platform parts, and made M1, R4 and R4u abstain on bare B's, where v2 says no motion. Those cases were left out of the "identical cases", which were therefore identical by construction. Section 4 is now scored as frozen; the first version's figures are in the history. The review also found the asymmetric cropping above, bolting columns counted in one category and not another, non-part columns among the never-labelled, a mid-band arrow left out, and doubtful points scored as missing; each is corrected or reported both ways below.

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
- **Figure misses (4):** 2 points missing, 1 doubtful point (F/026 band 2, J1, read "6" with a faint mark [?.6]), and 1 wrong figure (F/028 band 3, QA Ver, ".2").

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
| F/023 bands 3 and 4 | Axis B Ver (band 4: row 1 read as empty; the table ends after it) |
| F/029 band 3 | Axis C Ver, ″p″p and cp |
| F/033 U2 | Change fig Add→Sub — a Ver |

(The table counts the F/033 case under carriage.)

The reader found labels on F/029 that the inputs note had missed: "U 6", "U" and "U 4", written over exactly those three F/029 columns in band 2's 1/3 row. Read that way, all three parts were detached before band 3. They are scored as frozen: M1 misses, M0 hits.

There are 17 more attached parts whose platform is unknown (an earlier bare "B"). M1 predicts motion, M0 none: **14 moved** and 3 didn't. All 3 are at the end of an F/033 table.

**With the band-4 cells read as empty** (the paper ends inside row 1), four more persistence cases are scored, F/029 band 4's Axis C Ver, ″p″p, cp and D-″p″p, and none of them moved; the first three also did not move in band 3. Persistence is then **37 of 47**, and M0 is right on 10.

**Persistence holds.** 37 of 43 parts with no fresh label moved (37 of 47 with the band-4 cells read as empty). All 37 moved in the direction of the platform an earlier B had attached them to; of the 29 with a figure, 28 moved by its lift (the other, F/027 band 2, J1, has a doubtful point, read at low magnification only), and 8 have no figure. A stateless reading of B, in which only a fresh label moves a part, fails on them.

**The persistence denominators, reconciled.** v1 enumerated 78 persistence cases and v2 64:

| | v1 | v2 |
|---|---|---|
| Moved | 37 | 37 |
| Did not move | 6 | 6 |
| Cropped | 4 | 4 |
| F/033 mid-band rows (v1 only; scored apart, section 5) | 14 | — |
| F/033 band-closing label rows (not scored) | 17 | 17 |
| **Total** | **78** | **64** |

## 3. No-motion predictions

| Case | Moved | Did not move | Cropped |
|---|---|---|---|
| U in this band (R3, lone U) | **0** | **123** | 28 |
| Detached, no label | **0** | **75** | 25 |
| Bare "B" in this band (v2: no motion) | **37** | 0 | — |
| Unknown state, column labelled later on the sheet | 32 | 127 | — |
| Never labelled on its sheet (part columns only) | 70 | 578 | — |

- **U holds without exception.** No part moved in a band where it carried a U or had been detached: 198 of 198 (251 of 251 with the band-4 cells read as empty).
- **v2's bare-B prediction fails, 0 / 37.** I added "a bare B predicts no motion" as an implementation choice before the outcomes were seen; the rules as written make no prediction for a bare B. Every bare-B part moved, mostly by lifts that aren't in F/013's twelve-platform table: ".45" (the T and O columns), ".3" (the a10 columns), and once "1.1". A reading, not tested: a bare B attaches to a platform outside F/013's numbering.
- **R4 as written fails on unlabelled parts: 102 missed movements** (32 in the unknown state, 70 never labelled). It says a part with no attachment and no B doesn't move. But parts move with no label anywhere on their sheet:
  - ap, T2 and T3 in every band of F/022–024 (on F/021 they carry labels);
  - D-″P and D-″g on F/027;
  - ′g on F/022 and F/024;
  - T3 ′cs on F/027–029.

  The protocol starts every sheet with every part in the unknown state. These sheets continue one another, which is why the unknown-aware variant R4u was frozen beside R4.

## 4. Movement detection, model by model

Scored as the frozen v2 file says. One case is one part in one band.

| Category | M0 | M1 | R4 as written | R4u |
|---|---|---|---|---|
| Fresh B | motion | motion | motion | motion |
| Bare B | none | none | none | none |
| Persistent; attached to an unknown platform | none | motion | none | none |
| Unknown state; never labelled | none | abstains | none | abstains |
| U in the band; detached | none | none | none | none |

On these sheets R4 as written predicts exactly what M0 does: it moves an attached part only "in any later band in which platform k moves", and v2 wrote that as no motion, since no sheet numbers its platforms. "Identical cases" are those all four models predict: 468.

**With the band-4 cells dropped as cropped:**

| Model | Population | Predicts | Motion predicted and seen | **False movements** | **Missed movements** | Neither | Accuracy |
|---|---|---|---|---|---|---|---|
| M0 stateless | identical | 468 | 173 | 0 | **88** | 207 | 0.812 |
| M1 persistent | identical | 468 | 224 | **9** | **37** | 198 | 0.902 |
| R4 as written | identical | 468 | 173 | 0 | 88 | 207 | 0.812 |
| R4u | identical | 468 | 173 | 0 | 88 | 207 | 0.812 |
| M0 | own coverage | 1,275 | 173 | 0 | **190** | 912 | 0.851 |
| M1 | own coverage | 468 | 224 | 9 | 37 | 198 | 0.902 |
| R4 as written | own coverage | 1,275 | 173 | 0 | 190 | 912 | 0.851 |
| R4u | own coverage | 468 | 173 | 0 | 88 | 207 | 0.812 |

**With the band-4 cells read as empty:** M1 has 15 false movements and 37 missed on 527 identical cases (0.901); M0, R4 and R4u have 88 missed (0.833).

- **M1's 37 missed movements are the 37 bare B's**, which v2 said would not move. The protocol's M1 ("moves if it has a fresh B") would predict them: read that way, M1 misses none and has 9 false movements (0.981), or 15 (0.972) with the band-4 cells read as empty.
- **M1's false movements** are the persistence misses of section 2 (6, or 10) and the F/033 unknown-platform parts that did not move (3, or 5).
- **M0, R4 and R4u's 88 missed movements** are the 37 bare B's, the 37 persistent parts and the 14 unknown-platform parts that moved. On their own coverage M0 and R4 also miss the 102 unlabelled parts that moved.

**M0 against M1, pairwise.** Where both predict and they disagree, the persistent and unknown-platform parts: **60 cases, M1 right 51, M0 right 9** (66 cases, 51 to 15, with the band-4 cells read as empty). On the 43 persistence cases alone, 37 to 6 (47 cases: 37 to 10).

Every table, under each convention, is in `held-out-2-scores.md`.

Direction, lift and returns are reported separately above (sections 1 and 2).

## 5. F/033's mid-band labels (v2 change 7), and v1 against v2

- **The five mid-band "B k" labels** (about row 11) predict a motion just after the label:
  - **Motion seen:** 4 of 5 have a single-headed arrow in rows 11–12. "y" a10 ("B 4") has a double-headed up arrow ".3" in row 12; counted as motion, as double-headed arrows in row 1 are, it is 5 of 5.
  - **Direction:** 1 of 4 by F/013's table (2 of 5 with "y"). Three "B 7"s go up by ".2", where the table's platform 7 goes down by ".2".
  - **Lift:** 2 right, 1 doubtful point ("[?.]2"), 1 wrong ("x" "B 9": ".3"); with "y", one more wrong (".3" for ".6").
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
