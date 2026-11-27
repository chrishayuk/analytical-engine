# Two rechecks, and the labels of a held-out sheet

Read by a coding agent from the Science Museum Group images, 27 November
2026. **No person has checked these readings.** This note does not change any
transcription (`mechanical/*.txt`, `sources/notes/F0*.md`); where a reading
here differs from one there, both stand until a person looks.

It does two things for the platform hypothesis P of `docs/f-bu-audit.md`
("B k" = the part in that column bolted to travelling platform k; platform k
has the lift F/013's heads give it):

1. rereads at full resolution the two cells the provisional platform model
   misses (F/013 band 5 t23; F/018 cycle 3 e34);
2. lists the Series F sheets of 1835–1837, says which carry B/U labels *and*
   motion arrows with figures, and records the **labels and heads only** of
   the held-out sheets F/015 and F/016, so that a prediction can be written
   down before anyone reads their arrows.

**Method.** As in `bolting-plates-sources.md`: aligned 512 × 512 tiles of the
IIIF zoom image (`https://zoom.sciencemuseumgroup.org.uk/iiif/3/<zoom path>`),
fetched one at a time about 3.5 s apart and stitched with PIL. Scale 1 is full
resolution; scale 2, 4, 8 are tiles of 1024, 2048, 4096 px served at 512.
No request was refused (no 403). The collection search API returned 429
after about 165 catalogue queries in a row; the catalogue fetch stopped there
(past the 1835–1837 range). Regions are (x, y, w, h) in full-resolution
pixels of the stored zoom image. Crops were kept in the session scratchpad
only. Conventions as in `F013.md`: `[?x]` doubtful, `~~x~~` struck.

## 1. F/013 band (5), column t23 (′S1 Ver)

Image 216/259 (`216/259/Babbage_Papers__Table_Multiplication_1836_Jan_5.ptif`),
read from the full-resolution stitch already on disk
(`../downloads/smg/F/F013/s259/`, all 266 tiles at scale 1), enlarged 3–6×,
with and without a contrast stretch. Band (5) is the "2/3" row (y 6465–6557)
and row 1 (y 6557–6652) after band 4; t23 is x 4665–4855.

**The label, region (4665, 6465, 195, 80).** Observation: **"U 9 B 3"**,
written as one line in the "2/3" row. The "U" is light; the "9" is in
markedly heavier, darker ink than the U, the B and the 3; "B 3" is in the
same weight as the U. The 3 is the flat-topped form this hand uses for
other 3s on the sheet (e.g. t07, same row, "B N.<sup>o</sup> 3"; t22 band 3,
"U 9 B 3"). **It is "B 3".** Confidence: high.

**The figure in row 1, region (4735, 6545, 125, 100).** Observation:

- an up arrow at x ≈ 4705, from the rule under row 1 to the top of row 1;
- right of it, **".6"**: a point written as a short horizontal dash at about
  (4770, 6588), then a "6" (x ≈ 4790–4835, y ≈ 6555–6625) in **heavy, dark
  ink**, closed bowl, stem rising to the right. The point and the 6 are
  unambiguous;
- left of the point, **a faint thin oblique stroke** (about x 4740–4770,
  y 6553–6600), rising to the right, grey and much lighter than any ink in the
  cell. Under contrast stretch it is one stroke, with no point, curve or
  second stroke attached;
- nothing is visible under or beside the 6 (no second "1", no erasure
  showing); a pale vertical line through the cell at x ≈ 4810 runs the whole
  height of the sheet and is a crease or ruling, not a mark.

The faint stroke has the slant and length of the "1"s in this hand's
"1.1", which elsewhere on the sheet are thin strokes (t07 band 5, t22 and t25
band 3), but it is fainter than those. It could be the "1" of a figure
written lightly and then overwritten or abandoned, a pencil stroke, or a stray
mark. The ink does not decide between these.

**Reading.** What is written in ink is **".6"**, with certainty. It agrees
with the transcription's ".6"; the transcription's "[?.6]" and "[?1.6]"
flag the faint stroke, and that doubt is about the stroke, not the ".6".
The figure written is **not 1.1**. The ".6" (with the "9" of the label) is in
heavier ink than the other figures of band (5), which is consistent with it
having been written at another time or with another pen, but nothing shows
what, if anything, it replaced. **The model's miss stands as a miss**; the
cell is not evidence for P, and the faint stroke is not read as "1.1".

## 2. F/018 cycle 3, column e34 (R2), rows 15–16

Image 216/271 (`216/271/Babbage_Papers__Multiplication_without_Table_1836_Jan_11.ptif`,
9387 × 6438). Four tiles were fetched afresh at full resolution (columns
11–12, rows 11–12: x 5632–6656, y 5632–6438), which also cover the left
edge of e34 that the earlier full-scale crop (`F018/271/s1b3`, x ≥ 6144)
did not.

**The label, region (6140, 6040, 80, 45).** Observation: **"B 4"**. Clear.

**The figure, region (6136, 6080, 162, 125)** (row 16, down to the band rule
at y ≈ 6202). Observation: an up arrow at x ≈ 6170, and right of it a
**"6"** (x ≈ 6216–6246, y ≈ 6092–6166), a thin-stroked open-topped 6 in the
same ink as the label. **No point**: the space between the arrow head and the
6, and the space left of the 6 at the 6's mid-height, were searched at 5×
with a contrast stretch; the only marks are the arrow and the 6. The sheet's
other points in this row (e35 ".2") are clear dots of a size that would show.

**Comparison (not a correction).** F/019's partial rows above cycle 4 repeat
F/018 cycle 3's rows 14–16. Image 216/273, tiles columns 11–12, rows 0–2
(x 5632–6656, y 0–1536); region (6136, 940, 170, 180): e34 has **"B 4"**
over an up arrow and **".6"** with a clear point.

**Reading.** F/018 has "6" without a point, as transcribed; F/019's copy of
the same rows has ".6". Whether the missing point on F/018 is a slip is not
decided by the ink. **The transcription is confirmed as written, and the
model's miss stands as a miss** on F/018 (F/019's restatement agrees with
the model).

