# Lovelace, Note G (1843): the table for the Numbers of Bernoulli, transcribed and run

Read by a coding agent, November 2026. **No person has checked this
transcription.** It gives the six left-hand columns of the "Diagram for the
computation by the Engine of the Numbers of Bernoulli" (*Scientific Memoirs*
vol. 3, 1843, folding plate after p. 722), the decks made from it
(`control/note-g-printed.txt`, `control/note-g-corrected.txt`), and what they
give on the control machine (`src/sketch.rs`, configuration `1843`). Tests:
`tests/note_g.rs`.

**Observation** is what the plate or the text prints. **Reading** is what
the agent takes it to mean. **Hypothesis** is anything further. One
secondary source was used, and it is marked as secondary where it is cited.

## 1. Sources and how they were read

| Source | Copy | Use |
|---|---|---|
| The plate, primary | Natural History Museum (London) copy, digitised by the Biodiversity Heritage Library: <https://archive.org/details/scientificmemoir03memo>. The unfolded plate is leaf 754 (BookReader index `n733`). The **original** camera image `scientificmemoir03memo_orig_jp2.tar/…_orig_0754.jp2` (4368 × 2912 px, the plate filling about 2200 px of the width) was decoded and cropped. The processed images (`page/n733.jpg`, `_jp2.zip/…_0754.jp2`) are only 2241 px across the whole photograph. | The six left-hand columns of all 25 rows were read at about 1900 px for those columns (crops enlarged 3 to 6 times). The working-variable and result columns were read at the same scale. |
| Wikimedia Commons `File:Scientific_Memoirs,_Vol._3_(1843).djvu`, page 734 | The same NHM/BHL copy (its file page gives archive.org `scientificmemoir03memo` as the source). Thumbnails are capped at 1920 px. | Not an independent copy. Not read further. |
| English Wikisource, `Page:Scientific_Memoirs,_Vol._3_(1843).djvu/734` (raw wikitext) | A transcription of that scan, marked "proofread" (level 3), not validated | Compared cell by cell with the scan (§3). It has several errors and one silent correction. |
| Wikisource djvu/736–742 (text pp. 724–730, level 3–4) | Transcription | The text of Note G quoted in §5. Pp. 728 and 730 were checked against the scan in `menabrea-lovelace-1843-control.md`. Pp. 724–727 and 729 were **not** checked against the scan here. |
| Fourmilab, <https://www.fourmilab.ch/babbage/sketch.html>, diagram `figures/menat6_2k.png` | A typeset reproduction (1949 × 1260 px) with no source copy named | The six left-hand columns were compared with the scan (§3). Its other columns were not compared. |
| Wikipedia, "Note G" (raw wikitext, read November 2026). **Secondary.** | — | Its §"Error" states the Operation 4 swap and a value for the uncorrected program (§6). |
| A second physical copy | Digital Library of India `india.history.resource.53369` (vol. III) on archive.org | A quick look at leaves 735–765 did not show the folding plate. It was **not** searched further, so only one physical copy of the plate has been read. |

## 2. The plate, as printed: header and data

**Observation.** The title is "Diagram for the computation by the Engine of
the Numbers of Bernoulli. See Note G. (page 722 *et seq.*)". The column heads
are "Number of Operation.", "Nature of Operation.", "Variables acted upon.",
"Variables receiving results.", "Indication of change in the value on any
Variable.", "Statement of Results.", then "Data." (¹V₁ ¹V₂ ¹V₃), "Working
Variables." (⁰V₄ … ⁰V₁₃) and "Result Variables." (¹V₂₁ ¹V₂₂ ¹V₂₃ ⁰V₂₄). The
initial figures are 0 0 1 / 0 0 2 / 0 0 4 on V₁ V₂ V₃ and 0 0 0 on V₄ to V₁₃
and V₂₄. The boxes hold 1, 2, *n*, blank (V₄ to V₁₃), B₁, B₃, B₅, B₇. V₂₁ to V₂₃
are labelled "B₁ in a decimal fraction.", "B₃ …", "B₅ …". The sign circles
are blank.

(Wikisource prints the head of V₂₄ as ¹V₂₄. The scan has **⁰V₂₄**.)

## 3. The 25 operations, as printed (scan), row by row

