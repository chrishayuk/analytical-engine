# BAB/L/023, drawing 64 and Sketch Book Vol III: program and mechanism, 1837–1839

Read by a coding agent from the Science Museum Group zoom images at full
resolution, fetched as 512 px tiles and stitched (the server now returns at
most 512 px per side for `/max/`). Previews (`coimages … large_*.jpg`) were
used only to find regions. **No person has checked these readings.** Crops
are in `sources/downloads/smg/L023/codesign/`, `sources/downloads/smg/A064/`
and `sources/downloads/smg/S/` (git-ignored). Coordinates are in pixels of
the zoom image (x, y, w, h).

Conventions: `[?]` uncertain reading; `~~struck~~`; `⟨inserted⟩`. Quotations
keep Babbage's abbreviations.

The question: did the looped program of 7 June 1838 (L/023) lead to the card
prism of drawing 64 and the sketch of p 228? The sections below keep three
things apart: what the documents say (archival reading), what follows
directly from comparing them (inference), and explanations (hypotheses).

## 1. What each document says

### 1.1 Sketch Book Vol III p 137, 18 Nov 1837 (image 76, `225/288`)

Right page, numbered 137, headed "18 Nov". Region 2540,40,2300,3000.

Left column: "Mill  Store", then "a~~A~~+ [?]", "aB + bA", "aC + bB + cA",
"Multipl.g and add  × +", "Repeat the same one more at each process than it
was executed in the former."

Right column: "a b c d" over "A B C D"; "shift variable one and invert — then
take one more pair each time".

> By this plan a great number of cards may be saved in developements and if
> a new set of cards be made to be called the Combinatorial Cards these will
> govern the number of repetitions both of the [ope]ration cards in mill and
> those in the store each card determining a certain number of repetitions.
> Thus the combinatorial analysis will be put into wheelwork. —
> The cards containing the two alphabets in reverse order will be put into
> the Store and the operations ×, + in the mill. Then in order to get the
> coeff of any number ⟨(n)⟩ of terms of the Product of a + bx + cx² + dx³ + …
> by A + Bx + Cx² + Dx³ + … we must have n combl. cards on which are punched
> the natural numbers these will successively call into action the
> repetitions of the operation and the change of the quantities — It may be
> remarked that these n cards are not necessary because the series they
> produce is easily calculated but by having these cards as directors we get
> a very much greater extent of power than we otherwise would and the number
> of cards required [continues on p 138, not read]

Two inks: most of the passage is pale; some words are darker and heavier
("these will successively call into", "It may be remarked that these n
cards", "produce", "easily calculated"), as if re-inked or written with a
fresh dip. "two alphabets are in reverse order": "are" [?].

### 1.2 Sketch Book Vol III pp 161–162 (images 89–90, `225/301`, `225/302`)

Read from the preview (1536 px): the pages are in a large, regular fair
hand and fully legible there. No date is on either page; the date 11 Dec
1837 comes from the history sheet N/004 ("Combinatorial Cards. 11 Vol 3 p
161").

p 161, headed "Combinatorial wheels, cards, &c.":

> There is a set of figure wheels on the counting carriage axis which are
> called "combinatorial figure wheels": When these have run up by coming to
> 0 they throw out the combinatorial tooth which backs the operation cards
> to 0. Each time unity is subtracted from the combinatorial wheels the
> combinatorial tooth reduces the operation cards to 0. Any numbers may be
> transferred from the combinatorial cards to the combinatorial wheels. In
> using the combinatorial wheels it is necessary to divide the operation
> cards into two groups, the first the one subject to repetition; the second
> the constant group.

p 162:

> Between the first and second group a card must be inserted (see page 158
> of Vol 3 Sketch book) which orders the backing of operation cards which
> are thus brought to 0 or their commencing point; but, this order becomes
> ineffective if the combinatorial wheels have run up. At the end of the
> second group another card must be inserted (b) which always orders the
> backing of operation cards. The numbers put on combinatorial wheels
> (usually having their first difference constant) may be computed by the
> constant part of formula cards. See page 75 other end.

p 163 begins "Combinatorial Cards (one set) turn first / Operation Cards (one
set) … / Variable Cards (two sets) …" ("Formula Cards" bracketing Operation
and Variable).

