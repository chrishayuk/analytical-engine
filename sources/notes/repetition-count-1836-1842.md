# Where the repetition count comes from, 1836–1842 (Vol II p 84, Vol XIII history, Vol IV p 412, Plan 25, Vol V p 74)

Read 27 November 2026 by a coding agent from the Science Museum Group
images (CC BY-NC-SA 4.0, The Babbage Papers at the Science Museum, London).
**No person has checked these readings.**

Two questions:

1. Is the number of repetitions a number fixed in advance (on a card), or a
   number computed and held in the Store (or produced by the mill)?
2. Does any computed value control backing, repetition, or which operation
   cards act?

Method: as in `vol4-control-1839-1840.md`. The IIIF server returns at most
512 px per request, so full-resolution crops were stitched from 512 × 512
tiles at scale 1 (scale factor after stitching given where reduced).
Crops are `x,y,w,h` in full-image pixels; they were kept in the session
scratchpad, not in the repo. Plan 25 (BAB/A/089, A/089/1) is stored
portrait with EXIF orientation 6; its crop coordinates below are in the
**displayed (landscape)** frame (11330 × 7428 for A/089, 10866 × 7604 for
A/089/1), converted to stored coordinates when fetched.

Conventions: `[?word]` uncertain; `~~x~~` deleted; `⟨x⟩` interlined;
`.n`, `.g` etc. superscript contractions. (a) is what is on the page,
(b) what it means, (c) hypothesis.

---

## 1. Vol II p 84, 7 March 1836 (BAB/S/1/02, image 45, `323/1`, 4871 × 2925)

### (a) On the page

Full resolution: `1000,1150,1500,900` (paragraph); `1600,1380,700,200` at
×2 ("variable"); `1700,1600,800,200` at ×2 and `1650,1610,450,130` at ×3
(the interlineation over "on subtr.").

> 7 March
> When any operation is to be terminated ~~or at~~ after a given ⟨variable⟩
> number of repetitions, let the number of rep.ns be put on an axis having
> a carriage connected with it. Then ~~a running~~ on ⟨[?b]y a register
> axis⟩ subtr.g unity ⟨previous⟩ ~~at~~ each operation a running up will take
> place at end and thus the op.n be suspended

- **"variable"**: settled. Written above the space between "given" and
  "number", in the same ink; v-a-r-i-a-b-l-e is clear at ×2.
- **"by a register axis"**: "register axis" is clear. The first word is a
  single descending "y"-form followed by "a"; no ascender of a "b" is
  visible at ×3. Read "[?b]y a register axis". (It is written over "on";
  "on" is not struck through.) "previous" is clear, written above and to
  the right of "unity", with "at" struck.
- There is a caret-like stroke before "put" ("be ‸put on") with nothing
  interlined above it.

### (b) What it means

