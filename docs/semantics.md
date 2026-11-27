# The control machine, frozen: what each rule rests on

This page fixes the semantics of the control machine of the Sketch Books
(`src/sketch.rs`, and its Lean model `formal/Babbage/Machine.lean`) for the
dated configurations of 1836, 1837 and 1838. Each rule is marked as one of:

- **Page**: the rule is what a page says. The page is cited.
- **Reading**: the page allows more than one reading, and this one is
  chosen. The other readings are given.
- **Idealisation**: the rule is a modern choice that no page makes.

The transcriptions cited are in `sources/notes/sketchbooks-control.md`,
`codesign-L023.md` and `vol4-control-1839-1840.md`. No person has checked
them against the manuscripts.

Frozen on 27 November 2026. A change to any rule below changes the theorems
in `formal/`, and should be made here first.

## The rules

| # | Rule | Kind | Source |
|---|---|---|---|
| 1 | Cards are taken one after another, from the first. | Page | Vol 3 pp 161–162, Dec 1837 |
| 2 | An operation card takes two numbers to the mill and puts the result in a column. | Page | L series, passim |
| 3 | One operation can be repeated a number of times put on an axis. Unity is subtracted before each operation, and the running up ends the repetition. | Page | Vol 2 p 84, 7 Mar 1836: "terminated after a given ⟨variable⟩ number of repetitions … the number of rep.ns be put on an axis" |
| 3a | **Where the repetition count comes from.** `src/sketch.rs` reads it from a number card or from a store column. | **Reading** | The page says "given variable number" and does not say where it comes from. The alternative reading, a count from a number card only, is the hypothesis `ConstReps` of the Lean theorems. The two readings give different theorems (below). Read at full resolution on 27 Nov 2026 (`repetition-count-1836-1842.md`): "variable" is a clear interlineation, and the number is "put on an axis", but the page does not say from where. Counts are taken from the operands inside a multiplication (1836). In Turin, Aug 1840 (Vol IV p 412), indices are held "on one Store axis" and given off to the card counting apparatus; how they reach the store is not stated. So the store reading has support for 1840, but none for 1836. |
| 4 | The combinatorial wheels hold one count, outside the store. A combinatorial card puts a number on them, from the card itself or from the store. | Page | Vol 3 p 161: "transferred from the combinatorial cards", "computed by the constant part of formula cards" |
| 5 | A counted backing card subtracts unity from the wheels. It backs unless they have come to 0, when its order is ineffective. | Page | Vol 3 p 161: "ineffective if the combinatorial wheels have run up"; "run up by coming to 0" |
| 5a | **When the wheels run up.** With n on the wheels, a counted group passes n times. | **Reading** | p 161 "by coming to 0". On 8 June 1838 (Vol 3 p 201) Babbage wrote "reduced to zero or to −1 (runs up)", so he had not settled it. The other reading gives n + 1 passes; no theorem below depends on the choice. |
| 6 | An unconditional backing card always backs. | Page | Vol 3 p 162: "always orders the backing" |
| 7 | In Dec 1837 backing goes only to the first card. From 30 May 1838 it goes to any earlier card. | Page | Vol 3 p 162, "to 0 or their commencing point"; Vol 3 reverse pp 74–75, wheels "set to back any No of cards" |
| 8 | **No combinatorial card among the cards a counted backing sends back over.** | **Reading** | Every arrangement found sets the count before the group it counts (Dec 1837, 30 May 1838, L/023). No page forbids the other arrangement either. Without this rule the machine is the `not-found` configuration. |
| 9 | A card that writes a result gives off the number in a column. | Page | L/023, and Vol 3 p 162 |
| 10 | Nothing chooses between cards. No result of the mill acts on a card, or makes a backing effective or ineffective. A number the mill has computed may go on the wheels, by a combinatorial card from the store (rule 4), before the group it counts (rule 8). | Page (by absence) | Menabrea (Oct 1842) and Lovelace's Note G (1843) state the contrary as a principle ("the mill will order other cards"), later than every configuration here. Read for this up to April 1842: Vol 2 pp 74–95, Vol 3 pp 137–166 and reverse 74–75, Vol IV pp 2–19, 64–67, 406–417, and F/227. The one exception is Vol IV p 12 (25 June 1839), a variant Babbage does not adopt, which concerns complementing within one long addition (`vol4-control-1839-1840.md`). |
| 11 | Numbers are exact fractions of unbounded size. | Idealisation | The engine's numbers had a fixed number of figures: 40 on Vol IV p 11 (25 June 1839), with numbers of more figures added in parts. |
| 12 | The store is unbounded. | Idealisation | The store had a fixed number of columns. |
| 13 | A combinatorial count of 0 or less, a count of 0 or less on the wheels before the first card, or a counted backing with no number on the wheels, is an error. A repetition count of 0 performs no operation. | Idealisation | The pages do not say what happens. The Lean model holds the wheels as a natural number and takes the initial state as given: wheels at 0 there are an error only when a counted backing card is reached. The Rust refuses them at once. No theorem depends on the difference. |
| 14a | **A halt is passing the last card.** An operation that fails is an error, not a halt, and nothing given off before it is an output. | Idealisation | Model D (`Trap.lean`) reads the other way: a stop at an operation the mill cannot do ends the run, with the store as its result. No text read treats such a stop as the end of a computation: in Menabrea (1842) the engine rings a bell and "stops until the attendant has again set it in action" (`menabrea-lovelace-1843-control.md`). |
| 14 | An operation that is undefined, such as division by 0, is an error that ends the run. | Idealisation | The pages do not say. |
| 15 | An input is a number placed in the store or on the wheels before the first card. | Idealisation | Babbage's numbers came in on number cards. That is the same as a deck that sets its inputs first. |

