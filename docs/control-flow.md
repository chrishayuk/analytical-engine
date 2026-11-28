# Babbage's control flow, 1836–1838, from his own pages

What did Babbage specify for repeating and choosing, and what does that
let a program express? The sources are his Sketch Books (BAB/S/1/02 and
S/1/03), transcribed in `sources/notes/sketchbooks-control.md` and
`sources/notes/codesign-L023.md`. No person has checked those
transcriptions. Some pages were read at full resolution and some from
previews; the notes say which. Dates are those written on the pages,
unless marked otherwise.

## What he specifies, in his words

| Date | Where | Primitive | His words |
|---|---|---|---|
| 1 Mar 1836 | Vol 2 pp 80–81 | a counted repetition ended by a stop on a counting wheel | "The barrel then backs to −1 and steps up again … These alternations are continued q−d times when stop of q−d counting wh." |
| 7 Mar 1836 | Vol 2 p 84 | a variable count put on an axis, unity subtracted each time, the operation ended by a running up | "When any operation is to be terminated after a given variable number of repetitions, let the number of rep.ns be put on an axis having a carriage connected with it. Then by a register axis subtr.g unity previous to each operation a running up will take place at end and thus the op.n be suspended" |
| 22 Mar 1836 | Vol 2 p 94 | a choice between two cycles on the sign of a difference | "If in 5 q−p runs up A will be moved and cycle Neg. be put in gear. If it do not run up then A must be thrown out of gear and B into gear." (figure: "Pos. Cyc / q−p > 0", "Neg. Cyc / q−p < 0") |
| 30–31 Jul 1836 | Vol 2 pp 178–179 | several sets of cards, one before the other, the first passing a counted number of times | "Two or three sets of cards one before the other" (history); the first set passes once, twice, three, four times and backs |
| Nov 1837 | Vol 3 pp 143–155 | orders that depend on a running up, three ways | step down / no stepping / step up |
| Dec 1837 | Vol 3 pp 161–162 | combinatorial wheels on the counting carriage axis; numbers put on them from cards or computed; a conditional and an unconditional backing card | "Any numbers may be transferred from the combinatorial cards to the combinatorial wheels"; "a card … which orders the backing of operation cards … but, this order becomes ineffective if the combinatorial wheels have run up"; "another card … which always orders the backing"; "The numbers put on combinatorial wheels (usually having their first difference constant) may be computed by the constant part of formula cards" |
| Dec 1837 | Vol 3 p 158 and insert | backing orders with counts ("Back 4 add 2"), a table of combinatorial backing | — |
| 13 Mar 1838 | Vol 3 reverse p 60 | an operation that goes on as long as variable cards supply numbers | "The Oper.n cards order a certain oper.n — say Add.n which goes on as long as variables are supplied; the last variable card calls into action the operation card which orders Sub.n or Give off &c" |
| 30 May [1838] | Vol 3 reverse p 75 (year inferred) | six groups of cards; three backing wheels, each governed by a combinatorial card and set to back any number of cards | "Last card is combin.l and orders backing but if running up in Combin.l Axis occur this order is destroyed"; "There are to be 3 wanting tooth wheels each of which can be set to back any No of cards" |

**Not found in the pages read:** a card that chooses between two groups of
cards according to a number computed in the mill.

## Against the L/023 interpreter

L/023 (7 June 1838) is the one program that uses these primitives. The
engine runs it from its cards (`src/loops.rs`). The engine's model agrees
with Babbage's scheme in what it does. Where it differs, it follows the
sheet's table rather than the Sketch Book's mechanism:

