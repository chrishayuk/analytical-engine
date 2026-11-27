# What Babbage's control mechanisms could express, 1836–1838

This page asks which programs the control mechanisms in Babbage's Sketch
Books can express, at the dates the pages give. It uses a machine built for
the question (`src/sketch.rs`, `babbage control`). That machine is separate
from the L/023 interpreter (`src/loops.rs`), which follows L/023's table.

The sources are `sources/notes/sketchbooks-control.md` and
`codesign-L023.md`. No person has checked those transcriptions. The
arguments in section 4 are written proofs. They have not been
machine-checked or reviewed.

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
  of times put on an axis (Vol 2 p 84, 7 Mar 1836).

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
cards.

**A. A run that halts never passes an unconditional backing card.** Cards
go forward one at a time, or back. To halt, the run must pass the last
card. To pass the last card, it must pass any unconditional backing card
at position i. But every pass of card i sends the run back to a card at
or before i. So a run that reaches an unconditional backing card runs
until stopped (or until an error, such as a number too large).

**B. A deck without unconditional backing always halts.**
1. A card runs again only if a backing card at or after it, with a target
   at or before it, sends the run back.
2. Here every backing card is counted. By the rule of section 2, no
   combinatorial card lies in a counted group. So each combinatorial card
   runs at most once.
3. Each effective backing uses up one unit of the count on the wheels, and
   only a combinatorial card puts units there.
4. So the number of effective backings is at most the sum of the counts
   set (s₁ + … + s_k, plus any initial count). The run passes at most
   L × (1 + that sum) cards, and halts.

**C. A deck that halts cannot compute 2↑↑n (2 raised to itself n times)
for every n.** Let M be the largest numerator or denominator held
anywhere, the wheels included.
1. One operation of the mill turns M into at most 2M².
2. Divide the run into phases, each ending where a combinatorial card
   sets a count.
3. A phase that starts with M passes at most L × (1 + M) cards. A repeated
   operation counts as at most M operations, by the same bound.
4. So one phase turns M into at most 2 raised to (2 raised to a
   polynomial in M). That is two more levels of exponentiation.
5. There are at most k + 1 phases, where k is the number of combinatorial
   cards. So every number in a halting run is bounded by a tower of
   exponentials of fixed height, about 2(k + 1), in the input.
6. 2↑↑n eventually exceeds every tower of fixed height. So no deck computes
   it for all n.
7. 2↑↑n is primitive recursive.

So the dated configurations do not compute every primitive recursive
function. The question raised against `docs/control-flow.md` is answered in
the negative. That page's claim is withdrawn (section 5).

**D. A table can go further than a halting deck.** `tower-table` gives
2↑↑k as its k-th result. Its counted group of doublings takes as its count
the result before, set in the constant group. This is the shape of
Babbage's arrangement: a table of results, not a single result. What a
table computes and what a halting deck computes are different questions,
and the answers differ.

**E. What `not-found` adds.** A count set inside the group it counts can
end a loop on a number the loop computes. `collatz-halting` puts the next
term on the wheels, and its backing is ineffective exactly when that term
is 1. With unbounded store, loops of the form "while e ≠ 0" are expressible
this way: put e² + 1 on the wheels before a counted backing. A do-while
becomes a while with the flag of section 3. On the standard argument for
WHILE programs, that would be general computation. The translation is
sketched here, not proved, and no unbounded store is in the record.
**No claim of Turing completeness is made.**

**Not shown:** that `maximum` or `gcd` cannot be done in the dated
configurations. No deck for either was found. Both constructions here need
a comparison, and that needs a count set inside a loop. A proof that no
deck exists has not been attempted.

## 5. What this changes in `docs/control-flow.md`

- **Withdrawn:** "a loop inside a loop: S for two levels … suggests three
  levels". The found nesting is one counted group, or several in sequence,
  inside an endless loop.
- **Withdrawn:** "counted loops … nested to a fixed depth, compute what are
  now called primitive recursive functions". Argument C shows that halting
  decks in the dated configurations fall short of that class.
- **Confirmed and made precise:** the point on which generality turns is a
  count set within the group it counts (argument E). No page read gives it.

## 6. Leads

- **25 June 1839, Vol IV p 12 (long addition):** "the running up or non
  running up must turn a card over before it acts". This may be a result
  in the mill acting on a card. If it is, it is the first such record
  found. What "turn a card over" means is not settled from the
  transcription, and the page should be read at full resolution. It would
  be a new, later configuration, not a change to these.
- **Turin, August 1840 (Vol IV pp 406–417, Plan 25):** not yet read for
  control. Until it is, no 1840 configuration is given.
- **13 March 1838:** an addition that "goes on as long as variables are
  supplied". Its count is the number of variable cards, fixed in advance.
  It adds nothing to the configurations above.
