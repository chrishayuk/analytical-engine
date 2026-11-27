# Menabrea (1842), Lovelace (1843) and *Passages* (1864): conditional control and how a computation ends

Read by a coding agent, November 2026. **No person has checked these
readings.** The questions were:

- **(a) Conditional control.** Does anything in the 1842/1843 texts let a
  computed result (its sign, its being zero, a comparison) choose which cards
  come next, set a repetition count, or end a cycle?
- **(b) Termination.** How does a computation end? What happens at "the
  passage through zero or infinity", on division by zero, or at an impossible
  operation? Is such a stop a deliberate end (results standing), an alarm (a
  bell), or a failure?

Each passage is given as **Observation** (what the text says, quoted
exactly), **Reading** (what it plausibly means for the control, with the
alternatives), and **Hypothesis** (anything further). Readings and
hypotheses are the agent's own. No secondary literature was used.

## Sources and how they were read

| Text | Copy read | How checked |
|---|---|---|
| L. F. Menabrea, *Notions sur la machine analytique de M. Charles Babbage* (French) | Offprint, 27 pp., "Tiré de la Bibliothèque Universelle de Genève. (Octobre 1842.)", Accademia delle Scienze di Torino copy: <https://archive.org/details/TO01056056> (PDF and OCR text) | Key pages (14, 21–24) read from the page images rendered from the PDF; the OCR is poor in formulae |
| A. A. L. [Lovelace], translation and Notes A–G, *Scientific Memoirs* vol. 3 (1843), pp. 666–731 | English Wikisource page transcriptions of the scan, `https://en.wikisource.org/wiki/Page:Scientific_Memoirs,_Vol._3_(1843).djvu/<N>` (raw wikitext via `&action=raw`), and the scan images from Wikimedia Commons (`File:Scientific_Memoirs,_Vol._3_(1843).djvu`, `page<N>`) | Pp. 685, 728, 730 and the Note G diagram checked against the scan images; the rest from the Wikisource transcription (proofread "level 4" except where noted). Also compared with <https://www.fourmilab.ch/babbage/sketch.html> |
| C. Babbage, *Passages from the Life of a Philosopher* (1864), ch. VIII "Of the Analytical Engine" (pp. 112–) | <https://archive.org/details/passagesfromlife00babb> (OCR text, and page images `…/page/n<leaf>_w700.jpg`) | Pp. 122, 134, 135 checked against the page images; pp. 114, 119–120, 131–133 from the OCR only |

**Page numbers.** English page numbers are the printed numbers of
*Scientific Memoirs* vol. 3, read from the running heads. Wikisource djvu
index N = printed page + 10 up to p. 722, and printed page + 12 from p. 723
(djvu 733–734 are the folding Note G diagram). French page numbers are those
of the **offprint**, not of the journal (n.s. 41, pp. 352–376). The mapping
from offprint pages to journal pages was **not** established; the offprint
has 27 pages against the journal's 25, so a simple offset cannot be assumed.

**Transcription notes.** In the French and in the English the word printed is
"cos." where "cas"/"case" is plainly meant ("le cos. de n = ∞", offprint
p. 24; "the cos of n = ∞", p. 687). Fourmilab renders this "the cos of
n=1/0" and drops Lovelace's page references ("alluded to by M. Menabrea"
for "… in page 680"). The Wikisource transcription of the Note G diagram has
Operation 23 as "²V₁₀ **+** ¹V₁"; the scan (read at low resolution, 1920 px
across the whole plate) has "− ²V₁₀ − ¹V₁ … ³V₁₀ … = n − 3 (= 1)". Use the
scan.

---

## 1. Menabrea: a card held for a fixed number of repetitions

**Observation.** French, offprint pp. 14–15:

> Ainsi l'on pourra, au besoin, n'employer que trois cartons des opérations ;
> pour cela il suffira d'introduire dans la machine un appareil qui, par
> exemple, après la première multiplication, retienne le carton relatif à
> cette opération, et ne lui permette d'avancer, pour être remplacé par un
> autre, que lorsque cette même opération aura été répétée quatre fois.

English, p. 680 (Wikisource djvu/690):

> Therefore, if desired, we need only use three operation cards; to manage
> which, it is sufficient to introduce into the machine an apparatus which
> shall, after the first multiplication, for instance, retain the card which
> relates to this operation, and not allow it to advance so as to be replaced
> by another one, until after this same operation shall have been four times
> repeated.

**Reading.** A counted repetition of one operation card, with the count
(four) fixed by the problem. Nothing computed decides it. This matches the
Sketch Book "repetition" of an operation.

## 2. Menabrea: the bell, "the passage through zero or infinity"

**Observation.** French, offprint pp. 21–22 (read from the page image):

