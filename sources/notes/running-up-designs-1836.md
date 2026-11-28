# Running up and what it changes, February–March 1836: the designs one by one (Vol II pp 67–95, Vol XIII history; earlier statements)

Read by a coding agent from the Science Museum Group images (CC BY-NC-SA
4.0, The Babbage Papers at the Science Museum, London), 28 November 2026.
**No person has checked these readings.**

The question: in February–March 1836, how does an arithmetic event — a
"running up", a count coming to its stop, a result passing through zero —
change what the mill does next? This note does **not** combine the pages
into one design. Each dated page (or run of pages that is one design) is
reconstructed separately: what it says, what it draws, what it does and
does not show. The summary table at the end has one row per design.

**Method.** Tiles only through the local cache (`scripts/smg_cache.py`,
`crop(path, x, y, w, h)`); crops stitched at full resolution and viewed at
the scale given; crops kept in the session scratchpad, not in the repo.
Regions are x, y, w, h in full-resolution pixels of the stored image. Vol
II = BAB/S/1/02, zoom
`<a>/<b>/Scribbling_Book_Volume_II__1835_November_1837_February.ptif`;
image n = `322/(956+n)` up to image 43, then `323/(n−44)`. Vol XIII =
BAB/S/1/13, `229/<b>/Babbage_Papers_S19__Scribbling_Book_Volume_XIII.ptif`,
history pages stored inverted (rotated 180° for reading).

Conventions as in `counting-running-up-1836.md`: (a) on the page,
verbatim, with regions; (b) what it means; (c) hypotheses, labelled.
`[?x]` uncertain; `~~x~~` struck; `⟨x⟩` interlined; `.n` etc. raised
endings.

**Reading depth** is given for every page as **FR** (full resolution, this
session), **FR-earlier** (full resolution in an earlier note, cited, not
re-read here) or **preview** (the 1536 px preview only).

| Page(s) | Image | Depth in this note |
|---|---|---|
| Vol II pp 16–25, 38–43, 52–65 | 9–13, 20–22, 27–30, 33–35 | overview from full-resolution tiles (0.3); quoted passages FR (§1) |
| pp 1–15, 26–37, 44–51, 66 | 1–8, 14–19, 23–26, 31–32, 36 | not looked at here (`bolting-plates-sources.md` §3, preview) |
| p 67 | 36 | FR-earlier |
| p 68 | 37 | FR (drawing and text) |
| pp 70–71 | 38 | overview from full-resolution tiles; labels FR |
| Vol II p 74 (drawing) | 40 | FR (labels and drawing) |
| p 75 | 40 | FR-earlier (`counting-running-up-1836.md`) |
| pp 72–73 | 39 | p 73 drawing FR; p 72 sketches preview |
| p 76 | 41 | FR (whole page) |
| p 77 | 41 | preview (algebra only) |
| p 78 | 42 | FR (whole text) |
| p 79 | 42 | upper half FR-earlier; lower half ("Ex.n of Root") FR |
| p 80 | 43 | FR (the four written lines); rest blank but show-through |
| p 81 | 43 | FR (whole page, table, text, drawing, caption) |
| p 82 | 44 | FR (whole page) |
| p 83 | 44 | preview |
| p 84 | 45 | FR (paragraph, interlineations, drawings) |
| p 85 | 45 | preview |
| pp 86–87 | 46 | preview |
| pp 88–89 | 47 | FR-earlier (`counting-running-up-1836.md`) |
| p 90 | 48 | FR-earlier |
| p 91 | 48 | FR-earlier; foot table re-read FR |
| p 92 | 49 | FR (whole page) |
| p 93 | 49 | FR (whole page; show-through identified) |
| p 94 | 50 | FR (whole page, drawing part by part) |
| p 95 | 50 | FR (whole page) |
| Vol XIII image 87 (history, Nov 1835 – 9 March 1836; 24 March) | `229/48` | FR (from cached tiles) |
| Vol XIII image 86 (10 March) | `229/47` | FR (from cached tiles) |

---

## Summary

- **Nothing in the pages read defines "running up" in words.** What the
  pages do with it is consistent: a wheel or axis that holds a number,
  with a carriage connected to it, passes through zero, and that passage
  moves something. On p 84 (7 March) the something is not named ("the
  op.n be suspended"). On p 92 (12–16 March) it is named only as an effect
  ("directs which is to be Multiplier"). **Only p 94 (22 March) draws a
  mechanism**: a "running up axis" with three arms over three barrels B,
  A, C, and says which barrel is moved.
- **Earlier than February 1836**, the only "running up" found in Vol II
  is a time count on p 24 (5 Dec 1835): compound division takes "11 of
  Cycle of (16) + (n + No of runnings up) of cycles of (28)". It says that
  runnings up occur in division and cost cycles, not what they move.
  F/015–016 (8 Jan 1836) and N/001 (Nov 1834) are cited from earlier
  notes. Nothing found before 7 March 1836 says that a result passing
  through zero moves a lever, barrel, lock or lifter.
- **Before 7 March, the events that change the mill's course are stops on
  counting wheels, not running up.** pp 76, 78–81 (1 March): "the stop of
  the count.g wh. q throws an arm in", "a stop or cam at the end of this
  which in concurrence with the stop at the end of the Table mak.g app.s
  throws into gear division cycles", "The counting wh. by its stop then
  throws out barrel and into gear with a zero app.s". The direction (which
  of two numbers is greater) is taken from a **directing cam** moved by
  superposition of the two counts (p 75, p 78), or from a **lever L**
  "up or down" (p 68, earlier note).
- **From 7 March, running up replaces the stop as the signal**: p 84
  (repetitions ended by running up), p 88's "R" marks (11 March), p 91's
  table (12 March: "Carr Sub.n runs up", "−d Carr Sub.n runs up"), p 92
  ("A or E runs up and directs which is to be Multiplier"; "both 1 & 2
  will want carriage"), p 94 (running up axis; positive and negative
  cycles).
