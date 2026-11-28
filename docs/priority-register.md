# Priority register: the candidate contributions against prior work

Dated 28 November 2026.

This page sets each candidate contribution of the project against the prior
scholarship found. It changes no result, code or notebook text. It does not
claim originality for anything. Where no prior work was found, that means it
was not found in the searches listed here. It does not mean no such work
exists.

## Method

**Done on 28 November 2026.** It builds on the three earlier surveys and does
not repeat them:

- `docs/literature.md` (25 Nov): Rojas on Series L.
- `docs/literature-mechanical-notation.md` (26 Nov): the Mechanical Notation,
  Series F, Plan 28 to 2026, Rojas.
- `docs/literature-expressiveness.md` (27 Nov): computational power, LOOP
  hierarchies, universality.

New in this pass:

1. **Bromley (1982), read in full.** Source: the open scan at
   treasures.scss.tcd.ie, 22 pages, printed pp 196–217. It was OCR'd page by
   page with Tesseract, and the OCR text was read whole. PDF page *i* is
   printed page 195 + *i*; this was checked against the running footers.
   Quotations below are from the OCR, with obvious OCR slips corrected
   (for example "Engme" → "Engine"). The earlier surveys had read this paper
   only in part, from a damaged text.
2. **Bromley (1990), searched.** Source: "Difference and Analytical
   Engines", in Aspray (ed.), *Computing Before Computers*, from the Ed
   Thelen PDF at the same host (287 pages, with a text layer). It was
   searched (the whole book, then Bromley's chapter 2, pp 59–98) for bolt, platform, running up, repeated addition, table,
   conditional, barrel, microprogram, loop and universal. Pp 75–89 were
   read. Page numbers are the book's, from the running heads.
3. **The SMG Series F record, fetched.** BAB/F (aa110000014) was fetched
   through a fetch tool, because direct download returned HTTP 403. Its
   scope note is quoted below. The fetch tool returned the text in pieces,
   so check the quotation against the live page before quoting it again. The
   item records for F/001–F/033 were read from the repository's cached JSON
   (`sources/downloads/smg/F/`).
4. **The Plan 28 blog, read whole.** All 35 posts in the Blogger feed
   (3 June 2013 – 9 November 2026) were read as text, by a delegated
   search. That search also ran the blog's own search for bolt, platform,
   running up, multiplication, notation, simulation and Turing, and ran web
   searches on Swade's, Robinson's and Graham-Cumming's publications.
5. **Formal work, emulators and access, searched.** A second delegated
   search looked for formal and complexity-theoretic analyses, executable
   emulators and simulators, and open copies of Bromley (1987), Bromley
   (2000) and Rojas (2021) (section 8).

Web search and fetch only, in English. Nothing was sent to anyone. Delegated
searches report quotations they fetched; those not re-fetched here are marked
"via search". No person has checked this page.

## 0. General framing: certainly prior work

These points are established historical knowledge. The project uses them and
claims none of them.

| Claim | Prior work | Class | Exact quotation and reference |
|---|---|---|---|
| The mill was controlled by barrels acting as microprogram stores; the cards initiate microprogram sequences | Bromley 1982 | (1) established | "The barrels acted to effect control in a manner closely analogous to modern microprogram control; they were just like microprogram stores. The person programming the Analytical Engine would use punched cards that initiated sequences of microoperations. Babbage had a clear understanding of such hierarchies of control." (p 198). "The barrel may be thought of as a microprogram store and a single vertical row of studs as a word of that store." (p 206) |
| The notations are walk-throughs of microprograms | Bromley 1982; SMG catalogue | (1) | Bromley: the notations are "timing diagrams, logic diagrams, flowcharts, state-transition diagrams, and walk-throughs of microprograms" (p 197). SMG, BAB/F scope note: "Most of the notations, except in the earliest part of the series, are 'walk throughs' or 'traces' of micro-programs for the different versions of the Analytical Engine." It continues that the notations "explain the complex algorithms that Babbage planned to use to perform the various arithmetic functions of addition, subtraction, multiplication, division, extraction of square root and sub-tabulation", and that they "allow us to infer much of the functional arrangement and most of the sequence control of the various plans". The BAB/L series record (repository `sources/downloads/smg/L.json`) says the programs "show how the arithmetic micro-programs in the Series F notations are used in extended calculations". **Note the SMG's own qualifier, "except in the earliest part of the series".** The January 1836 sheets this project uses (F/013–F/033) are near the start of the series, so the catalogue may not class them as traces. |
| A running up, a carry out of the top cage, is a conditional signal that moves the barrel; conditional transfers; multiway branches | Bromley 1982, 1990 | (1) | "Conditional transfers may take place in response to conditional events within the mill … A common source of these is a carry propagation beyond the highest cage of the carry apparatus. Such an event is called a 'running up' and, if tens-complement arithmetic is being performed, signifies a change in sign of an arithmetic result." "A running up can occur in similar circumstances in connection with the specialized counting apparatus of the machine." (p 206). "multiway branches are quite possible" (p 207). 1990, p 86: "a conditional event … such as a carry propagation from the most significant digit position of a number (a running up), can move the barrel to another vertical." |
| Destructive read; two sets of figure wheels to give off and retain; stepping as ×10 | Bromley 1982 | (1) | "This form of storage exhibits a destructive readout" (p 199); "two sets of figure wheels were necessary if an axis was required to give off and retain a number" (p 198); stepping "corresponds to a multiplication by 10" (p 201) |
| Lockings applied in sequence along a train | Bromley 1982; Robinson 2026 | (1) | "These 'lockings' are applied in sequence from the source to the destination of each transfer." (p 201); lockings in units 13–15 of the cycle (p 207). Robinson, Plan 28 blog, 24 Oct 2026: "Babbage's system of lockings, every two gearings, applied sequentially from the source to the destination" (via search) |
| Separate operation and variable cards; counting apparatus; backing | Bromley 1982 | (1) | "the cards could be ordered to move forward and reverse (and hence to loop) independently of one another by an amount controlled by the counting apparatus." (p 215) |
| The user level is underdetermined by the sources | Bromley 1982, 1990 | (1) | "the 'user instruction set' of the Analytical Engine seems nowhere to be clearly stated." (p 215); "It is difficult to write with authority on the programming and user-level facilities" (p 216); 1990, p 88: "nothing corresponding to a specification of a user instruction set." |
| Conditional dependence on earlier results is Babbage's own concept | Bromley 1982 | (2) interpretation | "The whole concept of a conditional sequence of actions in a machine, and in particular of a conditional dependence on the outcome of previous actions of the machine, is original to Babbage" (p 207) |
| Bromley's scope is 1838 | Bromley 1982 | — | "The design described is detailed by the notations BAB.[F]74-107" (p 217); "based on a detailed analysis of less than 10 percent of the material" (p 217); "many of the conclusions must therefore be regarded as tentative" (p 197) |

## C1. Computational power of the dated configurations

Evidence in the repository:
- `docs/expressiveness.md` §4;
- `docs/growth-classes.md`;
- `docs/semantics.md`, rules 3a and 8;
- `formal/Babbage/` (`Growth.lean`, `GrowthStore.lean`, `Classes.lean`,
  `Separation.lean`, `Tower.lean`, `Minsky.lean`, `Trap.lean`).

Theorems: `no_tetration`, `tower_halts`, `no_pentation`,
`no_triple_exp_1837`, `triple_halts_1838`, `no_tet_exp_1837`, `compile_*`,
`trap*`.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| A fixed count at loop entry, with fixed nesting, bounds growth by a fixed tower | Meyer and Ritchie 1967; Grzegorczyk 1953 | (4) established mathematics | Meyer–Ritchie: "changes in the contents of X while P is being repeated do not alter the number of times P is to be repeated" (quoted in `literature-expressiveness.md` §2) | None in the mathematics. The bounds are instances of the Bounding Theorem pattern. |
| A count re-set inside its loop gives counter machines | Minsky 1961/1967 | (4) | cited, not formalised (`expressiveness.md` E) | None in the mathematics. |
| Universality from a trap that ends an endless loop | Rojas 1998 (Z3) | (4) technique | "the master loop of the simulation never stops" (`literature-expressiveness.md` §1) | Applied here to dated Babbage configurations (`trapDeck_accepted`, `trapDeck37_*`), with a statement that no text read treats such a stop as an end. |
| Prior analyses of the engine's power | Bromley 1982, 1990; Rojas 2024; Swade (Plan 28 blog 2017, 2021) | (2) interpretations | Bromley 1982, p 215: "by giving the Analytical Engine the power to read and punch numbers on other cards, he had created a universal calculating machine of effectively unlimited capacity." Bromley 1990, p 89: "a universal calculating machine in the sense that, given sufficient time, it could carry out any possible arithmetic calculation". Swade, Plan 28 blog, 16 Nov 2017: "Given that the 1840 version was incapable of user-programmable conditional branching, the machine described in Plan 25 should be regarded technically as a calculator rather than a computer in the modern sense." | Bromley's "universal" is Babbage's own sense: unlimited digits, cards and backing store. It is not a class result. Swade's verdict on Plan 25 (1840) is a qualitative judgement that fits in kind the result that the counted mechanisms are not universal. It is not a proof, and it concerns 1840, not 1837–1838. |
| The dated configurations (Dec 1837, May 1838) placed in subrecursive growth classes; Dec 1837 ⊊ May 1838; the bound changing with where a repetition count comes from (rule 3a) | none found | (5) | — | **No equivalent located.** Searched: the earlier surveys; Bromley 1982 in full (no analysis of computational power; the closest passage is the "universal calculating machine" one above); Bromley 1990 pp 75–89; the whole Plan 28 blog; section 8's searches. Not read: Bromley 1987, Bromley 2000, Rojas 2021, Copeland and Sommaruga 2015, Kfoury 1980, Goetze and Nehrlich 1980 (section 9). The configurations' dates and readings are this project's own transcriptions, unchecked by a person. |
| Machine-checked proofs (Lean) of these bounds and constructions | none found | (5) | — | No proof-assistant work on the Analytical Engine's control was found (section 8). |

## C2. Note G: two readings, each universal under explicit assumptions

Evidence in the repository:
- `docs/published-control-1843.md`;
- `formal/Babbage/Note43.lean` (`halts43`, `machine_halts_of_43`,
  `haltsB`, `machine_halts_of_B`);
- `control/note-g-*.txt`;
- `sources/notes/note-g-table.md` and
  `sources/notes/menabrea-lovelace-1843-control.md`.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| Note G has a test on a result that chooses between two courses | Lovelace 1843 | (1) primary source | "V₁₀ always decides which of two courses the succeeding processes are to follow, by feeling for the value of n through means of a subtraction" (pp 730–731) | — |
| The engine is universal given a conditional backing | Rojas 2024 (arXiv 2408.03334), after Bromley 2000 | (4)/(2) | Rojas assumes a zero test that backs both strings by amounts punched on cards, and builds indirect addressing and a finite-tape Turing machine, in prose (`published-control-1843.md` §5; `literature-expressiveness.md` §1) | The theorem is in kind Rojas's. What may differ: the primitive is taken from one 1843 passage; the two readings are kept apart; under Reading B the result needs the 1837 unconditional backing; and halting of the deck is tied to halting of the machine in both directions in Lean. |
| User-level conditional branching appears late | Swade, Plan 28 blog, 16 Nov 2017 and 2 Feb 2021 | (2) | 2017: "The first evidence of user-programmable conditional branching appears in an entry dated 19 March 1842 in what Babbage called the 'minor operations' – ascertaining if a variable is zero, and ascertaining if a variable is + or -." 2021: "it is not until Plan 27 that there is the first evidence of user-level conditional operation" (via search) | Bears on how far the 1843 primitive is backed by Babbage's own papers. **It should be compared with the project's reading of F/227 (April 1842), whose tests do not govern cards** (`expressiveness.md` §6), and with Vol V p 74 (12 March 1842). Swade's 19 March 1842 entry has not been read for this project. |
| The two readings of Note G's loop (cycle ended by V₁₀ against a counted cycle), each made precise and machine-checked | Executions of Note G by others (section 8) | (3) for the run; (5) for the readings and proofs | Hansen 2012 and Rogers 2020 ran the corrected program, with `while v10 > 0`. Rogers: "Ada's original didn't describe conditions for the repetition of operations 13 to 23" (section 8, via search). | Running Note G, and its corrections (operation 4, the sign, the repeated block), is prior work. Not located: the counted reading (B) set beside the V₁₀ reading, and universality proved under each. Searched as in C1, plus section 8. |

## C3. B/U in the January 1836 notation as bolting to numbered travelling platforms

Evidence in the repository:
- `docs/f-bu-audit.md`;
- `docs/predictions/` (`held-out-2-protocol.md`, `-rules.md`,
  `-predictions*.md`, `-result.md`, `-scores.md`; `f015-f016-*.md`;
  `platform-timing.md`);
- `sources/notes/bolting-plates-sources.md` and
  `sources/notes/platforms-1835-1836.md`.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| Babbage's own titles speak of bolting plates; his history speaks of bolting axes to travelling platforms | SMG catalogue titles; Babbage's manuscripts | (1) primary source | SMG titles: BAB/F/014 "Bolting plates for multiplication by table."; F/020 "Bolting plates to multiply without table."; F/025 "Bolting plates to divide without table." BAB/A/029: "Method of bolting to platforms for vertical motion of Axes. 4 Feb.y 1836" (as transcribed in `f-bu-audit.md`). BAB/N/002 (Feb 1835): "Barrels to bolt axes to travelling platforms". | That "bolting plates" exist is in Babbage's titles. The reading of the labels is not. |
| Bolting, platforms, B/U in secondary literature | none found | (5) | — | **Not located.** Bromley 1982, read in full, has no occurrence of bolt, platform or travelling. It treats only the 1838 design (F/074–107), where vertical motion is described as an axis "raised" or lowered (pp 199–201). Bromley 1990 (ch. 2, pp 59–98): neither "bolt" nor "platform" occurs in his chapter. In the whole book they occur only in other authors' chapters ("like a bolt from the blue", of logarithms; "moving platforms", of gunnery). Plan 28 blog (35 posts): "bolt" only as an idiom and as Meccano bolt heads; locks only as alignment locks ("Locks are applied to ensure accurate alignment", Robinson, 4 Oct 2026; via search). Not read: Bromley's 1980 Sydney reports 166/167, Bromley 1987, Robinson's unpublished technical description (over 150,000 words, including a 16,000-word account of the notation), Swade's books. **Robinson's unpublished text is the most likely place for a prior reading of these sheets.** |
| A frozen-prediction, held-out test of a notation reading (173/173 fresh B moved; persistence 37/43 against 6/43; no motion in 198 detached or lone-U cases) | none found | (5) | — | No published test of a reading of Babbage's notation against held-out sheets was found. The Royal Holloway project and Plan 28 report decoding by mechanisms of known function (Swade, Plan 28 blog, 19 Mar 2015, in `literature-mechanical-notation.md`). That is a different method, and no outputs were found. The test's own disclosures stand: the reader was given the labels, and the transcriptions are unchecked. |

## C4. Multiplication without table, tooth by tooth (F/018–020, January 1836)

Evidence in the repository:
- `docs/f-mill-milestone.md`, `f-mill-rules.md`, `f-mill-f018.md`;
- `docs/f-engage-rules.md`, `f-engage-result.md`;
- `docs/f-control-result.md`, `f-control-tests.md`, `f020-schedule.md`;
- `formal/Babbage/Mill.lean`.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| Babbage first multiplied by repeated addition with stepping, before the table | Bromley 1990; SMG titles | (1) | Bromley 1990, p 75: "it seems that he first realized that multiplication could be carried out by repeated addition if the ability to step numbers up or down on the axes (multiply or divide by ten) was provided." SMG: F/001 "Multiplication before the invention of multiplication by table" (1835); F/018 "Multiplication without table". | — |
| The 1838 multiplication (table of nine multiples, digit-selected partial products, stepping) | Bromley 1982 | (1) | "Before the multiplication commences, the multiples from 1 to 9 of the multiplicand are made by repeated addition and stored on table axes T1 to T9." (p 210); worked example 325 × 132 (Table 1, p 211) | Bromley's multiplication is the 1838 table method. He does not treat the 1836 method without table. |
| Repeated addition counted down by the multiplier's figure; running up ends the count | Bromley 1982 (in general) | (2)/(1) | A running up "can occur … in connection with the specialized counting apparatus" (p 206). Bromley states no counted multiplication. | The controller of `f-control-result.md` is a computational hypothesis fitted to the sheets. Its count is documented later than F/018 for related designs (Vol II p 84, 7 Mar 1836). |
| A decoding, transcription or simulation of F/001–002 or F/018–020 | none found | (5) | — | **Not located.** Bromley 1982 cites only F/074–107 and F/077. The Plan 28 blog never names F/018–020 or F/001–002. Rojas (arXiv 2311.04371) describes only "the algorithm for 'multiplication with a table' that Babbage decided to implement" (via search). The only executed Series F reconstruction reported is Robinson's of F/218, division, 26 Jan 1842 (Plan 28 blog, 11 Feb 2025), with no write-up or code found. |
| Tooth-level arithmetic proved in Lean (`multiply_correct`, `give_off_retain`, `add_band`) | none found | (5) | — | No formal verification of a Babbage arithmetic mechanism was found (section 8). **Scope, as the milestone states:** the Lean model does not include the bolting or E0–E3. It names the giving and receiving wheels directly, and the Lean–Python correspondence is argued, not proved. So "bolting-selected engagement" is tested (E1 6/6 unseen), not Lean-verified. |

## C5. Running up in the mill (March 1836) against conditional control on the cards (1837–1843)

Evidence in the repository:
- `docs/c1836-control.md`;
- `sources/notes/running-up-designs-1836.md`,
  `counting-running-up-1836.md`, `repetition-count-1836-1842.md`,
  `vol4-control-1839-1840.md`;
- `scripts/c1836.py`.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| Conditional control in the mill (barrels) on a running up | Bromley 1982, 1990 | (1) | See section 0. Bromley 1982, p 212: "An examination of the tentative processes involved in the determination of the quotient digits first led Babbage to a clear understanding of conditional processes conditioned by events occurring during the calculation. As we saw, these conditional processes are clearly embodied in the reducing apparatus of the barrels." | That the mill branched on a running up is established. |
| Dating: mill-level branching on arithmetic results | Bromley 1990 | (2), **earlier than the project's date** | Bromley 1990, p 76: "By late-1834 the basic plans for the Analytical Engine had been formulated. … Multiplication and division were carried out in the mill by combinations of simpler operations under the direction of one or more barrels. The sequence of operations ordered by the barrels included what today we call 'loops' and by alternate sequences dependent on arithmetic results that arose during calculations (today known as 'branching'). The calculation performed was directed by 'super' barrels that initiated transfers of numbers between the store and mill and started the sequences of operations of the subsidiary barrels. The super barrels also included looping and branching capabilities. (In mid-1836 the super barrels were replaced by strings of Jacquard punched cards.)" | **This bears directly on C5.** Bromley dates mill branching on arithmetic results to late 1834, and puts looping and branching in the super barrels (the level the cards later replaced) before mid-1836. He cites no sheet. `c1836-control.md` §1 says "Nothing found before 7 March 1836 says that a result passing through zero moves anything", within the Vol II pages read. Possible reasons for the difference: Bromley's general statement, the pages not yet read (Vol II images 1–8, 14–19, 23–26, 31–32, 36; F/003–006, "Division before division by table was contrived", 1835), or a difference between "an arithmetic result" and "a running up". **The chronology in C5 must not be put forward as the first occurrence until this is resolved.** |
| Mill-level against user-level conditional control, as a distinction | Swade, Plan 28 blog, 16 Nov 2017 | (2) | "there is no evidence of 'user level' conditional control in this defining version of the design, this despite provision for sophisticated multi-way conditional branching at the 'microcode' level." The first user-level evidence is "an entry dated 19 March 1842 in what Babbage called the 'minor operations'". (via search) | The distinction is already drawn, for Plan 25 (1840). What may remain: the dated sequence 1 Mar (stop), 7 Mar (running up of a count, "Running up applied to any op."), 22 Mar 1836 (sign choice, Neg./Pos. cycle), against Dec 1837 (combinatorial wheels running up). Also the observation that one device, a count on wheels run up to end a repetition, appears in the mill in March 1836 and on the cards in December 1837. Neither the dates nor this observation were found in what was read. |
| The first card-level choice on a result | Swade 2017 (19 March 1842); Menabrea 1842; Note G 1843 | (2) | as above | The project's table gives F/227 (April 1842, tests not governing cards) and Menabrea 1842 in print. Swade gives 19 March 1842. The two are close in date, but not reconciled: the 19 March entry has not been read here. |
| The three March 1836 designs as executable behaviour, with unresolved interfaces refused rather than guessed | none found | (5) | — | No executable model of these Vol II pages was found. |

## C6. Manuscript discrepancies

Evidence in the repository:
- `docs/discrepancies.md`, the 49 statements of `babbage verify`;
- `docs/revisions.md`, L/017, L/025 and L/018, the elliptic radius vector;
- `docs/f-control-result.md` §4 and `f020-schedule.md`, F/020's block 3;
- `sources/notes/running-up-designs-1836.md`, the p 93 show-through.

| Claim | Prior work found | Class | Exact quotation and reference | What remains possibly distinct |
|---|---|---|---|---|
| Errors in Babbage's and Lovelace's programs exist | Lovelace/Babbage; Note G's printed error | (1) | Babbage on Note G: "having detected a grave mistake which I had made" (*Passages*; in the repository's Rojas 2023 text); Bromley 1990, p 89: "she did detect a 'bug' in it" | Note G's printed error (Operation 4, V₅ ÷ V₄) is known (Wikipedia "Note G" §Error, cited in `published-control-1843.md`). |
| Rojas's transcriptions of Series L | Rojas 2017, 2023 | (2) | `literature.md` lists where he and the project differ (the L/001 table split, operation 12) | Rojas 2017 has no word for error or slip ("Fehler", "Versehen", "falsch" do not occur in the repository's text). Rojas 2021 was not read. |
| L/017's lost Q0 and the radius-vector programs run strictly; the 49 statements with candidate causes | none found | (5) | — | Not located in Rojas 2017, 2023 or 2024, Bromley 1982 or 1990, or the Plan 28 blog. Rojas 2021 was not read (section 9). |
| F/020's block 3 repeats block 2 | none found | (5) | — | No reading of F/020 was found anywhere (C4). |
| Vol II p 93's cycle sketches are p 94 showing through | — | **not a discovery about the manuscript** | — | This corrects the project's own earlier transcription (`sketchbooks-control.md`). It was found by re-reading at full resolution, not by execution. It should not be listed as a manuscript discrepancy. |

