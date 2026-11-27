# Travelling platforms, locking plates and sectors, 1835–1836

Read by a coding agent from the Science Museum Group images, November 2026.
**No person has checked these readings.** This note continues
`bolting-plates-sources.md`. It tests the hypothesis of `docs/f-bu-audit.md`
("B k" = a part bolted to travelling platform k, "U k" unbolted; platform k
has a fixed lift) against Vol XIII, the drawings A/026–A/031, and Vol II
pp 68–103. Each source is given as **Observation** (what is on the paper),
**Reading** (what the words say, read together) and **Hypothesis** (what it
might mean for B/U). Nothing is adopted into the data.

Method: as in `bolting-plates-sources.md`. Pages were first read from the
1536 px previews (`coimages … large_*.jpg`). Passages quoted were then read
from 512 px tiles of the zoom image, fetched at full resolution and stitched
with PIL. Regions are x, y, w, h in full-resolution pixels **of the stored
zoom image**. Several stored images are rotated relative to the previews:

- Vol XIII's history (images 86–94) is written from the back of the book,
  inverted. Regions are in stored pixels; the crop must be turned 180° to
  read.
- A/030 and A/031 are stored portrait (8484 × 11576) and shown landscape by
  an EXIF flag on the preview. Regions are in stored pixels; A/031's
  writing reads correctly after a 180° turn of the stored crop.

Crops were kept in the session scratchpad only. Conventions: `[?word]`
doubtful, `~~struck~~`, `⟨interlined⟩`, `.n` for a raised ending.

Sources and zoom paths:

- **Vol XIII** = BAB/S/1/13 (`aa110069630`), "Scribbling Book Volume XIII.
  Sketch of the history of the new calculating engine", 96 images, files
  `…/Babbage_Papers_S19__Scribbling_Book_Volume_XIII.ptif`. Image 1 is
  `228/962`, image 10 `228/971`, image 12 `228/973`, images 81–95
  `229/42`–`229/56`. Images 1–85: a sketch book written forward (Feb 1835 –
  Aug 1836, not in date order at the front). Images 86–94: the history,
  inverted.
- **Vol II** = BAB/S/1/02, images 37–55 (`322/993`–`323/11`), as in
  `bolting-plates-sources.md`.
- **A/026** `212/674/Sketch_No.ptif`; **A/027** `212/675/Sketch_No.ptif`;
  **A/028** `212/676/Elevation_and_formulae_for_gear_trains.ptif`;
  **A/029** `212/677/Method_of_bolting_to_platforms_for_vertical_motion_of_Axes.ptif`
  (11408 × 8304); **A/030**
  `212/679/Sketch_of_sectors_for_giving_vertical_motion_to_axes_etc_1938.ptif`;
  **A/031** `214/339/Sketch_of_sectors_for_giving_vertical_motion_to_axes.ptif`.

---

## 1. Summary

- **Locking plates, travelling platforms and sectors are three different
  things, and Babbage says so.** Vol XIII's history (image 89) dates the
  travelling platforms and the *locking plates* to the same sketch, 5 March
  1835 (Vol XIII p 21): an axis is locked to a travelling platform, raised,
  **unlocked from it and held "locked to a fixed point"** by a locking
  plate, then "relock[ed] … to a travelling platform". The locking plates
  were removed "from the controul of the barrels" and became "a most
  comprehensive system". The sectors appear on 6 Feb 1836 (history: "1st
  Plan of raising axes by sectors moved by central drum see drawing
  27 Feb") and replace platforms for table making on 20 Feb 1836 (Vol II
  p 69).
- **The verb "bolt" goes with platforms from the start.** Vol XIII's history
  (image 90, early 1835): barrels "when pushed inward … bolted the
  necessary axes to travelling platforms which being raised the circular
  motions were given by other means". The same history (image 87) lists
  "4 Feb [?Bolting] to [?platforms] – drawing", i.e. A/029.
- **A/029 (4 Feb 1836) numbers no platforms.** Read whole at full
  resolution: the only figures are the sheet number "29", the date (twice)
  and the subscripts of axis names. It draws, in plan, two groups of axes
  each enclosed by stepped plate outlines on long arms, with a small
  rectangular block at each named axis. It gives no lifts, no
  platform-to-axis key in words, and no barrels. A ruled table at the foot
  pairs axis names (g1/SA1, SA2/g3, S1/g2, SS/S2T, cp/S2B, g/'cp, P/pp) on
  seven ruled lines, with no figures.
- **A/031 (27 Feb 1836) numbers four sectors and lists their lifts**: "N.o 1
  moves 5/8 in lifts 1.1 ins. or .4 ins. or .45 ins. / 2 … out … .6 …
  .2 … .3 or .275 / 3 … lowers .6 … .2 … .3 … .275 / 4 … in … 1.1 … .4 …
  .55". Each axis in its plan has two sectors marked "N.o k". This is the
  only list found of numbered lift-givers with their lifts, apart from
  F/013's own head. It shows the same magnitudes as F/013's platforms (1.1,
  .6, .4, .2, up and down), but **one numbered sector gives alternative
  lifts**, so in the sector scheme the number does not fix the lift.
- **An earlier table (Vol XIII pp 16–17, Feb 1835) has columns headed by
  signed lifts**: −1.75, −.5, −.5, −.35, −1.75 | +1.75, +.35, +.5, +1.75,
  with arrows down under the first group and up under the second, lettered
  D, E, F, G. It is a precursor of F/013's "Platforms" head (twelve columns
  of signed lifts), with other values.
