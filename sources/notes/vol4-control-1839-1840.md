# Sketch Book Vol IV (June 1839, Aug 1838, July–Aug 1840) and BAB/F/227 (April 1842): does a mill result govern cards?

Read 27 November 2026. Question: can a result computed in the mill (a
running up, i.e. a sign or overflow detection) alter which cards act,
suppress a card, choose between cards, or make a backing order effective
or ineffective? Background: `src/sketch.rs`, `docs/expressiveness.md`
(dated 1836–1838 mechanisms fix a loop count before the loop starts).

Method. Images from BAB/S/1/04 (Vol IV, `aa110069622`) and BAB/F/227
(`aa110000911`), CC BY-NC-SA 4.0, The Babbage Papers at the Science Museum,
London. The IIIF server (`zoom.sciencemuseumgroup.org.uk/iiif/3/<a>%2F<b>%2F<file>.ptif`)
returns at most 512 px of output per request, so full-resolution crops were
made by stitching 512 × 512 tiles at scale 1 (scale factor after stitching
given where downsized for reading). Crop coordinates are `x,y,w,h` in the
full image (Vol IV images 7 and 33: 4774 × 2931; images 201–206: 4799 × 2960
or 4763 × 2960; F/227 image 2: 8327 × 5806). Crops were kept in the session
scratchpad, not in the repo.

Conventions: `[?word]` uncertain reading; `[…]` illegible; `~~x~~`
deleted; `⟨x⟩` interlined; `.n`, `.g` etc. are Babbage's superscript
contractions. Pages from about p 406 on are written twice: a fainter
(pencil or diluted-ink) text and a darker ink text over or beside it,
nearly word for word. Only the darker text is transcribed unless noted.

---

## 1. Vol IV pp 12–13, 25 June 1839 (image 7, `225/514`)

### (a) On the page

Full resolution, crops `0,0,2400,700`; `0,650,2400,750`;
`0,1350,2400,700`; `0,1980,2400,700`; `0,2550,2400,381` (p 12);
`2400,0,2374,1100` (p 13 text); `2400,1100,2374,1831` at 0.6 (p 13 lower).

p 12, headed "25 June 1839" (the 3 written heavily, perhaps over another
figure):

> Warning from 40th wh. is conveyed down to the units whs.
> But the consequent carr. is postponed to the next turn
> A Card can <u>cut off</u> the comm.n between the Runn.g up of F &
> the Sect. of ″A which it governs
> For Long Add.n
> Every tail has the same acc.l sign as its head
> 1st The heads are brought into Mill and treated as in Com. Add.n
> [a small "1" or tick precedes "1st" in the margin]
> In the case of a−b if F run up it throws into gear
> [x in margin] a cam x which acts on ″A (which causes to make Comp. of all the tails)
> in the same manner as the first Running up caused the
> heads to be made Comp. This cam is not acted upon by cards
> except that the last card puts it out of gear. If this cam
> is independent of the communication between F & ″A, the
> cards need not be affected by the running up of F
> but if not, the running up or non running
> up must turn a card over before it acts.
> If a−b does <u>not</u> cause running up of F,
> the cam x is not put in, & the chain between
> F and sector of barrel of ″A <u>is broken by order
> of card</u> in the Add.n or Subt.n of the tails so
> that their running up [small mark, perhaps a caret] may <u>not</u> order comple-
> ment of them to be made upon ″A

Checked word by word against the existing preview transcription
(`sketchbooks-control.md` §4): it is correct. Additions: "cut off" is
underlined; "is broken by order of card" is underlined; "x" stands in the
left margin beside "a cam x"; "Sect." is the reading (not "lect."). No
deletions in the paragraph. "turn a card over before it acts" is
unambiguous as to the words; there is a double space after "turn".

There is **no sketch** on p 12 or p 13. The lower two-thirds of p 13 is
blank apart from show-through of pencil figure working from the next leaf.

p 13:

