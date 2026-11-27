# What Babbage's control mechanisms could express, 1836–1838

This page asks which programs the control mechanisms in Babbage's Sketch
Books can express, at the dates the pages give. It uses a machine built for
the question (`src/sketch.rs`, `babbage control`). That machine is separate
from the L/023 interpreter (`src/loops.rs`), which follows L/023's table.

The sources are `sources/notes/sketchbooks-control.md` and
`codesign-L023.md`. No person has checked those transcriptions. The rules
of the machine, and which of them are readings or idealisations rather than
what a page says, are fixed in `docs/semantics.md`. Arguments A, B and C of
section 4 are machine-checked in Lean (`formal/`). The rest of section 4 is
argued in writing only. No one has reviewed any of it.

**Correction, 27 November 2026.** Argument C as first written here was
wrong. It said no halting deck computes 2↑↑n. But `tower-halting` does, in
the configuration of December 1837, because the machine reads a repetition
count from the store. Section 4 now gives the theorem in its two forms.

## 1. The machine

The machine has four parts:

- **The store and the mill.** Store columns hold exact numbers or letters.
  The mill does + − × ÷ on two operands. An operand comes from a store
  column, a number card, a letter, or a row of letter cards.
- **The combinatorial wheels.** They hold one count, outside the store. A
  combinatorial card puts a number on them, either from the card itself or
  from a store column (a computed number).
- **The backing card.** A counted backing card subtracts unity from the
  wheels. Its order is ineffective once the wheels "have run up by coming
  to 0" (Vol 3 p 161, Dec 1837). An unconditional backing card "always
  orders the backing" (p 162).
- **Repetition of one operation.** One operation can be repeated a number
  of times put on an axis (Vol 2 p 84, 7 Mar 1836). The page does not say
  where the number comes from. The machine reads it from a number card or
  from the store, and the difference matters (section 4, C).

The machine has no card that chooses between other cards, and no
comparison that yields a number.

**How a count is read.** With n on the wheels, a counted group passes n
times. That follows p 161, where the wheels run up "by coming to 0". It
also follows 7 March 1836, where the number on the axis is "the number of
rep.ns". On 8 June 1838 (Vol 3 p 201) Babbage wrote "reduced to zero or to
−1 (runs up)", so he had not settled the point himself.

A count of 0 is an error. The group has already passed once before its
backing card is reached, and the wheels would never come to 0. A count
must be a whole number of 1 or more.

## 2. The configurations

| Key | Date | What the pages give | Source |
|---|---|---|---|
| `1836-03` | March 1836 | One operation repeated a variable number of times. The sign chooses a mill cycle within an operation, which has no effect at the level of the cards. | Vol 2 pp 80–94 |
| `1837-12` | December 1837 | Combinatorial wheels and cards. The repeated group comes first, then a counted backing card, then the constant group, then an unconditional backing card. Both back "to 0 or their commencing point". The count is "computed by the constant part of formula cards". | Vol 3 pp 161–165 |
| `1838-05` | 30 May 1838 | Six groups of cards. Wheels "each of which can be set to back any No of cards". The count for each repeated group is made by the group of cards before it. | Vol 3 reverse pp 74–75 |
| `not-found` | — | As 30 May 1838, and also a count may be set inside the group it counts. **No page read says so.** It is here only to show what that one step would change. | — |

One rule separates the three dated configurations from `not-found`. A
combinatorial card may not stand among the cards that a counted backing
sends back over. Every arrangement Babbage describes sets the count before
the group it counts:

- Dec 1837: the count is set in the constant group.
- 30 May 1838: the count is set by "Cards to make the combinatorial
  numbers", which come before the group.
- L/023: the count is set by the make card, which comes before the formula
  cards.

**Correction to `docs/control-flow.md`.** Neither scheme nests one counted
group inside another:

