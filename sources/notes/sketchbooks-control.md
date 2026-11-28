# Sketch Books Vols II–IV: Babbage's control flow, compound addition and complements, 1836–1839

Read by a coding agent from the Science Museum Group images, November 2026.
**No person has checked these readings.** Where a passage matters, it was
read at full resolution from 512 px tiles of the zoom image, stitched (the
server returns at most 512 px per side for `/max/`); the rest was read from
the 1536 px previews (`coimages … large_*.jpg`), which is said each time.
Crops and previews are in `sources/downloads/smg/S/sk/` (git-ignored);
crop file names give the zoom-pixel region (x, y, w, h). The fetch script is
the one described in `codesign-L023.md` (tile, wait ≥ 3.5 s, stitch).

Conventions: diplomatic transcription, Babbage's spelling and
abbreviations kept; `[?word]` doubtful; `[illegible ~n words]`;
`~~struck~~`; `⟨inserted⟩`; `.n`, `.s` etc. for superscript endings
("Mult.n" = Mult with raised n). Figures are described in square brackets.

Image ids: Vol II files `large_000000NN.jpg` (zoom `322/…`–`323/…`), Vol
III `bab_s3_NNNN`, Vol IV `bab_s4_NNNN`; zoom path `<a>/<b>` is the
coimages/zoom directory pair (see `references.md`).

Corrections to `references.md` found here:

- **Vol II p 84 is the left page of image 45; it is unnumbered** (only odd
  pages are numbered in Vol II). Confirmed.
- **"Two or three sets of cards one before the other" (N/003, July 1836,
  "Vol 2 p 173 30") is not on p 173. It is on pp 178–179**, dated 30–31
  July 1836 (image 94). p 173 (27 July) has only sketches. "173" on the
  history sheet may be a slip for 178, or "173" may be a misreading of
  "178" in `N003.md`; the day "30" fits p 178.
- **Vol III image 87 is p 158 plus a loose ruled insert** (dated 11 Dec
  1837, a backing table); p 159 is the right page of image 88, beside the
  "Notation of the Multiplication of two series" wrapper. So p 160/161 is
  image 89 as predicted, but the insert count is two, not one.
- **Vol III's "other end" pages**: the book was also written from the back,
  upside down, with its own numbering at the foot. Forward page + reverse
  page = 550 (image 250 = forward pp 480/481 = reverse 70/69). So "p 75
  other end" = forward p 475 (image 247), "p 60 other end" = forward p 490
  (image 255).
- **Vol IV offset changes before p 271**: image 136 is pp 278/279 (not
  270/271); p 270/271 is image 132.
- **Vol IV p 17 ("Principles of Compound Addn", placed in July 1838 by
  N/005) is dated June 1839 on the page** (pp 11 lower–19, "25 June 1839",
  "26 June 1839"), written into pages left blank after the July–Aug 1838
  entries of pp 7–11. See §4.

---

## 1. Vol II pp 74–95, February–March 1836: counting apparatus, running up, repetition, choice of cycle

The 7 March entry of p 84 is a single paragraph, but it sits in a run of
pages (pp 75–95, 24 Feb – 23 March 1836) on counting apparatus for
multiplication, division and roots, which is where Babbage works out
running up, stops that end repetitions, backing of barrels, and choosing
between cycles by a running up. The run starts at p 75 ("Counting App. for
Mult.n", the history sheet's "Count.g App. for Mult.n vol 2 p 75") and ends
after p 95; pp 96–97 (23 March) are mechanism sketches only.

### p 72, image 39 (`322/995`), preview

Head: "24 Feb. 1834 This date must be wrong; it ought to be 1836 see page 81
of this Vol." (the correction in a later, smaller hand). Sketches of
counting/stepping wheels; "29 Feb." lower down. No text on control.

### p 75, image 40 (`322/996`), preview (cramped; not all read)

Head: "Counting App. for Mult.n". Facing p 74: a labelled sketch, "Driven
spiral axis", "Notched wh. on ax. No 1", "No 2", "Left hand counting
wheel", "Right hand counting wheel", "Directing cam", "Gathering up tooth
for Stepp.g up after Mult.n", "stop for −d", "Gather.g up tooth for Stepp.g
up after Mult.n", "p−d", "30−p", "q−d", "Driving spiral axis", "1836".

> [?] is transfer to one Notched axis (No 1) [?&] B to the other A having p
> digits and B having q digits. Let driving spiral move back, the top arm
> will receive if the top fig. is zero, the top notched wheel thus driven
> will drive the top arm of the spiral ac[?] which will bring the second arm
> of the same spiral into a position to be acted on by the second notched
> wheel if it is at zero and so on. It may be necessary to make the spiral
> take 2 turns at 2 different elevations. The driven spiral axis is thus
> moved as many teeth as there are zeros on the top of the number which it
> communicates to the ⟨two⟩ counting wheels p ⟨and p−d⟩ and similar
> mechanism from other notched wheel to other counting wheels q ⟨and q−d.⟩
> Superposition of motion thus carries the directing cam over no teeth if
> p = q but over p−q in one direc.n if p > q or over q−p in the other
> direction if p < q. p−d and q−d are wheels in which the stop has been set
> to d. d = No. of decimals. If p > q directing arm governs the barrel of
> multiplier axis which orders it to be ~~put out~~ ⟨put out on the
> multiplier axis⟩ and also to be tabulated, and the gathering up axis to
> be put into gear with q

### p 76, image 41 (`322/997`), preview (large hand, legible)

> N.B. p was previously thrown out of gear with p−d and q out of gear with
> q−d. At the same time A and B are put on Mult.n axis ⟨each⟩ ~~one~~ is
> received on the fig wh. of ⟨one of the⟩ carriages belonging to Mult.n
> axis. Table being ~~made~~ ⟨finished⟩ throws into gear ⟨circularly⟩
> gathering up tooth of p & q which acting on the gathering up wheel q (in
> this case) determines the No. of steppings down. It also throws into gear
> the Mult.n cycle of the barrels of Mult.r & Product axes here ends Mult.n
> but the stop of the count.g wh. q throws an arm in which in the
> subsequent part of its revolution throws out the gathering up tooth from
> q and throws in the gathering up teeth on q−d It also throws in on the
> barrel of the product axis the cycle for stepping up. the count.g wh. q−d
> determines the number of steppings up. This throws out Mult.n
> See page 78

p 77: "1 March"; algebra of a continued fraction (x′ = (a + x)/x, x″, x‴ …);
no text on control.

### pp 78–79, image 42 (`322/998`), preview (large hand)

p 78, head "1 March" (top left, with "78)"), "for Division":

> ~~Direction~~ A and B having been rec.d as before upon the counting wheels
> and consequently q−p upon the counting wheel of the directing cam and the
> directing cam having set levers to step up or down, it must be thrown out
> of gear with those levers and with the superposition of mo.n app.s and
> into gear with one of the red gathering up teeth which steps up or down
> the dividend q−p times. There is a stop or cam at the end of this which in
> concurrence with the stop at the end of the Table ⟨making⟩ app.s throws
> into gear division cycles

p 79, head "Division Contin.d":

> The wheel q is connected with the second counting wheel which has a stop
> upon it at d+1 which after q is counted stands at q+d+1 As soon as
> direc.g cam is out of gear p is reduced to zero and conseq.y the stop on
> the dec[?] coun.g wh. ~~now~~ marks q−p+d+1 The gath.g up tooth of
> q ⟨[?]⟩ ~~now~~ thrown into gear ~~as well as the regist~~ vertically
> ~~itself~~ thrown into gear circularly ~~is done~~ at the same time that the
> division cycle is thrown into gear. The reduct.n of coun wh. p to zero
> also sets the spi[ral] ax. belonging to the regis.r whs of divi.n to the
> p.th and the p+1.th cages
>
> Extr.n of Root of A
> The dec coun. wh. of p has a fixed stop at +30 on count.g the ~~digit~~
> number of digits in A this stop is placed at 30−p ~~[?]~~ a wheel a fixed on
> p has its even teeth wanting and drives a complete wheel b which has a
> moveable stop upon it set to ± d this is thrown out of gear with a and into
> gear with a gathering up arm gather.g up upon 30−p stepp.s up A each time
> the

### pp 80–81, image 43 (`322/999`), full resolution (crops 300,60,2200,450 and 2540,60,2220,1940)

p 80, top (continuing p 79):

> stop at the end of 30−p throws into gear ex.n cycles and also the
> gathering ⟨up⟩ tooth upon b ex.n continues until the stop on b puts an
> end to it

(The rest of p 80 is blank but for show-through.)

p 81, head "1 March 1836". At left a table headed "No of advances of
barrel", two columns: advances 1–26 against barrel verticals: "1 Rec. A & B
/ 2, 3 } Count on both / 4 4A Tabulate A. and reduce to zero car. fig
wheels / 5 5B Tab. 2a / 6 4A do 3a / 7 5B do 4a / 8 4A do 5a / 9 5B do 6a /
10 4A do 7a / 11 5 R do 8a / 12 6 do 9a Throw out A from mill" (rows 4–12
bracketed "Table making"), then "13 7 / 14 8 / 15 9A / 16 10 / 17 11 / 18
12B4 / 19 9A / 20 10 / 21 11 / 22 12B4 / 23 9A / 24 10 / 25 11 / 26 12B4".
So verticals 9–12 of the barrel are gone through again and again. Text:

> These repetitions continue 29 ~~cycles~~ ⟨advances⟩ of barrel after which
> steps up q−d times and the multiplication is done.
> The counting wh. by its stop then throws out barrel and into gear with a
> ~~backing~~ ⟨zero⟩ app.s which brings it to zero
> On the zero column of barrel there are directions to step up and a
> backing pin
> The barrel then backs to −1 and steps up again but −1 having an advancing
> pin barrel goes to 0 and so on —
> These alternations are continued q−d times when stop of q−d counting wh.
> throws all out and mult.n is ended.

Below: sketches, "Plan for backing cycles in barrels by an axis reducing
to zeros".

### pp 82–83, image 44 (`323/0`), preview

p 82, head "4 March", "1836". Sketches of counting wheels and stops; across
the middle "Counting App. p 74" [i.e. the sketch on p 74]; at the foot six
counting wheels labelled "30 / p−30", "0 / q−p", "0 / p−d", "0 / q−d",
"d+1 / q−p+d+1", "0 / p−q".

