# Literature: the Mechanical Notation, Series F, and Rojas on Series L

This was a web search done on 26 November 2026. It covers three things: Babbage's
Mechanical Notation and modern work on formalising it; Series F of the Babbage
Papers (BAB/F) and anything written about the mill's microprograms; and Raúl
Rojas's papers on the Series L programs. Nothing here is a claim of this project.
Each entry says what the source states, not what it might imply.

**Access key**

- **Read (full text):** the full text was obtained and the sections relevant here
  were read. The note says which sections.
- **Read (part):** the full text was obtained but only some sections were read.
- **Abstract / record only:** only the abstract, a catalogue record or citation
  metadata was seen.
- **Web page (via fetch):** a blog or project page, read through a fetch tool that
  returns a summary of the page. Short quotations from these pages may have been
  lightly normalised. Check them against the live page before quoting them again.

---

## 1. The Mechanical Notation and its modern formalisation

### Primary source

**Babbage, C. (1826). "On a Method of Expressing by Signs the Action of
Machinery." *Philosophical Transactions of the Royal Society of London* 116,
pp. 250–265.** Communicated 17 January 1826 and read 16 March 1826.
Open-access scan: <https://archive.org/details/philtrans09445034>
(OCR text: <https://archive.org/stream/philtrans09445034/09445034_djvu.txt>).
*Access: Read (part), from the OCR text: the sections on the signs for
transmission of motion and on the timing ("cycle") rules.*

- **Arrows for how motion is passed on.** Babbage uses an arrow to show
  transmission of motion, with variants for the means:
  - a bar at the end of the arrow means the piece is permanently attached (a pin
    on a wheel, a wheel and pinion on one axis);
  - a plain arrow means the driven piece always moves when the driver moves;
  - an arrow "formed of a line interrupted by dots" means the piece is driven but
    "yet not always move when the latter moves" (for example a stud lifting a
    bolt once a revolution);
  - an arrow that is half full line and half dotted means stiff friction;
  - a dotted arrow with a ratchet tooth at its end means a ratchet.
- **Separate lines for separate motions.** When a part moves in more than one
  way, its name may be bracketed to two or more vertical lines, "characterised by
  a distinguishing mark, such as (vert. motion) and (circ. motion)". This is the
  earliest published form found of the "Ver. Mo." / "Cir. Mo." column
  distinction.
- **Rules for the cycle (timing).** The purpose is to show "at any instant of time
  in this course or cycle of operations" the state of motion or rest of every
  part:
  - unbroken lines mean motion; which side of the indicating line they are on
    gives the direction;
  - parallel straight lines mean uniform motion, and curved lines mean variable
    velocity;
  - a small cross line marks an uncertain start or end of a motion;
  - dotted lines (or no line) mean rest;
  - the side of a dotted line shows whether a click, bolt or valve is in or out
    of action.
- **Worked example.** The paper includes the timing table of an eight-day clock.

### Secondary sources on the notation

**Swade, D. D. (2020). *Charles Babbage's Difference Engine No. 2: Technical
Description.* London: Science Museum (dated March 2020).**
PDF: <https://www.sciencemuseum.org.uk/sites/default/files/2023-09/DE2_Technical_Description.pdf>
*Access: Read (part): §1 "The Mechanical Notation" (pp. 6–9) and the
"Timing and Phasing" section of ch. 3 (pp. 20–22).*

- **Three forms.** Babbage specified the engine in three ways: Forms (mechanical
  drawings), Trains (symbol strings describing "causal chains of action") and
  Cycles (timing diagrams).
- **Origin of the name "Cycles".** Footnote 5 says Babbage's son used "Cycles"
  when he formalised the scheme in 1856. Babbage himself also called timing
  diagrams "Notation of Periods", "Notation of Units (General and Special)" and
  "Cycles of Units".
- **How parts are named.** Each part gets a capital letter, italic for moving
  parts and upright for fixed framing, in several typeface families. It carries
  up to six indices:
  - four numerical: identity, circular position, linear position, and an
    extension index for when letters run out;
  - two non-numerical: the "Sign of Form" (the kind of part) and the "Sign of
    Motion" (linear, circular, reciprocating and so on).
- **Key to the arrows in the DE2 timing diagram** (BAB/F/385/1, 1848):
  - the length of an arrow is the duration of the motion;
  - short vertical arrows with numbers are lifts and lowerings, given in inches;
  - variants of the arrow's head and tail give circular or linear motion, its
    direction, and whether the part returns to rest;
  - a dotted shaft means conditional motion;
  - vertical position on the page is always time;
  - locks are shown as a state: a backwards "F" for Free and an "L" for Locked.
- **Units.** The DE2 cycle has 50 time units, each 7.2°.
- **Arrow direction changed meaning.** "At one point they indicated direction of
  physical rotation. Later this was changed to indicate 'positive direction'"
  (from the section on the carriage figures).
- **How DE2 was decoded.** "No significant use of the Trains was made in decoding
  the drawings." Forms and Cycles were the sources. The notation had not been
  fully decoded when DE2 was first interpreted, and it is "the subject of a
  separate study".
- **Scope.** This document is about DE2, not the Analytical Engine.

**Swade, D. (2017). "'Photographing the Footsteps of Time': Space and Time in
Charles Babbage's Calculating Engines." In S. Wuppuluri and G. Ghirardi (eds.),
*Space, Time, and the Limits of Human Understanding*, Springer, pp. 417–427.**
This citation is as given in Swade 2020, footnote 6. *Access: not seen.* Swade
2020 cites it for the indices of the notation.

**Swade, D. (2018). "Mathematics and Mechanical Computation." In *Technology and
Mathematics* (Philosophy of Engineering and Technology series), Springer,
pp. 79–106. DOI 10.1007/978-3-319-93779-3_5.**
*Access: Abstract / record only (Crossref metadata and a search snippet).* A
search snippet says the chapter describes the Analytical Engine and "his
Mechanical Notation, a universal language of signs and symbols". Its content was
not seen.

**Swade, D. (2003). *Calculation and Tabulation in the Nineteenth Century: Airy
versus Babbage.* PhD thesis, University College London.**
*Access: citation only (cited in Rojas 2023).* Judging only by the title, the
thesis is about Airy and Babbage on tabulation, not the notation. No evidence
was found that it treats the Mechanical Notation. This was not checked against
the text.

**Dutz, J. and Schlimm, D. (2021). "Babbage's Guidelines for the Design of
Mathematical Notations." *Studies in History and Philosophy of Science* 88,
pp. 92–101. DOI 10.1016/j.shpsa.2021.03.001.**
Accepted manuscript (CC BY-NC-ND):
<https://www.cs.mcgill.ca/~dirk/dutzSchlimm2021-AM-babbage_guidelines.pdf>
*Access: Read (part): the abstract, §2, and the passages on the Mechanical
Notation.*

- **Ten guidelines.** The paper sets out Babbage's ten guidelines for notation:
  conciseness, simplicity, univocity, mnemonics, iconicity, analogy, modularity,
  generality, symmetry of symbols and symmetry of structure.
- **Notation as illustration.** It uses the Mechanical Notation only to
  illustrate the guidelines. It discusses the 1826 arrows as iconic, and the
  lettering rules from *Passages* (1864): upright letters for framing, italic
  for moving parts, lower case for working points.
- **No formalisation.** It is not a formalisation and does not cite the Royal
  Holloway project.

### The Royal Holloway project (Johnstone and Scott)

**Project: "Notions and notation: Babbage's language of thought."** Leverhulme
Trust. PI: Adrian Johnstone, with Elizabeth Scott, Royal Holloway, University of
London. Doron Swade and Piers Plummer were also named.

- **Dates and amount.** The Royal Holloway Pure record gives 1 March 2014 to
  28 February 2017 and £222,540, status Finished. It lists no linked outputs.
  <https://pure.royalholloway.ac.uk/en/projects/notions-and-notation-babbages-language-of-thought/>
  *Access: record only.*
- **Project website: "Babbage in the twenty-first century".**
  <https://babbage.csle.cs.rhul.ac.uk/>
  - The WordPress pages API lists six pages: home, navigation, "Babbage and his
    legacy", "The Babbage Engines", "Notions and Notation" and "Alternate
    Babbagery".
  - The navigation page shows labels "FORTRAC" and "DE2 notations and
    simulations", but no linked pages for them were found.
  - The project page states five aims: trace the notation's development;
    formalise it "in a way that can be parsed and processed by modern
    computers"; build a simulator; test it against DE2; and apply it to new
    designs.
  - No publication list, software, data or symbol key was found on the site.

  *Access: Web page (via fetch).*

**Johnstone, A. (2014). "Babbage's Language of Thought." Guest post, Plan 28
blog, 28 November 2014.**
<https://blog.plan28.org/2014/11/babbages-language-of-thought.html>
*Access: Web page (via fetch).*

- **Announcement.** It announces the Leverhulme award "to document, formalise and
  implement simulators for Babbage's Notation".
- **The HDL comparison.** It compares the notation's facets (geometry, functional
  transfer, behavioural/timing) to modern hardware description languages.