> Il y a certaines fonctions qui doivent changer de nature lorsqu'elles
> passent par zéro ou l'infini, ou dont les valeurs ne sauraient être admises
> au delà de ces limites. Lorsque ces cas se présentent, la machine au moyen
> d'une sonnerie peut avertir que le passage par zéro ou l'infini a lieu, et
> alors elle s'arrête, jusqu'à ce que le gardien l'ait remise en action pour
> telle autre opération qu'on voudra lui ordonner. Si cette opération est
> prévue, la machine, au lieu de sonner, se disposera de manière à présenter
> les nouveaux cartons relatifs à l'opération qui doit succéder au passage par
> zéro et l'infini. Ces nouveaux cartons peuvent faire suite aux premiers et
> n'entrer en jeu que lorsque les deux circonstances indiquées précédemment
> auront lieu.

English, p. 685 (djvu/695; checked against the scan):

> There are certain functions which necessarily change in nature when they
> pass through zero or infinity, or whose values cannot be admitted when they
> pass these limits. When such cases present themselves, the machine is able,
> by means of a bell, to give notice that the passage through zero or
> infinity is taking place, and it then stops until the attendant has again
> set it in action for whatever process it may next be desired that it shall
> perform. If this process has been foreseen, then the machine, instead of
> ringing, will so dispose itself as to present the new cards which have
> relation to the operation that is to succeed the passage through zero and
> infinity. These new cards may follow the first, but may only come into play
> contingently upon one or other of the two circumstances just mentioned
> taking place.

**Observation (translation).** The French ends "n'entrer en jeu que lorsque
les deux circonstances indiquées précédemment auront lieu" ("come into play
only when the two circumstances indicated above take place"). Lovelace's
"contingently upon one or other of the two circumstances" is more explicit
that either event (zero or infinity) is enough. The French *gardien* is her
"attendant".

**Reading.**

- Two outcomes for one detected event. (i) **Unforeseen:** bell, then the
  engine stops and waits for a person, who restarts it "for whatever process
  it may next be desired". (ii) **Foreseen:** no bell. The engine "disposes
  itself" to present other cards, which sit after the first ones and act
  only if the event occurs. Outcome (ii) is a conditional choice of cards
  made by a result.
- The stop in (i) is an **alarm and a halt for human action**. It is not
  described as the end of a computation, and the text says nothing about the
  results then standing in the store or being printed. "Again set it in
  action for whatever process" implies that the computation continues under
  a person's direction, not that it is finished.
- What is "passage through zero or infinity" mechanically? The text does not
  say. Reading A: a sign change, or a result going to zero (zero) and
  overflow beyond the wheels (infinity). That is how Babbage himself explains
  it in 1864 (§9 below). Reading B: the term is mathematical, about functions
  whose form changes at singular points, and the engine is told in advance
  where they are. The phrase "is able … to give notice that the passage …
  is taking place" favours a detection in the machine (Reading A).
- **Division by zero** is not mentioned as such. "Whose values cannot be
  admitted when they pass these limits" is the closest phrase. Nothing says
  that dividing by zero is what triggers the bell.

**Hypothesis.** The unforeseen case behaves like a trap that hands over to an
operator: halt and signal. Nothing in it suggests the trap is meant as the
normal way to end a program.

## 3. Menabrea: a power aⁿ with a counter; the sign chooses × or ÷

**Observation.** French, offprint pp. 22–23 (read from the page images):

> Mais lorsque n sera donné pour le cas particulier que l'on veut calculer,
> il sera encore nécessaire que la machine borne ses multiplications aux
> nombres convenables. … Lorsque le nombre n aura été introduit dans la
> machine, un carton ordonnera à un *compteur* de marquer (n − 1) et en même
> temps fera exécuter la multiplication de b par b. Quand celle-ci sera
> achevée, le compteur aura effacé une unité et ne marquera plus que (n − 2),
> … Alors une nouvelle unité s'effacera sur le compteur, et les opérations
> indiquées se répéteront jusqu'à ce que le compteur ne marque plus que zéro.
> Ainsi le nombre bⁿ se trouvera écrit sur la colonne V₃, et la machine
> poursuivant le cours de ses autres opérations, ordonnera le produit de bⁿ
> par a, et le calcul demandé se trouvera achevé sans que le nombre de cartons
> à employer ait dû varier avec la valeur de n. Si n était négatif, les
> cartons, au lieu d'ordonner la multiplication de a par bⁿ, ordonneraient
> la division, ce qui peut se concevoir, puisque tout nombre peut être écrit
> avec son signe respectif et réagir de cette manière sur la nature des
> opérations à exécuter.

English, p. 686 (djvu/696):