- **Dec 1837:** one counted group inside an endless loop.
- **30 May 1838:** two counted groups (3 and 5) one after the other,
  inside a loop back "to end of prep.n Cards" (group 6). Group 6 also has
  a combinatorial card, which "governs" the third of the wheels that are
  "set to back any No of cards". Those wheels set how far to back. The
  page does not say whether group 6's backing is counted, or how a count
  for it would survive the counts of groups 3 and 5 on the one
  combinatorial axis.

There is one set of wheels. An inner count would use up the outer one,
unless the outer count is kept in the store and put back on the wheels
inside the outer group, which is the arrangement not found. That page said
the scheme gave "two levels" and "suggests three". That is withdrawn: the
counted nesting found is one level, inside an endless loop.

## 3. The suite

The decks are in `control/`. `babbage control` runs each deck under each
configuration, and `tests/control.rs` pins the results.

| Deck | What it computes | First accepted by | Result |
|---|---|---|---|
| `multiply-1836` | 1028 × 201 by one addition repeated 201 times | `1836-03` | halts: 206628 |
| `multiply-1837` | the same, as a counted group | `1837-12` | halts: 206628 |
| `sum-1837` | 1 + 2 + … + 100 (two cards repeated together) | `1837-12` | halts: 5050 |
| `factorial-1837` | 10! | `1837-12` | halts: 3628800 |
| `L023-1837` | L/023's product of series, in the Dec 1837 arrangement | `1837-12` | a table: Aa, Ab + Ba, … |
| `L023-sheet` | the same, in the three groups L/023's cover describes | `1838-05` | a table, the same results |
| `collatz-table` | the Collatz sequence from 27, term by term | `1837-12` | a table: 82, 41, 124, … |
| `tower-table` | 2, 4, 16, 65536, …, each 2 to the power of the one before | `1837-12` | a table |
| `product-halting` | L/023's product, stopping after 4 coefficients | `not-found` only | halts |
| `collatz-halting` | Collatz from 27, stopping at 1 | `not-found` only | halts after 111 terms |
| `maximum` | max(17, 42) | `not-found` only | halts: 42 |
| `gcd` | gcd(1071, 462), Euclid by subtraction | `not-found` only | halts: 21 |
| `tower-halting` | 2↑↑4 = 65536, with 4 on the wheels: each pass computes 2^x by one multiplication repeated x times | `1837-12` | halts: 65536 |
| counter machines | addition and multiplication, translated by `src/minsky.rs` | `not-found` only | halts, with the machine's counters |

Nothing in the suite chooses between cards. Where a deck needs a choice,
it computes both values and multiplies one of them by a flag, 0 or 1. The
flag comes from a counted group passed x + 1 times, which leaves [x > 0]
in a column: the first pass writes 0, every later pass writes 1. This uses
only + − × and counted groups.

**What the suite shows:**

- **L/023 two ways.** The Dec 1837 arrangement already computes L/023's
  product, with the cards rearranged so the repeated group comes first.
- **L/023's own arrangement needs 30 May 1838.** In that arrangement Y
  backs "to the beginning of the formulae cards", which is not card 0. The
  Dec 1837 pages give no backing to any card but the first. The first
  configuration that accepts L/023's arrangement is dated 30 May 1838,
  eight days before L/023 (7 June 1838).
- **The counter moves off the mill.** L/023's table counts down with a mill
  subtraction, the "use" card. On the wheels that becomes the wheels' own
  subtraction of unity. For the first four coefficients there are 10
  products in both versions. The table also has 10 mill subtractions; the
  wheel version has none, and subtracts unity from the wheels 10 times
  instead. `tests/control.rs` checks that both versions give the same four
  coefficients.
- **Halting.** Every deck that halts with a number not fixed in advance is
  accepted only by `not-found`: the product with its own end, Collatz to 1,
  the maximum and Euclid. Each needs the count it stops on to be computed
  inside the loop.

## 4. Arguments

Take a deck accepted by `1837-12` or `1838-05`, and let L be its number of
cards. The Lean names are in `formal/Babbage/`.