## 8. Formal work, emulators and simulators

All of this section comes from the delegated search of 28 November 2026.
Quotations were fetched by that search and not re-fetched here.

**Proof-assistant or complexity-theoretic work: none found.**
- Queries for Lean, Coq/Rocq, Isabelle, HOL or ACL2 formalisations of the
  Analytical Engine, its cards, Note G, or Babbage's carry or
  multiplication found nothing relevant.
- So did queries placing the engine in primitive recursive, LOOP or
  Grzegorczyk classes.
- The arXiv API, searched for Babbage + engine and for Analytical Engine /
  Lovelace + Bernoulli, gave only Rojas 2303.13740, 2311.04371 and
  2408.03334, and two papers by Misa (2301.02919, 2402.00749), whose
  abstracts treat neither execution nor control.
- DBLP was blocked by bot protection.
- One lead was not read: an FOM mailing-list thread of February 2006 on
  whether the engine is Turing complete, pointing to Gandy (1988)
  (cs.nyu.edu/pipermail/fom/2006-February/009829.html).

**The closest formal project.** Royal Holloway, "Notions and Notation"
(Johnstone, Scott, Swade, Plummer). Its page says it treats "his system of
notations as a formal language, adopting techniques from software language
engineering", and that it will "develop abstract simulators which make
specification written in the notation executable", tested "by reference to
Difference Engine II". The target is DE2, not the Analytical Engine's
barrels. No software or results were found.

