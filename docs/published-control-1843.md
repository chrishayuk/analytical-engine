# The control of the published accounts, 1842–1843

This page asks one question. Can a general machine be built from only the
control that Menabrea's account of 1842 and Lovelace's Notes of 1843 describe
explicitly, without either of the extensions of `expressiveness.md` (a count
set inside its own loop, `not-found`; or a trap read as the end, Model D)?

It adds a separate configuration, `1843`, and leaves Models A–D and the dated
configurations of the Sketch Books as they were. The readings of the texts are
in `sources/notes/menabrea-lovelace-1843-control.md`, and the Note G table is in
`sources/notes/note-g-table.md`. No person has checked either.

## 1. What the texts describe

Each primitive is marked as explicit (a worked case in the text), stated as a
principle (no worked case), or not described.

| Primitive | Where | Status |
|---|---|---|
| Operation cards, variable cards, results on columns | Menabrea, passim; the Note G table | Explicit |
| Backing the cards, to repeat a card or a set of cards "any number of times" | Note C, p. 706 | Explicit; the circumstances ("at pleasure, under the requisite circumstances") are not said |
| A cycle repeated a number of times fixed in advance ("limits 1 to n … regulate how often") | Note E, p. 720 | Explicit; the count is the person's choice |
| A counter ("registering-apparatus") loaded with n − 1 and run down to zero | Menabrea p. 686 | Explicit; n is given data, not computed during the run |
| **A result of the mill, zero or greater than zero, chooses between two courses** | Note G, pp. 728, 730–731: "the engine follows the one or the other of the two courses … contingently on the one or the other result of Operation 7"; "V₁₀ always decides which of two courses the succeeding processes are to follow, by feeling for the value of n through means of a subtraction" | **Explicit**, with one worked case (Operations 7, 12, 23). The mechanism is not described |
| **That this test ends the repetition of (13…23)**, a cycle repeated until a result comes to zero | Note G, pp. 728–730, read with the diagram (V₁₀ falling by one at each test) | **Reading A** of the archive note, rated moderate there: inferred, not stated. Reading B: the repetition is a counted backing (Σ(+1)ⁿ⁻², "limits"), and the test only chooses a forward course |
| Other cards brought into play when a remainder is zero ("the mill will order other cards") | Menabrea p. 687 | Stated as a principle; which cards, and how they are reached, is not said |
| The sign of a datum choosing × or ÷ | Menabrea p. 686 | Stated as a principle. Reading A of the archive note: a choice of operation; Reading B, different cards presented ("the cards … would order its division"), is not excluded |
| At "the passage through zero or infinity", if the case "has been foreseen", the engine "will so dispose itself as to present the new cards", which come "into play contingently" | Menabrea p. 685 | Stated as a principle: a choice of cards on a result; which cards, and how, is not said |
| The same stop, if not foreseen: a bell, and the engine "stops until the attendant has again set it in action" | Menabrea p. 685 | An alarm, not an end (Model D is not this) |
| The engine can "change its processes … on the occurrence of any specified contingency" | Notes E (p. 715) and G (p. 723) | Stated as a principle |

So what is explicit is a test that chooses between two courses. That the
test ends a repetition, rather than choosing a forward course after a counted
one, is a reading. Everything below that needs a cycle ended by a result
holds **under Reading A**.

Two kinds of control are kept apart:
- **Control of the cards**: what decides which card acts next (backing, a
  counted cycle, the Note G test). This page is about that.
- **Control inside the mill**: the sign choosing a mill cycle within one
  division (22 March 1836), and, on Reading A of Menabrea p. 686, × against
  ÷. It changes what one operation does, not which cards follow, and is not
  used here.

## 2. The configuration `1843`

`src/sketch.rs` and `formal/Babbage/Note43.lean` add one card to the machine
of the Sketch Books: `back LABEL if vN` (`Card43.backIf`), a backing made
effective while the number in column vN is greater than zero, and otherwise
passed over. The configuration `1843` is the configuration of 30 May 1838
with this card. Nothing else is added.