### 1.3 Sketch Book Vol III pp 200–201, 6 and 8 June 1838 (image 109, `225/321`)

p 200 head (120,50,800,180): "200", then "6 [?] June" (the first figure is
heavy and could be a 6 or a G-like flourish; "June" is clear). The page is
scratch work: expressions in p, r, d, c ("p − r − 1 − d", "−p + r + 1 + d − c
if 0 < 0 [?] go to [?]"), small columns of figures, two sketches.

Bottom (1050,2200,1300,720), a calculation:

```
101/2 · 100 = 5050  Mult.
                × 2 [?"2'10"]
15150 add      10100 min.        [overwritten, perhaps from 11000]
    × 6          505   [? "1/10"]
20)90900 turns  4545   [? "9/10"]
   4545 min.  60)15150
                 252·5 hours
```

So: 5050 multiplications (the products for 100 coefficients); 15150
"add", × 6 = 90900 "turns", ÷ 20 = 4545 minutes; and a column 10100 + 505 +
4545 = 15150 minutes, ÷ 60 = 252·5 hours. What 505 is, and the small
fractions beside 505 and 4545, were not read with confidence.

p 201, headed "8 June": "Mult.", "put p on Screw", "p − 1 cases p − 1 is + k
… is 0", "p cannot be = 0"; boxed at right (3880,200,1000,780): "Subtract 1
every time [?cards] orders and when k is thus reduced to zero or to −1 (runs
up) / Do ~~but [?] of doing this is changed~~"; below: "Step up once for each
unit when k is reduced to zero Runs up"; "−k Step down"; "+k Subt. 1 k−1 =
+1 / = 0 Runs up"; studs, a cam, and a sketch of a counting wheel.

### 1.4 BAB/L/023, 7 June 1838 (`222/603` cover, `222/604` sheet)

See `L023.md` for the whole sheet. The parts that bear on the question:

- Cover: "By means of combinatorial cards connected with the operation
  cards … The backing apparatus Y backs the cards to the beginning of the
  formulae cards. The backing apparatus Z backs them to the beginning of the
  cards forming the combinatorial numbers."
- Table, column "Combl" of the Store, beneath the heading: "This ought not
  to be in Store but on Prisms".
- Table, "Backg Appas" column, rows 1 and 2: "Gear Z with prism", "Gear Y
  with Prism" (4180,1820,700,260). These are in the body of the table, not a
  marginal note.
- Above the table: "See Sketch Book Vol.3; p.228; fig. 1".
- Below the table: "N.B. 252·5 hours reqd to obtain 100 terms of the
  Product see p 200 Vol 3 Sketch book".

### 1.5 BAB/A/064, drawing 64 (`214/419`, 8084 × 11714)

The zoom image is stored on its side: the preview carries EXIF orientation 6
(rotate 90° clockwise to view). A point (X, Y) of the upright 1536 × 1060
preview is zoom pixel (7.627·Y, 7.627·(1536 − X)).

**Correction to `references.md`: the heading reads "18 June 1838", not 19.**
Left half, top to bottom, all in a regular engrossing script in brown ink:

- "64" at the top left.
- A card with two staggered rows of 12 round holes between two ruled lines,
  labelled "A Form of Operation Card" (zoom 1891,9312,244,1144).
- "Operation Card and Card Prism / 18 June 1838" (2326,8816,457,1716). The
  "18" is clear at full resolution.
- "Form of Operation Card adopted": a card with three rows of 8 holes (the
  middle row offset), a larger single hole near each end, and at each end two
  strips labelled "Tape" running past the card's ends (wavy-cut, i.e. broken
  off) (3050,8664,1220,381 and 3050,10952,1220,343). Beneath it (4156,8626,
  511,2249 and 4156,10685,511,327): "This card will move 8 sectors for each
  Barrel and will therefore order them to move from 0 to ± 9".
- An octagon labelled "Operation Card Prism" (5430,9541,274,838), one side
  dimensioned "2·454+ ins" (4919,10380,533,533), with a red arc for the swept
  circle. To its right three bars labelled "Wires", with two dashed
  positions "Neutral" and "Working" (4995,8626,1144,533).
- Below the prism (6673,8702,495,2173; left edge 6673,10685,495,327):
  "All the sectors of the Barrels are to be put back by a Backing plate which
  must be thrown out when a cycle is inserted for the purpose of moving
  Barrels only."

