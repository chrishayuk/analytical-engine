# Inputs of the held-out sheets F/021–024, F/026–029, F/032, F/033

Read by a coding agent from the Science Museum Group images, 27 November
2026. **No person has checked these readings.** This note records the
*inputs* of a held-out test only: titles, layout, column heads, platform heads,
every B/U label row, and the platform columns' own arrows. It does **not**
record any arrow, figure or other mark in a non-platform column (axis, pinion,
wheel, rack, carriage, lock, cage columns): those are held out. It changes no
transcription. It follows `f-rechecks-and-heldout.md` §4 (the F/015–016
labels).

**Method.** As in `bolting-plates-sources.md`: aligned 512 × 512 tiles of the
IIIF zoom image (`https://zoom.sciencemuseumgroup.org.uk/iiif/3/<zoom path>`),
fetched one at a time 3.2 s apart and stitched with PIL. Scale 1 = full
resolution; scale 2 and 8 are 1024- and 4096-px tiles served at 512. No
request was refused by the zoom server (no 403/429). The collection search
returned 403 (CloudFront) to five catalogue queries; the image paths of
F/027–033 were taken from a catalogue dump already in the session scratchpad
(fetched in the earlier session), and every size below is from the zoom
server's own `info.json`. Crops were kept in the scratchpad only. Regions are
(x, y, w, h) or y-ranges in full-resolution pixels of the stored image.
Conventions: `[?x]` doubtful, `~~x~~` struck, ″ and ′ for the double and
single prime marks as written.

## 0. What was looked at (exposure statement)

For every table image:

1. **The whole image at 1/8 scale** (to find the band rules and the sheet's
   layout). At 1/8 the arrows and some figures of every column are visible;
   none was recorded.
2. **The head** at 1/2 scale (top 900–1400 px of the image).
3. **Each band's label row at full resolution**, as a strip from about 40 px
   above the band rule to about 85 px below it (F/021–024), or to about 200 px
   below it (F/026–029, F/032, F/033, whose label row shares its ruled cell
   with row 1). These strips show the row-1 arrows and figures of every
   column; they were not read or recorded.
4. **Platform columns, full height, at full resolution**: F/026
   (293, x 5400–5994), F/027 (296, x 5300–6016), F/032 (311, x 3900–4700,
   which also takes in the Lock Carr.″ column and the edge of Bolt).
5. The row-number column at full resolution for F/032 (311, x 0–250) and
   F/033 (316, x 0–400), and, for F/033, three further full-resolution strips
   where labels are written away from the label rows (316: y 1850–2110 at
   x 4700–5498; y 5330–5570; y 6040–6270).

Covers and other images (279, 281, 284, 285, 287, 291, 294, 297, 300, 310,
312–315) were fetched at 1/8 only, to identify them; their writing was not
read, except where stated.

## 1. The images

| Sheet | Image | Zoom path | Size (w × h) | Content |
|---|---|---|---|---|
| F/021 | 279 | `216/279/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif` | 4983 × 6442 | cover (not read) |
| F/021 | 280 | `216/280/Babbage_Papers__Division_without_Table_1836_Jan_13.ptif` | 9315 × 6446 | whole table, one photograph |
| F/022 | 281 | `216/281/…Division_without_Table_1836_Jan_13.ptif` | 4983 × 6442 | cover (not read) |
| F/022 | 282 | `216/282/…` | 9315 × 6446 | whole table |
| F/022 | 284 | `216/284/…` | 4992 × 6405 | back of the sheet (stamp "BAB [F] 22"; not read) |
| F/023 | 285 | `216/285/…` | 4992 × 6405 | cover (not read) |
| F/023 | 286 | `216/286/…` | 9315 × 6446 | whole table |
| F/024 | 287 | `216/287/…` | 4992 × 6405 | cover (not read) |
| F/024 | 288 | `216/288/…` | 9342 × 6405 | whole table |
| F/026 | 291 | `216/291/Babbage_Papers__Square_Root_1836_Jan_15.ptif` | 4951 × 6369 | cover (not read) |
| F/026 | 292 | `216/292/…Square_Root_1836_Jan_15.ptif` | 5994 × 6369 | table, left half |
| F/026 | 293 | `216/293/…` | 5994 × 6369 | table, right half |
| F/027 | 294 | `216/294/…` | 4999 × 6369 | cover (not read) |
| F/027 | 295, 296 | `216/295/…`, `216/296/…` | 6016 × 6369 each | table, left and right halves |
| F/028 | 297 | `216/297/…` | 4997 × 6369 | cover (not read) |
| F/028 | 298, 299 | `216/298/…`, `216/299/…` | 6004 × 6393 each | table, left and right halves |
| F/029 | 300 | `216/300/…` | 5056 × 6393 | cover (not read) |
| F/029 | 301, 302 | `216/301/…`, `216/302/…` | 5587 × 6369 each | table, left and right halves |
| F/032 | 310 | `216/310/Babbage_Papers__Ordinary_Cycle_of_16_1836_Jan_18.ptif` | 5073 × 6369 | another sheet (circles and figures; not read) |
| F/032 | 311 | `216/311/Babbage_Papers__Ordinary_Cycle_of_16_1836_Jan_18.ptif` | 5257 × 6369 | whole table |
| F/033 | 312–314 | `216/31N/Babbage_Papers__First_General_Notation_1836_Feb_12.ptif` | 4979 × 5378; 5220 × 8671 (313, 314) | "First General Notation" (filed in this record; not read) |
| F/033 | 315 | `216/315/Babbage_Papers__Notation_of_Carriage_1836_Jan_25.ptif` | 4987 × 6401 | cover: "Notation of Carriage", "25 Jan.ʸ 36", "(33)" (1/8 only) |
| F/033 | 316 | `216/316/Babbage_Papers__Notation_of_Carriage_1836_Jan_25.ptif` | 5498 × 6959 | whole table |