| Rule | Kind | Source |
|---|---|---|
| The backing is effective while the tested number is greater than zero, and ineffective when it is zero. | **Reading** (Reading A) | Note G, p. 728: "a result equal to zero … or a result greater than zero … and the engine follows the one or the other of the two courses". Reading A of the archive note: the repetition of (13…23) is ended by the test at Operation 23. Reading B (a counted backing with the count n − 2, V₁₀ only choosing between "finished" and "go on") is the alternative; the text describes no counter in Note G. |
| The backing goes back. | Reading | The repeated cycle (13…23) is earlier cards. A forward course ("the mill will order other cards"; the n = 1 and n = 2 courses of Operations 7 and 12) is not given a card: the texts do not say how it is reached. |
| A negative tested number lets the cards go on. | Idealisation | In the intended run of Note G the tested number is never negative. The theorems below test no negative number, so they hold if a negative number backs instead. The Note G decks for n = 1 and n = 2 do use it (§4). |

Every other rule is that of `docs/semantics.md`, except rule 10 ("nothing
chooses between cards"), which this card replaces. Under rule 14a a halt is
still passing the last card.

## 3. What follows

Each line is a theorem of `formal/Babbage/Note43.lean` (Lean 4, core library,
in CI), except where marked.

| Statement | Lean |
|---|---|
| The new card is a conservative extension: a deck of the Sketch Books runs exactly as before. | `step43_lift`, `run43_lift` |
| A counter machine translates into a deck that **halts, by passing its last card, exactly when the machine halts**, and gives off its counters. | `halts43`, `machine_halts_of_43` |
| That deck has only operation cards, result cards and the new backing: no combinatorial card, no counted or unconditional backing, no repetition card. | `deck43_plain` |
| The configuration `1843` accepts it; no configuration without the new backing does (near-definitional: the deck contains the card). | `deck43_accepted`, `deck43_refused` |

So, given Minsky's theorem (cited, not formalised), and **under Reading A**,
the configuration of the published accounts is general under the ordinary meaning of a halt, with no
count set inside its own loop and no trap. Only the Note G test is needed. The
counted mechanisms of 1837 and 1838, Menabrea's counter and the combinatorial
wheels, are not used at all.

The translation (`deck43`, and `Ending::Cond1843` in `src/minsky.rs`):
- each flag [c_r > 0] is a cycle the new backing ends: K := 0; then F := K;
  K := 1; U := c_r × (1 − F); back while U > 0. The first pass writes 0 and
  leaves U = c_r; if c_r > 0, a second pass writes 1 and leaves U = 0;
- each pass of the whole deck is one step of the machine, as in `compile`;
- the pass ends W := W − 1 and backs to the first card while W > 0, where W − 1
  is 1 while the machine runs and 0 once it has halted; the counters are then
  given off.

Tested in Rust (`tests/control.rs`, `counter_machines_in_1843`), and the Lean
model and the Rust machine agree on the decks of `scripts/lean-diff.sh`, which
now include the new card: 3,911 runs, among them 814 runs of 407 random decks
with it (each with and without the trap), the
counter-machine decks of `1843`, and the earlier ones. That is a test, not a
proof.

## 4. Note G, run

`control/note-g-printed.txt` and `control/note-g-corrected.txt` are Lovelace's
table of 25 operations for B₇ (her numbering; −1/30, B₈ today), with the
repetition of (13…23) as `back op13 if v10` (`tests/note_g.rs`). Only `1843`
accepts them. Read from a camera image 4,368 px wide (the plate about 2,200 px of it)
(`sources/notes/note-g-table.md`, which has the row-by-row transcription and
the uncertain cells).

| Deck | Result (V₂₄; V₂₅ for n = 5, V₂₃ for n = 3) | Passes of (13…23) |
|---|---|---|
| As printed, n = 4 | −95/126 | 2 |
| Corrected, n = 4 | −1/30 | 2 |
| Corrected, n = 5 | B₉ = 5/66 | 3 |
| Corrected, n = 3 | 1/42 | 1 |

The three corrections, each with its source in the table note:
1. Operation 4 is printed V₅ ÷ V₄; the plate's own statement of results gives
   V₄ ÷ V₅. Also stated by Wikipedia, "Note G" §Error (secondary), whose
   figure for the uncorrected program, −25621/630, was not reproduced.
2. Operation 21 must take B₅ from V₂₃ on the repetition (text, p. 728); the
   plate shows the first pass only. This machine cannot advance a variable
   card, so the deck copies V₂₂, V₂₃, V₂₄ to three working columns and shifts
   them down after each Operation 21: six cards not in the table, right for
   n ≤ 5.
3. Operation 24 adds; by equation (9), B₇ = −V₁₃. The text says the table
   leaves the signs aside (p. 727).

The cycle runs n − 2 times, as "Σ(+1)ⁿ⁻²" on p. 730 says, and V₁₀ ends at 0.

**Limitations.** The tests at Operations 7 and 12 are not expressed: their
other course goes forward, and the machine has only the backward test. The
deck takes the course for n > 2. For n = 1 and 2 the values still come out
right, but V₁₀ ends at −2 or −1, and those runs halt only because a negative
number lets the cards go on (§2). The zeroing of columns is done by extra mill
operations, where the engine's variable cards would do it. Superscripts and
the series of Numbers are not modelled.

## 5. Against Rojas (2024)

Rojas, "Unconventional universal computation in Babbage's Analytical Engine"
(arXiv:2408.03334), argues that the engine is universal. He assumes, after
Bromley (2000), a conditional jump: a store column tested for zero, and if it
passes, both strings of cards backed n and m cards, n and m punched on cards.
From it he builds indirect addressing and a Turing machine with a finite
tape. His argument is in prose.

What is the same: universality from a backing made conditional on a result of
the mill. That is his result, and it is not claimed here.

What this page adds, as far as it goes:
- the primitive is taken from one place in the 1843 text (Note G's V₁₀),
  read one way, with the other reading stated; only a backward test is used,
  where Rojas's jump backs both strings by amounts punched on cards;
- no counted mechanism, combinatorial card or indirect addressing is needed;
- the translation is a theorem in Lean, with the halting of the deck tied to
  the halting of the machine in both directions; Minsky's theorem is cited;
- Note G itself runs on the same machine, with its errors.

Bromley (2000) was not read (paywalled), so his reading of the conditional
mechanism is known only through Rojas.

## 6. What this does not show

- That the 1843 engine was built to do this. The texts describe the
  conditional course as a principle with one worked case; the mechanism is
  first described in Babbage's *Passages* (1864, p. 134), which is later.
- That Reading A of Note G is right. Under Reading B, the cycle (13…23) is a
  counted backing and V₁₀ only chooses whether a Number is finished. Then the
  explicit test still decides between two courses, but a forward one, which
  this machine does not have; whether a general machine follows from Reading B
  alone has not been worked out.
- Anything about the dated configurations of 1836–1838, which are unchanged.
- That the Note G decks run the same in Lean. Operation 1 writes three
  columns, which the Lean model's operation card cannot, so the Note G decks
  are not in the Lean–Rust comparison and their results rest on the Rust
  machine alone. The Lean theorems are over whole numbers; Note G needs
  fractions, which only the Rust and the random fraction decks of the
  comparison exercise.
- Much in the comparison for `1843`: only the counter machine `add`, on two
  inputs, besides the random decks.
- That a configuration accepts the same older decks: `step43_lift` proves
  they run the same; that `Accepts43` agrees with `Accepts` on them is
  evident from the definitions, not a theorem.