*Correction (28 Nov 2026, `running-up-designs-1836.md`):* re-read at full resolution, the p 82 wheels read "−d / p−d" and "−d / q−d", not "0 / p−d" and "0 / q−d".

p 83 (no date; "March" in a sketch): sums "a+b, a+b+c …" for S(a,b);
"v′₁ = f(v₁, v₂, v₃ … v₁₀₀)" …; sketches; "superposition of six different
movements under certain conditions". At the foot, in a later hand: "Very
Important as a general plan for the add.n Subt.n and superposition of
Motion 1870".

### pp 84–85, image 45 (`323/1`), full resolution (crop 1000,1150,1500,900)

p 84 (unnumbered left page). Head "6 March" (top left) over geometrical
sketches (a curve through P, A, E, Q with ordinates OR, PR, QR, OS); then,
in the middle of the page:

> 7 March
> When any operation is to be terminated ~~or at~~ after a given ⟨variable⟩
> number of repetitions, let the number of rep.ns be put on an axis having
> a carriage connected with it. Then ~~a running~~ on ⟨by a register axis⟩
> subtr.g unity ~~at~~ ⟨previous [to]⟩ each operation a running up will take
> place at end and thus the op.n be suspended

[The insertion above "subtr. unity" reads "by a register axis"
(the "by" uncertain); the one above "at" reads "previous".] Columns of
figures "04 08 12 16 20" twice; sketches of a carriage, wheels, a stack of
plates.

p 85 (numbered), head "8 March": series x/1² + x²/2² + …, A x⁰ + B x′ + …,
1/(1−x); sketches of counting wheels "tens" / "units"; "04 08 12 16 20 24".
Nothing further on repetition.

"Running up applied to order any Opn" (N/003, March, 7): no separate
passage. The 7 March paragraph is the only text dated 7 March in pp 74–95,
and it is running up applied to end ("suspend") an operation; it is
probably what both history entries refer to.

### pp 86–87, image 46 (`323/2`), preview

p 86 head "9 March 1836": decompositions of numbers into sums of powers of
2 ("7 = 4+2+1 = 2²+2¹+2⁰ = 111", "5 = 101"), multiples tables
("10 = 2.4+2 …"), sketches. p 87: sketches ("outer oblique teeth"). No
control text.

### pp 88–89, image 47 (`323/3`), full resolution (crops 250,720,2200,1860 and 3350,590,1410,530)

p 88, head "10th" over a sketch, then "11 March":

```
p = 0023              9977
q = 21                0021
        0023          ----
        0021          9998
        ----          0002
        0002

p = 19   +p = 0019        −p = 9981   R    9980 [over 99..]
q = 21   −q = 0021        +q =   21            21
p − q =      9998 R            ----         [?]901
                               0002 R
```

and a working "0000 / 19 / 0·091 / +[?] 21 / 111". "R" is written after the
result in the cases where (on the reading here) a running up occurs.
At the foot:

> Today planned the method of using digit Counting app.s entirely in Mill
> and plan of p. [?74] superseded except spiral axis and notched Whl.

p 89: sketches of counting wheels "units / tens / hundreds", "A", "B", "C";
"units 3 0 / tens 2 n / hund. 1 n′ / 0 n″" (?); text:

> If A have 10 on rising 1/10 it is thrown into gear with the tens at the
> 2nd ~~[?tooth]~~. If B has 10 it is also thrown into gear with the tens but
> not untill the 3rd [?tooth]

### pp 90–91, image 48 (`323/4`), full resolution for p 90 parts (crops 1420,120,800,620 and 600,1900,1850,950), p 91 preview

p 90 head "2 March" as read in the preview (head not fetched at full
resolution; p 88 is 11 March and p 91 12 March, so "12" is likely), and
"Lifters 13 March" lower down. Top right:

```
0019
9981
  19
----
0000
   1
   1
----
0002          21 = 19 + 2
```

with a note "fig. wh. on which p or q is put. This fig wh. is connected
with add.n carriage" (partly read). Lower: a "moveable snail" sketch: "a
moveable snail like that at page 132 in old book"; "Que. Would not 100
divisions be sufficient for snail instead of 2110? Units move …"; "d — a
disc which always moves the same distance, it does not touch the snail. b a
rack which is stopped by the snail and then turns the pinion e in a similar
manner to the digit count.g app.s above."

p 91 (preview), head "Digit counting app.s 12 March 36": a rack a with 30
feelers, etc., "so that the feelers on a will pass 15 wheels if they are all
at zero … thus feeling and transfer.g all the digits in 2 turns"; at foot a
table, "B +p Carr Sub.n −q runs up", "C +p No Car", "D +q No Car", "E +q Car
Sub.n −p", "During Tabu.n"; "Let q > p. Then Tab.n of mult. p multiplier";
"this should be [?] −d Carr. Sub.n, runs up / Change Car. from − to + /
During Mul.n +1 +1 +1 / = p−d at end of Mul.n".

### pp 92–93, image 49 (`323/5`), full resolution (crops 280,90,2160,1640; 280,1720,2160,820; 2600,630,2130,1280)

p 92 (no date; between 12 and 16 March):

> Suppose two Mul.ns going on at same time then for ~~one~~ ⟨the first⟩ we
> have A. B. C. Suppose ~~that~~ ⟨Product⟩ occupies Nos 1 and 2 on C and Nos
> 3 & 4 on B and Multiplier Nos 3 and 4 on C.
> Put p upon ⟨1st⟩ A ⟨2 and No 1 on B⟩ ~~and~~ q ⟨and No 3 on E⟩ upon ~~E~~ ⟨2⟩ F
> ~~Give off (& not retain) p to No 1 on B and q to No 3 of E~~
> Do — −p to No 3. on E and −q to No 1 on A
> A or E runs up and directs which is to be Multiplier.
> If q is Mul.r it must be transferred to A where it may be reserved while
> the same operations are gone through for the second Multiplication after
> which the mul.r of first Mul.n must be transferred to No 1 to ⟨have 1
> subtracted from it and to⟩ limit the No. of steppings down, and to No 2
> to have d+1 subtracted from it and to limit the No. of steppings up — but
> both 1 & 2 will want carriage

Workings below (full resolution): "p−d−1 = p−(d+1)", "p−(d−1)",
"000·00123", "N 99999 / 99985 / 00014", "N 99999 / 00002 / [?]99997",
"p−d−1 / 21 6 1 / 7 / 14", "d−p … 9998[?5]", "d = 23", "d−p = 2[?3]−21 =
+2", "+21 − 23 − 1 = −3".

p 93 (full resolution):

> 16 March — Decided that whenever transfers are made from Mill to Store or
> from Store to Mill the two central wheels should be ~~u~~ used together as
> one wheel

Below, in pencil: sketches of two cycles labelled "Neg. Cyc. q−p<" and
"Pos. Cyc. q−p>" [cf. p 94]; "Comp. P. = √(−P²) = P^½ √−1" [?; "Comp."
here may be "complex", not "complement"]; "a + b√−1".

*Correction (28 Nov 2026, `running-up-designs-1836.md`):* these pencil marks on p 93 are p 94 showing through the leaf; mirrored, they are p 94's drawing and text in p 94's positions. p 93 has no cycle sketches of its own.

### pp 94–95, image 50 (`323/6`), full resolution (crops 250,60,2200,2740 and 2530,60,2230,2740)

p 94, head "22 March", "1836". Left, a column "03 06 09 12 … 27"; a
division "Div.d 000514 / 03 / 21", working "051 / 03 / 021 4 / 21a / 210 /
004". Text:

> Carriage is ⟨in some cases⟩ to be prevented when running up occurs and
> the ⟨lowest⟩ wheel put back to 0

Figure: a horizontal "running up axis" carrying three arms; below them
three barrels or cycle-wheels on axes, labelled "B" ("Pos. Cyc / q−p > 0"),
"A" ("Neg. Cyc / q−p < 0") and "C". At left a lever, "Positive / 1 = New
cycle step". Text:

> At No 4 throw A into gear
> If in 5 q−p runs up A will be moved and cycle Neg. be put in gear. If it
> do not run up then A must be thrown out of gear and B into gear.
> The 1st vert.l of Cycle Neg. puts out A and puts in C which C on the next
> running up puts out the cycle Neg

p 95:

> The term.n of Pos. or of Neg. Cyc acts jointly with the term.n of table
> making to put in the real division cycle

"Sq. root"; working "·000021 / ·000010 / 0·000000000021", "(p+q)/2",
"30 − q+1 + d"; a sketch "A every other", "B", "C"; struck through: "if at
1 or 2 it stops it subtracts 1 / 3 or 4 … 2 / 5 5 … 3 which arises from
having every alternate tooth wanting". Then:

> If there are 1 or 2 then step up 28 30−2 / 3 or 4 26 30−4 / 5 6 24 30−6 /
> 7 8 22 30−6[sic]
> A is driven one at each move in digits B is on same axis ⟨and⟩ fixed to A
> but every other tooth is cut out — B acts on C and when a tooth act it
> drives C over two teeth but at the next move of B its blank tooth cannot
> drive C

pp 96–97 (image 51, `323/7`, preview): "23 March"; mechanism sketches only.
The topic of counting apparatus continues in other forms but the control
passages end at p 95.

---

## 2. Vol II pp 170–179, 188–189, July–August 1836: cards, sets of cards, complements

### pp 170–171, image 90 (`323/46`), preview

p 170 "22 July"[?]: sketches, "10 for Mult.", "10 for Step". p 171: "a
sector, b sector, 10 goes to 11 by sector 4+2 / 12 goes to 9 — 8+1 / Up
13−8, 14−4−2 / Down 15−8−4, 16−8−2"; powers of a, (p n² + q n + r); a row
"1 2 3 … 24" over "0 S S′ …". No control text.

### pp 172–173, image 91 (`323/47`), preview (p 172 large hand; p 173 pencil)

p 172, head "25 July 1836" (written over "23 July"):

> Every horizontal line in the notation ⟨of formula⟩ ~~[?]~~ represents a
> card. The variables on the ~~left~~ ⟨left⟩ side of the Mill belong to the
> upper central wheel — those on the right to the lower central wheel.
> ~~Determined that two~~ No more than one operation be done at one time on
> the same side of the Mill.
> (3) It is impossible to add by giving off from a store to a store; if a
> number is given off from a store to a store the compliment of each digit
> is received.
> (4) If the compliment of each figure is given off from a store to a store
> the number received is the original number.
> (5) In obs.n (3) and (4) it is supposed that the axes which receive have
> no figures upon them previous to reception.
> See page 188