> But when n is given for the particular case to be calculated, it will be
> further requisite that the machine limit the number of its multiplications
> according to the given values. The process may be thus arranged. The three
> numbers a, b and n will be written on as many distinct columns of the
> store; we shall designate them V₀, V₁, V₂; the result abⁿ will place
> itself on the column V₃. When the number n has been introduced into the
> machine, a card will order a certain registering-apparatus to mark (n − 1),
> and will at the same time execute the multiplication of b by b. When this
> is completed, it will be found that the registering-apparatus has effaced a
> unit, and that it only marks (n − 2); … Another unit is then effaced from
> the registering-apparatus, and the same processes are continually repeated
> until it only marks zero. Thus the number bⁿ will be found inscribed on V₃,
> when the machine, pursuing its course of operations, will order the product
> of bⁿ by a; and the required calculation will have been completed without
> there being any necessity that the number of operation-cards used should
> vary with the value of n. If n were negative, the cards, instead of
> ordering the multiplication of a by bⁿ, would order its division; this we
> can easily conceive, since every number, being inscribed with its
> respective sign, is consequently capable of reacting on the nature of the
> operations to be executed.

**Reading.**

- **Repetition count from a number in the store.** n is a datum written on
  column V₂. A card orders the counter (*compteur*, "registering-apparatus")
  to "mark (n − 1)", and the cycle ends when the counter "only marks zero".
  So the count is taken from a column value, not set by hand or punched on a
  card. Reading A: the counter is loaded from V₂ (the value goes from the
  store to a counting apparatus). Reading B: "when the number n has been
  introduced into the machine" refers to the person entering n, and the
  counter is set at the same time. The French "lorsque le nombre n aura été
  introduit dans la machine" does not settle which. In this example n is
  **given data**, not a result computed earlier. Nothing says the counter
  could be loaded from a computed result, though nothing rules it out.
- **The cycle ends on a counter reaching zero.** The text separates this
  counter from the store columns.
- **The sign of n chooses multiplication or division.** "Every number, being
  inscribed with its respective sign, is consequently capable of reacting on
  the nature of the operations to be executed." Reading A: the sign of a
  store value changes which operation the mill performs (a choice of
  operation, not of cards). Reading B: different cards are presented for
  negative n. The text says "the cards … would order its division". This is a
  data-dependent choice stated as a principle. It is not worked out
  mechanically, and here too n is given data.
- Fractional n "of the form p/q": "the machine would bring into action two
  sets of processes" (*deux appareils*). The choice of processes depends on
  the form of the datum. The text does not say how the choice is made.

## 4. Menabrea: "if the remainder is nothing … the mill will order other cards"

**Observation.** French, offprint p. 23 (read from the page image):

> Pour cela les cartons pourront ordonner que m + q et n + p soient
> transportés dans le moulin pour y être soustraits l'un de l'autre ; si le
> reste est nul, comme cela doit avoir lieu dans l'hypothèse admise, le
> moulin ordonnera à d'autres cartons de lui porter les coefficients Ab et aB
> pour les sommer ensemble, et les donner ainsi pour coefficient au terme
> unique xⁿ⁺ᵖ = xᵐ⁺ᑫ.
>
> Cet exemple nous montre comment les cartons peuvent reproduire toutes les
> opérations qu'exécute l'intelligence pour arriver à un résultat déterminé,
> lorsque ces opérations sont elles-mêmes susceptibles d'être nettement
> précisées.

English, pp. 686–687 (djvu/696–697):

> For this purpose, the cards may order m+q and n+p to be transferred into
> the mill, and there subtracted one from the other; if the remainder is
> nothing, as would be the case on the present hypothesis, the mill will
> order other cards to bring to it the coefficients Ab and Ba, that it may
> add them together and give them in this state as a coefficient for the
> single term xⁿ⁺ᵖ = xᵐ⁺ᑫ.
>
> This example illustrates how the cards are able to reproduce all the
> operations which intellect performs in order to attain a determinate
> result, if these operations are themselves capable of being precisely
> defined.

**Reading.** This is the most direct statement in the 1842 text of a
**comparison deciding the cards**: subtract two computed exponents. If the
remainder is zero, "the mill will order other cards". The subject of
"ordonnera" is the mill, so the mill's result is what directs the cards. The
text describes only the zero branch. It says nothing about what happens when
the remainder is not zero, or how the other cards are reached (skipping ahead
or a separate set). Reading A: the zero result brings into play cards that
would otherwise be passed over (a conditional skip or advance). Reading B:
the mill only signals and the card mechanism does the selecting. That is the
same thing under another description.

## 5. Menabrea: π "foreseen"; the engine "is no thinking being"

**Observation.** French, offprint pp. 23–24:

> On peut demander à la machine non-seulement d'exécuter le calcul de cette
> expression fractionnaire, mais encore d'indiquer immédiatement que sa
> valeur devient celle même du rapport de la circonférence au diamètre
> lorsque n est infini, cas dans lequel le calcul serait impossible.
> Observons que l'on exigerait ainsi que la machine interprétât un résultat
> non évident par lui-même, ce qui n'est point dans ses attributions,
> puisqu'elle n'est point un être pensant. Cependant lorsque le cos. de
> n = ∞ a été prévu, un carton peut ordonner immédiatement la substitution
> de la valeur de π …

English, p. 687 (djvu/697):

> We may require the machine not only to perform the calculation of this
> fractional expression, but further to give indication as soon as the value
> becomes identical with that of the ratio of the circumference to the
> diameter when n is infinite, a case in which the computation would be
> impossible. Observe that we should thus require of the machine to interpret
> a result not of itself evident, and that this is not amongst its
> attributes, since it is no thinking being. Nevertheless, when the cos of
> n = ∞ has been foreseen, a card may immediately order the substitution of
> the value of π (π being the ratio of the circumference to the diameter),
> without going through the series of calculations indicated.

**Reading.** "A case in which the computation would be impossible" is a
non-terminating limit (n infinite), not a failed operation. The remedy is
**planning ahead by the person preparing the cards**: a card supplies π (a
"card of numbers"). There is no detection or test. This passage limits the
others: the engine does not recognise a result. It can only act on events
that were provided for in advance.

## 6. Lovelace, Note C and Note E: backing; cycles; "limits … regulate how often"

**Observation.** Note C, p. 706 (djvu/716):

> A method was devised of what was technically designated *backing* the
> cards in certain groups according to certain laws. The object of this
> extension is to secure the possibility of bringing any particular card or
> set of cards into use *any number of times successively* in the solution
> of one problem. … by causing the prism over which the train of
> pattern-cards is suspended, to revolve *backwards* instead of *forwards*,
> at pleasure, under the requisite circumstances; until, by so doing, any
> particular card, or set of cards, that has done duty once, and passed on
> in the ordinary regular succession, is brought back to the position it
> occupied just before it was used the preceding time. The prism then
> resumes its *forward* rotation, and thus brings the card or set of cards in
> question into play a second time. This process may obviously be repeated
> any number of times.

Note E, pp. 716–717 (djvu/726–727):

> A cycle of operations, then, must be understood to signify any set of
> operations which is repeated more than once. … In many cases of analysis
> there is a *recurring group* of one or more *cycles*; that is, a *cycle of
> a cycle*, or a *cycle of cycles*.

and on series division:

> It is of course to be remembered that the process of algebraical division
> in reality continues *ad infinitum*, except in the few exceptional cases
> which admit of an exact quotient being obtained. The number n in the
> formula (4.), is always that of the number of terms we propose to
> ourselves to obtain …

Note E, p. 719 (djvu/729), varying cycles:

> … where each cycle contains the same group of operations, but in which the
> number of repetitions of the group varies according to a fixed rate, with
> every cycle.

Note E, p. 720 (djvu/730; checked against the scan):

> Σ, in reality, here indicates that when a certain number of cards have
> acted in succession, the prism over which they revolve must *rotate
> backwards*, so as to bring those cards into their former position; and the
> limits 1 to n, 1 to p, &c., regulate how often this backward rotation is to
> be repeated.

**Reading.**

- Backing is "at pleasure, under the requisite circumstances" (Note C). The
  phrase does not say whether the circumstances are a count or a result.
- In Note E the number of repetitions is **a count fixed by the person
  preparing the problem**: "the number of terms we propose to ourselves to
  obtain", and "limits 1 to n … regulate how often". A non-terminating
  process (division *ad infinitum*) is ended by choosing n in advance, not by
  a test.
- A varying cycle's count "varies according to a fixed rate". That is a
  count fixed by a rule known in advance, not by a computed value. Note E
  does not say how the engine knows the current count (a counter, or a
  test).

## 7. Lovelace, Note E: "on the occurrence of a specified contingency"

**Observation.** Note E, p. 715 (djvu/725):

> The substitution made by the engine of the processes in the second side of
> (3.) for those in the first side, is an excellent illustration of the
> manner in which we may arbitrarily order it to substitute any function,
> number, or process, at pleasure, for any other function, number or
> process, on the occurrence of a specified contingency.

Note G, p. 723 (djvu/735), the list of the engine's powers:

> It can provide for singular values. Its power of doing this is referred to
> in M. Menabrea's memoir, page 685, where he mentions the passage of values
> through zero and infinity. The practicability of causing it arbitrarily to
> change its processes at any moment, on the occurrence of any specified
> contingency (of which its substitution of (½ cos (n+1)θ + ½ cos (n−1)θ)
> for (cos nθ . cos θ), explained in Note E., is in some degree an
> illustration), at once secures this point.