Titles (catalogue): F/021–024 "Division without table", sheets 1–4;
F/026–029 "Square root", sheets 1–4; F/032 "Ordinary cycle of 16."; F/033
"Notation of carriage". Dates are from the file names except F/033, whose
table carries "25 Jan.ʸ 1836" over the head and, at its foot, a note
"Commencement of cycle altered 23 March 1836" and memoranda dated "26 March"
(read at 1/4 only, [?] in places).

**The square-root halves overlap.** Each left half ends, and each right half
begins, with the same columns (from about "T4" to "D Carr. c" below). Labels
in the overlap were read on both halves and agree; they are listed once.

## 2. F/021–024, "Division without table", 13 Jan 1836

**Layout.** One table per sheet, heads at the top, four label rows. Each
band is ruled at its top; "1/3" is written above the rule and "2/3" just under
it: **the "2/3" row is the label row**; rows 1–15 follow (row numbers in a
column at x ≈ 240–400), and "1/3" closes the band at the next rule. Band rules
(y on the table image): F/021 1108, 2802, 4492, 6172; F/022 1140, 2830, 4525,
6208; F/023 1104, 2800, 4488, 6176; F/024 1144, 2848, 4536, 6216 (±30 across
the sheet). The fourth band is cut off by the foot of the table (rule at
y ≈ 6400) after its row 1. There are **no platform columns** and no "Bolt"
column.

**Heads (F/021, read at 1/2 scale; F/022–024 have the same columns, checked
at 1/2 scale).** x on 280, full resolution, ±20:

| x | Head as written |
|---|---|
| 240–402 | row numbers |
| 402–732 | two columns, no head |
| 732–894, 894–1060 | "Axis A" — "Ver", "Cir" |
| 1060–1224, 1224–1390 | "Figure wh.ˢ" — "N.º 1", "N.º 2" |
| 1390–1558 | ″P [? the mark is a double prime or a flourish] |
| 1558–1722 | "pp" |
| 1722–1890 | no head |
| 1890–2056 | "ap" |
| 2056–2218 | "g" |
| 2218–2384 | "g1" |
| 2384–2552 | "Figures upon Axis A" |
| 2552 | heavy vertical rule |
| 2552–3046 | three columns, no head |
| 3046–3206, 3206–3370 | "Axis B" — "Ver", "Cir" |
| 3370–4030 | "Figure wheels" — "N.º 1", "N.º 2", "N.º 3", "N.º 4" |
| 4030–4324 | a narrow column and one column, no head |
| 4324–4488 | ′P |
| 4488–4656 | ′p′p |
| 4656–4818 | "Carriage" — "b" |
| 4818–4982 | ′g |
| 4982–5146 | ′g1 |
| 5146–5314 | "O2" |
| 5314–5482 | "T2" |
| 5482–5642 | "Carriage" — ′b |
| 5642–5810 | ′g2 |
| 5810–5974 | ′g3 |
| 5974–6138 | "O3" |
| 6138–6298 | "T3" |
| 6298–6458 | ′S′S |
| 6458–6624 | ′S1 |
| 6624–6790 | "Wire Axes Ver" |
| 6790–7118 | "Figures upon Axis B" |
| 7118 | heavy vertical rule |
| 7118–7282 | "R1 Cir" |
| 7282–7440, 7440–7608 | "Axis A" — "Ver", "Cir" (a second Axis A group; called **A₂** below) |
| 7608–7936 | "Figure wheels" — "N.º 3", "N.º 4" |
| 7936–8104 | "SS" |
| 8104–8268 | "S1" |
| 8268–8780 | "Cages where the quotient is registered" — "n", "n−1", "n−2" |
| 8780–9266 | three columns, no head |

Titles over the head: a word over the left group, cut off at the top of the
1/2-scale strip ([?"Divisor"]); "Quotient" over the right group.

**Labels.** Every column of every label row was inspected at full
resolution; a column not listed has no label in that band. All readings are
clear unless marked.

### F/021

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "B 5" |
| 1 | ″P | "B 3" |
| 1 | ap | "B.4" (a point between, as written) |
| 1 | g | "B 4" |
| 1 | ′P | "B 3" |
| 1 | ′g | "B 1" |
| 1 | T2 | "B" (no figure) |
| 1 | T3 | "B" (no figure) |
| 2 | Axis A Ver | "U 5 B 6" |
| 2 | ″P | "U 3" |
| 2 | pp | "B 4" |
| 2 | g | "U 4" |
| 2 | g1 | "B 3" |
| 3 | Axis A Ver | "U 6 B 5" |
| 3 | ″P | "B 3" |
| 3 | pp | "U 4" |
| 3 | g | "B 4" |
| 3 | g1 | "U 3" |
| 4 | Axis A Ver | "U 5 B 6" |
| 4 | ″P | "U 3" |
| 4 | pp | "B 4" |
| 4 | g | "U 4" |
| 4 | g1 | "B 3" |
| 4 | ′P | "U 3" |
| 4 | ′p′p | "B 3" |