- **Method and goal.** It plans abstract simulators that make specifications
  "executable", tested against DE2 and then used on the Analytical Engine. In
  the comments, the blog's author says papers would appear "over time".

**Swade, D. Report on the Analytical Engine, "Society Activity",
*Resurrection* 65 (Spring 2014), Computer Conservation Society.**
<https://www.computerconservationsociety.org/resurrection/res65.htm>
*Access: Web page (via fetch).*

- **Grant.** It reports the three-year Leverhulme grant to Johnstone and Scott.
- **DE2 as Rosetta Stone.** "The physical DE2 is being used as a kind of Rosetta
  Stone to decode the Notation as used by Babbage in the late 1840s."
- **Tools.** Software tools "will be developed to examine the Notation and its
  effectiveness in driving simulations".

**Swade, D. Project report of 11 March 2015, posted as "Progress on
understanding Babbage's Mechanical Notation", Plan 28 blog, 19 March 2015.**
<https://blog.plan28.org/2015/03/progress-on-understanding-babbages.html>
Also covered by I Programmer (S. Gee, 23 April 2015):
<https://i-programmer.info/news/82-heritage/8506-plan-28-makes-progress-in-understanding-babbages-mechanical-notation-.html>
*Access: Web pages (via fetch).*

- **Trains decoding.** "Trains" diagrams are being decoded. They use an alphabet
  of about 90 symbols covering the form of parts and the type of motion. The
  meaning of each symbol is inferred from mechanisms whose function is known:
  addition, carriage, warning and locking.
