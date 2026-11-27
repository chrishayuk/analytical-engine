# formal: the control machine's theorems, in Lean

A Lean 4 model of the control machine of the Sketch Books (`src/sketch.rs`)
and theorems about what its dated configurations can compute. It uses only
Lean's core library (no Mathlib). Build it with `lake build`; CI checks that
there is no `sorry` and that the main theorems use only the axioms
`propext` and `Quot.sound`. The concrete instances for whole-number
division and for fractions (`intSized`, `ratSized` and what uses them) also
use `Classical.choice`, through core Lean's lemmas on `Int` division and
`Rat`.

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
| `Babbage/GrowthStore.lean` | C3, with repetition counts from the store: one card's growth (`step_invS`), `out_le_ptw` (at most 2(L + 1) tetrations on the input plus a constant) and `no_pentation`: no deck of the pages halts with 2↑↑↑n for every n. `tower_below_pentation` applies it to the deck of `tower_halts`. |
| `Babbage/RatSize.lean` | `ratSized`: exact fractions (core `Rat`, size the larger of the absolute numerator and the denominator) satisfy the size condition; `no_tetration_rat`, `no_pentation_rat`. |
| `Babbage/Separation.lean` | `out_le_tower` and `no_tetration` (C1): with repetition counts from number cards, no deck of the pages halts with 2↑↑n for every n. `intSized`: whole numbers satisfy the size condition. `towerDeck_not_constReps`: the deck of `tower_halts` differs only in where its count comes from. `no_tetration_eventually`: the same, for every n from some point on. |
| `Babbage/Classes.lean` | December 1837 against 30 May 1838. `halt_within_1837`: where backing goes only to the first card, a halting run passes its cards in one loop, at most (w + 1)(L + 1) of them with w on the wheels at the start. `out_le_dexp_1837` and `no_triple_exp_1837`: with counts from number cards, nothing beyond 2^2^(linear), so no 2^2^2^n. `out_le_tet_1837` and `no_tet_exp_1837`: with counts from the store, nothing beyond a tetration of linear height, so no 2↑↑2ⁿ. `triple_halts_1838` and `tet_exp_halts_1838`: decks of May 1838 that give 2^2^2^n and 2↑↑2ⁿ (`tripleDeck_refused_1837`; the second follows from `no_tet_exp_1837`). |
| `Babbage/Minsky.lean` | Counter machines translated into decks (`compile`, as `src/minsky.rs`): `compile_accepted` by `not-found`, `compile_refused` by every configuration with rule 8, `compile_halts` and `machine_halts_of_compile`, so the deck halts exactly when the machine does and gives off its counters. |
| `Babbage/Trap.lean` | Model D, a stop at an operation the mill cannot do read as the end (`TrapStops`). With every backing counted a trap adds nothing (`reach_le_tower`, `reach_le_ptw`, `no_tetration_reach`, `no_pentation_reach`). With the unconditional backing card a counter machine translates into a deck of 30 May 1838 (`trapDeck_accepted`, `trap_halts`, `machine_halts_of_trap`), and, with repetition counts from the store, of December 1837 (`trapDeck37_accepted`, `trap37_halts`, `machine_halts_of_trap37`). |
| `Diff.lean` | Not theorems: `lake exe diff` runs decks with `Babbage.step` on fractions, for the differential test against Rust (`scripts/lean-diff.sh`). |

**Not proved here:**
- that `src/sketch.rs` implements this model. `scripts/lean-diff.sh` (in CI)
  runs the same decks through both and compares them: they agree on every
  deck tried (the control decks, the counter-machine decks, 2,000 random
  decks with and without the trap), which is a test, not a proof;
- that any model's functions belong to, or exhaust, a class of the
  subrecursive hierarchies: the theorems bound numbers and the cards a run
  passes, and give decks, but membership and equality are argued or open
  (`docs/growth-classes.md`);
- that `src/minsky.rs` makes the same decks as `compile`, `trapDeck` and
  `trapDeck37`; it uses the same layout and is tested against direct
  simulation;
- Minsky's theorem that two counters suffice; it is cited.

**What the theorems take as given** (from an independent review of
`formal/`, 27 Nov 2026):
- `Ends` counts an error as an ending; "halts" means passing the last card,
  and an error is not a halt (`docs/semantics.md`, rule 14a).
- The separations cover runs that halt. A table that runs on, or results
  given off before an error, are outside them.
- `result … off`, operations with several destinations, and letters are not
  modelled. They can be simulated, so the theorems are unaffected.

**Axioms.** The generic bounds use only `propext` and `Quot.sound`. The
whole-number and fraction instances, and the theorems about the Minsky and
trap decks (`compile_halts`, `machine_halts_of_compile`, `trap_halts`,
`machine_halts_of_trap`, the 1837 versions, `trapDeck_accepted`,
`trapDeck_refused_1837`, `trapDeck37_not_constReps`) and
`tower_below_pentation`, also use `Classical.choice`: through core Lean's
lemmas on division and case analysis, and in `machine_halts_gen` through a
proof by contradiction.

**"Counts from number cards"** (`ConstReps`) means *repetition* counts.
Combinatorial cards may put a computed number on the wheels in every model
(rule 4), and the May 1838 constructions use it.