**Reading.** Lovelace links Menabrea's bell passage to a general power: to
"change its processes at any moment, on the occurrence of any specified
contingency". Her own illustration is weak, and she says so ("in some
degree"). The cos substitution in Note E is applied to terms whose form is
known when the cards are prepared. No result is tested. So this passage
states the principle of conditional change of process but gives no example
of a test by result. The example in Note G (§8) does.

## 8. Lovelace, Note G: Operation 7, "two courses", V₁₀; "stop altogether"

**Observation.** Note G, p. 728 (djvu/740; checked against the scan):

> Operation 7 will be unintelligible, unless it be remembered that if we were
> calculating for n = 1 instead of n = 4, Operation 6 would have completed
> the computation of B₁ itself; in which case the engine, instead of
> continuing its processes, would have to put B₁ on V₂₁; and then either to
> stop altogether, or to begin Operations 1, 2…7 all over again for value of
> n (= 2), in order to enter on the computation of B₃; (having hovever [sic]
> taken care, previous to this recommencement, to make the number on V₃
> equal to *two*, by the addition of unity to the former n = 1 on that
> column). Now Operation 7 must either bring out a result equal to zero (if
> n = 1); or a result *greater* than *zero*, as in the present case; and the
> engine follows the one or the other of the two courses just explained,
> contingently on the one or the other result of Operation 7. In order fully
> to perceive the necessity of this *experimental* operation, it is
> important to keep in mind what was pointed out, that we are not treating a
> perfectly isolated and independent computation, but one out of a series of
> antecedent and prospective computations.

> Card 12 has to perform the same office as Card 7 did in the preceding
> section; since, if n had been = 2, the 11th operation would have completed
> the computation of B₃.

> Card 23 has the office of Cards 11 and 7 to perform, since if n were = 3,
> the 21st and 22nd operations would complete the computation of B₅. As our
> case is B₇, the computation will continue one more stage; and we must now
> direct attention to the fact, that in order to compute A₇ it is merely
> necessary precisely to repeat the group of Operations 13 to 20; and then,
> in order to complete the computation of B₇, to repeat Operations 21, 22.

("Cards 11 and 7" is as printed. From the diagram, the test cards are 7, 12
and 23, so "11" looks like a slip for "12".)

The diagram (folding plate after p. 722, djvu/734, scan read at low
resolution): Operation 7 is "− ¹V₃ − ¹V₁ → ¹V₁₀ … = n − 1 (= 3)";
Operation 12 is "− ¹V₁₀ − ¹V₁ → ²V₁₀ … = n − 2 (= 2)"; Operation 23 is
"− ²V₁₀ − ¹V₁ → ³V₁₀ … = n − 3 (= 1)". Below Operation 23: "Here follows a
repetition of Operations thirteen to twenty-three". Operation 25 is
"+ ¹V₁ + ¹V₃ → ¹V₃ … = n + 1 = 4 + 1 = 5", with V₆ and V₇ zeroed "by a
Variable-card".

Note G, p. 729 (djvu/741):

> At the termination of the *repetition* of operations (13…23) in computing
> B₇, the alterations in the values on the Variables are, that
> V₆ = 2n − 4 instead of 2n − 2. V₇ = 6 … 4. V₁₀ = 0 … 1. …
> In this state the only remaining processes are first: to transfer the value
> which is on V₁₃, to V₂₄; and secondly to reduce V₆, V₇, V₁₃ to zero, and to
> add one to V₃, in order that the engine may be ready to commence computing
> B₉.

and its footnote:

> … during the processes for the computation of *millions* of these Numbers,
> no other arbitrary modification would be requisite in the arrangements,
> excepting the above simple and uniform provision for causing one of the
> data periodically to receive the finite increment unity.

Note G, p. 730 (djvu/742; checked against the scan):

> (1…7), (8…12), Σ(+1)ⁿ⁻² (13…23), (24, 25) … B₂ₙ₋₁ = nth …
>
> Again, (1…7), (24, 25), Σ(+1)ⁿ [limits 1 to n] {(1…7), (8…12),
> Σ(n+2)(13…23), (24, 25)} [limits 0 to (n+2)] represents the total
> operations for computing every number in succession, from B₁ to B₂ₙ₋₁
> inclusive.

> V₁₀ always decides which of two courses the succeeding processes are to
> follow, by feeling for the value of n through means of a subtraction; and
> so on; but we shall not enumerate further.

(The last sentence runs over to p. 731: "…through means of a subtraction".)

Note G, p. 727 (djvu/739):

> … we suppose the engine to be in the course of computing the Numbers to an
> indefinite extent, from the very beginning …

**Reading.**