**Card-level emulators.**
- **Walker, fourmilab.ch/babbage.** This is the main one. It works at card
  level, with an abstract mill and no barrels:
  - "the Mill has a Run-up Lever which is activated when exceptional
    conditions arise during an arithmetic operation";
  - "Advance ("F") or back ("B") cards only if the Mill's run-up lever is
    set";
  - "Operation, Variable, and Number cards are turned in lockstep … Since
    such a mechanism was never clearly spelled out, we assume it wasn't
    intended" (cards.html, authentic.html).
- **Others:** jfinkels (Java), simonjwright (Ada), James-P-D (Raku) and an
  npm port of Walker's. They were seen as listings only; none appeared to
  model barrels, carriage or teeth.
- **Relevance:** Walker's conditional card is a user-level conditional
  backing on the run-up lever. That is close in kind to the `1843`
  configuration's `back … if`, but it is an emulator design choice, not a
  reading of a dated page, and it makes no claim about power.

**Note G executed by others.**
- **Hansen, 10 Dec 2012** (h14s.p5r.org). Lists three "bugs in the original
  program": the swapped division in step 4, the repeated-block issue and
  the sign.
- **Rogers (Oxford), 20 Jan 2020.** Runs the program "fixing Ada's bug in
  operations 4 and 24", and notes "Ada's original didn't describe
  conditions for the repetition of operations 13 to 23". He uses
  `while v10 > 0`.
