# The notation

A `.bab` page is one table of one of Babbage's sheets, written cell for cell.
A line is a directive word and what follows it. `%` starts a note (at the
start of a line, or after a space). Accents are written `'`: `b'` is b′,
`v1''` is v₁″. `·` or `.` multiplies, and so does writing two things side by
side, as on the sheet: `b'a` is b′ × a.

## What the page is

```
Sheet BAB/L/001
No. 1
Date 4 Aug 1837          "No 1. 4 Aug 1837."
Title "Elimination between two equations of the first degree …"
Image 222/594 upper table
```

`Image` is the Science Museum Group image the table is read from (the
`222/594` part of its zoom path). Words in `"…"` at the end of a line are the
sheet's own words, quoted.

## The problem

```
Letters a b c a' b' c'
Unknowns x y
Equation a x + b y + c = 0
Equation a' x + b' y + c' = 0
Find x = (bc'-b'c)/(b'a-ba')
```

`Letters` are the page's letters: every value is a rational function of
them, held exactly. `Equation` and `Unknowns`, where the sheet states the
equations, let the run solve them independently and check that the results
solve them. `Find` is a result as the sheet states it.

## The store

```
Store v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'
Working v7
```

What each variable holds at the start, and the working variables the table
uses.

## The operations

```
Op 1     ×  | b'a     | v1 0, v5 0, v7 b'a    | v7 = v5·v1
Op 7  *  ÷  | (bc'-b'c)/(b'a-ba') | v1 0, v3 =x, v4 0 | x = v3'' = v4'/v1''
Op 8        |         | v1 a, v8 0            | v1'' = v1 = a
```

Four fields, separated by `|`:

1. The number of the operation; `*` where the sheet stars it; the operation
   (`×` `÷` `+` `−`), or nothing for a row with no operation (a transfer).
2. The "variables in Mill" column: the value the operation makes, in letters.
   Empty if the sheet writes nothing.
3. The store cells the row writes, `vN value`, in any order. `0` is a column
   the row leaves at zero (read). `=x` names the result. `Ca` is the
   complement of a.
4. The right-hand column: `[name =] variable-written = formula [= letters]`.

A cell the sheet leaves empty is not written.

Numbers given to the store from outside the table, between operations (the
sheet's "Calculate f(1) f₁(1)"), are an `In` line: `In v1 f1, v2 g1`. They
are not an operation; each column must be at zero.

## Checked statements

```
Composition x = v3'' = v4'/v1'' = (v2'-v1')/(v7-v3') = … = (bc'-b'c)/(b'a-ba')
States great 5, small 2, total 7, variables 6, working 1, occupied 7
```

Each `=` of a `Composition` says the members either side of it are equal, so
each member is checked against the one before it (one slip in a chain is one
disagreement). A composition ending `= 0` is a chain of equations, as on
BAB/L/004: members then agree if one is a multiple of the other by a factor
free of the `Unknowns`. `States` are the counts
the sheet gives: `great` (× and ÷), `small` (+, − and transfers), `total`,
`variables` (the store's starting variables), `working`, `occupied`.

## Kept, not run

```
Remark "It at first appeared that …"
Unrun "pencil, right of the counts: '6 Mult = 18 …'"
```

## What the run checks

For each operation:

- each operand is to hand: in a column the row leaves at zero, or (for the
  multiplicand of a multiplication) in the table still standing in the mill;
- every column the row leaves at zero goes somewhere: to the mill, or to
  another column as its complement;
- the operation on its operands gives the formula on the right; the mill
  column; every store cell (a complement must be of a number read in that
  row); every name;
- the variable written carries as many accents as numbers it has now held;
  every accented name in a formula is looked up in that variable's history.

Then the page: each `Find`, the solution of the `Equation`s, each
`Composition`, each `States` count, and that the variables used are those
declared.

`babbage decisions` lists the rules of the machine and what each rests on.