Nothing on the left half mentions combinatorial numbers or cards, counting,
repetition, the store, or Y and Z. The "backing" in the note is of the
**barrel sectors**, not of the cards.

Ink and hand: the backing-plate note is in the same brown ink and the same
engrossing hand as "Operation Card and Card Prism 18 June 1838" and the card
captions. The 1839 work on the right half is in a darker, black ink with
heavier strokes: "Plan 18 / 17 Sep. 1839" (1334,4126,419,915) and "Table
Axes. / 17 Sepr 1839. / See Sketch book Vol 4 page 211." (6635,6490,495,1426;
**"211", not "24"** as in `references.md`). On that evidence the note
belongs with the 1838 half, not the 1839 plans; ink colour alone does not
prove it.

The paper label above the sheet: "Plans 18, 19 & 20 / Cards &c / 64 / Sep. &
Oct 1839" (61,9793,640,945).

### 1.6 Sketch Book Vol III pp 226–229, July 1838 (images 122–123, `225/334`, `225/335`)

p 226 head (90,40,2400,250): "[?10]. July. Counting app reduced from the
screw apps see pencil sketches of screw counting No 1 & No 2 June 1838".
The page and p 227 are on counting apparatus (decimal counting app gearing
"occasionally with this axis (7 Aug)", axes A–E, bands, a clutch). Nothing
on them about cards or prisms was seen in the preview; not read further at
full resolution.

p 228 head (40,40,500,160): "228  10 July".

p 228, fig. 1 (320,1220,2100,880): a horizontal axis carrying, left to
right: an arm "A"; a clutch or coupling "H" [?]; a large box "Prism for
Card"; a coupling "G" [?]; an arm "B". Below A, a box lettered "Z" with a
rack (a row of teeth) along it; below B, a box lettered "Y". Connections
run from the couplings round under the prism to a vertical rod. Beside it,
written diagonally: "See Notn for the Multn of two finite series". Below:
"1 2 4 8 16 32 64 / 128 256 512".

The note of 11 July (1000,720,1300,420), written across and around the
lower part of an earlier sketch labelled "Prism":

> 11 July  Y is backed to 0 by Combin-|atorial Card. Z is backed
> by Combinatorial Count-|ing Apparatus   fig 1

**Correction to `references.md` and `L023.md`: the letters are Y and Z,
not A and B.** The initial of the first sentence has the same form as the
"Y" in the box of fig. 1 (compared at ×2); the "Z" is clear. "to 0" [?]: a
"to" is run into "backed", then "0". The ink of the note is a heavier black
than the sketches it crosses. Show-through from the other side of the leaf
is visible behind it.

Elsewhere on p 228: sketches of a prism (octagon) on an axis, a rack, and
"The picking up sectors above may be made to have every tooth a picking up
tooth by having two rows of picking up teeth in different planes: the teeth
being alternately wanting in each plane."

p 229 top (2520,40,2380,900): "382 units in a minute / 19·1 No of cycles ⟨of
20⟩ moved in a minute / 25·5 cycles of 15 moved in a minute"; "2·45 inches
moved by opn card see Dr 64"; "In cycle of 15 cards can move during 10
units allowing ⅓ of unit ⟨beyond⟩ for any locking". Below (preview only):
how many operation cards can be turned in cycles of 15 and 20, "exclusive of
time for advancing" and "taking whole cycle for turning".

### 1.7 Sketch Book Vol IV pp 66–67, 9 Feb 1839 (image 34, `225/541`, 4774 × 2931)

Regions 1000,800,1420,300; 260,1850,2150,1020; 2480,120,2220,880.

> Card backing Appars. 9 Feb 1839
> It is proposed to take a decimal Counting Appts for backing cards.
> In order to back n + i cards after advancing n: first put the number i
> (computed or taken from Store) ~~[?gear]~~ upon the backing Apps ⟨& gear
> the backing apparatus⟩ with Card prism. After n cards have advanced, the
> backing Appt will stand at n + i; reduce it to 0 [p 67] slowly so as to
> back the cards. One such Apps is sufficient for each Prism. Possibly the
> backing App. sketched in this volume at page 64 may be found mechanically
> simpler but as this one consists entirely of Decimal Counting Apps which
> will have been made for other purposes, it may be better, or cheaper to
> use a repetition of the same work.