| | Babbage (Sketch Book) | The engine (as L/023's table writes it) |
|---|---|---|
| The counter | wheels on the counting carriage axis, not in the store | Comb, a store column (v3). The sheet's own remark says it "ought not to be in Store but on Prisms" |
| Counting down | "unity is subtracted from the combinatorial wheels" | a subtraction card in the mill, Comb − Const |
| Setting the counter | numbers "transferred from the combinatorial cards", or "computed by the constant part of formula cards" | the make card: Tab + Δ′, then Comb = Tab |
| Conditional backing | a card in the sequence, "ineffective if the combinatorial wheels have run up" | `Back Y after use to formula unless v3 = 0`, a declaration after a group |
| Unconditional backing | a card that "always orders the backing" | `Back Z after use to make` |
| How far to back | to "0 or their commencing point"; later, wheels "set to back any No of cards" | to the first card of a named group |

The engine's general "unless a column holds a value" is wider than
Babbage's condition, which is only the combinatorial wheels running up.
L/023 uses only that one condition. To bring the model to the Sketch
Book's form, backing would become a card in the sequence, and the counter
would get wheels of its own outside the store. This is not done yet. It
would not change what L/023 computes.

## What the scheme can express

Kept apart: what Babbage specifies (S), what follows from it (F), and what
would need something not found (N).

- **Repeat a group a given number of times.** S (1836, 1837).
- **A count that varies, from cards or computed.** S. Counts come "from the
  combinatorial cards" or are "computed by the constant part of formula
  cards". So a count can depend on data computed before the loop starts.
- **A loop inside a loop.** One counted group (or several in sequence)
  inside an endless loop: L/023's Y inside Z, Dec 1837's two backing cards,
  and the 30 May 1838 plan's groups 3 and 5 inside 6. Counted inside
  counted is not found: there is one combinatorial axis, and every count is
  set before the group it counts (`docs/expressiveness.md`, section 2). An
  earlier version of this page said "two levels" and "suggests three";
  that is withdrawn.
- **Repeat for ever.** S: the card that "always orders the backing". L/023
  never stops of itself; its table ends partway through the fifth
  coefficient.
- **Stop when the data say so.** In the mill, S: a running up on the sign of
  q − p chooses the positive or the negative cycle (22 March 1836). On the
  cards, only the counter's running up ends a repetition. An addition that
  "goes on as long as variables are supplied" (March 1838) ends when the
  variable cards run out, which is again a count fixed beforehand. N: a
  backing order cancelled by a running up of a number computed in the
  loop.
- **Choose between alternative groups of cards.** N in the pages read. The
  choice of 22 March 1836 is between mechanical cycles inside one
  operation, not between groups of operation cards.
- **General computation.** See `docs/expressiveness.md`, which runs these
  primitives as a machine and proves the bounds in Lean. What a halting deck
  can compute depends on where a repetition count comes from, which the
  pages do not settle (`semantics.md`, rule 3a):
  - **counts from number cards only** (hypothesis `ConstReps`): every number
    is bounded by a tower of exponentials of fixed height, so 2↑↑n is not
    computed for every n (`no_tetration`), and these decks do not compute
    every primitive recursive function;
  - **counts read from the store**, as `src/sketch.rs` reads 7 March 1836:
    `tower-halting` computes 2↑↑n for every n in the December 1837
    configuration (`tower_halts`), and 2↑↑↑n is not computed
    (`no_pentation`).

  Either way the dated configurations fall short of general computation.
  Going further needs a count set inside the group it counts, so that a loop
  can end on a number it has computed (argument E, `Minsky.lean`). No page
  read gives it. That is N, and it is the point at which a claim of full
  generality for 1836–1838 would go beyond the record. *(Corrected 28
  November 2026: this paragraph first gave only the number-card bound, as if
  it held generally.)*

  The mill's own control is a separate matter: on 22 March 1836 a running
  up of q − p chooses between two barrel cycles inside one operation
  (`docs/c1836-control.md`). Whether that cycle's end depends on a number it
  computes is not settled by the page, and nothing read connects it to the
  cards.

These are modern categories applied to his specification. They describe
what the primitives allow, not what Babbage said about them.

## What to read next

- Vol IV p 12, 25 June 1839, at full resolution: "the running up or non
  running up must turn a card over before it acts" may be a mill result
  acting on a card.
- Vol 3 pp 143–155 (Nov 1837) in full: the three-way orders on running up
  are the nearest thing to a choice, and were read only partly at full
  resolution.
- Anything after May 1838 on how a running up in the mill reaches the
  cards: that is what generality turns on.