- **Igalia JavaScript emulator.** Says conditionals and loops are
  "mentioned in the article but no details are provided".
- **Wikipedia "Note G".** Gives the operation-4 error and a `WHILE V[10] > 0`
  pseudocode, uncited.
- **Bearing on C2:** that Note G runs, and its corrections, are prior
  work. These executions pick a loop ended by V₁₀ without discussion,
  which in effect is Reading A. Rogers and Igalia say the text does not
  specify the end. No source was found that sets out the counted reading
  (B) beside it.

**Executed Series F reconstructions.**
- Robinson's RTL simulation of division per F/218, 1842 (Plan 28 blog,
  11 Feb 2025): "except for a few small bugs it works as intended", with
  randomised testing "equivalent to about five years continuous cranking".
  No write-up or code was found.
- Robinson's "logical" simulation environment, "not unlike a later
  Hardware Description Language" (Plan 28 blog, 20 Sep 2019).

**Formal verification of a Babbage arithmetic mechanism: none found.**

## 9. Sources not accessed

| Source | Why | What it might bear on |
|---|---|---|
| Bromley, "The Evolution of Babbage's Computers", *Annals* 9(2), 1987 | no open copy found; paywalled | C4, C5: Bromley's dated account of 1834–1838 |
| Bromley, "Plans 28 and 28a: the programmer's interface", *IEEE Annals* 22(4), 2000 | no open copy; the IEEE Xplore fetch returned an empty page. The abstract (ISC record) gives Plan 28 as "Between 1843 and 1846" and "a workable, if unpolished, user instruction set" (via search) | C2: the conditional mechanism Rojas adopts; 1843–46, so later than every dated configuration |
| Bromley, Basser Tech. Repts 166 and 167 (1980) | not found online | C3, C4, C5: mechanism and control c. 1838 |
| Bromley's "technical history of all of Babbage's designs", "in preparation" in 1982 (p 217) | not known to have been published | all |
| Bromley, *The Babbage Papers in the Science Museum: A Cross-Referenced List*, 1991 | print only | C3, C4: his notes on F/013–033 |
| Rojas, "The Computer Programs of Charles Babbage", *IEEE Annals* 43(1), 2021 | no open copy found (closed access). A search snippet of Rojas's CACM paper (2024; the page returned 403) says of L/001 that "Babbage did not check these two conditions in his program" | C6 and C2 |
| Robinson's technical description of the Analytical Engine (over 150,000 words) | unpublished (Plan 28 blog, Feb 2025) | C3, C4, C5; the most likely prior reading of the Jan 1836 sheets |
| Robinson's F/218 RTL simulation | no code or write-up found | C4 (an executed Series F reconstruction, 1842) |
| Swade, "Photographing the footsteps of time", Springer 2017 | the publisher's page redirected to a login | C3 (the notation's indices) |
| Swade, *The Cogwheel Brain* / *The Difference Engine*, 2000 | book, not accessed | C5 (chronology) |
| Swade's 19 March 1842 "minor operations" entry (the manuscript) | not read for the project | C2, C5 |
| Copeland and Sommaruga 2015 | redirected to a Springer sign-in; a direct PDF download was refused by this session's permissions and was not attempted another way. Snippets say it "assesses claims that various historic computers, including Babbage's Analytical Engine … were universal" | C1, C2 |
| Gandy 1988, and the FOM thread of Feb 2006 | not read | C1 |
| Collier 1970 (thesis) | found (open PDF), not read | C5 (Collier read the notebooks for the history) |
| The SMG BAB/F record, by direct download | HTTP 403 (CloudFront); read through a fetch tool | section 0 |