Superscripts are written before V as on the plate (¹V₂ = "1V2"). "(sic)"
marks a cell that is printed so. The confidence column is the agent's
judgement of how clearly the scan shows the cell, not of what it means.

| Op | Nature | Variables acted upon | Variables receiving results | Indication of change | Statement of results | Legibility; other copies |
|---|---|---|---|---|---|---|
| 1 | × | ¹V₂ × ¹V₃ | ¹V₄, ¹V₅, ¹V₆ | ¹V₂ = ¹V₂; ¹V₃ = ¹V₃ | = 2n | clear; FM same |
| 2 | − | ¹V₄ − ¹V₁ | ²V₄ | ¹V₄ = ²V₄; ¹V₁ = ¹V₁ | = 2n − 1 | clear; FM same |
| 3 | + | ¹V₅ + ¹V₁ | ²V₅ | ¹V₅ = ²V₅; ¹V₁ = ¹V₁ | = 2n + 1 | clear; FM same |
| 4 | ÷ | **²V₅ ÷ ²V₄** | ¹V₁₁ | ²V₅ = ⁰V₅; ²V₄ = ⁰V₄ | = (2n − 1)/(2n + 1) | clear; FM same; **WS has ²V₄ ÷ ²V₅** (silently corrected) |
| 5 | ÷ | ¹V₁₁ ÷ ¹V₂ | ²V₁₁ | ¹V₁₁ = ²V₁₁; ¹V₂ = ¹V₂ | = ½ · (2n − 1)/(2n + 1) | clear; FM same |
| 6 | − | ⁰V₁₃ − ²V₁₁ | ¹V₁₃ | ²V₁₁ = ⁰V₁₁; ⁰V₁₃ = ¹V₁₃ | = −½ · (2n − 1)/(2n + 1) = A₀ | clear; FM same |
| 7 | − | ¹V₃ − ¹V₁ | ¹V₁₀ | ¹V₃ = ¹V₃; ¹V₁ = ¹V₁ | = n − 1 (= 3) | clear; FM same; WS indication garbled ("¹V₂ = ¹V₃, ¹V₃ = ²V₂") |
| 8 | + | ¹V₂ + ⁰V₇ | ¹V₇ | ¹V₂ = ¹V₂; ⁰V₇ = ¹V₇ | = 2 + 0 = 2 | clear; FM same |
| 9 | ÷ | ¹V₆ ÷ ¹V₇ | ³V₁₁ | ¹V₆ = ¹V₆; ⁰V₁₁ = ³V₁₁ | = 2n/2 = A₁ | clear; FM same |
| 10 | × | ¹V₂₁ × ³V₁₁ | ¹V₁₂ | ¹V₂₁ = ¹V₂₁; ³V₁₁ = ³V₁₁ | = B₁ · 2n/2 = B₁A₁ | clear; FM same; WS has "¹V₁₂ × ³V₁₁" |
| 11 | + | ¹V₁₂ + ¹V₁₃ | ²V₁₃ | ¹V₁₂ = ⁰V₁₂; ¹V₁₃ = ²V₁₃ | = −½ · (2n − 1)/(2n + 1) + B₁ · 2n/2 | clear; FM same |
| 12 | − | ¹V₁₀ − ¹V₁ | ²V₁₀ | ¹V₁₀ = ²V₁₀; ¹V₁ = ¹V₁ | = n − 2 (= 2) | the minus is printed doubled or broken ("−−"), read as one minus; FM same |
| 13 | − | ¹V₆ − ¹V₁ | ²V₆ | ¹V₆ = ²V₆; ¹V₁ = ¹V₁ | = 2n − 1 | clear; FM same |
| 14 | + | ¹V₁ + ¹V₇ | ²V₇ | ¹V₁ = ¹V₁; ¹V₇ = ²V₇ | = 2 + 1 = 3 | clear; FM same; WS has "¹V₁ − ¹V₇" |
| 15 | ÷ | ²V₆ ÷ ²V₇ | ¹V₈ | ²V₆ = ²V₆; ²V₇ = ²V₇ | = (2n − 1)/3 | clear; FM same |
| 16 | × | ¹V₈ × ³V₁₁ | ⁴V₁₁ | ¹V₈ = ⁰V₈; ³V₁₁ = ⁴V₁₁ | = 2n/2 · (2n − 1)/3 | clear; FM same |
| 17 | − | ²V₆ − ¹V₁ | ³V₆ | ²V₆ = ³V₆; ¹V₁ = ¹V₁ | = 2n − 2 | clear; FM same |
| 18 | + | ¹V₁ + ²V₇ | ³V₇ | ²V₇ = ³V₇; ¹V₁ = ¹V₁ | = 3 + 1 = 4 | clear; FM same |
| 19 | ÷ | ³V₆ ÷ ³V₇ | ¹V₉ | ³V₆ = ³V₆; ³V₇ = ³V₇ | = (2n − 2)/4 | clear; FM same |
| 20 | × | ¹V₉ × ⁴V₁₁ | ⁵V₁₁ | ¹V₉ = ⁰V₉; ⁴V₁₁ = ⁵V₁₁ | = 2n/2 · (2n − 1)/3 · (2n − 2)/4 = A₃ | clear; FM same |
| 21 | × | ¹V₂₂ × ⁵V₁₁ | **⁰V₁₂** (sic) | ¹V₂₂ = ¹V₂₂; ⁰V₁₂ = ²V₁₂ | = B₃ · 2n/2 · (2n − 1)/3 · **(2n − 2)/3** (sic) = B₃A₃ | clear; FM has ⁰V₁₂ but **(2n − 2)/4** (silently corrected); WS has receiving "⁶V₁₁" and indication "⁰V₁₂ = ⁰V₁₂" |
| 22 | + | ²V₁₂ + ²V₁₃ | ³V₁₃ | ²V₁₂ = ⁰V₁₂; ²V₁₃ = ³V₁₃ | = A₀ + B₁A₁ + B₃A₃ | clear; FM same; WS has "³V₁₂ + ²V₁₃" |
| 23 | − | ²V₁₀ − ¹V₁ | ³V₁₀ | ²V₁₀ = ³V₁₀; ¹V₁ = ¹V₁ | = n − 3 (= 1) | clear; FM same; WS has "²V₁₀ + ¹V₁" and "³V₁₀ = ³V₁₀" |
| — | Across the table: "Here follows a repetition of Operations thirteen to twenty-three." | | | | | clear |
| 24 | + | ⁴V₁₃ + ⁰V₂₄ | ¹V₂₄ | ⁴V₁₃ = ⁰V₁₃; ⁰V₂₄ = ¹V₂₄ | = B₇ | clear; FM same; WS has "⁴V₁₂ + ⁰V₂₄" and "⁴V₁₂ = ⁰V₁₂" |
| 25 | + | ¹V₁ + ¹V₃ | ¹V₃ | ¹V₁ = ¹V₁; ¹V₃ = ¹V₃; ⁵V₆ = ⁰V₆ "by a Variable-card."; ⁵V₇ = ⁰V₇ "by a Variable-card." | = n + 1 = 4 + 1 = 5 | the superscript of ⁵V₆ is blotted: 5 (or 6), read as **5** (agrees with FM and with the count of changes to V₆); the rest clear. WS has ⁴V₆ |

