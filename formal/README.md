# formal: the control machine's theorems, in Lean

A Lean 4 model of the control machine of the Sketch Books (`src/sketch.rs`)
and theorems about what its dated configurations can compute. It uses only
Lean's core library (no Mathlib). Build it with `lake build`; CI checks that
there is no `sorry` and that the main theorems use only the axioms
`propext` and `Quot.sound`.

The rules the model follows, and which of them are readings or
idealisations rather than what a page says, are in `docs/semantics.md`. What
the theorems mean for Babbage's mechanisms is in `docs/expressiveness.md`
§4.

| File | Contents |
|---|---|
| `Babbage/Machine.lean` | Cards, states, one step, runs; the configurations of 1836, Dec 1837, 30 May 1838 and `not-found`, and the rule each accepts. Generic in the numbers of the mill. |
| `Babbage/Termination.lean` | `never_halts_from_start` (A): a deck with an unconditional backing card never halts from its first card. `ends_of_counted` (B): with counted backing only and no combinatorial card inside a counted group, every run ends. `halting_dichotomy`: the two together. |
| `Babbage/Growth.lean` | One card's growth (`step_inv`), the cards in one phase (`phi_step`), and the bound through a run (`out_le_Q`), for repetition counts from number cards (`ConstReps`). |
| `Babbage/Tower.lean` | `tower_halts`: `control/tower-halting.txt` is accepted by the configuration of Dec 1837 and halts with 2↑↑n for every n ≥ 1, its repetition count read from the store. |
| `Babbage/Separation.lean` | `out_le_tower` and `no_tetration` (C1): with repetition counts from number cards, no deck of the pages halts with 2↑↑n for every n. `intSized`: whole numbers satisfy the size condition. `towerDeck_not_constReps`: the deck of `tower_halts` differs only in where its count comes from. |

**Not proved here:**
- that `src/sketch.rs` implements this model; the Rust tests and decks
  exercise the same rules, but nothing checks the correspondence;
- that exact fractions satisfy the size condition;
- the bound C3 for counts read from the store;
- that the counter-machine translation (`src/minsky.rs`) is correct.