## 10. Summary

None of the candidate contributions is put forward here as original. What
the search shows is narrower.

- **The framing is prior work.** Barrels as microprogram stores, running up
  as a conditional signal in the mill, multiway branches, the hierarchy of
  cards over barrels, and the underdetermined user instruction set are all
  Bromley's (1982, 1990). The SMG catalogue calls most of Series F traces of
  micro-programs, "except in the earliest part of the series".
- **C1.** The mathematics is classical (Meyer–Ritchie, Grzegorczyk, Minsky,
  Rojas's trap). No application of it to Babbage's dated configurations,
  and no proof-assistant formalisation, was found.
- **C2.** Universality from a conditional backing is Rojas's result (2024).
  Running Note G, with its corrections, is prior work (Hansen 2012,
  Rogers 2020); those runs assume a loop ended by V₁₀ without discussion.
  Walker's emulator already has a card conditional on the run-up lever.
  What may differ is the textual basis, the two readings set side by side,
  and the machine-checked two-way halting correspondence. Swade's dating of the
  first user-level conditional (19 March 1842) should be read and set
  against the project's F/227 reading.
- **C3.** Bolting plates and travelling platforms are Babbage's own words.
  No secondary reading of the B/U labels, and no held-out test, was found.
  Bromley's 1980 reports and Robinson's unpublished description are the
  likeliest places for one.
- **C4.** That multiplication without table came first is in Bromley
  (1990). No decoding or simulation of F/018–020 was found. The Lean proof
  covers the arithmetic of the controller, not the bolting.
- **C5.** That the mill branched on a running up is established. **Bromley
  (1990) dates mill branching on arithmetic results to late 1834, and puts
  looping and branching in the super barrels before mid-1836.** That
  conflicts with the project's "nothing before 7 March 1836" within the
  pages read, and must be resolved before the chronology is put forward.
  Swade (2017) already draws the mill-level against user-level distinction.
- **C6.** The program discrepancies found by execution were not found in
  the work read, but Rojas (2021) was not read. The p 93 show-through
  corrects the project's own transcription and is not a manuscript
  finding.

Throughout: "not found" is not proof of originality. The searches were web
only, several key sources were not accessible (section 9), and a specialist
may know of work this search missed.
