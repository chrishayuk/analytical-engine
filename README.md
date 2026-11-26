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

Eleven sheets read, 4 to 29 August 1837. Run by the engine, eight sheets and
eleven programs: **BAB/L/001** (Nos. 1 and 2, 4 and 5 August), **BAB/L/002**
(14 August), **BAB/L/004** (three programs, 16 August), **BAB/L/005**
(16 August), **BAB/L/006**, **BAB/L/007** (before 22 August) and
**BAB/L/011** (two programs, 28 August): 642 statements checked, 637 agree
(`babbage verify`). **BAB/L/008, L/009 and L/010** (20 to 23 August) work the
store as a difference engine with "carriages", which the engine does not yet
model; each is checked figure by figure by a short script instead
([`sources/checks/`](sources/checks/)), 276 of 279 figures agreeing.
**BAB/L/012** (29 August), carriages beside the mill, is transcribed and not
yet checked. BAB/L/003 has no images in the Museum's catalogue; Rojas 2017
lists its program as not in the archive.

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

## What reading BAB/L/008 to BAB/L/012 found

- **The store becomes a difference engine.** L/008, L/009 and L/010
  tabulate n² + 2n + 3, n³ and n⁴ with no mill at all: three-figure columns,
  complements written as numbers (994 for 6), and three "carriages" that
  accumulate and pass their figures on. Each value takes the number of
  operations the cover gives (six for n³: "Each value of n³ takes six
  operations"; 2m for n^m on L/010), and the columns alternate between
  plain numbers and complements from one value to the next, as L/010's cover
  says. Every figure of L/008 (60) and L/009 (95) agrees; L/010 has two
  slips in its last block, a transposition (320 for 302) and 469 for 369,
  neither of which reaches T₄ = 256.
- **L/011 runs a recurrence twice.** u(z+1) = f(z)u(z) + f₁(z) and the
  three-term u(z+2), each written out for z = 0 and 1, with "Calculate f(1)
  f₁(1)" between: 22 of 22 statements agree. A faint pencil draft lays
  complements and marks each group with ">", as L/002 does.
- **L/012 joins the two.** The store's carriages step M and N, quadratics in
  k, by differences, and the mill does the two great operations of each
  cycle of twelve, as the cover says ("Twelve Operations are required for
  each value of P. Two Great and Ten Small"). How its columns v1 and v9
  receive M and N from a carriage is not settled by any single rule yet.

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

- The other 26 sets of Series L, in date order: L/004-L/007, L/015, L/016,
  L/019-L/022 are elimination (three, four and five equations); L/008-L/010
  tabulation by differences; L/002-L/003 and L/013-L/014 coefficients of
  polynomials and series; L/017-L/018 the elliptic radius vector.
- What rules each needs beyond BAB/L/001's, and when each first appears.
- Series F, where the catalogue says earlier "user program traces" are found
  among the earliest notations, for anything before 4 August 1837.
- Liu Hui and Babbage on the same equations: the counting board of
  [nine-chapters](../nine-chapters) and these tables, run on the same
  systems, operation for operation. Still to be made.
- A literature search before any result is called new.

## Licence

Apache-2.0, for the code and the transcriptions. The scans belong to the
Science Museum Group and are not included.
