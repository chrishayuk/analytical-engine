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

## Given off and retained; the cards

`G.R` (BAB/L/016, "give off & retain") or `0 x` (BAB/L/019, L/020: a 0
above, the letter below) is a column that gives its number to the mill and
keeps it. `Cx 0` is the complement on its way back, in the column it passes
through. After a row, `Cards (v7 v17)(v3 0)(v17 v7)(0 v18) 4` is the sheet's
list of variable cards (0 for the mill) and their count, which the run
checks against the pairs it moves numbers by; `Carried 136`, `Group` and
`Total 12 148` are the sheet's counts, a group's and the running total;
`Running 98` is a running total alone.
`C` is the complement before a letter, a bracket or a point, and otherwise
the letter C.

## Turns of the store

BAB/L/008 to L/012 work the store as a difference engine with three
carriages, `Car1` to `Car3`. A row is a `Turn`: its number, what is done in
order, and the cells the sheet writes.

```
Wheels 3
Turn 2  | Car1 = Car1 - v2, v7 = Car1, Car2 = Car2 - v2 | Car1 995, Car2 997, v2 0, v7 995
Turn 3  | Car3 = Car2, v8 = Car2, Car1 = 0, Car2 = 0    | Car1 -0, Car2 -0, Car3 997, v8 997
```

A store column an action takes a number from is left at zero after the turn
unless the turn gives it one; a column given a number need not be at zero.
`Wheels 3` puts the page on three-figure wheels, where `C(x)` is 1000 − x;
with no `Wheels`, in letters, `C(x)` (or the sheet's `C.x`) is −x. `Δ²M`,
`ΔM0` are names. `Let M1 = M0 + ΔM0` defines a name the sheet uses, so that
its cells can be checked against what the name means; `Gives 4 v8 = C(T1)`
is the sheet's statement of what a column holds after a row. A `Turn 0` is
not counted.

## A looped program

BAB/L/023 (7 June 1838) is written as the run of its cards. The page gives
the cards; the engine runs them, and each `Op` row is checked against the
card that comes up in its place.

```
Deck make     + | v2 = v2 + v1, v3 = v2, S = 0
Deck formula  × | P = Γγ
Deck formula  + | S = S + P
Deck use      − | v3 = v3 - v4
Back Y after use to formula unless v3 = 0
Back Z after use to make
Letter Great Γ = A B C D at v2 - v3 towards D
Letter Small γ = a b c d at v3 - 1 towards a
Result S at Z
Time 100 results = 252.5 hours, a minute for each card of formula use

Op 13  ×  | Ac          |            |
  Moves Great back 1, Small back 2
  Backing Y "gear"
```

A `Deck` line is one card of a group: its operation, then what it gives, in
order, to columns or to names. The first of these is what the mill shows.
The groups run in the order they first appear. After the last card of a
group, the first `Back` named for that group that applies sends the cards to
the start of another group. A `Back` with `unless v3 = 0` does not apply
while v3 holds 0. If no `Back` applies, the next group follows.
A `Letter` row of cards stands at the place its expression gives (counting
from 0), and a card names the letter showing by the row's name (`Γ`).
Under an `Op`, `Moves` is what the sheet writes in the letter-card columns,
checked against how far the cards go between the letters they show.
`Backing` holds the words in an apparatus's column. The word `back` is
checked: the apparatus backs the cards at that row, and every backing the
run makes must be written. Other words, such as gear and ungear, are shown
but not run. `Result S at Z` makes S's value a result each time Z backs, and
the `Find` lines are checked against those results in order. `Time` runs the
cards, counting only, until there are so many results, and checks the hours
at a minute for each card of the groups named.

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