p 173, head "27 July", pencil throughout. Top: sums "a, a+b, a+b+c,
a+b+c+d", "3(1+2+ … n) = 3 n·(n−1)/2", "(2+3+4 … n+1) = (n+1)·n/2",
"3×20×39 = 780 × 3 = 2340 + 820 = 3160", "100 / 50 / 5008 / 20000", "4×100".
Sketches: an octagon and a hexagon (prisms), a frame with zigzag springs,
"lever", a wheel. Middle: two horizontal lines divided into compartments,
the upper headed "Shift [?]" with entries "Aa | Ba Ab | Bb | Ac", the lower
"Aa | Ab Ba | Ac | Ac Bb Ca | Ab | Ac | Ad", with B, C, D written below
some compartments and "3" marks above. [These look like the sequence of
pairs of letters (coefficient products) taken in turn, as for the product
of two series; not read in detail.] Bottom: a long plate with two rows of
holes, wheels, a rack. **No sentence about sets of cards is on p 173.**

### p 175, image 92 (`323/48`), preview

Head "27 July": "a/(1+x) = a − ax + ax² − …"; "A + B sin θ + C sin 2θ + …";
"1 3 5 … 40 / 1 2 … 40 / 20×39 = 780"; sketches. p 174 ("1836"): sketches,
"6, 6+6, 6+6+6 …", a card with two rows of holes and "Mult".

### pp 176–177, image 93 (`323/49`), preview

p 176, head "27 July 1836":

> When very complicated formula are worked by Engine after the cards are
> once made ~~it will be~~ as for instance for the development of any
> function in a series it will be better to verify the cards by assuming
> such constants that the coeff. of the series may all be some very simple
> numbers as unity or all be in geom. progress. or in arithmetical

Below: "Card for Eng." — a card divided into "Upper fig Wheels | Mill |
Lower fig Wheels", with holes along its edges.

p 177, head "28 July": "100 Variables each 3 sectors each sector 2 levers
600 / Mill 23 in all +1 for backing 24 / 624"; arithmetic on 624; sketches;
"Lever for fig axis ST / Pri axis ST / Receive LT".

### pp 178–179, image 94 (`323/50`), full resolution (crops 270,1880,2180,940; 2570,80,2200,1420; 2570,1450,2200,1400; and 250,60,2200,1850 at half resolution)

p 178, head "30 July". Top half: complements worked:
"0034 / 0004 / 0136"; "(10ⁿ−b)a = 10ⁿa − ab"; "1·0000 / 0004 / 9996 /
0004"; "0014 / 9986 / 0000 / 0014 / 0096"; a long division
"9996 … 0204 / 306 …"; "0004) 9864 / 2466"; columns "00000012 /
99999988", "00000001 / 99999999 }", "−00000001 / 99999999", "−99999999 /
00000001 } 4 … −2 z+2"; "A − B = −a"; "P Q / + + − / − − +". Then, after a
ruled line:

> 31 July 36
> In backing cards for Dev.n of series the first card or rather the plate
> with holes which pushes the card must have a lever behind it which at
> each backing advances laterally one hole whenever the first card acts
> this lever must advance with it thus (see No 5 Not.n 31 July) making it
> be alternately received on each variable in the first appropriated to the
> great letters [?]
> The same effect might be had by throwing two cards at certain variable
> intervals but the first seems ⟨best⟩.
> Two sets of cards one before the other with different times of movement
> would do the same thing

[At left, a sketch: a ladder-like strip (the card) bent round a curved
guide.]

p 179 (continues):

> are set to have 9 cards.
> The 1st time No 3 passes a card of the 2nd set is to act and then pass to
> a blank this will give the zero marked at 3 in the Not.n for each of the
> [?Calc.n]
> The first set passes ~~[?]~~ once and backs —
> It then passes twice
> thrice times
> four
> The 3rd set of cards acts at ⟨the⟩ 2nd 3rd &c. passages of the groups of
> the 1st and puts on the c/B in 12 & 15 the d/B in 21 & 24.
> It does not recede —
> Or conditional arms may be interposed between the wires and their work
> and these may be governed by studs on a revolving barrel

[At top left a sketch: a card bent round a prism-like guide, with wires.]
Then, dated "1 Aug.t", complement arithmetic under "Mill" and "Store":
"b + (p₁ − q₁)x"; "+P = 00034 / +Q = 00004", "−P = 99966 / −Q = 99996",
"+P = 00034 / −Q = 99996", "−P = 99966 / +Q = 00004"; "P = 000123,
Q = 000041, −P = 999877, −Q = 999959", "P = 000123 + Q = 999959 [sic for
−Q] = 000082"; a stepped division "00204 / 00306 …".

So this is the entry the history sheet records in July 1836 ("Two or three
sets of cards one before the other", day 30): three sets of cards (p 179's
"1st", "2nd", "3rd set"), the first passing once, twice, three, four times
and backing, the others acting at chosen passages; with conditional arms
governed by a barrel as an alternative.

### pp 180–181, image 95 (`323/51`), preview

p 180 "7 Aug.t": divisions by complements ("9996 | 013600 / 999996 …",
"b/(10ⁿ − a) = …", "10000 − 4", "9988 / 0136"). p 181:

> Rec + on No 1
> Rec — on No 1
> Give Off & Retain on No 1
> ——— on No 2
> Rec + on No 2
> Rec — on No 2

with long columns of nines-filled complements ("9999960000136",
"10⁴ − a, 10⁴ − b", "10⁸ − 10⁴(a+b) + ab = …").

### pp 188–189, image 99 (`323/55`), full resolution for the lower part of p 188 (crop 250,1650,2250,1200), preview for the rest

p 188, head "11 Aug.t 1836 Of the Notation of Formulae":

> 1 Every horizontal line in the Not.n of Formulae denotes a Card
> 2 The variables on No 1 & No 2 belong to the Upper Cent.l Wh.l and are
> connected by them with the Left side of the Mill
> 3 The variables on No 3 and No 4 belong to the lower centr. Whl. and are
> connected by them with the right side of the Mill
> 4 Any ~~[?]~~ Variable belongs to either side of the Mill when the Cent.l
> Wheels are united by ⟨uniting⟩ ~~[?]~~ pinion
> 2* A variable in Store cannot be transferred to other fig. wheels of
> Store. But its numerical compliment (that is the compl. of each digit to
> 10) can be transferred
> 2** Hence, a variable may pass by card to other ⟨in Store⟩ fig. whs which
> receive its numerical compl. ⟨and⟩ by a second card ⟨the numerical
> compl. of⟩ this numerical compl. may be restored to its former fig wh. or
> placed on any others in Store — But the numerical compl. of a numerical
> compliment is the variable itself

p 189 (preview):

> Thus 007621 = Variable / 003489 = Numerical Compl
> Again 003489 = Var. / 007621 = Num. Comp. of Var.
> 5 It is impossible to execute two opera-tions ⟨at once⟩ on the same side
> of the Mill
> 6 ~~[?]~~ numbers are to be put in on the fig wh. of Mill — except the
> engine is used as one of differences — ⟨But when numbers are received
> from Store into Mill their numerical compliments may be retained on any
> axes of the Store⟩
> 7 Numbers with their proper signs are to be put on the fig whs of Store
> N.B. Numbers are always placed in the store with positive signs. But
> when they become changed by any operations in the Mill the signs so
> acquired are conveyed with them into the Store
> If the Engine considered as a single one ⟨of 30 fig.⟩ ~~[?]~~ ⟨using⟩
> only one side of the Mill
> 8 Any ~~number~~ vari. ⟨or P⟩ may be brought ⟨down⟩ from the Store into
> Mill by a card and placed so as to be prepared for having another
> variable added to it
> 8* Any variable may by a card be brought out of Store into Mill and
> placed so as to be prepared for having another variable subtracted from
> it