### F/022

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "U 5 B 6" |
| 1 | ″P | "U 3" |
| 1 | pp | "B 4" |
| 1 | g | "U" (no figure) |
| 1 | g1 | "B 3" |
| 1 | ′P | "U 3" |
| 1 | ′p′p | "B 3" |
| 2 | Axis A Ver | "U 6 B 7" |
| 2 | pp | "U 4" |
| 2 | g1 | "U 3" |
| 2 | Axis B Ver | "B 5" |
| 2 | ′p′p | "U 3" |
| 2 | ′g3 | "B 2" |
| 2 | ′S1 | "B 3" |
| 2 | A₂ Ver | "B 7" |
| 2 | S1 | "B 9" |
| 3 | Axis A Ver | "U 7 B 5" |
| 3 | ″P | "B 3" |
| 3 | g | "B 4" |
| 3 | Axis B Ver | "U 5" |
| 3 | ′p′p | "B 4" |
| 3 | ′g | "U 1" |
| 3 | ′S1 | "U 3" |
| 3 | A₂ Ver | "U 7" |
| 3 | S1 | "U 9" |
| 4 | Axis A Ver | "U 5 B 6" |
| 4 | ″P | "U 3" |
| 4 | pp | "B 4" |
| 4 | g | "U 4" |
| 4 | g1 | "B 3" |
| 4 | ′P | "B 4" |
| 4 | ′p′p | "U 4" |

Band 2 also has the words "…[?the] axes are bolted" written across the margin
and row-number column at the label row (start not legible in the strip).

### F/023

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "U 5 B 6" |
| 1 | ″P | "U 3" |
| 1 | pp | "B 4" |
| 1 | g | "U 4" |
| 1 | g1 | "B 3" |
| 1 | ′P | "B 4" |
| 1 | ′p′p | "U 4" |
| 2 | Axis A Ver | "U 6 B 8" |
| 2 | pp | "U 4" |
| 2 | g1 | "U 3" |
| 2 | Axis B Ver | "B 6" |
| 2 | ′P | "U 4" |
| 2 | ′g | "B 1" |
| 2 | ′S′S | "B 3" |
| 2 | A₂ Ver | "B 8" |
| 2 | SS | "B 9" |
| 3 | Axis A Ver | "U 8 B 5" |
| 3 | ″P | "B 3" |
| 3 | g | "B 4" |
| 3 | ′P | "B 3" |
| 3 | ′g3 | "U 2" |
| 3 | ′S′S | "U 3" |
| 3 | A₂ Ver | "U 8" |
| 3 | SS | "U 9" |
| 4 | Axis A Ver | "U 5 B 6" |
| 4 | ″P | "U 3" |
| 4 | pp | "B 4" |
| 4 | g | "U 4" |
| 4 | g1 | "B 3" |

On F/023 the band-2 labels to the right are in ′S′S and SS where F/022 and
F/024 have them in ′S1 and S1; the column was checked against the head at
1/2 scale (confidence: high for F/023 band 2; medium for band 3, where the
columns were placed by ruling only).

### F/024

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "U 5 B 6" |
| 1 | ″P | "U 3" |
| 1 | pp | "B 4" |
| 1 | g | "U 4" |
| 1 | g1 | "B 3" |
| 2 | Axis A Ver | "U 6 B 5" |
| 2 | ″P | "B 3" |
| 2 | pp | "U.4" (point between, as written) |
| 2 | g | "B 4" |
| 2 | g1 | "U 3" |
| 2 | ′P | "U 3" |
| 2 | ′p′p | "B 3" |
| 3 | Axis A Ver | "U 5 B 7" |
| 3 | ″P | "U 3" |
| 3 | g | "U.4" (point between) |
| 3 | Axis B Ver | "B 5" |
| 3 | ′p′p | "U" (no figure) |
| 3 | ′g3 | "B 2" |
| 3 | ′S1 | "B 3" |
| 3 | A₂ Ver | "B 7" |
| 3 | S1 | "B 9" |
| 4 | Axis A Ver | "U 7 B 6" |
| 4 | pp | "B 4" |
| 4 | g1 | "B 3" |
| 4 | Axis B Ver | "U 5" |
| 4 | ′p′p | "B 4" |
| 4 | ′g | "U 1" |
| 4 | ′S1 | "U 3" |
| 4 | A₂ Ver | "U 7" |
| 4 | S1 | "U 9" |

## 3. F/026–029, "Square root", 15 Jan 1836