- **Which version of the notation.** The team works from the 1851 version.
- **Forms, Trains and Cycles defined:**
  - "Forms are un-dimensioned engineering diagrams…";
  - "Trains show the chain of cause and effect…";
  - "Cycles show timing and phasing relationships of moving parts."
- **FORTRAC15.** The team defined "an ASCII-text language called FORTRAC15 which
  captures and expresses Babbage's hand-written notations". Its first tool
  annotates JPEG images of the notations with FORTRAC15 terms, and is being used
  to digitise all the DE2 notations.
- **What digitising found.** It "exposed omissions, anomalies and ambiguities" in
  Babbage's DE2 description.

**Swade, D. Computer Conservation Society reports, reposted on the Plan 28 blog,
May 2016.** *Access: Web pages (via fetch).*

- **"Winter 2015" report.**
  <https://blog.plan28.org/2016/05/winter-2015-project-report-to-computer.html>
  - The provisional conclusion from DE2 is that the notations are "a description
    of the mutual physical relationships of mechanical parts", "not an
    abstraction of a logical description", and that "the mechanical design
    preceded the notational description".
  - The roughly 2,700 Analytical Engine notations "may indeed embody higher-level
    logic", including control functions.
  - It notes mismatches between the digitised archive and Bromley's 1991 printed
    index.
- **"Autumn 2015" report.**
  <https://blog.plan28.org/2016/05/autumn-2015-progress-report-for.html>
  - A new find in the Buxton papers (History of Science Museum, Oxford) contains
    Babbage's "generalised rules for annotating his mechanical drawings".
  - Those rules "confirm our findings from the earlier exercise".
- **"Spring 2016" report.**
  <https://blog.plan28.org/2016/05/spring-2016-report-to-computer.html>
  - It gives about 2,200 Notations and about 300 drawings; the two reports
    disagree on the count.
  - Bromley "published only a small part of his substantial findings" and "was
    the last to use them as an interpretative tool".

**Johnstone, A. and Scott, E. "Babbage's mechanical notation." Talk at HFM2019
(History of Formal Methods workshop), session 3, 11 October 2019.**
<https://easychair.org/smart-program/HFM2019/2019-10-11.html>
*Access: Abstract only.*

- **Content.** A tutorial on "pieces" and "working points", which form a graph of
  parts and their interactions, and on the trains, timing and forms facets.
- **Comparison.** It sets DE2 examples (1849 drawings) against a 1987 design
  written in the Inmos HDL.
- **Question posed.** It asks whether the notation is formal and complete enough
  for symbolic simulation.
- **No paper.** No paper or slides were linked.