[The "numerical compliment" here is digit-by-digit to 10 (7621 → 3489),
as p 189's example shows: 7+3, 6+4, 2+8, 1+9.]

---

## 3. Vol III pp 137–166, November–December 1837: counting apparatus, running up, combinatorial cards

All from the previews (Vol III pp 138–166 are in a large, regular hand and
fully legible at 1536 px), except where stated. p 137, 161, 162 are in
`codesign-L023.md` §1.1–1.2 and are not repeated.

### p 137, image 76 (`225/288`): see `codesign-L023.md` §1.1 (18 Nov 1837)

### pp 138–139, image 77 (`225/289`)

p 138 (continuing p 137, whose last words are "and the number of cards
required"):

> for the formulae and variables is reduced to the lowest possible — for we
> must have one card for each variable and in this case there are not more
> — We must also have the cards for the two operations

Then "20 Nov": the formula (ab − cd)/(ac + bd) set out as v₅ = v₁ × v₂,
v₆ = v₃ × v₄, v₇ = v₁ × v₃, v₈ = v₂ × v₄, v₉ = v₅ − v₆, v₁₀ = v₇ + v₈,
v₁₁ = v₉ ÷ v₁₀; the operations "× × × × − + ÷" and signs "+ − − + + − −";
cards drawn as groups of lines; "ac², mc + nc"; a letter scheme "a b c d e
f / a b c d e f / ab ac ad ae / bc bd be / cd ce".

p 139, head "24 Nov": sketches of carriage and wires; "For top of running
up a carriage"; "Running up levers No 1, 2, 3, 4"; figures "80 81 82 90 91
92 93", "9·48 9·54 9·59 9·64", "918700·00 / 9500"; "3·14 / 2·500 / 2·98 /
3·02". No text on control.

### pp 140–141, image 78 (`225/290`)

p 140, "For Extr. of Sq. root", "24 Nov", a list of steps with turns at
left ("1 Receive Power / 4 Count digits and put two first ⟨changed if there
are an odd number⟩ in conn. with Registers (they being connected with Root
table / 8 { Reduce to zero and put + 2 first fig by table; In the meantime
add d to spiral and halve it } 6 turns / 1 Rec 2 fig of root through
registers in right place / 1 to put this in store / Then follow approp.
cards", total "15"); "Mult. 15 + No of digits in Mult.r + steppings";
"Div.n 18 + 2 No of digits in Quotient + Steppings"; "Nov 27"; sketches,
"Running up levers", "Carr sign".

p 141, "24 Nov", headed at right "Add.n & Subt.n with signs":

> A enters
> A transfers B enters
> A+B added C enters
> A+B goes out & is ~~retained~~ ⟨retained⟩
> C added
> A+B+C goes out & is retained ⟨returned [?]⟩
> D added

Then:

> By a 41st wh. on ⟨all⟩ Carr. called a sign wh. and a pair of fig wheels
> in each of the 41st cages of ~~the~~ Mill
> Avoids requir. for add.n a sign train in "F at sign on pinion conn.
> ⟨with⟩ central. 27 Nov 1837

[This is a running sum, one number added at a time, not an addition of
more than two numbers at once.]

### pp 142–143, image 79 (`225/291`)

p 142, head "28 Nov.r 1837":

> It was found that ~~ordinary~~ fig wheels on A with carriages on F & ′F in
> the 41st or sign cage with an axis to separate the sign wheels on A from
> the fig wheels — fig wheels only in 41 cage of ″A and a fig wheel in 41
> cage of carr ″F with a wire at every odd fig lifted when it stood at an
> odd fig by a fixed arm on ″W and which when it lifted put a carrying
> sector on ″C into gear which moved it one fig and thereby set it to an
> even No = + and an axis to separate the top pinion of ″O from the other
> pinions on that axis, numerical carriage never going higher than 40th
> cage, would combine the signs correctly for Add.n & Sub.n Mul.n &
> Division.
> The numbers for Add.n & Sub.n were brot. from transit axis to ′A and sign
> wheels only of ″F and from ′A trans. to A &

p 143, "Multiplication", "q = No of digits in Multiplier d = No of
decimals"; a list of steps with "No of Turns" at right:

> Set the Barrels for Mult.n — 1
> Bring first factor into Mill — 1
> Do 2nd Do and subtract it from first with carriage ″F — 1
> ⟨Commence Table⟩ Transfer Q (the Multiplier) and set the spiral ax. of R
> to q by gearing it with Y and at the same time put q on the counting
> app.s Nos 1 & 2 by gearing their units wheels with Y — 5
> Subtract the number which represents the number of figures in the
> Multiplier which are to be used (where is this number to be put?) from
> the count.g app.s No 1. If it runs up reduce it to + zero and use the
> other one No 2. but if not, subtract the numb.r left from the counting
> app. No 2 and then use it for q — 2
> See page 185

### pp 144–145, image 80 (`225/292`)

p 144 (continuing):

> Reduce the counting App.s No 1 to +0 — 1
> Each time 1 is counted off No 2 add 1 to the count.g App.s No 1 and when
> No 2 is reduced to 0 change the sign of No 1 subtract d from it, and
> proceed as in Not.n 68
> Make Table with Ax. ″A
> Mult.r upon ″A after table is made
> Product upon A and ′A
> d upon the axis which has complement in Division and when it is given
> off it is transferred from one wheel to the other on that axis
> The highest figure of the Mult.r is used first the multiplier is stepped
> up and the Table is stepped down
> 13 Nov. 1837

p 145, "Division with one set of picking up sectors such as those on
Drawing No 52 / q = No of digits in dividend p = ditto in divisor d = No of
decimals": four bracketed comparisons of "Not.n 71" with the "Method
described below": "q+1−p / 9+1−14 = −4 expressed by 996 / p−q−1 /
14−9−1 = +4 expressed by 4 } Step up 4 times"; "q+1−p+d / 9+1−14+8 = +4
expressed by 4 / p−q−d−1 / 14−9−8−1 = −4 expressed by 996 } 4 figures in
quotient"; "8+1−5 = +4 expd by 4 / 5−8−1 = −4 expd by 996 } Step down 4
times"; "8+1−5+3 = +7 expd by 7 / 5−8−3−1 = −7 expd by 993 } 7 figures in
quotient". Foot: "In the method described below (or rather in next page)
when p−q−d−1 = 0 or +1 or +2 &c there are no figures in quotient".

### pp 146–147, image 81 (`225/293`)

p 146, steps with "No of Turns":

> Set Barrels for Division — 1
> Bring P into Mill and set spiral axes of ″R and counting app.s Nos 1, 2
> & 3 (by acting on their units wheels) to p Bring in Q on No 2 of ″A
> (signs on No 1) and ′Q on No 1 of ′A — 5
> Disconnect carr. from spiral axes and bring it to −0 (N.B. by a little
> alteration it may be at −0 ⟨at the end of the turn in which⟩ ~~when~~ it
> has finished setting the spiral axes. See Note A on Notation 74 Sheet 2)
> [bracketed "Table commences"]
> Transfer Q from 2 to 1 on ″A and by means of an axis (not shewn in
> drawing 52) gearing with Y subtract q from counting apparatus Nos 1, 2 &
> 3 (by acting on their units wheels) after their signs have been changed
> and 1 subtracted from them — 5

p 147:

> Lift wires of counting app.s No 1. If it runs up order Stepping down. If
> it does not run up subtract 1 from it and lift the wires again if it now
> runs up order no stepping but if it does not run up order Stepping up —
> 1
> Subtract d from Counting app Nos 2 and 3. If neither count.g app. No 1
> have run up in the last turn nor Nos 2 & 3 in this turn there are no
> figures in the quotient; but if running up has occurred in either turn
> proceed with the operation

Margin: "Stepping commences / In common Division p−q−d−1 is now ready. / If
there are no figures in the quot.t it is known".

### pp 148–149, image 82 (`225/294`)

p 148:

> If roots are to be extracted by approx.n Add the number of digits which
> are to be retained of the quotient = n which has been put upon a wheel
> (what wheel?) by cards to Counting App.s No 3 If it runs up use No 2
> which has p−q−d−1 upon it as in common division — 1
> But if it does not run up add to its units wheel until it does run up and
> for every unit moved add, to the units wheel of Counting app. No 2 &
> move the spiral axis of R one division; this may be done by a gathering
> up tooth acting on the units wheel until it comes to 0 and then waiting
> until the wires have been lifted. The Counting app No 2 has now comp. of
> n upon it which use instead of p−q−d−1 — 4 / See page 185

p 149:

> In the method of counting shewn on Not.n 71 the fact of there being no
> figures in the machine could not be known until the end of the
> preliminary steppings it is here known in the 12th turn.
> 15 Nov. 1837
> If quotient were began in the cage of the highest figure and spiral axis
> moved circularly at every figure it would require d to be given off to
> p−q−1, unit by unit, and would only save the turn of the hand in which d
> is transferred to one of the Table axes.
> 24 Nov. 1837. For the purpose of extracting Roots by approx.n there is to
> be a wheel with a zero app.s which sets it at a certain number (say 11)

### pp 150–151, image 83 (`225/295`)

p 150:

> and a wire to enable it to run up, and a gathering up tooth. This wheel
> is to be thrown in when Approx.n is ordered and at the proper time shifts
> the barrels (by the running up acting on their sectors) to the verticals
> for adding n to counting app.s
> Division with one set of picking up sectors like those shown on Drawing
> No 52 and a set to the other carriage like those in page 134 ~~Sketch~~
> ⟨of this⟩ Book ~~[?]~~
> Set Barrels for Division — 1
> Bring P into Mill and set Spi. ax. of ″R and counting app. Nos 1, 2 & 3
> to p−1. Bring in Q on No 1 of ″A and to the 2nd set of Picking up
> sectors and ′Q on No 1 of ′A — 5

p 151:

> Table commences
> Change sign of count. app. Nos 1, 2 & 3 and subtract q from them — 1
> Lift wires of count. app.s No 1, &c &c — Stepping commences (4 turns
> sooner than in the method at page 145) Subtract d from Count. App.s Nos
> 1, 2 & 3 If neither &c &c — 1
> If there are no figs. in the quotient it is known 4 turns sooner than in
> the method at page 145
> If roots are to be extracted by approx.n Add the number of digits &c &c
> — 1
> But if it does not run up &c &c (see the method for Division at page 145)
> — 4
> Division may now commence as soon as table is ready unless the number of
> preliminary steppings prevent it.

### pp 152–153, image 84 (`225/296`)

p 152: "1234 / 1 1 1 / 2 1 1 / 3 1 1 / 4 1"; "a / a+b / a+b+c / a+b+c+d"
"in letters if a had been in b — b−a, c — c−a−b, d — d−a−b−c"; "put these
a … on axis govern.g [?]"; "No 1 p / in one turn step P down"; "10⁴⁰ − 1 /
10⁸⁰ − 2×10⁴⁰ + 1". Then "2 Dec 1837": (ab + cd)/(a + b) with
a = a′ + a″/10ᵈ etc., worked for numbers in two parts.