> In the case of a+b nothing need be done but the
> comm.n between F & sector of Bar. of ″A broken by
> card <u>after</u> the add.n of heads in the usual way
> −a+b the Subt.n of a causes a run.g up
> on F, which orders in x & if a = or > b every [sic; a word omitted] goes on
> as in the case of a−b when b > a but if a < b
> a second running up occurs on ′F which must
> put x <u>out</u> & the same orders are afterwards given
> as in the case a+b

### Surrounding pages (same subject, 25 June – 1 July 1839)

- p 11 (image 6, `225/513`; full resolution `2455,1490,2280,1100` at 0.85),
  "25 June 1839": "Add.n of numbers of more than 40 figures k being 40 /
  Bring into Mill the two heads with their alg. & acc. signs treat them as
  in ord. add.n & put them into Store"; table "+a +b / +a −b b > a /
  −a +b b > a / −a −b" against "Run if R.g up" [?], "Run on Neg. + Run. on
  Pos", "Run on Neg.", and "if Running up a+b => 40 fig / Give Comp. /
  Give off Number / Give off Compl." The choice is what to give off
  (number or complement), not which card acts.
- p 15 (image 8, `225/515`; full resolution `3150,50,1600,1320` at 0.9),
  "26 June", "The Reserve Carr. or F ′F ″F": "In all cases Card puts in
  reserve of F ′F / When −a enters F is thrown <u>out</u> / When −b …
  ′F is thrown <u>in</u> / When a<b this running-up must put out both F &
  ′F". (A fainter duplicate is written under each line.)
- pp 18–19 (image 10, preview): numbered rules 1–5 (see
  `sketchbooks-control.md` §4). Rule 5: "Supposing Complement is not
  ordered by Running up of Heads yet if any tail run up it would order
  Complement by itself. This is to be prevented by breaking the connexion
  between Running up and the sector of ″A after the Addition of Heads". Foot
  of p 19: "case a+b over".
- p 20 (image 11, `225/518`, preview): "Case +a+b / In this case nothing is
  done but chain broken / Case −a−b / In this case chain is broken and cam
  is put in". Then "1 July 1839", warning arm of the 41st cage; p 21: "When
  the postponed carriage which remains on F & G is to be used Card or
  barrel puts G into gear with H".
- Nowhere on pp 10–21 is "turn" used of a card again.

### (b) What it means

The subject is one operation: the long ("compound") addition of two
numbers of more than 40 places, done head first and then tail by tail.
A running up of F (the sign/overflow detection on the heads) must make the
machine take complements of the head and of every following tail. Two
devices are in play: (1) the existing link from a running up of F to the
sector of barrel ″A, which makes ″A shift its vertical (= take a
complement); (2) a new cam x, thrown in by the running up of F on the
heads, which keeps ordering complements on ″A for all tails, and is put out
by the last card (or, for −a+b with a<b, by a second running up on ′F).

A card is to cut the F–″A link after the heads, so that a running up in a
tail cannot by itself order a complement. The sentence in question then
says: if cam x works independently of that link, the cards need not be
affected by the running up of F; if not (i.e. if cutting the link would
also disable x), "the running up or non running up must turn a card over
before it acts." That is, in that design the card that cuts the link would
have to be dealt with according to whether F ran up, before it acts.

On the page's own evidence:

- It is a **conditional** that Babbage states and then avoids. The plan he
  goes on with (pp 12 last paragraph, 13, 18–20) has the card break the
  chain unconditionally after the heads ("nothing is done but chain
  broken"; "chain is broken and cam is put in"), with cam x carrying the
  state. The cards are then independent of the result.
- The scope is complement-making within one long addition. Nothing on
  pp 10–21 mentions backing, advancing, repetition, or choosing another
  card or group.
- "Turn a card over" has no sketch and no second use nearby. Babbage's
  regular use of "turn" for cards elsewhere is the card prism advancing:
  Vol III pp 163–164 (Dec 1837) "Combinatorial Cards … turn first",
  "the barrels direct the variable cards to turn"; Vol III reverse p 60
  (13 Jan 1838) "ordered to be turned by the successive verticals …
  orders the operation cards not to turn any more"; Vol IV p 411 (1 Aug
  1840, below) "an order to the Count.g App. to turn the Prism on one
  card"; F/227 (1842) "Operation Card is ordered to turn".