- **6 Oct 1835 (Vol XIII image 82): "to make one platform move axes to
  various [?heights] in same time"**, beside a sketch of three axes with
  collars at different heights over one bar. Evidence that Babbage
  considered one platform giving different lifts. **This is against** the
  strict form of "platform k has a fixed lift", though F/013's heads give
  each platform one figure.
- **The 20 Feb 1836 decision speaks only of tables.** Vol II p 69 and its
  neighbours give no reason. But the sector drawings of 27 Feb (A/030,
  A/031) are general: "Sketch of Sectors for giving vertical motion to
  axes", with sectors on the same axes as A/029 (P, pp, g, g1, g2, g3, cp,
  'cp, S1, SS, S2T, S2B, SA2, SA3) about a "Short time axis". Vol XIII's
  history puts the "1st Plan of raising axes by sectors" on 6 Feb, two days
  after the bolting drawing. After 20 Feb, Vol II (pp 70–103, to 3 April
  1836) never uses "platform", "bolt" or "lock … to" again.
- **Another "B" in the same weeks.** Vol II p 81 (1 March 1836), a list of
  barrel advances for multiplication with table making, marks rows "4A",
  "5B", "12 B4", "9A". After "12 B4" the next row is "9": B there is the
  barrel going back (A advancing), not bolting. A letter B in Babbage's
  working notation of early 1836 need not mean "bolt".
- **Not found**: any list numbering platforms 1–12 with their lifts other
  than F/013's head; any page defining "B" or "U"; any description of how
  bolting of an axis to a platform works mechanically.

---

## 2. Vol XIII (BAB/S/1/13)

### 2.1 The history, entries for 1835 that define the terms

The history (written from 21 May 1836, image 94) narrates 1834–35 in prose
and then lists dated entries. Two passages from early 1835 bear on the
terms, though they lie outside Oct 1835 – Apr 1836.

**(a) Image 90 (`229/51`), left page of the rotated view.** Region
2470,0,2500,950, turned 180°. Undated; it follows "24 Jan.y 1835 General
plan is dated …" and precedes "5 March" on image 89.

Observation:

> After this the several cases of the actions of each ⟨fig.⟩ axis were made
> and their vertical motion found and notations made
> The general view of the directive part was now imagined. barrels with
> fixed studs corresponding to all the cases for each axis were proposed
> according as these barrels stood at any part.r case so when pushed inward
> they bolted the necessary axes to travelling platforms ~~and part~~ which
> being raised the circular motions were given by other means at the right
> times
> ~~The~~ barrels were brought to the right case by [continues on image 89:]
> drums with adjustable stops.