p 153: "Head / Tail" — numbers split into head and tail ("1234·567891",
"0000·000001", "7891 × 191 = 875901", "6 dec.", "p q / p+q No in
Product", "Head 4 or q+1 / Tail 40 p / step down 40−p", "Required to have
40−p / +q / n+q+1 / step p−d−1").

### pp 154–157, images 85–86 (`225/297`, `225/298`)

p 154: "Mode of Operating suited to the manner of obtaining the sum of ⟨w⟩
~~the~~ products, each formed by beginning the Multiplication at the bottom
of the tail axis. Let every number be supposed to consist of head and tail
on two separate axes. After the sum of the products has been formed and is
⟨to be⟩ brought into the Mill as a Dividend, bring in head first — if the
carriage appointed to ascertain whether it has any figures ⟨does not⟩
run~~s~~ up — bring in its tail on the head axis"

p 155: "and treat it as head — if ⟨it does run up⟩ ~~not~~, bring in the
tail on the tail axis and add or subtract as the case may be. 40 to or
from the counting apparatus. If both head and tail are 0 notice of that
fact must be given by the ~~carriage~~ ⟨carriage⟩ which receives tail
⟨not⟩ running up to go to the final verticals.
The orders given by running up must be conveyed through the running-up
lever to the levers governing the requisite reducing sectors.
When Multiplication is begun with highest figure of Multiplier the same
number of figures as with the above method may be used either by stepping
the product down to the bottom of"

p 156: "tail axis = 40−p times, or putting the top of head axis in
communication with the bottom of some other stepping axis; then if by
stepping up the head goes off it is reserved and put into Store and from
thence again into Mill as the true head, and is treated as above, and that
which remains on axis ′A goes into Store as tail.
In Division the head (stepped off from top of A) is to be brought in on A,
and the next 40 figures on ″A and when all are stepped off ′A, 40 more are
to be put upon it. When 40 figures of Quotient have been made they are to
be given off to an axis for receiving Head of Quotient in Store."

p 157, head "8 Dec.r": three equations ax + by + cz + d = 0 etc.;
"Ax + By + Cz + D = 0", "x = −D/A"; a table headed v₁ v₂ v₃ v₄ with
"+ + + +" and x⁰ x¹ x² x³ at foot; sketch of carriage "No 1/2", "41", "40".

### p 158 and the ruled insert, image 87 (`225/299`); p 159, image 88 (`225/300`)

Image 87 read at full resolution (whole image stitched, 4577 × 3063;
crops of p 158's lower half and of the insert).

p 158, head "~~10~~ 11 Dec 1837", with "A B C" over the product
"aA + (aB + bA)x + (aC + bB + cA)x² +" of "a + bx + cx² + dx³ +" by
"A + Bx + Cx² + Dx³ +". A sketch: two card-frames either side of a
vertical axis carrying small wheels. Columns of operation signs growing by
one pair each time ("× +", "× + × +", "× + × + × +" …) and "x⁰ x¹ x² x³";
"v₁ v₂ v₃ v₄", "aA 0 / aB 0 / bA aB". Lower half:

```
A (struck)        B                    C
(x+, xx)    (x+, x+, xx)     (x+, x+, x+, xx)
1, 2, 3, 4

1234 | 12, 12, 34 | 12, 12, 12, 34 |       [the 12s underlined]

~~[?Repeat]~~   Back 4 add 2           126346
                Back 2
                Back 4
                    add 2
                Back 2
                    add 2
                Back 2
                Back 4
```

and to the right "0 1 2 3 4 v₆", "a.b + b.B + c.A" (pencil), "c d c b a /
A B C D", "+ −". [Read as: the groups of operation cards are "1 2" (× +)
repeated and "3 4" (× ×) closing; the backing orders "Back 4", "add 2",
"Back 2" give the movements of the card prism, by 4 to the start and by 2
to repeat the pair.]

The ruled insert (right half of image 87; a loose sheet of ruled paper
with red vertical rules, torn at the foot), dated at top right
"11 Dec.r 1837". Column heads: (1) row numbers; (2) "× + ÷[?] × × /
1 2 [?6] 3 4 [?6]" [operation numbers]; (3) blank; (4) "Operation
Backing"; (5)–(6) blank; (7) "Δ′₁" with an arrow from (6); (8) "Comb.l
fig. Wh." with "T₀" [?] under it (struck, overwritten); (9) "Comb.t
Backing"; (10) in pencil "Comb backing". Rows (ink for 1–10, pencil for
11 on):

| row | ops | Operation Backing | Δ′₁ | Comb.l fig. Wh. | Comb.t Backing | Comb backing (pencil) |
|---|---|---|---|---|---|---|
| 1 | 12 | | | | | |
| 2 | 6 | | | | | |
| 3 | 34 | | + | 1 | 1 | [?T] |
| 4 | [blot] | backs | | | | |
| 5 | 12 | | | | | |
| 6 | 6 | | | ~~[?]~~ | backs [pencil] | |
| 7 | 12 | | | | | |
| 8 | 6 | | | | 0 [pencil] | |
| 9 | 34 | | + | 2 | 2 | |
| 10 | 6 | backs | | | | |
| 11 | 12 | | | | | |
| 12 | 6 | | | | backs | |
| 13 | 12 | | | | | |
| 14 | 6 | | | | backs | |
| – | 12 | | | | | |
| – | 6 | | | | 0 | |
| – | 34 | | | 3 | 3 | |
| – | 6 | backs | | | | |

[So the table runs the product of two series as L/023 later does: a
repeated group "12" (× +) with "6", a closing group "34", the
combinatorial figure wheel counting 1, 2, 3 (incremented by Δ′₁ "+"),
"backs" in the Comb.t Backing column while the count lasts and "0" when it
has run out, and "backs" under Operation Backing at the end of each
round. Short rules in the margin after rows 3, 4 and 10 and at the foot
mark the rounds.]

p 159 (right page of image 88, `225/300`; the left half of image 88 is the
wrapper "Notation of the Multiplication of two series — Sketch Book p 1"
[the "1" may continue]): "R.t Bc [?] lat[?]", "a b c d e", "P₀ + P₁x +
P₂x² + P₃x³ + …" with "x⁰ x¹ x² x³ x⁴"; sketches of small wheels or
studs marked "0", "Give", and a bracket labelled "effective / ineffective".
This is the page that p 162 cites ("see page 158 of Vol 3"): the
"effective / ineffective" bracket is on p 159, the grouped operations and
backing orders on p 158.

### pp 160–162, images 89–90: see `codesign-L023.md` §1.2

p 160 is blank (show-through only). Date of p 161: no date on the page;
the insert of image 87 is dated "11 Dec 1837", which fits N/004.

### pp 163–166, images 90–92 (`225/302`–`225/304`)

p 163:

> Combinatorial Cards (one set) turn first
> Formula Cards { Operation Cards (one set) order barrels to prepare for
> the operation by moving to the first vertical and then order the
> Variable Cards (two sets) to supply variables to be operated upon }
> The Mill by means of the Barrels performs the operations without further
> orders from Cards
> When the operation is finished, the barrels direct the variable cards to
> turn in order to place the result of the operation in Store
> The above relates to the case where all the variables are on figure
> wheels of Store
> If some of the variables are on Number Cards (2 sets) then when

p 164:

> they are required the variable cards order in the proper number card, it
> is given off by the small racks to figure wheels in Store, transferred to
> other Store wheels if necessary and conveyed into Mill when it is wanted
> When the operation Cards have completed the orders they have received
> they order the combinatorial Cards to turn, which give off to the
> combinatorial wheels the number of repetitions of operations to be made
> to obtain the next term of the series
> At the end of each operation the barrel orders the operation cards to
> turn.

p 165:

> The Combinatorial Cards might be inserted among the number Cards, and
> give their numbers off to the Store and thence to the Combinatorial
> wheels; but as this would be combining Cards of the most general nature
> with those of the most particular and as there are but three
> combinatorial wheels, it was thought best to keep the two kinds of Cards
> separate. 13 Dec. 1837 See page 60 other end
> 13 December 1837
> On Machinery for the Algebraic Development of Functions
> About this date the idea of making a development engine arose with
> considerable degree of distinctness. It is obvious that if the
> Calculating Engine could

p 166: "print the substitutions which it makes in an algebraic form that
we should arrive at the algebraic development "it can print all those
substitutions which are noted in the composition in some of the
Notations" — It will however be better to construct a new engine for
~~that~~ ⟨corrected⟩ purpose[s] [such purposes]". p 167 is "2 Jan.y 1838",
mechanism sketches: the topic ends.

### Internal references from pp 137–166

- **"see page 158 of Vol 3 Sketch book"** (p 162): p 158 and p 159,
  above.
- **"See page 185"** (pp 143, 148): p 185, image 101 (`225/313`),
  preview. p 184 head "15 March" [1838]: "After Mult. Step 10 times",
  "Have stepped 3 / Spiral was ordered [?] up / Let d = decimals, p = No of
  sig. figs., x = No of figs ~~[?]~~ of Mult.r used / After Mult. (a−1)
  stepping up / if Mult of all figs (p−1) step up / (p−1)−d stepp. up …
  x = p−a−d". p 185, "Mult.n for Approximation": worked products, then
  "Hence x the Number of Steppings after Mult.n which was commenced at the
  a.th significant in the left is x = p−a−d / p = No of sig fig. in
  Multiplier / d = No of decimals — Hence spiral of register must be turned
  through p−a divisions And after this Multiplication Product must be
  stepped up x = p−a−d times / See page 187". Arithmetic of the steppings;
  no further control. (A cross-reference added after 15 March 1838 to
  pages of Nov 1837.)