FM = Fourmilab. WS = Wikisource. Braces in the first column group 13–23
(outer), 13–16 and 17–20 (inner), as in both copies.

**Working-variable and result columns (observation, the cells that matter
here).** Op 4, V₁₁: (2n − 1)/(2n + 1). V₄ and V₅: 0, 0 at Op 4. V₁₀: n − 1,
n − 2, n − 3 at Ops 7, 12, 23. Op 20, V₁₁: "{2n/2 · (2n − 1)/3 · (2n − 2)/**3**
= A₃}" (sic, the third denominator printed 3). Op 21: V₁₁ 0 (sic: the
indication column does not zero V₁₁), V₁₂ B₃A₃, V₂₂ B₃. Op 22: V₁₂ 0, V₁₃
"{**A₃** + B₁A₁ + B₃A₃}" (sic: A₃ where the statement column has A₀). Op 24:
V₂₄ B₇. Op 25: V₁ 1, V₃ n + 1, V₆ 0, V₇ 0.

## 4. The deck as printed (`control/note-g-printed.txt`)

One card for each operation, with the columns as printed. Superscripts are
dropped: the machine holds one number per column, and a superscript only
counts the values a column has held. How each convention of the table is
handled:

- **Data.** V₁ = 1, V₂ = 2, V₃ = 4. B₁, B₃, B₅ on V₂₁, V₂₂, V₂₃ are given with
  the signs of the text's equation (4) (p. 725), x/(eˣ − 1) = 1 − x/2 +
  B₁x²/2 + B₃x⁴/2·3·4 + …: B₁ = 1/6, B₃ = −1/30, B₅ = 1/42. Then B₇ = −1/30
  (modern B₈). Text, p. 727: "In the above table and diagram we are not
  considering the *signs* of any of the B's, merely their numerical
  magnitude. The engine would bring out the sign for each of them correctly
  of course".
