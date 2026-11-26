# babbage

Charles Babbage's *Notations of calculations for the Analytical Engine*
(Science Museum Group, the Babbage Papers, series BAB/L: "27 sets of
notations consisting of 36 sheets", 1836-1840), run as he wrote them. Each
table is transcribed cell for cell from the scans; each operation is done on
a model of the engine as the sheets of its date show it; and every number
the sheet writes (each store cell, each mill entry, each formula and the
accents on its variables, each line of the "Composition", each count of
operations and variables) is checked against what the operation does.

```
$ babbage no L001-1
BAB/L/001  No. 1, 4 Aug 1837
  1   ×  v7 = v5·v1             table of b′ made; v1 v5 → 0; v7 = ab′          ✓ 4
  2   ×  v1' = v5·v3            table of b′ standing; v3 → 0; v1 = b′c         ✓ 4
  3   ×  v3' = v2·v4            table of b made; v2 v4 → 0; v3 = a′b           ✓ 4
  4   ×  v2' = v2·v6            table of b standing; v6 → 0; v2 = bc′          ✓ 4
  5   −  v4' = v2'-v1'          v1 v2 → 0; v4 = bc′ - b′c                      ✓ 4
  6   −  v1'' = v7-v3'          v3 v7 → 0; v1 = ab′ - a′b                      ✓ 4
  7 * ÷  x = v3'' = v4'/v1''    v1 v4 → 0; v3 = (bc′ - b′c)/(ab′ - a′b)        ✓ 5
…
42 statements of the sheet checked: 42 agree, 0 do not.
```

Values are held as algebra in the sheet's own letters (a, b, c, a′, b′, c′),
exactly, and compared by cross-multiplying, so a check holds for every value
of the letters. `--at a=2,b=3,…` shows the same run on numbers.

This is not an emulator of the Analytical Engine. It is a reading of the
sheets: what each row says the engine did, whether doing it gives what the
row writes, and what the engine must have been able to do for the rows to be
right.

## Status

Every sheet of Series L that has images, BAB/L/001 to BAB/L/027 (L/003 has
none; Rojas 2017 lists its program as not in the archive), 4 August 1837 to
9 August 1841: 35 pages, of which 33 run and two are prose or a drawing of
the store (L/016 sheet 2, L/027). One of the 33 is the looped program of
L/023: the engine runs its cards. Of 2672 statements of the sheets the run
checks, 2623 agree (`babbage verify`). The 49 that do
not come from slips of the pen on 14 pages, each described on its page and
counted in `tests/corpus.rs`; none stops a run.

Those figures are for a run that, where the sheet and the run differ, goes
on with the sheet's value, so one slip is one disagreement. `babbage verify
--strict` never does. The run keeps its own value, and an operand that is
not where the sheet says it is comes from the column as it actually is. So
what a slip causes later is counted too. Strict, 2535 of 2675 statements
agree (a strict run checks three more). The disagreements are on the same
14 pages and no others. Of the 12 pages that state equations the run can
solve, eleven reach the solution on the machine's own values. One ends with
a wrong answer: L/001's back, from −v3″−v5″ at operation 12. L/020's last
operation, −e/∂ = z, once counted as a slip, is the mill giving out e/∂
with its sign changed, which Babbage's history sheet for 1840 records in
June, the month before (rule 32). On pages without equations, slips carry
wrong values forward in L/017, L/018 and L/024's second sheet. For the
three versions of the elliptic radius vector, see
[`docs/revisions.md`](docs/revisions.md): run as written, L/017 and L/018
get five of their six coefficients wrong, for different reasons, and L/025
gets all six right.

The transcriptions were made by coding agents from the scans; no person has
checked them. Two readings by Rojas (2017, 2023) have been read and a short
search made, so nothing here is claimed as new. See
[`docs/literature.md`](docs/literature.md).

## What running BAB/L/001 found

- **The sheet holds two programs, not one.** Its cover lists No. 1,
  "4 Aug 1837", elimination of x (7 operations, 7 variables), and No. 2,
  "Aug. 5", elimination of x and y (13 operations, 9 variables), each with
  its own counts. The opened sheet has No. 1 above, No. 2 below. Rojas
  (2023) describes the 13-row table as part of one program of 4 August.
- **123 statements; 122 agree.** No. 1: all 42. No. 2: 80 of 81. Every store
  cell, every mill entry, both compositions (including No. 2's expansion of
  y through −cb′a + cba′ − c′ba + cb′a), x and y as stated, the solution of
  the equations, and every count on the sheet and its cover.
- **Every accent is right.** Babbage's accents count the numbers a variable
  has held: v₁″ is v1's second new number. The right-hand columns and the
  compositions of the two tables name variables 53 times with accents (and
  more without), and every name is the number the run finds there. They name numbers, not
  columns: No. 2's operation 8 is v₁″ = v₁ = a, though the a that comes back
  into v1 comes from its complement in v8.
- **Operation 12 of No. 2 is the one disagreement.** It is marked "−", its
  formula is −v₃″ − v₅″, and the mill column says −c − ax. Neither c − ax nor
  ax − c is that. For the row to be right the mill must take both numbers
  negatively, which no other row of the sheet asks of it. Composition, cells
  and the y it leads to all agree once it is granted.
- **The mill keeps a table of multiples, and the sheet depends on it.**
  Operation 2 of both programs multiplies by b′ although operation 1 has left
  v5, which held b′, at zero; operation 4 does the same with b. The remark
  under No. 1 gives the reason: Babbage ordered the products so that the
  "table of b′" made for one serves the next, and rejected a saving of
  variables that "would have caused the table of b′ … to be destroyed and it
  must have been recomputed … thus causing the loss of about ten turns of the
  hand". The run makes two tables for No. 1 and three for No. 2.
- **The cards can be read off.** `babbage cards L001-2` gives each operation
  card with the variable cards it needs: which columns go to the mill, which
  receive the result, where a complement is laid, which rows are transfers.
  Given the decisions below, nothing has to be invented to do that on this
  sheet, except how the mill makes −c − ax at operation 12.
- **A pencil note does not match the table.** Beside No. 2's counts, in
  pencil: "6 Mult = 18, 1 Div = 5, 6 add = 1", total 24. The table has 5
  multiplications and 2 divisions. Unrun; hand and date unknown.

## What running BAB/L/002 found

- **68 statements; 68 agree.** Every mill entry and every store cell of the
  30 rows. The table has no right-hand column of formulas, so there are no
  accents to check, and the mill column fixes which way round each
  subtraction and division goes (rule 12 below).
- **The coefficients are right.** The run's λ0 … λ6 are the coefficients of
  (A0 + A1x + … + A6x⁶)/(a + bx), checked against the series worked out
  independently of the sheet's recurrence (`tests/corpus.rs`).
- **The program is a cycle of five.** After λ0, each λm takes the same five
  operations: bring b into v2 from its complement in v1, × bλ, −, bring a
  into v2 from its complement in v3, ÷. Only the columns of Am and λm
  move on by one each time. A mark like ">" stands beside the table at the
  start of each cycle, and pencil on the cover, faint and read only in part,
  describes the cycles in words: "1 Bring in a number 2 Multiplication
  {3} Subtraction {4} Bring in a number 5 Division gets λm … = 5 operations".
  The run counts 13 great and 17 small: 1 + 4 + 5 × 5.
- **a and b are kept only while needed.** The last division lays no
  complement of a and writes λ6 in one column only; operation 27's "Com b"
  is faint.

## What running BAB/L/004 to BAB/L/007 found

- **They run.** No. 4.1, 4.3, 5 and 6 agree throughout (7, 16, 199 and 107
  statements), including every accent of No. 5's 34 rows (written up to
  roman v) and its six compositions, and the counts on each cover.
- **The table of multiples is used more and more.** In No. 4 the quotient
  A = b′/b is made once and multiplies twice, with A in no column the second
  time; in No. 5 two tables serve three products each; in No. 7 each of
  d′/d, d″/d, d‴/d serves four. Babbage's remark on No. 4: "Had H = b′a −
  ba′, M = bc′ − b′c, 4 Multns must have been made instead of 2".
- **Five disagreements, all slips of the pen.** No. 4.2's composition writes
  v₃′ where the table puts Ac in v5 (and the next line calls it v₅′), and
  begins v₁′x + v₂″ where every later member is Hx − M. No. 7 does not write
  the 0 in v22 from which d‴/d is taken at row 22 (rows 2 and 12 write it
  for the same step), and its mill column at row 35 writes ∂′ for ∂″.
- **Complements and transfers become routine.** No. 7 lays each operand's
  complement in the column the one before it vacated, and five transfers
  after each round put a, b, c, d, e back; the last round keeps none.
- See `sources/notes/` for each sheet's cover, pencil and uncertain cells.

## What running BAB/L/008 to BAB/L/012 found

- **The store becomes a difference engine.** L/008, L/009 and L/010
  tabulate n² + 2n + 3, n³ and n⁴ with no mill at all: three-figure wheels,
  complements written as numbers (994 for 6), and three "Carriages Negative"
  that take numbers subtracted from them, are cleared ("−0") and lay their
  figures on the columns. Each turn is run by the actions the sheet's own
  right-hand column or numbered instructions state (`Turn` rows). L/008:
  66 of 66; L/009: 99 of 99; L/010: 125 of 128, two slips in its last block
  (320 for 302, and 469 for 369 twice) that do not reach T₄ = 256. Every
  starred value is right: T₁ … T₄ for each, as complements for odd n, as the
  covers say ("Each value of n³ takes six operations when n is even the
  same number of operations obtains the complement when n is odd").
- **L/011 runs a recurrence twice.** u(z+1) = f(z)u(z) + f₁(z) and the
  three-term u(z+2), each written out for z = 0 and 1, with "Calculate f(1)
  f₁(1)" between: 22 of 22. A faint pencil draft lays complements and marks
  each group with ">", as L/002 does.
- **L/012 joins the two, and runs: 124 of 124.** The carriages step M and
  N, quadratics in k, by their differences, in letters, and the mill does
  the two great operations of each cycle of twelve, as the cover says ("Two
  Great and Ten Small"); P₁ … P₄ are the cover's (M/N)·P. One thing the
  sheet does not settle: v1 and v9 receive M and N from a carriage that
  holds their complements in cycles 1 and 3 and the numbers themselves in
  cycle 2, so the transfer must complement in the one and not the other.
  The run does what the cells require; no single rule does both
  (`tests/corpus.rs`).

## What running BAB/L/013 to BAB/L/027 found

- **The products of polynomials** (L/013, 11 December 1837; L/014,
  undated). λ6 = ΣAₖa₆₋ₖ, and the first six coefficients, laid out in the
  cover's point notation ("0.6 + 1.5" for A₀a₆ + A₁a₅). L/014's second table
  orders its 21 products by Aₖ, so that six tables of multiples serve them
  all; each a is read again and again from its complement. L/013's second
  table is unfinished on the sheet. Nothing on L/014 mentions cosines,
  which are only in the catalogue's title, as Rojas says.
- **Elimination, 1837 to 1840** (L/015, L/016, L/019 to L/022). L/015
  eliminates by cross-multiplication and needs the mill to keep the table of
  the factor written second (HK′, then MK′ with K′ in no column). L/016
  (June 1838) brings in "G.R", "give off & retain"; by 1840 (L/019 to L/022)
  every number kept is given off through a complement column and back, and
  every operation has its variable cards listed beside it. All 136 cards of
  L/019, the 225 of L/019–L/020 and the 142 of L/021 agree with the run,
  with their counts and running totals (L/021's first total is written 48
  for 49). L/021 and L/022 move each new coefficient into the column its
  multiplier left, so that the reduced equations stand as the first ones
  did, and the same pattern of cards serves again.
- **The elliptic radius vector** (L/017, 1 October 1838; L/025, pencil,
  undated; L/018, a fair copy dated 9 August 1841 "from Not. No 17"). The
  same 29 operations three times. L/017 fails to keep Q₀, which L/018 and
  L/025 put right; L/018, the fair copy, swaps the signs of rows 5 and 6
  and writes ΔQ₂ + ΔQ₂ for ΔQ₂ + Δ²Q₂, slips L/025 does not have.
- **The looped program** (L/023, 7 June 1838). The product of two series
  by combinatorial cards: an inner loop backed by Y to the formula cards, an
  outer one by Z to the start, the letter cards advanced and backed, and a
  counter stepped by its difference. The page gives the cards and the
  engine runs them as a loop. All 123 of the sheet's statements agree with
  what the cards do: the 35 rows, every letter-card move, every backing of
  Y and Z, the four results, and the NB's 252·5 hours for 100 terms.
- **Recurrences** (L/024). Laplace coefficients by Pₓ₊₁ = (Wₓ/Vₓ)Pₓ and a
  three-term recurrence: 113 of 123, four slips of the pen.
- **One formula two ways** (L/026, undated). (ab + c∂)/(a + c) and
  b + (∂ − b)c/(a + c), in five operations each, with no 0, no complement
  and no accent: each number going to the mill is marked with an arrow and
  every column keeps its number. Both give the same x (58 of 58).
- **The store drawn** (L/027, undated). Columns of figure wheels with a sign
  wheel above each, laid out for the variables of many problems, and, on
  the cover, a product split into heads and tails of thirty figures each.

## What Babbage's history sheets show

BAB/N/001 to N/008, the yearly "history" of the engine from 1834 to 1841,
are transcribed in `sources/notes/N001.md` to `N008.md`. Each capability
the engine has is set against them in `history/chronology.txt`: when the
history sheets record it as conceived, designed or revised, and when a
program first uses it. `babbage history` and `babbage history pages` print
the result. See [`docs/chronology.md`](docs/chronology.md).

The order runs both ways:
- Some capabilities are recorded before any program uses them. "Plan of
  Mult. by Table" is recorded on 12 March 1835, and "To repeat an Opn any
  variable No of times" on 7 March 1836.
- Others appear in a program first. L/023's backing apparatus comes 8
  months before the history's "Card backing App.". L/011's addition of many
  numbers comes 11 months before "Principles of Compound Addn". The
  complements of August 1837 come two years before the history records an
  apparatus for them.

L/020's "−e/∂ = z", once counted as a slip, is the mill giving out a result
with its sign changed, which the history records the month before. And the
history's Notations column records none of the Series L programs.

## The machine

The engine's rules, as BAB/L/001 and BAB/L/002 show them (`babbage decisions` gives each
with what it rests on):

1. Reading a column leaves it at zero.
2. The mill keeps the table of multiples of the multiplicand until another
   operation comes between.
3. The first factor written is the multiplicand.
4. A number taken from a column may at the same time be laid in another as
   its complement (Ca, defined on the back of the sheet).
5. A transfer from one column to another complements; complementing twice
   restores. (The sheet shows Ca in and a out; the mechanism is Rojas's.)
6. A transfer does not touch the mill. (A choice; nothing here depends on it.)
7. Accents count the numbers a column has been given.
8. An accented name means that number, wherever it now is.
9. Great operations are × and ÷; small are +, − and transfers.
10. Values are compared as algebra.
11. A column is given a number only when it is at zero. (Every row of
    BAB/L/001 and BAB/L/002 obeys it; not stated on a sheet.)
12. Where a sheet has no right-hand column, a subtraction or division takes
    its operands in the order the mill column writes. (BAB/L/002.)
13. Where a sheet has no right-hand column, the first factor the mill column
    writes is the multiplicand. (BAB/L/004, BAB/L/007.)
14. A composition written as equations ("= 0") agrees up to a factor free of
    the unknowns, member by member. (BAB/L/004.)
15. An addition may take more than two numbers. (BAB/L/011.)
16. Numbers may be given to the store from outside the table between
    operations ("Calculate f(1)"). (BAB/L/011.)
17. The store can work as a difference engine with three carriages and no
    mill: a column read is subtracted from carriages and left at zero; a
    carriage's number is laid on columns, which need not be at zero; "−0"
    clears a carriage. (BAB/L/008 to L/010.)
18. On wheels of k places a complement is 10^k − x; in letters, −x.
19. A turn of the carriages is a small operation. (Covers of L/010, L/012.)
20. How a carriage gives M and N to the mill's columns is not settled.
    (BAB/L/012.)
21. A table is made of the factor the next multiplication uses again,
    whichever is written first. (BAB/L/015.)
22. A number taken from a column may be laid, as it is, in another.
    (BAB/L/017, L/018.)
23. A number may be given off to the mill and retained: "G.R" (L/016), the
    0 above the letter (L/019 to L/022), the arrow (L/026).
24. A complement read into the mill gives the number it is the complement
    of. (BAB/L/014.)
25. The variable cards are the pairs the run moves numbers by; the sheet's
    are checked against them, with their counts. (BAB/L/019 to L/022.)
26. A row may move a number while the mill operates on others. (L/021,
    L/022.)
27. Where the mill column and the operation differ and the cells follow the
    mill, the run goes on with the sheet's value: one slip, one
    disagreement. (L/018.)
28. With `--strict`, the run never goes on with the sheet's value.
29. A looped program is run from its cards. The groups run in order. After
    a group's last card, a backing apparatus sends the cards to the start
    of another group, unless its condition holds. (BAB/L/023's cover: Y to
    the formula cards, Z to the cards forming the combinatorial numbers.)
30. In a looped program, a column the cards read keeps its number.
    (BAB/L/023: no 0 under Δ′, Tab or Const.)
31. Letter cards stand at a place the store gives. The sheet's advances and
    backs are checked against the moves that requires. (BAB/L/023 writes
    the moves, not what sets them.)
32. The mill may give out a result with its sign changed. (BAB/N/007, June
    1840; used by BAB/L/020, July 1840.)

Each later sheet will be run on the rules of its own date, and a rule a later
sheet needs that the sheets before it do not show will be a new, dated
decision.

## Install and use

You need [Rust](https://rustup.rs). No dependencies.

```bash
cargo install --path .
babbage list                 # the pages
babbage no L001-2            # a page, run, every cell checked
babbage no L001-2 --store    # with the whole store after each operation
babbage no L001-2 --at "a=2,b=3,c=-8,a'=5,b'=-1,c'=-3"
babbage cards L001-2         # the program as operation and variable cards
babbage verify               # every page
babbage decisions            # the rules of the machine
babbage json L001-2          # a run as JSON, for the playground
babbage lsp                  # a language server on standard input and output
cargo test                   # every page, the tutorial, and probes that a changed cell is caught
```

**The tutorial**, [`tutorial/`](tutorial), in nine chapters, from what a
sheet is to the one disagreement; every page and command in it is run by
`cargo test` and its output compared.

**In an editor:** `babbage lsp` gives problems as you type, hover on an
operation (what it took, from where, what it made, the store after it) and
on a variable (`v3''`: the number it names), colours, an outline of the
operations and completion. A Visual Studio Code extension with `babbage`
built in is in [`editors/vscode`](editors/vscode); Neovim, Helix and Emacs
are in [`editors/README.md`](editors/README.md).

**In the browser:** [`web/`](web) runs the same program, compiled for WASI,
in the page: the mill and the columns of the store, stepped operation by
operation, the sheet laid out as Babbage laid it out with every cell
checked, and the transcription in an editor that runs as you type.
`node web/build.mjs` builds it, `node web/test.mjs` checks the WebAssembly
build against the native one, and any static server will serve it
(`python3 -m http.server -d web`). `web/playground.js` exports
`mountPlayground` and `mountRunner`, for embedding.

The notation is in [`docs/notation.md`](docs/notation.md); the sources, and
how to fetch the scans again, in [`sources/README.md`](sources/README.md);
what was hard to read in [`sources/notes/L001.md`](sources/notes/L001.md).

## Next

- Series F, where the catalogue says earlier "user program traces" are found
  among the earliest notations, for anything before 4 August 1837.
- Rojas (2021, IEEE Annals, closed access) and Bromley (1982, 2000), read
  in full, before any result is called new. See
  [`docs/literature-mechanical-notation.md`](docs/literature-mechanical-notation.md).
- Series F/001 as a pilot: one 13-unit cycle of "Multiply a, b, c, d by
  1021" (1835), read in the mechanical notation of 1826, before anything of
  Series F is run.
- A person to check the transcriptions against the scans.
- Liu Hui and Babbage on the same equations: the counting board of
  [nine-chapters](../nine-chapters) and these tables, run on the same
  systems, operation for operation.

## Licence

Apache-2.0, for the code and the transcriptions. The scans belong to the
Science Museum Group and are not included.