## 3. Series F, 1835–1837: which sheets could be held out

**Catalogue.** BAB/F is 388 sets, 16 March 1835 – 3 October 1846. Records
F/001–026 are in `../downloads/smg/F/F001-006.json` and `F007-116.json`
(which, despite its name, ends at F/026). F/027–F/193 were fetched from
the collection search (`https://collection.sciencemuseumgroup.org.uk/search/documents?q=BAB/F/NNN`)
into the scratchpad only. The last sheet of 1837 is F/076 ("Two cycles of 15
and 20", 26 Dec 1837); F/077 is 8 Jan 1838. Dates below are from the image
file names or cover writing (the records have no date field).

**How each sheet was looked at.** "q" = the table image whole at 1/4 scale;
"e" = every image of the record whole at 1/8 scale; "f" = label rows at full
resolution (section 4). At 1/8 a label such as "B3" is about 8 px high:
enough to see that labels exist, not to read them. **Looking at the 1/4 and
1/8 images showed arrows and figures**; none was recorded, and none is used
below (see section 5).

| Sheet | Title (catalogue) | Date | Looked at | B/U labels | Arrows with figures | Held-out candidate |
|---|---|---|---|---|---|---|
| F/001–002 | Multiplication before … table | 1835 | transcribed | no | yes | (transcribed) |
| F/003 | Division before division by table, sh. 1 | 16 Mar 1835 | q 338 | **no** | yes | no |
| F/004–006 | Division continued, sh. 2–4 | 16 Mar 1835 | q 379, 385, 387 | **no** | yes | no |
| F/007–009 | Extraction of square root, sh. 1–3 | 8 Apr 1835 | q 389, 390, 396, 399 | **no** | yes | no |
| F/010 | Extraction of square root, sh. 4 | 8 Apr 1835 | q 249 | **no** | yes | no |
| F/011–012 | Notation for lifters (division by table) | 15 Jun 1835 | q 252, 254 | **no** | few (words such as "Moved by A") | no |
| F/013 | Table multiplication | 5 Jan 1836 | transcribed | yes | yes | (transcribed) |
| F/014 | Bolting plates for multiplication by table | — | transcribed | yes | no | (transcribed) |
| **F/015** | **Table division** | **8 Jan 1836** | q 263, 264; f | **yes** | **yes** | **yes: labels in section 4** |
| **F/016** | **Table division** | **8 Jan 1836** | q 266, 267; f | **yes** | **yes** | **yes: labels in section 4** |
| F/017 | Table division ("Bolting Plates — Division by Table" written on the sheet) | 8 Jan 1836 | q 269 | yes | **no** (a schedule, like F/014) | no (a cross-check for F/015–016) |
| F/018–020 | Multiplication without table; bolting plates | 11 Jan 1836 | transcribed | yes | F/018–019 yes | (transcribed) |
| F/021–024 | Division without table, sh. 1–4 | 13 Jan 1836 | q 280, 282, 286, 288 | yes | yes | **yes; labels not read here** |
| F/025 | Bolting plates to divide without table | — | q 290 | yes | no | no (a schedule) |
| F/026–029 | Square root, sh. 1–4 | 15 Jan 1836 | q 292, 293; e 294–302 | yes | yes | **yes; labels not read here** |
| F/030–031 | Bolting plates to do square root, sh. 1–2 | 15 Jan 1836 | e 306–309 | [?yes] (not legible at 1/8) | no | no (schedules) |
| F/032 | Ordinary cycle of 16 | 18 Jan 1836 | e 310–311 | yes (also "L 4", "L 3") | yes | **yes; labels not read here** |
| F/033 | Notation of carriage | 25 Jan 1836 (additions 23 Mar 1836) | e 312–316 | yes (figures to 11) | yes | **yes; labels not read here** |
| F/034 | Notation for differences | — | e 317–318 | no | no (grid of 0, ×, O) | no |
| F/035 | Various sheets on division and multiplication | 16 Mar 1836 | e 319–320 | no B/U seen | no | no |
| F/036 | Part of a notation of division | 26 Mar 1836 | e 321–324 (only 322 viewed) | not determined | not determined | not determined |
| F/037 | Notation for division | 30 Mar 1836 | e 325–328 | labels of another form ("B1S", "UB2S", [?]) | no | no |
| F/038 | Notation for multiplication | 8 Apr 1836 | e 329–331 | labels of another form ("B1S", "UB2S") | no (rows of figures, ↕ in a margin) | no |
| F/039, F/042, F/044 | Notation for multiplication; for division; for square root | Apr–May 1836 | e 335, 348, 358 | labels of the F/038 form | no | no |
| F/040, F/041, F/043 | Barrels for multiplication; counting apparatus; cycles on barrels for division | Jun 1836 | e 339 (cover), 345 (cover), 352 | not determined (F/043: short arrows with small figures and words, not legible at 1/8) | not determined | not determined |
| F/045 | Barrels for square root | 6 Jun 1836 | e 362–364 | no | no | no |
| F/046–F/054 | Counting apparatus; 60-figure and 30-figure general notations; verticals on barrels; differences; addition and subtraction; printing differences; additions with signs | May–Aug 1836 | e (1–2 images each) | none of the January form; F/052 and F/054 have labels of the F/038 form | no (tables of figures, words, a few arrows without lifts) | no |
| F/055 | Copy of ordinary cycle of 16, No. 32 | — | e 417–418 | [?yes] (a copy of F/032; labels not legible at 1/8) | yes | **[?yes]; labels not read here** |
| F/056–F/059 | Verticals on barrels; multiplication; square root; counting by stepping | Jul 1836 – Feb 1837 | e (1–2 images each; F/057–058's main tables not seen) | not seen | no (rows of figures) | no, as far as seen |
| F/060, F/062 | Cycle of 16; cycle of 17 | Apr 1837 | e 446–447, 454–455 | no B/U label rows seen at 1/8 | arrows, a few with figures | not determined at 1/8 |
| F/061, F/063–F/066 | Notations of locking | Apr 1837 | e (2 images each) | no | arrows without lifts | no |
| F/067–F/071 | Notations of division, multiplication, square root; addition with signs | May–Jul 1837 | e (2 images each) | no B/U of the January form | no (rows of figures and words) | no |
| F/072, F/073, F/076 | Cycle of 20; cycles of 21 and 28; cycles of 15 and 20 | Aug–Dec 1837 | e (2 images each) | no | arrows without lifts | no |
| F/074, F/075 | Notation of multiplication with hoarded carriages; notation of division | 1837 | (no images in the records) | — | — | — |

Notes. F/036: only its cover (image 322) was viewed; the cover carries a
title and a memorandum. F/037–039, F/042, F/044: after March 1836 the multiplication and division
notations are written as rows of figures and labels of a different form
("B1S", "UB2S", "B2S" and the like), coloured by band, without the January
sheets' time rows of motion arrows; at 1/8 the letter after the figure could
not be read. These are another notation and are not candidates for this test.

Sheets not looked at in this pass, or only in part, are listed in
section 6.

## 4. Held-out labels (arrows not read)

**F/015 and F/016, "Table division", 8 January 1836** (`aa110000499`,
`aa110000500`). Each is photographed in two overlapping halves:

| Sheet | Image | Zoom path | Size (w × h) |
|---|---|---|---|
| F/015 | left half | `216/263/Babbage_Papers__Table_Division_1836_Jan_8.ptif` | 6141 × 6955 |
| F/015 | right half | `216/264/Babbage_Papers__Table_Division_1836_Jan_8.ptif` | 6141 × 6955 |
| F/016 | left half | `216/266/Babbage_Papers__Table_Division_1836_Jan_8.ptif` | 5997 × 6929 |
| F/016 | right half | `216/267/Babbage_Papers__Table_Division_1836_Jan_8.ptif` | 5997 × 6929 |

(The cover images 216/262 and 216/265 were not read.) They are the division
counterpart of F/013: the same column scheme, the same twelve platforms, the
same "2/3" label rows, and a bolting schedule of their own, F/017.

**What was read.** The heads (from scale-2 tiles of the top of each image;
the platform figures of F/015 also at full resolution), and **only the "2/3"
row of each band**, at full resolution: strips from about 15 px above each
band rule to about 100 px below it, cut off above row 1, where the arrows'
figures are written. The heads of arrows that reach up into the 2/3 row show
in these strips; they were not read. Every column of every 2/3 row was
inspected; a column not listed has no label there.

### Heads (both sheets, reading)

Left to right, as on F/013 (F/013's t-ids given for comparison only):
Axis C Ver, Cir (t01–t02); Figure wheels N.<sup>o</sup> 1–4 (t03–t06);
Cen Pin ″P (t07); Cen Pin ″p″p (t08); ″S″S Ver (t09); ″S1 Ver (t10);
Wheel on ″S2 Ver, Cir (cf. t11); Carr.<sup>e</sup> c; Carr. pin.<sup>g</sup> ″g;
Carr.<sup>e</sup> ′c; Carr. pin.<sup>g</sup> ″g3; ″R1 Ver; ″R2 Ver; heavy rule;
Axis B Ver, Cir; Figure wheels N.<sup>o</sup> 1–4; ′S′S Ver; [a narrow column,
head not read]; ′S1 Ver; Wheel on ′S2 Ver, Cir; ′R Ver; heavy rule; Wire
Axes (with "E" in band 1's 2/3 row); Lock Cent.<sup>l</sup>; Lock Fig. wh.;
Lock Carr.<sup>e</sup>; Platforms N.<sup>o</sup> 1–12; "Bolt to plat-forms";
"Back Central"; Lifters Ver, Cir.

Titles: F/015 "Dividend upon N.<sup>os</sup> 1 & 2" (left), "Dividend on
N.<sup>os</sup> 3 and 4 / Quotient on N.<sup>os</sup> 1 & 2" (right),
"N.B. the stepping is all up", and a bracketed note dated "6 Feb.<sup>y</sup>
36" ("N.B. the quotient must be on an axis with one wheel R (which it is) as
R2 R3 gear with 3 & 4 only", read at 1/2 scale, [?] in places).

**Platform heads.**

| Platform | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| F/015 (full resolution, 264 x ≈ 2700–5050, y ≈ 545–600) | +1.1 | +.6 | +1.1 | +.6 | +.4 | +.2 | −.2 | −.4 | −.6 | −1.1 | −.6 | −1.1 |
| F/016 (1/2 scale, 267) | 1.1 | .6 | 1.1 | .6 | .4 | .2 | −.2 | −.4 | −.6 | −1.1 | −.6 | −1.1 |
| F/013 (for comparison) | +1.1 | +.6 | +1.1 | +.6 | +.4 | +.2 | −.2 | −.4 | −.6 | −1.1 | −.6 | −1.1 |

F/016 writes no "+" before 1–6 (as far as 1/2 scale shows). Both sheets
group the platforms "Long time" (1–2), "Short time" (3–10), "Long time"
(11–12), the brackets clearer than on F/013.

### F/015 labels (2/3 rows)

Band rules (y on 263; on 264 about 30–40 px less): band 1 ≈ 572, band 2 ≈
2268, band 3 ≈ 3536, band 4 ≈ 5232, band (5) ≈ 6464 (the table ends after
its row 1, as on F/013). Columns' x on 263, approximately (±40; the sheet is
skewed and columns drift by up to about 30 px down the sheet): Axis C Ver
330–510; ″P 1475–1675; ″p″p 1675–1860; ″S″S 1860–2075; ″S1 2075–2250; Wheel
on ″S2 Ver 2250–2450; ″R1 3425–3615; ″R2 3615–3795; Axis B Ver 3795–3990;
′S′S 4950–5145; ′S1 5275–5460; Wheel on ′S2 Ver 5460–5650; ′R 5850–6040.
"Bolt to platforms" is on 264 at x ≈ 5050–5200.

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis B Ver | "U 7" over "B 5" (stacked; the U 7 written on the head rule) |
| 1 | ′S1 Ver | "U 9" over "B 3" (stacked, as above) |
| 2 | Axis C Ver | "B N.<sup>o</sup> 6" |
| 2 | Cen Pin ″P | "U 4" |
| 2 | ″S″S Ver | "B 3" |
| 2 | Wheel on ″S2 Ver | "B 3" |
| 2 | ″R1 Ver | "B 3" |
| 2 | ″R2 Ver | "B 3" |
| 2 | Axis B Ver | "U 5 B 8" |
| 2 | ′S′S Ver | "B 9" (written at the right of the column) |
| 2 | ′S1 Ver | "U 3" |
| 2 | Wheel on ′S2 Ver | "B 10" |
| 2 | ′R Ver | "B ~~[?8]~~ 4" (a figure struck through, then 4) |
| 2 | Bolt to platforms | "U&B" (beside a short down arrow) |
| 3 | Axis C Ver | "U N.<sup>o</sup> 6" |
| 3 | Cen Pin ″p″p | "B N.<sup>o</sup> 3" |
| 3 | ″S″S Ver | "U N.<sup>o</sup> 3" |
| 3 | Wheel on ″S2 Ver | "U 3" |
| 3 | ″R1 Ver | "U 3" |
| 3 | ″R2 Ver | "U.3" (a point between, as written) |
| 3 | Axis B Ver | "U 8 B 6" |
| 3 | ′S′S Ver | "U 9 B 3" |
| 3 | Wheel on ′S2 Ver | "U 10" |
| 3 | ′R Ver | "U ~~[?8]~~ 4" (struck figure, then 4) |
| 3 | Bolt to platforms | "U&B" |
| 4 | Axis C Ver | "B N.<sup>o</sup> 5" |
| 4 | Cen Pin ″p″p | "U N.<sup>o</sup> 3" |
| 4 | ″S1 Ver | "B 3" |
| 4 | Wheel on ″S2 Ver | "B 4" |
| 4 | ″R1 Ver | "B 4" |
| 4 | ″R2 Ver | "B 4" |
| 4 | Axis B Ver | "U 6 B 7" |
| 4 | ′S′S Ver | "U 3" |
| 4 | ′S1 Ver | "B 9" |
| 4 | Wheel on ′S2 Ver | "B 9" |
| 4 | ′R Ver | "B ~~[illeg.]~~ 3" (a blotted figure, then 3) |
| 4 | Bolt to platforms | "U&B" |
| (5) | Axis C Ver | "U N.<sup>o</sup> 5" |
| (5) | Cen Pin ″P | "B N.<sup>o</sup> 4" |
| (5) | ″S1 Ver | "U 3" |
| (5) | Wheel on ″S2 Ver | "U ~~[illeg.]~~ 4" |
| (5) | ″R1 Ver | "U 4" |
| (5) | ″R2 Ver | "U.4" |
| (5) | Axis B Ver | "U 7 B 5" |
| (5) | ′S′S Ver | faint grey (pencil?) writing, not read: it may be figures |
| (5) | ′S1 Ver | "U 9 B 3" |
| (5) | Wheel on ′S2 Ver | "U 9" |
| (5) | ′R Ver | "U ~~[illeg.]~~ 3" |
| (5) | Bolt to platforms | "U&B" |

No labels in the platform, lock, Wire Axes, Back Central or Lifters columns'
2/3 rows (the Lifters Ver column has an arrow there in bands 3 and (5), not
read). The Axis C Cir and Axis B Cir columns have a short arrow in some 2/3
rows (bands 3 and (5)), not read.

### F/016 labels (2/3 rows)

F/016 opens with rows 12–15 of a band carried over (no label row), then four
label rows. Band rules (y on 266; 267 within about 10 px): band 1 ≈ 1186,
band 2 ≈ 2870, band 3 ≈ 4460, band 4 ≈ 6144 (the last band is cut off by the
image after a few rows). Columns as on F/015 (x within about 50 px).

| Band | Column | Label as written |
|---|---|---|
| 1 | Axis B Ver | "U 5" |
| 1 | ′S1 Ver | "U 3" |
| 1 | Bolt to platforms | "U&B" (beside a short down arrow) |
| 2 | Axis C Ver | "B 6" |
| 2 | Cen Pin ″P | "U 4" |
| 2 | ″S″S Ver | "B 3" |
| 2 | Wheel on ″S2 Ver | "B 3" |
| 2 | ″R1 Ver | "B 3" |
| 2 | ″R2 Ver | "B 3" |
| 2 | Axis B Ver | "B 8" |
| 2 | ′S′S Ver | "B 9" |
| 2 | Wheel on ′S2 Ver | "B 10" |
| 2 | ′R Ver | "B 4" |
| 2 | Bolt to platforms | "U&B" |
| 3 | ′S′S Ver | "U 3" |
| 3 | Bolt to platforms | "U&B" |
| 4 | Axis C Ver | "B 5" |
| 4 | Cen Pin ″p″p | "U 3" |
| 4 | ″S1 Ver | "B 3" |
| 4 | Wheel on ″S2 Ver | "B 4" |
| 4 | ″R1 Ver | "B 4" |
| 4 | ″R2 Ver | "B 4." (a point after, as written) |
| 4 | Axis B Ver | "B 7" |
| 4 | ′S1 Ver | "B 9" |
| 4 | Wheel on ′S2 Ver | "B 9" |
| 4 | ′R Ver | "B 3" |
| 4 | Bolt to platforms | "U&B" |

Confidence: every label above was read at full resolution and is clear,
except the struck figures in F/015's ′R and ″S2 columns, F/015's faint
pencil in ′S′S band (5), and the point in "U.3", "U.4", "B 4.". F/016's
Axis B "B 8" (band 2) is a clear 8.

**Labels not yet read (held out but not prepared).** F/021–024 (Division
without table, 13 Jan 1836; zoom `216/279`–`216/288`, files
`Babbage_Papers__Division_without_Table_1836_Jan_13.ptif`), F/026–029 (Square
root, 15 Jan 1836; `216/291`–`216/302`,
`Babbage_Papers__Square_Root_1836_Jan_15.ptif`), F/032 (Ordinary cycle of
16, 18 Jan 1836; `216/310`–`216/311`) and F/033 (Notation of carriage, 25 Jan
1836; `216/312`–`216/316`) also carry B/U labels over arrows with figures.
F/021–024 show no platform columns at 1/4 scale; F/032's heads appear to
include "Platforms" ("Long time", "Short time") and "Bolt to platforms"
columns ([?], read at 1/8); F/026–029 and F/033 were not checked for them. Their labels were not read in this pass.

## 5. What a reader of the arrows should know

- **Exposure.** The agent that wrote this note saw F/015–016 (and F/021–029,
  F/032–033) whole at 1/4 or 1/8 scale while deciding whether they carry
  arrows, and the bottoms of arrows from the previous band in the
  full-resolution label strips. It recorded no arrow or figure, but it cannot
  certify that it took none in. A prediction from P is mechanical (label
  "B k" → platform k → F/013's or the sheet's own head figure and sign), so
  it can be generated by a script from section 4 without anyone's judgement;
  the readings in section 4 are the only place exposure could leak in, and
  they are of labels only.
- **What P would be tested on.** On F/015, 26 labels contain a "B k" (counting
  "U j B k" and the stacked pairs) and on F/016, 18; "U&B" is not a test (as
  on F/013). Figures used: 3–10, the same range as F/013. The two B labels with a struck figure (F/015 ′R, bands 2 and 4) should be
  scored as the figure left standing ("B 4", "B 3"), with the strike noted.
- **The cross-check.** F/017, "Bolting Plates — Division by Table"
  (`216/269/Babbage_Papers__Table_Division_1836_Jan_8.ptif`, 5587 × 6503),
  is F/014's counterpart: B/U labels by column in alternating rows of "12" and
  "16" with words, and no arrows. Its labels can be compared with section 4
  without touching any arrow; this was not done here.

## 6. Not looked at in this pass

- From F/046 on, only the first two images in each catalogue record were
  fetched at 1/8 (usually the cover and the first opening). Sheets whose main
  table is in a later image (F/057, F/058, F/060–F/073 with four or more
  images) were seen only in part. At 1/8 the presence of B/U labels can be
  missed; "no" in the table above means none seen at that scale.
- The covers of F/015 (216/262) and F/016 (216/265) were not read; so their
  dates are from the file names only.
- F/017's labels were not compared with F/015–016's.

## Summary

- **F/013 band (5) t23**: the label is "U 9 B 3" (B 3 certain). The figure
  in row 1 is **".6"** in heavy ink, certain, with a faint grey oblique stroke
  before it that no reading here turns into a figure. It agrees with the
  transcription's ".6" and is **not 1.1**: the model's miss stands.
- **F/018 cycle 3 e34**: "B 4" over an up arrow and **"6" with no point**, at
  full resolution; agrees with the transcription. F/019's restatement of the
  same rows has ".6" with a point. The miss on F/018 stands.
- **Held-out sheets**: F/015 and F/016 ("Table division", 8 Jan 1836) carry
  B/U labels over arrows with figures, twelve platforms with the same heads as
  F/013, and are untranscribed. Their labels (2/3 rows) and platform heads are
  in section 4, read without reading their arrows. F/021–024, F/026–029,
  F/032 and F/033 also qualify, and F/055 (a copy of F/032) probably does;
  their labels were not read. F/003–012 (1835)
  have no B/U labels; from F/037 (March 1836) the notation changes to labels
  of another form without the January time rows.