**A. A deck with an unconditional backing card never halts from its first
card** (`never_halts_from_start`). Every backing goes back. So a run that
starts at or before an unconditional backing card at position i stays at or
before i: from i it is sent back. It never passes the last card. It runs on
until stopped, or until an operation fails.

**B. A deck without unconditional backing always ends** (`ends_of_counted`).
Each card does one of three things:
- passes a combinatorial card, so one fewer lies ahead;
- passes a counted backing card, so the wheels go down by one and the number
  of combinatorial cards ahead stays the same, because none lies in the
  group (the rule of section 2);
- moves on by one card, changing neither.

So the triple (combinatorial cards ahead, count on the wheels, cards left)
falls in lexicographic order at every card, and the run ends.

**C. The growth bound depends on where a repetition count comes from.**

*C1. With repetition counts from number cards only* (`out_le_tower`,
`no_tetration`). Let X bound every number at the start, the input included,
and let K bound the number cards.
1. One card makes nothing larger than X^(3^(K+1)) (`step_inv`).
2. Before the next combinatorial card, at most w(L + 1) + L cards pass,
   where w is the count on the wheels (`phi_step`). That count is at most
   X.
3. So one phase is at most a tower of three 2s on X + E, where E depends
   only on the deck (`H_le`).
4. There are at most L + 1 phases, so a halting deck gives off nothing larger
   than a tower of 3(L + 1) 2s on X + (L + 1)E.
5. That tower falls below 2↑↑n at n = 2J + 2 + C, where J = 3(L + 1) and
   C is a constant of the deck. So no such deck gives 2↑↑n for every n.
6. 2↑↑n is primitive recursive, so these decks do not compute every
   primitive recursive function.

The theorem holds for any numbers whose single operation makes nothing
larger than the cube of its operands. Whole numbers are shown to satisfy
that (`intSized`). Fractions are not.

*C2. With repetition counts from the store, as `src/sketch.rs` reads 7
March 1836* (`tower_halts`). `tower-halting` is accepted by the configuration
of December 1837, and for every n ≥ 1 it halts with 2↑↑n. So C1 needs its
hypothesis. The step that failed in the first version is the one that bounded
a repetition count by the numbers at the start of a phase: a count read
from the store is the number the phase has just made.

*C3. The bound with counts from the store* (`out_le_ptw`, `no_pentation`,
machine-checked in `formal/Babbage/GrowthStore.lean`).
1. With a count within X, one card makes nothing larger than X^(3^X)
   (`step_invS`), which is at most a tower of three 2s on X + 2
   (`growS_le`).
2. One phase is then a tower of height linear in X, so at most one
   tetration, 2↑↑((5L + 6)(X + 1)) (`H_growS_le`).
3. With at most L + 1 phases, a halting deck gives off nothing larger than
   2(L + 1) tetrations on X + (L + 1)(5L + 6).
4. That falls below 2↑↑↑n at an explicit n. So no such deck gives 2↑↑↑n
   for every n.

Here 2↑↑↑0 = 1 and 2↑↑↑(n + 1) = 2↑↑(2↑↑↑n), so 2↑↑↑3 = 65536.
`tower_below_pentation` applies the theorem to `tower-halting` itself,
which shows that its hypotheses can be met by a deck that reaches
tetration.

Both C1 and C3 hold for exact fractions as well as whole numbers, with size
the larger of numerator and denominator (`ratSized`, `no_tetration_rat`,
`no_pentation_rat`).

**What C settles.** The question raised against `docs/control-flow.md` was
whether the dated configurations compute every primitive recursive
function. Under either reading of 7 March 1836 they do not, and both
halves are machine-checked. Where the line falls depends on the reading:
- **counts from number cards only:** tetration is not computed;
- **counts from the store:** tetration is computed, and pentation is
  not.

Where these classes sit among the subrecursive hierarchies (Grzegorczyk,
Meyer–Ritchie) is in `docs/growth-classes.md`. That placement is argued,
not proved.

The pages do not decide between the two readings (`semantics.md`, rule 3a).

**D. A table can go further than a halting deck.** `tower-table` gives
2↑↑k as its k-th result without reading a count from the store, and is
endless. What a table computes and what a halting deck computes are
different questions.