- **A computed result chooses the course.** Operation 7 is a subtraction
  whose result is zero or greater than zero, "and the engine follows the one
  or the other of the two courses … contingently on the one or the other
  result of Operation 7". The tested quantity is a Working-Variable (V₁₀)
  holding n − 1, then n − 2, n − 3 … It is recomputed by subtraction at
  Operations 7, 12 and 23, so the tested value is a **result of the mill**,
  not a counter. This is a zero test, not a sign test, as described. The
  values tested are never negative in the intended run.
- **What each course is.** On zero (B₂ₙ₋₁ complete), the text's course is
  "put B on its result column, and then either stop altogether, or begin
  Operations 1…7 all over again", after adding one to V₃. On greater than
  zero, continue with the next group, or repeat (13…23).
- **Does a result set the repetition count, or end a cycle?** The number of
  repetitions of (13…23) is n − 2 ("Σ(+1)ⁿ⁻²"). Reading A: it is **ended by
  the test at Operation 23** (V₁₀ reaching zero), so a computed result ends
  the cycle and no counter is loaded. This is what "V₁₀ always decides which
  of two courses … by feeling for the value of n through means of a
  subtraction" says, and the diagram shows V₁₀ falling by one at each test.
  Reading B: the Σ notation with "limits" (Note E's "the limits … regulate
  how often this backward rotation is to be repeated") is read as a counted
  backing, with the count n − 2 taken from n. Then V₁₀ only selects between
  "this B is finished" and "go on". The text does not describe a counter in
  Note G. It does describe a test that is repeated at each pass (Card 23
  "has the office of" Cards 12 and 7). Reading A fits the text better.
  (Amended 27 Nov 2026: the Reading B deck, `control/note-g-reading-b.txt`,
  takes the count n − 2 from V₁₀ after Operation 12, a number computed in the
  run and put on the wheels from the store, as rule 4 of `docs/semantics.md`
  allows. The text does not say where the count comes from; a number card
  would mean changing the deck for each n. So the sentence that follows holds
  of the text, not of that encoding.)
  Neither reading has the engine load a count computed during the run into a
  counter.
- **How the whole computation ends.** "Either to stop altogether, or to begin
  … all over again". The text does not say what decides between stopping and
  starting again, or how the stop is made: no bell, no card, no test is named.
  Elsewhere the engine is supposed to compute "to an indefinite extent", and
  the "total operations" formula is bounded by the outer limit n
  ("limits 1 to n"), a count fixed in advance. Reading A: stopping is the
  attendant's choice, or the end of the card train. Reading B: the outer
  cycle Σ(+1)ⁿ is a counted backing that runs out after n Numbers, and the
  engine then stops. The text supports neither over the other.
- **Results standing at the stop.** Each B is placed on its own result column
  (V₂₁, V₂₂, …) before the "stop altogether or begin again" choice, so a stop
  at that point leaves the results on the store. That is the closest the
  texts come to a deliberate normal end with results standing. It is
  **not** tied to a bell, an impossible operation or a passage through zero
  or infinity.

**Hypothesis.** The Note G "two courses" are a conditional branch on a zero
test of a mill result. Together with backing, this gives a loop whose exit is
decided by data. Whether the engine's hardware for this was the Menabrea
"bell or foreseen cards" mechanism (detection of passage through zero) is not
said in the 1843 text. Babbage's 1864 account (§9) does say so.

## 9. *Passages* (1864), ch. VIII: bells, zero/infinity detection, Mosotti's question

These are Babbage's retrospective statements (published 1864, describing
conversations in and after 1840). They are not evidence of what the 1843
texts meant, but they are Babbage's own account of the same features.

**Observation (bell 1: a table lookup).** pp. 119–120 (OCR):

> I then added that when the machine wanted a tabular number, say the
> logarithm of a given number, that it would ring a bell and then stop
> itself. On this, the attendant would look at a certain part of the
> machine, and find that it wanted the logarithm of a given number, say of
> 2303. … Upon this the engine would first ascertain whether the assistant
> had or had not given him the correct logarithm of the number; if so, it
> would use it and continue its work. But if the engine found the attendant
> had given him a wrong logarithm, it would then ring a louder bell, and stop
> itself.

