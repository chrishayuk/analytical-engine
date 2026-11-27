# The literature, against the expressiveness results

This page asks what was already known before `docs/expressiveness.md` and
`formal/` make any claim. The results it checks:

- **(A)** With repetition counts fixed on number cards, a halting deck gives
  off nothing larger than a fixed-height tower of exponentials of its input,
  so it cannot give 2↑↑n for every n (`out_le_tower`, `no_tetration`).
- **(B)** With repetition counts read from the store, a halting deck of
  December 1837 gives 2↑↑n (`tower_halts`); that pentation is out of reach is
  argued, not proved.
- **(C)** In the hypothetical configuration `not-found`, where a count is set
  inside the group it counts, decks simulate counter machines (tested, not
  proved).

Searched on 27 November 2026, by web search and fetch only. "Read" means the
full text was read for this page. Nothing was sent to anyone.

## 1. The Analytical Engine's computational power

**Rojas, R. "Unconventional Universal Computation in Babbage's Analytical
Engine." arXiv:2408.03334 [cs.LO], 2024.** *Read (7 pp).*
He assumes, after Bromley (2000), a conditional jump: a store column is
tested for zero, and if it passes, both strings of cards are backed n and m
cards, where n and m are punched on cards. He also assumes the "simple fixed
loop", one operation repeated a number of times punched on its card (after
Menabrea and Lovelace). From the conditional jump he builds indirect
addressing by a chain of tests, and from that he argues for a Turing machine
with a finite tape. If only backing is allowed, he glues the ends of each
string into a ring, so a backward jump can do the work of a forward one. The
argument is written out in prose, not formalised. He does not ask what the
counted mechanisms alone compute, and he gives no subrecursive bound.
*Relevance:* this is the standard universality argument, and it rests on a
**data-dependent** backing. That is the step the 1836–1838 configurations
lack, and the step `not-found` adds. It is close in kind to (C). It does not
touch (A) or (B).

**Rojas, R. "Conditional Branching is not Necessary for Universal
Computation in von Neumann Computers." *J. Universal Computer Science* 2(11),
1996, pp. 756–768. doi:10.3217/jucs-002-11-0756.** *Read.*
He shows that LOAD, STORE, INC and GOTO, used in self-modifying programs, are
universal. In §6 he shows that an external program glued into an endless
loop, with indirect LOAD/STORE, simulates a Turing machine. He leaves output
and halting aside: "the machine can be left looping in a fixed state or an
additional 'halt' instruction can be added". *Relevance:* universality from
one endless loop. It sits on the "table" side of point D in
`expressiveness.md`, not on the halting-deck side.

**Rojas, R. "How to Make Zuse's Z3 a Universal Computer." *IEEE Annals of
the History of Computing* 20(3), 1998, pp. 51–54. doi:10.1109/85.707574.**
*Read: the preprint of 5 Sept 1997, fu-berlin.de.*
With no conditional branch, a single loop of the four arithmetic operations
(the tape glued into a ring) simulates any Turing machine with a bounded
tape. The branches are replaced by arithmetic. Halting: "the master loop of
the simulation never stops". He solves this with the Z3's trap on an
undefined operation: computing 0/Q at the top of the loop stops the machine
when the state Q reaches 0. *Relevance:* it bears directly on (A) and (B).
`semantics.md` says that under rule 8 a deck with only counted backing "halts
or an operation fails", and a deck with an unconditional backing card never
halts. Rojas's construction is an endless loop that ends by a deliberate
failure. The Sketch has the same kind of thing: "by means of a bell, to give
notice that the passage through zero or infinity is taking place, and it then
stops" (Menabrea, below). So the bounds in (A) and (B) hold only if a stop on
a failed operation is not counted as a halt with an output. That should be
said wherever (A) and (B) are stated. The arithmetic used to replace a
branch is also the same in kind as the [q = i] polynomials and the flag that
`src/minsky.rs` uses for (C).