### (c) Hypotheses (not established)

- H1: "turn a card over" = advance the prism past one card so that it does
  not act (suppress one card depending on the running up). Fits the
  "turn" usage above and "before it acts".
- H2: physically reverse/flip the card so that a different set of holes
  presents (select an alternative action on the same card).
- H3: the phrase means only that the card's action is altered (made
  effective/ineffective) by the running up, without a prism movement.

All three make a mill result (running up of F) govern whether, or how, a
single card acts. None affects backing or the sequence of cards beyond
that one card. Which one Babbage meant cannot be settled from these pages.

**Answer for this passage:** the page states that, in one design variant,
"the running up or non running up must turn a card over before it acts"
— a mill result governing a card. Confined to complementing within long
addition, and the variant is not the one adopted on pp 13–20. Effect on
card sequence or backing: **no** evidence. Whether a mill result governs a
card: **yes as a stated possibility, not adopted**; mechanism unclear.

---

## 2. Related: Vol IV pp 64–65, August 1838 (image 33, `225/540`)

Preview of the opening; full resolution for p 65 text, crop
`2455,60,2300,1560` at 0.75. p 64 headed "Cards 4 Aug. 1838" (sketches:
"Prism", counting apparatus, number card). p 65 headed "Cards", "[?1] Aug":

> see Sketch Vol 3 p. 228
> Y and Z determine the Number of cards to be backed
> The Combinatorial card always orders Y to back to its zero
> The Running up of the Comb.l Counting App.
> ungears Y and gears Z so that the cards
> in that case are backed by Z
> (Pre. C) (Comb.l No) (Term.) C
> The first of the Cards for making the Comb.l
> No [?puts] [?Screw] Prism into gear with Screw[?]
> Then when the Comb.l Card C advances it
> will cause the cards to back to the end
> of the prelim. Cards

(b) A running up selects between two backing amounts (Y or Z). The
running up is of the **combinatorial counting apparatus** (the repetition
counter), not of a result in the mill. This is the same family as Vol III
reverse p 75 (30 May 1838: "if running up in Combin.l Axis occur this order
is destroyed"). So: counter governs backing — yes; mill result governs
backing — no.

---

## 3. Vol IV pp 406–417, 30 July – 18 August 1840 (Turin) (images 201–206, `225/708`–`225/713`)

Image numbering confirmed: image 201 = pp 406/407, 202 = 408/409,
203 = 410/411, 204 = 412/413, 205 = 414/415, 206 = 416/417.

### (a) On the page

**p 406, "30 July (History)"** (image 201; preview for the top, full
resolution `100,1400,2300,1300` at 0.8 for the lower half). Top: "Proposed
to give out from Mill the result of any operation with its sign
reversed"; making axis ″R rise vertically, "Spiral Axis ″R" (hand
cramped; preview reading). Lower half:

> Oper.n [cards] should have on them
> 1 their Number
> 2 The Var. Cards to which each oper.n refers
> 3 The No of Cards which form a cycle
> 4 The No of Rep.ns of that cycle
> 5 The No of Cards in the formula
> NB the number of repetitions of a cycle may be expressed
> thus as in the [?1st] Nott. of No. algebraic dated
> 23 July 1840 the cycle × × − is repeated 8 times, but it
> may be expressed as
> 3+3+2 or as {(1+1+1)+(1+1+1)}+{(1+1)}

**p 407** (image 201, full resolution `2470,60,2300,1150` and
`2470,1180,2300,1700`, both at 0.8):

