# The machine's capabilities against Babbage's history sheets

Babbage kept a "history" of the Analytical Engine: one ruled sheet a year,
a row for each month, columns for the parts of the machine (Addition,
Carriage, Stepping, Counting, Selectors, Groupings, General Plans, Barrels,
Miscellaneous Contrivances, Notations, Division, Principles). BAB/N/001 to
N/008 cover September 1834 to December 1841. They are transcribed in
`sources/notes/N001.md` to `N008.md`. Coding agents made the transcriptions
from the scans; no person has checked them.

The back of the 1834 draft (223/667) gives the key to the numbers in the
cells: "Figures after the description denote the day of the month", and
"Figures at the end of each column denote the number of the drawing or
notation referred to".

## Method

`history/chronology.txt` sets each capability the engine has
(`src/history.rs`) against the entries that bear on it. Every entry is
quoted, with its source and date. Each entry is one of three kinds:

- **conceived**: the idea is recorded, with a notebook page or nothing.
- **designed**: the entry gives the number of a drawing.
- **revised**: a later change to how the capability is done.

Each entry is also marked by how closely it bears on the capability:

- **direct**: the entry is about the capability itself.
- **related**: the entry is about something the capability depends on or
  belongs with.

"Used" is not taken from the history. It is the first sheet of Series L
whose run needs the capability (`babbage uses`). So the four dates, from
conception to revision, come from two independent records: what Babbage
wrote down about his machine, and what his programs needed of it.

`babbage history` prints the four dates for each capability.
`babbage history pages` gives, for each dated page, how each capability it
uses stands against the record before that date:

- **recorded**: the history sheets have the capability by then;
- **related only**: they have only something related to it by then;
- **used before**: an earlier sheet already uses it;
- **first here**: this sheet is the first evidence of any kind;
- **same month**: the history records it in the same month and gives no
  day, so the order cannot be told.

`babbage history pages --as-of 1837-08-04` asks the question the other
way: given the machine as evidenced by a date, which pages need something
it does not yet have? A capability counts as there if the history sheets
record it directly by that date, or a sheet dated by then uses it. On 4
August 1837, for example, L/023's loop is there (recorded in March 1836),
but its letter cards are not (first recorded in November 1837).

Nothing is enabled or disabled by date. The engine runs every page on the
same rules, and the report says where the record and the programs stand
against each other.

## What it shows

| Capability | Recorded | First used | |
|---|---|---|---|
| Table of multiples kept | "Plan of Mult. by Table" 12 Mar 1835 | L/001, 4 Aug 1837 | record first |
| Repetition | "To repeat an Opn any variable No of times" 7 Mar 1836 | L/023, 7 Jun 1838 | record first |
| Two sets of cards (letter cards) | "Two sets of variable cards … for Comb. Analys." 18 Nov 1837 | L/023, 7 Jun 1838 | record first |
| Combinatorial cards | "Combinatorial Cards" 11 Dec 1837 | L/023, 7 Jun 1838 | record first |
| Card backing | Sketch Book Vol 3 pp 161–162 (Dec 1837): one backing card "ineffective if the combinatorial wheels have run up", another that "always orders the backing" | L/023's Y and Z, 7 Jun 1838 | record first, by six months. The history sheets name a "Card backing App." only in Feb 1839. |
| Many numbers added at once | "Principles of Compound Addn" Jul 1838 | L/011, 28 Aug 1837 | program first, by 11 months |
| Complement apparatus | "Selecting App. for number and Comp." Dec 1839 | L/001 No. 2, 5 Aug 1837 | program first, by over 2 years |
| Sign changed | "Order to Mill to give out the Result of any opern with its sign changed" Jun 1840 | L/020, 31 Jul 1840 | record first, by a month |

- **The order runs both ways.** Some capabilities were written down long
  before any program used them: repetition by more than two years,
  multiplication by table by more than two, the backing of L/023 by six
  months (in the Sketch Book). Others appear in a program first: compound
  addition and complements, as far as the record read so far goes.
  So the first surviving evidence of a capability is not its date of
  invention, in either direction.
- **A slip that was not.** L/020's last operation, "−e/∂ = z", had been
  counted as a slip, because neither order of its operands gives −e/∂. The
  history for 1840 records, in June, the order to give out a result with its
  sign changed. With that rule (rule 32), L/020 agrees in all 148
  statements, and a strict run of it solves its equations.
- **The notations are not in the history.** The Notations column is empty
  for every year from 1834 to 1841, except one entry: "Division by
  Stepping up to top of Engine" (November 1840). Elsewhere the sheets record
  "Notation for Div.n" (February 1835, on the draft) and "Notation of
  Formulæ" (August 1836). None of the 27 Series L programs of August 1837
  to 1841 is recorded. The history follows the machine's design. It does
  not follow its programs.
- **L/023 was written to a scheme already worked out.** The history
  sheets alone made it look as if L/023's backing came eight months before
  it was recorded. That was wrong. The Sketch Book, which the history
  sheets cite, has the scheme in December 1837 (pp 161–162). There the
  combinatorial wheels sit "on the counting carriage axis", not in the
  store. One card backs the operation cards unless the wheels "have run
  up" (L/023's Y), and another "always orders the backing" (Z). The
  numbers have "their first difference constant" (L/023's Tab and Δ′). L/023
  (7 June 1838) carries out that scheme, and its table already says "Gear Z
  with prism". See `sources/notes/codesign-L023.md`. The lesson for the
  method: the history sheets are an index, not the record, and a "used
  before recorded" result holds only once the pages they point to have
  been read.

## Not settled

- The history sheets are Babbage's own summary, written up later. The
  1834 draft covers 1834–1836 and the 1837 draft covers 1837–1838, each
  marked "Copied". They are not a complete record. An entry's date is when
  Babbage placed it, not necessarily when the idea first came.
- Whether an entry is direct or only related is a judgement made here,
  shown in the file. The quotations are there so it can be checked.
- Several capabilities have no entry at all: reading to zero, transfers,
  copies, give off and retain, moving a number during an operation, the
  store as a difference engine. Their only evidence is the programs.
- Six pages are undated (L/006, L/014, L/024, L/025, L/026, L/027) and are
  not placed.