## 2. Contemporaneity on L/023 (observations only)

The sheet has two kinds of writing. (a) A large, formal, upright script with
a broad nib in dense black: the column headings ("Comb.l", "Const.", "Small
/ Large Letter Cards"), the figures of the table, the operation-card
brackets. (b) A smaller running hand with a finer nib, greyer ink, and long
s ("neceſsary", "paſsing"): the NB on ungearing Y, "Opn Cards in this Notn
denote the sum of the Cards", the cells "Gear Z with prism" / "Gear Y with
Prism", the sketch-book reference, and the "see p 200" part of the foot NB.
Since hand (b) also writes cells inside the table body (rows 1–2), (b)
alone does not mark a later addition.

- **"This ought not to be in Store but on Prisms"** (crop 1990,1440,420,420;
  the words at about 2050–2270 × 1570–1760). Four short lines in a small,
  neat script under "Comb.l", in a brown-purple ink close in colour to the
  ruled column lines and clearly paler and thinner than the black heading
  and the black "0" and "1" below it. It exactly fills the column: "on"
  starts at the left rule and the final "t" of "but" touches the right rule.
  It sits in the gap between heading and first line of figures, which is
  deeper in this column than its neighbours need; whether the gap was left
  for it cannot be told. Letter forms (looped T, S of "Store", P of
  "Prisms") are like hand (b) but neater. Nothing (crowding, overwriting of
  a figure, different paper tone) shows it was added after the table; the
  ink difference shows only a different pen or dip.
- **"See Sketch Book Vol.3; p.228; fig. 1"** (4150,980,750,380). Hand (b),
  grey-black, fine nib, in open space between the letter cards and the top
  of the table; not squeezed. The "22" of "228" is darker and heavier than
  the "8" and the rest of the line, as if gone over or corrected.
- **Foot NB** (650,5800,3900,230). Written below the last table row, across
  the downward continuations of the column rules (it crosses five or six
  rules), and skips over the central fold. "N.B. 252·5 hours reqd to obtain
  100 terms of the Product" is in dark ink; "see p 200 Vol 3 Sketch book"
  is paler and greyer, with smaller letters, and "Sketch book" has a small
  "b" where the upper reference has "Book". This looks like two stints, the
  page reference added after the N.B., but the change could also be the pen
  running dry.
- Date "7 June 1838" at top right (6750,40,620,200): hand (b), grey-black.

## 3. Inferences that follow from the dates and texts

1. The scheme of L/023 is in the sketch book six months earlier. p 137 (18
   Nov 1837) sets the exact problem (the coefficients of the product of two
   series, two alphabets of variable cards in reverse order, combinatorial
   cards punched with the natural numbers, × and + in the mill) and remarks
   that the series of combinatorial numbers "is easily calculated".
   pp 161–162 (dated Dec 1837 only by N/004) give the combinatorial wheels,
   backing of the operation cards by a card inserted between the groups that
   "becomes ineffective if the combinatorial wheels have run up" (L/023's
   Y), a second card that "always orders the backing" (L/023's Z), and
   numbers "having their first difference constant" computed "by the
   constant part of formula cards" (L/023's Tab + Δ′).
2. In Dec 1837 the combinatorial wheels are "on the counting carriage axis",
   not in the store. L/023 puts Comb, Tab and Δ′ in the Store columns; the
   remark says Comb "ought not to be in Store but on Prisms".
3. The 252·5 hours of L/023's NB is computed on p 200, which is headed
   6 [?] June 1838, the day before the sheet. The p 200 breakdown is not
   "one minute per operation": it is 5050 multiplications (× 2 → 10100
   min), 15150 "add" × 6 turns ÷ 20 = 4545 min, and a 505, totalling 15150
   minutes. (`L023.md` reads the total as 15150 operations at one minute;
   the total agrees, the composition does not.)
4. Drawing 64's left half is dated 18 June 1838, eleven days after L/023,
   and agrees with N/005's "Plans for Cards 18 64". It is a design of the
   **operation card** and the **operation card prism** (an octagon, side
   2·454 in.), with a backing plate for **barrel sectors**. It does not
   mention combinatorial numbers, counting, or backing of cards.
5. L/023's body already names a prism ("Gear Z with prism", "Gear Y with
   Prism"), so a card prism was part of the scheme on 7 June, before
   drawing 64.
6. p 228 fig. 1 (10–11 July 1838) is the first of these documents to put Y
   and Z on the prism axis, and to say what backs what: "Y is backed to 0
   by Combinatorial Card. Z is backed by Combinatorial Counting Apparatus".
   It points back to the program ("See Notn for the Multn of two finite
   series"), and L/023 points to it ("See Sketch Book Vol 3 p 228 fig. 1").
   p 229 points to drawing 64 ("2·45 inches moved by opn card see Dr 64").
7. In Feb 1839 (Vol IV p 66) a counting apparatus geared to the card prism
   does the backing, set from a number "computed or taken from Store".

## 4. Competing explanations

**H1. The program led to the mechanism.** Writing out L/023 on 7 June
showed Babbage that the combinatorial count in the store was wrong;
he noted "ought … to be … on Prisms", drew the card prism (18 June), and
worked Y and Z onto the prism axis (10–11 July).
- For: the order of dates (L/023 7 June → dr 64 18 June → p 228 10–11
  July); the remark itself; p 228 cites the notation and L/023 cites p 228.
- Against: the card prism is already in the table body on 7 June ("Gear Z
  with prism"); drawing 64 is about operation cards and barrels and never
  mentions combinatorial counting; the combinatorial wheels "on the counting
  carriage axis" and the two backing cards are already in Dec 1837; the
  remark is not shown to be later than the table.

**H2. The mechanism (scheme) came first; the program was written to it.**
The design of Nov–Dec 1837 already had the combinatorial counter off the
store and two backing orders. L/023 is a notation that writes the counts
in Store columns because the notation form has only Mill and Store columns,
and the remark corrects the form, not the design. Drawing 64 and p 228 are
the continuing mechanical work on cards (scheduled in the June history).
- For: pp 137 and 161–162 contain every element of L/023's control
  (combinatorial cards, two backing orders with the run-up condition,
  first-difference computation); the prism is in the table body; drawing 64
  is a card/barrel drawing, not a counting one; the 252·5 h was worked
  the day before on p 200, so the sheet was a planned exercise.
- Against: L/023 makes the combinatorial number by computing it (Tab + Δ′)
  in the store, which is a real design choice and not only a notation
  convenience; the 11 July note, which assigns Y and Z to card and counting
  apparatus, comes after the program, so some details were settled later.

**H3. The remarks were added later.** The cross-references, and perhaps
the "Prisms" remark, were written on L/023 after 10–11 July.
- For: "See … p 228" cites a page dated 10 July, a month after the sheet;
  it and the "see p 200" are in the finer hand (b), and "see p 200" looks
  like a second stint after the N.B.; the "22" in "228" is darker, as if
  corrected.
- Against: hand (b) also writes table cells (rows 1–2), so it is not a
  later hand as such; the "Prisms" remark fits its space exactly without
  crowding and shows no sign of overwriting; p 200 is dated the day before
  the sheet, so "see p 200" could be contemporary. Nothing physical dates any
  of these to a later day.

H1 and H2 are not exclusive with H3: H3 concerns the remarks, H1/H2 the
design.

## 5. Assessment

The evidence favours H2 over a strong H1, moderately. The control
structure of L/023, its two backing orders, its run-up condition and its
computed combinatorial numbers, is written in the sketch book in Nov–Dec
1837, and a card prism is already named in the body of L/023. Drawing 64
is not a drawing of the combinatorial counter. A weak form of H1 remains
open: writing out L/023 may have prompted the specific decision of 10–11
July to put Y and Z on the prism axis, worked by a combinatorial card and a
combinatorial counting apparatus, and p 228 explicitly looks back to the
notation. The "See Sketch Book p 228" reference on L/023 must date from
10 July or later (H3 for that line is near certain on dates); for the
"Prisms" remark the physical evidence does not decide.

Open: the date of pp 161–162 rests on N/004 only; p 138 (continuation of
p 137), p 158 and p 75 "other end" (cited on p 162), and Vol IV p 64 (the
other backing apparatus) were not read; the fractions on p 200 are
uncertain.