p. 122 (checked against the page image; running head "STOPS AND RINGS A
BELL."):

> Now when the Engine requires a tabular number, it will stop, ring a bell,
> and ask for such number. … When the attendant has placed a tabular card in
> the Engine, the first step taken by it will be to verify the *number* of
> the card given it by subtracting its number from 2 3 0 3, the number whose
> logarithm it asked for. If the remainder is zero, then the engine is
> certain that the logarithm must be the right one, since it was computed and
> punched by itself. … The Engine will always reject a wrong card by
> continually ringing a loud bell and stopping itself until supplied with the
> precise intellectual food it demands.

**Reading.** Here a bell and a stop are a **request for input** (stop and
wait, then continue) and an **error alarm** (wrong card). Both are followed
by continuation, and neither is an end of computation. The check is a zero
test on a subtraction, and it decides between "continue" and "louder bell
and stop".

**Observation (Mosotti; detection of zero and infinity; backing on
conditions).** pp. 131–135 (pp. 134–135 checked against the page images):

> … he had no conception how the machine could perform the act of judgment
> sometimes required during an analytical inquiry, when two or more different
> courses presented themselves, especially as the proper course to be adopted
> could not be known in many cases until all the previous portion had been
> gone through. (p. 131)

> His real difficulty consisted in teaching the engine to know when to change
> from one set of cards to another, and back again repeatedly, at intervals
> not known to the person who gave the orders. (p. 133)

> But here a difficulty arises: successive powers of ten are to be
> substituted for x in the equation, until a certain event happens. A set of
> cards may be provided to make the substitution of the highest power of ten,
> and similarly for the others; but on the occurrence of a certain event,
> namely, the change of a sign from + to −, this stage of the calculation is
> to terminate.
>
> Now at a very early period of the inquiry I had found it necessary to
> teach the engine to know when any numbers it might be computing passed
> through zero or infinity.
>
> The passage through zero can be easily ascertained, thus: Let the
> continually-decreasing number which is being computed be placed upon a
> column of wheels in connection with a carrying apparatus. After each
> process this number will be diminished, until at last a number is
> subtracted from it which is greater than the number expressed on those
> wheels.
>
> Thus let it be . 00000,00000,00000,00423
> Subtract . . . 00000,00000,00000,00511
> [result] 99999,99999,99999,99912
>
> Now in every case of a carriage becoming due, a certain lever is
> transferred from one position to another in the cage next above it.
>
> Consequently in the highest cage of all (say the fiftieth in the Analytical
> Engine), an arm will be moved or not moved accordingly as the carriages do
> or do not run up beyond the highest wheel.
>
> This arm can, of course, make any change which has previously been decided
> upon. In the instance we have been considering it would order the cards to
> be turned on to the next set. (p. 134)

> If we wish to find when any number, which is increasing, exceeds in the
> number of its digits the number of wheels on the columns of the machine,
> the same carrying arm can be employed. Hence any directions may be given
> which the circumstances require.
>
> It will be remarked that this does not actually prove, even in the
> Analytical Engine of fifty figures, that the number computed has passed
> through infinity; but only that it has become greater than any number of
> fifty places of figures. …
>
> It may here be remarked that in the process, the cards employed to make
> the substitutions of the powers of ten are *operation* cards. They are,
> therefore, quite independent of the numerical values substituted. Hence the
> same set of operation cards which order the substitutions 1 × 10ⁿ will, if
> backed, order the substitution of 2 × 10ⁿ, &c. We may, therefore, avail
> ourselves of mechanism for backing these cards, and call it into action
> whenever the circumstances themselves require it.
>
> The explanation of M. Mosotti's difficulty is this:—Mechanical means have
> been provided for backing or advancing the operation cards to any extent.
> There exist means of expressing the conditions under which these various
> processes are required to be called into play. It is not even necessary
> that two courses only should be possible. Any number of courses may be
> possible at the same time; and the choice of each may depend upon any
> number of conditions. (p. 135)

(The OCR text gives the subtraction result as "09999,…"; the page image has
"99999,99999,99999,99912".)

**Reading.**

- Babbage's own account of "passage through zero" is **a carriage running
  beyond the highest wheel on a subtraction** (a borrow out of the top, so
  the result goes below zero). "Passage through infinity" is **the same arm
  on an increasing number exceeding the wheels** (overflow). He states that
  overflow is not a true infinity.
- The arm "can … make any change which has previously been decided upon". In
  the example it "would order the cards to be turned on to the next set".
  That is: **a sign change ends a counted-by-event cycle and advances the
  cards**. The cycle here (substituting 1×10ⁿ, 2×10ⁿ, … by backing the same
  cards) runs **until a computed result changes sign**. The number of
  repetitions is not known in advance ("at intervals not known to the person
  who gave the orders").
- "Backing or advancing the operation cards to any extent … the choice of
  each may depend upon any number of conditions". This is a general claim of
  conditional backing and advancing.
- This is the mechanism Menabrea's "foreseen" case (§2) needs. In 1864 it is
  presented as a **normal control event (end of a stage, go to next set)**,
  not as an alarm. The bell is not mentioned in this passage. It appears only
  for unforeseen cases (§2) and table requests (pp. 119–122).
- "At a very early period of the inquiry" places this before the Turin
  meeting of 1840 by Babbage's own account. That date is his 1864 statement
  and was not checked against the manuscripts here.

---

## Summary

| Question | What the texts say | Strength of evidence |
|---|---|---|
| Can a computed result choose which cards come next? | Yes. Menabrea p. 685 (French pp. 21–22): on passage through zero or infinity, if "foreseen", the engine "will so dispose itself as to present the new cards", which act "contingently". Menabrea p. 687 (French p. 23): "if the remainder is nothing … the mill will order other cards". Note G p. 728: "the engine follows the one or the other of the two courses … contingently on the one or the other result of Operation 7"; p. 730–731: "V₁₀ always decides which of two courses …" | **Strong** as a statement of principle in both 1842 and 1843, with one worked case (Note G). The mechanism is not described in 1842/1843 (it is in 1864, p. 134) |
| What property of the result is tested? | Zero (Menabrea "remainder is nothing"; Note G "equal to zero … or greater than zero"). Sign (Menabrea: n negative → division; 1864: "change of a sign from + to −"). "Passage through zero or infinity" (1864: borrow or carry out of the top wheel, i.e. below zero or overflow) | Strong for zero/sign as stated; the mechanical reading of "passage through zero" rests on the 1864 text |
| Is a repetition count ever taken from a computed result? | Menabrea p. 686: a counter is set to n − 1 from the datum n "introduced into the machine" and runs to zero (a count from a number, but a **given** number). Note E: counts are limits fixed in advance ("the number of terms we propose to ourselves to obtain"; "a fixed rate"). Note G: the number of repetitions of (13…23) is not loaded as a count; it is ended by testing V₁₀ (n − 1, n − 2, …) for zero each pass. 1864: a cycle runs until a sign change, its length "not known to the person who gave the orders" | **No text loads a counter from a value computed during the run.** A cycle ended by a computed result (in effect a data-dependent count) is stated in Note G (moderate: inferred from the test at every pass and "V₁₀ always decides") and plainly in 1864 |
| Can a result end a cycle? | Note G: Card 23 repeats the office of Cards 7 and 12, a zero test ending the B computation. 1864 p. 134: sign change ends the stage, "turned on to the next set" | Moderate (1843), strong (1864) |
| What happens at passage through zero or infinity if not foreseen? | Bell; engine "stops until the attendant has again set it in action for whatever process it may next be desired" (p. 685; *sonnerie*, *gardien*, French pp. 21–22) | Strong, but it is an **alarm and halt for a person**, not an end of computation |
| Division by zero; impossible operation | Not named. Closest: functions "whose values cannot be admitted when they pass these limits" (p. 685); π example "a case in which the computation would be impossible" (n infinite), handled by a card foreseen by the person preparing the cards (p. 687). Note G footnote p. 723: quantities increasing or decreasing indefinitely are "absolutely beyond the sphere of its powers" | Nothing on division by zero as an event |
| How does a computation end? | Menabrea p. 686: "the required calculation will have been completed" when the counted cycle and the final card are done (end of the card train). Note E: chosen number of terms. Note G p. 728: after putting B₁ on V₂₁, "either to stop altogether, or to begin … all over again". What decides that, and how the stop is made, is not said. Note G p. 727: computing "to an indefinite extent". Results are on the result columns when the stop would occur | The end is by exhausting cards or counts, or an unspecified "stop altogether". **Weak/absent** on the mechanism |
| Is a stop at zero/infinity, or a trap, used as the deliberate normal end? | No passage does so. Bells and stops (1842 p. 685; 1864 pp. 119–122) are alarms or requests for an attendant, followed by continuation. The 1864 zero/overflow detection drives a change of cards, not a stop | **No evidence** that a trap or impossible operation is contemplated as a normal end |

## What could not be read or was not established

- The French original **in the journal** (*Bibliothèque universelle de
  Genève*, n.s. 41, Oct. 1842, pp. 352–376). Only the 27-page offprint was
  read. Journal page numbers for the French quotations are therefore not
  given, and the offprint→journal mapping is unknown. Gallica, HathiTrust and
  French Wikisource were not found to hold the volume. Searches on
  archive.org found volumes of the *Bibliothèque universelle* for other years
  only. French Wikisource search found no transcription.
- The Note G diagram was read only at about 1920 px across the whole plate.
  The readings of Operations 7, 12, 23 and 25 are legible at that size; other
  cells were not checked.
- Lovelace pages other than 685, 728, 730 and the diagram were read from the
  Wikisource transcription, not checked against the scan line by line.
  Wikisource marks djvu/689, 694 and 725 as "proofread" (level 3), not
  validated.
- *Passages* pp. 114, 119–120 and 131–133 were read from OCR only.
- Not read: Babbage's other published or manuscript accounts from 1840–1843
  (for example the Turin lecture notes, and Babbage's own draft notes for
  Menabrea or Lovelace). Whether the "passage through zero or infinity"
  mechanism of 1864 p. 134 is in the Sketch Books before 1842, as "at a very
  early period of the inquiry" suggests, was not checked here.
- No secondary literature was consulted.