Reading. In Babbage's account of early 1835, a barrel's studs **bolt** axes
to travelling platforms; the platforms, raised, give the vertical motion;
circular motion is given separately. This is the passage N/002 summarises
for Feb 1835 ("Barrels to bolt axes to travelling platforms, Drums to govern
Barrels").

**(b) Image 89 (`229/50`).** Region 2470,500,2500,1400, turned 180°.

Observation:

> The several arrangements of this gen.l plan and the locking cost much time
> 5 March p 21 A plan for locking axes to travelling platforms had been
> contrived and it was found necessary to unlock an axis after raising it,
> then to leave it locked to a fixed point for a certain time then to unlock
> it and relock it to a travelling platform. It became necessary to remove
> these locking plates from the controul of the barrels — This sketch is the
> origin of what I have called locking plates which form a most comprehensive
> system.
> 7 March a plan for finding which is largest of two numbers

Reading.
- "Locking axes to travelling platforms" (the verb here is lock) and
  "locking plates" are distinct. The travelling platform carries the axis
  up. The locking plate holds the raised axis "to a fixed point" while it
  is free of the platform.
- The locking plates were taken from the barrels' control.

Hypothesis. If the F sheets follow this, "U k" (unbolt from platform k)
can be followed by a period in which the part stays up, held by a locking
plate, before it is bolted again. This would fit the audit's finding that a
U often comes in a later band than its B, after the part's return; it
does not explain it. "Bolting plates" (F/014, F/020) could be a name for
platforms or for locking plates; this passage makes "locking plates" the
name of the second.

**(c) Vol XIII p 21 itself (image 12, `228/973`, right page).** Region
2500,0,2428,1800. Page number "21" top right.

Observation:

> Contr. to lock and unlock axes from ⟨[?or]⟩ to trav.g platforms at top and
> to unlock them at ~~[?for]~~ bottom
> a position of ~~tumbler~~ A at bottom before locking by [?D]
> b d.o ⟨after⟩ ~~before~~ unlocking by D
> c d.o top ~~before~~ ⟨after⟩ unlocking by D
> a position of B ~~before~~ at top before locking by D

Sketches: an axis with a stepped piece and a small lever D; a T-shaped bar;
an elevation of a frame with a pair of slides. Letters a b c, α β γ.

Reading. The first sketch of locking (5 March 1835). It speaks of locking
and unlocking axes to travelling platforms "at top" and "at bottom", by
named parts A, B, D. No numbers of platforms, no lifts.

### 2.2 Vol XIII pp 16–17 (image 10, `228/971`), Feb 1835: a table of signed lifts

p 9 is dated 3 Feb 1835 and p 19 25 Feb 1835.

Observation. Left page: "Fig. Axes for ~~A~~ Constant N.o 1 or 4n+1 /
through Centre by Upper Wheel", rows "Red. Zero / Give off / Rec. Add.n /
Rec. Sub.n", "Ditto through lower central W.", "N.o 1 Cons.t add to N.o 2
through upper ⟨or lower⟩ central", "Give off to N.o 2 / 3 / 4 through upper /
lower", "Transfer to N.o 2 / 3 / 4", "16 cases 4 Variable 4 × 16 = 64 cases
for barrel". Right page: nine ruled columns. Heads (region 2850,80,1800,260):

> ‾1·75 | ‾·5 (over a struck figure) | ‾·5 | ‾·35 | ‾1·75 ‖ ⊥1·75 | ⊥·35 | ⊥·5 | ⊥1·75

The first five heads carry a bar above; the last four carry a bar with a
short vertical stroke through it. A heavy double rule separates the two
groups. In the body (region 2850,1350,1800,700 and the whole page), the
marks in the first group are all down arrows, lettered "↓D", "↓F"; those in
the second group are all up arrows, lettered "↑E", "↑F", "↑D", "↑G".

Reading. A table in which each column is a vertical motion of a given size
and direction, and the marks in a row say which lettered part makes it in
that case. The bar and the barred stroke are the signs of direction: bar
over = down column, stroke through = up column, agreeing with the arrows.

Hypothesis. The form is that of F/013's "Platforms" head: columns that
each stand for one signed lift (F/013: +1.1, +.6, +1.1, +.6, +.4, +.2, −.2,
−.4, −.6, −1.1, −.6, −1.1 for N.o 1–12). If these columns are platforms
(the word does not occur), then a year before F/013 Babbage already had
lift-givers each with one size and one direction, the same lift appearing
in more than one column (1.75 four times, .5 three times). The values
differ from 1836 (1.75, .5, .35 against 1.1, .6, .4, .2). Not evidence for
the 1836 numbering.

### 2.3 Forward pages, Oct 1835 – Jan 1836 (images 81–85)

Images 81 (29 Sept, 2 Oct 1835), 82 (5, 6, 7 Oct), 83 (10, 13, 24 Oct), 84
(30 Oct; 6 Jan 1836; 16 Jan 1836) and 85 (18 Jan 1836, inverted) were read
at preview. They are mechanism sketches with few words. One passage bears
on platforms.

**Image 82 (`229/43`), left page, 6 Oct 1835.** Region 0,1300,2500,1826
(text at about 1350,1820,1150,230).

Observation:

> to make one platform
> move axes to various [?ht.s]
> in same time

Beside it, three vertical axes in elevation, each with a collar (a small
block on the axis) at a different height above one horizontal bar, and a
second bar dashed above; to the right a pencil sketch of a lever and wheel.
Above on the same page, 5 Oct: "1st Snail wire in ring of fig. wh.l / 2 Two
different zero points one for add.n one for sub.n / 3 Thus lever moves
vert.y [⊐ for add.n / for neutral / ⊐ for sub.n]".

Reading. A way for **one** platform to move several axes to **different**
heights in the same time, by collars set at different heights (so that the
rising bar takes up each axis after a different free travel). This is the
reading of the sketch, not of words.

Hypothesis. Against the strict form of P ("platform k has a fixed lift,
which every part bolted to it shares"). In October 1835 Babbage considered
one platform giving several lifts. F/013's heads (Jan 1836) give each
platform one figure, so by January the design may have gone the other way,
or the figure may be the platform's own travel with parts taking less.
Nothing decides between these. Compare Vol II p 7 (Nov 1835): "Pin.s 1.1
.6 / Axis .4 .2" with lever proportions, two lifts from one motion.

Image 84 has labels "Div.d", A, B; image 85 has sector-like shapes (an
open fan with a pivot) dated 18 Jan 1836 on the inverted page. No words
about platforms or sectors on either.

### 2.4 The history's list, Nov 1835 – Apr 1836 (image 87, `229/48`, and image 86)

Image 87, left half of the stored image, turned 180°. Regions 0,1250,2550,1000
(Nov–Dec 1835), 0,1130,2550,300 (4–31 Dec), 0,300,2550,1000 (Jan–Mar 1836),
1650,880,900,180 and 1100,920,1450,200 (3 Jan – 4 Feb, enlarged).

Observation:

> 6 Nov 1835 Obs.ns on Drums
> 24 Gen. Plan N.o 9 with stores having single pin.n
> 28 Obs. on Drum
> To prevent incompatible motions. Spider
> 1 Dec 1835 Plan to step down prod. add. div.d axes and table to remain.
> 2 Dec. Printing separated entirely one rack conveying figures to it
> 4 Dec a long discussion on stepping down by long pinions not rejected
> ⟨Step. Ax. was us.d at this date for printing but not probably for the [?stand.]⟩
> 11 Plan with store axes without stepp.g ⟨NB Table not to [?be] stepped – but Div. and produc[t]⟩
> 31 Dec carbonised paper for printing single copy
> 3 Jan 1836 Algebraic plan to approx. to 3 roots of a cubic [?equation]
> 18 Jan. improved [?circ.r] plan drawn [?7 March]
> 29 Jan. Carrying by wires with clearance between ends
> 4 Feb [?Bolting] to [?platforms] – drawing
> 6 Feb. Plans to make drums act without spring with teeth cut out
> 1st Plan of raising axes by sectors moved by central drum see drawing 27 Feb
> 10 Central drum changed for small drums all round
> Page 67 Remarks on digit counting app.s
> 24 Plan of counting digits
> 1 March 1st plan of Zero Apparatus applied to barrels
> 7 March Running up applied to any op.
> 9 March feeling [?] without spring

The 4 Feb line is small and crowded between 29 Jan and 6 Feb; "Bolting"
and "platforms" are probable but not certain (the second word has the long
descender of "pl…f…"). "drawing" is clear. Image 86 (`229/47`) continues:
"10 March Counting rack various stages", "6 April Time of backing type
sector saved by [?printing]", then 9 and 15 April (stepping by long pinion
with notches), 9 May, 30 May, 1 June (preview only).

Reading.
- "18 Jan … plan drawn [?7 March]" matches A/027 ("Sketch N.o 11 …
  Designed 18 Jan.y, Drawn 7 March 1836").
- "4 Feb [?Bolting] to [?platforms] – drawing" matches A/029 (4 Feb 1836).
- "1st Plan of raising axes by sectors moved by central drum see drawing
  27 Feb" sits under 6 Feb and before 10 [Feb]. It matches A/030–A/031
  (27 Feb 1836). The sectors were planned **two days after** the bolting
  drawing, and before the 20 Feb decision.
- The 20 Feb decision itself has no entry. No entry speaks of
  platforms for table making, of multiplication "by table" or "without
  table", or of locking plates, between Oct 1835 and Apr 1836.
- On tables: "1 Dec 1835 Plan to step down prod. add. div.d axes and table
  to remain", "NB Table not to [?be] stepped". (The earlier history, image
  88, preview: "30 March [1835] page 45 Hitherto all mult.n and div.n had
  been done by successive add.n … I now proposed that the engine should make
  a mult.n table of the 9 mult.s of the multiplicand and then reduce the
  time of mult.n to the number of the digits"; "13 April mechanical
  contrivance by which the engine selected the particular multiple
  required".)

---

## 3. BAB/A/029, "Method of bolting to platforms for vertical motion of Axes", 4 Feb 1836

Read at full resolution over the whole sheet (all 391 tiles of the
11408 × 8304 zoom image were fetched and stitched; regions below).

### 3.1 Every legend, letter and number

Observation:
- Paper label, top left (region 1400,0,1200,700): "Bolting axes to /
  Platforms for Vert. Mot.n" and pencil "[A] 29".
- Sheet number "29" top left of the drawing; "4 Feb 1836" top right
  (region 9900,600,1500,400).
- Title, centre (region 3400,5950,2200,500): "Method of bolting to
  platforms for vertical motion / of Axes. 4 Feb.y 1836."
- Axis labels: upper left group cp, g, S (twice, joined by a red line),
  g1, SS, SA1; upper right group P, pp, p (twice, joined by a red line
  through pp), g2, g3, S2T, S2B, S1, SA2, 'cp; centre C, R (twice); lower
  O (twice), G (twice), T (twice), E (twice), c, 'c, c10, 'c10, SA1, SA2
  (large circles at the foot). Several unlabelled circles.
- Table, lower right (region 6400,7000,4900,1000; whole in region
  5900,7000,5500,1000): about eight horizontal ruled lines, their left
  ends stepped (each lower line starts further left). Between them,
  in two columns: g1 / SA1, SA2 / g3, S1 / g2, SS / S2T, cp / S2B, g / 'cp,
  P / pp. Between the two columns a group of four close vertical rules;
  further right two red verticals and a short vertical at the right end.
  **No figures in the table.**
- Museum mark "E.–1905" lower right.
- **No other number or word on the sheet.** No platform numbers, no
  lifts, no "N.o", no "B" or "U".

### 3.2 What is drawn

Observation (regions 1500,800,3000,4500 left group; 4500,800,3200,4500
right group; 800,4800,8000,3504 lower part):
- A plan of part of the mill, symmetrical about a vertical red centre line
  through C.
- On each side a long tapering arm runs from a pivot near the lower centre
  (about 3344,4867 on the left; about 5820,4920 on the right, above the T
  axes) up into the group of axes. On it are **stepped plate outlines**
  (L- and U-shaped, one inside another) that pass around several axes:
  on the left round g, g1, SS and the lower S; on the right round g2, g3
  and S2T.
- **Fine red lines radiate from each pivot to every axis of its group**
  (SA1, S, g1, SS, g, cp on the left; SA2, S1, S2T, g3, g2, pp, P on the
  right).
- At each named axis of the groups a **small rectangular block** overlaps
  the axis circle, with a step or notch where it meets the axis, its long
  side across the red radial line (region 5200,3700,900,800 shows S1 and
  SA2 enlarged). A dashed line marks the axis centre through the block.
- Other arms: cp (left) and 'cp (right) sit at the ends of two-link arms
  pivoted near large wheels; P–pp–P on an arm pivoted near C; two further
  arms with round pivots on the right; long arms from G pivots towards O
  and T at the foot; a curved arm down to SA2 at the foot.
- No barrels, drums, studs or levers to a barrel are drawn. No elevation
  of any axis is drawn.

Reading. The drawing shows, in plan, the parts that carry axes for vertical
motion and where each axis is taken (the blocks). It does not say which
axis goes to which platform except by the outlines that enclose them and by
the foot table's pairs.

Hypotheses (not established):
- **(H-A) The arms are the platforms**, levers swinging vertically about
  the pivots near T; the red radial lines give each axis's distance from
  the fulcrum, so axes bolted to one arm would rise by amounts in
  proportion to their radii. This would be the 6 Oct 1835 idea ("one
  platform move axes to various heights in same time") and the lever
  proportions of Vol II p 7. It would make a platform's lift depend on
  the axis, **against** "platform k has a fixed lift".
- **(H-B) The stepped plates are separate platforms** stacked one above
  another (the foot table, with seven ruled lines of stepped length, each
  naming two axes, could be the plates seen edge-on), and the blocks are
  the bolts that tie an axis to one of them. Then the pairs in the table
  (g1/SA1, SA2/g3, S1/g2, SS/S2T, cp/S2B, g/'cp, P/pp) would be the axes
  served by each plate. Seven plates, not twelve.
- Neither reading is stated on the sheet; the red radial lines could also
  be construction lines for arcs of swing in plan. **The drawing does not
  number platforms, give lifts, or show the bolt mechanism.**

---

## 4. A/026, A/027, A/028, A/030, A/031

Catalogue records `aa110000160`–`aa110000165`. A/026, A/027 and A/028 were
read from the 1536 px previews only; A/030 and A/031 in part at full
resolution.

- **A/026**, "Sketch No. 10*, circular, arrangement. Shows 26 variables",
  11 Dec 1835 (preview). Circular plan; "Sketch N.o 10* Dec.r 11 1835";
  label "Plan 10"; arrows "Give off from Store / Give off from Mill". No
  platforms, bolts or sectors written.
- **A/027**, "Sketch No. 11, circular, arrangement. Shows 27 variables",
  7 March 1836 (preview). "Sketch N.o 11 / Designed 18 Jan.y / Drawn 7
  March 1836"; label "Gen.l Plan Sketch 11 / Jan.y March 1836"; "Table in
  N.o 2", "Table in N.o 3" at the store; "N.os 1 and 3" etc. at the mill
  axes A, B, C, D, E. No platforms or sectors written.
- **A/028**, "Superposition of Motion. 16 March 1836" (catalogued as
  "Elevation and formulae for gear trains"; its zoom file is listed under
  A/027). Bevel trains A–S and formulae. Not about vertical motion.
- **A/030**, "Sketch of Sectors for giving vertical motion to Axes.
  27 Feb.y 1836" (preview title; catalogue: "Arrangement, design, sketch for
  interference"). Left part (region 2500,7300,3700,3600, stored pixels): a
  "Short time Axis" at the centre, with sectors in pairs at SA3 (twice),
  c10, c, SS (twice, red), SA2 (twice), t10 (red), S2T (twice, red), t
  (twice), S2B (twice). No numbers on the sectors in the part read. Right
  part (preview): a plan of axes P, pp, g, g1, g2, g3, cp, 'cp, S1, SS,
  S2T, S2B, SA2, SA3, R2, R3, T3, T4, O3, O4, c, c10, with rectangles
  (axis elevations) between them.
- **A/031**, "Sketch of Sectors for giving vertical motion to axes.
  27 Feb.y 1836." (title region 1700,450,6000,550, turned 180°).

  Legend (region 1700,950,2900,800, turned 180°):

  > N.o 1 moves 5/8 in lifts 1.1 ⟨ins.⟩ or .4 ⟨ins.⟩ or .45 ⟨ins.⟩
  > " 2 " " out " .6 " .2 " .3 or .275
  > " 3 " " " lowers .6 " .2 " .3 " .275
  > " 4 " " in " 1.1 " .4 " .55

  The ditto marks stand under "moves 5/8", under "in"/"lifts" in row 2 and
  under "out"/"lowers" in rows 3–4, by position. So, by reading the dittos:
  No 1 moves in, lifts 1.1 or .4 or .45; No 2 moves out, lifts .6, .2, .3
  or .275; No 3 moves out, lowers .6, .2, .3 or .275; No 4 moves in,
  lowers 1.1, .4 or .55. The direction of row 4 rests on a ditto's
  position and is not certain.

  "N.B. All the axes O and T, are long timed." (region 5000,1150,4200,330,
  turned 180°). "Sectors for S1 are the same in this view as those for pp."
  (region 3900,5900,1300,700, turned 180°).

  Sector plan (region 2490,2530,3760,3770, turned 180°): a central "Short
  time axis" with an arm marked "P" and "N.o 1", a second mark "N.o 3" near
  it; round it each axis has two sectors, each marked with a number: pp
  N.o 2 and N.o 1; g1 N.o 3 and N.o 4; g3 N.o 2 and N.o 1; cp N.o 4 and
  N.o 3; 'cp N.o 2 and [?N.o 4]; g2 N.o 1 and N.o 2; g N.o 4 and N.o 3.

Reading.
- A/031 is the only source found that **numbers the lift-givers and
  states their lifts**. There are four, two lifting (1, 2) and two lowering
  (3, 4); the large-lift pair (1, 4) gives 1.1 or .4 (or .45/.55), the
  small-lift pair (2, 3) gives .6 or .2 (or .3/.275).
- An axis has either a pair of lifting sectors (pp, g3, g2: 1 and 2) or a
  pair of lowering sectors (g1, cp, g: 3 and 4), by the labels read.
- The magnitudes 1.1, .6, .4, .2 are those of F/013's platform heads and
  of Vol II p 7.

Hypothesis. F/013's eight short-time platforms (N.o 3–10: +1.1, +.6, +.4,
+.2, −.2, −.4, −.6, −1.1) carry the same set of lifts as A/031's four
sectors (+1.1/.4, +.6/.2, −.6/.2, −1.1/.4). The sector scheme gives the
same motions with fewer drivers by letting one sector give more than one
lift. **This is a match of sets of numbers only.** A/031's numbers 1–4 are
not F/013's platform numbers (A/031's No 3 lowers; F/013's N.o 3 lifts
1.1).

---

## 5. The 20 Feb 1836 decision and Vol II pp 68–103 (to 3 April 1836)

### 5.1 p 69 and its facing page

Observation. p 69 (image 37, `322/993`): top, "18 Feb 1836", sketches of
wheels with arms, captioned "Locking App." (preview; region about
2560,0,2329,950). Then the 20 Feb entry (quoted in full in
`bolting-plates-sources.md` §3.10, region 2560,950,2329,1650): "Decided
that tables should be made by means of the ordinary sectors and not by
means of platforms …".

p 68, facing (region 250,650,2250,1650):

> plan to find which ~~[?has]~~ the greatest N.o Dig.ts
> R = rack put into gear first with counting wh.l of A then with that of
> B — according as p or q is greatest so will lever L be up or down and
> decide
> To Multiply A by B
> Add over A and B to the two ⟨Dig.t⟩ Counting App. and let them be applied
> successively to the above app. for finding greatest
> Tabulate B the greatest
> Set register to ⟨[?lowest]⟩ fig. of A connect it with the lifters and
> reduce ⟨it⟩ to zero by stepping down
> Continue on thus to p or p+1? terms
> But while table is making Reduce C. Wh.l of A to zero and add p over to a
> wheel having a stop at −d (d = no. of decimals) then ~~after the last fig~~
> ⟨when⟩ ~~[?…]~~ is used gather up ⟨the p−d⟩ teeth of this wh.l and ~~so after~~
> ~~[?…] the mult.n is complete~~ at each tooth step up product —

Reading.
- "the ordinary sectors" are named as already known, in contrast to
  platforms. The phrase "Nine or ten of the sectors are to be put into gear
  … acted on by the tooth on the drum of Mill" agrees with Vol XIII's
  "raising axes by sectors moved by central drum" (6 Feb).
- The decision is about **making tables**. It says nothing of platforms for
  the multiplication itself or for other vertical motion.
- **No reason is given** on p 69, p 68, or the pages after. p 68 is about
  choosing the larger of two numbers to tabulate and counting digits.
- "Locking App." two days earlier (18 Feb) is a sketch of wheels with
  pawls or arms; it is not said to concern platforms.

### 5.2 Vol II pp 70–103 (images 38–55, 22 Feb – 3 April 1836)

Read at preview; passages below at full resolution where stated.

- p 70 (22 Feb): "Cycle for Multiplication", two rows "3′ 4′ ~~2′ 1′~~ 1 2 3
  4 5 6 7 8 9 / 2′ 1′ ~~3′ 4′~~ 9 8 7 6 5 4 3 2 1", sketches of axes
  with collars. p 71 (24 Feb): "Barrel", "Counting Wh.l", sketches.
- pp 72–73 (24, 29 Feb): sketches of **sectors** (fans of teeth on an arc,
  a sector on a pivot over an axis with collars), "G.r gathering up tooth".
  No words about platforms.
- pp 74–79 (1 March): counting apparatus for multiplication and division
  (see `sketchbooks-control.md` §1).
- **p 81 (1 March 1836)**, image 43 (`322/999`), region 2520,30,1300,1500:

  > N.o of advances of barrel
  > 1 1 Rec. A & B
  > 2 2 } Count on both
  > 3 3 }
  > 4 4A Tabulate A. and reduce to zero ⟨Car. fig. wheels⟩
  > 5 5B Tab. 2a
  > 6 4A d.o 3a
  > 7 5B d.o 4a
  > 8 4A d.o 5a
  > 9 5B d.o 6a
  > 10 4A d.o 7a
  > 11 5 R d.o 8a
  > 12 6 d.o 9a & rub out A from mill [bracketed: "Table making"]
  > 13 7 / 14 8 / 15 9A / 16 10 / 17 11 / 18 12B4 / 19 9A / 20 10 / 21 11
  > / 22 12B4 / 23 9A / 24 10 / 25 11 / 26 12B4
  > These repetitions continue 29 ~~cycles~~ ⟨advances⟩ of barrel after which
  > step up q−d times and the multiplication is done …

  The capitals A, B, R and "B4" stand beside the second column of numbers
  in an upright hand. After "12B4" the next row is always "9A"; after
  "5B" always "4A".

  Reading. The second column is the barrel's row. "B" goes with the barrel
  moving back (12 → 9, 5 → 4), "A" with advancing; "B4" plausibly "back
  [to row 9, over] 4" or similar. **This "B" is not bolting.** The page
  shows multiplication by table, with table making by repetition on the
  barrel, ten days after the sector decision, and no platforms.