- **"See page 75 other end"** (p 162). Forward p 475, image 247
  (`225/466`), read from the preview rotated 180°. Reverse page 75, head
  "30 May" (no year; the facing reverse p 60 has "13 Jan" and "13 March
  1838", so 30 May is probably 1838, the week before L/023):

  > 30 May
  > Formulæ Cards must be divided into 6 groups
  > 1st Preparation Cards — these place numbers from the number cards in
  > the Store and are never used but once
  > 2 — Cards to make the combinatorial numbers
  > 3 — Cards subject to the combinatorial process and which relate solely
  > to the coeffecients of the development.
  > 4 — Cards to make the combinatorial number for the functions
  > 5 — Cards subject to the combinatorial process which relate solely to
  > the function according to which the variable is developed
  > 6 — Cards not subject to the combinatorial

  reverse p 74 (forward 474):

  > process by which the coeffecients & the function are combined
  > 1. Prepar.n Cards
  > 2. Cards for Combin.l Numbers
  > 3. Formulæ for Coeff.ts
  > Last card is combin.l and orders backing but if running up in Combin.l
  > Axis occur this order is destroyed
  > 4 Card for Combin.l No.
  > 5 Formulæ for variable
  > Same remark applies here as at 3
  > 6 Cards for combining coeffecients and Function of variable
  > Last card orders backing to end of prep.n Cards. —
  > There are to be 3 wanting tooth wheels each of which can be set to back
  > any No of cards
  > The Combin.l Card on 3 governs the 1st wheel
  > — Do — 5 — 2 —
  > — Do — 6 — 3 —

- **"See page 60 other end"** (p 165, 13 Dec 1837). Forward p 490, image
  255 (`225/474`), rotated preview. Reverse p 60, headed "Cards" (a
  pencil mark after it), "13 Jan." [1838]:

  > If operation cards call in Add.n or Sub.n any number of times, they
  > have been ordered to be turned by the successive verticals of the
  > barrels; but when the last of these cards gives its order, the next
  > vertical orders the operation cards not to turn any more
  > The last card that orders Add.n or Sub.n must act upon a lever which
  > prevents the Barrels from ordering the cards to be turned again until
  > the operations are completed
  > Note — The above has all been altered. The Oper.n cards order a certain
  > oper.n — say Add.n which goes on as long as variables are supplied; the
  > last variable card calls into ⟨action⟩ the operation card which orders
  > Sub.n or Give off &c &c and sets the variable cards in motion to supply
  > numbers or axes to receive results &c &c 13 March 1838
  > No. of small operations
  > Add.n — Give off
  > Sub.n — Give off and retain
  > Stepping to be done in Store
  > No of great Oper.ns
  > 2 Methods of Mult.n
  > Division — { 2 small and 3 large operations

  [The facing reverse p 59 is blank. This is the "operation that goes on
  as long as variables are supplied", i.e. an addition of a run of
  numbers ended by the last variable card: see "Compound addition" below.]
- Other references on these pages are to notation sheets, not the sketch
  book: "Not.n 68" (p 144), "Not.n 71" (p 145, p 149), "Note A on
  Notation 74 Sheet 2" (p 146); to drawings 52 (pp 145, 146, 150); and "page
  134 of this Book" (p 150, picking-up sectors, the history sheet's "By
  picking up Sectors p 134 of III"). Not followed.

---

## 4. Vol IV pp 2–19: addition of many numbers (July–Aug 1838) and "Compound Addition" (June 1839)

Previews, with the two date headings of 1839 checked at full resolution
(crops `v4_bab_s4_0007_950_0_900_220_s1.jpg`,
`v4_bab_s4_0010_1700_0_800_220_s1.jpg`).

**The order of writing.** p 2 is the title ("Sketch Book Vol 4"); pp 3–6
are blank; the book starts on p 7, "26 July 1838". pp 7–11 are July–August
1838. Then, on the lower half of p 11 and on pp 12–19, entries dated **25
and 26 June 1839** ("25 June 1839" p 11 and p 12; "26 June 1839" p 18;
"25 June" p 14, "26 June" p 15). Both 1839 dates are clear at full
resolution. So pp 11 (lower)–19 were filled in June 1839, in pages left
blank after the July 1838 entries; p 66 (9 Feb 1839, `codesign-L023.md`
§1.7) was written before them.

### p 7, image 4 (`225/511`), "Add / 26 July 1838"

> Put P add.g on A through JLI to F
> F stands at positive zero
> Note: both sets of the figs on F run in the same direction the zero of
> the 7 8 9 0 1 2 3 4 positive / 8 9 0 1 2 3 4 5 negative
> Case 1 +P Reduce F to zero pos.ly what number is given off then P will
> be given off
> 2 +P Reduce F to zero neg.ly P+11111… without any carr. Each digit of P
> is increased by unity
> Put P subt.g on A through GSLI to F  F stands at pos. zero
> case 3 −P Reduce F to zero pos.ly then Numerical comp of P is given off
> if P = 0004208 N.C of P = 0006802
> 4 −P Red F to zero neg.ly of P = 0004208 No given off = 1117913
> Let F stand at neg. zero
> Case 1 +P Red F to neg. zero No. given off = P
> 2 +P Red F to pos. zero P−111 No giv. off = P unity subt. from each
> digit & but without Carr.
> 3 −P Red F to neg. zero No. giv. off = Arith Comp of P
> 4 −P Red F to pos. zero No. given off = Arith Comp of P − unity
> subtracted from each of its figures but without carr.

### pp 8–9, image 5 (`225/512`)

p 8, "26 July": "Add.n of P and Q may be made by 1 by bringing in P with
its joint sign ±(±P), P ± (±Q), P+Q"; with C.P [complement of P]:
"C.P + (+Q) = C.P + Q = Q − P", "C.P + (−Q) = C.P + C.Q = C(P+Q)",
"P = 037, Q = 028, C 963, C 972, 065, C 935 = 065", "C.P − Q = 963 − 28 =
C 935 = 065 = C.P + C.Q", "C.P + Q = 963 + 28 = 991 = 9 = P − Q".

p 9: "C(P+Q)", "−′P ± (±R)", "′P = P+Q = 37+28 = 65", "C.′P = 935 let R =
19", "∴ C′P + R = 935 + 19 = 954 = C 046", "C′P + R = −′P + R", "C.′P − R
= −′P − R = −(′P + R)". Then, after a rule, "2 Aug", "27" [the day-number
of the history sheet's entry]:

> 0 − P
> 0 − P − Q
> Add.n of n quantities from St. to St. = n+4
> Add.n n quantities from St. to St. giving off & retaining after each
> add.n there being p of that class of giving off 2(n−1)+4 = 2n−2+4 = 2n+2
> = 2(n+1)
> Add.n of n quantities from St. to St. giving off & retaining q times but
> never giving off twice in succession  n+4+q  n = 3 q = 1
> P Q R S T U
> P
> P + Q
> P + Q + R
> P + Q + R + S    P + Q + R + S
> P + … T          P + … T
> P + … U

### pp 10–11, image 6 (`225/513`)

p 10, "27 July":

> 1st P & Q ⟨added⟩ upon the same axis
> 2nd P+Q, P−Q, Q−P on three fig whs and the right one selected by the
> signs
> 3 P+Q, P−Q made and P+Q or P−Q or the Comp. of P−Q selected by signs
> Alg. & Acc.l signs act separately
> alg. & Acc.l signs act jointly } do
> For giving off and retaining — put sum on A and in giving off retain it
> on A and reciprocally In this we must change carr from pos to neg

"+(+a) + (−b) b < a"; "a + a₁ + a₂ / b + b₁ + b₂"; sign cases
"+a+b; +a−b a>b; +a−b a<b R.; −a+b a>b; −a+b a<b R.; −a−b".

p 11: "P / P+Q / P+Q+R / P+…S / 12 P+…T / 15 P+…U / 16 P+…V / 17 P+…W /
18 P+…X"; "Let n = No of Quantities Added, p = No of Retainings in
Succession", "2(n+1)", "p = 2, p = 3", "2(p+3) + (n−p−3) + 3 = … = p+n+6".
Then, later:

> 25 June 1839
> Add.n of numbers of more than 40 figures k being 40
> Bring into Mill the two heads with their alg. & acc. signs treat them as
> in ord. add.n & put them into Store

with sign cases "+a+b / +a−b b>a Run [?] if R.g up / −a+b b>a Run on Neg.
+ Run on Pos / −a−b Run on Neg.", and "if Running up a+b => 40 fig Give
Comp. / Give off Number / Give off Compl."

### pp 12–13, image 7 (`225/514`), "25 June 1839"

p 12:

> Warning from 40th wh. is conveyed down to the units whs. But the
> consequent carr. is postponed to the next turn
> A Card can cut off the comm.n between the Runn.g up of F & the Sect. of
> ″A which it governs
> For Long Add.n
> Every tail has the same acc.l sign as its head
> 1st The heads are brought into Mill and treated as in Com. Add.n
> In the case of a−b if F run up it throws into gear a cam x which acts on
> ″A (which causes to make Comp. of all the tails) in the same manner as
> the first Running up caused the heads to be made Comp. This cam is not
> acted upon by cards except that the last card puts it out of gear. If
> this cam is independent of the communication between F & ″A, the cards
> need not be affected by the running up of F but if not, the running up
> or non running up must turn a card over before it acts.
> If a−b does not cause running up of F, the cam x is not put in, & the
> chain between F and sector of barrel of ″A is broken by order of card in
> the Add.n or Subt.n of the tails so that their running up may not order
> complement of them to be made upon ″A

p 13:

> In the case of a+b nothing need be done but the comm.n between F &
> sector of Bar. of ″A broken by card after the add.n of heads in the
> usual way
> −a+b the Subt.n of a causes a run.g up on F, which orders in x & if
> a = or > b every goes on as in the case of a−b when b > a but if a < b a
> second running up occurs on ′F which must put x out & the same orders
> are afterwards given as in the case a+b

### pp 14–15, image 8 (`225/515`)

p 14, "25 June": head-and-tail working: "a − b < 0", "±(a + ′a + ²a) /
±(b + ′b + ²b)", "A + ′A + ²A On F / On ″F"; cases "1 a−b … −(b−a) / 2
²a − ²b gives −(1 or 0) / 3 ′a − ′b − (1 or 0) gives −′(1 or 0) / 4 a − b
− ′(1 or 0)"; "−a−b / 1 Com a = C b … −(a+b) / 2 Com ²a + Com ²b gives
(1 or 0)"; "a − b > 0".

p 15, "26 June. The Reserve Carr. or": "1 +a+b / 2 +a−b a>b, a< / 3 −a−b /
4 −a+b a>b, a<b"; "F ′F ″F"; "In all cases Card puts in reserve of F ′F";
"When −a enters F is thrown out / When −b … ′F is thrown in"; "When a<b
this running-up must put out both F & ′F"; worked complements
("+023 123 / −023 801 / 000678", "−043 123 / +043 201 / 000078", "R 999",
"999322 / 000678").

### pp 16–17, image 9 (`225/516`)

p 16 (no date): "10⁸⁰A + 10⁴⁰′A + ″A", "10⁸⁰B + 10⁴⁰′B + ″B",
"±(10⁴⁰A + ′A)"; "C ±±A ±±B"; "−a = −014,231,763 / +b2 +021,306,925";
worked complements "227 / −1 925 / 152 / +1", "231 / 768 / −1 306 / 074 /
+1 075", "014 / 986 / −1 985 / −1 021 / 006 / +1 007", "007075152".

p 17: "±″A + 0 / ±″B − / A ′A / B ′B", "±″A + (?)", "F ′F ″F" with columns
of 1s; "1 Count.g App. / 2 C. App."; columns "999 R / 000 R / 999 R …".
Then:

> Three principles for Compound Add.n & the Add.n of numbers larger than
> 40 places of figures
> 1 — to carry from 40th to 1st cage — & to reserve this actual carr.
> until succeeding part of Number enters.
> 2 to send the reserved carr.s into the store & treat them as numbers to
> be added to the next tail above
> 3 to make units (whenever a carr. occurs by R.g up) in the store

### pp 18–19, image 10 (`225/517`), "Case +a−b b >=< a 26 June 1839"

p 18:

> The heads either run up or do not run up
> 1st If they run up ~~a~~ F then the resultant head must be made
> Complement and so must all the tails
> 2. If they do not run up then the resultant head must not be made
> Complements nor must any of the tails
> 3. Complement is made by an order on barrel A″ to shift its vertical
> this arises from a Running up and can only occur by a Running up
> 4. But if the Running up of Heads puts in a cam X which orders the
> barrel to shift its vertical then whether there be or be not any
> subsequent Running up by tails Complement will continue to be made of
> them

p 19:

> 5. Supposing Complement is not ordered by Running up of Heads yet if
> any tail run up it would order Complement by itself. This is to be
> prevented by breaking the connexion between Running up and the sector
> of ″A after the Addition of Heads
> Case −a+b
> 1st When −a is put on F there will be a Running up which will order in
> X and thus direct Complement to be taken
> 2. This order must remain if b is =< a and in those circumstances there
> will be no running up on ′F
> 3 But if b > a then ′F will run up and in fact the number itself b−a and
> not its Complement is to be used
> 4 This will occur if the Running up of ′F puts out X
> case a+b over

"Compound Addition" on p 17 is therefore the addition of numbers in parts
(head and tails, each of 40 places), with the carriage between parts
reserved and sent to the store. It is not the addition of more than two
numbers at once.

---

## 5. Vol IV pp 270–271, 7 December 1839: "Selecting App. for number and Comp."

Image 132 (`225/639`) — not 136 as the offset predicts; image 136 is pp
278/279 ("13 Dec. 1839 To reverse carr. from + to − in consequence of a
running up after carr. has been effected …", the history sheet's "Mode of
reversing the sign of Carr. p 278"). Full resolution (crops
2560,60,2200,2400 and 150,0,2300,820). The ink on p 271 is written over
an earlier pencil draft of the same text, visible between the lines; the
ink is transcribed.

p 270, head "7 ~~Sep~~ Dec.":

> NC 10r − N r = NC 9r      13 / NC 97
> NC 10r − NC 2r = NC 8r
> r 2r 3r 4r 5r   NC 10r   NC 10r     NC 10 970 / 97 / 983 [?]
> NC 10r
> N C(10r) + NC r = NC 9r [? overwritten]     117 / 993

Below: multiples of 13 ("13 26 39 52 65"), "130 / 9987 / 117", "130 / 13
/ 127", "130 / 97 / 127", "130 / 127 / 117 = 9 × 13", "104 = 8 × 13",
"181 = 10 + 7 × 13 [?(−10)]", "6 × 13 = 78", "99970", "NC 10r − N r =",
"0 1 2 3 4 5" with diamond-shaped cams. [NC = numerical complement; the
page works out how the multiples r, 2r, … 9r of a number are got by
adding complements, i.e. table making by subtraction from 10r, cf. the
history sheet's "Table made in 5 turns by Subt. from 10ⁿ p 269 Vol IV".]

p 271, head "7 Dec.", "23 87", "20 / ~~12~~ 30", "Selectors":

> If Unity of Number Subt.d > 3 it throws in L & then if there are no
> tens the chain is complete If Units fig < 3 and if there are no tens
> there can be no running up either by lifting tens or units [?lifts]
> But if there are tens the tens whs must be so prepared that the passage
> of the 3 = (2+1) tens shall lift
> Selector to lift when set to b a [?]
> The Units Wh. A has moveable cams set to that point of motion which
> leaves the wheel between 0 & a shall produce no effect on K but if it
> has a greater number than a subtracted from it (supposing it left at a)
> or any number less than Comp. of a added to it then acting by its cams
> through K it throws in the wire B a[?nd thereby] renders it possible for
> the tens warning to act
> Wires in the tens wh. are fixed at the zero point & at all figures
> beyond & the wheel is set to the number b
> Between b & b+1 a cam has been set which when it passes acts through K
> on B & renders the running up of the tens effective & therefore any
> number < a is taken from the units it will not warn B

[Sketches at left: wheels "tens", "Units", wires "L", "B", "E", arms "K",
"A". This is a selector that detects whether a number exceeds a set value
(by subtraction of the number, or addition of the complement of a), for
choosing the multiple in division; "Comp." here is the complement of the
set number a. It is not the apparatus for taking complements as such.]

---

## 6. Vol III, August 1837 (for complements), previews only

- p 60, "2 Aug 1837" (image 38, `225/250`): mechanism sketches; p 61
  "Velocity of the Machine". Nothing on complements.
- p 64–65 (image 40): elimination for three equations; p 65 "19 Aug.
  1837": "It was found that by mistake the sketches were made at page 80
  after some days. On 19 Aug we returned to this page —".
- p 68 "2[?] Aug 1837" and p 69 (image 42): sketches; "Time of Mult.n
  (12 + 2q + r) turns", "r = q−1 ∾ d", "if q−1 > d", "q−1 < d".
- p 72 "25 Aug.t 1837", p 73 (image 44, `225/256`): p 73 "To count
  difference between the Number of digits in p and Q 0000 In Old method of
  counting 1st Bring fig wh. of Carr. to −0 in which case there will be a
  chain of long and short wires from bottom to top — 2 P is transferred to
  carr. fig wh. in such a manner that wherever there is a digit notice of
  carriage is given to the tens warning arm …".
- p 76 (image 46, `225/258`): "Counting App." … "p−1 is first put upon it
  & then q subtracted from it & if q > p−1 the loose wheel b is gathered up
  until the axis comes to 0".
- p 77 (image 46), dated at mid-page "2[?9] Aug": columns of numbers marked
  "Nc" and "ac" (or "a.c."): "0028 / 0082 Nc / 9972 ac"; "00123 / 00987 Nc
  / 99877 ac"; "00002400197 / 00008600913 Nc / 11001110 Nc+N / 99997599803
  ac / … / 11113511207 Nc of ac". ["ac" is presumably arithmetical
  complement: 9972 = 10⁴ − 28, 99877 = 10⁵ − 123; "Nc" not understood.]
- p 80 (image 48, `225/260`), "Principles of Engine" (between 2 and 17
  Aug 1837; p 81 is "17 Aug. 1837"):

  > One mode of running up without long cycle is to take Comp. as if
  > Q = 0002346 Put Comp Q = 9997654 Step this on C from Carr. to Carr.
  > After each stepping raise the Wire below the units cage the highest
  > wire cannot be raised unless a chain be formed through all the wires
  > which can only happen when by stepping Comp of Q down we have got
  > nothing but 9s remaining

---

## Control-flow primitives Babbage specifies

Only what the pages say; the words are his. Dates are the page headings
(year from the volume where the page gives none).

1. **A stop on a counting wheel ends a repetition.** Vol II p 79 and p 81,
   1 March 1836: "There is a stop or cam at the end of this which in
   concurrence with the stop at the end of the Table making app.s throws
   into gear division cycles"; "The counting wh. by its stop then throws
   out barrel"; "when stop of q−d counting wh. throws all out and mult.n is
   ended". p 76: "the count.g wh. q−d determines the number of steppings
   up. This throws out Mult.n".
2. **Repetition of barrel verticals.** Vol II p 81, 1 March 1836: the
   barrel's advances 9A, 10, 11, 12B4 recur ("These repetitions continue
   29 advances of barrel after which steps up q−d times").
3. **Backing of the barrel.** Vol II p 81, 1 March 1836: "On the zero
   column of barrel there are directions to step up and a backing pin. The
   barrel then backs to −1 and steps up again but −1 having an advancing
   pin barrel goes to 0 and so on — These alternations are continued q−d
   times". Below: "Plan for backing cycles in barrels by an axis reducing
   to zeros".
4. **A count of repetitions on an axis, unity subtracted each time, a
   running up at the end.** Vol II p 84, 7 March 1836: "When any operation
   is to be terminated after a given variable number of repetitions, let
   the number of rep.ns be put on an axis having a carriage connected with
   it. Then … subtr.g unity previous [to] each operation a running up will
   take place at end and thus the op.n be suspended".
5. **Choosing by a running up (comparison).** Vol II p 92, March 1836
   (between 12 and 16 March): "−p to No 3. on E and −q to No 1 on A / A or E
   runs up and directs which is to be Multiplier."
6. **Choosing between alternative cycles on the sign of a difference.**
   Vol II p 94, 22 March 1836: cycles "Pos. Cyc q−p > 0" (B) and "Neg. Cyc
   q−p < 0" (A) on a "running up axis": "If in 5 q−p runs up A will be
   moved and cycle Neg. be put in gear. If it do not run up then A must be
   thrown out of gear and B into gear. The 1st vert.l of Cycle Neg. puts
   out A and puts in C which C on the next running up puts out the cycle
   Neg"; p 95: "The term.n of Pos. or of Neg. Cyc acts jointly with the
   term.n of table making to put in the real division cycle". p 94 also:
   "Carriage is in some cases to be prevented when running up occurs and
   the lowest wheel put back to 0".
7. **Several sets of cards, one before the other; a set that passes once,
   twice, three, four times and backs; a set acting at chosen passages of
   another's groups.** Vol II pp 178–179, 30–31 July 1836: "In backing cards
   for Dev.n of series the first card or rather the plate with holes which
   pushes the card must have a lever behind it which at each backing
   advances laterally one hole …"; "Two sets of cards one before the other
   with different times of movement would do the same thing"; "The first
   set passes once and backs — It then passes twice / thrice times / four";
   "The 3rd set of cards acts at the 2nd 3rd &c. passages of the groups of
   the 1st"; "It does not recede".
8. **Conditional arms governed by studs on a barrel.** Vol II p 179, 31
   July 1836: "Or conditional arms may be interposed between the wires and
   their work and these may be governed by studs on a revolving barrel".
9. **Choosing which counting apparatus to use on a running up; branching
   to one of three orders.** Vol III p 143 (Nov 1837): "If it runs up
   reduce it to + zero and use the other one No 2. but if not, subtract …
   from the counting app. No 2 and then use it for q". p 147 (Nov 1837):
   "Lift wires of counting app.s No 1. If it runs up order Stepping down.
   If it does not run up subtract 1 from it and lift the wires again if it
   now runs up order no stepping but if it does not run up order Stepping
   up"; "If neither … have run up … there are no figures in the quotient;
   but if running up has occurred in either turn proceed with the
   operation". p 148: "If it runs up use No 2 … But if it does not run up
   add to its units wheel until it does run up". p 150 (24 Nov 1837): a
   wheel "at the proper time shifts the barrels (by the running up acting
   on their sectors) to the verticals for adding n". p 155 (Dec 1837):
   "if the carriage appointed to ascertain whether it has any figures does
   not run up — bring in its tail on the head axis and treat it as head —
   if it does run up, bring in the tail on the tail axis"; "The orders
   given by running up must be conveyed through the running-up lever to the
   levers governing the requisite reducing sectors."