**Johnstone, A. Talk at the Ada Lovelace Symposium, Oxford, 9 December 2015
(session 1, talk 3).**
Transcript: <https://media.podcasts.ox.ac.uk/comlab/comsci/lovelace/2015-12-09-acm-lovelace-session-1-talk-3-johnstone.srt>
*Access: Read (part) from the transcript.*

- **Notation elements.** He describes letters in different fonts with up to six
  sub- and superscripts, braces, arrows and parentheses, and a trains diagram as
  "one of three facets".
- **DE2 build.** DE2 was built "purely by reference to the engineering diagrams",
  so the machine can be used to decode the notation.
- **Other talks.** Further talks were found but not read: Oxford CS seminar 2240,
  Newcomen Society "Babbage and the abstraction of mechanism", and a Newcastle
  2018 seminar with a steam-driven difference engine.

**Robinson, T. An extended account of the Mechanical Notation**, reported in
Swade, "Autumn 2023 report to the Computer Conservation Society", Plan 28 blog,
29 September 2023.
<https://blog.plan28.org/2023/09/autumn-2023-report-to-computer.html>
*Access: Web page (via fetch).*

- **What it is.** A 16,000-word account within Robinson's larger technical
  description, covering the notation's development and Babbage's use of it,
  "especially for the Analytical Engine about which practically nothing has been
  published".
- **Status.** Unpublished as of the posts found.

**Robinson, T. "The form of gear teeth for the Analytical Engine" (24 October
2026) and "Framework of The Analytical Engine" (9 November 2026), Plan 28 blog.**
<https://blog.plan28.org/2026/11/framework-of-analytical-engine.html>
*Access: Web pages (via fetch).*

- **Lettering conventions.** The "Framework" post notes that in Plan 27 "A dot
  placed above a letter at this time generally indicates an object which is
  fixed". Lower-case letters mark working points and upper-case letters mark
  pieces.
- **Simulation still to come.** The control framework cannot be specified until
  its mechanism has been "verified in simulation".

### Not found

- No peer-reviewed paper, technical report, FORTRAC/FORTRAC15 specification,
  annotation tool, simulator code or dataset from the Royal Holloway project was
  found in public.
- Searches covered the project site, Pure, Plan 28, *Resurrection*, Semantic
  Scholar (rate-limited) and general web search. DBLP and Springer refused
  automated access.

---

## 2. Series F (BAB/F) and the mill's microprograms

### The archive itself

**Science Museum Group. BAB/F, "Notations of the Analytical Engine", The
Babbage Papers.**
<https://collection.sciencemuseumgroup.org.uk/documents/aa110000014>
*Access: catalogue record.*

- **Extent and dates.** 388 sets of notations, 16 March 1835 to 3 October 1846,
  meant to accompany the drawings in Series A.
- **Contents.** "Most are 'walk throughs' or 'traces' of micro-programs" for
  addition, subtraction, multiplication, division, square root and
  sub-tabulation, showing the engine's functional arrangement and sequence
  control.
- **Arrangement.** Numerical, in date order. Each area between the folds of a
  sheet is a "page".
- **Rights.** Images are CC BY-NC-SA 4.0.
- **Date discrepancy.** Swade 2020 cites a 1848 DE2 timing diagram as F/385/1,
  which is later than this date range. It was not checked how the catalogue
  reconciles the two.

Item records seen:

| Reference | Title | Date | Notes |
|---|---|---|---|
| BAB/F/001 | "Multiplication before the invention of multiplication by table. Sheet 1 of 2." | 1835 | "These two sheets of notations were numbered consecutively as 1 and 2 by Babbage." <https://collection.sciencemuseumgroup.org.uk/documents/aa110000050> |
| BAB/F/002 | Same title, sheet 2 of 2 | 1835 | one sheet, 46 × 117 cm. <https://collection.sciencemuseumgroup.org.uk/documents/aa110000051> |
| BAB/F/077 | "Mill and rack cycles" | 8 January 1838 | three sheets. <https://collection.sciencemuseumgroup.org.uk/documents/aa110000612> |
| BAB/F/077/1 | "Mill cycles of 15 and 20. Sheet 1 of 2." | 8 January 1838 | with an insert "numbered F.77/1[a] by Bromley". <https://collection.sciencemuseumgroup.org.uk/documents/aa110000613> |
| BAB/F/218/1–6 | "Division" | 26 January 1842 | includes a pencil draft marked "copied". <https://collection.sciencemuseumgroup.org.uk/documents/aa110000895/division-sheet-1-of-6> |
| BAB/F/221 | "Verticals for division as performed on Notation 218 arranged on one barrel." | 15 February 1842 | <https://collection.sciencemuseumgroup.org.uk/documents/aa110000905> |

