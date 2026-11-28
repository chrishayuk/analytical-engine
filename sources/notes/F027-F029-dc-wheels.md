# F/026–029: which word stands in which D figure-wheel column ("Figs", "Zeros")

Read by a coding agent from the Science Museum Group images (CC BY-NC-SA
4.0, The Babbage Papers at the Science Museum, London), 28 November 2026.
**No person has checked these readings.**

Question: in `F021-F033-arrows.md`, several cells of the square-root sheets
put "Figs" and "Zeros" (or "Fig" and "0") in one cell of the D figure-wheel
columns. Which word stands in **D-Fig wh. 1** and which in **D-Fig wh. 2**,
which column has a stepped shaft, and which way does it point? And what is
in **D-C Ver** and **D-C Cir** in the same bands?

Method. Tiles from the local cache (`scripts/smg_cache.py`; all tiles of the
eight square-root halves were already cached). Each band of the D group was
cropped at 0.5 (heavy rule to ″P), the word row at 0.8, the words and shafts
at 1.0–3.0. Crops were kept in the session scratchpad, not in the repo.
Regions are x, y, w, h (or x ranges) in full-resolution pixels of the stored
image. Rows are numbered as in the right-hand margin of the right halves
(checked on 293 and 296: row 11 lies at y ≈ 2300 in band 1, the row of the
words). Conventions as in `repetition-count-1836-1842.md`: (a) on the page,
(b) what it means, (c) hypothesis; `[?x]` doubtful.

## 1. The columns

The second "Axis C" group, after the heavy rule near the right edge of each
left half (and again near the left edge of each right half, in the
overlap), is headed: one unheaded column; "Axis C" (with a small "B" over
the C on F/028 and F/029) "Ver", "Cir"; "Fig wheels" (F/026 "Fig wheels",
F/028 "Figs whls"[?], F/029 "Fig wh.") "N.º1", "N.º2" (F/028, F/029 just
"1", "2"); ″P (with a small "B" above it); ″p″p (with a small "pp" above
it); "Carriage c"; ″g; ″g1. Column bounds measured from the vertical rules at
0.5 (±10 px):

| Sheet, half | heavy rule | D-C Ver | D-C Cir | D-Fig wh. 1 | D-Fig wh. 2 | D-″P |
|---|---|---|---|---|---|---|
| F/026, 292 | 4996 | 5124–5250 | 5250–5376 | 5376–5496 | 5496–5626 | 5626–5750 |
| F/027, 295 | 4986 | 5116–5234 | 5234–5354 | 5354–5474 | 5474–5600 | 5600–5720 |
| F/028, 298 | 4986 | 5100–5230 | 5230–5350 | 5350–5474 | 5474–5596 | 5596–5726 |
| F/029, 301 | 4986 | 5106–5234 | 5234–5360 | 5360–5480 | 5480–edge (5587) | (on 302) |
| F/029, 302 | 312 | 430–555 | 555–680 | 680–800 | 800–925 | 925–1044 |

The right halves 293, 296, 299 were also looked at in the word rows of
bands 1–3 (x 250–1250 at 0.3): the same marks in the same columns.

## 2. (a) On the page

Word row is row 11 in every case (y ≈ 2300 in band 1, ≈ 4000 in band 2,
≈ 5700 in band 3). "Solid" and "dashed" (stepped) as seen at 1.0.

| Sheet, band | D-Fig wh. 1 | D-Fig wh. 2 | D-C Ver | D-C Cir |
|---|---|---|---|---|
| F/026, 1 | **"Fig"**; no shaft | **"0"**; no shaft | nothing | nothing |
| F/026, 2 | **"Figs"**; short solid down arrow, rows 9–10, head at the lower end | **"0"**; no shaft | nothing | nothing |
| F/026, 3 | **"Fig"**; long solid down arrow, rows 8–10, head at the lower end | **"0"**; no shaft | nothing | nothing |
| F/027, 1 | **"Figs"**; long solid down arrow, rows 6–10, head at the lower end | **"Zeros"**; no shaft | nothing | nothing |
| F/027, 2 | **"Figs"**; dashed shaft rows 2–10, head at the lower end | **"Zeros"**; no shaft | nothing | nothing |
| F/027, 3 | **"Zeros"**; dashed shaft rows 2–10, head at the lower end | **"Figs"**; dashed shaft rows 2–10, head at the top (row 2) | row 1 "B 5" over ↑ ".4"; row 12 ↓ with two heads, ".4" | long solid down arrow rows 2–10, head at the lower end; short down arrow row 13 |
| F/028, 1 | **"Zeros"**; no shaft | **"Figs"**; dashed shaft rows 3–10, head at the lower end | row 1 "U 5" (label only, no arrow) | nothing |
| F/028, 2 | **"Zeros"**; no shaft | **"Figs"**; dashed shaft rows 2–10, head at the lower end | nothing | nothing |
| F/028, 3 | **"Figs"**; dashed shaft rows 2–10, head at the top (row 2) | **"Zeros"**; dashed shaft rows 2–10, head at the lower end | row 1 "B 6" over ↑ ".2"; row 12 ↓ with two heads, ".2" | long solid down arrow rows 2–10, head at the lower end; short down arrow row 13 |
| F/029, 1 | **"Figs"**; dashed shaft rows 2–10, head at the lower end | **"Zero[?s]"**; no shaft | row 1 "U 6" (label only) | nothing |
| F/029, 2 | **"Figs"**; dashed shaft rows 2–10, head at the lower end | **"Zero[?s]"**; no shaft | nothing | nothing |
| F/029, 3 | **"Figs"**; dashed shaft rows 2–10, head at the lower end | **"Zero[?s]"**; no shaft | nothing | nothing |