**E. What `not-found` adds.** It adds a count set inside the group it
counts, so a loop can end on a number it has computed.
`src/minsky.rs` uses this to translate a counter machine into a deck:
- the state is a number, and [q = i] is a polynomial in it;
- [r > 0] is the flag of section 3;
- each pass of one counted group is one step of the machine;
- the count of that group is set, inside the group, to 2 − [q = halt].

Counter machines with two counters compute every computable function
(Minsky). So, if the translation is correct for every machine, `not-found`
with unbounded numbers and store is general. It has been tested on
addition and multiplication (`counter_machines_under_not_found`). It is not
proved. **No claim of Turing completeness is made.** Nor is any claim made
about the Analytical Engine as Babbage went on to design it. This is a
reconstruction of the mechanisms of 1836–1838 only, and a subset not being
universal says nothing about the engine.

**Not shown:** that `maximum` or `gcd` cannot be done in the dated
configurations. No deck was found for either, and no proof that none exists
has been attempted. With counts from the store, the flag of section 3 still
needs its count set before the group. So the question remains open under
both readings.

## 5. What this changes in `docs/control-flow.md`

- **Withdrawn:** "a loop inside a loop: S for two levels … suggests three
  levels". The found nesting is one counted group, or several in sequence,
  inside an endless loop.
- **Withdrawn:** "counted loops … nested to a fixed depth, compute what are
  now called primitive recursive functions". Argument C shows that halting
  decks in the dated configurations fall short of that class.
- **Confirmed and made precise:** the point on which generality turns is a
  count set within the group it counts (argument E). No page read gives it.

## 6. The later pages, 1839–1842

Read for one question: does a result computed in the mill act on the
cards, on the backing, or on the wheels? The transcriptions are in
`sources/notes/vol4-control-1839-1840.md`. Full-resolution crops were
taken on 27 November 2026, and no person has checked them.

| Page | Date | What it shows | A result of the mill acting on cards? |
|---|---|---|---|
| Vol IV p 12 | 25 June 1839 | Long addition: "the running up or non running up must turn a card over before it acts". | **Only as a variant not adopted, and only within one long addition.** The sentence applies only "if" a cam is not independent of the F–″A link. pp 13 and 18–20 break the link by card in every case and let the cam carry the state. Nothing concerns backing or the order of cards. What "turn a card over" means is not settled. |
| Vol IV p 65 | Aug 1838 | "The Running up of the Comb.l Counting App. ungears Y and gears Z so that the cards in that case are backed by Z." | No. The combinatorial counter, not the mill, chooses how far to back. This is the found configuration's own mechanism. |
| Vol IV pp 406–417 | 30 July – 18 Aug 1840 (Turin) | Each set of cards has a card counting apparatus: cards "moved on" or "moved back through the same number"; counts from cards or from the store (p 412, two-figure indices); "The R.g up of the first index … directs its barrel to … put the second index upon it". | No. The counts come from cards or the store, loaded before use; the running up is the card counter's own. |
| BAB/F/227 | April 1842 | Tests: "′F Runs up ∴ Vₙ > 0", "F R[uns up] ∴ Vₙ has a − sign". | No. Both outcomes have the same card columns and orders ("Same … without exception"). The only running up that orders a card is the index counter's. |

So no new configuration is added. The Turin pages may add counts read from
the store (two-figure indices), which bears on rule 3a. They do not add a
count set inside its own group, or a result of the mill acting on a
backing.

## 7. Leads

- **Sketch Book Vol V p 74**, cited in F/227's title (April 1842): not read.
- **Drawing 25**, the Turin plan itself: not read for control.
- **Turin p 412**, two-figure indices on the card counting apparatus: read
  closely, this may settle rule 3a for 1840, though not for 1836–1838.
- **13 March 1838:** an addition that "goes on as long as variables are
  supplied". Its count is the number of variable cards, fixed in advance.
  It adds nothing to the configurations above.
