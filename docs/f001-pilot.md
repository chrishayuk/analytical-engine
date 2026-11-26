# BAB/F/001: a pilot in the mechanical notation

BAB/F/001 is headed "Multiply a, b, c, d by 1021" and is probably from early
1835. Its cover reads: "Multiplication before the invention of Mult.n by
Table. The multiplying pinions were such as are [?those] drawing N.o —
geared with central wheels and were [?lowered] one cage at a time". The
drawing's number was never filled in.

The sheet is not a program of the kind in Series L. It is a time chart of
the mill. It has 56 columns, one for each part, each motion vertical
("Ver. Mo.") or circular ("Cir. Mo."), and rows of time units in cycles of
13. The pilot asked how far one cycle can be carried through four layers,
each a separate milestone, without filling any gap to make 1021 come out.

| Layer | Milestone | State |
|---|---|---|
| 1. The notation | Every mark of one cycle transcribed as written | **Done** for the partial rows 11–13 at the top and cycle 1, rows 1–13, on both images (`sources/notes/F001.md`, `mechanical/F001-cycle1.txt`). No person has checked it. |
| 2. Timing | Which parts act in which time unit | **Done** as a chart (`babbage mechanical`). Arrows are taken as motions, their length as duration, but that reading comes from 1838 and 1848 sources and is not shown for 1835. |
| 3. Mechanical state | Axes, pinions and wheels, and what each motion does to them | **Not possible yet** |
| 4. Arithmetic | The product comes out of layer 3 | **Not possible yet** |

## What one cycle shows

What the marks show, without interpreting them:
- Row 2 sets the multiplier on four wheels, 1 0 2 1, and four other wheels
  headed "complement" show 9 0 8 9.
- A feeder is "lowered upon 1." (rows 7–10) and "Feels upon n." (rows 9–10).
- The four lower multiplying pinions, n to n−3, come down together in rows
  10 to 13, each written "Gears with n.", "Gears with n−1." and so on.
- "Carry" is written in F's circular motion at row 12, and C¹ is "In gear."
  at row 13.
- The most columns in motion at once is 10, in time unit 10. Counted by
  time unit, from 1 to 13: 3 1 1 3 1 2 4 2 4 10 5 7 9.

## Why layers 3 and 4 stop

Of the 87 marks in the cycle:
- 28 are arrows, read as motions on the authority of later sources;
- 14 are Babbage's words;
- 9 are figures;
- 1 is a dotted line, which means rest (Babbage 1826, p. 259);
- 34 are marks no source found explains: "IF", the Y mark, converging and
  diverging double arrows, hatched strokes;
- 1 is a stray mark outside the table.

Simulating the cycle would need:
1. **The drawing of the multiplying pinions** the cover refers to. Its
   number is blank.
2. **The 1835 mill drawings** for the parts named in the column heads.
   Babbage's drawing numbers are the BAB/A numbers (see
   `sources/references.md`); which ones are 1835's mill is not yet worked
   out.
3. **A key to the 1835 marks** listed above.
4. **The starting state.** The cycle gives no value for a, b, c or d.
5. **What "n" denotes,** and whether the two C¹ columns are the same part.

To build a mechanism that turns these motions into a product would be to
write the arithmetic and assign it to the marks. The pilot set out not to do
that. So the pilot stops here.

## Against other work

- **Royal Holloway** (Johnstone and Scott, Leverhulme 2014–17) defined an
  ASCII form of the notation, FORTRAC15, and an annotation tool. No grammar,
  tool or data was found public. So this transcription cannot yet be
  compared with theirs, and should be once theirs is published.
- **Tim Robinson** has an unpublished register-transfer-level simulation of
  division from F/218, mentioned in a Plan 28 blog post of February 2025.
  It is a later sheet; F/001 and F/002 have no published reading found.
- Nothing here is claimed as new until both have been asked.

## What would move it

The most likely to help are the later cycles of F/001 and its second sheet,
F/002 (216/303–305). Cycle 2 already differs (digits 0 0 2 1, "lowered upon
0."), and the differences between cycles may show what the unexplained
marks do. Next after that are the Sketch Book volumes of 1835 (BAB/S/1/13
is a candidate for "S.B. Vol 1") and the BAB/A drawings of early 1835.
