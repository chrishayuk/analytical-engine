# Figure wheels from the chart: the rules, before the run (F/018–019)

Written and committed **before** `scripts/f_mill.py` was run against the
numbers Babbage wrote on BAB/F/018–019 ("Mult.<sup>n</sup> without Table, 11
Jan 1836, 1028 × 201"). Those numbers were known when these rules were
written (they are in `sources/notes/F018.md` §1), so this is **not a blind
test**. What it can show is whether the products follow from wheel-level
transitions read off the chart's marks, with no addition or multiplication
performed as an operation on numbers. Where a transition is not on the
sheets, it is named here as missing and not supplied.

The transcription used is `mechanical/F018-cycle1.txt` … `F019-cycle6.txt`
(one reader, from photographs; not checked by a specialist). Band 6's lack
of give-off marks was re-read at full resolution from the local cache
(216/273, x 0–3300, y 4500–6400): the Axis A Cir, the two Axis A figure
wheel columns and the Axis B N.<sup>o</sup> 1 column are empty in that band;
only the words are written.

Each rule has a class:

- **observed**: a mark or word on the sheet;
- **source**: stated in another Babbage manuscript, cited;
- **inferred**: this project's reading of a mark, with the evidence for it;
- **assumed**: needed to run, with no evidence either way; every result
  that depends on it says so;
- **missing**: a transition the sheets need and do not show. Not simulated.

## 1. What is represented

| Entity | Representation | Class |
|---|---|---|
| Axes A, B, C | the multiplicand, product and multiplier groups | observed (the titles over the three groups, and "Axis A/B/C") |
| Figure wheels N.<sup>o</sup> 1 and N.<sup>o</sup> 2 of each axis | each a column of **cages**, one figure wheel per cage, each wheel at a figure 0–9 | observed (heads "Fig wheels N.<sup>o</sup> 1, N.<sup>o</sup> 2"); cages: source, Vol II p 42 ("on a cage higher") |
| Number of cages | 6 on every axis (the product is written to six places) | inferred for B; **assumed** for A and C |
| A wheel's figure | an integer 0–9, turned one tooth at a time | inferred |
| Warning | a flag on a product cage, set when its wheel turns from 9 to 0 | **inferred**: not on these sheets; the column "Carriage b" and the word "Carry" are observed |
| Time | rows 1–9 of a band, one tooth per row | observed: the long Cir arrow and the stepped shafts run from the rule to the row 9/10 boundary; source: Vol II p 24 (5 Dec 1835), "Give off from Table to Product — · 9" |

No rule adds, subtracts or multiplies numbers. The only operation on a
figure is turning one wheel by one tooth.

## 2. Transitions

**T1. Give off** (inferred). In a band where an axis's Cir column has the
long down arrow in rows 1–9, the figure wheel of that axis whose column has
a **stepped shaft down** and the word **"Zeros"** gives off: in each of the
nine rows, every cage of that wheel not at 0 turns back one tooth. A cage
at 0 stays. After nine rows the wheel is at zero.
*Evidence:* "Zeros" under the shaft; Vol XIII pp 16–17 (Feb 1835), rows
"Red. Zero / Give off / Rec. Add.<sup>n</sup>"; F/020, "Give off from
N.<sup>o</sup> one".

**T2. Receive** (inferred). Each wheel with a **stepped shaft up** in the
same band (with "Figs", or with no word) turns forward one tooth in a cage
for each tooth the giving wheel's corresponding cage turns back.
*Evidence:* "Figs" under the shaft; F/020, "Retain on N.<sup>o</sup> two",
"Add to N.<sup>os</sup> one".

**T3. Which cage receives** (inferred, with a source). A receiving wheel on
the same axis as the giver takes cage *i* to cage *i* when the group's words
are "Give off and retain", and cage *i* to cage *i* + 1 when they are "Step
up from … to …". A receiving wheel on another axis takes cage *i* to cage
*i*.
*Evidence:* Vol II p 42 (23 Dec 1835, multiplication by table): "Product is
now on A 2 but on a cage higher". Cage *i* to cage *i* across axes is
assumed (nothing says the multiplicand and product are aligned except that
the sheet writes them right-aligned).

**T4. Out of the top** (inferred). A figure that a step would move above the
top cage leaves the axis. It is recorded as given to an **unknown resource**
and not used again.
*Evidence:* Vol II p 24 (5 Dec 1835, multiplication by table): "Step up
multiplier which reduces its first figure to zero and sets lifters". What
receives it on these sheets is not shown.

**T5. Warning** (inferred, not on these sheets). A product wheel that a
receive turns from 9 to 0 sets its cage's warning.

**T6. Carriage** (inferred). In a band with the up arrow and "Carry" in
"Carriage b" (row 13), each warned cage turns the wheel one cage above it
forward one tooth, and the warnings are cleared. Whether a carriage that
itself turns 9 to 0 is carried on at once (anticipating) or in a further
step (successive) is **not shown**. Both are implemented and reported;
they can differ only where a carry meets a 9.
"Carriage 'b" with "Zeros" in the same row is recorded, not interpreted
(**missing**).

**T7. A band with words and no marks** (inferred, reported both ways).
Band 6 writes "Give off and retain" and "Add to N.<sup>os</sup> one" with no
Cir arrow or stepped shaft. Variant M (**marks only**) does nothing in that
band. Variant W (**words**) executes the band as the same words are executed
in bands 2–3: the giving wheel is the one of the axis's two wheels that is
not at zero (if exactly one is), the other retains, and the product's
N.<sup>o</sup> 1 receives. Choosing the giver by the wheels' state is this
project's, not the sheet's.

## 3. Initial configuration

| Wheel | Initial | Class |
|---|---|---|
| A N.<sup>o</sup> 1 | 1028 | observed (the operand: cover, "1028 × 201"; "1028" in "Figures upon Axis A" above band 1). Which wheel holds it is **inferred** from band 2 giving off from N.<sup>o</sup> 1 |
| B N.<sup>o</sup> 1 | 0 | observed ("000000" above band 1). This is a recorded state used as the start; it is not counted as a target |
| C N.<sup>o</sup> 1 | 201, its first figure in the top cage | observed (the operand, cover only; the table never writes it); the placement is **assumed** |
| every other wheel | 0 | **assumed** |
| warnings | none | assumed |

## 4. What is checked, and against what

**Targets** (recorded states, never inputs): the number upon each axis at
row 14 of bands 1–6, as written in "Figures upon Axis A" (1028 each band)
and "Figures upon Axis B" (000000, 001028, 002056, 020560, 205600, 206628).
"The number upon an axis" is read as the figures of whichever of its two
wheels is not at zero; if both are not at zero, it is reported as two
numbers and scored a miss.

**State checks**, which the marks could fail: in each band, the wheel the
marks name as giving ("Zeros") should hold the axis's number, and the
receiving wheel on the same axis should stand at zero beforehand (else a
"retain" or "step" would not copy). And "Add to N.<sup>os</sup> one" should
find the product on N.<sup>o</sup> 1.

**Exploratory only, fitted**: the figures the multiplier gives out of its
top cage (T4) at each step, against the number of "Add" bands before the
next step. This depends on the assumed placement of 201, which was chosen
knowing the sequence; it is not evidence.

## 5. Missing transitions, named now

- **M1. How the multiplier's figure decides the number of additions.** The
  sheets carry no counting of additions: no wheel moves in the multiplier
  group during an "Add" band. The simulator takes the order of bands
  (which bands step, which add) from the chart, as the chart's control. It
  does not derive it.
- **M2. Which bolting or lift puts which wheel into gear.** The engagement
  of T1–T3 is read from the stepped shafts and the words, not from the
  B/U labels or the lifts of Ver columns. How a lift of Axis B by .4
  (platform 5) makes a step instead of an addition is not shown.
- **M3. What "Carriage 'b … Zeros" does**, and how the warning (T5) is held.
- **M4. What R2, pp, ap, g, g1, ′p′p, ′g1, 02, ′g2/′g3, 03, ′S′S, ′S1,
  ″S″S, ″S1 are.** Their motions are in the trace of `scripts/f_sim.py`;
  none of them is given a role here.