Other titles that turned up in searches show what kinds of sheet are in the
series:

- "Notation for lifters for division by table" (F/12, 1835);
- "Table multiplication" (5 January 1836);
- "Extracted from notations F/39, F/42 and F/44 for the purpose of arranging the
  verticals on the barrels" (F/50, 1836);
- "Trains ordered by one barrel on group "F and group "A" (F/134, 1839);
- "Enumeration of trains on groups I and "F" (F/141, 1839).

**Bromley, A. G. (1991). *The Babbage Papers in the Science Museum: A
Cross-Referenced List.* London: Science Museum.**
*Access: citation only (via Science Museum catalogue text and secondary
mentions).*

- **What it is.** The printed finding aid behind the BAB numbering. The Science
  Museum says the cross-referencing "is far too complex to replicate in this
  electronic catalogue".
- **Same numbers as Bromley's papers.** The F.77/1[a] note shows that the modern
  BAB/F numbers match Bromley's F numbers.

### Bromley

**Bromley, A. G. (1982). "Charles Babbage's Analytical Engine, 1838." *Annals of
the History of Computing* 4(3), pp. 196–217.** Reprinted in *IEEE Annals of the
History of Computing* 20(4), 1998, pp. 29–45, DOI 10.1109/85.728228.
Full text, on an unofficial host:
<https://anthony-zhang.me/blog/rod-logic/an-engine.pdf>
*Access: Read (part): introduction, §§6–9 (microprogram control, timing cycle,
functional organisation, multiplication), conclusion and references.*

