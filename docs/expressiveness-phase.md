# The expressiveness phase: what it established, and what it left open

This phase asked what the control mechanisms Babbage described could compute,
at the dates the sources give, under each reading the sources allow. It is
closed here, on 27 November 2026, at the commits below. The notes written
from it are on chrishayuk.com (N-BABBAGE-CONTROL, N-BABBAGE-NOTE-G).

Nothing in this phase is about the machinery. A configuration is a set of
rules for cards, read from what the pages say the cards do; no theorem here
says how, or whether, the mechanism of any date carried those rules out.

## What it established

Each line is a theorem of `formal/` (Lean 4, core library, checked in CI),
except where marked. The rules, and which are readings or idealisations, are
in `semantics.md`; the readings of 1842–1843 in `published-control-1843.md`.

| Result | Where |
|---|---|
| With repetition counts from number cards, a halting deck of 1836–1838 gives off nothing as large as 2↑↑n, for every n from some point on. | `Separation.lean` |
| With repetition counts from the store, it gives 2↑↑n and not 2↑↑↑n for every n. | `Tower.lean`, `GrowthStore.lean` |
| Both bounds hold for exact fractions. | `RatSize.lean` |
| With a halt as passing the last card, December 1837 is strictly weaker than 30 May 1838 (year inferred) under both readings. | `Classes.lean` |
| A count set inside its own loop (no page) makes the machine general, given Minsky. | `Minsky.lean` |
| A stop at 1 ÷ 0 read as the end, with the unconditional backing of 1837, makes it general; with every backing counted it adds nothing. | `Trap.lean` |
| Note G's test read as a backing a result makes effective (Reading A) makes it general with one card. | `Note43.lean` |
| Read as a forward course (Reading B), it does with the unconditional backing of 1837. | `Note43.lean` |
| An operation with several destinations equals the operation and copies. | `Multi.lean` |
| Lovelace's Note G program: as printed −95/126; corrected −1/30, and 1/42 and 5/66 for n = 3, 5; under Reading B, the same Numbers with V₁₀ ending at 0 for n = 1 to 5. | Tested: `tests/note_g.rs` |
| The Lean model and the Rust machine agree on every compared run. | Tested: `scripts/lean-diff.sh` |

## The evidence for the Lean–Rust agreement

The script prints what it generated, what it compared and what it left out.
At the close: 4,026 runs generated; 3,720 compared, all agreeing; 292 left out
because no configuration accepts the (random) deck; 3 outside the Lean model;
11 because a number grew too large for the Rust machine's i128 fractions. The
random decks found one bug in the Rust fractions (a result on i128::MIN),
fixed in a9a0b50.

## Backlog: open, kept for later

- **A proof that Lovelace's program computes every Bernoulli number it is
  given**, rather than a test for n = 1 to 5.
- **Advancing variable cards** (Note G, Operation 21), so the program needs no
  adaptation and runs past n = 5.
- **Reading B without the unconditional backing is bounded**: argued through
  the existing measures, not formalised.
- **Exact classes**: whether Model A is the elementary functions (it turns on
  x mod y) and Model B the next Grzegorczyk class; argued or open.
- **Full Lean–Rust equivalence**: tested, not proved; the Rust machine's
  numbers are bounded (i128), the Lean model's are not. Arbitrary-precision
  fractions in the Rust would remove the overflow exclusions.
- **December 1837 under Model D without store repetition counts**: open.
- **Gcd and x mod y in May 1838**: open.
- **Reading the literature not read**: Bromley (2000), Rojas (2021), Copeland
  and Sommaruga (2015), Kfoury (1980), Goetze and Nehrlich (1980).
- **A person's check** of the transcriptions of the Sketch Books, the
  published accounts and the Note G plate.

## Commits at the close

analytical-engine: the commit that adds this file. The notes cite a9093f5
(N-BABBAGE-CONTROL) and a9a0b50 (N-BABBAGE-NOTE-G).