> Of <u>Cards</u> of Add.n Color White
> Of hole | one to order the add.n of any number given from
> Store to zero or to whatever is already in the Mill
> one to do the same <u>subtractively</u>
> [boxed] O for Add.n O for Subt.n | O To prevent giving off
> O To order retaining O To reverse the Sign
> General view of the Engine
> The are [sic] two parts Mill to perform Op.ns (gov.d by Oper.n Cards)
> Store to contain Var.s & rec. results (gov.d by Var. Cards)
> Two axes Ingress & Egress containing 4 variables are
> each governed by both Mill & Store or by barrels & var. cards
> There are three oper.ns Alg. Add.n Alg. Mult.n; Alg. Divis.n
> in which the arithmetical numbers & their alg.c & acc.l signs
> are rightly operated upon
> Every Alg. sign in a formula is represented by a card
> Alg. Add.n by white — Alg. Mult. by yellow — Al. Div. by Drab.
> These cards have various holes for modifying the above ~~[…]~~
> These holes when filled throw in conditional arms which are
> acted on & change those verticals which are required for

**p 408** (image 202, full resolution `100,1450,2300,750` at 0.8), "31 July
1840" at the head, with sketches and fractions above:

> those modifications
> The barrels order the Var.ble Cards to advance in order that
> the mill may receive from the Store the subjects of the operations
> and also that the store may receive & distribute on its
> variables the results of those operations

p 409 (preview): "Counting App." with "Dec. Store C.g App.", "Dec. Store"
brackets and worked sequences k, k−1, … 0, −a, l+a, … (counting down and
loading a counting apparatus); not transcribed in full.

**p 410** (image 203, full resolution `60,40,2300,330` at 0.8), "1 Aug.
1840":

> Advance Cards one by one through A B C
> Back Cards at once through −a −b −c

followed by a ruled table, columns "Advance by by one" [sic], "Card
Count.g App.", "No of the Card on Prism", "Gear & Ungear Prism with
Count.g App." (preview reading): A, then 0, Ungear; −a, 0, Gear, A−a,
Ungear; B, 0, Ungear; −b, 0, Gear, A−a+B−b, Ungear; C. Foot:
"A−a + B−b + C−c + D−d + E−e".

**p 411** (image 203, full resolution `2440,40,2340,1900` at 0.75):

> The Government of the <u>Cards</u> is effected thus
> Each set of Cards has a Card Count.g App. of three
> or four fig. wheels as in Drawing 71
> The Card prism can be geared with this Count.g App.
> either pos. or neg.y. In the former case when the Count.g App.
> is reduced to zero the cards will be moved on through a
> number equal to that which was upon the Count.g App. in
> the latter case the cards will be moved back through the
> same number
> There are three holes in the Cards
> No 1 for subtr.g unity from the Count.g App.
> 2 — Reducing the Count.g App. to zero
> 3 — to reverse the direction of the mot.n of the Prism
> All the ordinary Oper.n cards have on them an order to the
> Count.g App. to turn the Prism on one card
> If at the end of any number A of such turns
> it is required to back the Cards through a then when
> the last of the A cards advances it orders