- **What is acted on**, page by page: a barrel (p 75 "directing arm governs
  the barrel of multiplier axis"; p 81 "throws out barrel"; p 94 barrels
  A, B, C "put in gear"/"thrown out of gear"); gathering-up teeth (pp 76,
  78, 79, 80); levers (p 78 "the directing cam having set levers to step up
  or down"; p 68 "lever L"); an arm (p 76). **No page in Feb–March 1836
  names a lock, a carriage lifter or a card as the thing a running up
  acts on.** p 84 names none.
- **The number of figures of the multiplier.** The pages count the digits
  of both numbers mechanically (p 75 spiral axis and notched wheels; p 91
  rack with 30 feelers), put the counts on counting wheels with stops (p
  75, p 82) or on wheels with carriage (pp 91–92), and use them to **limit
  the steppings** of a multiplication by table (pp 68, 76, 81, 91, 92).
  That is the only use stated. The count that limits stepping is p−d or
  q−d (d = decimals), or the multiplier's count less 1 and less d+1 (p 92),
  not p itself.
- **Correction to an earlier note.** The "pencil sketches of two cycles
  labelled Neg. Cyc. q−p< and Pos. Cyc. q−p>" reported on p 93 in
  `sketchbooks-control.md` §1 are **show-through of p 94** (the next page,
  on the back of the same leaf): mirrored, they read "Pos. Cyc / q−p > 0",
  "Neg. Cyc / q−p <", "1 = New cycle step", "At No 4 throw A into gear", "If
  in 5 q−p runs up A will be moved and cycle" in p 94's positions. p 93 has
  no drawing of the cycles of its own. Also p 82's counting wheels "0 /
  p−d", "0 / q−d" (`counting-running-up-1836.md`) read **"−d / p−d", "−d /
  q−d"** at full resolution.

---

## 1. Before February 1836

**What was looked at.** Vol II images 9–13, 20–22, 27–30, 33–35 (pp
16–25, 38–43, 52–59, 60–65; 1 Dec 1835 – 16 Feb 1836) were fetched whole
through the cache and looked at as overviews (the full-resolution tiles
reduced to 0.3), with the passages quoted below read at full resolution.
Images 1–8, 14–19, 23–26, 31–32 and 36 (fly-leaves to p 15, pp 26–37,
44–51, the loose inserts, pp 66–67) were **not** looked at in this session;
for them this note relies on `bolting-plates-sources.md` §3, which read
every page to p 71 at preview for other words and lists nothing on zero
or running up. Vol XIII image 87 (history, 6 Nov 1835 – 9 March 1836) was
read at full resolution from cached tiles.

### 1.1 Vol II p 24, 5 Dec 1835: "No of runnings up" in a time count for division

**Depth:** FR (`13` 180,1620,2250,1300 at 0.55; 200,2350,2150,400 at 0.9;
180,60,2250,700 at 0.55).

(a) Upper half (the cycle for compound multiplication, as in
`bolting-plates-sources.md` §3.5): "Cycle for compound Multiplication /
having made table / Step up multiplier which reduces its first figure to
zero and sets lifters } 9 / Lift lifters } 1 / …". Lower half:

> S = sum of digits   n = number of digits
> Simple Mult.n  S + 1 + ⟨n−1⟩ of turns whose Cycle is 16
>        S + n = time for simple multiplication
> For simple ~~subtraction~~ Division
>        S + 2n turns of Cycle 16
> Compound Mult.n including tabulating a × b in [?b mul.]
>        10 of Cycle (16) + n of cycles of (28)
> Compound Division including a, b
>        11 of Cycle of (16) + (n + No of runnings up) of cycles of (28)
> [Large] 90 + 31 mult. … [workings 4)2520, 4)630, 158; 1586/948]

