# Three versions of one program: L/017, L/025, L/018

Babbage wrote the same program three times: the coefficients B6,8 to B6,18
of the elliptic radius vector, each from the one before by a ratio of two
polynomials stepped by their differences, in 29 operations.

| Sheet | Date | What the sheet says of itself |
|---|---|---|
| L/017 | 1 Oct 1838, ink | "No 17" |
| L/025 | undated, pencil | "Algebraic Notation" |
| L/018 | 9 Aug 1841, ink | "Copied from Not. No 17 Dated 1 Oct. 1838" |

The mill column is the same in all three, row for row. They differ in how
each one keeps its numbers, and in their slips. The question here is what
those differences do when the program is run as written, with the machine
never taking the sheet's value. `babbage L017 --strict` runs it that way.

## Run as written (strict)

| | B6,8 | B6,10 to B6,18 | Statements that agree, strict |
|---|---|---|---|
| L/017 | right | all five wrong | 84 of 127 |
| L/025 | right | all five right | 89 of 93 |
| L/018 | right | all five wrong | 73 of 91 |

"Right" means equal to the value the cover's formula gives for that
coefficient.

**L/017: a number lost.** Operation 1 divides P0 by Q0 and gives Q0 back to
no column. Operation 4 then reads Q0 from v6, which by then is at zero. Run
as written, the machine adds ΔQ0 to 0, and every Q after that is short by
Q0 = 168. Q1 comes out as 344 instead of 512, and every B after B6,8 is
wrong: B6,10 = (540/301)B6,6 against the right (135/112)B6,6. The sheet's
own composition of B6,10 writes (168 + 344), so the right number was in
Babbage's working but not in the program.

**L/025: the same fault, avoided.** P0 and Q0 are each in two columns from
the start (v1 and v2; v5 and v6), so the division at operation 1 uses one
copy and Q0 is still there at operation 4. All six Bs are right. Its four
disagreements all come from row 5, which writes B6,10 one row early into
two columns. That is a slip in the table, not in what the machine computes:
row 6 gives the same columns the right B6,10.

**L/018: the fault mended another way, and a new one made.** The fair copy
"from Not. No 17" mends the lost Q0 differently from L/025: operation 1
gives Q0 to a second column. But rows 5 and 6 carry each other's signs, ×
where the division P1/Q1 should be and ÷ where the multiplication should be.
Taken as the operation cards, that makes P1·Q1 = 184320 instead of P1/Q1,
and every B from B6,10 on is wrong. Row 20's "ΔQ2 + ΔQ2" for ΔQ2 + Δ²Q2 is
in the mill column only; the columns hold the right numbers, so it changes
nothing.

## What can and cannot be said

- The three versions handle the lost Q0 in three ways: not at all (L/017),
  a second column from the start (L/025), and a copy at operation 1
  (L/018). Two different mendings of one fault is what correcting a program
  looks like. But neither later sheet says it is correcting anything.
- L/018 is a fair copy written nearly three years after L/017. It mends
  L/017's fault and adds one of its own, in the signs of two operations.
  Whether that sign slip would have reached the cards cannot be known from
  the sheet: the table may be the only place it was ever made.
- L/025's place in the order is not settled. It is undated and in pencil.
  It mends the fault differently from L/018, so the copy in L/018 was not
  made from L/025's arrangement.
- These are readings of transcriptions no person has yet checked against
  the scans. The slips above should be confirmed on the manuscripts before
  anything is built on them.
