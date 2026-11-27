# The control models among the subrecursive hierarchies

This page places the control models of `docs/expressiveness.md` among the
standard classes of computable functions. Each statement is marked:

- **Proved**: a theorem in `formal/` (Lean 4, no `sorry`).
- **Tested**: a deck in `control/`, run by `cargo test`, for some inputs.
- **Argued**: an argument written here, not machine-checked and not reviewed.
- **Open**: not known.

A growth bound is not a class. "No deck gives more than T(n)" is proved for
several models below. "Every function the model computes is in class E" also
needs a bound on the work done, and "the model computes every function in E"
needs constructions. Neither of those is proved for any model here.

Whether this placement appears in the literature on the Analytical Engine
has not been checked beyond `docs/literature-expressiveness.md`. The abstract
facts cited below are known; none is claimed as new.

## The models

The rules are those of `docs/semantics.md`. All the models keep rules 1–7,
9 and 10: no card chooses between cards.

| Model | Repetition counts | A count set inside its own group? |
|---|---|---|
| **A** | from number cards only (`ConstReps`) | no (rule 8) |
| **B** | from number cards or the store | no (rule 8) |
| **C** | from number cards or the store | yes (`not-found`) |

Models A and B are each taken in three configurations: March 1836 (no
backing), December 1837 (backing only to the first card) and 30 May 1838
(backing to any card). **The configuration matters as much as the reading.**
Earlier versions of this page put December 1837 and May 1838 together. That
was wrong (section 2).

**What "computes f" means here.** The input is put in the store or on the
wheels before the first card. Every other starting number is a constant of
the deck. The deck halts for every input, and f(input) is a number it gives
off. Only halting decks are classified: a table, which runs on, is a
different object (`expressiveness.md`, D).

## 1. What programs the dated configurations allow

**Argued** from `Accepts`, with the run lemmas below proved where marked.

- **Nesting gives nothing.** There is one set of wheels. A counted backing
  card passed with the wheels at 0 is an error, and the wheels come to 0
  only when a counted group is passed for the last time. Rule 8 forbids a
  combinatorial card inside a counted group. So if a counted group contains
  another counted backing card, then by the time the outer backing card is
  reached the inner one has run the wheels up, and the run stops in error.
  The same holds for two groups that overlap, and for two groups one after
  the other with no combinatorial card between them.
- **May 1838.** A halting run is therefore: straight runs of cards, and
  loops, one after the other. Each loop is passed w times, with w the number
  put on the wheels by a combinatorial card before it, from a number card
  or the store. A loop's body is straight-line: + − × ÷ and repetition
  cards, with no loop inside.
- **December 1837** (**proved**, `halt_within_1837`). Every backing goes to
  card 0, so a combinatorial card before a counted backing card would be
  inside its group. So every combinatorial card comes after every backing
  card (`back_lt_set`), and the only count a backing can use is the number
  on the wheels before the first card. A halting run passes its cards in
  one loop, from card 0 to the first backing card, and then straight on:
  at most (w + 1)(L + 1) cards with w on the wheels at the start. Without a
  number on the wheels at the start, a halting deck never backs.
- **March 1836.** No backing and no combinatorial cards: straight-line.
- **Repetition** (7 March 1836) repeats one operation k times: `c := c o b`.
  With k a number card (model A) it is a fixed number of operations. With k
  from the store (model B) it is one new operation inside a loop body:
  c·bᵏ, c + kb, c − kb or c / bᵏ, with k computed.
- **Division** in the Lean model of whole numbers (`intArith`) is exact: a
  ÷ that leaves a remainder is an error. In `src/sketch.rs` and `ratArith`
  the numbers are fractions and ÷ is always exact. Neither has a floor
  division or a remainder.

So model A in May 1838 is a language of loops one level deep, in sequence,
over straight-line + − × ÷ code, with loop counts computed. Model B adds,
inside a loop body, a power with a computed exponent.

## 2. What is proved