10. **Groups of operation cards; backing by a stated number of cards.**
    Vol III p 158, 11 Dec 1837: groups "(x+, xx) (x+, x+, xx) (x+, x+, x+,
    xx)", "1234 | 12, 12, 34 | 12, 12, 12, 34", "Back 4 add 2 / Back 2 …";
    the ruled insert of 11 Dec 1837 with columns "Operation Backing", "Δ′₁",
    "Comb.l fig. Wh.", "Comb.t Backing" (see §3).
11. **Combinatorial wheels, unity subtracted, a tooth that backs the
    operation cards; numbers transferred from combinatorial cards to the
    wheels; two groups (repeated and constant); a conditional backing card
    and an unconditional one.** Vol III pp 161–162 (Dec 1837): see
    `codesign-L023.md` §1.2. p 159 (Dec 1837) has a bracket "effective /
    ineffective".
12. **The order of card sets; operation cards order the combinatorial
    cards to turn.** Vol III pp 163–164 (Dec 1837): "Combinatorial Cards
    (one set) turn first"; "Operation Cards (one set) order barrels …";
    "Variable Cards (two sets)"; "Number Cards (2 sets)"; "When the
    operation Cards have completed the orders they have received they order
    the combinatorial Cards to turn, which give off to the combinatorial
    wheels the number of repetitions of operations to be made to obtain the
    next term of the series". p 165, 13 Dec 1837: combinatorial cards kept
    separate from number cards, "as there are but three combinatorial
    wheels".