**Not modelled:** a result card that leaves its column at zero (`result … off`, which the L/023 decks use); the letters and rows of letter cards of `src/sketch.rs`,
which are used only by the L/023 decks; and operation cards that write
several columns at once. Neither changes what can be computed with numbers.

**Undecided by the pages, and not used:** whether a result of the mill can
make a counted backing effective or ineffective. No page read does (rule 10).

**Used, and given by the pages:** a computed number put on the wheels from
the store (rule 4, "computed by the constant part of formula cards"), before
the group it counts. The theorems use it in every model: "Model A" (counts
from number cards, `ConstReps`) restricts only *repetition* counts (rule 3),
never combinatorial counts. The `not-found` configuration adds only a
combinatorial card *inside* the group it counts, by dropping rule 8.

## What follows from the rules

Each line below is a theorem of `formal/` (Lean 4, core library only,
checked by CI with no `sorry`), except where marked **argued**.

| Statement | Rules used | Lean |
|---|---|---|
| A deck with an unconditional backing card never halts from its first card. | 1, 6, and backing goes back | `never_halts_from_start` |
| Under rule 8, a deck whose backing cards are all counted always ends: it halts, or an operation fails (an error, which `Ends` counts as ending). | 1, 4–8, 13 | `ends_of_counted`, `halting_dichotomy` |
| Under rule 8, **with repetition counts from number cards only**, a halting deck gives off nothing larger than a fixed tower of exponentials on its input, and so does not give 2↑↑n for every n. | all, with `ConstReps` | `out_le_tower`, `no_tetration` |
| Under rule 8, **with repetition counts from the store** (rule 3a as coded), a deck of Dec 1837 halts with 2↑↑n for every n ≥ 1. | all | `tower_halts` |
| Under rule 8, with repetition counts from the store, a halting deck gives off nothing larger than a fixed number of tetrations on its input, and so does not give 2↑↑↑n for every n. | all | `out_le_ptw`, `no_pentation`; applied to `tower-halting` in `tower_below_pentation` |
| Without rule 8 (`not-found`), a counter machine translates into a deck that halts exactly when the machine does, and gives off its counters; every configuration with rule 8 refuses that deck. | 1–7 | `compile_accepted`, `compile_refused`, `compile_halts`, `machine_halts_of_compile` |
| With counts from number cards, for every n from some point on, a halting deck gives off nothing as large as 2↑↑n. | all, with `ConstReps` | `no_tetration_eventually` |
| **Model D**, every backing card counted: the bounds above hold for every state a run reaches, a trap stop included. | all, rule 14a reversed | `reach_le_tower`, `reach_le_ptw`, `no_tetration_reach`, `no_pentation_reach` |
| **Model D**, with the unconditional backing card: a counter machine translates into a deck of 30 May 1838 that stops at a trap exactly when the machine halts, its counters in the store. | 1–8, rule 14a reversed | `trapDeck_accepted`, `trap_halts`, `machine_halts_of_trap` |
| **Model D**, December 1837 with repetition counts from the store: the same, with no combinatorial card and no counted backing. | 1–8, 3a as coded, rule 14a reversed | `trapDeck37_accepted`, `trap37_halts`, `machine_halts_of_trap37`; `trapDeck_refused_1837`, `trapDeck37_not_constReps` |

Both whole numbers (`intSized`) and exact fractions satisfy the size
condition of the growth theorems. For fractions, size is the larger of
|numerator| and denominator (`ratSized`, `no_tetration_rat`,
`no_pentation_rat`). The fraction results, and `intSized`'s case for ÷,
rest on core Lean lemmas about `Rat` and `Int` division that use the axiom
`Classical.choice`. The generic theorems do not.

**Lean against Rust.** `scripts/lean-diff.sh` (in CI) runs the same decks
through `Babbage.step` on exact fractions (`formal/Diff.lean`) and through
`src/sketch.rs`, and compares the status, the results and the store: every
control deck the Lean model has, the counter-machine decks, and 2,000 random
decks with and without the trap. They agree on all of them. That is a test,
not a proof of correspondence.
