# The 49 disagreements, as leads

`babbage verify` finds 49 statements, on 14 pages, where the sheet and the
run differ. Each has been called a slip of the pen. One already turned out
to be something else: L/020's "−e/∂ = z" is the mill giving out a result
with its sign changed, which Babbage's history sheet records the month
before (rule 32). So none of the rest is settled. Each is listed here with
every explanation still open.

The 49 statements come from 18 causes; one slip can make several
statements fail. For each cause, the candidates are:

- **table**: a slip in writing the table: a figure, an accent, a cell in
  the wrong row.
- **working**: a slip in the formulas Babbage wrote beside the table (the
  compositions). These are not part of the program.
- **program**: the program as written would compute a wrong result. This
  is a fault in the program, not in the writing.
- **capability**: the machine may have done something the engine does not
  yet do.
- **transcription**: our reading may be wrong. This is open for every
  item, since no person has checked the transcriptions. It is named only
  where the note records a doubtful reading.

| # | Page, row | Statements | What differs | Candidates | Leading reading | What would decide it |
|---|---|---|---|---|---|---|
| 1 | L/001 No. 2, op 12 | 1 | The sheet writes −v3″−v5″ (−c−ax); the subtraction gives c − ax | capability, table | Open. −c−ax is the complement of c, less ax; L/001's back defines the complement. It may also be −(c + ax), an addition given out with its sign changed. | Whether v3 holds c or its complement at op 12, and the back of the sheet |
| 2 | L/004 sheet 2, composition | 2 | v3′ for v3, and the sign of the constant term | working | Working | The scan |
| 3 | L/007, row 22 | 1 | d‴/d is taken from v22 with no 0 written | table, capability | Open (see below) | Nothing later uses v22 |
| 4 | L/007, row 35 | 1 | The mill writes (d′/d)b − b″; the operation gives b″ − (d″/d)b | table, capability, transcription | Open: an accent (d′ for d″) and the order. It may be a result with its sign changed, which is not recorded until 1840. | The scan (the note says the accent is plain) |
| 5 | L/010, turn 28 | 1 | v3 is written 320; Car3, the same number, 302 | table | Table: transposed figures | None needed |
| 6 | L/010, turn 30 | 2 | 469 in two cells; 194 + 175 = 369 | table | Table: an addition slip, carried into both cells | None needed |
| 7 | L/013 sheet 2, row 6 | 1 | A0a5 written into v18, which still holds Comp a4 | table, capability | Table: A0a5 written twice, in v10 and v18 | The scan |
| 8 | L/014 sheet 1, rows 5–6 | 4 | A4 and A5 taken with no 0 written | table | Table: the columns receive new numbers at once, so the numbers were not kept | — |
| 9 | L/014 sheet 2, rows 25–26 | 2 | No 0 in v14; "Comp a0" written on row 26's line | table, transcription | Table: one entry a line low | The scan |
| 10 | L/015, rows 3 and 9 | 3 | d taken from v4 with no 0; v4 then given c′d, then M | table | Table: v4 receives at once | — |
| 11 | L/015, row 29 | 2 | M″/H″ taken with no 0 in v1 or v4 | table, capability | Open (see below) | Last row: nothing later |
| 12 | L/017, row 4 | 2 | Q0 read from v6, which row 1 left at zero | program | Program: Q0 is never kept. Run strictly, five of six results are wrong. L/018 and L/025 mend it two different ways ([revisions](revisions.md)). | — |
| 13 | L/017, compositions | 7 | Accents (v16, 'v9), the heading v20, and no minus on the products | working | Working. The products are the magnitudes; the cover's recurrence has the minus. | — |
| 14 | L/018, rows 5, 6 and 20 | 3 | × and ÷ swapped at rows 5 and 6; ΔQ2 + ΔQ2 at 20 | program, table | Rows 5–6: program, if the cards were punched from the table, else table. Row 20: table (the columns are right). | Whether any card list for No. 18 survives |
| 15 | L/021, row 19 and the count | 3 | C′∂ with one accent; 48 for 49 in the running count | table | Table | — |
| 16 | L/024 sheet 1, row 17 | 3 | W3 taken from v1 with no 0 | table, capability | Open (see below) | Nothing later uses v1 |
| 17 | L/024 sheet 2, rows 6, 8, 16–18 | 7 | A 0 in v15 two rows early; b(3) for b(2) in v20; no 0 in v13 at row 18 | table, transcription | Table, but the sheet is dense and in pencil in places | The scan |
| 18 | L/025, rows 5–6 | 4 | B6,10 written a row early, in v18 and v19 | table | Table: written ahead, then again in the right row | — |

## Taking a number without a 0

Eight rows on six pages take a number from a column and write no 0 there
(items 3, 8, 9, 10, 11, 16 and the last of 17). There are two readings:

- **A slip:** Babbage left out the 0.
- **Unmarked give off and retain:** the column gave its number to the mill
  and kept it. The engine has this capability, but it is first written
  ("G.R", "give off & retain") on L/016 in June 1838.

One test separates them. If the column then receives a new number without
being read, the number was not meant to be kept, and the 0 is a slip. That
decides items 8 and 10: both are slips.

Items 3, 11, 16 and 17 cannot be decided this way: nothing later on the
page uses the column. Two of them are dated, L/007 (August 1837) and L/015
(December 1837), and both come before L/016. So if they are unmarked
retains, they put the capability earlier than its first written mark.
Nothing in the history sheets settles it.

## Leads worth following

- **Item 1** (L/001 No. 2, op 12) is the oldest disagreement, and the one
  most likely to be machine behaviour rather than a slip. Babbage defines
  the complement on the back of that same sheet. The subtraction gives
  −c−ax exactly if v3 holds the complement of c, which in letters is −c.
  Then op 12 is C(c) − ax. But op 10, which moves c into v3, writes
  "v3'' = v3 = c", and the engine's rule 5 (a transfer complements) gives c.
  If the transfer of op 10 left the complement as it was, the page would
  agree and its y would be right. That would change rule 5, which rests on
  this same page. Tested below: it does not hold.
- **Item 4** (L/007, row 35) has the shape of a result given out with its
  sign changed, three years before the history records it. The accent
  must be checked on the scan first.
- **Item 14** (L/018) bears on the debugging story: whether the swap was
  in the program or only in the table.
- **The rows with no 0** (above).

## Item 1 tested: two models of the complement

Two competing readings of L/001 No. 2, operation 12, were added to the
engine as switches. Each changes one rule and nothing else. Both were run
over the whole corpus, normally and strictly (`babbage verify
--model=…`).

| Model | Rule changed | L/001 No. 2 | Corpus, normal | Corpus, strict |
|---|---|---|---|---|
| A (as it stands) | — | 80 of 81 | 2623 of 2672 | 2535 of 2675 |
| A′ `complement-as-held` | rule 24: the mill takes a complement read as −x, not x | 80 of 81 | 2623 | 2535 |
| B `transfer-keeps` | rule 5: a transfer moves the complement as it is | 77 of 81 | 2579 | 2113 of 2287 |
| B + A′ | both | 77 of 81 | 2579 | strict L/001 No. 2 stops at op 11 |

What the runs show:

- **B contradicts the sheet it was meant to explain.** Operations 8, 9 and
  10 of L/001 No. 2 each write their result in the right-hand column:
  "v1″ = v1 = a", "v2‴ = v2 = b", "v3″ = v3 = c". Under B they bring back
  Ca, Cb and Cc. Run strictly, the machine then stops at operation 11,
  which multiplies the complement of a by x.
- **B breaks transfers on five other sheets:** L/002, L/005, L/006, L/007
  and L/015, which lose 4 to 12 agreements each in a normal run. Strictly,
  L/005 falls from 199 to 8.
- **A′ changes nothing anywhere in the corpus.** Rule 24 cannot be told
  from its alternative on this evidence.
- **Neither model accounts for −c−ax.** Under B the operand of operation
  12 would be Cc, but the sheet itself says v3 holds c.

So A stands. Item 1 remains open, as a slip or as something not yet
modelled. The one reading consistent with the sheet's own right-hand
column is that Babbage wrote the numerator of y, −c − ax, directly, and not
what the subtraction gives. The switches stay in the engine
(`--model=transfer-keeps`, `--model=complement-as-held`), so any later
reading can be set against the whole corpus the same way.