13. **An operation that continues while variable cards supply numbers;
    the last variable card brings in the next operation.** Vol III reverse
    p 60, 13 Jan 1838, with a note of 13 March 1838 (see §3, internal
    references): "If operation cards call in Add.n or Sub.n any number of
    times, they have been ordered to be turned by the successive verticals
    of the barrels; but when the last of these cards gives its order, the
    next vertical orders the operation cards not to turn any more"; "Note —
    The above has all been altered. The Oper.n cards order a certain oper.n
    — say Add.n which goes on as long as variables are supplied; the last
    variable card calls into action the operation card which orders Sub.n
    or Give off &c".
14. **Six groups of formula cards, with backing orders that a running up
    destroys, and three wanting-tooth wheels to back any number of cards.**
    Vol III reverse pp 75–74, "30 May" [1838]: "Last card is combin.l and
    orders backing but if running up in Combin.l Axis occur this order is
    destroyed"; "Last card orders backing to end of prep.n Cards"; "There
    are to be 3 wanting tooth wheels each of which can be set to back any
    No of cards / The Combin.l Card on 3 governs the 1st wheel / Do 5 — 2 /
    Do 6 — 3". [Nesting: the groups 3, 5 and 6 each have their own backing
    wheel, inside the "backing to end of prep.n Cards" of the whole.]
15. **Backing by a counting apparatus set to a number computed or taken
    from the Store.** Vol IV p 66, 9 Feb 1839: see `codesign-L023.md` §1.7.
16. **A card cuts the connexion between a running up and the barrel it
    governs; a running up puts in a cam that keeps ordering complements.**
    Vol IV pp 12–13, 18–19, 25–26 June 1839: "A Card can cut off the
    comm.n between the Runn.g up of F & the Sect. of ″A which it governs";
    "Complement is made by an order on barrel A″ to shift its vertical
    this arises from a Running up and can only occur by a Running up"; "if
    not, the running up or non running up must turn a card over before it
    acts".

Not found in the pages read: any explicit test for zero as distinct from
running up (p 155's "If both head and tail are 0 notice of that fact must
be given by the carriage which receives tail not running up" is the
nearest); any choice between alternative groups of **cards** on a
condition (the choices on pp 94, 143, 147 are between barrel cycles,
counting apparatus or orders in the mill; p 165 and reverse p 75 have
cards that order or suppress backing, not a jump to another group).

## Compound addition

Question: is adding more than two numbers at once (as L/011 does on 28 Aug
1837) described before July 1838?

- **What "Compound Addn" on Vol IV p 17 means.** "Three principles for
  Compound Add.n & the Add.n of numbers larger than 40 places of figures":
  carriage from the 40th cage reserved, sent to the store, and added to the
  next tail. It is addition of numbers in parts (head and tails), not of
  more than two numbers at once. And p 17 is among pages dated **25–26
  June 1839** (pp 11–19), not July 1838. The history sheet's "Principles of
  Compound Addn Vol 4 p 17" in July 1838 (N/005) does not match the page's
  date; the July 1838 pages of Vol IV are pp 7–11.
- **Many numbers added, Vol IV pp 8–11, 26 July – 2 Aug 1838**: "Add.n of
  n quantities from St. to St. = n+4" [turns]; with giving off and
  retaining "2(n+1)"; "P / P+Q / P+Q+R / P+Q+R+S / P+…T / P+…U"; p 11 "Let
  n = No of Quantities Added". This matches the history sheet's July 1838
  "Put all numbers to be added on A connected with a Pos. & Neg. Carr. 27".
  It is a running sum: each number added in turn to the sum on one axis.
- **Earlier, in Vol III:** p 141, 24 Nov 1837 ("Add.n & Subt.n with
  signs"): "A enters / A transfers B enters / A+B added C enters / A+B goes
  out & is retained / C added / A+B+C goes out & is retained / D added" —
  a running sum with giving off and retaining. Reverse p 60, 13 Jan 1838,
  note of 13 March 1838: "The Oper.n cards order a certain oper.n — say
  Add.n which goes on as long as variables are supplied; the last variable
  card calls into action the operation card which orders Sub.n …" — one
  addition order for any number of variables.
- **Before 28 Aug 1837: not found in the pages read.** In Vol II (pp
  74–95, 170–189) and Vol III pp 60–85 (Aug 1837, previews) there is no
  addition of more than two numbers under one order. (Vol II p 92, March
  1836, "Suppose two Mul.ns going on at same time", is two
  multiplications, not many addends.)
- **Answer:** in the pages read, the addition of more than two numbers is
  first described on 24 Nov 1837 (Vol III p 141, as a running sum) and, as
  one operation for any number of variables, on 13 Jan / 13 March 1838
  (Vol III reverse p 60) — both before July 1838, both after L/011 (28 Aug
  1837). Nothing earlier than L/011 was found. "Compound Addn" (Vol IV
  p 17) is a different thing and dates from June 1839.

## Complements

Question: were complements as used by L/001 No. 2 (5 Aug 1837) described
before December 1839?

Yes, from March 1836, in both mill and store:

- **Vol II pp 88, 90, 92, March 1836 (mill, counting apparatus).** p 88,
  11 March 1836: "−p = 9981 … +q = 21 … 0002 R"; "+p = 0019 −q = 0021 p−q
  = 9998 R"; p 90: "0019 / 9981 / 19 / 0000"; p 92: "−p to No 3. on E and
  −q to No 1 on A / A or E runs up and directs which is to be Multiplier",
  "99999 / 99985 / 00014". Negative numbers held as ten's complements, with
  a running up ("R") marking the sign.
- **Vol II p 172, 25 July 1836 (store to store):** "if a number is given
  off from a store to a store the compliment of each digit is received. (4)
  If the compliment of each figure is given off from a store to a store the
  number received is the original number."
- **Vol II pp 178–181, 30 July – 7 Aug 1836:** "+P = 00034 / −Q = 99996",
  "−P = 99966", "P = 000123 … −P = 999877", "Rec + on No 1 / Rec — on No
  1 / Give Off & Retain on No 1 …".
- **Vol II pp 188–189, 11 Aug 1836, "Of the Notation of Formulae":** "A
  variable in Store cannot be transferred to other fig. wheels of Store.
  But its numerical compliment (that is the compl. of each digit to 10) can
  be transferred"; "the numerical compl. of a numerical compliment is the
  variable itself"; "Thus 007621 = Variable / 003489 = Numerical Compl";
  "when numbers are received from Store into Mill their numerical
  compliments may be retained on any axes of the Store"; "Numbers are
  always placed in the store with positive signs. But when they become
  changed by any operations in the Mill the signs so acquired are conveyed
  with them into the Store". [These are digit-wise complements to 10
  (7621 ↔ 3489), unlike the ten's complements of March 1836 (−19 = 9981).]
- **Vol III, August 1837 (the month of L/001):** p 73, 25 Aug 1837, "Bring
  fig wh. of Carr. to −0"; p 77, late Aug 1837, numbers marked "ac"
  ("0028 … 9972 ac", "00123 … 99877 ac"), presumably arithmetical
  complement; p 80 (between 2 and 17 Aug 1837), "One mode of running up
  without long cycle is to take Comp. as if Q = 0002346 Put Comp Q =
  9997654". None of these is dated before 5 Aug 1837 on the page; p 80 is
  bracketed only by p 60 (2 Aug) and p 81 (17 Aug).
- **Vol III pp 144–145, 13 Nov 1837:** "d upon the axis which has
  complement in Division and when it is given off it is transferred from one
  wheel to the other on that axis"; "−4 expressed by 996", "−7 expd by
  993".
- **Vol IV p 7, 26 July 1838:** "Numerical comp of P is given off if P =
  0004208 N.C of P = 0006802"; "No. giv. off = Arith Comp of P"; p 8:
  "C.P + (−Q) = C.P + C.Q = C(P+Q)", "P = 037 … C 963".
- **Vol IV p 271, 7 Dec 1839:** a selector working by subtraction of a
  number or "any number less than Comp. of a added to it"; p 270 "NC 10r −
  N r = NC 9r". This is complement arithmetic applied to selecting
  multiples, not the first description of complements.

**Answer:** complements were described before December 1839 many times.
In the pages read, ten's complements for negative numbers in the mill go
back to 11 March 1836 (Vol II p 88), and the giving off of complements
from store to store, the "numerical compliment", to 25 July and 11 Aug
1836 (Vol II pp 172, 188). So complements were in Babbage's record about
17 months before L/001 No. 2 (5 Aug 1837). Whether L/001's particular use
(its "C" sign on the back) matches the store-to-store complement of 1836
or the ten's complement of March 1836 has not been checked against
`L001.md` here.