The count is "put on an axis" with a carriage; a register axis subtracts
unity before each operation; when the count is exhausted the axis runs up
and the operation is suspended. The page **does not say where the number
on the axis comes from** — neither card nor Store nor mill is named. The
interlined "variable" says the count differs from one use to another
(the history sheet N/003 repeats it: "To repeat an Opn any variable No of
times . Vol 2 p 84 7"). The count is fixed once put on the axis; the
running up only ends the repetition.

### Context, pp 74–95 (from `sketchbooks-control.md` §1, not re-read)

In the surrounding pages (24 Feb – 22 March 1836) the counts that limit
repetitions inside multiplication and division are **derived from the
operands**: the number of digits p, q of the two numbers is counted
mechanically (p 75), the difference q−p is formed by superposition, and
the counting wheels "p−d", "q−d" etc. limit the steppings (pp 76, 78–79,
81). p 92: "the mul.r of first Mul.n must be transferred to No 1 to ⟨have
1 subtracted from it and to⟩ limit the No. of steppings down"; "A or E
runs up and directs which is to be Multiplier". p 94 (22 March): "If in 5
q−p runs up A will be moved and cycle Neg. be put in gear. If it do not
run up then A must be thrown out of gear and B into gear." These are
data-derived counts and a data-dependent choice of **barrel cycle**
inside one operation, not of operation cards.

## 2. Vol XIII, "Sketch of the history of the New Calc Engine" (BAB/S/1/13, `aa110069630`)

The history is written from the back of the book, inverted, on images
86–94 (`229/47`–`229/55`). It opens on image 94 ("Sketch of the History of
the New Calc Engine … This paragraph was written 21 May 1836 C.B.").
Images 1–85 are a forward sketch book (1835–1836), not read.

### (a) On the page

Image 87 (`229/48`, 4969 × 3126), left half of the stored image, rotated
180° for reading. Full resolution `60,150,2450,1150` and
`60,1880,2450,1200`.

> 10 Central drum changed for small drums all round
> Page 67 Remarks on digit counting app.s
> 24 Plan of counting digits
> 1 March 1st plan of Zero Apparatus applied to barrels
> 7 March Running up applied to <u>any</u> op.
> 9 March feeling [?] without spring

and, at the head of the facing (inverted-order) page:

> (24 March 1836) Counting App. As 30 must be counted it seemed that 3
> turns were necessary and in the first sketch 2 were taken and the ⟨Eng.⟩
> increased to 1⅔ But it occurred that if the Eng. knew how many tens there
> were it could register those tens and direct another part to count only
> the difference between p (the number of digits) and the ⟨sum of the⟩
> tens so counted — Thus it would never be necessary to count more than
> nine & be recorded on a units wh. and not more than 3 for a tens wh.
> and this would be done in one turn —

Image 86 (`229/47`), top of the page that continues it, full resolution
`2480,2550,2489,576`, rotated: "10 March Counting rack various stages
[?] 3rd [?]"; "6 April Time of backing type sector saved by [?printing]".

### (b) What it means

The history's March 1836 entry on p 84 is only "Running up applied to
<u>any</u> op." (7 March). It generalises running up (end of a count) to
any operation; it says nothing about where the count comes from. The
24 March entry is about counting the **digits** of a number (p), i.e. a
count derived from data inside the mill, as in Vol II pp 75–91.

## 3. Vol IV p 412, 1 Aug 1840 (BAB/S/1/04, image 204, `225/711`, 4799 × 2960)

### (a) On the page

Full resolution `60,40,2330,700`; `60,700,2330,700`; `60,1360,2330,900`.
Ink over a pencil text; the ink is transcribed.

> 1 Aug  History
> If there are not more than 20 indices each of two figs only put them
> above each on one Store axis
> When the first index is req.d Reduce the index Axis to zero giving off
> the two lowest figs to the Count.g App. and returning the Compl.t on I
> No 1 then step [?I No 1] down twice and the two lowest are destroyed &
> the next index is prepared
> The R.g up of the first index on the Card C.g App. directs its barrel to
> perform the operations necessary to put the second index upon it
> } Prelim. { Store / Prelim. / Index Making / Subsidiary / Terminal

("individual" in the earlier reading of line 1 is not there: "20
indices", with a struck or blotted letter before "indices".)

### (b) What it means

The indices (two-figure counts) are **held on a Store axis**, packed up to
20 per axis, and given off two figures at a time into the card counting
apparatus; the remainder goes back via I (the Ingress axis; on Plan 25,
"Rack — Give off from Store to I or ″F"). When one count runs up, the
barrel loads the next. So the count comes **from the Store**. The page
does not say how the indices got onto the Store axis (from number cards,
or computed). The word list "Store / Prelim. / Index Making / Subsidiary /
Terminal" names an "Index Making" stage among the preliminaries.

### (c) Hypothesis

"Index Making" as a preliminary stage suggests indices may be formed by
the engine before the main work, i.e. possibly computed; the page does not
say so. No computed value here changes a count once it is loaded, and no
mill result is shown governing the cards.

## 4. Plan 25, 6 August 1840 (BAB/A/089 and BAB/A/089/1)

Catalogue: **BAB/A/089** "Arrangement and rack of Plan 25" (`aa110000224`,
54 × 90 cm, one sheet; image `214/465/Plan_25_1840.ptif`), and
**BAB/A/089/1** "The general plan of Mr. Babbage's Great Calculating
Engine. Arrangement and rack, details, et cetera." (`aa110000225`,
61 × 92 cm, scale included; `214/464/…`; a lithograph copy, marked
"LITHO COPY OF BAB [A] 89"). No date field in either record.

### (a) On the page

A/089 (red and black ink): crops (display frame) `5100,3650,1800,1000`
at 0.8; `7000,2750,2900,1350` at 0.6.

> Plan 25 / 6 August 1840 / There are to be 41 figure wheels besides a
> sign wheel on certain axes. See Sketch Book Vol. 3 pages 347 & 349.

Beside the Store: a dashed enclosure "Counting Apparatus" (wheels A, a, B,
K, L, g, G, h), standing over the Rack; the Rack is labelled "→ Give off
from Store to I or ″F / ← Receive on Store from ″A or I". At left, added
later: "Improved fixed wire for Carriage Drawing 32. 14 May 1841"; label
on the mount "General Plan 25 and Improved fixed wire for Carr. … Aug 1840
May 1841".

A/089/1 (lithograph): preview, and `4100,1350,1400,1100` (display
frame) for the "Running-up Levers": four levers a, a₁, a₂, a₃ on axis d
joined at f; b, b₁, b₂, b₃ on a second axis; c … c₃ above, broken off.
Separate detail drawings, unconnected to the plan, of "Operation Cards",
"Variable Cards", "Number Cards", "Reducing App. R" with "Barrel B" (×3).

### (b) What it means

Plan 25 places a counting apparatus in the Store, next to the rack that
gives off from the Store to I. That fits p 412: counts given off from the
Store into a counting apparatus. Neither sheet shows a connection from a
mill running up to a card prism or card counter; the running-up levers are
a free-standing detail whose c-arms are drawn broken off. The drawing
does not decide what the levers act on.

## 5. Vol V p 74, 12 March 1842 (BAB/S/1/05, `aa110069623`)

Catalogue: "Scribbling Book Volume V. Important matter of history in the
Analytical Engine", 562 pp, 288 images, no date field. Image–page offset
(viewed): image 38 = pp 70/71, image 40 = pp 74/75, so **left page =
2·N − 6** here. p 75 is headed "14 March 1842".

### (a) On the page

Image 40 (`226/210`, 4937 × 3093), full resolution `150,100,2350,1100`
and `150,1150,2350,1100` at 0.85. Ink over pencil, nearly word for word:

> 12 March
> Operation of Reversing sign
> Oper.n Card orders barr. to a vertical which has the negative sign upon it.
> Var. Card orders the variable whose sign is to be changed to receive
> through Rack.
> Vert. ord.d by Card to give negative sign to F also a connexion between
> F and Rack — also F to be reduced to zero thus conveying its sign to the
> Store axis but not altering the figure wheel of the var.ble
> If the sign of the var. was + (or even No.) the add.n of minus (or an
> odd No.) has reversed it.
> If the sign of the var. had been — (minus or odd) the add.n of — (or odd)
> would make it [?even] and thus also reverse it

p 75 (14 March 1842): "Stepping up or down", rows of axis orders numbered
(1)–(8).

### (b) What it means

F/227 cites p 74 for its first part (reversing sign). p 74 has the
reversal only, done by adding a minus sign (parity); **no zero test, no
sign test, and no use of a result** to order cards. The zero and sign
tests of F/227 (April 1842) are not on this page.

---

## Summary

| Source | Date | Where the count comes from | Computed value controls backing / repetition / cards? |
|---|---|---|---|
| Vol II p 84 | 7 Mar 1836 | "put on an axis"; source not stated; "given ⟨variable⟩" | no (running up only ends the count) |
| Vol II pp 75–94 | Feb–Mar 1836 | digit counts p, q, d and the multiplier, from the operands | yes, inside one operation: q−p running up chooses the barrel cycle (p 94) and which number is multiplier (p 92); not operation cards |
| Vol XIII history | Mar 1836 | not stated ("Running up applied to any op.") | no |
| Vol IV p 412 | 1 Aug 1840 | Store axis (packed two-figure indices) → card counting apparatus | no; counter's own running up loads the next index |
| Plan 25 (A/089, A/089/1) | 6 Aug 1840 | counting apparatus beside the Store rack | not shown |
| Vol V p 74 | 12 Mar 1842 | — | no (sign reversal only) |

Gaps: how indices reach the Store axis ("Index Making") is not stated;
Vol III pp 347 & 349 (cited on Plan 25) were not read; Vol XIII images
1–85 were not read.