**Rojas, R. "The Computer Programs of Charles Babbage." *IEEE Annals of the
History of Computing* 43(1), 2021, pp. 6–18. doi:10.1109/MAHC.2020.3045717.**
*Abstract only (paywalled).* It reviews the 26 programs of 1836–1840 from a
programmer's point of view. Rojas (2024) cites it for the counting of
constant cards both ways in L/023. Whether it discusses expressiveness is not
known.

**Rojas, R. "How Charles Babbage Invented the Computer." arXiv:2311.04371,
2023.** *Read; the text extraction is damaged in places.* On control it says
only that there was "a provision for carrying out conditional jumps … (using
'combinatorial cards'), although it remains uncertain whether this included
both backward and forward jumps [Bromley 2000]".

**Bromley, A. G. "Charles Babbage's Analytical Engine, 1838." *Annals of the
History of Computing* 4(3), 1982, pp. 196–217. doi:10.1109/MAHC.1982.10028.
Reprinted in *IEEE Annals* 20(4), 1998.** *Read: a scan whose text is
damaged in places.* Conditional transfers are at the level of the
microprogram barrels ("running up", "conditional arm"; "multiway branches
are quite possible"). At the user level: "the cards could be ordered to move
forward and reverse (and hence to loop) independently … by an amount
controlled by the counting apparatus". But "the 'user instruction set' of
the Analytical Engine seems nowhere to be clearly stated", and "It is
difficult to write with authority on the programming and user-level
facilities." There is no variable-address mechanism (until at least 1840).
*Relevance:* Bromley says outright that the user-level control is
underdetermined by the sources, which is the premise of the three readings.
He offers no analysis of computational power.

**Bromley, A. G. "Babbage's Analytical Engine Plans 28 and 28a — The
Programmer's Interface." *IEEE Annals* 22(4), 2000.** *Not accessible.* It is
known only through Rojas (2024) and the Wikipedia article: he has "had to
adopt the minimal default assumption" that "both the operation and variable
cards can only be turned backward", "as is necessary to implement the loops
used in Babbage's sample programs", and he says "There would be no
mechanical or microprogramming difficulty" in "placing the direction of
motion under the control of the user". This concerns the 1840s design
(Plans 28, 28a), not 1836–1838.

**Menabrea, L. F. and Lovelace, A. A. "Sketch of the Analytical Engine …
with notes by the translator." *Scientific Memoirs* 3, 1843.** *Read: the
fourmilab.ch text, searched for the passages below.*
- Menabrea gives a·bⁿ: "When the number n has been introduced into the
  machine, a card will order a certain registering-apparatus to mark
  (n−1)…" and "until it only marks zero". This is a repetition count taken
  from a number in the store, as in reading (B), described in 1842.
- The bell: the machine "stops" at "the passage through zero or infinity";
  "if this process has been foreseen", it "will so dispose itself as to
  present the new cards". This is a data-dependent choice of cards.
- Note G: "V10 always decides which of two courses the succeeding processes
  are to follow, by feeling for the value of n through means of a
  subtraction". And: "the engine follows the one or the other of the two
  courses … contingently on the one or the other result of Operation 7".
- Notes E and F: "backing" and "cycles of cycles … to an indefinite
  extent".
*Relevance:* by 1842–43 the published account has a mill result choosing
the course of the cards. That is more than any configuration of 1836–1838
modelled here. It is consistent with the project's own scope note: no claim
about the engine as later designed.

**Walker, J. "The Analytical Engine" (emulator and "Is the Emulator
Authentic?"), fourmilab.ch.** *Read: the authenticity page.* The emulator
has conditional backing and advancing on the run-up lever, and admits that
some features are reconstructions ("never clearly specified"; the lockstep
card rule is "an assumption"). It makes no formal claim about computational
power.

**Wikipedia, "Analytical engine".** *Read.* It calls the design
"Turing-complete", with citations to popular sources (Science Museum; New
Scientist 2010) and to Bromley, as summarised above. No proof is given.

**Swade; Plan 28 (Graham-Cumming, Robinson, Johnstone).** *Searched; nothing
found* that analyses user-level control or computational power. Swade's
books and Bromley's Basser Department technical reports (Sydney, 1980) were
not read.

**Copeland, B. J. and Sommaruga, G. "The Stored-Program Universal Computer:
Did Zuse Anticipate Turing and von Neumann?" In Sommaruga and Strahm (eds.),
*Turing's Revolution*, Birkhäuser, 2015, pp. 43–101.
doi:10.1007/978-3-319-22156-4_3.** *Not accessible: the fetch was blocked.*
Its abstract says it assesses claims that the Analytical Engine, Colossus and
the Z3 were universal. A secondary source says it discusses the "host" of
in-principle universality proofs for old machines that followed Rojas
(1998). This is the most likely place for a discussion of "universal in
principle" against "halting", and it should be read.

**Not found:** any work that places Babbage's control (in any year) in a
subrecursive class, such as primitive recursive, elementary, Grzegorczyk
levels or LOOP depth. Every analysis found asks only "universal or not", and
assumes a conditional backing.

## 2. Bounded loops and hierarchies

**Meyer, A. R. and Ritchie, D. M. "The complexity of loop programs." *Proc.
ACM National Meeting* 1967, pp. 465–469.** *Read (people.csail.mit.edu).*
- "changes in the contents of X while P is being repeated do not alter the
  number of times P is to be repeated. The final clause is needed to ensure
  that executions of Loop programs always terminate."
- The Bounding Theorem: the running time of a program in Lₙ is bounded by
  fₙ⁽ᵏ⁾, where k is its length, f₂(x) = 2ˣ and f₃(x) is a tower of 2s of
  height x.
- L₂ is the elementary functions, and Lₙ = ℰⁿ⁺¹ for n ≥ 2.
- Loop programs compute exactly the primitive recursive functions.
*Relevance:* (A) is the Bounding Theorem pattern. Counts fixed before entry,
with fixed nesting, are bounded by a fixed iterate of an exponential, which
is a fixed-height tower. 2↑↑n is not elementary. (B) is the next level:
counts taken from computed registers, fixed at entry, with one level of
nesting that the arithmetic primitives make richer. 2↑↑n is reachable there,
and the argued C3 bound, a fixed number of iterates of x ↦ 2↑↑(cx), is the
f₃⁽ᵏ⁾ pattern. (C) breaks exactly "the final clause".

**Wikipedia, "LOOP (programming language)".** *Read.* "At shallow nesting
depths, the choice of basic instructions affects which functions are
reachable"; Loopₙ = ℰⁿ⁺¹; tetration "requires nesting depth exactly 3". It
cites Kfoury (1980, POPL), "Analysis of Simple Programs Over Different Sets
of Primitives", and Goetze and Nehrlich (1980), "The Structure of Loop
Programs and Subrecursive Hierarchies". Neither was read. Both bear on the
point that Babbage's ×, ÷ and repeated operation shift the depth at which
each class is reached.

**Ritchie, D. M. *Program Structure and Computational Complexity*, PhD
thesis, Harvard, 1968.** *Found, not read.* It generalises loop depth to
ordinals. **Ritchie, R. W. "Classes of predictably computable functions."
*Trans. AMS* 106, 1963, pp. 139–173.** *Not read.*

**Grzegorczyk, A. "Some classes of recursive functions." *Rozprawy
Matematyczne* 4, 1953.** **Kalmár, L. "Egyszerű példa eldönthetetlen
aritmetikai problémára." *Matematikai és Fizikai Lapok* 50, 1943.** *Neither
read.* They are cited for the standard facts: ℰ³ is the elementary
functions, and every elementary function is bounded by a tower of fixed
height.

**Hoare, C. A. R. "A note on the for statement." *BIT* 12, 1972,
pp. 334–341.** *Only a two-page synopsis read.* "Some languages forbid the
alteration of the limit b from within the loop body", so it "needs to be
evaluated only once"; when the counting variable cannot vary, "there is no
need of an explicit proof of termination". Algol 60, by contrast,
re-evaluates its for-list elements on each pass (course notes; the Revised
Report was not checked). *Relevance:* the difference between (B) and (C) is
the old one between a FORTRAN-style count, fixed at entry, and a bound that
can be re-set in the body.

**Minsky, M. "Recursive unsolvability of Post's problem of 'Tag' …" *Annals
of Math.* 74, 1961; *Computation: Finite and Infinite Machines*,
Prentice-Hall, 1967.** *Not read; standard.* Two-counter machines are
universal. This is what (C) relies on.

**Not found:** a paper on "counter reloading" as such, meaning a LOOP
language where only the loop's own count may be re-set inside it. That this
gives WHILE power is folklore. No source was found that states it as a
theorem.

## 3. Different classes from different readings of a historical machine

**Not found.** The nearest work:
- Bromley (2000) against Rojas (2024). Backward-only backing against both
  ways; Rojas shows that the two give the same class, by joining each string
  into a ring.
- The in-principle universality debates on the Z3 (Rojas 1998), Colossus
  (Wells, cited by Wikipedia; not read) and ENIAC. They turn on criteria
  (bounded memory, halting, rewiring), not on readings of a source.

No work was found that sets out several readings of one machine's documents
and proves that they compute different classes.

## 4. Assessment

**Known.** The mathematics of (A), (B) and (C) is classical:
- (A) is an instance of the Meyer–Ritchie Bounding Theorem, and of Kalmár
  and Grzegorczyk: a count fixed at entry, with fixed nesting, gives an
  elementary bound, and 2↑↑n is not elementary.
- (B) is the next level of the same hierarchy.
- (C): an unbounded loop gives Minsky machines. Branches built from
  arithmetic are the technique of Rojas (1996, 1998, 2024).

**Folklore-adjacent.** Two points:
- That the change from (B) to (C) is exactly the change from "count fixed
  at entry" to "count re-settable in the body".
- That an endless loop (a "table") can go beyond a halting deck, which is
  Rojas's point about the Z3.

**Apparently not in the literature searched.**
- Classifying Babbage's mechanisms of 1836–1838 by subrecursive class
  rather than "Turing-complete or not".
- The finding that the answer depends on where a repetition count comes
  from (rule 3a), with a tower bound in one reading and tetration in the
  other.
- Machine-checked proofs of either.
- That Babbage's documented counted mechanisms, without a data-dependent
  backing, are not universal. Every prior universality argument found
  assumes such a backing (Bromley; Rojas 2024; Walker), or a trap
  (Rojas 1998).

**Caveat raised by the search.** Rojas (1998) gets universality out of an
endless loop plus a stop on an undefined operation. The 1842 Sketch
describes the engine stopping at "the passage through zero or infinity". If
a failed operation in the 1836–1838 configurations ends the run with
readable columns, then (A) and (B) may only hold because of how a halt is
defined. That definition, and whether `not-found` is the only way past the
bounds, needs to be stated explicitly. Menabrea's a·bⁿ example (count taken
from n "introduced into the machine") is also 1842 evidence for reading (B).
It is evidence for that year, not for 1836–1838.

**Limits of the search.**
- Web only, in English (plus Rojas's German paper, already in
  `literature.md`).
- Paywalled or blocked, so not read: Bromley (2000), Rojas (2021),
  Copeland and Sommaruga (2015), Kfoury (1980), Goetze and Nehrlich (1980).
- Not searched: Swade's books, Bromley's 1980 Sydney reports, Rojas's 2020
  VCFB talk, and the recursion-theory texts (Grzegorczyk, Kalmár, Minsky,
  Odifreddi), which were cited from memory.
- A specialist in subrecursion or the history of computing may know of
  work this search missed.
