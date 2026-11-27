# The six cycles of "Multiply a, b, c, d by 1021" (F/001–002)

This page sets out what the six transcribed cycles show and the competing
readings of them. Nothing here is a simulation. The figures are as Babbage
wrote them, and the words are his. Every reading of the arithmetic is
labelled as a hypothesis. The transcription is in `mechanical/` and
`sources/notes/F001.md` and `F002.md`; the marks are in
`docs/f-concordance.md`. No person has checked it.

## What the sheet records

| Cycle | Multiplier at row 2 | Complements at row 2 | Snail feeder (c08–c11) | Feeler (c40) | Gathering-up tooth (c12) | Gearing (c44) |
|---|---|---|---|---|---|---|
| 1 | 1021 | 9089 | c11 "lowered upon 1." | "Feels upon n." | Y marks | "Gears with n." |
| 2 | 0021 | 0089 | c10 "lowered upon 0." | "Feels upon n−1." | "Last.", "Single" | "Gears with n−1." |
| 3 | 0021 | 0089 | c09 "lowered upon 2." | "Feels upon n−2." | "Single." | "Gears with n−2." |
| 4 | 0011 | 0099 | none | "Rest." | "last but 1." | none |
| 5 | 0001 | 0009 | c08 "lowered upon 1." | "Feels upon n−3." | "Last.", "Single." | "Gears with n−3." |
| 6 | 0000 | 0000 | none | none | "Last.", "Single." | "Put out of gear." |