(b) **The earliest dated "running up" found in Vol II.** It is used only
in a count of time: compound division (division with a table, "including
a, b") takes one cycle of 28 for each digit and one more for each running
up. **What the running up acts on is not said.** "Step up multiplier which
reduces its first figure to zero and sets lifters" (same page) is a
figure brought to zero by stepping, with the lifters then set; it does
not say that the zero is detected or that it controls anything.

(c) HYPOTHESIS. In division by table, a subtraction of a tabulated
multiple that is too large passes through zero (runs up) and costs an
extra cycle to undo or to step on; so the number of runnings up depends
on the figures and is added to n. Basis: the formula only.

### 1.2 Vol II p 20, Dec 1835: division by table, no running up

**Depth:** FR (`11` 200,80,2250,1100 at 0.55). "in Old plan Mult. 1835 Dec
/ Tab — 099 198 297 3[?96] 495 594 693 792 891 C 901"; a division of
"0101234[5]" by 099 by subtracting multiples; "New plan / For Division /
Stepp. Up — 9 / Vert. mot. of lifters 1 / Subtraction 9 / Carriage 3 /
Vert. to mean point 1 / 23 / but in this lifters are placed right". The
"C 901" is the complement of 099. **Nothing on what decides the multiple
or on a result passing zero.**

### 1.3 Vol II p 59 (Jan 1836, "22 Jan" on the page), p 60 (5–6 Feb), p 65 (16 Feb)

**Depth:** FR for the passages (`30` 3300,150,1550,1050 at 0.8; `33`
1400,60,1100,380 at 0.8 and 250,780,2250,1220 at 0.55; `35`
2550,400,2300,1400 at 0.55).

- p 59: a count of cycles for a root, "1 to feel 1st fig / 1 to put it and
  2 and r on Mult. and also on r … / 18 to Mult. during this make 2r … / 3
  to make 3r² / 1 to make x−r² and 3r²+x / 15 to Mult by 2r / 15 to div by
  3r²+x". **"feel" a figure; no zero test.**
- p 60, "5 Feb": "To change Carr. from Add.n to Sub.n and vice versa"
  (heading only; sketches of axes). "6 Feb": "The drums belonging to small
  barrels may be made to act without springs … AB is a ~~barrel~~ ⟨drum⟩
  consisting of Wheels any tooth of each of which can be removed the
  formula is set in this by taking out a tooth instead of inserting a stud
  as in the former drum. The Wh. C has all its teeth and being raised into
  gear with the successive parts in each of which a tooth is wanting when C
  makes a rev.n it will carry AB only up to the wanting tooth and will
  drive lock it and the barrel being geared with AB thereby its [?D] will
  be carried to its case. C makes a rev.n each turn and is then raised to
  the next case. The Barrel and Drum may be reduced to zero ~~by~~ after each
  turn by a zero app.s". A wanting tooth sets how far a barrel is carried;
  it is set by the "formula", not by a result.
- p 65, "16 Feb": after the drum entry, "For divi.n", "A 00001000 / B
  00864210 … 0000864210", "p = 4 / q = 6 / q − p = 6 − 4 = 2": **the first
  working with digit counts p, q in Vol II** found here (the dividend
  stepped by q−p places). No mechanism.

### 1.4 Vol XIII history, 6 Nov 1835 – 9 March 1836

**Depth:** FR (`229/48` 0,0,2560,1900 rotated, at 0.45). Entries from "6
Nov 1835 Obs.ns on drums" through "1 Dec 1835 Plan to step down prod. and
div.d axes and table to remain", "3 Jan 1836 Algebraic plan to approx. to
3 roots of a cubic", "29 Jan carrying by wires with clearance between
ends", "6 Feb Plan to make drums act without spring but with teeth cut
out", to "10 … Page 67 Remarks on digit counting app.s / 24 Plan of
counting digits / 1 March 1st plan of Zero Apparatus applied to barrels /
7 March Running up applied to <u>any</u> op. / 9 March feeling [torn]
without spring". **No entry before 7 March names running up, zero or a
sign.**

### 1.5 From earlier notes, not re-read

- BAB/N/001 (history sheet, 1834), Nov 1834 (`N001.md`): "The first
  indication of the possibility of using the change of a number from
  positive to (21 negative as a mode of dividing Mult.n by cont.d Ad.n had
  been planned before 27"; Principles: "Running up 21". A sign change used
  in division by continued addition, by Babbage's later account.
- BAB/F/015–016 ("Table division", 8 January 1836;
  `F015-F016-arrows.md` §2a, 2c): rows written across the sheet,
  "Subtract from N.os <u>two</u>" / "<u>Runs up</u>" (C side) / "Step up
  quotient from <u>one</u> to <u>two</u>" (B side), and "Subtract from N.os
  <u>One</u>", "<u>Runs up</u>", "Step up quotient from <u>two</u> to
  <u>one</u>". The sheet writes the running up as a step of the division
  cycle; that note does not record what the running up moves.

**Not found** in the pages looked at, Dec 1835 – mid Feb 1836: any
statement that a result passing through zero, or a carriage from the top
wheel, moves a lever, barrel, lock or lifter, or chooses what is done
next.

---

## 2. Feb 1836, p 67 and p 68: registers set to a cage; lever L decides which number has more digits

**Depth:** p 67 FR-earlier; p 68 FR (this session: `37` 400,80,1800,750
at 0.7; 250,700,2200,700 and 250,1350,2200,900 at 0.6), agreeing with
`platforms-1835-1836.md` §5.1.

**p 68, the drawing** (top of the page, above "plan to find which …";
not described in the earlier notes): a horizontal bar (the rack R,
labelled "R" under it) with an arrow "←" at its left end and "→" at its
right; two small wheels (circles with centre dots), one at each end of
the rack, each on a vertical axis; at the middle of the rack an upright
piece standing on it (heavily inked at its foot) with a horizontal arm
running to the right, labelled "L" (the lever). Above, separately: a
horizontal line interrupted by a U-shaped part whose two uprights end in
points, with a short vertical stem below its base (a fork or stop [?]). A
large empty circle at far left; two short vertical strokes ending in dots
at top left.

(a) p 67 (between 9 and 18 Feb): "The two Registers connected with table
must be set by Digit Counting App. one to ~~the~~ the p th & the other to the
p+1 th cage by means of the spirals [?axis] … Quotient register must
always be in the lowest cage ⟨and the number of figs registered in
quotient⟩ must arise ⟨from its first subtraction⟩ from stepping quotient
up, and it must be equal to ⟨one plus⟩ the No of times Dividend was
previously stepped down that is to q−p+1 times".

p 68 (about 18–20 Feb): "plan to find which ~~[?has]~~ the greatest N.o
Dig.ts / R = rack put into gear first with counting wh.l of A then with that
of B — according as p or q is greatest so will lever L be up or down and
decide / To Multiply A by B / Add over A and B to the two ⟨Dig.t⟩ Counting
App. and let them be applied successively to the above app. for finding
greatest / Tabulate B the greatest / Set register to ⟨lowest⟩ fig. of A
connect it with the lifters and reduce ⟨[?it to]⟩ ~~[?zero]~~ by stepping
down / Continue on thus to p or p+1? terms / But while table is making
Reduce C. Wh.l of A to zero and add p over to a wheel having a stop at −d
(d = no. of decimals) then … ⟨used⟩ gather up ⟨the p−d⟩ teeth of this wh.l
and … at each tooth step up product —"

(b) **Trigger:** the comparison of two digit counts by a rack geared in
turn with two counting wheels. **Acts on:** a lever L, "up or down", which
"decide[s]" (the page does not say what L moves; the next lines choose B,
the number with more digits, to be tabulated). The step count is a wheel
"having a stop at −d" whose p−d teeth are "gathered up", one stepping of
the product per tooth. **Drawn:** rack R between two wheels (the two
counting wheels, by the text), lever L standing on the rack. **Not
shown:** what L moves when it is "up or down"; how the rack is put in
gear "first with … A then with … B"; nothing passes through zero; no
running up.

(c) HYPOTHESIS. The rack is driven one way by A's counting wheel and the
other way by B's, so that its net displacement is p−q and its sign tilts
L. Basis: the arrows at both ends and the text; the page does not say it.

**pp 70–71 (22, 24 Feb)**, image 38, FR overview (`38` whole image at 0.3;
2500,1000,1400,1300 at 0.6; 1100,100,1100,300 at 0.9): p 70 "Cycle for
Multiplication" over two rows "3′ 4′ ~~2′ 1′~~ | 1 2 3 4 5 6 7 8 9" and "2′
1′ ~~3′ 4′~~ | 9 8 7 6 5 4 3 2 1", "22 Feb", sketches of axes with collars
and wheels. p 71 "24th Feb": a block labelled "Barrel" with pins; twice, a
wheel labelled "Counting Wh.l" with notches at top and bottom and pins on
its rim, embraced by a long pivoted loop or lever whose ends hook into the
notches (a counting wheel with a catch that falls in at one position
[?]); sketches of stepped racks. No sentence on either page.

---

## 3. 24 Feb – 1 March, pp 72–75: counting the digits by spiral axis and notched wheels; directing cam

**Depth:** p 74 drawing FR (this session: `40` 250,60,1800,1000 and
250,900,1800,1200 at 0.7; 1100,1100,700,400 at 1.4; 1450,1400,300,450 at
1.5); p 75 text FR-earlier; p 73 drawing FR (`39` 2600,900,2200,1200 at
0.55); p 72 preview. Date: p 72 "24 Feb" (with the year corrected to
1836) and "29 Feb" lower; p 74 "1836"; history (Vol XIII image 87) "24 Plan
of counting digits" under February.

### (a) p 74, the drawing, part by part

Upper half, five vertical axes drawn as lines with horizontal arms
(elevation), labelled (writing vertical, reading upward):

- "Driven Spiral axis": arms stepping down to the left like a spiral
  staircase (each arm lower and further left), the lowest two short.
- "Notched wh. ax. N.o 1": five equal arms (wheels seen edge-on) at the
  same heights as the spiral arms.
- Between them, written along the axis: "Gathering up axis".
- "Notched wh. ax. N.o 2": five arms.
- "Driven spiral of ax.n N.o 2" [?]: a second stepped (spiral) axis, arms
  stepping down to the right; beside it "gathering up [?spiral] [?]"
  (faint, vertical).

At the foot of these axes, a row of plates (horizontal bars) marked "α",
"b", "p" (the "p" with a short vertical below the α plate), with a red-brown
wash over the left end; "Left hand counting wheel" written beside.

Lower half, a frame (vertical axes) carrying:

- top: a bar "p−d" over "30−p" at left (two wheels on one axis), labelled
  at left "Gather.g up tooth for Stepp.g up after Mul.n"; then the "Left
  hand counting wheel" (a wide wheel, drawn as a trapezoid, on the central
  axis);
- middle: a bar with crossed boxes (☒) at each end (wheels with pins or
  bolts), and to the right the "Directing cam": a cranked arm over a bar
  with ☒ at both ends; below it two short bars labelled "q−p" and "p−q"
  (each with a ☒ and a diagonal stroke through the label: they may be
  struck or may be pointers [?]);
- lower: "q" at left; the "Right hand counting wheel" (trapezoid, inverted);
  to the right a bar "q−d" with a block (a stop) standing on it, labelled
  "stop for −d"; and at right "Gathering up tooth for Stepp.g up after
  Mul.n" (second time);
- written vertically beside the right counting wheel, in a smaller hand:
  "stop for / q−p+d+1", the last figures crossed by hatching (struck [?]);
- bottom: a large wheel with a small wheel ("Driven spiral", a star of
  teeth beside it) and a second star-wheel under it, an arrow up to the
  pair, "Driving spiral axis" below; at right a small wheel with a pointer
  (an arm with a flat end).

A long horizontal rule with a ☒ in the middle crosses the foot of the
frame.

### (a) p 75 (text, FR-earlier)

> Counting App. for Mult.n
> A is transfer[d] to one Notched axis (No 1) … & B to the other A having p
> digits and B having q digits
> Let driving spiral move back, the top arm will [?receive] if the top fig.
> is zero, the top notched wheel thus driven will drive the top arm of the
> spiral axis which will bring the second arm of the same spiral into a
> position to be acted on by the second notched wheel if it is at zero and
> so on.
> It may be necessary to make the spiral take 2 turns at 2 different
> elevations.
> The driven spiral axis is thus moved as many teeth as there are zeros on
> the top of the number which it communicates to the ⟨two⟩ counting
> wheels p ⟨and p−d⟩ and similar mechanism from other notched wheel to
> other counting wheels q ⟨and q−d.⟩ Superposition of motion thus carries
> the directing cam over no teeth if p = q but over p−q in one direc.n if
> p > q or over q−p in the other direction if p < q.
> p−d and q−d are wheels in which the stop has been set to d.
> d = No. of decimals
> If p [?=]> q directing arm governs the barrel of multiplier axis which
> orders [?A] to be [?rub] out ⟨on the multiplier axis and [?q to be]⟩ … to
> be tabulated; and the gathering up axis to ⟨be⟩ put into gear with q

p 73 (drawing, FR): sectors and a frame with gathering-up parts, labels
"Gathering" (left) and "G.r gathering up tooth / G" (right); a working

```
003421  A
−3000   B
000421
```

and below "p [?—] d". No sentence.

### (b) What it means

**Trigger:** none of the events is a running up. The count of digits is
made by counting **leading zeros**: the notched wheel of each place drives
the next arm of the spiral only "if it is at zero", so the spiral axis
moves "as many teeth as there are zeros on the top of the number". The
two counts (p, q) are combined by superposition on the **directing cam**,
which moves p−q one way or q−p the other.
**Acts on:** "directing arm governs the barrel of multiplier axis" (which
number is tabulated, which is multiplier); "the gathering up axis to be
put into gear with q". The p−d and q−d wheels carry a stop set to d.
**Drawn:** the axes, counting wheels, directing cam, stops for −d,
gathering-up teeth (p 74). **Not shown:** how the directing arm reaches
the barrel; what the stop on p−d / q−d acts on (the drawing has "stop for
−d" but no arm from it); no running up.

(c) HYPOTHESIS. The struck "stop for q−p+d+1" beside the right counting
wheel is the division count that p 79 later puts on "the second counting
wheel which has a stop upon it at d+1" (FR on p 79 earlier). Basis: the
same expression; nothing on p 74 says so.

---

## 4. 1 March, p 76: the stop of counting wheel q ends stepping down and starts stepping up

**Depth:** FR (`41` 250,60,2250,1000; 250,1000,2250,950; 250,1900,2250,1050
at 0.55). No date on p 76; p 77 is headed "1 March"; p 75's design.

(a)

> N.B. p was previously thrown out of gear with p−d and q out of gear with
> q−d.
> At the same ⟨time⟩ A and B are put on Mult.n axis ~~one~~ ⟨each⟩ is
> received on the fig wh.ls of ⟨one of the⟩ carriages belonging to Mult.n
> axis.
> Table being ~~made~~ ⟨finished⟩ throws into gear ⟨circularly⟩ gathering
> up tooth of p & q which acting on the gathering up wheel q (in this
> case) determines the No. of steppings down. It also throws into gear the
> Mult.n cycle of the barrels of Mult.n & Product axes here ends Mult.n but
> the stop of the count.g wh. q throws an arm in which in the subsequent
> part of its revolution throws out the gathering up tooth from q and
> throws in the gathering up teeth on q−d It also throws in on the barrel
> of the product axis the cycle for stepping up. the count.g wh. q−d
> determines the number of steppings up. This throws out Mult.n
> See page 78

(b) **Trigger:** two: the end of table making ("Table being finished
throws into gear …"), and **the stop of counting wheel q**, reached after
q gatherings (one per stepping down). **Acts on:** an arm, thrown in by
the stop, which (i) throws out the gathering-up tooth from q, (ii) throws
in the gathering-up teeth on q−d, (iii) "throws in on the barrel of the
product axis the cycle for stepping up". The q−d wheel then counts the
steppings up and "throws out Mult.n". So a count coming to its stop
changes **which barrel cycle is in gear** (Mult.n cycle → stepping-up
cycle) and **which counting wheel is being gathered**. **Not shown:** no
drawing on the page; no running up or carriage; how "throws out Mult.n"
is done.

---

## 5. 1 March, pp 78–80: division and root; a stop "in concurrence" with the end of table making puts in the division cycles

**Depth:** p 78 FR (`42` 250,60,2250,900 and 250,900,2250,800 at 0.55); p
79 upper FR-earlier, lower FR (`42` 2500,1500,2389,1450 at 0.55); p 80 FR
(`43` 250,60,2250,500 at 0.6).

(a) p 78, head "1 March", "for Division":

> ~~Direction~~ A and B having been rec.d as before upon the counting wheels
> and consequently q−p upon the counting wheel of the directing cam and
> the directing cam having set levers to step up or down it must be thrown
> out of gear with those levers and with the superposition of mo.n app.s
> and into gear with one of the red gathering up teeth which steps up or
> down the dividend q−p times. There is a stop or cam at the end of this
> which in concurrence with the stop at the end of the Table ⟨mak.g⟩ app.s
> throws into gear division cycles

p 79 upper (FR-earlier): "The wheel q is connected with the second
counting wheel which has a stop upon it at d+1 which after q is counted
stands at q+d+1 / As soon as direc.g cam is out of gear p is reduced to
zero and conseque.y the stop on the dec coun.g wh. … marks q−p+d+1 The
gath.g up tooth of q … now thrown into gear … vertically … thrown into gear
circularly … at the same time that the division cycle is thrown into gear.
/ The reduct.n of coun wh. p to zero also sets the spi. ax. belonging to
the regis.r whs of divi.n to the p.th and the p+1.th cages".

p 79 lower and p 80 top (FR):

> Ex.n of Root of A
> The dec. coun. wh. of p has a fixed stop at +30 on count.g the ~~digits~~
> number of digits in A this stop is placed at 30−p [figures struck] a
> wheel a fixed on p has its even teeth wanting and drives a complete
> wheel b which has a moveable stop upon it set to [?±]d this is thrown
> out of gear with a and into gear with a gathering up arm gather.g up.
> upon 30−p stepp.g up A each time the [p 80] stop at the end of 30−p
> throws into gear ex.n cycles and also the gathering ⟨up⟩ tooth upon b
> ex.n continues until the stop on b puts an end to it

(b) **Trigger:** the **directing cam** (which way q−p runs) sets "levers to
step up or down"; then a **stop or cam** at the end of q−p gatherings,
**jointly with** the stop at the end of table making. **Acts on:** levers
(direction of stepping), a red gathering-up tooth (put into gear), and
"division cycles" (thrown into gear). For the root, the stop at the end of
30−p "throws into gear ex.n cycles" and the stop on b "puts an end to"
the extraction. **Not shown:** no drawing; no running up; the levers and
how the cycles are "thrown into gear" are not described.

---

## 6. 1 March, p 81: the barrel table, the zero apparatus, and an "R"

**Depth:** FR (`43` 2520,30,2350,900; 2520,900,2350,1100; 2520,1950,2350,950
at 0.55; 2600,380,500,500 at 1.5; 3600,2230,1100,330 at 1.3). Head "1
March 1836". History (Vol XIII image 87, FR): "1 March 1st plan of Zero
Apparatus applied to barrels".

(a) A table headed "N.o of advances of barrel": rows 1–26, a second column
of barrel positions with letters, and text:

```
1   1     Rec. A & B
2   2   } Count on both
3   3   }
4   4A    Tabulate A. and reduce to zero Car. fig wheels   ⎫
5   5B    Tab.  2a                                          ⎪
6   4A    do    3a                                          ⎪
7   5B    do    4a                                          ⎬ Table making
8   4A    do    5a                                          ⎪
9   5B    do    6a                                          ⎪
10  4A    do    7a                                          ⎪
11  5 R   do    8a                                          ⎪
12  6     do    9a & rub out A from mill                    ⎭
13  7
14  8
15  9A
16  10
17  11
18  12B4
19  9A   20 10   21 11   22 12B4   23 9A   24 10   25 11   26 12B4
```

The letter in row 11 is a capital **R** (clear at ×1.5), standing a little
to the right of where the "B"s of rows 5, 7, 9 stand; row 11 is the only
place in rows 5–11 where the position after a "5" is not "4A".

> These repetitions continue 29 ~~cycles~~ ⟨advances⟩ of barrel after which
> step up q−d times and the multiplication is done.
> The counting wh. by its stop then throws out barrel and into gear with a
> ~~backing~~ ⟨zero⟩ app.s which brings it to zero
> On the zero column of barrel there are directions to step up and a
> backing pin
> The barrel then backs to −1 and steps up again but −1 having an
> advancing pin barrel goes to 0 and so on —
> These alternations are continued q−d times when stop of q−d counting
> wh. throws all out and mult.n is ended.

Drawing at the foot: two vertical axes; on the left one a block with
horizontal lines (a barrel with studs, seen side-on) and a part-circle
with radial ticks below (a dial or toothed sector); on the right one, a
taller barrel between two collars, and lower down a clutch-like collar on
a horizontal rod ending in a dot; at top right a small circle with six
small circles round a centre (an end view [?]). Caption:

> Plan for [?racking] Cycles in barrels by an axis reducing to ⟨various⟩
> zeros

(b) **Trigger:** the stop of the counting wheel (after 29 advances), then
the stop of the q−d counting wheel. **Acts on:** the barrel ("throws out
barrel and into gear with a zero app.s which brings it to zero"); the
barrel's own "zero column" then holds a step-up direction and a backing
pin, so the barrel alternates (back to −1, step up, advance to 0) q−d
times, and the q−d stop "throws all out". The caption names a further
idea: cycles in barrels set by **"an axis reducing to various zeros"**.
**Not shown:** what the R in row 11 means (no key); how the zero
apparatus or the reducing axis acts on the barrel (the drawing is
unlabelled).

(c) HYPOTHESIS. The "R" of row 11 marks a running up: the table-making
loop (barrel 4 ↔ 5) ends at 8a/9a, and row 11 is where the barrel goes on
to 6 instead of back to 4. Basis: the same capital R that p 88 (11 March)
writes after results that pass through zero; the position in the loop.
Against: on 1 March the page's own text ends loops by "stops", not running
up, and "R" could be another word. Not adopted.

---

## 7. 4 March, p 82: six counting wheels and their settings

**Depth:** FR (`44` 250,60,2250,1600 at 0.5; 300,1550,1700,800 at 0.7).

(a) Head "4 March", "1836". Upper half: a vertical axis with five discs,
each with a cam or arm and an upright bar beside it; two discs with
triangular cams on a second axis with horizontal rods ending in dots; a
third axis with offset bars (a stepped rack [?]); a large circle with a
radial arm. No words.

Lower: under a curved caption "Counting App. p 74", six counting wheels
drawn as upright hooks (a wheel in elevation with a stop at top and
bottom [?]) on one horizontal axis (double line). Each has a figure above
(its setting) and an expression below:

| above | 30 | 0 | −d | −d | +d+1 | 0 |
|---|---|---|---|---|---|---|
| below | p−30 | q−p | p−d | q−d | q−p+d+1 | p−q |

(b) The wheels start at 30, 0, −d, −d, +d+1, 0 and, after the counts are
added or subtracted, hold p−30, q−p, p−d, q−d, q−p+d+1, p−q. This is the
p 74 design (stops set to −d, d+1) laid out as six wheels. **Trigger /
acts on:** not stated. **Not shown:** any text; any running up.

---

## 8. 7 March, p 84: a running up ends a repeated operation

**Depth:** FR (`45` 1000,1100,1500,1000 at 0.75; 1550,1580,950,220 at 1.6;
250,1100,1300,1700 at 0.5; 1050,1850,1400,1050 at 0.6; 750,1900,700,450 at
1.2). History: "7 March Running up applied to <u>any</u> op." (Vol XIII image
87, FR).

(a)

> 7 March
> When any operation is to be terminated ~~or at~~ after a given ⟨variable⟩
> number of repetitions, let the number of rep.ns be ‸put on an axis having
> a carriage connected with it. Then ~~a running~~ on ⟨[?b]y a register
> axis⟩ subtr.g unity ⟨previous⟩ ~~at~~ each operation a running up will
> take place at end and thus the op.n be suspended

"variable", "register axis" and "previous" are clear; the first letter of
"[?b]y" shows no ascender.

Drawings on p 84 (none labelled): at the top, geometrical figures dated "6
March" (curves through P, A, E, Q); a curved line with "E", a small
arrowhead and "D" above a rule; a circle with a small knob; three rows of
dots; "04 08 12 16 20" twice; concentric arcs. Below the paragraph: (i) a
tall rectangle ruled into horizontal strips, its top two strips divided
into cells with "8" and "4 7" [?] and dots, with a small separate piece
marked "1" to its right (a stack of plates or figure cells [?]); (ii) a
hatched block (a barrel or a stack of discs) on a vertical axis carried
by a bracket, a narrow rectangle hanging beside it, and lower on the axis
a small star wheel and a column of small loops (a spiral or a stack of
pins [?]); a horizontal bar from the top right.

(b) **Trigger:** a running up — the axis that holds the count, with its
carriage, after unity has been subtracted before each operation. **Acts
on:** "the op.n be suspended" — **the page does not say what part is
moved**: no barrel, lever, lock, lifter or card is named, and the
drawings are not tied to the text by any letter. The count is put on the
axis from somewhere unnamed ("put on an axis"). **Not shown:** the
mechanism of suspension; where the count comes from.

---

## 9. 10–11 March, pp 88–89: "R" after results through zero; p 74 superseded

**Depth:** FR-earlier (`counting-running-up-1836.md` §2, regions there);
not re-read. History: "10 March Counting rack various stages up to 3rd
[?App.]" (Vol XIII image 86, FR this session).

(a) p 88, under "11 March": "p = 19 +p = 0019 / q = 21 −q = 0021 / p − q =
9998 R"; "−p = 9981 R … +q = 21 … 0002 R"; not marked: "0023 − 0021 = 0002",
"9977 + 0021 = 9998". Foot: "Today planned the method of using digit
Counting app.s entirely in Mill and plan of p. 74 superseded except spiral
Axis and Notched Whl." p 89: racks "units of Mill", "tens", "hundreds";
"If A have 10 on rising 1/10 it is thrown into gear with the tens at the
2nd tooth. If B has 10 it is also thrown into gear with the tens but not
untill the 3rd tooth".

(b) "R" stands against exactly the results that pass 0000/9999. **Acts
on:** nothing is stated on these pages. The superseded plan is p 74's
counting wheels and directing cam; the spiral axis and notched wheels are
kept. **Not shown:** a mechanism for R.

---

## 10. 12–13 March, pp 90–91: counting by a rack with 30 feelers; counts built with carriage so that they run up

**Depth:** FR-earlier for both pages (`counting-running-up-1836.md` §2); p
91 foot table re-read FR (`48` 2500,2150,2389,750 at 0.6), agreeing.

(a) p 91, "Digit counting app.s 12 March 36":

> 5. A rack a with 30 feelers upon it and sliding on the base d. Another
> rack ⟨b⟩ gearing with a by means of pinion c and also with a pinion e
> upon the axis of which is a bevel wheel working into another bevel wheel
> which moves vertically on its axis
> When d descends a and b descend with it until a is stopped by one of its
> feelers when b is made to descend with twice the velocity of d by which
> means e and all gearing with it are made to revolve.
> d is to descend ~~15 cages~~ ⟨so that the feelers on a will pass 15 wheels
> if they are all⟩ in .9 of a turn then ⟨at 0⟩ stop .1 thus feeling and
> transfer.g all the digits in 2 turns
> The interposed pinion c may have the bevel wheel upon it, thus
> dispensing with b and e.
> The feelers are to be in 3 or 4 different parts of the circle on
> different wheels, so that a may pass thro' a space = 3 or 4 Cages if all
> the wheels are at zero. — — Let q > p. Then Tab.n of mult. p multiplier

Foot table:

```
B                  C              D              E
+p Carr Sub.n      +p No Car      +q No Car      +q Car Sub.n
−q runs up         [?−] [faint]   −  0           −p 0   — During Tabu.n
[left: "this should be −(d+1)"]
0
−d Carr Sub.n runs up         } 2
Change Car from − to +        }
During {  +1
Mul.n  {  +1
       {  +1
       {  = p−d at end of Mul.n
```

p 90 (FR-earlier): "fig. wh. on which p or q is put. This fig wh. is
connected with add.n carriage"; "gears with units"; and a snail with a
disc d and rack b "in a similar manner to the digit count.g app.s above".
"Lifters 13 March" heads a sketch with no text.

(b) **Counting the digits (replacing p 75):** a feeler rack descends until
it meets the first wheel not at zero; the rest of its travel (at twice
the speed, through pinion c) turns e and the counting train; "all the
digits in 2 turns". **Trigger (table):** with q > p, B (+p −q, "Carr
Sub.n") "runs up"; E (+q −p) does not (it is left at its result, "0" under
it). Then a wheel set to 0, given −d with "Carr Sub.n runs up", "Change Car
from − to +", and +1 at each stepping until it holds p−d "at end of Mul.n".
**Acts on:** not stated on these pages: the table records which wheels
run up, not what the running up moves. **Not shown:** the parts that a
running up moves; no drawing of the table's wheels.

---

## 11. 12–16 March, p 92: "A or E runs up and directs which is to be Multiplier"

**Depth:** FR (`49` 250,60,2250,900 and 250,900,2250,850 at 0.6;
250,1700,2250,1200 at 0.55; 400,440,1400,300 at 1.1; 400,1200,1700,260 at
1.0). No date; between p 91 (12 March) and p 93 (16 March).

(a)

> Suppose two Mul.ns going on at same time then for ~~one~~ ⟨the first⟩ we
> have A. B. C. Suppose ~~Mult~~ ⟨Product⟩ occupies Nos 1 and 2 on C and
> Nos 3 & 4 on B and Multiplier Nos 3 and 4 on C.
> Put p upon [?₄]A ⟨and No 1 on B⟩ and q ⟨and No 3 on E⟩ upon ~~E~~ [?₂]F
> ~~Give off (& not retain) p to No 1 on B and q to No 3 of E~~
> Do — −p to No 3. on E and −q to No 1 on A
> A or E runs up and directs which is to be Multiplier.
> If q is Mul.r it must be transferred to A where it may be reserved while
> the same operations are gone through for the second Multiplication
> after which the mul.r of first Mul.n must be transferred to No 1 to
> ⟨have 1 subtracted from it and to⟩ limit the No. of steppings down, and
> to No 2 to have d+1 subtracted from it and to limit the No. of steppings
> up — but both 1 & 2 will want carriage

The small figures before A and F (read "1st … 2" in
`sketchbooks-control.md`) look like a subscript "4" before A and "2"
before F at ×1.1; not settled.

Workings below (FR): "p−d−1 = p−(d+1)", "p−(d−1)" (pencil), "000·00123",
"N 99999 / 99985 / 00014", "N 99999 / 00002 / 99997", "p.", "p−d−1 / 21
6 1 / 7 / 14", "d−p", "21 / 99985" (written over), "d = 23", "d−p =
2[?3]−21 = +2", "+21 − 23 − 1 = −3". At the foot, three small unlabelled
sketches (a bracket and rod ending in a comb-like part "E{" [?]; an
upright bar; a heavily inked lever or catch on a bracket).

(b) **Trigger:** p and q are put on axes; −p and −q are given off so that
each axis holds a difference (q−p on one, p−q on the other); **whichever
of A or E runs up** "directs which is to be Multiplier". **Acts on:** not
named — "directs". Then the multiplier's count is put on wheels No 1 and
No 2, 1 and d+1 are subtracted, and "both 1 & 2 will want carriage": the
counts that limit stepping down and stepping up are to be counted with
carriage, i.e. (reading) to end by running up. **Not shown:** what the
running up moves to "direct"; no mechanism drawn for it on this page.

(c) HYPOTHESIS. "If q is Mul.r" uses q as the name of the number with q
digits (as p 91 "Tab.n of mult. p multiplier"), and "the mul.r … must be
transferred to No 1" means the multiplier's **digit count**, since it is
to "limit the No. of steppings". The page does not say which.

---

## 12. 16 March, p 93: no cycle drawing (show-through)

**Depth:** FR (`49` 2550,60,2300,1300 and 2550,1100,2300,1100 at 0.55;
the second mirrored and contrast-stretched).

(a) Ink: a small sketch at the top (a bar divided into cells, the last
with a heavy mark; below it two rectangles and a pin); then

> 16 March — Decided that whenever transfers are made from Mill to Store or
> from Store to Mill the two central wheels should be ~~u~~ used together as
> one wheel

Pencil, forward-reading: "Comp. P. = √(—P²) = P^½ √−1"; "a + b√−1"; a
vertical column at the left with "E"-shaped teeth and an arrow ">" (no
words).

Everything else in pencil-grey on the lower page (two or three grid-like
blocks with uprights, "Pos. Cyc / q−p>0", "Neg. Cyc / q−p<", "1 = New
cycle step", and lines of writing) **reads correctly only when mirrored**
and then matches p 94's drawing and text in position ("At No 4 throw A
into gear / If in 5 q−p runs up A will be moved and cycle …"). It is p 94
showing through the leaf.

(b) p 93 has no design for choosing a cycle. The earlier reading of
"sketches of two cycles labelled Neg. Cyc. … Pos. Cyc." on p 93
(`sketchbooks-control.md` §1) should be withdrawn.

---

## 13. 22 March, pp 94–95: the running-up axis and its arms; positive and negative cycles

**Depth:** FR (`50` 250,60,2200,900; 250,850,2200,1050; 250,1750,2200,1150
at 0.6; 780,760,900,700, 1600,820,850,650 and 400,1050,500,650 at 1.0;
250,1550,800,300 at 1.3; 1000,1450,1100,400 at 1.0; 250,2250,1300,250 at
1.2; p 95 2530,60,2300,1000, 2530,1000,2300,900, 2530,1850,2300,1050 at
0.55).

### (a) p 94, every word

Top left: "22 March", "1836" (the year in a different ink). A column "03 /
06 / 09 / 12 / 15 / 18 / 21 / 24 / 27" (multiples of 3). A division:
"Div.d 000514 / 03 / 21"; "051 / 03 / 021 4 / 2[?1]a / 210 / 004" (with
dots over two figures of 051). Then:

> Carriage is ⟨in some cases⟩ to be prevented when running up occurs and
> the ⟨lowest⟩ wheel put back to 0

Labels in the figure: "running up axis" (written inside the axis); "B",
"A", "C" (beside the three barrels); "Pos. Cyc / q−p > 0" (under B, with a
small tick before "Pos."); "Neg. Cyc / q−p < 0" (under A); "Positive" (in
lighter ink, over) "1 = New cycle step" (left, under a separate part).

Text below the figure:

> At No 4 throw A into gear
> If in 5 q−p runs up A will be moved and cycle Neg. be put in gear. If it
> do not run up then A must be [?thrown] out of gear and B into gear.
> The 1st vert.l of Cycle Neg. puts out A and puts in C which C on the
> next running up puts out the cycle Neg

("thrown" is written heavily, over another word.)

### (a) p 94, the drawing, part by part

1. **The running-up axis**: a horizontal axis in elevation (two parallel
   lines, about 1900 px long, y ≈ 1000–1080), "running up axis" written
   along it, an arrowhead at its right end and a short vertical tick just
   before it.
2. **The part at the left end**: a heavily inked upright piece standing on
   the axis at its left end, with a round head (a ring or knob) at the
   top and a short foot below the axis line; smudged. It rises above the
   axis; it is the only part above it apart from the arms' tops. Unlabelled
   (a crank, handle or detent [?]).
3. **Three arms**: three flat bars fixed across the axis and hanging down
   below it (each a narrow rectangle crossing the axis, its top a little
   above the axis, its lower end about 250–300 px below). Arm 1 (x ≈
   1130) and arm 2 (x ≈ 1605) are plain, their lower ends thickened; arm 3
   (x ≈ 2025) has a foot or toe turned to the left at its lower end.
4. **Three barrels on axes**: below the arms, three cross-hatched squares
   (barrels seen side-on, horizontal lines across their faces), each on a
   horizontal axis line, each with an **upright stem** (a narrow
   rectangle) rising from the barrel towards the arms. B (left, x ≈
   1190), A (middle, x ≈ 1690), C (right, x ≈ 2125, the largest square).
   Each stem stands a little to the **right** of its arm, and the arm's
   lower end reaches below the top of the stem: the arm, if the axis turns,
   would strike the stem.
5. **The separate part at left**: an upright piece with a forked top (a
   U, like a spanner jaw) and a ring at the bottom with a small mark
   inside; not connected to the axis. Under it "Positive" and "1 = New
   cycle step".

No letters other than A, B, C mark the parts; the axis, the arms, the
left-end part and the forked part are unlettered. No wheel, carriage,
counting wheel or the "q−p" axis itself is drawn.

### (a) p 95

> The term.n of Pos. or of Neg. Cyc acts jointly with the term.n of table
> making to put in the real division cycle

Then "Sq. root"; "·000021 / ·000010 / 0·000000000021", "−(p+q)/2" [?];
"30 − q+1 + d" [?]; a sketch: an upright with five horizontal ticks, a
small toothed wheel "A" in a circle, a wheel "C" (circle) beside it,
"every other". Struck through with two diagonal lines: "if at 1 or 2 it
stops it subtracts 1 / — 3 or 4 — 2 / 5 5 — 3 / which arises from having
every alternate tooth wanting". Then "10·0001 / −1 / 1·0000"; and

> If there are 1 or 2 then step up 28 30−2 / 3 or 4 26 30−4 / 5 6 24 30−6
> / 7 8 22 30−6 [sic]
> A is driven one at each move in digits B is on same axis ⟨and⟩ fixed to A
> but every other tooth is cut out — B acts on C and when a tooth act it
> drives C over two teeth but at the next move of B its blank tooth
> cannot drive C

### (b) What it means

**Trigger:** "If in 5 q−p runs up": at barrel row (or step) 5, the q−p
wheels run up (q < p) or do not (q ≥ p). **What is moved:** "A will be
moved", i.e. barrel A is moved by the running up — in the drawing, by an
arm of the running-up axis striking A's stem. "At No 4 throw A into gear"
prepares this: A is in gear before the test. **What follows:** if it runs
up, the negative cycle (barrel A) is put in gear; if not, "A must be
thrown out of gear and B into gear" (positive cycle). Then "the 1st vert.l
of Cycle Neg. puts out A and puts in C", and **C, "on the next running
up", puts out the cycle Neg**: a second running up, read by barrel C's arm,
ends the negative cycle. p 95: the end of either cycle, jointly with the
end of table making, "put[s] in the real division cycle". "Carriage is in
some cases to be prevented when running up occurs and the lowest wheel
put back to 0" says what happens to the number on the wheels that ran up.

**Drawn:** axis, three arms, three barrels with stems, a left-end part and
a separate forked part. **Not drawn or not said:** how the running up of
the q−p wheels turns the running-up axis (no carriage, wheel or link from
the figure wheels is drawn); what moves B when q−p does **not** run up
(the text says "must be thrown", but no arm is assigned to the not-running
case — the arm over B can only act if the axis turns); what "No 4" and "in
5" number (barrel rows, by p 81's usage [?]); what the forked part "1 = New
cycle step" is connected to; what the left-end part is.

(c) HYPOTHESIS. The running-up axis turns once, a fixed angle, when a
carriage passes out of the top of the q−p wheels, and every arm on it
moves together; which barrel actually changes depends on which barrels
are "in gear" (engaged so that their stem lies in the path of an arm) at
that moment. Basis: one axis, three arms, the text's "At No 4 throw A into
gear" before the test, and C being "put in" before "the next running up".
Not stated on the page.

(c) HYPOTHESIS. "1 = New cycle step" with "Positive" labels the forked part
as the piece that takes one step to start a new cycle when the result is
positive. Basis: position and words only.

---

## 14. 24 March, Vol XIII history: count tens and units separately

**Depth:** FR (`229/48`, left half, rotated; cached tiles).

> (24 March 1836) Counting App. As 30 must be counted it seemed that 3
> turns were necessary and in the first sketch 2 were taken and the ⟨Eng.⟩
> increased to 1⅔ But it occurred that if the Eng. knew how many tens
> there were it could register those tens and direct another part to count
> only the difference between p (the number of digits) and the ⟨sum of
> the⟩ ~~[?no] of~~ tens so counted — Thus it would never be necessary to
> count more than nine & be recorded on a units wh. and not more than 3
> for a tens wh. and this would be done in one turn —

(b) A refinement of the p 91 counting (12 March, "in 2 turns") to one turn.
No running up; nothing about what the count controls.

---

## 15. Question 5: can any of these designs supply the number of figures of the multiplier to a multiplication?

Only as the pages state it:

- **Yes, as a count that limits stepping.** p 68: "add p over to a wheel
  having a stop at −d … gather up the p−d teeth of this wh.l and … at each
  tooth step up product". p 76: "the gathering up wheel q … determines the
  No. of steppings down … the count.g wh. q−d determines the number of
  steppings up". p 81: "steps up q−d times and the multiplication is done
  … These alternations are continued q−d times when stop of q−d counting
  wh. throws all out and mult.n is ended". p 91: "−d Carr Sub.n runs up /
  Change Car from − to + / During Mul.n +1 +1 +1 = p−d at end of Mul.n".
  p 92: "the mul.r of first Mul.n must be transferred to No 1 to have 1
  subtracted from it and to limit the No. of steppings down, and to No 2
  to have d+1 subtracted from it and to limit the No. of steppings up —
  but both 1 & 2 will want carriage".
- **How the count is got:** by counting the leading zeros of each number
  (p 75 spiral axis; p 91 feelers), A and B both, since which number is
  multiplier is decided after the count (p 75 directing cam, p 68 lever
  L, p 92 "A or E runs up").
- **What the count is in each case:** q (p 76, steppings down), q−d (pp
  76, 81, steppings up), p−d (pp 68, 91), "1 subtracted" and "d+1
  subtracted" (p 92). **None of the pages gives the count as "p" to a
  multiplication without these corrections**, and none feeds it into the
  number of additions per figure: every multiplication in pp 67–95 is by
  table (pp 68, 76, 81: "Table making", "Tabulate"), and the count governs
  stepping only.
- **Not found:** a count of the multiplier's figures used to stop a
  multiplication without a table; any statement of where the stepping
  count goes when the multiplier has fewer figures than the multiplicand,
  beyond choosing it (p 75 "If p > q directing arm governs the barrel of
  multiplier axis").

---

## Table

| Design | Date | Page | What triggers it | What it acts on | What is drawn | What is missing |
|---|---|---|---|---|---|---|
| Running up as a cost in division | Nov 1834 (history); 5 Dec 1835; 8 Jan 1836 | N/001 (earlier note); Vol II p 24; F/015–016 (earlier note) | a subtraction that runs up | not stated (p 24 counts "n + No of runnings up" cycles of 28; F/015–016 write "Runs up" as a step before "Step up quotient") | nothing | what the running up moves |
| Registers set by digit count; lever L | ~10–20 Feb 1836 | Vol II pp 67–68 | comparison of two digit counts by rack R; a wheel with a stop at −d | lever L "up or down … decide"; registers set to the p th / p+1 th cage; stepping of product | nothing on these lines | what L moves; no running up |
| Spiral axis and notched wheels; directing cam | 24 Feb – 1 Mar 1836 | pp 72–75 | leading zeros advance the spiral; superposition of p and q on the directing cam | "directing arm governs the barrel of multiplier axis"; gathering-up axis into gear with q | p 74: spiral and notched axes, counting wheels, directing cam, stop for −d, gathering-up teeth | link from directing arm to barrel; what the stops act on |
| Stop of counting wheel q | 1 Mar 1836 | p 76 | the stop of counting wheel q (after q steppings down); end of table making | an arm: gathering-up tooth out of q, into q−d; stepping-up cycle into gear on product barrel; "throws out Mult.n" | nothing | drawing; how Mult.n is thrown out |
| Division and root by stops | 1 Mar 1836 | pp 78–80 | directing cam direction; stop at end of q−p gatherings jointly with stop at end of table making; stop at 30−p; stop on b | levers "to step up or down"; red gathering-up tooth; "division cycles", "ex.n cycles" into gear; end of extraction | nothing | the levers; how cycles are thrown into gear |
| Barrel table and zero apparatus | 1 Mar 1836 | p 81 | stop of counting wheel (after 29 advances); stop of q−d wheel | barrel thrown out and into gear with zero apparatus; barrel's zero column (step-up direction, backing pin); "throws all out" | two barrels on axes, dial; "an axis reducing to various zeros" | meaning of "R" in row 11; the zero apparatus's parts |
| Six counting wheels | 4 Mar 1836 | p 82 | — | — | six wheels set 30, 0, −d, −d, +d+1, 0 → p−30, q−p, p−d, q−d, q−p+d+1, p−q | any text |
| Repetitions ended by running up | 7 Mar 1836 | p 84 | running up of an axis holding the count, unity subtracted (by a register axis) before each operation | "the op.n be suspended" — part not named | unlabelled sketches (plate stack, barrel on axis) not tied to text | what is suspended and how; source of the count |
| "R" marks; p 74 superseded | 10–11 Mar 1836 | pp 88–89 | results passing 0000/9999 marked R | not stated | workings; racks units/tens/hundreds | any mechanism for R |
| Feeler rack; counts with carriage | 12–13 Mar 1836 | pp 90–91 | feeler meets first wheel not at zero; "Carr Sub.n runs up" (B), "−d Carr Sub.n runs up" | the counting train (pinion e, bevel wheel); not stated for the running up | p 90 snail, disc, rack; no drawing of the table's wheels | what the running up moves |
| Choice of multiplier by running up | 12–16 Mar 1836 | p 92 | "A or E runs up" (p−q on one axis, q−p on the other) | "directs which is to be Multiplier" — part not named; counts on No 1, No 2 "will want carriage" | small unlabelled sketches at foot | what is directed and how |
| (show-through, no design) | 16 Mar 1836 | p 93 | — | — | only p 94 seen through the leaf; "two central wheels … as one wheel" | — |
| Running-up axis; positive/negative cycles | 22 Mar 1836 | pp 94–95 | "in 5 q−p runs up" (or does not); "the next running up" | barrel A moved, cycle Neg into gear; else A out, B (Pos) in; 1st vertical of Neg puts out A, puts in C; C puts out Neg; termination + end of table making put in division cycle | running-up axis with left-end part and three hanging arms; barrels B, A, C with stems; forked part "1 = New cycle step" | link from q−p wheels to the axis; what moves B when there is no running up; meaning of "No 4", "5" |
| Tens and units counted separately | 24 Mar 1836 | Vol XIII history | — | — | — | (counting only) |