The sentence stops there in both the ink and the fainter text ("… then
when the last of the A cards advances it orders"). p 412 begins a new
heading.

**p 412** (image 204, full resolution `60,40,2330,1200` and
`60,1240,2330,950` at 0.75), "1 Aug", "History" (ink over a pencil text;
many readings uncertain):

> If there are not more than 20 [?individual] [?indices] each
> of two figs only put them above each on one
> Store axis [?]
> When the first index is req.d Reduce the index
> Axis to zero giving off the two lowest figs to the Count.g
> App. and returning the Compl.t on I No 1 then [?step] [?I No 2]
> down twice and the two lowest are destroyed & the
> next index is prepared
> The R.g up of the first index on the Card
> C.g App. directs its barrel to perform the operations
> necessary to put the second index upon it
> } Prelim. { Store / Prelim. / Index Making / Subsidiary / Terminal

**p 413** (image 204, preview), "3 Aug", "Cards &c": "A ′A ″A 1 2 …";
"Let there be two sets of Var.ble Cards"; "4 Aug" sketches of card
plates, rings and levers. No control text.

**p 414** (image 205, full resolution `60,40,2300,800` at 0.6), "4 Aug":
"Cards for Mult.n / Holes / one to order Mult.n / — Mult.n without
Stepping / — Mult.n retaining table"; "Cards for Division / Holes / one to
order Div.n / — Div.n retaining Table"; "for Add 5 / Mult 3 / Div.n 2";
card plate sketch.

**p 415** (image 205, full resolution `2470,600,2300,1300` at 0.75):

> Variable Cards
> holes — one to Carr. wh. ″F [?] to reduce to zero / to change from + to − / − to +
> — Ingress wh. to Receive / Give off
> — each Store Variable to Receive / Give off
> — to Number Card Counting App
> — to Ingress wh. to Step up / down
> — [pencil] to connect Carr. ″F to Ingress [?wh.]
> — to Op.n Card C.g Ap
> — to Var. Card C.g App

"8 Aug": "5 | 220 / 44 holes long", "10 holes = 4⅝".

**p 416** (image 206, full resolution `60,40,2300,500` at 0.6 and sketch
`100,350,2300,2550` at 0.55): "Plan 25 Dated 6 August 1840 for Turin.",
"Running-up Levers": four levers a, a₁, a₂, a₃ on an axis d joined at f,
with b, b₁ … and c, c₁ … above on a second axis; "Operation Cards 7¾ by
2¼", "Reduc.g App.", "Reducing App. R", wheels r, r₁, r₂, r₃, p, ′p,
"Barrel B", "Variable Cards 22 holes 22 holes 28 inches", "Rack", "Number
Cards 20 holes 20 holes 26½ by 5 in"; "Drawings 42, 50 & 63* were also
taken to Turin"; label "The General Plan of Mr. Babbage's Great Calculating
Engine". The running-up levers stand in an outline above and between the
operation-card prism and barrel B; no line or word on the page connects
them to a card prism.

**p 417** (image 206, full resolution `2440,750,2320,2200` at 0.7), "18
August": head/middle/tail stepping in division ("before Stepp.g 30 30 /
After Stepp.g 5 40 15 = Prod / … = Div.d"), then: "It was found that the
plan of stepping up and down div.r in order to save time led to the
throwing away in certain cases of portions which might have had an
influence on the Quot. & it being found inconvenient to pick these out
from the increase of the directive as well as comparatively uneconomical
of time from the rarity of their occurrence it was now resolved always to
step up the Div.d"; a plan "of stepping up or down 2 cages at once …
was also abandoned"; "there must be something to give notice when table
reaches the highest cage"; "Division always begins by subtracting the
whole mult.e from A) ~~and if it get there before the stepping is ended
the cycles of the barrels must be changed thus requiring a great quantity
of directive this was also given up~~" [the struck passage reading is
uncertain where the strike-through crosses it].

### (b) What it means

- The card-control mechanism of 1 Aug 1840 is a **card counting
  apparatus** per set of cards, geared to the prism forwards or backwards;
  holes on the cards subtract unity, reduce it to zero, or reverse the
  prism. Ordinary operation cards each order one turn. Backing "through a"
  after A advances is the same counted-backing scheme as Feb 1839 (Vol IV
  p 66). Nothing on pp 406–417 says that a running up in the mill, or any
  sign or zero detection, orders, suppresses or reverses a card, or alters
  the count.
- The counts come from cards and from the Store: p 406 lists "the No of
  Rep.ns of that cycle" as information on operation cards; p 412 loads
  two-figure "indices" from a Store axis into the counting apparatus, and
  "The R.g up of the first index on the Card C.g App. directs its barrel to
  perform the operations necessary to put the second index upon it" — a
  running up of the **card counter** (its count exhausted) triggers loading
  the next count. p 415 gives variable cards holes to send to the
  operation-card and variable-card counting apparatus. So a number in the
  Store (which could itself have been computed earlier) can set a
  repetition or backing count. That count is fixed when it is loaded.
