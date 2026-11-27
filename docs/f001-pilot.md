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
| 1. The notation | Every mark transcribed as written | **Done** for all six cycles of F/001 and F/002 (below); first for the partial rows 11–13 at the top and cycle 1, rows 1–13, on both images (`sources/notes/F001.md`, `mechanical/F001-cycle1.txt`). No person has checked it. |
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

## All six cycles (F/001 and F/002)

The rest of F/001 and all of F/002 are now transcribed the same way
(`mechanical/F001-cycle2.txt` to `F002-cycle6.txt`, `sources/notes/F002.md`).
There are six cycles, numbered 1 to 6 by pencil figures in the right
margin. F/002 has no column heads of its own. Its columns are taken to be
F/001's by the ruling, which is an inference. `docs/f-concordance.md` sets
every mark against every occurrence, with hypotheses for and against, and
adopts none.

| Cycle | Multiplier (as written) | Complements | Feeder lowered upon | Marks | Unexplained | Most columns in motion |
|---|---|---|---|---|---|---|
| 1 | 1021 | 9089 | 1 | 87 | 34 | 10 |
| 2 | 0021 | 0089 | 0 | 90 | 19 | 9 |
| 3 | 0021 | 0089 | 2 | 78 | 14 | 10 |
| 4 | 0011 | 0099 | — | 61 | 17 | 4 |
| 5 | 0001 | 0009 | 1 | 97 | 20 | 10 |
| 6 | 0000 | 0000 | — | 84 | 19 | 9 |

What can be said without giving a mark a meaning:
- **The multiplier counts down.** The figures Babbage wrote on the
  multiplier's wheels go 1021, 0021, 0021, 0011, 0001, 0000 over the six
  cycles. In each cycle, a short down arrow stands beside the multiplier
  wheel and the complement wheel whose figure changed since the cycle
  before.
- **"Gears with" moves on one place.** It reads n … n−3, then n−1 … n−4,
  n−2 … n−5, and n−3 … n−6. Cycle 4 has no gearing; cycle 6 has "Put out
  of gear."
- **Babbage's own notes under F/002's table** are the only writing on
  either sheet that says what a group of columns is for. Columns 07–14
  "belong to the method of multiplying by means of Snails and feelers
  which distinguish each figure, or which have ten angular positions", and
  columns 36–52 work "without snails, and with a feeler which has only two
  angular positions". Of the complements: "The comp.ts are proposed to be
  used for the purpose of avoiding the necessity of making U[?1] move in
  two directions."
- **"IF" and the double arrows occur only at the ends:** in the rows above
  cycle 1, in cycle 1, and in cycle 6. In cycles 2–5 the same cells hold
  words ("Put in.", "Put out.", "Last."), a bare arrow, or nothing. What
  that means is not decided (`docs/f-concordance.md`).

The count down of the multiplier is written on the sheet. That the machine
adds once for each unit counted down, at the place the gearing has reached,
is the obvious reading. But it is an arithmetic reading, and the pilot does
not adopt it until the marks that would carry it out are understood.

## What would move it

With all six cycles read, the next most likely to help are the Sketch Book volumes of 1835 (BAB/S/1/13
is a candidate for "S.B. Vol 1") and the BAB/A drawings of early 1835.
