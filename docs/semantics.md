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
| 3a | **Where the repetition count comes from.** `src/sketch.rs` reads it from a number card or from a store column. | **Reading** | The page says "given variable number" and does not say where it comes from. The alternative reading, a count from a number card only, is the hypothesis `ConstReps` of the Lean theorems. The two readings give different theorems (below). |
| 4 | The combinatorial wheels hold one count, outside the store. A combinatorial card puts a number on them, from the card itself or from the store. | Page | Vol 3 p 161: "transferred from the combinatorial cards", "computed by the constant part of formula cards" |
| 5 | A counted backing card subtracts unity from the wheels. It backs unless they have come to 0, when its order is ineffective. | Page | Vol 3 p 161: "ineffective if the combinatorial wheels have run up"; "run up by coming to 0" |
| 5a | **When the wheels run up.** With n on the wheels, a counted group passes n times. | **Reading** | p 161 "by coming to 0". On 8 June 1838 (Vol 3 p 201) Babbage wrote "reduced to zero or to −1 (runs up)", so he had not settled it. The other reading gives n + 1 passes; no theorem below depends on the choice. |
| 6 | An unconditional backing card always backs. | Page | Vol 3 p 162: "always orders the backing" |
| 7 | In Dec 1837 backing goes only to the first card. From 30 May 1838 it goes to any earlier card. | Page | Vol 3 p 162, "to 0 or their commencing point"; Vol 3 reverse pp 74–75, wheels "set to back any No of cards" |
| 8 | **No combinatorial card among the cards a counted backing sends back over.** | **Reading** | Every arrangement found sets the count before the group it counts (Dec 1837, 30 May 1838, L/023). No page forbids the other arrangement either. Without this rule the machine is the `not-found` configuration. |
| 9 | A card that writes a result gives off the number in a column. | Page | L/023, and Vol 3 p 162 |
| 10 | Nothing chooses between cards. No result of the mill acts on a card, on the backing, or on the wheels. | Page (by absence) | Read for this up to April 1842: Vol 2 pp 74–95, Vol 3 pp 137–166 and reverse 74–75, Vol IV pp 2–19, 64–67, 406–417, and F/227. The one exception is Vol IV p 12 (25 June 1839), a variant Babbage does not adopt, which concerns complementing within one long addition (`vol4-control-1839-1840.md`). |
| 11 | Numbers are exact fractions of unbounded size. | Idealisation | The engine's numbers had a fixed number of figures: 40 on Vol IV p 11 (25 June 1839), with numbers of more figures added in parts. |
| 12 | The store is unbounded. | Idealisation | The store had a fixed number of columns. |
| 13 | A count of 0 or less, or a counted backing with no number on the wheels, is an error. | Idealisation | The pages do not say what happens. |
| 14 | An operation that is undefined, such as division by 0, is an error that ends the run. | Idealisation | The pages do not say. |
| 15 | An input is a number placed in the store or on the wheels before the first card. | Idealisation | Babbage's numbers came in on number cards. That is the same as a deck that sets its inputs first. |

**Not modelled:** the letters and rows of letter cards of `src/sketch.rs`,
which are used only by the L/023 decks; and operation cards that write
several columns at once. Neither changes what can be computed with numbers.

**Undecided by the pages, and not used:** whether a result of the mill can
make a counted backing effective or ineffective, or put a count on the
wheels. No page read does either (rule 10). The `not-found` configuration
adds only the second, by dropping rule 8.

## What follows from the rules

Each line below is a theorem of `formal/` (Lean 4, core library only,
checked by CI with no `sorry`), except where marked **argued**.

| Statement | Rules used | Lean |
|---|---|---|
| A deck with an unconditional backing card never halts from its first card. | 1, 6, and backing goes back | `never_halts_from_start` |
| Under rule 8, a deck whose backing cards are all counted always ends: it halts or an operation fails. | 1, 4–8, 13 | `ends_of_counted`, `halting_dichotomy` |
| Under rule 8, **with repetition counts from number cards only**, a halting deck gives off nothing larger than a fixed tower of exponentials on its input, and so does not give 2↑↑n for every n. | all, with `ConstReps` | `out_le_tower`, `no_tetration` |
| Under rule 8, **with repetition counts from the store** (rule 3a as coded), a deck of Dec 1837 halts with 2↑↑n for every n ≥ 1. | all | `tower_halts` |
| Under rule 8, with repetition counts from the store, a halting deck does not give 2↑↑↑n (2↑↑2↑↑…2, n times) for every n. | all | **argued** in `expressiveness.md` §4, not formalised |
| Without rule 8 (`not-found`), counter machines can be translated into decks. | 1–7 | **tested** on two machines (`src/minsky.rs`); not proved |

The whole-number arithmetic `intArith` satisfies the size condition of the
growth theorem (`intSized`). Exact fractions are expected to satisfy it too,
with size taken as the larger of numerator and denominator, but that is not
proved in `formal/`.