- **Columns restored to zero.** Where the indication column says a column
  becomes ⁰V (Ops 4: V₄, V₅; 6: V₁₁; 11: V₁₂; 16: V₈; 20: V₉; 22: V₁₂; 24: V₁₃;
  25: V₆, V₇ "by a Variable-card"), the deck has a card `× vN 0 > vN` after
  the operation. This machine's operation card leaves its operands
  unchanged, so the zeroing needs a card of its own. It is **not** an
  operation of the table. **None of these zeroings changes V₂₄ in a single
  run.** Each zeroed column is overwritten before it is next read, or is not
  read again. They matter only for the next Number: Op 8 reads ⁰V₇, Op 6
  reads ⁰V₁₃, and Op 24 reads ⁰V₂₄. With them, the final store has V₄ to V₉,
  V₁₂ and V₁₃ at zero, as the table says.
- **Op 21, receiving ⁰V₁₂ (sic).** The column is V₁₂ either way. No effect.
- **Ops 7 and 12, the tests.** These are subtractions whose result, zero for
  n = 1 or n = 2, would send the engine on the other "course" (p. 728): put
  B on its result column and stop or start again. That course goes
  **forward**. This machine's only conditional card is `back LABEL if vN`,
  which goes backward, so the course is **not expressed**. The subtractions
  are made, and the cards go on (the course for n > 2). No card is invented
  for it.
- **Op 23 and the repetition.** `back op13 if v10` follows Op 23. It backs to
  Op 13 while V₁₀ > 0 and otherwise lets the cards go on to 24 and 25. This
  is Reading A of `menabrea-lovelace-1843-control.md` §8: no counter is
  loaded; V₁₀ is recomputed by subtraction at Ops 7, 12, 23 and tested.
- **Op 21 on the repetition.** The card reads V₂₂, as printed, on every pass.
  The text says otherwise (§5). This is kept in the printed deck.

## 5. What the text says about the repetition (observation)

P. 728 (djvu/740): "Not only are all the *operations* precisely the same
however for every such repetition, but they require to be respectively
supplied with numbers from the very *same pairs of columns*; with only the
one exception of Operation 21; which will of course need B₅ (from V₂₃)
instead of B₃ (from V₂₂)."

P. 729 (djvu/741): "The only exception to a *perfect identity* in *all* the
processes and columns used, for every repetition of Operations (13…23) is,
that Operation 21 always requires one of its factors from a new column, and
Operation 24 always puts its result" (p. 730) "on a new column. But as these
variations follow the same law at each repetition, (Operation 21 always
requiring its factor from a column *one* in advance of that which it used
the previous time, and Operation 24 always putting its result on the column
*one* in advance of that which received the previous result), they are
easily provided for in arranging the recurring group (or cycle) of
Variable-cards."

P. 729: at the end of the repetition "V₁₀ = 0 … instead of 1", and "V₁₃ =
A₀ + A₁B₁ + A₃B₃ + A₅B₅". P. 730: "(1…7), (8…12), 2(13…23), (24, 25) … B₇";
"Σ(+1)ⁿ⁻²(13…23)" for B₂ₙ₋₁.

## 6. Discrepancies and corrections