Readings to note:

- **The two words of each pair are written in two different columns.** In
  every case the first word ends before the rule between N.º1 and N.º2 and
  the second begins after it (e.g. F/027 band 1, 295 at ×1.5,
  5150,2200,600,300: "Figs" 5355–5478, "Zeros" 5478–5602). Read together
  across the rule they look like one phrase; they are two cell entries.
- **F/026 writes "0"**, not "Zero", in N.º2 in all three bands, and "Fig"
  (no s) in bands 1 and 3, "Figs" in band 2.
- **F/029, N.º2**: the word is "Zero" followed by a terminal stroke (302 at
  ×3, 790,2260,160,110; 790,3950,160,110; 790,5640,160,110). It is like
  the final "s" of "Zeros" on F/027 (295, 5470,2260,140,110) but more
  drawn out; read "Zero[?s]" in all three bands. (The earlier reading
  "Zero" for bands 1–2 and "Zeros" for band 3 does not hold as a
  difference: the three look alike.)
- **F/026 band 1**: the words are in **row 11**, not row 8 as given in
  `F021-F033-arrows.md` (row numbers on 293, 5550,2150,444,300).
- **D-C Cir in F/027 and F/028 band 3**: the long arrow is solid and runs
  from the top of row 2 to row 10; a second, short single-headed down arrow
  stands in row 13 (295, 5100,4490,280,1500 at 0.6; 298, 5090,4490,280,1500).
- No other mark is in D-C Ver or D-C Cir in bands 1–3 of these four sheets.
  (In band 4, cut off, D-C Ver has "U 5" on F/027, "U 6" on F/028 and
  "B 5" with a short up arrow on F/029, as in `F021-F033-inputs.md`.)

## 3. (b) What it means

- **Where there is one shaft, it is in the column that says "Figs" (or
  "Fig").** That column's shaft points down (head at the lower end) in
  every such band: F/026 bands 2–3, F/027 bands 1–2, F/028 bands 1–2,
  F/029 bands 1–3. The other column says "Zeros" (or "0") and has no shaft.
  F/026 band 1 has the two words and no shaft at all.
- **Where there are two shafts (F/027 band 3, F/028 band 3)**, they point
  opposite ways, and the words go with direction the other way round:
  "Zeros" under the shaft with its head at the lower end, "Figs" under the
  shaft with its head at the top. The same sheet's D-C Ver has a bolt label
  and an up arrow in row 1 and a double-headed return in row 12, and D-C
  Cir has a long down arrow, in those two bands only.
- **Which wheel is "Figs" changes**: N.º1 on F/026, F/027 bands 1–2 and
  F/029; N.º2 on F/028 bands 1–2 and band 3 of F/027; N.º1 again on F/028
  band 3.

## 4. (c) Hypotheses (labelled; not adopted)

- HYPOTHESIS. In the single-shaft bands, the wheel marked "Figs" holds the
  figures and is stepped (down), while the wheel marked "Zeros" (or "0")
  holds zero and stays still; the two words record the state of the two
  figure wheels of the D axis at that time rather than an action. Nothing
  on the sheets says so.
- HYPOTHESIS. In the two-shaft bands (with D-C Ver lifted and D-C Cir
  turning), the figures pass from one wheel to the other, the wheel
  stepped down ending at zero and the wheel stepped up ending with the
  figures. This is only the arrangement of words and arrow heads read
  together.
