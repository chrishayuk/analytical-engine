# The three control models among the subrecursive hierarchies

This page places the control models of `docs/expressiveness.md` among the
standard classes of computable functions. Each statement is marked:

- **Proved**: a theorem in `formal/` (Lean 4, no `sorry`).
- **Argued**: an argument written here, not machine-checked and not reviewed.
- **Open**: not known.

No exact correspondence with any known class is claimed. Whether this
placement appears in the literature on the Analytical Engine has not been
checked.

## The models

The rules are those of `docs/semantics.md`. All three models keep rules 1–7,
9 and 10: no card chooses between cards.

| Model | Repetition counts | A count set inside its own group? | Configurations |
|---|---|---|---|
| **A** | from number cards only (`ConstReps`) | no (rule 8) | `1837-12`, `1838-05`, read one way |
| **B** | from number cards or the store | no (rule 8) | `1837-12`, `1838-05`, as `src/sketch.rs` reads 7 March 1836 |
| **C** | from number cards or the store | yes | `not-found`, which no page gives |

**What "computes f" means here.** The input n is put in the store or on
the wheels before the first card. Every other starting number is bounded by
a constant of the deck. The deck halts for every n, and f(n) is a number it
gives off. Only halting decks are classified: a table, which runs on, is a
different object (`expressiveness.md`, D).

## The hierarchies used

- **Grzegorczyk's classes** E⁰ ⊂ E¹ ⊂ E² ⊂ E³ ⊂ …, whose union is the
  primitive recursive functions. E³ is the class of Kalmár elementary
  functions. A function in Eⁿ⁺¹ (n ≥ 2) is bounded by a fixed iterate of
  the n-th Grzegorczyk function: for E³ a tower of 2s of fixed height, for
  E⁴ a fixed number of iterations of a function of tetration's growth.
- **The LOOP hierarchy** of Meyer and Ritchie (1967): Lₙ is the class
  computed by LOOP programs with loops nested at most n deep. For n ≥ 2,
  Lₙ = Eⁿ⁺¹. So L₂ is the elementary functions and L₃ is E⁴.
- **Time bounds.** For n ≥ 3, a function computed by a Turing machine in
  time bounded by a function in Eⁿ is itself in Eⁿ. This standard closure
  property is what the "argued" inclusions below use.

## Where the models sit

| Statement | Status | Where |
|---|---|---|
| A halting deck of model A gives off nothing larger than a tower of 2s of height 3(L + 1) on the input plus a constant. | **Proved** | `out_le_tower` |
| Model A does not compute 2↑↑n, so it does not compute every primitive recursive function. | **Proved** | `no_tetration` |
| Model A computes 2ⁿ, and towers of any fixed height: one counted group of doublings per level of the tower, its count set from the result before. | **Argued** (by construction; `multiply-1837` and `tower-table` are the pieces) | — |
| Every function model A computes is elementary (in E³ = L₂). | **Argued**, below | — |
| Model A computes every elementary function. | **Open** | — |
| Model B computes 2↑↑n with a deck of December 1837. | **Proved** | `tower_halts` |
| So model B computes a function outside E³: model A ≠ model B. | **Proved** for the function (`tower_halts`, `no_tetration`); that 2↑↑n ∉ E³ is the standard fact that it outgrows every fixed tower. | — |
| A halting deck of model B gives off nothing larger than 2(L + 1) tetrations on the input plus a constant. | **Proved** | `out_le_ptw` |
| Model B does not compute 2↑↑↑n, so it does not compute every primitive recursive function. | **Proved** | `no_pentation` |
| Every function model B computes is in E⁴ = L₃. | **Argued**, below | — |
| Model B computes every function in E⁴. | **Open** | — |
| Model C computes every partial computable function, with unbounded numbers. | **Proved, given Minsky's theorem**: counter machines translate into decks that halt exactly when the machine does and give off its counters (`compile_halts`, `machine_halts_of_compile`). Minsky's universality of two-counter machines is cited, not formalised. | `Minsky.lean` |

The hierarchy, then:
- **Proved:** A ⊊ B as classes of growth. B computes a function that A
  cannot, and both fall short of the primitive recursive functions.
- **Argued:** A ⊆ E³ and B ⊆ E⁴.
- **Open:** whether either inclusion is an equality.

## The argued inclusions

**Model A ⊆ E³.**
1. Fix a deck of model A that halts on every input.
2. By `out_le_tower`, every number in the run is bounded by T(n), a tower
   of 2s of fixed height on n + C. That holds for every number in the
   store and on the wheels at every card, not only for the numbers given
   off: the proof bounds the invariant `Inv` at every state.
3. The number of cards passed is at most the sum over phases of
   w(L + 1) + L, with w ≤ T(n), so it is at most (L + 1)(T(n)(L + 1) + L).
4. Each card is one operation, or a repetition of at most K operations, on
   numbers of at most log₂ T(n) binary digits. A Turing machine does it in
   time polynomial in that.
5. So the deck can be simulated in time bounded by an elementary function
   of n, and f ∈ E³.

The same holds with exact fractions, since numerator and denominator are
bounded together (`ratSized`).

**Model B ⊆ E⁴.** The argument is the same, with T(n) now 2(L + 1)
tetrations on n + C (`out_le_ptw`).
1. A repetition count is at most the bound, so a card is at most T(n)
   operations.
2. The simulating time is bounded by a fixed iterate of a function of
   tetration's growth.
3. That puts f in E⁴.

**What would make these exact.**
- **A = E³** would need the deck to compute the elementary functions'
  closure operations: bounded sums and products, and limited subtraction,
  of functions it computes. Bounded sums look possible with a counted group
  of additions. Bounded products and the comparisons that limited
  recursion needs run into the problem of `maximum` and `gcd`
  (`expressiveness.md` §4): no deck for them has been found in the dated
  configurations.
- **B = E⁴** would need the same, one level up.

Both are open.

## How the models line up with LOOP nesting

This is an informal reading, not a theorem:
- **Counted group:** one loop, and in the dated configurations the only
  level of counted nesting there is (`expressiveness.md` §2).
- **Repetition with a count from a number card:** a fixed number of
  operations, which adds no nesting.
- **Repetition with a count from the store:** a loop inside that loop. That
  is why model B reaches one level of the hierarchy higher than model A.
- **Phases one after another:** composition, which adds no nesting.

So the dated mechanisms behave like LOOP programs of depth 2 (model A) or
depth 3 (model B). The upper bounds above agree with that reading. It is not
shown that every LOOP program of that depth can be written as a deck.