- **The archive.** It describes about 300 drawings, 600–700 "notations" ("timing
  diagrams, logic diagrams, flowcharts, state-transition diagrams, and
  walk-throughs of microprograms") and 6,000–7,000 pages of notebooks. Bromley
  says his is the first paper "based primarily on a detailed study of Babbage's
  notations".
- **Which sheets it rests on.**
  - "The design described is detailed by the notations BAB.[F]74-107."
  - Figure 9, the timing cycle, "is based on the notation BAB.[F]77" (the "Mill
    and rack cycles" of 1838).
  - Figure 8, the barrel, is based on drawing BAB.[A]35.
- **Barrels.** The barrel is a microprogram store. A "vertical" is both a word of
  it and the actions that word causes. Reducing sectors of 1, 2 and 4 teeth
  advance the barrel by 1 to 7 verticals. A "running up" from the carry gives a
  conditional transfer.
- **Timing.**
  - A unit is the time for a figure wheel to move one digit, about 1/7 second.
  - A short cycle is 15 units (a transfer, about 2.4 s). A long cycle is 20
    units (an addition, about 3 s).
  - Units 1–2: the barrel advances. Units 3–4: it retreats. Units 4–12:
    digit-parallel transfer. Units 13–15: lockings. In the long cycle, unit 16
    lifts the carry wires, unit 17 propagates the carry, and units 18–20 are
    lockings.
- **Key to Figure 9.** It is "similar in style to some of Babbage's own
  notations":
  - the extent of an arrow is the time of the action;
  - a dotted arrow means the action "might occupy only part" of the interval;
  - direction is relative to conventional axes;
  - circular motion is shown by an arc;
  - a single arrowhead is the basic action, and double arrowheads are the return.
- **Registers (1838 / Plan 25 design).** Ingress axis I; egress axis "A; head
  and tail axes A and 'A; table axes T1–T9; anticipating-carriage figure axes F,
  'F and "F; transfer and long pinions G, S, L, J. These are the 1838 design's
  labels. The search found nothing on whether they carry over to the 1835 sheets.
- **Multiplication.** Multiples 1–9 of the multiplicand are first made by
  repeated addition on T1–T9. Each multiplier digit then selects a partial
  product, which is added to the double-length product, with stepping. Table 1
  works 325 × 132.
- **Limits Bromley states.** The paper rests on "less than 10 percent of the
  material", and its designs are "considerable simplifications". It does not
  transcribe any notation sheet.
- **Further reports cited.** Bromley, A. G. (1980), Basser Dept. of Computer
  Science, University of Sydney: Tech. Rept. No. 166 ("The Mechanism of Charles
  Babbage's Analytical Engine circa 1838", 39 pp.) and Tech. Rept. No. 167 ("The
  Functional Algorithms and Control of Charles Babbage's Analytical Engine circa
  1838", 41 pp.). Neither was found online.

**Bromley, A. G. (1990). "Difference and Analytical Engines." In W. Aspray (ed.),
*Computing Before Computers*, Ames: Iowa State University Press, ch. 2,
pp. 59–98.**
Open scan (Ed Thelen, with the permission statement):
<http://ed-thelen.org/comp-hist/CBC.html>; PDF mirror:
<https://treasures.scss.tcd.ie/miscellany/TCD-SCSS-X.20121208.001/ComputerHistory-EdThelen-AlanBromley-1990.pdf>
*Access: Read (part): the sections on the origins of the Analytical Engine,
control and programming.*

- **Multiplication before the table.** After 1833 Babbage "first realized that
  multiplication could be carried out by repeated addition if the ability to step
  numbers up or down on the axes (multiply or divide by ten) was provided".
  This is a general statement and does not cite BAB/F/001.
- **Barrels and cards.** By late 1834 the mill was under "one or more barrels",
  with loops and branches. "Super" barrels were replaced by Jacquard cards in
  mid-1836.
- **Mastery of microprogramming.** "The microprogramming of the barrels for
  multiplication and division show command of the basic branching and looping
  ideas and his skills in the microprogramming of addition and subtraction show
  complete virtuosity."

**Bromley, A. G. (1987). "The Evolution of Babbage's Calculating Engines."
*Annals of the History of Computing* 9(2), pp. 113–136.**
*Access: citation only.* Rojas (2023) calls it "the definitive account of the
evolution" of the Analytical Engine.

**Bromley, A. G. (2000). "Babbage's Analytical Engine Plans 28 and 28a: The
Programmer's Interface." *IEEE Annals of the History of Computing* 22(4),
pp. 5–19. DOI 10.1109/85.887986.** It has an introduction by M. V. Wilkes in the
same issue, pp. 4–5, DOI 10.1109/MAHC.2000.887985.
*Access: Abstract / index terms only (via search snippets).*

- **Scope.** Plan 28 is dated 1843–1846. The paper presents "a workable though
  rough user instruction set".
- **Index terms.** Addition/subtraction, conditional branches, division,
  multiplication, strings of operands.
- **Not read.** Whether it uses Series F sheets was not determined.

**Grier, D. A. (2004). "Appreciating Charles Babbage: Emails between Allan
Bromley and Maurice Wilkes." *IEEE Annals of the History of Computing*,
October 2004.** *Access: citation only (cited in Rojas 2023).*

**Collier, B. (1970). *The Little Engines That Could've: The Calculating Machines
of Charles Babbage.* PhD thesis, Harvard.**
PDF mirror: <https://treasures.scss.tcd.ie/miscellany/TCD-SCSS-X.20121208.002/TheLittleEnginesThatCouldve-TheCalculatingMachinesOfCharlesBabbage.pdf>
*Access: found, not read.*

### Plan 28 (Graham-Cumming, Swade, Robinson, Shustek)

*All entries in this subsection: Web pages (via fetch).*

- **Swade, "Spring 2017 report"** (19 May 2017).
  <https://blog.plan28.org/2017/05/spring-2017-report-to-computer.html>
  - Robinson has built a searchable, cross-referenced database of the catalogued
    archive, linked to Science Museum records.
  - Swade reviewed the 26 Scribbling Books for Mechanical Notation material. He
    calls it the third full pass through them, after Collier's and Bromley's.
- **Swade, "Spring 2023 report"** (17 March 2023).
  <https://blog.plan28.org/2023/03/spring-2023-report-to-computer.html>
  - Robinson's technical description was completed in November 2021, about
    120,000 words, covering six phases from 1832 to 1871.
  - A 6,300-word section on the Selecting Apparatus for division was added.
  - The team planned monthly summaries on the blog.
- **Swade, "January 2024 Analytical Engine Project Report"** (4 February 2024).
  <https://blog.plan28.org/2024/02/january-2024-analytical-engine-project.html>
  - Plans 27 and 28a are being assessed as build targets.
  - In the comments, Robinson says the Plan 13 engine "would had at least 7
    barrels", and that barrels with separate reducing apparatus act as
    "independent but co-operating state machines".
  - He also says division in Plan 25 used a "non-restoring" algorithm giving one
    digit per cycle.
  - Graham-Cumming: "Bromley is my main source but he is not clear."
- **Swade, "Analytical Engine Project Report"** (11 February 2025).
  <https://blog.plan28.org/2025/02/analytical-engine-project-report.html>
  - Robinson's text "runs to over 150,000 words".
  - He has built a wood-laminate trial layout of the Plan 27 mill gearing.
  - Robinson reports "an RTL-level simulation of division running per F/218"
    which "works as intended" after fixing "a few small bugs". Randomised
    testing equivalent to about five years of continuous cranking passed.
  - He finds "greater complexity in the control than I had previously
    appreciated".
  - This is the only report found of an executed simulation driven by a
    specific Series F sheet. No code, transcription or write-up was found.

---

## 3. Rojas on the Series L programs

**Rojas, R. (2017). "Die Computerprogramme von Charles Babbage."
*Informatik-Spektrum* 40(3), pp. 283–293. DOI 10.1007/s00287-017-1018-5.**
Author PDF: <https://www.mi.fu-berlin.de/inf/groups/ag-ki/publications/Computerprogramme-Babbage/Computer-Programme-von-Babbage.pdf>
*Access: Read (full text).*

- **Scope.** It covers the 26 programs L01–L027 (1836–1841; Program 3 is not in
  the archive) and derives the "Programmierarchitektur" from them.
- **Rules of the machine it describes:**
  - destructive reads;
  - a column sent to the mill can be laid as its complement in another column
    and moved back, (v1,v8)…(v8,v1);
  - "v1 = v1 + v3 [war] aus unbekannten Gründen mechanisch nicht möglich";
  - operation and variable cards run on separate strings ("Datenfluss-
    Architektur");
  - three "carry units" can work with the store, so the store can act as a
    difference engine.
- **Table 3.** Dates and classifies every program:
  - 12 linear algebra;
  - 4 polynomial multiplication or division;
  - 2 recursion by loop unrolling;
  - 3 difference-engine tables in the store;
  - 3 astronomical;
  - 1 showing combinatorial cards (Program 23, 7 June 1838, with nested loops
    and a kind of indirect addressing).
- **Conclusions.** Babbage was "der erste Programmierer der Welt", and Lovelace
  "nichts zu tun gehabt" with these programs.
- **What it does not do.** It does not use Series F.

**Rojas, R. (2021). "The Computer Programs of Charles Babbage." *IEEE Annals of
the History of Computing* 43(1), pp. 6–18. DOI 10.1109/MAHC.2020.3045717.**
*Access: Abstract only (via Semantic Scholar; listed as closed access).*
Abstract: "The mathematician and inventor Charles Babbage drafted 26 code
fragments between 1836 and 1840 for his unfinished 'Analytical Engine.' The
programs were embedded implicitly in tables representing execution traces. In
this article, we explore the programming architecture of Babbage's mechanical
computer, that is, its structure from the point of view of a programmer, based
on those 26 coding examples preserved in the Babbage Papers Archive."

- **Probably an English version of the 2017 paper.** The abstract matches the
  2017 German paper in scope. Rojas (2023) says that is where he "discuss[es]
  the architecture of the AE and review[s] some of its programs".
- **Not determined.** How far it goes beyond the 2017 paper could not be
  checked, because the full text was not read.
- **Date range differs.** 2021 says 1836–1840; 2017 says 1836–1841.

**Rojas, R. (2023). "The First Computer Program." arXiv:2303.13740 (24 March
2023); published in *Communications of the ACM* 67(6), June 2024, pp. 78–81,
DOI 10.1145/3624731.**
<https://arxiv.org/abs/2303.13740>
*Access: Read (part): about the first half, through the first code table.*

- **Note on the date.** The request mentioned a "2017 arXiv" paper with this
  title. The arXiv paper is from 2023. The 2017 paper is the German
  *Informatik-Spektrum* article above.
- **Subject.** BAB/L/001, "No. 1. 4 August 1837": solving two linear equations
  for x in 7 operations (4 ×, 2 −, 1 ÷).
- **Reading of the sheet.** Primed variables mark overwritten addresses. The
  multiplicand b′ is reused in the mill.
- **Where it places the second table.** It says the second table is in "L26".
  `docs/literature.md` in this repository records where this project's reading
  differs.

**Rojas, R. (2023). "How Charles Babbage invented the Computer."
arXiv:2311.04371 (7 November 2023).** <https://arxiv.org/abs/2311.04371>
*Access: Read (part): abstract, timeline section, and references checked.*

- **Content.** An overview of the stages of the Analytical Engine's design from
  the digitised Babbage Papers, following Bromley's periodisation.
- **Notes barrels.** For example, it says Plan 25 has "six barrels for
  microprogramming the mill".
- **No Series F.** No BAB/F sheet is cited by number.

**Rojas, R. (2024). "Unconventional Universal Computation in Babbage's
Analytical Engine." arXiv:2408.03334.** <https://arxiv.org/abs/2408.03334>
*Access: Read (part): abstract and introduction.*

- **Claim.** The programming model (separate operation and variable card
  strings, and combinatorial cards for jumps) can simulate indirect addressing
  for a fixed-size memory, and so a Turing machine with a finite tape.
- **Status.** Rojas calls this "only of theoretical and historical interest".

**Other work from 2022 to 2026 on Series L.**

- Apart from Rojas's papers, no study of the Series L programs from 2022–2026
  was found.
- One paper citing Rojas (2021) is D. Carthy, "Conjoint offprints of Ada
  Lovelace's monograph…", *British Journal for the History of Mathematics*
  (2026), DOI 10.1080/26375451.2026.2618933. Its title is about Lovelace's
  offprints, not Series L. *Access: citation only.*

### Emulators (for contrast)

**Walker, J. "The Analytical Engine: Is the Emulator Authentic?" Fourmilab.**
<https://fourmilab.ch/babbage/authentic.html>
*Access: Web page (via fetch).*

- **What it models.** It emulates user-level card programs from the 1837 memoir,
  Menabrea and Lovelace, and *Passages*.
- **What it does not model.** It does not claim to model barrels, microprograms
  or mill timing. Speed is "one decidedly non-authentic aspect".
- **Other emulators.** Several on GitHub are user-level emulators of the same
  kind (jfinkels, simonjwright, enigmatic-code, cakenggt).

---

## Gaps (not found in this search)

All of these mean "not found in this search", not "does not exist". The search
was limited by bot protection on DBLP, Springer and two library catalogues, and
by Semantic Scholar rate limits.

1. **No executed transcription of a Series F sheet was found.**
   - Bromley (1982) based his account on BAB/F/074–107 and redrew F/077 in
     simplified form, but published no transcription.
   - The only reported execution driven by a Series F sheet is Robinson's
     "RTL-level simulation of division … per F/218" (Plan 28 blog, February
     2025). No code, data, transcription or paper for it was found.
2. **Nothing was found on BAB/F/001–002** ("Multiplication before the invention
   of multiplication by table", 1835).
   - No transcription, analysis or discussion of either sheet turned up.
   - Bromley (1990) says only in general that multiplication by repeated
     addition with stepping came first.
3. **No published key to the symbols as used in Series F was found.**
   - **Babbage 1826:** arrows, "(vert. motion) and (circ. motion)", and the
     line rules.
   - **Bromley 1982, Fig. 9:** arrow extent, dotted arrows, arcs, single and
     double heads.
   - **Swade 2020:** the DE2 timing diagram F/385/1, with arrow length,
     head and tail variants, dotted shafts, and F/L lock states.
   - Not found: any explanation of abbreviations such as "Ver. Mo." / "Cir. Mo."
     in Series F column heads, of Roman-numeral-plus-letter labels such as "IF",
     or of how the 1835 axis letters (A, B, F, C¹, S) relate to Bromley's 1838
     register names.
4. **Nothing public was found from the Royal Holloway project's formalisation.**
   - Missing: a FORTRAC/FORTRAC15 grammar, the JPEG annotation tool, the DE2
     notation corpus, a simulator, and any peer-reviewed paper on the notation.
   - The HFM2019 talk exists only as an abstract. The project's Pure record
     lists no outputs.
   - The project worked on DE2. No account of it applying the formalisation to
     Analytical Engine notations was found.
5. **Robinson's technical description of the Analytical Engine is unpublished.**
   - It runs to over 150,000 words and includes the 16,000-word account of the
     Mechanical Notation and the division Selecting Apparatus.
   - As of February 2025 the team was "exploring avenues to publish".
6. **Several of Bromley's works were not seen.**
   - Not found online: his 1980 Sydney technical reports 166 and 167, and the
     "technical history of all of Babbage's designs" that he described in 1982
     as "in preparation".
   - Not read: Bromley 1987 and Bromley 2000.
   - No account was found of Bromley's unpublished notes being held at the
     Science Museum or by Plan 28. Swade (2016) says only that he "published
     only a small part of his substantial findings".
7. **Rojas (2021) was not read in full.** Whether it adds anything to the 2017
   German paper (for example, a full transcription of every Series L program) is
   still undetermined.