| Statement | Status | Where |
|---|---|---|
| **March 1836.** Every halting run is straight-line. | **Argued** (no backing card is accepted) | — |
| **Dec 1837.** A halting run passes at most (w + 1)(L + 1) cards, w the number on the wheels at the start. | **Proved** | `halt_within_1837` |
| **Dec 1837, A.** Nothing larger than 2^2^(X + 3^(K+1)(X + 1)(L + 1)) is given off, X the bound on the starting numbers. | **Proved** | `out_le_dexp_1837` |
| **Dec 1837, A.** For every n from some N on, no halting deck gives 2^2^2^n. | **Proved** | `no_triple_exp_1837` |
| **Dec 1837, A.** Computes 2^2^n (one loop squaring, n on the wheels). | **Argued** (a one-loop deck, as `tower-halting` with the repetition replaced by one multiplication) | — |
| **May 1838, A.** Computes 2^2^2^n for every n ≥ 1; refused by Dec 1837. | **Proved** | `triple_halts_1838`, `tripleDeck_accepted`, `tripleDeck_refused_1837`, `tripleDeck_constReps`; `control/triple-1838.txt` |
| So, with counts from number cards, **Dec 1837 ⊊ May 1838** as classes of growth. | **Proved** (the two theorems above) | — |
| **May 1838, A.** Nothing larger than a tower of 2s of height 3(L + 1) on the input plus a constant; no 2↑↑n. | **Proved** | `out_le_tower`, `no_tetration`, `no_tetration_eventually` |
| **May 1838, A.** Towers of any fixed height: one loop per level. | **Argued**; the case of height 3 is `triple_halts_1838` | — |
| **May 1838, A.** Computes max(x, y), and so the comparison [y ≤ x]. | **Tested** (`control/max-1838.txt`, x, y ≤ 4); **argued** for all x, y below | `tests/classes.rs` |
| **Dec 1837, B.** Nothing larger than a tetration of height X + 5(X + 1)(L + 1). | **Proved** | `out_le_tet_1837` |
| **Dec 1837, B.** For every n from some N on, no halting deck gives 2↑↑2ⁿ. | **Proved** | `no_tet_exp_1837` |
| **Dec 1837, B.** Computes 2↑↑n. | **Proved** | `tower_halts` |
| **May 1838, B.** Computes 2↑↑2ⁿ for every n ≥ 1. | **Proved** | `tet_exp_halts_1838`, `tetDeck_accepted` |
| So, with counts from the store, **Dec 1837 ⊊ May 1838** as classes of growth. | **Proved** (the two theorems above) | — |
| **May 1838, B.** Nothing larger than 2(L + 1) tetrations; no 2↑↑↑n. | **Proved** | `out_le_ptw`, `no_pentation` |
| **A ⊊ B** as classes of growth, in Dec 1837 and in May 1838: B gives 2↑↑n, A does not. | **Proved** | `tower_halts`, `no_tetration`, `out_le_dexp_1837` |
| **Model C** computes every partial computable function, with unbounded numbers. | **Proved, given Minsky's theorem** (cited) | `compile_halts`, `machine_halts_of_compile` |

Every bound above holds for whole numbers (`intSized`) and for exact
fractions (`ratSized`), with size the larger of numerator and denominator.

## 3. Membership: is each model inside a Grzegorczyk class?

**Argued, not proved.** For n ≥ 3, a function computed by a Turing machine
in time bounded by a function of Eⁿ is in Eⁿ. So membership needs a bound on
the work of a run, not only on its numbers:

1. The number of cards a halting run passes. For Dec 1837 this is proved
   (`halt_within_1837`). For May 1838 it is proved inside `out_le_Q`, as the
   sum over phases of w(L + 1) + L with w at most the bound on the numbers,
   but not stated as a theorem of its own.
2. The work of one card on numbers of a given size: + − × and exact ÷ are
   polynomial in the number of digits. A repetition with a count from the
   store is up to that count many operations.
3. Then a Turing machine simulates the deck in time bounded by a fixed
   function of the bound on the numbers.

That gives, as arguments:

| Model and configuration | Numbers bounded by | Class (argued) |
|---|---|---|
| A, March 1836 | a polynomial (fixed straight-line code) | inside E² |
| A, Dec 1837 | 2^2^(linear) | inside E³ |
| A, May 1838 | a tower of fixed height | inside E³ (elementary) |
| B, March 1836 | a tower of fixed height (each repetition adds one exponential) | inside E³ |
| B, Dec 1837 | a tetration of linear height | inside E⁴ |
| B, May 1838 | a fixed number of tetrations | inside E⁴ |

A proof in Lean would need a cost model (a time-bounded machine or a
characterisation of Eⁿ by bounded recursion) and the step bound of point 1
as a theorem. Neither is in `formal/`.

## 4. Lower bounds: what can the models compute?

### The comparison, and so the maximum, in May 1838 (model A)

`docs/expressiveness.md` §4 records that no deck for `maximum` or `gcd`
was found in the dated configurations. **There is one for the maximum.**
`control/max-1838.txt` sets every count before its group:

1. A counted group passed x + 1 times makes P = y(y − 1)…(y − x). For whole
   numbers x, y ≥ 0, P = 0 exactly when y ≤ x.
2. The flag of `expressiveness.md` §3, a group passed P² + 1 times, makes
   F = [P ≠ 0] = [y > x]. P² is used because a count must not be negative.
3. max(x, y) = x + F·(y − x).

It is accepted first by `1838-05` and refused by `1837-12`, and gives the
maximum for every x, y ≤ 4 (`tests/classes.rs`). That it does so for every
x, y is the argument above, not checked in Lean. The deck is slow: the flag
group is passed about (y!)² times. Speed is not part of the class.

The same idea gives, in model A of May 1838, as arguments:
- **comparison** [y ≤ x] and truncated subtraction x ∸ y = [y ≤ x]·(x − y);
- **divisibility** [y ∣ x] = [Π_{k=0..x} (ky − x) = 0];
- any question "is there an i ≤ B with p(i, …) = 0", for p made by
  straight-line + − × from i and the numbers so far, with B computed;