- "Conditional arms" (p 407) are thrown in by holes on the operation cards
  and change barrel verticals; they modify how an operation is carried out
  (give off, retain, reverse sign). This is card → barrel, not mill result
  → card.
- p 417 states the design aim of avoiding data-dependent changes to barrel
  cycles in division ("the cycles of the barrels must be changed … this was
  also given up", if the struck reading is right).

### (c) Hypotheses

- Babbage's p 411 sentence breaks off at "it orders". What the last of the
  A cards orders (presumably gearing the prism negatively with a on the
  counter) is not on the page.
- p 415's "to connect Carr. ″F to Ingress" might bring the contents of a
  carriage (reserve-carry) wheel ″F into the mill, as in the long-addition
  scheme of June 1839; it does not say ″F acts on a card counter.
- Whether the "Running-up Levers" of Plan 25 (p 416) reach the card prisms
  cannot be read from this sketch; on the page they are drawn near barrel
  B and the reducing apparatus. Drawing 25 itself would decide it.

**Answer for this passage:** mill result governs cards or backing — **no**
evidence on pp 406–417. Counts are set from cards or the Store; a running
up of the card counter itself sequences the loading of counts.

---

## 4. BAB/F/227, "Reversing sign …", April 1842

### Catalogue

Record `aa110000911`, collection.sciencemuseumgroup.org.uk/documents/aa110000911
(fetched with `scripts/fetch-catalogue.py BAB/F/227`; the bare document URL
returns HTTP 403 to non-browser clients). Title: "Reversing sign
ascertaining if a variable is zero, ascertaining if a variable has a + or
- sign (supersedes 223)." Level: item; extent "one sheet". The record has
**no date field**. Two images: `219/661/large_bab_f_227_0001_reversing_sign_1842_apr.jpg`
(cover) and `219/662/large_bab_f_227_0002_reversing_sign_1842_apr.jpg`
(the notation; zoom `219/662/Babbage_Papers__Reversing_Sign_1842_Apr.ptif`,
8327 × 5806). The sheet itself is dated "April 1842" at top right. F/223
("Reversing sign", `aa110000907`) has image file names dated "1842_mar_19".

### (a) On the page

Cover (image 1, preview): "227 / Reversing Sign (Supersedes 223) /
Ascertaining if a Variable is zero / Ascertaining if a Variable has a + or
− sign"; stamp "BAB.[F] 227 E.-1905".

Image 2, full resolution, crops `150,100,4500,2400` at 0.4 (columns),
`4600,950,3300,1350` and `4600,2250,3300,1300` at 0.55 (summary),
`2200,80,6000,400` at 0.3 (title), `2400,3750,1150,450` at 0.8 (pencil
oval). Title: "Reversing Sign (see Sketch Book Vol. V page 74)"; "April
1842". Columns: No. of the Cycle; Operation Cards order; Oper.n Cards are
ordered to; Store Variable Cards order; Var.ble Cards are ordered to;
Verticals; ordered by; Index Count.g App.n (Its lifting axis is L₃); S; U;
8; 9; Summary of the work ordered &c &c.

Summary column, verbatim:

> The last Cycle of the previous Operation
> [Cycle 1, op. card "− G. off", var. "Blank", verticals 0 J, "Oper.n Card",
> index "³+0 / ⁴−1 = 999"] Vertical 0 advances & orders Index Count.g App.n
> to receive from Store, & afterwards 1 to be subtracted from it; it
> <u>Runs up</u> ∴ Operation Card is ordered to turn
> [Cycle 2, "Turn by Index Count.g App.n / Advance by Vert. J",
> "Rec.d from Mill ⁷ —"] Barrel puts a − sign upon U & orders it to gear
> with F & G. off. At the same time Variable Card orders the Variable
> whose sign is to be changed to Rec.e from Rack
> Ascertaining if a Variable (say upon Vₙ) is zero
> [Cycle 1 "Is Vₙ = 0?"] Vertical 0 advances & gives the same orders as in
> Cycle 1 above
> [Cycle 3, "Turn by Index Count. App.n", "G. off & Retain Vₙ", vertical K]
> G. off Number & sign from Vₙ and Retain both by backing the Rack.
> Subtract number <u>only</u> from ′F. Keep ′S in gear while backing the
> Racks which reduces it to 0. Reduce ′F to 0 in half time ′F Runs up ∴
> Vₙ > 0
> [Cycle 3, same column entries] Same orders are given as by Vertical K
> Cycle 3 above without exception; <u>but</u> ′F does <u>not</u> Run up ∴
> Vₙ = 0
> Ascertaining if a Variable (suppose on Vₙ) has a + or − sign
> [Cycle 1 "Is Vₙ + or − ?"] Vertical 0 advances & gives the same orders
> as in Cycle 1 above
> [Cycle 4, "Turn by Index Count. App.n", "G. off & Retain Vₙ", vertical L]
> G. off number and sign from Vₙ and Retain both by backing the Rack. Add
> (fewer gearings than Sub[t.n]) sign <u>only</u> to F & U. Try the wire in
> F and afterwards Reduce F & U to 0 by the axis U. F R[uns up]
> ∴ Vₙ has a − sign
> [Cycle 4] Same orders are given as by Vertical L Cycle 4 above without
> exception; <u>but</u> F does <u>not</u> Run up ∴ Vₙ has a + sign

Pencil oval below the table: "3 Verticals J K & L / The above are too
simple to require a Nott.n of Variables".

### (b) What it means

F/227 sets out, as notations, a zero test (running up of ′F after
subtracting the number from ′F) and a sign test (running up of F after
adding the sign to F and U). The outcome is stated as a conclusion ("∴
Vₙ > 0", "∴ Vₙ = 0", "∴ Vₙ has a − sign / + sign"). The two outcomes of
each test are written as two rows with identical card columns ("Turn by
Index Count. App.n", "G. off & Retain Vₙ") and identical orders "without
exception"; the only difference is whether F/′F runs up. **The sheet does
not say what the result does next**: no card, backing, counter or
alternative row is ordered by the test result. The one card consequence of
a running up on the sheet ("it Runs up ∴ Operation Card is ordered to
turn") belongs to the **Index Counting Apparatus** (load from Store,
subtract 1, run up), i.e. the repetition counter, not to the test.

### (c) Hypotheses / gaps

- The tests presumably exist so that a later step can use the result (the
  state of F or ′F), but that use is not on F/227. The title cites
  "Sketch Book Vol. V page 74", which would be the place to look; Vol V
  (BAB/S/1/05) is not among the volumes located in `sources/references.md`
  and was not checked here.
- F/223 (19 March 1842, superseded) was not read.

**Answer for this item:** zero-testing and sign-testing — yes, explicitly,
April 1842. Test result governs cards or backing — **no** on this sheet;
the result is only recorded as an inference.

---

## 5. Summary

| Source | Date | Mill result detected? | Governs a card? | Governs backing/sequence? |
|---|---|---|---|---|
| Vol IV pp 12–13 (image 7) | 25 June 1839 | yes (running up of F in long addition) | stated as a possible requirement ("must turn a card over before it acts"), in a variant not adopted; meaning of "turn over" unclear | no |
| Vol IV pp 18–20 | 26 June – 1 July 1839 | yes | no: card breaks the chain unconditionally; cam x carries the state | no |
| Vol IV p 65 (image 33) | Aug 1838 | no (running up of the combinatorial counter) | — | counter selects backing amount Y or Z |
| Vol IV pp 406–417 (images 201–206) | 30 July – 18 Aug 1840 | not in a control role | no | counts from cards or Store, loaded before use; counter running up loads next index |
| BAB/F/227 (image 2) | April 1842 | yes: zero test and sign test | no (outcome only stated "∴ …") | no |

Not found in what was read: any passage in which a mill result selects a
different group of cards, makes a backing order effective or ineffective,
or sets a backing count at the moment it is detected.