The columns of the two methods Babbage names under F/002's table are both
marked in every cycle. The snail method uses columns 07–14 ("Snails and
feelers which distinguish each figure, or which have ten angular
positions"). The feeler method uses columns 36–52 ("a feeler which has
only two angular positions"). The chart traces both side by side.

## Observations that need no reading of the marks

1. **The multiplier only goes down, and the complements only go up.** Each
   change of a multiplier figure from one cycle to the next is −1 on a
   single wheel. Each change of a complement figure is +1 (mod 10) on the
   same wheel: 9→0, 8→9, 9→0, 9→0. The complements are the figures'
   complements to 10, figure by figure (0 stays 0); this is not the ten's
   complement of the whole number. Babbage's note gives the reason: "The
   comp.ts are proposed to be used for the purpose of avoiding the
   necessity of making U[?1] move in two directions." The record shows
   wheels that turn one way only.
2. **Each figure of the multiplier is felt once, in order from the
   highest.** The snail feeders c11, c10, c09, c08 (headed "Feeder of 4th
   fig." and so on) are each lowered once, upon 1, 0, 2 and 1: the figures
   of 1021, highest first. The feeler "Feels upon" n, n−1, n−2, n−3 in the
   same cycles, and the gearing moves on with it.
3. **The figure 2 takes two cycles.** Cycle 3 feels the tens figure (2), and
   cycle 4 feels nothing ("Rest.", no feeder lowered). The tens figure goes
   2→1 in cycle 3 and 1→0 in cycle 4. The gathering-up tooth is marked
   "last but 1." in cycle 4. That is the only cycle without "Last." or
   "Single".
4. **The figure 0 takes one cycle and changes nothing.** In cycle 2 the
   feeder is "lowered upon 0." and the multiplier stays 0021.
5. **The run ends when the multiplier is 0000.** Cycle 6 starts at 0000 and
   puts the gearing "out of gear". The feeler arm is "Moved to the inactive
   position".

## Competing readings (hypotheses)

**H1. One addition for each unit of each figure, shifted by place.** The
machine adds the multiplicand, shifted to the place being felt, once for
each unit of that figure, counting the figure down to 0. Then the gearing
moves on one place. The product is 1000a + 10a + 10a + a.
- *For:* the cycle count. One cycle for each unit (1 + 2 + 1) plus one for
  the 0 figure and one to finish gives 6, as on the sheet. The
  single-step decrements fit, and so do the extra cycle for the 2 and
  "last but 1." in it.
- *Against, or not shown:* no mark on the sheet is yet understood as "add".
  The figures of a, b, c, d never appear, so no addition can be seen.

**H2. One cycle for each figure, multiplying by the whole figure at once.**
This is what "ten angular positions" might suggest for the snail method.
- *Against:* it predicts five cycles (four figures and a finish), not six.
  It does not account for the tens figure going down in two steps over
  two cycles.

**H3. Both methods are drawn on one chart for comparison, and only one is
meant to run.** The notes under F/002 describe two methods. The words in
their columns sometimes differ: the snail feeder is "lowered upon 0." in
cycle 2, where the feeler "Feels upon n−1.". So the chart may show two
designs on one time axis, not one mechanism.
- *For:* the two notes, and the two sets of feeders.
- *Open:* whether each method alone accounts for the count down. The
  figures on the multiplier wheels are shared, so the record cannot say
  which method moves them.

**H4. The 0 figure is skipped by the feeler but not by the snail.** In
cycle 2 the snail feeder is lowered upon 0 and the feeler feels n−1. It is
not decided whether either takes a cycle that adds nothing, or whether the
cycle is spent only in moving the gearing on.

H1 fits the counts best. It is not adopted. Adopting it would mean
deciding what the marks that would do the adding mean, and the concordance
has not done that.

## What would decide between them

- **The marks of cycle 4 against cycle 3.** Cycle 4 has the least motion (4
  columns at most) and repeats a figure. Any mark present in both cycles
  but not in cycle 2 (figure 0) is a candidate for "add once". Any mark
  present only in cycles where the place changes is a candidate for
  "shift". See the concordance's per-cycle table.
- **A multiplication by table**, to compare with this one: the same figures
  felt, with the repeated additions replaced. The earliest in Series F is
  **BAB/F/013, "Table multiplication."** (`aa110000497`, two images). The
  archive's file names date it 5 January 1836, and the date has still to
  be read on the sheet. Around it in the catalogue:
  - F/011–012, "Notation for lifters … for the purpose of division by
    table", 15 June 1835, cross-referenced to drawing BAB/A/24;
  - F/014, "Bolting plates for multiplication by table";
  - F/018–019, "Multiplication without table", 11 January 1836, six days
    after F/013;
  - F/020, "Bolting plates to multiply without table".

  The history sheets have "Plan of Mult. by Table" on 12 March 1835.

## Not in the record

The multiplicand's figures, any product, and any carriage of tens shown as
figures. "Carry" is written in F's circular motion in some cycles, but
nothing records a carried figure.

## Three designs: 1835, and January 1836

F/013 ("Table multiplication", 5 January 1836) and F/018–019
("Multiplication without table", 11 January 1836) are now transcribed to
the same standard (`sources/notes/F013.md`, `F018.md`). `babbage mechanical`
lists all three designs.

| | F/001–002 (about 1835) | F/013, by table (5 Jan 1836) | F/018–019, without table (11 Jan 1836) |
|---|---|---|---|
| Operands written | "Multiply a, b, c, d by 1021" | none on any wheel | "1028 × 201"; the multiplicand and each product, to six places |
| Columns | 56 | 47 | 43, in Multiplicand, Product and Multiplier groups |
| Rows in a band | 13 | 11 to 15, with rows "2/3" and "1/3" before and after | 16 |
| Bands | 6 | 4, and the start of a fifth | 6 |
| Most columns in motion at once | 10 | 21–22 | 10 |
| Multiplier | its figures written, counted down a unit at a time | "stepped down" from one numbered wheel to another; no figure | "Step[ped] up"; its figures never written |
| Sensing a figure | snail feeders "lowered upon" a figure; a feeler "Feels upon n" | none named | none named |
| Complements | figure by figure, counted up | none | none |
| Unexplained marks of F/001 | — | only the stepped shaft and the stacked double head recur | none recur |

**What F/018–019 records, checked against its own words.** Each band says
"Add" or "Step up", and writes the product. Every product written follows
from the one before. Where the band says "Add", it is the one before plus
the multiplicand written (1028). Where it says "Step up", it is ten times
the one before:

000000 → 001028 → 002056 → 020560 → 205600 → 206628 = 1028 × 201.

So the order is: two additions for the 2, the product shifted twice, and
one addition for the 1. The highest figure is taken first, and the product
is shifted rather than the gearing moved on (compare F/001's "Gears with
n−1"). This check compares Babbage's figures with his own words. It does
not simulate the mechanism and gives no mark a meaning. It is the first
place in Series F where a calculation can be followed from the record
alone.

**What it bears on.** In F/001–002, H1 (one addition for each unit of a
figure) was the leading reading, but no product was written to test it.
F/018–019 shows that very scheme, written out with its figures, six days
after the table design: one addition for each unit of a figure, the
highest first. That supports H1 as a reading of Babbage's method in
January 1836. It does not prove that F/001–002, a year earlier and a
different mechanism, worked the same way.

**What F/013 does not show.** No figure is written on any of its wheels, and
nothing in it is said to feel a figure. So whether the table design
multiplies by a figure at once cannot be read from it. Its notes (one dated
6 February 1836) and its "Platforms" with signed figures are described in
`sources/notes/F013.md`.

**Not the same design redrawn.** The three differ in their parts, cycle
length, symbols and how they move to the next place. Nothing on the sheets
supports merging them into one machine.