- pp 82–103 (4 March – 3 April): counting apparatus, running up (p 84,
  7 March), digit counting (p 91, 12 March), "Lifters 13 March" (p 90),
  "Decided that whenever transfers are made from Mill to Store … the two
  central wheels should be [?used] together as one wheel" (p 93, 16 March),
  positive and negative cycles (p 94, 22 March), sketches 23–31 March,
  stepping by racks (p 102, 3 April).
- **"Platform", "bolt" and "lock … to" do not occur on pp 70–103** as far
  as the previews show.

### 5.3 What happened to the bolting scheme for the multiplication itself

Observation. After 20 Feb 1836 no source read mentions platforms or
bolting in the mill design of 1836. The general drawings of 27 Feb (A/030,
A/031) give vertical motion to the same axes as A/029 by sectors, round a
"Short time axis". A/032 (9 April, "First method of stepping by long
pinions") and A/033 (21 April, "Sketch 12 … stepping by the method designed
15 April 1836") follow (catalogue titles only).

Reading. The sources do not say that platforms were given up for all
vertical motion. They say (a) tables are to be made by sectors, not
platforms (20 Feb), and (b) sectors were the "1st plan of raising axes"
from 6 Feb, drawn for the whole group of axes on 27 Feb.

Hypothesis. The platform/bolting scheme of the F sheets (Jan 1836) was
replaced as a whole by sectors driven from the central drum within three
weeks of A/029, the 20 Feb entry recording only the table-making part of
that change. This rests on the dates and on A/030–031 drawing sectors on
A/029's axes; no sentence says it.

---

## 6. Independent evidence for each platform's lift and direction

What a source other than the arrows of the F time charts says:

| Source | Date | What it gives | Ties lifts to numbers? |
|---|---|---|---|
| Vol XIII pp 16–17 (image 10) | Feb 1835 | nine columns headed −1.75, −.5, −.5, −.35, −1.75, +1.75, +.35, +.5, +1.75 | No numbers; columns unnamed |
| Vol XIII image 82 | 6 Oct 1835 | "one platform move axes to various [?heights] in same time" | Against one lift per platform |
| Vol II p 7 | Nov 1835 | "Pin.s 1.1 .6 −.6 −1.1 / Axis .4 .2 −.2 −.4", lever proportions | No |
| Vol II p 39 | Dec 1835 | margin "1.1 / .6 / .5" by "Platform lifting pin.s" | No |
| Vol II p 42 | Dec 1835 | parts locked to "Pl. 1, 2, 3, 4, 6" | Numbers, no lifts |
| F/013 head (not its arrows) | Jan 1836 | N.o 1 +1.1, 2 +.6, 3 +1.1, 4 +.6, 5 +.4, 6 +.2, 7 −.2, 8 −.4, 9 −.6, 10 −1.1, 11 −.6, 12 −1.1; Long 1–2, Short 3–10, Long 11–12 | **Yes**, the only such list |
| A/029 | 4 Feb 1836 | no figures | No |
| A/031 legend | 27 Feb 1836 | sectors N.o 1 +1.1/.4/.45, 2 +.6/.2/.3/.275, 3 −.6/.2/.3/.275, 4 −1.1/.4/.55 | Yes, for **sectors**, with several lifts each |

Reading. Outside F/013 itself, **no list numbers platforms 1–12 with
lifts.** F/013's head is on the same sheet as the arrows but is not the
arrows: the head gives each numbered platform one signed figure, and the
labels' figures were tested against it (`F013.md` §5.1). The set of
magnitudes 1.1, .6, .4, .2 recurs in Vol II p 7 (Nov 1835) and A/031
(Feb 1836), so it was stable across the change from platforms to sectors.
The direction of a lift-giver is fixed in every source that gives one
(Vol XIII pp 16–17 by column sign; F/013 by head sign; A/031 by "lifts" /
"lowers"). Its **size** is fixed in Vol XIII pp 16–17 and F/013, and not
fixed in A/031 or in the 6 Oct 1835 idea.

Which parts use which platform: only Vol II p 42 (Dec 1835), in words
(centre pinion and carriage pinions to N.o 1; stepping axis to Pl. 3 then
Pl. 4; adding axis to [?Pl. 5]; A2 to Pl. 6; two centre pinions to Pl. 4;
carriage pins to N.o 2), and A/031 by sector numbers on each axis.

---

## 7. Locking plates, travelling platforms, ordinary sectors

| Component | What it is, from the sources | First seen | Later |
|---|---|---|---|
| **Travelling platform** | A raised and lowered carrier to which axes are bolted or locked so that it gives them vertical motion; circular motion is given separately (Vol XIII image 90). Platforms go to a "neutral point" each cycle (Vol II pp 17, 23–24). Numbered (Vol II p 42; F/013 N.o 1–12) | early 1835 (Vol XIII image 90; N/002 Feb 1835) | A/029 (4 Feb 1836) is the last drawing; for tables given up 20 Feb 1836 (Vol II p 69). The word recurs in other senses for DE2 and 1859–1870 (`bolting-plates-sources.md` §4.3) |
| **Locking plate** | A plate that holds a raised axis "locked to a fixed point" between unlocking from one travelling platform and relocking to one; removed from the barrels' control (Vol XIII image 89) | 5 March 1835, Vol XIII p 21 (N/002 Mar 1835 "Locking plates to moveable levers") | "a most comprehensive system" (written by May 1836); A/180/1 names "Locking plates and travelling platforms" together |
| **Ordinary sector** | A toothed sector, put into or out of gear by "axes segment or some other mechanical contrivance … acted on by the tooth on the drum of Mill" (Vol II p 69), "moved by central drum" (Vol XIII); numbered 1–4 with lifts or lowerings of chosen sizes (A/031); in pairs at each axis round a "Short time axis" (A/030, A/031) | 6 Feb 1836 (Vol XIII history); sketches Vol II pp 72–73 (24–29 Feb); Vol XIII image 85 (18 Jan 1836) shows fan shapes, unlabelled | A/030–A/031 (27 Feb 1836); tables made by sectors from 20 Feb 1836 |

"Ordinary" on 20 Feb is not explained. It may mean sectors of the kind
already in use for other motions, as against platforms; no earlier use of
"ordinary sectors" was found.

---

## 8. Evidence against the platform reading of B/U

1. **The verb in Babbage's own descriptions of platforms is mostly
   "lock"** (Vol XIII p 21 and image 89, 1835; Vol II pp 17–42, 1835).
   "Bolt" occurs with platforms in Vol XIII image 90 (early 1835), N/002,
   F/013 t43, A/029 and the history's 4 Feb line. Both verbs are used of
   the same act.
2. **"Locking plates" are a separate part** that holds an unlocked axis
   up. A part between a "U" and its next "B" may be held by a locking
   plate; the F sheets' "plates" could name these.
3. **One platform giving several lifts** was considered on 6 Oct 1835, and
   A/029's red radial lines allow (not require) a lever-platform whose lift
   varies with the axis (H-A). Either is against "platform k has a fixed
   lift" taken strictly.
4. **A/031's numbered sectors give alternative lifts**, so a number fixing
   a lift is not Babbage's practice in the sector design.
5. **A/029 has seven paired lines, not twelve platforms**, and no numbers.
   Nothing in A/029 confirms twelve platforms.
6. **Another B in early 1836**: Vol II p 81 "5B", "12B4" (barrel back).
7. **No source defines B or U.**

---

## 9. Where searched, found nothing, or could not read

- **Vol XIII history**, images 86–94: all read at preview; the passages
  quoted at full resolution. No entry for the 20 Feb 1836 decision; no
  entry for multiplication "without table"; no list of platforms.
- **Vol XIII forward pages**, images 1–85: read at preview as contact
  sheets (4 to a sheet) and singly for images 81–85. Images 1–80 run
  Feb–Sept 1835 (with Aug 1836 entries on images 4–5); only image 10 (pp
  16–17) and image 12 (p 21) were read at full resolution. Mechanism
  sketches without words were not examined in detail. Images 1–32,
  37–40, 53–56, 69–72 and 77–80 were seen only at quarter size on the
  contact sheets; **images 33–36, 41–52, 57–68 and 73–76 were not looked
  at**. By their neighbours' dates (28 Apr 1835 on image 32, 4 May on 38,
  June on 53–56, July on 69–72, 29 July on 77) these lie in May–July 1835,
  outside Oct 1835 – Apr 1836, but they are not searched for platform
  words.