- **x mod 2**, as (1 − (−1)ˣ)/2, and x mod m for each fixed m, by a cycle
  of m columns.

### What is still missing: the remainder

Mazzanti (2002) showed that the elementary functions are exactly what
composition makes from x + y, x ∸ y, x·y, ⌊x/y⌋ and xʸ. Prunescu,
Sauras-Altuzarra and Shunia (arXiv 2505.23787, 2025) showed that x + y,
x mod y and 2ˣ are already enough, and that this basis is minimal. Model A
of May 1838 computes x + y and 2ˣ, and decks can be put one after another,
so the following is **argued**:

> Model A of May 1838 computes every elementary function if and only if it
> computes x mod y (with the convention of Prunescu et al. for y = 0).

(The "only if" holds because x mod y is elementary. The "if" needs the
composition of decks, which is ordinary but not written out, and the
upper bound A ⊆ E³ of section 3.)

**Open:** whether x mod y, or ⌊x/y⌋, can be computed. The obstacle is that
a loop body is a fixed polynomial (or, with ÷, rational) map of the
numbers, and the only test, the flag, is itself a loop and cannot go
inside another. Every construction found so far tests a polynomial
condition once, after a loop; the remainder seems to need a test inside
the loop at each step. No proof that it cannot be done has been found.

For the same reason gcd remains open.

### December 1837, model A, is far weaker

**Argued.** In Dec 1837 the cards passed depend only on the number on the
wheels at the start (section 1). So for a fixed number on the wheels, the
output is a fixed composition of + − × ÷ applied to the store: a rational
function of the inputs in the store. max(x, y), with y in the store and x
fixed, equals y for every y > x, so as a rational function it would be y
everywhere, which fails at y = 0 when x > 0. So **model A of Dec 1837 does
not compute max(x, y)**, with either input on the wheels (the maximum is
symmetric). Not checked in Lean: it needs rational functions and the fact
that one that agrees with y at infinitely many points is y.

With the input n on the wheels (and in the store), what Dec 1837 model A
computes is of the form g(pⁿ(v)): a fixed straight-line map p iterated n
times, then a fixed map g, with coefficients that may use n. Without ÷,
these are the polynomial recursive sequences studied by Cadilhac,
Mazowiecki, Paperman, Pilipczuk and Sénizergues (ICALP 2020; Theory of
Computing Systems, 2024), who show that n^n is not one of them when the
coefficients are constants. Here n is in the store as well, so n^n is
computable. Clemente, Donten-Bury, Mazowiecki and Pilipczuk (arXiv
2210.01635) study the version with division.

### Model B

**Open:** whether model B of May 1838 computes every function in E⁴, and
whether model B of Dec 1837 computes every elementary function. B adds a
power with a computed exponent inside a loop body; it does not add a test
inside a loop, so the remainder question is the same.

## 5. Rationals against whole numbers

**Argued.** The upper bounds hold for both (`ratSized`). The lower-bound
decks above use only whole numbers and exact divisions, so they work in
both. With fractions ÷ never fails on a nonzero divisor, but that gives no
test: a loop body is still a rational map, and the remainder question is
unchanged. No difference between the two has been found.

## 6. How the models line up with LOOP nesting

Meyer and Ritchie (1967): Lₙ, the LOOP programs with loops nested at most n
deep, is Eⁿ⁺¹ for n ≥ 2. Their loop bodies have only assignment, zero and
successor; the decks' bodies have + − × ÷.

- **May 1838, model A** is depth 1, in sequence, with × in the body. × in
  the body gives the growth of L₂ (towers of fixed height). Whether it
  gives everything L₂ does is the remainder question above.
- **Model B** adds a power inside the body, which behaves like one more
  level of loop. That is why B reaches one level of growth higher than A.
- **Dec 1837** allows only one loop in a halting run, so it is weaker than
  May 1838 in both models.

This is a reading, not a theorem.

## Sources

- A. R. Meyer and D. M. Ritchie, "The complexity of loop programs", Proc.
  ACM National Meeting, 1967.
- A. Grzegorczyk, "Some classes of recursive functions", Rozprawy
  Matematyczne 4, 1953.
- S. Mazzanti, "Plain bases for classes of primitive recursive functions",
  Mathematical Logic Quarterly 48, 2002. Known here through the next item;
  not read.
- M. Prunescu, L. Sauras-Altuzarra and J. M. Shunia, "A minimal
  substitution basis for the Kalmár elementary functions",
  [arXiv 2505.23787](https://arxiv.org/abs/2505.23787). Read in its abstract
  and introduction only.
- M. Cadilhac, F. Mazowiecki, C. Paperman, M. Pilipczuk and G. Sénizergues,
  "On polynomial recursive sequences", ICALP 2020,
  [arXiv 2002.08630](https://arxiv.org/abs/2002.08630). Read in its
  abstract only.
- L. Clemente, M. Donten-Bury, F. Mazowiecki and M. Pilipczuk, "On rational
  recursive sequences", [arXiv 2210.01635](https://arxiv.org/abs/2210.01635).
  Not read.