**Layout.** Each sheet is photographed in two overlapping halves. Band rules
(y, ±30): 1110–1145, 2805–2850, 4490–4545, 6150–6240. Under each rule one
ruled row holds both "2/3" and "1" (the label is written at its top, row 1's
marks below); rows 2–15 follow and "1/3" closes the band. Bands 1–3 are full;
band 4 is cut off at the foot after the 2/3–1 row (on F/026 band 4's rule is
partly over the paper's lower edge). Row numbers are at the **right** edge of
the right half.

**Heads (F/026, read at 1/2 scale; the column scheme is the same on F/027–029,
checked by overlaying the rulings of each half at 1/2 scale).** Left to right
(the names in this list are as written; where a head spans several columns
the group word is given once):

left half (292): [first two columns, heads read as "N" and "R" [?]];
"Axis A" Ver, Cir; "Figure wheels" N.º 1, 2, 3, 4; P; pp; "Carriage a";
ap; g; g1; O; T; "Axis a" Ver, Cir; "Axis a10"; "Figs on Axis A" (with the
note "Lowest posit.ⁿ 000" in band 1); [two columns read as "N2", "R2" [?]];
"Axis C" Ver, Cir; four columns [? figure wheels of C, read as "C1"–"C4"];
″P; ″p″p; "Carriage c"; [cp [?]]; ″g; ″g1; "O4"; "T4"; "Axis c" Ver, Cir;
"Axis c10"; "Figs on Axis C"; heavy rule; one column without head; a second
"Axis C" group (written with a small "B" above the C on F/029 [?]) Ver, Cir,
"Fig wh." 1, 2, ″P, ″p″p, "Carriage c", ″g, ″g1 (called **D-** below: D-C Ver,
D-″P, …); then on the right half (293): "O2 ca", "T2 cs"; under "Divisor N.º 1
Trans.ʳ": "Axis V1" Ver, Cir; J1; "Carriage" ′c; ″g2; ″g3; "O3 ′ca"; "T3 ′cs";
under "Divisor N.º 2 Trans.ʳ": "Axis V2" Ver, Cir; J2; ′S′S; ′S1; "Wire axes";
"Figs on Div axis"; heavy rule; "R1"; "Axis A" Ver, Cir (called **QA**);
"Figure wheels" N.º 3, 4; SS; S1; "Cages where the quotient is registered" n,
n−1, n−2; then:

- **F/026 and F/027**: "Platforms" — "Long time", "Short time"; "Bolting to
  plat forms"; the row-number column.
- **F/028 and F/029**: no platform or bolt heads; after n−2 come unheaded
  columns (four on F/029) and the row numbers.

Confidence on the heads: medium. They were read at 1/2 scale only, several
are small and abbreviated, and the group names in brackets are doubtful.
Labels below are placed by column ruling counted from these heads.

**Platform heads.** F/026 and F/027 have two platform columns, headed only
"Long time" and "Short time" under "Platforms": **no number and no signed
lift is written** in the head or in the 2/3 rows. F/028 and F/029 have none.

### F/026

| Band | Column | Label as written |
|---|---|---|
| 1 | g1 | "B 1" |
| 1 | O | "B" |
| 2 | Axis A Ver | "B 5" |
| 2 | P | "B.3" (point between) |
| 2 | ap | "B 4" |
| 2 | g | "B 2" |
| 2 | g1 | "U 1" |
| 2 | O | "U" |
| 2 | ″g1 | "B 1" |
| 2 | O4 | "B" |
| 2 | D-″P | "B 3" |
| 2 | D-″g | "B 1" |
| 2 | cs (T2) | "B" |
| 2 | J1 | "B 4" |
| 3 | Axis A Ver | "U 5" |
| 3 | P | "U 3" |
| 3 | ap | "U 4" |
| 3 | O | "B" |
| 3 | Axis C Ver | "B 5" |
| 3 | ″P | "B 3" |
| 3 | cp | "B 4" |
| 3 | ″g | "B 2" |
| 3 | ″g1 | "U 1" |
| 3 | O4 | "U" |
| 3 | V1 Ver | "B 6" |
| 3 | J1 | "U 4" |
| 3 | J2 | "B 4" |
| 4 | Axis A Ver | "B 6" |
| 4 | pp | "B 4" |
| 4 | ap | "B 4" |
| 4 | g | "U 2" |
| 4 | g1 | "B 1" |
| 4 | O | "U" |
| 4 | Axis C Ver | "U 5" |
| 4 | ″P | "U 3" (a dot under the 3) |
| 4 | cp | "U.4" (point between) |
| 4 | O4 | "B" |
| 4 | V1 Ver | "U 6" |
| 4 | J1 | "B 4" |
| 4 | V2 Ver | "B 6" |
| 4 | J2 | "U" |

Band 1 has the notes "Lowest posit.ⁿ 000" in the Axis a10 / Figs-on-A and
Axis c10 / Figs-on-C columns (not labels).

### F/027

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "B 6" |
| 1 | pp | "B 4" |
| 1 | ap | "B 4" |
| 1 | g | "U 2" |
| 1 | g1 | "B 1" |
| 1 | Axis C Ver | "U 5" |
| 1 | ″P | "U" (no figure) |
| 1 | cp | "U 4" |
| 1 | J1 | "B 4" |
| 1 | V2 Ver | "B 6" |
| 2 | Axis A Ver | "U 6" |
| 2 | pp | "U 4" |
| 2 | ap | "U 4" |
| 2 | O | "B" |
| 2 | ″g | "U 2" |
| 2 | O4 | "U" |
| 2 | Axis c10 | "B" |
| 2 | V1 Ver | "B 6" |
| 2 | V2 Ver | "U 6" |
| 3 | Axis A Ver | "B 7" |
| 3 | ″g1 | "B 2" |
| 3 | T4 | "B" |
| 3 | D-C Ver | "B 5" |
| 3 | D-″P | "U" |
| 3 | V1 Ver | "U 6" |
| 3 | J1 | "U 4" |
| 3 | ″g3 | "B 2" |
| 3 | ′S1 | "B 3" |
| 3 | QA Ver | "B 7" |
| 3 | S1 | "B 9" |
| 4 | Axis A Ver | **"U 7" over "B 5"** (stacked; the U 7 written on the band rule) |
| 4 | P | "B 3" |
| 4 | ap | "B 4" |
| 4 | g | "B 2" |
| 4 | g1 | "U 1" |
| 4 | O | "U" |
| 4 | ″g | "B 4" |
| 4 | ″g1 | "U 2" |
| 4 | O4 | "B" |
| 4 | T4 | "U" |
| 4 | D-C Ver | "U 5" |
| 4 | D-″p″p | "B 4" |
| 4 | D-″g | "U 1" |
| 4 | J1 | "B 4" |
| 4 | ′S1 | "U 3" |
| 4 | QA Ver | "U 7" |
| 4 | S1 | "U 9" |

Not labels: the word "[?pre]vented" written over the rule in the D-Carriage c
column (bands 2–3), "Put back" written across V1 Ver / V1 Cir in band 3's
row 1, and "[?Step]" after Figs on A in band 4.

### F/028

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "B 5" |
| 1 | P | "B 3" |
| 1 | ap | "B 4" |
| 1 | g | "B 2" |
| 1 | ″g | "B 4" |
| 1 | O4 | "B" |
| 1 | D-C Ver | "U 5" |
| 1 | D-″p″p | "B 4" |
| 1 | J1 | "B 4" |
| 1 | ′S1 | "U 3" |
| 1 | QA Ver | "U 5" |
| 1 | S1 | "U 9" |
| 2 | Axis A Ver | "U 5" |
| 2 | P | "U 3" |
| 2 | ap | "U 4" |
| 2 | O | "B" |
| 2 | ″g | "U 4" |
| 2 | O4 | "U" |
| 2 | Axis c10 | "B" |
| 2 | V1 Ver | "B 6" |
| 3 | Axis A Ver | "B 8" |
| 3 | ″g1 | "B 2" |
| 3 | T4 | "B" |
| 3 | D-C Ver | "B 6" |
| 3 | D-″p″p | "U" |
| 3 | D-″g | "B 1" |
| 3 | V1 Ver | "U 6" |
| 3 | J1 | "U 4" |
| 3 | ′S′S | "B 3" |
| 3 | QA Ver | "B 8" |
| 3 | SS | "B 9" |
| 4 | Axis A Ver | **"U 8" over "B 6"** (stacked) |
| 4 | pp | "B 4" |
| 4 | ap | "B 4" |
| 4 | g | "U" |
| 4 | g1 | "B 1" |
| 4 | O | "U" |
| 4 | ″g | "B 4" |
| 4 | ″g1 | "U 2" |
| 4 | O4 | "B" |
| 4 | T4 | "U" |
| 4 | D-C Ver | "U 6" |
| 4 | D-″P | "B 3" |
| 4 | J1 | "B 4" |
| 4 | ′g3 [? ″g3] | "U 2" |
| 4 | ′S′S | "U 3" |
| 4 | QA Ver | "U 8" |
| 4 | SS | "U 9" |

The SS/S1 column of the last two labels in each band was checked against the
head at full resolution: band 1 "U 9" is in **S1**, bands 3–4 in **SS**.
Bands 2–4 were read from strips laid out with provisional column names; the
assignments to ″g/″g1/O4/T4 and to D-columns are medium confidence.

### F/029

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis A Ver | "B 6" |
| 1 | pp | "B 4" |
| 1 | ap | "B 4" |
| 1 | g | "U 6" |
| 1 | g1 | "B 1" |
| 1 | O | "U" |
| 1 | ″g | "B 4" |
| 1 | ″g1 | "U 2" |
| 1 | O4 | "B" |
| 1 | T4 | "U" |
| 1 | D-C Ver | "U 6" |
| 1 | D-″P | "B 3" |
| 1 | J1 | "B 4" |
| 1 | ″g3 | "U 2" |
| 1 | ′S′S | "U 3" |
| 1 | QA Ver | "U" + a large ink blot over where a figure would be (figure illegible) |
| 1 | SS | "U 9" |
| 2 | Axis A Ver | "U" (no figure) |
| 2 | pp | "U 4" |
| 2 | ap | "U 4" |
| 2 | O | "B" |
| 2 | Axis C Ver | "B 6" |
| 2 | ″p″p | "B 4" |
| 2 | cp | "B 4" |
| 2 | ″g | "U" |
| 2 | ″g1 | "B 3" |
| 2 | O4 | "U" |
| 2 | V1 Ver | "B 6" |
| 2 | J1 | "U" |
| 2 | J2 | "B 4" |
| 3 | g1 | "U" |
| 3 | O | "U" |
| 3 | O4 | "B" |
| 3 | D-″p″p | "B 3" |
| 3 | V1 Ver | "U 6" |
| 3 | V2 Ver | "B.6" (point between) |
| 4 | g | "B 1" |
| 4 | T | "B" |
| 4 | Axis a10 | "B" |
| 4 | D-C Ver | "B 5" |
| 4 | D-″P | "U" |
| 4 | ″g3 | "B 2" |
| 4 | V2 Ver | "U.6" (point between) |
| 4 | J2 | "U 4" |
| 4 | ′S1 | "B 3" |
| 4 | QA Ver | "B [?7]" (the figure partly under an ink blot) |
| 4 | S1 | "B 9" |

The last label of bands 1 and 4 was checked against the head at full
resolution: band 1 "U 9" in **SS**, band 4 "B 9" in **S1**.

### Platform columns of F/026 and F/027

The Long-time, Short-time and Bolting columns were read **full height** at
full resolution on both sheets. They are **empty**: no arrow, figure or label
in any row of any band.

| Sheet | Band | Platform | Motion | Return row |
|---|---|---|---|---|
| F/026 | 1–4 | Long time | none | none |
| F/026 | 1–4 | Short time | none | none |
| F/027 | 1–4 | Long time | none | none |
| F/027 | 1–4 | Short time | none | none |

## 4. F/032, "Ordinary cycle of 16", 18 Jan 1836

**Layout.** One table (image 311) with "(32)" at top right. Three label rows,
at band rules y ≈ 704, 2384, 4080. As on the square-root sheets, "1/3" is
written above the rule and one ruled row under it holds "2/3" and "1". Rows
2–15 follow, then "1/3" at the next rule. The row numbers 2–15 are in ink over
fainter pencil numbers 1–14 written one place to the left (renumbered). Band 3
runs to the foot of the table with no further label row.

**Heads (1/2 scale).** Row numbers (x 28–233); "Axis A" Ver, Cir; "Figure
wheel" N.º 1, N.º 2; two columns, no head; "Cen.ˡ pinion pp"; "Cent pin.ⁿ ″P"
[the P with a double-prime-like mark]; "Cen pin.ⁿˢ ap"; "Carr.ᵉ pin.ⁿ g";
"Carr.ᵉ pin.ⁿ g1"; "Fig wh. N.º 1 on B"; one column, no head; "Cen pinion
′p′p"; "Carr b"; "Carr.ᵉ pin.ⁿ ′g1"; "Wire Axes E"; "Lock Cent.ˡ"; "Lock
Fig wh."; "Lock Carr.ᵉ"; "Platforms" — "Long time", "Short time"; "Bolt to
Plat-forms"; three columns, no head. Titles: "Give off from A and ~~reserve~~
retain" [?] over the pinion columns, "Receive upon N.º 1 upon B" over ′p′p–′g1.

**Platform heads.** Two platform columns, "Long time" and "Short time", **no
number and no signed lift written.**

| Band | Column | Label as written |
|---|---|---|
| 1 | Cen pin. ap | "L 4" |
| 1 | Cen pinion ′p′p | "L N.º 3" |
| 1 | Carr. pin. ′g1 | "L N.º 3" |
| 1 | Lock Cent. | "U" (written low in the cell, at row-1 height, beside a short arrow) |
| 1 | Lock Fig wh. | "U" (as above) |
| 1 | Lock Carr. | "U" (as above) |
| 2 | Axis A Ver | "U 5 B 6" |
| 2 | Cen. pinion pp | "L 4" |
| 2 | Cent pin. ″P | "U 3" |
| 2 | Carr. pin. g | "U 4" |
| 2 | Carr. pin. g1 | "L 3" |
| 2 | Lock Cent. | "U" (as band 1) |
| 2 | Lock Fig wh. | "U" |
| 2 | Lock Carr. | "U" |
| 2 | Bolt to Platforms | "B&U" (the & small, like ×; beside a short down arrow) |
| 3 | Axis A Ver | "U 6 B 5" |
| 3 | Cen. pinion pp | "U 4" |
| 3 | Cent pin. ″P | "B 3" |
| 3 | Carr. pin. g | "B 4" |
| 3 | Carr. pin. g1 | "U 3" |
| 3 | Lock Cent. | "U" |
| 3 | Lock Fig wh. | "U" |
| 3 | Lock Carr. | "U" |
| 3 | Bolt to Platforms | "B&U" (beside a short down arrow) |

Band 1 has no label in Axis A Ver or the Bolt column. "L" (lock?) labels are
new here; they are recorded as written.

**Platform motions** (full height, full resolution).

| Band | Platform | Motion | Return row |
|---|---|---|---|
| 1 | Long time | row 1: an up arrow and a down arrow side by side (↑ ↓), no figures | row 15, running into the 1/3 row and ending on the next band rule: a down arrow with a double head and an up arrow with a double head side by side; no figures |
| 1 | Short time | row 1: ↑ ↓ side by side, no figures | row 12: double-headed down and double-headed up side by side; no figures |
| 2 | Long time | row 1: ↑ ↓, no figures | row 15 / 1/3 (as band 1) |
| 2 | Short time | row 1: ↑ ↓, no figures | row 12 (as band 1) |
| 3 | Long time | row 1: ↑ ↓, no figures | none to the foot of the table |
| 3 | Short time | row 1: ↑ ↓, no figures | none to the foot of the table |

"Return" here means the pair of double-headed arrows; whether this is the
same mark as the "double-headed return arrow" of F/013 is for the reader to
judge.

## 5. F/033, "Notation of carriage", 25 Jan 1836 (additions to 23–26 Mar 1836)

**Layout.** Image 316 holds two tables, one above the other. Each is a set of
column **groups**, one per operation, each headed in words, with the
sub-heads (letter over "Ver"/"Cir") written above a rule. Rows are numbered
in a column at the left (x ≈ 250–440): "1/3" above the rule, then "2/3" and
"1" in the first ruled row, rows 2–15, then "1/3", "2/3", "1" again.

- **Upper table** (dated "25 Jan.ʸ 1836" in the head): label row 1 under the
  head rule (y ≈ 840); label row 2 at the 2/3 after row 15 (y ≈ 2520). In the
  last group the second label row is one row lower (under the next rule,
  y ≈ 2670), and a label is written at about row 11.
- **Lower table** (heads y ≈ 3300–4190; "Commencement of cycle altered 23 March
  1836" below it): label row 1 at y ≈ 4190; a short sub-table "If reducing to
  zero be done in the cycle of 12 the times will be as follows" has an end
  label row after its row 12 (y ≈ 5440); label row 2 at y ≈ 5900; in four
  groups a further label is written one row lower (y ≈ 6070) and in three
  groups a label at about row 11 (y ≈ 5380).

There are **no platform columns** on F/033.

**Heads, upper table (1/2 scale, confirmed against the full-resolution label
strips).** x on 316: row numbers 254–442; **"Reduce to Zero preparatory to
Add.ⁿ"**: "a" Ver 442–630, Cir 630–824, "a" Ver 824–1020; **"Reduce to Zero
preparatory to Sub.ⁿ"**: "a" Ver 1020–1217, Cir 1217–1409, "a 10" Ver
1409–1598; **"Rec. figs thro' upper Cen."**: "ap" Ver 1598–1790, "O" Ver
1790–1986; **"Rec. figs thro' lower Cen."**: "ap" Ver 1986–2176, "O" Ver
2176–2368; **"Rec. fig or Add not thro' Cent."**: "O" Ver 2368–2869;
**"Rec. Add.ⁿ thro' upper Cent.ˡ"**: "ap" Ver 2869–3064, "O" Ver 3064–3255;
**"Rec. Add thro' lower Cent.ˡ"**: "ap" Ver 3255–3444, "O" Ver 3444–3645;
**"Suff. Sub thro' Up Cent.ˡ"**: "ap" Ver 3645–3831, "T" Ver 3831–4028;
**"Suff. Sub thro' Low Cent.ˡ"**: "ap" Ver 4028–4225, "T" Ver 4225–4413;
**"Suff. Sub.ⁿ not thro' Cent.ˡ"**: "T" Ver 4413–4790; **"Change fig. from
Add.ᵈ to Sub.ⁿ"** (headed also "Z" [?]): "a" Ver 4790–4973, Cir 4973–5164,
"a 10" Ver 5164–5429.

| Band | Column | Label as written |
|---|---|---|
| U1 | Red. Zero prep. Add — a Ver | "B 7" |
| U1 | Red. Zero prep. Add — a Ver (3rd col.) | "B" |
| U1 | Red. Zero prep. Sub — a Ver | "B 8" |
| U1 | Red. Zero prep. Sub — a 10 Ver | "B" |
| U1 | Rec. figs upper — ap Ver | "B 4" |
| U1 | Rec. figs upper — O Ver | "B" |
| U1 | Rec. figs lower — ap Ver | "B 9" |
| U1 | Rec. figs lower — O Ver | "B" |
| U1 | Rec. not thro' Cent — O Ver | "B" |
| U1 | Rec. Add upper — ap Ver | "B 2" |
| U1 | Rec. Add upper — O Ver | "B" |
| U1 | Rec. Add lower — ap Ver | "B 11" |
| U1 | Rec. Add lower — O Ver | "B" |
| U1 | Suff. Sub up — ap Ver | "B 2" |
| U1 | Suff. Sub up — T Ver | "B" |
| U1 | Suff. Sub low — ap Ver | "B 11" |
| U1 | Suff. Sub low — T Ver | "B" |
| U1 | Suff. Sub not thro' — T Ver | "B" |
| U1 | Change fig Add→Sub — a 10 Ver | "B" |
| U-mid (≈ row 11) | Change fig Add→Sub — a Ver | "B 7" |
| U2 | Red. Zero prep. Add — a Ver | "U 7" |
| U2 | Red. Zero prep. Add — a Ver (3rd col.) | "U" |
| U2 | Red. Zero prep. Sub — a Ver | "U" (no figure) |
| U2 | Red. Zero prep. Sub — a 10 Ver | "U" |
| U2 | Rec. figs upper — ap Ver | "U 4" |
| U2 | Rec. figs upper — O Ver | "U" |
| U2 | Rec. figs lower — ap Ver | "U 9" |
| U2 | Rec. figs lower — O Ver | "U" |
| U2 | Rec. not thro' Cent — O Ver | "U" |
| U2 | Rec. Add upper — ap Ver | "U 2" |
| U2 | Rec. Add upper — O Ver | "U" |
| U2 | Rec. Add lower — ap Ver | "U 11" |
| U2 | Rec. Add lower — O Ver | "U" |
| U2 | Suff. Sub up — ap Ver | "U 2" |
| U2 | Suff. Sub up — T Ver | "U" |
| U2 | Suff. Sub low — ap Ver | "U 11" |
| U2 | Suff. Sub low — T Ver | "U" |
| U2 | Suff. Sub not thro' — T Ver | "U" |
| U2 (one row lower) | Change fig Add→Sub — a Ver | "U 7" |
| U2 (one row lower) | Change fig Add→Sub — a 10 Ver | "U" |

No label in the Cir columns of the upper table in either label row.

**Heads, lower table (1/2 scale).** x on 316 (from the rulings of the label
strip, ±40): row numbers 294–465; **"Change fig wheel from Sub.ⁿ to Add.ᵈ"**
(headed "x"): "a" Ver 465–653, Cir 653–848, "a 10" Ver 848–1044; **"x"
"a different time for"**: "a 10" Ver 1044–1242; **"y"**: "a 10" Ver
1242–1433; **"Reduce to Zero after Add.ⁿ prep.ʸ to Add.ⁿ"**: "a" Ver
1433–1626; **"Reduce to Zero after Sub.ⁿ preparatory to Sub.ⁿ"**: "a" Ver
1626–1822; **"Carry"**: "Axis G" Ver 1822–2022, Cir 2022–2213 (with
"180°", "28½" and "Carry" written in it), "Wire Axis E Ver" 2213–2404;
**"Reduce to Zero after Add.ⁿ preparatory to Sub.ⁿ"**: "a" Ver 2404–2600, "a
10" Ver 2600–2798; one narrow column, no head (2798–2965); under "If reducing
to zero be done in the cycle of 12 …": **"Preparatory to Addition"**: "a" Ver
2965–3110, Cir 3110–3303, "a 10" Ver 3303–3494; **"Preparatory to
Subtraction"**: "a" Ver 3494–3692, Cir 3692–3880, "a 10" Ver 3880–4079;
**"Reduce to Zero after Sub.ⁿ prep.ʸ to Addition"**: "a" Ver 4079–4274, "a
10" Ver 4274–4469; **"Change fig wheel from Add.ⁿ to Sub.ⁿ"**: "a" Ver, Cir,
"a 10" Ver (4469–4940); **"Change fig wheel from Sub.ⁿ to Addition"**: "a"
Ver, Cir, "a 10" Ver (4940–5468).

| Band | Column | Label as written |
|---|---|---|
| L1 | Ch. fig Sub→Add — a 10 Ver | "B" |
| L1 | Red. Zero after Add prep. Add — a Ver | "B 7" |
| L1 | Red. Zero after Sub prep. Sub — a Ver | "B 8" |
| L1 | Red. Zero after Add prep. Sub — a Ver | "B 8" |
| L1 | Red. Zero after Add prep. Sub — a 10 Ver | "B" |
| L1 | Prep. to Addition — a Ver | "B 7" |
| L1 | Prep. to Addition — a 10 Ver | "B" |
| L1 | Prep. to Subtraction — a Ver | "B 8" |
| L1 | Prep. to Subtraction — a 10 Ver | "B" |
| L1 | Red. Zero after Sub prep. Add — a Ver | "B 7" |
| L1 | Red. Zero after Sub prep. Add — a 10 Ver | "B" |
| L-mid (≈ row 11) | Ch. fig Sub→Add — a Ver | "B 7" |
| L-mid (≈ row 11) | "x" a 10 Ver | "B 9" |
| L-mid (≈ row 11) | "y" a 10 Ver | "B 4" |
| L-mid (≈ row 11) | Ch. fig Add→Sub — a Ver | "B 7" |
| L12 (end of cycle-of-12 sub-table) | Prep. to Addition — a Ver | "U 7" |
| L12 | Prep. to Addition — a 10 Ver | "U" |
| L12 | Prep. to Subtraction — a Ver | "U 8" |
| L12 | Prep. to Subtraction — a 10 Ver | "U" |
| L2 | "x" a 10 Ver | "U 9 B 4" |
| L2 | "y" a 10 Ver | "U 4 B 9" |
| L2 | Red. Zero after Add prep. Add — a Ver | "U 7" |
| L2 | Red. Zero after Sub prep. Sub — a Ver | "U 8" |
| L2 | Red. Zero after Add prep. Sub — a Ver | "U 8" |
| L2 | Red. Zero after Sub prep. Add — a Ver | "U 7" |
| L2 (one row lower) | Ch. fig Sub→Add — a Ver | "U 7" |
| L2 (one row lower) | Ch. fig Sub→Add — a 10 Ver | "U" |
| L2 (one row lower) | "x" a 10 Ver | "U 4" |
| L2 (one row lower) | "y" a 10 Ver | "U 9" |
| L2 (one row lower) | Ch. fig Add→Sub — a Ver | "U 7" |

No label in the Carry columns, the Cir columns, or the "Change fig wheel from
Sub.ⁿ to Addition" group. Not labels: the memoranda dated 26 March in the
x/y and Reduce-to-Zero columns, "Done in the above times to suit [?]", "N.B.
The boxes on G must have double sets of arms" [?], and the struck crosses
along the foot (read at 1/4 only).

Confidence: the labels themselves are clear at full resolution (the "U 8" of
Red. Zero after Add prep. Sub was checked at 2× because it looks like "U 2" at
1/8). Column assignment in the lower table is medium where the strip's
rulings drift (about 20–40 px); each label above was placed by the ruling
nearest it and by the head over it.

## 6. Summary for the test

| Sheet | Platform columns | Platform heads (number / lift) | Label rows | Labels containing "B k" (k a figure) | Bare "B" | Other |
|---|---|---|---|---|---|---|
| F/021 | no | — | 4 | 16 | 2 | — |
| F/022 | no | — | 4 | 18 | 0 | — |
| F/023 | no | — | 4 | 17 | 0 | — |
| F/024 | no | — | 4 | 17 | 0 | — |
| F/026 | Long time, Short time (empty) | none written | 4 | 21 | 5 | — |
| F/027 | Long time, Short time (empty) | none written | 4 | 21 | 4 | one stacked "U 7" over "B 5" |
| F/028 | no | — | 4 | 22 | 5 | one stacked "U 8" over "B 6" |
| F/029 | no | — | 4 | 21 | 5 | QA Ver band 4 "B [?7]" blotted (counted) |
| F/032 | Long time, Short time (arrows, no figures) | none written | 3 | 4 | 0 | 2 "B&U"; 5 "L" labels |
| F/033 | no | — | 2 + 2 (+ off-row labels) | 21 | 16 | "U 9 B 4", "U 4 B 9" |

(Counts are of table rows above that contain a "B" followed by a figure,
counting each "U j B k" and stacked pair once; "Bare B" are labels "B" with no
figure. "U&B"/"B&U" are not counted.)

**What a test can and cannot use.** None of these sheets writes a platform
**number or lift** in its head, so the platform hypothesis P of
`docs/f-bu-audit.md` cannot map "B k" to a lift from the sheet itself; any
prediction must take the lifts from F/013 (or F/015–016) and say so. F/021–024,
F/028–029 and F/033 have no platform columns at all. On F/026–027 the platform
columns are empty; on F/032 they carry arrows without figures. The labels of
F/026–029 and F/033 use figures 1–11, outside the
F/013 labels' range (3–10) at both ends: "B 11" on F/033, and "B 1" and "B 2" are common
on the square-root sheets.