- **A/029**: whole sheet at full resolution. No numbers found except
  "29", the dates and axis subscripts.
- **A/030**: left part at full resolution; the right part and its labels
  at preview only. No legend of lifts seen at preview.
- **A/031**: legend, title, N.B., one note and the sector cluster at full
  resolution; the left half (plan of axes) at preview only.
- **A/026, A/027, A/028**: preview only.
- **Vol II pp 70–103**: preview, except p 81's list at full resolution
  and p 68.
- **Not read**: A/032, A/033, A/034 (titles only); N/001, N/003 not re-read;
  Vol II after 3 April 1836.
- **Uncertain readings**: Vol XIII image 87 "4 Feb [?Bolting] to
  [?platforms]" and "18 Jan improved [?circ.r] plan drawn [?7 March]";
  image 82 "[?ht.s]"; A/031 row 4's direction (by ditto position) and
  'cp's second sector number.

---

## 10. Claims, evidence and confidence

| Claim | Evidence for | Evidence against | Confidence |
|---|---|---|---|
| 1. "Bolt axes to travelling platforms" is Babbage's phrase for barrels connecting axes to raised carriers, from early 1835 | Vol XIII image 90 ("they bolted the necessary axes to travelling platforms"); N/002 Feb 1835; A/029 title | 1835 pages also say "lock … to travelling platforms" (Vol XIII p 21, image 89) | High |
| 2. Locking plates ≠ travelling platforms | Vol XIII image 89 (5 March 1835): axis unlocked from platform, "locked to a fixed point", relocked; "origin of what I have called locking plates" | — | High |
| 3. "Bolting plates" (F/014, F/020) = platforms | A/029 draws plates; F/013 t43 "Bolt to platforms" | Locking plates are named "plates"; their role (holding an unbolted axis) fits the gaps between U and B | Low–medium |
| 4. A/029 numbers the platforms and states lifts | — | Read whole at full resolution: no numbers, no lifts | Rejected |
| 5. A/029 shows how an axis is bolted (bolt/block per axis) | A small block at every named axis, aligned on radial lines | No word identifies the blocks; no elevation | Low |
| 6. Each platform has one fixed lift and direction | F/013 head (one signed figure per N.o); Vol XIII pp 16–17 (one signed figure per column, Feb 1835); audit test (F/013, F/018–019) | 6 Oct 1835 "one platform move axes to various heights"; A/029's radial lines (H-A); A/031 sectors give several lifts each | Medium for F/013's design; low as a general rule |
| 7. The lifts 1.1, .6, .4, .2 (up and down) are the design's set in Nov 1835 – Feb 1836 | Vol II p 7; F/013 head; A/031 legend | A/031 adds .45, .55, .3, .275; 1835 table uses 1.75, .5, .35 | High |
| 8. No source other than F/013 numbers platforms 1–12 with lifts | Search of Vol XIII, A/026–A/031, Vol II pp 1–103 | Parts not read at full resolution (§9) | Medium–high |
| 9. Sectors replaced platforms for table making on 20 Feb 1836 | Vol II p 69 | — | High |
| 10. Sectors replaced platforms for all vertical motion in Feb 1836 | Vol XIII "1st Plan of raising axes by sectors" (6 Feb); A/030–031 "giving vertical motion to axes" on A/029's axes; no platform after 20 Feb in Vol II to 3 April | p 69 speaks only of tables; no sentence says platforms were abandoned | Medium |
| 11. A reason for the change is recorded | — | None on Vol II pp 60–103 or in Vol XIII | Not found |
| 12. "B" on the F sheets abbreviates "bolt" | A/029 and the history's 4 Feb line use "bolting"; F/013 t43 | No key; Vol II p 81 uses B for barrel backing (1 March 1836); Dec 1835 verb is "lock" | Medium |