| # | Where | Observation (scan) | Reading | Effect on the run | Correction in `note-g-corrected.txt` | Source |
|---|---|---|---|---|---|---|
| 1 | Op 4, variables acted upon | ²V₅ ÷ ²V₄ | A slip for ²V₄ ÷ ²V₅. The plate's own statement of results and its V₁₁ column give (2n − 1)/(2n + 1). Ops 2 and 3 put 2n − 1 on V₄ and 2n + 1 on V₅. Equation (8) begins −½·(2n − 1)/(2n + 1). | Yes: A₀ = −½·9/7 instead of −½·7/9 | `÷ v4 v5 > v11` | the plate (statement and V₁₁ column); text p. 726 eq. (8). Secondary: Wikipedia "Note G" §Error states the same swap. |
| 2 | Op 21 on the repetition | the card reads ¹V₂₂ | The text (pp. 728–730) says the repetition takes its factor from V₂₃ (B₅), provided by a cycle of Variable-cards. The table prints only the first pass. This is not an error of the plate. It is a step the plate leaves to the text. | Yes: the deck as printed uses B₃ twice | Copy V₂₂, V₂₃, V₂₄ to working columns V₁₄, V₁₅, V₁₆ before Op 13. Op 21 reads V₁₄. After Op 21, shift V₁₅ → V₁₄, V₁₆ → V₁₅, and zero V₁₆. That is 3 + 3 cards and three columns that are **not** in the table. Right for n = 3, 4, 5. | text pp. 728, 729–730 |
| 3 | Op 24, nature | + ⁴V₁₃ + ⁰V₂₄ | By equation (9), 0 = A₀ + A₁B₁ + A₃B₃ + … + B₂ₙ₋₁, so B₇ = −V₁₃. The printed + gives −B₇. This is consistent with p. 727 (the table considers magnitudes only), so it is a sign omission the text owns to, not a slip. | Sign only: +1/30 for −1/30 | `- v24 v13 > v24` (⁰V₂₄ − ⁴V₁₃) | text pp. 726 eq. (9), 727 |
| 4 | Op 21, statement of results; Op 20, V₁₁ column | (2n − 2)/**3** | A slip for /4 (Op 19 gives (2n − 2)/4, and Op 20's statement has /4) | None: not on a card | — | the plate; FM silently prints /4 |
| 5 | Op 22, V₁₃ column | {A₃ + B₁A₁ + B₃A₃} | A slip for A₀ (the statement column has A₀) | None | — | the plate |
| 6 | Op 21, receiving | ⁰V₁₂ | A slip for ²V₁₂ (its own indication: ⁰V₁₂ = ²V₁₂) | None: same column | — | the plate |
| 7 | Op 21, indication; V₁₁ column | V₁₁ not listed; V₁₁ column shows 0 at Op 21 | Unclear. V₁₁ must keep A₃ for the repetition (Op 16 multiplies onto it, p. 729 lists V₁₁ among the columns that "present a new set of values for the *next* performance"), so a zero here would break the cycle. Read as a slip in the V₁₁ column. | None in the deck: V₁₁ is not zeroed | — (not zeroed in either deck) | the plate; text p. 729 |
| 8 | Op 12 | the minus between the operands printed doubled ("−−") | type defect | None | — | the plate |
| 9 | Op 25 | ¹V₃ = ¹V₃ though V₃ changes | Explained by the text (p. 729: "these indices always begin anew for a separate calculation") | None | — | text p. 729 |

(The Wikisource transcription errors listed in §3 are errors of that
transcription, not of the plate.)

## 7. Results (configuration `1843`; `babbage control run -`)

| Deck | Data | Result | Passes of 13…23 (backings) | Cards read |
|---|---|---|---|---|
| as printed | n = 4 | **V₂₄ = −95/126** | 2 (1) | 51 |
| printed + correction 1 | n = 4 | V₂₄ = −1/2 | 2 (1) | 51 |
| printed + 1 + 3 | n = 4 | V₂₄ = 1/2 | 2 (1) | 51 |
| corrected, 1 + 2 without 3 | n = 4 | V₂₄ = 1/30 (= −B₇) | 2 (1) | 60 |
| **corrected (1 + 2 + 3)** | n = 4 | **V₂₄ = −1/30 = B₇** (modern B₈) | 2 (1) | 60 |
| corrected | n = 5; B₇ = −1/30 on V₂₄; Op 24 to V₂₅ | **V₂₅ = 5/66 = B₉** (modern B₁₀) | 3 (2) | 78 |
| corrected | n = 3; Op 24 to V₂₃ | V₂₃ = 1/42 = B₅ | 1 (0) | 42 |
| as printed | n = 5; Op 24 to V₂₅ | V₂₅ = −241/90 | 3 (2) | 66 |

The cycle runs n − 2 times ("Σ(+1)ⁿ⁻²(13…23)", p. 730). At the end V₁₀ = 0
(p. 729: "V₁₀ = 0"). Every value was also checked against an independent
exact-fraction computation in Python (scratch, not kept).

For n = 5 the data change is V₃ = 5 and B₇ on V₂₄, and Op 24's receiving
column moves to V₂₅. The text says Op 24 puts its result one column further
on for each Number (p. 730). Without that move, Op 24 would read B₇ where it
expects ⁰V₂₄. The n = 5 and n = 3 decks are made from the corrected deck by
those line substitutions in `tests/note_g.rs`. They are not separate files.

**Secondary claim not reproduced.** Wikipedia ("Note G", §Error; secondary)
says the uncorrected program gives −25621/630. No combination of
corrections 1–3, with signed or unsigned B data, gives ±25621/630 here.
How that figure was computed was not established.

**Which configurations accept the decks.** Only `1843`. The others refuse at
the `back op13 if v10` card ("a backing made effective by a result of the
mill").

## 8. Limitations of the encoding

- **The forward course at Ops 7 and 12 (and 23 for n = 3) is not
  expressed.** The machine has only a backward conditional. For n = 1 and
  n = 2 the decks run on through Ops 8–23. Their values still come out right,
  because every extra term multiplies a B column that is still zero or the
  factor 2n − 2 = 0: n = 1 gives V₂₁ = 1/6, and n = 2 gives V₂₂ = −1/30. But
  V₁₀ ends at −2 or −1, which the text's course never produces, and
  operations are performed that the engine would skip. This is a property
  of the encoding, not of Note G.
- **The advancing Variable-card of Op 21 (and Op 24) is not a card of this
  machine.** An operation card carries fixed column numbers. Correction 2
  encodes the advance by moving numbers through three working columns with
  extra cards. That is right for n ≤ 5 only. Op 24's column is fixed in each
  deck and is changed by hand for n = 3 and 5.
- **Zeroing on reading** is encoded by `× vN 0 > vN` cards, which are extra
  mill operations. In the engine it is a property of the Variable-card.
- **Superscripts** are not represented.
- **The whole series** ("cycle of a cycle", p. 730, with Ops 24–25 preparing
  the next B) is not run. Each deck computes one Number from data.

## 9. What could not be read or was not established

- Only one physical copy of the plate was read (NHM London, via BHL/archive.org;
  the Commons djvu is the same copy). The original image is a JPEG 2000 of
  540 KB at 4368 px across the photograph. Every cell of the six left-hand
  columns is legible at that size, apart from the blotted superscript of
  ⁵V₆ in Op 25 and the doubled minus in Op 12.
- The working-variable columns were read only for the cells cited in §3.
  Rows of "…" were not checked one by one.
- Whether Op 21's printed V₁₁ "0" and the missing V₁₁ in its indication is a
  slip (discrepancy 7) is a reading.
- Text pp. 724–727 and 729 were read from the Wikisource transcription and
  not checked against the scan here.
- No other secondary literature was consulted.

## 10. Reading B deck

`control/note-g-reading-b.txt` is the corrected program (§6, corrections
1–3, documented as in `note-g-corrected.txt`) under Reading B of
`menabrea-lovelace-1843-control.md` §8. The repetition of (13…23) is a
counted backing of count n − 2 (p. 730, "Σ(+1)ⁿ⁻²(13…23)"; Note E, the
limits "regulate how often this backward rotation is to be repeated"). The
zero test on V₁₀ only chooses a forward course. The 25 operations and their
zeroing cards are those of the corrected deck, card for card.

**Where the count comes from.** Operation 12 puts n − 2 on V₁₀. A
combinatorial card `set v10` straight after it puts that number on the
wheels, before the group it counts (rule 8 of `docs/semantics.md`). So the
count is a number computed in the run, Operation 12's result, taken from
the store (rule 4). No operation is added to make it. Operation 23 still
subtracts unity from V₁₀ on each pass, so V₁₀ ends at 0, as p. 729 says.

**Cards not in the table** (each under a comment in the deck), besides the
zeroing cards and the six cards of correction 2:

| Card | After | Why |
|---|---|---|
| `ahead op24 if v10 zero` | Op 7 | For n = 1, "instead of continuing its processes, would have to put B₁ on V₂₁; and then either to stop altogether, or to begin … all over again", having made V₃ = 2 (p. 728). The course goes to Op 24 (B on its column) and Op 25 (V₃ + 1, V₆ and V₇ zeroed), and the deck then ends: "stop altogether". |
| `ahead op24 if v10 zero` | Op 12 | "Card 12 has to perform the same office as Card 7" (p. 728), for n = 2. It also goes round `set v10`, whose count would be 0. |
| `set v10` | the card above | Puts n − 2 on the wheels. |
| `back op13 counted` | Op 23 | Stands for the table's line "Here follows a repetition of Operations thirteen to twenty-three". It subtracts unity from the wheels and backs to Op 13 unless they have run up. |

So the deck has 3 cards more than the Reading A deck: the two forward
courses and the combinatorial card. The counted backing takes the place of
`back op13 if v10`.

**Operation 23's test has no card.** Under this reading, V₁₀ comes to 0 on
the same pass on which the wheels run up, so the "B finished" course of
Card 23 and the end of the count are one event. A forward course on Op 23's
result would take the last pass out before the backing card, leaving the
wheels at 1. The cycle would then be ended by the test, not by the count,
which is Reading A in effect. `tests/note_g.rs`
(`reading_b_test_at_23_would_bypass_the_count`) shows this: the same B₇,
one subtraction from the wheels instead of two.

**Results** (configuration `1843-B`, Op 24's column moved to V₂₀₊ₙ as in §7):

| n | Result | V₁₀ at end | Passes of 13…23 (wheel steps) | Backings | Cards |
|---|---|---|---|---|---|
| 1 | V₂₁ = 1/6 = B₁ | 0 | 0 (forward course at Op 7) | 0 | 16 |
| 2 | V₂₂ = −1/30 = B₃ | 0 | 0 (forward course at Op 12) | 0 | 23 |
| 3 | V₂₃ = 1/42 = B₅ | 0 | 1 | 0 | 45 |
| 4 | **V₂₄ = −1/30 = B₇** | 0 | 2 | 1 | 63 |
| 5 | V₂₅ = 5/66 = B₉ | 0 | 3 | 2 | 81 |

The group passes exactly n − 2 times. V₁₀ takes the values n − 1, n − 2, …
down to 0 and never goes below zero. Under Reading A the n = 1 and n = 2
runs end with V₁₀ at −2 and −1 (§8). For every n, V₃ ends at n + 1.

**Which configurations accept it.** Only `1843-B`. Every other
configuration, `1843` included, refuses at card 11, the forward course
after Op 7 ("a forward course chosen by a result of the mill"). `1843`
does not have that card. Under Reading B the deck has no `back … if`.

**Without the forward courses** the deck is a deck of 30 May 1838
(`1838-05` accepts it, and it gives B₇ for n = 4). A counted backing whose
count is set from a computed number is all the repetition needs. Without
them, n = 2 puts a count of 0 on the wheels and n = 1 puts a count of −1;
both are errors (rule 13). So under Reading B, the only thing Note G needs
beyond the Sketch Books is the forward course on a zero result, and that
course is needed only for n = 1 and n = 2.

**Limitations.**

- The forward course ends the deck after Op 25 ("stop altogether"). The
  other course, "begin Operations 1, 2…7 all over again", is not
  expressed, and neither is the outer cycle Σ(+1)ⁿ of p. 730. Each run
  computes one Number from data, as in §8.
- Op 24's result column is fixed in the deck and moved by hand for each n.
  The advancing Variable-card of Op 21 is encoded as in correction 2, and is
  right for n ≤ 5 only.
- The count is taken from V₁₀ because Op 12 has just put n − 2 there. The
  text gives the count only as "Σ(+1)ⁿ⁻²". It does not say which column
  or card sets it, or when. A count from n by a number card would need the
  deck to be changed for each n, against the footnote to p. 729 (V₃ is the
  only datum that changes from one Number to the next).
- With the count on the wheels, V₁₀'s subtraction at Op 23 does nothing to
  the course. It is kept because it is an operation of the table.
- This machine's wheels hold one count (rule 4). Reading B for the whole
  series (an outer count of n Numbers around the inner count n − 2) would
  need two counts at once, which this machine cannot hold. It is not
  attempted here.
