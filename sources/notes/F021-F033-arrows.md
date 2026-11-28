# F/021–024, F/026–029, F/032, F/033: the arrows of every column

Read by a coding agent from the Science Museum Group images, 27–28 November
2026. **No person has checked these readings.** This note transcribes, for
every part column of every band of the held-out sheets whose inputs are in
`F021-F033-inputs.md`, the first motion row, every double-headed arrow later
in the band, and the other marks met on the way. Nothing under `docs/` or
`scripts/` was opened for it. Each band and column was read for itself:
nothing was inferred from another band, another sheet or the labels. The
labels are repeated in the Notes column (as `F021-F033-inputs.md` gives them,
or as seen where it gives none) only to help find the column.

**Method.** As in `bolting-plates-sources.md`: aligned 512 × 512 tiles at
full resolution of the IIIF zoom images
(`https://zoom.sciencemuseumgroup.org.uk/iiif/3/<zoom path>`, paths in
`F021-F033-inputs.md` §1), fetched one at a time about 2.8 s apart plus the
request time (≈ 3.3 s), and stitched locally with PIL (auto-contrast,
greyscale). Every tile of the fourteen table images (280, 282, 286, 288,
292, 293, 295, 296, 298, 299, 301, 302, 311, 316) was fetched; tiles already
in the session scratchpad from the earlier reader were reused. No request was
refused (no 403, no 429). Crops were kept in the scratchpad only. Column
bounds were measured from the vertical rules of each image (dark-pixel
profile over a band body, rules matched to the heads of
`F021-F033-inputs.md`); regions are (x, y, w, h) or x/y ranges in
full-resolution pixels of the stored image, with the scale at which the crop
was viewed.

**Conventions.** Rows are named as the left (F/021–024, F/032, F/033) or
right (F/026–029) margin numbers them. "Row 12" is the row numbered 12;
"rows 15–1/3" is an arrow whose shaft starts in row 15 and whose head lies on
the next band rule, under the "1/3" row. "Short up arrow" / "short down
arrow" = one head; "double head" = two heads stacked on one shaft (⇈, ⇊).
A figure is given exactly as written: ".6" with a point, "6" without (only
stated as "no point" where checked at ×1.0 or more). `[?x]` doubtful.
Three cases are kept apart: **nothing** (the cell was read and is empty),
**unreadable** (ink present but not legible), **cropped/not photographed**
(the paper or photograph ends). "Returns" lists only double-headed arrows;
single-headed arrows later in the band are under "Other". "none" in Returns
means the column was read down the band and holds no double-headed arrow.

**Coverage and confidence (all sheets).** The row-1 cell of every column of
every band was read at 0.55–0.6, every doubtful figure at 0.9–1.6. The band
bodies (rows 2–15) were scanned at 0.3 over the full width, the rows that
hold the returns (11–1/3) again at 0.45–0.6, and every return whose head or
figure was doubtful at 0.8–1.6 (scales given in the tables where they
matter). A faint mark in the body could have been missed at 0.3; the
double/single judgement of a head read only at 0.3–0.55 is medium
confidence. Column assignment is ±20–40 px; the marks named lie well inside
their columns except where an x is given.


## 1. F/021–024, "Division without table" (images 280, 282, 286, 288)

**Rows.** In the left margin of 280 the figures "1/3", "2/3" and "1" are all
written **above** the heavy band rule; the arrows read here as row 1 lie in
the ruled cell directly above the rule, under the labels, and the first
numbered row below the rule is 2. (`F021-F033-inputs.md` §2 describes "2/3"
as just under the rule; this note reads the cell above the rule as row 1.)
Rows 2–15 follow and "1/3" closes the band above the next rule. Returns lie
in row 12 or in rows 15–1/3, heads on the next band rule. Band 4: the table
ends a little below its rule, after row 1; rows 2–15 of band 4 are not on
the sheet/photograph (**cropped/not photographed**).

**Regions** (same scheme on all four images; rules as in
`F021-F033-inputs.md` §2). Row 1 of each band: x 240–9315, y rule − 260 to
rule + 12, at 0.6, in six overlapping strips. Bodies: x 200–9315,
y rule − 10 to next rule + 10, at 0.3, in three strips per band. Rows
11–1/3: x 200–2400 and 4300–6800, at 0.5–0.55. Zooms: ap / g / g1 row 1
(x 1880–2400) and T2 (5300–5560) at 1.2 (280); ′g / ′g3 (4800–5150,
5780–6000) at 1.1 (282, 286); Axis A Ver row 12 at 1.4–1.5 (282, 286, 288);
Axis B Ver row 1 and row 12 at 1.0–1.2 (288); A₂ Ver–S1 row 12 at 1.0 (288);
band-4 strip y 6100–6446 at 0.25–0.3.

Columns read per band: 53 (all part columns and the unheaded columns,
x 402–9266). Band 4: row 1 only.

### F021

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | (no head, x 402–564) | nothing | — | none |  |  |
| 1 | (no head, x 564–732) | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  |  |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 1 | Figure wh. N.º 1 | nothing | — | none | dashed (stepped) shaft rows 2–10, head at the lower end; row 11 "Zeros" |  |
| 1 | Figure wh. N.º 2 | nothing | — | none | dashed (stepped) shaft rows 2–10, head at the top (row 2); row 11 "Figs" |  |
| 1 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | pp | nothing | — | none | "Give off and retain" written across pp–Figures upon A, row 9 |  |
| 1 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 1 | g | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 1 | g1 | nothing | — | none |  |  |
| 1 | Figures upon Axis A | nothing | — | none | "49" in the 1/3–2/3 rows above row 1; row 15 "49" |  |
| 1 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 1 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 1 | (no head, x 2884–3046) | nothing | — | none | brown stains along the rule at x ≈ 2884, rows 7–15 (not marks) |  |
| 1 | Axis B Ver | nothing | — | none |  |  |
| 1 | Axis B Cir | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 1 | nothing | — | none | dashed (stepped) shaft rows 2–10, head at the lower end; row 11 "Figs" |  |
| 1 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 1 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 1 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 1 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 1 | ′P | short up arrow | 1.1 | row 12, down, double head, **no figure** |  |  |
| 1 | ′p′p | nothing | — | none |  |  |
| 1 | Carriage b | nothing | — | none | "Suffer Subtraction" across Carriage b–′g3, row 9; row 14 "Carry" with a short down stroke under it [?arrow] |  |
| 1 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head (heads on the next band rule), 1.1 |  |  |
| 1 | ′g1 | nothing | — | none |  |  |
| 1 | O2 | nothing | — | none |  |  |
| 1 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 1 | ′g2 | nothing | — | none |  |  |
| 1 | ′g3 | nothing | — | none |  |  |
| 1 | O3 | nothing | — | none |  |  |
| 1 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire Axes Ver | nothing | — | none |  |  |
| 1 | Figures upon Axis B | nothing | — | none | "09889" and "49" in the rows above row 1; row 15 "04989" |  |
| 1 | R1 Cir | nothing | — | none | rows 6–11 "Gears / with / N.º 3 / in / Cage / n−2" |  |
| 1 | A₂ Ver | nothing | — | none |  |  |
| 1 | A₂ Cir | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "0" |  |
| 1 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 1 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 1 | (no head, x 9100–9266) | nothing | — | none | row 9 "1" |  |
| 2 | (no head, x 402–564) | nothing | — | none |  |  |
| 2 | (no head, x 564–732) | nothing | — | none |  |  |
| 2 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 |  |  |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wh. N.º 1 | nothing | — | none | stepped shaft rows 2–10, head at the top (row 2); row 11 "Figs" |  |
| 2 | Figure wh. N.º 2 | nothing | — | none | dashed shaft rows 2–10, head at the lower end (row 10); row 11 "Zeros" |  |
| 2 | ″P | nothing | — | none |  | label "U 3" only |
| 2 | pp | short up arrow | .6 | row 12, down, double head, .6 | "Give off and retain" across, row 9 |  |
| 2 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 2 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 2 | g | nothing | — | none |  | label "U 4" only |
| 2 | g1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | Figures upon Axis A | nothing | — | none | "49" above row 1 |  |
| 2 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 2 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 2 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 2 | Axis B Ver | nothing | — | none |  |  |
| 2 | Axis B Cir | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft rows 2–10, head at the lower end; row 11 "Figs" |  |
| 2 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 2 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 2 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 2 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 2 | ′P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | ′p′p | nothing | — | none |  |  |
| 2 | Carriage b | nothing | — | none | "Suffer Subtraction" across, rows 8–9; row 14 "Carry" with a short down arrow under it |  |
| 2 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | ′g1 | nothing | — | none |  |  |
| 2 | O2 | nothing | — | none |  |  |
| 2 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 2 | ′g2 | nothing | — | none |  |  |
| 2 | ′g3 | nothing | — | none |  |  |
| 2 | O3 | nothing | — | none |  |  |
| 2 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire Axes Ver | nothing | — | none |  |  |
| 2 | Figures upon Axis B | nothing | — | none | row 15 "00089" |  |
| 2 | R1 Cir | nothing | — | none | row 2 short up arrow (no figure) |  |
| 2 | A₂ Ver | nothing | — | none |  |  |
| 2 | A₂ Cir | nothing | — | none |  |  |
| 2 | Figure wheels (A₂) N.º 3 | nothing | — | none | row 2 short up arrow (no figure) |  |
| 2 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "0" |  |
| 2 | n−1 | nothing | — | none | row 3 "0" |  |
| 2 | n−2 | nothing | — | none | row 3 "1" |  |
| 2 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 2 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 2 | (no head, x 9100–9266) | nothing | — | none | row 8 "2" |  |
| 3 | (no head, x 402–564) | nothing | — | none |  |  |
| 3 | (no head, x 564–732) | nothing | — | none |  |  |
| 3 | Axis A Ver | short up arrow | .4 | row 12, down, double head, **4** (no point seen at 0.55) |  |  |
| 3 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wh. N.º 2 | nothing | — | none | shaft, head at the top; row 11 "Figs" |  |
| 3 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | pp | nothing | — | none |  | label "U 4" only; "Give off and retain" across, row 9 |
| 3 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 3 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 3 | g | short up arrow | **6** (no point; ×1.2) | row 12, down, double head, .6 |  |  |
| 3 | g1 | nothing | — | none |  | label "U 3" only |
| 3 | Figures upon Axis A | nothing | — | none | "49" above row 1 |  |
| 3 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 3 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 3 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 3 | Axis B Ver | nothing | — | none |  |  |
| 3 | Axis B Cir | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 1 | nothing | — | none | shaft, head at the lower end; row 11 "Figs" |  |
| 3 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 3 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 3 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 3 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 3 | ′P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | ′p′p | nothing | — | none | "Sign changed" across ′p′p–′g2, row 11 |  |
| 3 | Carriage b | nothing | — | none | "Suffer Subtraction" across, rows 8–9; rows 13–15 "Carri / age / prevent / ed" |  |
| 3 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′g1 | nothing | — | none |  |  |
| 3 | O2 | nothing | — | none |  |  |
| 3 | T2 | short up arrow | **45** (no point; ×1.2) | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 3 | ′g2 | nothing | — | none |  |  |
| 3 | ′g3 | nothing | — | none |  |  |
| 3 | O3 | nothing | — | none |  |  |
| 3 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | nothing | — | none |  |  |
| 3 | Wire Axes Ver | nothing | — | none |  |  |
| 3 | Figures upon Axis B | nothing | — | none | "06189" |  |
| 3 | R1 Cir | nothing | — | none | row 2 short up arrow |  |
| 3 | A₂ Ver | nothing | — | none |  |  |
| 3 | A₂ Cir | nothing | — | none |  |  |
| 3 | Figure wheels (A₂) N.º 3 | nothing | — | none | row 2 short up arrow |  |
| 3 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | nothing | — | none |  |  |
| 3 | n | nothing | — | none | row 3 "0" |  |
| 3 | n−1 | nothing | — | none | row 3 "0" |  |
| 3 | n−2 | nothing | — | none | row 3 "2" |  |
| 3 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 3 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 3 | (no head, x 9100–9266) | nothing | — | none | "3" |  |
| 4 | (no head, x 402–564) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 564–732) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Ver | short up arrow | .2 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ″P | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 3" only |
| 4 | pp | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 1722–1890) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ap | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | g | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 4" only |
| 4 | g1 | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis A | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2552–2714) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2714–2884) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2884–3046) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (narrow, x 4030–4156) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 4156–4324) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′P | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 3" only |
| 4 | ′p′p | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T2 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  | figure ×1.0 |
| 4 | Carriage ′b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T3 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  | figure ×1.0 |
| 4 | ′S′S | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Wire Axes Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis B | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | R1 Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | SS | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8780–8940) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8940–9100) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 9100–9266) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |

### F022

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | (no head, x 402–564) | nothing | — | none |  |  |
| 1 | (no head, x 564–732) | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .2 | row 12, **up**, double head, .2 (×1.5) |  |  |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; an ink blot over Axis A Ver/Cir rows 10–11 with a dotted trail |  |
| 1 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the top (row 2); row 11 "Figs" |  |
| 1 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 1 | ″P | nothing | — | none |  | label "U 3" only |
| 1 | pp | short up arrow | .6 | row 12, down, double head, .6 | "Give off and Retain" across, row 7 |  |
| 1 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 1 | g | nothing | — | none |  | label "U" only |
| 1 | g1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | Figures upon Axis A | nothing | — | none | "49" |  |
| 1 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 1 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 1 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 1 | Axis B Ver | nothing | — | none |  |  |
| 1 | Axis B Cir | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the top (row 2); row 11 "Figs" |  |
| 1 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 1 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 1 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 1 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 1 | ′P | nothing | — | none |  | label "U 3" only |
| 1 | ′p′p | short up arrow | 1.1 | row 12, down, double head, **no figure** | "Receive addition of Divisor <u>without</u> carriage" across, row 6 |  |
| 1 | Carriage b | nothing | — | none | rows 13–15 "Carriage prevented" |  |
| 1 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | ′g1 | nothing | — | none |  |  |
| 1 | O2 | nothing | — | none |  |  |
| 1 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 1 | ′g2 | nothing | — | none |  |  |
| 1 | ′g3 | nothing | — | none |  |  |
| 1 | O3 | nothing | — | none |  |  |
| 1 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire Axes Ver | nothing | — | none |  |  |
| 1 | Figures upon Axis B | nothing | — | none | "06189" and "49" above row 1; row 15 "00089" |  |
| 1 | R1 Cir | nothing | — | none |  |  |
| 1 | A₂ Ver | nothing | — | none |  |  |
| 1 | A₂ Cir | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "2" |  |
| 1 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 1 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 1 | (no head, x 9100–9266) | nothing | — | none | "4" |  |
| 2 | (no head, x 402–564) | nothing | — | none | words in the margin at the label row: "…es are bolted", "…turn[?]" (start cut off) |  |
| 2 | (no head, x 564–732) | nothing | — | none |  |  |
| 2 | Axis A Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 (×1.4) |  |  |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; "Rest" and "Step up quotient" written vertically across Axis A Cir / Fig. wh. N.º 1, rows 6–10 |  |
| 2 | Figure wh. N.º 1 | nothing | — | none |  |  |
| 2 | Figure wh. N.º 2 | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | pp | nothing | — | none |  | label "U 4" only |
| 2 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 2 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 2 | g | nothing | — | none |  |  |
| 2 | g1 | nothing | — | none |  | label "U 3" only |
| 2 | Figures upon Axis A | nothing | — | none |  |  |
| 2 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 2 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 2 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 2 | Axis B Ver | short up arrow | .4 | row 12, down, double head, .4 |  |  |
| 2 | Axis B Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 2 | Figure wheels (B) N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 2 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 2 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 2 | ′P | nothing | — | none |  |  |
| 2 | ′p′p | nothing | — | none | "Step up" across ′P–′p′p, rows 6–7 | label "U 3" only |
| 2 | Carriage b | nothing | — | none |  |  |
| 2 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 2 | ′g1 | nothing | — | none |  |  |
| 2 | O2 | nothing | — | none |  |  |
| 2 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | Carriage ′b | nothing | — | none |  |  |
| 2 | ′g2 | nothing | — | none |  |  |
| 2 | ′g3 | short up arrow | .6 (×1.1) | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | O3 | nothing | — | none |  |  |
| 2 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | short up arrow | 1.1 | row 12, down, double head, 1.1 | row 5 a small scribbled mark (unreadable) |  |
| 2 | Wire Axes Ver | nothing | — | none |  |  |
| 2 | Figures upon Axis B | nothing | — | none | "00890" |  |
| 2 | R1 Cir | nothing | — | none |  |  |
| 2 | A₂ Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 |  |  |
| 2 | A₂ Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wheels (A₂) N.º 3 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 2 | Figure wheels (A₂) N.º 4 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs"; "Step up" across N.º 4–S1, rows 6–7 |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | short **down** arrow | .6 | row 12, **up**, double head, .6 |  |  |
| 2 | n | nothing | — | none |  |  |
| 2 | n−1 | nothing | — | none |  |  |
| 2 | n−2 | nothing | — | none |  |  |
| 2 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 2 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 2 | (no head, x 9100–9266) | nothing | — | none | "5" |  |
| 3 | (no head, x 402–564) | nothing | — | none |  |  |
| 3 | (no head, x 564–732) | nothing | — | none |  |  |
| 3 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  |  |
| 3 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | pp | nothing | — | none | "Give off and retain" across, row 7 |  |
| 3 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 3 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 3 | g | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 3 | g1 | nothing | — | none |  |  |
| 3 | Figures upon Axis A | nothing | — | none |  |  |
| 3 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 3 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 3 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 3 | Axis B Ver | nothing | — | none |  | label "U 5" only |
| 3 | Axis B Cir | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 1 | nothing | — | none | row 11 "Zeros" |  |
| 3 | Figure wheels (B) N.º 2 | nothing | — | none | dashed shaft rows 2–9 (head not seen at 0.3); row 11 "Figures" |  |
| 3 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 3 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 3 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 3 | ′P | nothing | — | none |  |  |
| 3 | ′p′p | short up arrow | .6 | row 12, down, double head, .6 | "Suffer Subtraction" across, row 7; "Sign changed" row 9; a long faint curved stroke from ′p′p row 15 up to the narrow column row 2 [?crease or stroke] |  |
| 3 | Carriage b | nothing | — | none | row 14 "Zeros" |  |
| 3 | ′g | nothing | — | none |  | label "U 1" only |
| 3 | ′g1 | nothing | — | none |  |  |
| 3 | O2 | nothing | — | none |  |  |
| 3 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | Carriage ′b | nothing | — | none | rows 13–15 "Carriage prevented" |  |
| 3 | ′g2 | nothing | — | none |  |  |
| 3 | ′g3 | short up arrow | .6 (×1.1) | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | O3 | nothing | — | none |  |  |
| 3 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | nothing | — | none |  | label "U 3" only |
| 3 | Wire Axes Ver | nothing | — | none |  |  |
| 3 | Figures upon Axis B | nothing | — | none | "06990" |  |
| 3 | R1 Cir | nothing | — | none | rows 2–7 "Gears / with / N.º 4 / in / Cage / n−2" |  |
| 3 | A₂ Ver | nothing | — | none |  | label "U 7" only |
| 3 | A₂ Cir | nothing | — | none |  |  |
| 3 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | nothing | — | none |  | label "U 9" only |
| 3 | n | nothing | — | none | row 3 "0" |  |
| 3 | n−1 | nothing | — | none | row 3 "2" |  |
| 3 | n−2 | nothing | — | none | row 3 "0" |  |
| 3 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 3 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 3 | (no head, x 9100–9266) | nothing | — | none | "6" |  |
| 4 | (no head, x 402–564) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 564–732) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Ver | short up arrow | .2 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ″P | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 3" only |
| 4 | pp | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 1722–1890) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ap | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | g | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 4" only |
| 4 | g1 | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis A | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2552–2714) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2714–2884) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2884–3046) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (narrow, x 4030–4156) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 4156–4324) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′P | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′p′p | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 4" only |
| 4 | Carriage b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g | nothing | — | cropped/not photographed (the table ends after row 1) |  | checked ×1.1 |
| 4 | ′g1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T2 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage ′b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g3 | short up arrow | **6** (no point; ×1.1) | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T3 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S′S | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Wire Axes Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis B | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | R1 Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | SS | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8780–8940) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8940–9100) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 9100–9266) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |

### F023

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | (no head, x 402–564) | nothing | — | none |  |  |
| 1 | (no head, x 564–732) | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 |  |  |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 1 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 1 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 1 | ″P | nothing | — | none |  | label "U 3" only |
| 1 | pp | short up arrow | .6 | row 12, down, double head, .6 | "Give off and retain" across, row 6 |  |
| 1 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 1 | g | nothing | — | none |  | label "U 4" only |
| 1 | g1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | Figures upon Axis A | nothing | — | none |  |  |
| 1 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 1 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 1 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 1 | Axis B Ver | nothing | — | none |  |  |
| 1 | Axis B Cir | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 1 | nothing | — | none | row 11 "Zeros" |  |
| 1 | Figure wheels (B) N.º 2 | nothing | — | none | dashed shaft, head at the top (row 2); row 11 "Figs" |  |
| 1 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 1 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 1 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 1 | ′P | short up arrow | .6 (×1.1) | row 12, down, double head, .6 |  |  |
| 1 | ′p′p | nothing | — | none | "Receive addition of Divisor without carriage" across, row 6 | label "U 4" only |
| 1 | Carriage b | nothing | — | none | row 14 "Zeros" |  |
| 1 | ′g | nothing | — | none |  |  |
| 1 | ′g1 | nothing | — | none |  |  |
| 1 | O2 | nothing | — | none |  |  |
| 1 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | Carriage ′b | nothing | — | none | rows 13–15 "Carriage prevented" |  |
| 1 | ′g2 | nothing | — | none |  |  |
| 1 | ′g3 | short up arrow | .6 (×1.1) | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | O3 | nothing | — | none |  |  |
| 1 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire Axes Ver | nothing | — | none |  |  |
| 1 | Figures upon Axis B | nothing | — | none | "06990" and "49" above row 1; row 15 "00890" |  |
| 1 | R1 Cir | nothing | — | none |  |  |
| 1 | A₂ Ver | nothing | — | none |  |  |
| 1 | A₂ Cir | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "2" |  |
| 1 | n−2 | nothing | — | none | row 3 "0" |  |
| 1 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 1 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 1 | (no head, x 9100–9266) | nothing | — | none | "7" |  |
| 2 | (no head, x 402–564) | nothing | — | none |  |  |
| 2 | (no head, x 564–732) | nothing | — | none |  |  |
| 2 | Axis A Ver | short **down** arrow | .4 | row 12, **up**, double head, .4 (the point drawn as a short dash; ×1.4) |  |  |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; "Step up quotient" written vertically beside it (Axis A Cir / Fig. wh. N.º 1, rows 5–11) |  |
| 2 | Figure wh. N.º 1 | nothing | — | none |  |  |
| 2 | Figure wh. N.º 2 | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | pp | nothing | — | none |  | label "U 4" only |
| 2 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 2 | ap | short up arrow | .6 | row 12, down, double head, **no figure** (×1.4) |  |  |
| 2 | g | nothing | — | none |  |  |
| 2 | g1 | nothing | — | none |  | label "U 3" only |
| 2 | Figures upon Axis A | nothing | — | none |  |  |
| 2 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 2 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 2 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 2 | Axis B Ver | short up arrow | .2 | none seen |  | read at 0.3 and 0.5; no return found |
| 2 | Axis B Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | Figure wheels (B) N.º 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 2 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 2 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 2 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 2 | ′P | nothing | — | none | "Step up" across ′P–′g, row 6 | label "U 4" only |
| 2 | ′p′p | nothing | — | none |  |  |
| 2 | Carriage b | nothing | — | none | row 14 "Carry" |  |
| 2 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | ′g1 | nothing | — | none |  |  |
| 2 | O2 | nothing | — | none |  |  |
| 2 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 2 | ′g2 | nothing | — | none |  |  |
| 2 | ′g3 | short up arrow | .6 (×1.1) | rows 15–1/3, down, double head, .6 |  |  |
| 2 | O3 | nothing | — | none |  |  |
| 2 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | ′S′S | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire Axes Ver | nothing | — | none |  |  |
| 2 | Figures upon Axis B | nothing | — | none | "08900" |  |
| 2 | R1 Cir | nothing | — | none |  |  |
| 2 | A₂ Ver | short **down** arrow | .4 | row 12, **up**, double head, .4 |  |  |
| 2 | A₂ Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wheels (A₂) N.º 3 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | Figure wheels (A₂) N.º 4 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 2 | SS | short **down** arrow | .6 | row 12, **up**, double head, .6 |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none |  |  |
| 2 | n−1 | nothing | — | none |  |  |
| 2 | n−2 | nothing | — | none |  |  |
| 2 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 2 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 2 | (no head, x 9100–9266) | nothing | — | none | "8" |  |
| 3 | (no head, x 402–564) | nothing | — | none |  |  |
| 3 | (no head, x 564–732) | nothing | — | none |  |  |
| 3 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  |  |
| 3 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | pp | nothing | — | none | "Give off and retain" across, row 6 |  |
| 3 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 3 | ap | short up arrow | .6 | row 12, down, double head, **no figure** (×1.4) |  |  |
| 3 | g | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 3 | g1 | nothing | — | none |  |  |
| 3 | Figures upon Axis A | nothing | — | none |  |  |
| 3 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 3 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 3 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 3 | Axis B Ver | nothing | — | none |  |  |
| 3 | Axis B Cir | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" |  |
| 3 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 3 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 3 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 3 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 3 | ′P | short up arrow | 1.1 | row 12, down, double head, 1.1 | "Suffer Subtraction" across, row 6 |  |
| 3 | ′p′p | nothing | — | none |  |  |
| 3 | Carriage b | nothing | — | none | row 14 short down arrow + "Carry" |  |
| 3 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′g1 | nothing | — | none |  |  |
| 3 | O2 | nothing | — | none |  |  |
| 3 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 3 | ′g2 | nothing | — | none |  |  |
| 3 | ′g3 | nothing | — | none |  | label "U 2" only |
| 3 | O3 | nothing | — | none |  |  |
| 3 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′S′S | nothing | — | none |  | label "U 3" only |
| 3 | ′S1 | nothing | — | none |  |  |
| 3 | Wire Axes Ver | nothing | — | none |  |  |
| 3 | Figures upon Axis B | nothing | — | none | "04000" |  |
| 3 | R1 Cir | nothing | — | none | "Gears / with / N.º 3 / in / Cage / n−2" |  |
| 3 | A₂ Ver | nothing | — | none |  | label "U 8" only |
| 3 | A₂ Cir | nothing | — | none |  |  |
| 3 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 3 | SS | nothing | — | none |  | label "U 9" only |
| 3 | S1 | nothing | — | none |  |  |
| 3 | n | nothing | — | none | row 3 "2" |  |
| 3 | n−1 | nothing | — | none | row 3 "0" |  |
| 3 | n−2 | nothing | — | none | row 3 "0" |  |
| 3 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 3 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 3 | (no head, x 9100–9266) | nothing | — | none | "9" |  |
| 4 | (no head, x 402–564) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 564–732) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Ver | short up arrow | .2 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ″P | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 3" only |
| 4 | pp | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 1722–1890) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ap | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | g | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 4" only |
| 4 | g1 | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis A | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2552–2714) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2714–2884) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2884–3046) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (narrow, x 4030–4156) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 4156–4324) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′P | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′p′p | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T2 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage ′b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T3 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S′S | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Wire Axes Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis B | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | R1 Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | SS | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8780–8940) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8940–9100) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 9100–9266) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |

### F024

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | (no head, x 402–564) | nothing | — | none |  |  |
| 1 | (no head, x 564–732) | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 |  |  |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 1 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 1 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 1 | ″P | nothing | — | none |  | label "U 3" only |
| 1 | pp | short up arrow | .6 | row 12, down, double head, .6 | "Give off and retain" across, row 5 |  |
| 1 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, **no figure** |  |  |
| 1 | g | nothing | — | none |  | label "U 4" only |
| 1 | g1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | Figures upon Axis A | nothing | — | none | "49" |  |
| 1 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 1 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 1 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 1 | Axis B Ver | nothing | — | none |  |  |
| 1 | Axis B Cir | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" |  |
| 1 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 1 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 1 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 1 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 1 | ′P | short up arrow | 1.1 | row 12, down, double head, 1.1 | "Suffer Subtraction" across, row 5; "Sign changed" row 7 |  |
| 1 | ′p′p | nothing | — | none |  |  |
| 1 | Carriage b | nothing | — | none | rows 13–15 "Carriage prevented" |  |
| 1 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | ′g1 | nothing | — | none |  |  |
| 1 | O2 | nothing | — | none |  |  |
| 1 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 1 | ′g2 | nothing | — | none |  |  |
| 1 | ′g3 | nothing | — | none |  |  |
| 1 | O3 | nothing | — | none |  |  |
| 1 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire Axes Ver | nothing | — | none |  |  |
| 1 | Figures upon Axis B | nothing | — | none | "04000" above row 1; row 15 "00100" |  |
| 1 | R1 Cir | nothing | — | none |  |  |
| 1 | A₂ Ver | nothing | — | none |  |  |
| 1 | A₂ Cir | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (A₂) N.º 4 | nothing | — | none |  |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "2" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "1" |  |
| 1 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 1 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 1 | (no head, x 9100–9266) | nothing | — | none | "10" |  |
| 2 | (no head, x 402–564) | nothing | — | none |  |  |
| 2 | (no head, x 564–732) | nothing | — | none |  |  |
| 2 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  |  |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 2 | Figure wh. N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 2 | Figure wh. N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | pp | nothing | — | none | "Give off and retain" across, row 6 | label "U.4" only |
| 2 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 2 | ap | short up arrow | .6 | row 12, down, double head, **no figure** |  |  |
| 2 | g | short up arrow | .6 | row 12, down, double head, **no figure** |  |  |
| 2 | g1 | nothing | — | none |  | label "U 3" only |
| 2 | Figures upon Axis A | nothing | — | none |  |  |
| 2 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 2 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 2 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 2 | Axis B Ver | nothing | — | none |  |  |
| 2 | Axis B Cir | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figures" [?] |  |
| 2 | Figure wheels (B) N.º 2 | nothing | — | none | row 11 "Zeros" |  |
| 2 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 2 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 2 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 2 | ′P | nothing | — | none | "Rec.ᵉ addition of divisor without carriage" across, row 6 | label "U 3" only |
| 2 | ′p′p | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | Carriage b | nothing | — | none | rows 13–15 "Carriage prevented" |  |
| 2 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** (×1.0) |  |  |
| 2 | ′g1 | nothing | — | none |  |  |
| 2 | O2 | nothing | — | none |  |  |
| 2 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (×1.0) |  |  |
| 2 | Carriage ′b | nothing | — | none | row 14 "Zeros" |  |
| 2 | ′g2 | nothing | — | none |  |  |
| 2 | ′g3 | nothing | — | none |  |  |
| 2 | O3 | nothing | — | none |  |  |
| 2 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (×1.0) |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire Axes Ver | nothing | — | none |  |  |
| 2 | Figures upon Axis B | nothing | — | none | "04000" |  |
| 2 | R1 Cir | nothing | — | none | row 2 short up arrow |  |
| 2 | A₂ Ver | nothing | — | none |  |  |
| 2 | A₂ Cir | nothing | — | none |  |  |
| 2 | Figure wheels (A₂) N.º 3 | nothing | — | none | row 2 short up arrow; row 3 "Figs" |  |
| 2 | Figure wheels (A₂) N.º 4 | nothing | — | none | row 3 "Zeros" |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "2" |  |
| 2 | n−1 | nothing | — | none | row 3 "0" |  |
| 2 | n−2 | nothing | — | none | row 3 "1" |  |
| 2 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 2 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 2 | (no head, x 9100–9266) | nothing | — | none | "11" |  |
| 3 | (no head, x 402–564) | nothing | — | none |  |  |
| 3 | (no head, x 564–732) | nothing | — | none |  |  |
| 3 | Axis A Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 (×1.4) |  |  |
| 3 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; "Step up quotient" written vertically beside it |  |
| 3 | Figure wh. N.º 1 | nothing | — | none |  |  |
| 3 | Figure wh. N.º 2 | nothing | — | none |  |  |
| 3 | ″P | nothing | — | none |  | label "U 3" only |
| 3 | pp | nothing | — | none |  |  |
| 3 | (no head, x 1722–1890) | nothing | — | none |  |  |
| 3 | ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 3 | g | nothing | — | none |  | label "U.4" only |
| 3 | g1 | nothing | — | none |  |  |
| 3 | Figures upon Axis A | nothing | — | none |  |  |
| 3 | (no head, x 2552–2714) | nothing | — | none |  |  |
| 3 | (no head, x 2714–2884) | nothing | — | none |  |  |
| 3 | (no head, x 2884–3046) | nothing | — | none |  |  |
| 3 | Axis B Ver | a vertical stroke with **no head** (×1.2) | .4 | row 12, down, double head, .4 (×1.0) |  | read as written: no arrowhead in row 1 |
| 3 | Axis B Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wheels (B) N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wheels (B) N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | Figure wheels (B) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (B) N.º 4 | nothing | — | none |  |  |
| 3 | (narrow, x 4030–4156) | nothing | — | none |  |  |
| 3 | (no head, x 4156–4324) | nothing | — | none |  |  |
| 3 | ′P | nothing | — | none | ink spots rows 4–5 (′P / ′p′p) |  |
| 3 | ′p′p | nothing | — | none |  | label "U" only |
| 3 | Carriage b | nothing | — | none | row 14 "Zeros"; "Step up" written across about ′g–O2 [?columns], row 6 |  |
| 3 | ′g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 3 | ′g1 | nothing | — | none |  |  |
| 3 | O2 | nothing | — | none |  |  |
| 3 | T2 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | Carriage ′b | nothing | — | none | row 14 "Figs" |  |
| 3 | ′g2 | nothing | — | none |  |  |
| 3 | ′g3 | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 3 | O3 | nothing | — | none |  |  |
| 3 | T3 | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | Wire Axes Ver | nothing | — | none |  |  |
| 3 | Figures upon Axis B | nothing | — | none | "40000" |  |
| 3 | R1 Cir | nothing | — | none |  |  |
| 3 | A₂ Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 (×1.0) |  |  |
| 3 | A₂ Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wheels (A₂) N.º 3 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wheels (A₂) N.º 4 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | short **down** arrow | .6 | row 12, **up**, double head, .6 (×1.0) | "Step up" across S1–n−1, row 6 |  |
| 3 | n | nothing | — | none |  |  |
| 3 | n−1 | nothing | — | none |  |  |
| 3 | n−2 | nothing | — | none |  |  |
| 3 | (no head, x 8780–8940) | nothing | — | none |  |  |
| 3 | (no head, x 8940–9100) | nothing | — | none |  |  |
| 3 | (no head, x 9100–9266) | nothing | — | none | "12" |  |
| 4 | (no head, x 402–564) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 564–732) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Ver | short up arrow | .2 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis A Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wh. N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ″P | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | pp | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 1722–1890) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ap | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | g | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | g1 | short up arrow | 1.1 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis A | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2552–2714) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2714–2884) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 2884–3046) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Axis B Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 5" only |
| 4 | Axis B Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (B) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (narrow, x 4030–4156) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 4156–4324) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′P | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′p′p | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 1" only |
| 4 | ′g1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T2 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Carriage ′b | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′g3 | short up arrow | .6 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | O3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | T3 | short up arrow | .45 | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S′S | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | ′S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 3" only |
| 4 | Wire Axes Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figures upon Axis B | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | R1 Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | A₂ Ver | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 7" only |
| 4 | A₂ Cir | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 3 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | Figure wheels (A₂) N.º 4 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | SS | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | S1 | nothing | — | cropped/not photographed (the table ends after row 1) |  | label "U 9" only |
| 4 | n | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−1 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | n−2 | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8780–8940) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 8940–9100) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |
| 4 | (no head, x 9100–9266) | nothing | — | cropped/not photographed (the table ends after row 1) |  |  |

## 2. F/026–029, "Square root" (images 292/293, 295/296, 298/299, 301/302)

**Rows.** As `F021-F033-inputs.md` §3: under each band rule one ruled cell
holds the label (at its top) and row 1 (the arrows below it); rows 2–15
follow, numbered in the right margin; "1/3" closes the band. Returns lie in
row 12 or in rows 15–1/3. Band 4: the paper (or photograph) ends inside the
row-1 cell; arrows are seen with their figures cut off, and everything below
is **cropped/not photographed**.

**Columns.** Bounds were measured from the vertical rules of 292 and 293 at
y 1500–1900 and transferred to the other sheets by matching their rules
(295 −10 px, 296 +2, 298 −12, 299 −18; 301 and 302 measured directly at
y 1500–2900). Names follow `F021-F033-inputs.md` §3 (with its doubtful names
N, R, N2, R2, C1–C4 kept as [?]); the "D-" group is the second Axis C group
after the heavy rule; "T2 cs" is the column `F021-F033-inputs.md` calls
"cs (T2)". Columns in the overlap of the two halves (O4 … D-Carriage c) were
read on both halves.

**Regions** (each sheet). Row 1: y rule − 20 to rule + 205, x 0–5994 in four
overlapping strips at 0.6, both halves. Bodies: y rule + 150 to next rule
+ 20, x 0–3050 and 2950–end, at 0.3. Rows 10–1/3 at 0.45–0.8. Zooms at
1.0–1.6 as given in the tables (e.g. F/026 J1, V1 Ver, J2 returns at 1.6;
F/027 and F/028 Axis c Ver / c10 at 1.2–1.3; F/029 c10 at 1.3, Axis c Ver
at 1.2). Band 4: y 6150–6369 at 0.9–1.0.

Columns read per band: 80 (77 part columns + the platform columns on
F/026–027, or the three unheaded columns after n−2 on F/028–029).

### F026

Platforms Long time, Short time and Bolting to platforms: nothing in any row of any band (row-1 strips and bodies), as in `F021-F033-inputs.md` §3.

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | N [?] | nothing | — | none |  |  |
| 1 | R [?] | nothing | — | none | short up arrow, about row 10 |  |
| 1 | Axis A Ver | nothing | — | none |  |  |
| 1 | Axis A Cir | nothing | — | none |  |  |
| 1 | Figure wheels N.º 1 | nothing | — | none | short up arrow, about row 10 |  |
| 1 | Figure wheels N.º 2 | nothing | — | none |  |  |
| 1 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 1 | P | nothing | — | none | "Receive Addition of 1" written across, row 6 |  |
| 1 | pp | nothing | — | none |  |  |
| 1 | Carriage a | nothing | — | none | rows 13–14 up arrow + "Carry" |  |
| 1 | ap | nothing | — | none |  |  |
| 1 | g | nothing | — | none |  |  |
| 1 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  | label "B 1" |
| 1 | O | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 1 | T | nothing | — | none |  |  |
| 1 | Axis a Ver | nothing | — | none |  |  |
| 1 | Axis a Cir | nothing | — | none |  |  |
| 1 | Axis a10 | nothing | — | none |  |  |
| 1 | Figs on Axis A | nothing | — | none | "Lowest posit.ⁿ 000" in the label row; row 15 "100" |  |
| 1 | N2 [?] | nothing | — | none |  |  |
| 1 | R2 [?] | nothing | — | none |  |  |
| 1 | Axis C Ver | nothing | — | none |  |  |
| 1 | Axis C Cir | nothing | — | none |  |  |
| 1 | C1 [?] | nothing | — | none |  |  |
| 1 | C2 [?] | nothing | — | none |  |  |
| 1 | C3 [?] | nothing | — | none |  |  |
| 1 | C4 [?] | nothing | — | none |  |  |
| 1 | ″P | nothing | — | none |  |  |
| 1 | ″p″p | nothing | — | none |  |  |
| 1 | Carriage c | nothing | — | none |  |  |
| 1 | cp | nothing | — | none |  |  |
| 1 | ″g | nothing | — | none |  |  |
| 1 | ″g1 | nothing | — | none |  |  |
| 1 | O4 | nothing | — | none |  |  |
| 1 | T4 | nothing | — | none |  |  |
| 1 | Axis c Ver | nothing | — | none |  |  |
| 1 | Axis c Cir | nothing | — | none |  |  |
| 1 | Axis c10 | nothing | — | none |  |  |
| 1 | Figs on Axis C | nothing | — | none | "Lowest posit.ⁿ 000" in the label row; row 15 "000" |  |
| 1 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 1 | D-C Ver | nothing | — | none |  |  |
| 1 | D-C Cir | nothing | — | none |  |  |
| 1 | D-Fig wh. 1 | nothing | — | none | row 8 "Fig" (D-Fig wh. 1), "0" (D-Fig wh. 2) |  |
| 1 | D-Fig wh. 2 | nothing | — | none |  |  |
| 1 | D-″P | nothing | — | none |  |  |
| 1 | D-″p″p | nothing | — | none |  |  |
| 1 | D-Carriage c | nothing | — | none |  |  |
| 1 | D-″g | nothing | — | none |  |  |
| 1 | D-″g1 | nothing | — | none |  |  |
| 1 | O2 ca | nothing | — | none |  |  |
| 1 | T2 cs | nothing | — | none |  |  |
| 1 | V1 Ver | nothing | — | none |  |  |
| 1 | V1 Cir | nothing | — | none |  |  |
| 1 | J1 | nothing | — | none |  |  |
| 1 | Carriage ′c | nothing | — | none |  |  |
| 1 | ″g2 | nothing | — | none |  |  |
| 1 | ″g3 | nothing | — | none |  |  |
| 1 | O3 ′ca | nothing | — | none |  |  |
| 1 | T3 ′cs | nothing | — | none |  |  |
| 1 | V2 Ver | nothing | — | none |  |  |
| 1 | V2 Cir | nothing | — | none |  |  |
| 1 | J2 | nothing | — | none |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow (single heads) |  |
| 1 | Figs on Div axis | nothing | — | none | row 15 "040601" |  |
| 1 | R1 | nothing | — | none |  |  |
| 1 | QA Ver | nothing | — | none |  |  |
| 1 | QA Cir | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 3 | nothing | — | none | row 3 "0"; "First" written across, row 8 |  |
| 1 | Figure wheels (QA) N.º 4 | nothing | — | none | row 3 "0" |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "0" |  |
| 1 | Platforms Long time | nothing | — | none |  |  |
| 1 | Platforms Short time | nothing | — | none |  |  |
| 1 | Bolting to platforms | nothing | — | none |  |  |
| 2 | N [?] | nothing | — | none |  |  |
| 2 | R [?] | nothing | — | none |  |  |
| 2 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  | label "B 5" |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 2 | Figure wheels N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "0" |  |
| 2 | Figure wheels N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 2 | P | short up arrow | 1.1 | row 12, down, double head, **no figure** | "Give off" written across, row 6 | label "B.3" |
| 2 | pp | nothing | — | none |  |  |
| 2 | Carriage a | nothing | — | none |  |  |
| 2 | ap | short up arrow | .6 | row 12, down, double head, **no figure** |  | label "B 4" |
| 2 | g | short up arrow | .6 | rows 15–1/3, down, double head, **no figure** |  | label "B 2" |
| 2 | g1 | nothing | — | none |  | label "U 1" only |
| 2 | O | nothing | — | none |  | label "U" only |
| 2 | T | nothing | — | none |  |  |
| 2 | Axis a Ver | nothing | — | none |  |  |
| 2 | Axis a Cir | nothing | — | none |  |  |
| 2 | Axis a10 | nothing | — | none |  |  |
| 2 | Figs on Axis A | nothing | — | none | row 15 "100" |  |
| 2 | N2 [?] | nothing | — | none |  |  |
| 2 | R2 [?] | nothing | — | none | long up arrow, rows 5–9 (x ≈ 2683) |  |
| 2 | Axis C Ver | nothing | — | none |  |  |
| 2 | Axis C Cir | nothing | — | none |  |  |
| 2 | C1 [?] | nothing | — | none | long up arrow, rows 5–9 (x ≈ 3065) [?column]; "Receive Addition of 3" across, row 6 |  |
| 2 | C2 [?] | nothing | — | none |  |  |
| 2 | C3 [?] | nothing | — | none |  |  |
| 2 | C4 [?] | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | ″p″p | nothing | — | none |  |  |
| 2 | Carriage c | nothing | — | none | row 14 up arrow + "Carry" |  |
| 2 | cp | nothing | — | none |  |  |
| 2 | ″g | nothing | — | none |  |  |
| 2 | ″g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  | label "B 1" |
| 2 | O4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 2 | T4 | nothing | — | none |  |  |
| 2 | Axis c Ver | nothing | — | none |  |  |
| 2 | Axis c Cir | nothing | — | none |  |  |
| 2 | Axis c10 | nothing | — | none |  |  |
| 2 | Figs on Axis C | nothing | — | none | row 15 "300" |  |
| 2 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 2 | D-C Ver | nothing | — | none |  |  |
| 2 | D-C Cir | nothing | — | none |  |  |
| 2 | D-Fig wh. 1 | nothing | — | none | short down arrow rows 9–10; row 11 "Figs" (D-Fig wh. 1) "0" (D-Fig wh. 2) |  |
| 2 | D-Fig wh. 2 | nothing | — | none |  |  |
| 2 | D-″P | short up arrow | 1.1 | row 12, down, double head, **no figure** (an ink dot above the shaft; ×1.3) |  | label "B 3" |
| 2 | D-″p″p | nothing | — | none |  |  |
| 2 | D-Carriage c | nothing | — | none |  |  |
| 2 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Suffer Subt.ⁿ of 1" across, row 6 | label "B 1" |
| 2 | D-″g1 | nothing | — | none |  |  |
| 2 | O2 ca | nothing | — | none |  |  |
| 2 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 2 | V1 Ver | nothing | — | none |  |  |
| 2 | V1 Cir | nothing | — | none |  |  |
| 2 | J1 | short up arrow | .6 | row 12, down, double head, "6" with a faint mark low at its left [?.6] (×1.6) | "Receive Divisor" written vertically, rows 6–11 | label "B 4" |
| 2 | Carriage ′c | nothing | — | none |  |  |
| 2 | ″g2 | nothing | — | none |  |  |
| 2 | ″g3 | nothing | — | none |  |  |
| 2 | O3 ′ca | nothing | — | none |  |  |
| 2 | T3 ′cs | nothing | — | none |  |  |
| 2 | V2 Ver | nothing | — | none |  |  |
| 2 | V2 Cir | nothing | — | none |  |  |
| 2 | J2 | nothing | — | none |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 2 | Figs on Div axis | nothing | — | none | row 15 "030601" |  |
| 2 | R1 | nothing | — | none |  |  |
| 2 | QA Ver | nothing | — | none |  |  |
| 2 | QA Cir | nothing | — | none |  |  |
| 2 | Figure wheels (QA) N.º 3 | nothing | — | none | row 4 "0"; "Second" [?] across, row 8 |  |
| 2 | Figure wheels (QA) N.º 4 | nothing | — | none | row 4 "0" |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "0" |  |
| 2 | n−1 | nothing | — | none | row 3 "0" |  |
| 2 | n−2 | nothing | — | none | row 3 "0" |  |
| 2 | Platforms Long time | nothing | — | none |  |  |
| 2 | Platforms Short time | nothing | — | none |  |  |
| 2 | Bolting to platforms | nothing | — | none |  |  |
| 3 | N [?] | nothing | — | none |  |  |
| 3 | R [?] | nothing | — | none | long up arrow, rows 4–9 |  |
| 3 | Axis A Ver | nothing | — | none |  | label "U 5" only |
| 3 | Axis A Cir | nothing | — | none |  |  |
| 3 | Figure wheels N.º 1 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 2 | nothing | — | none | long up arrow; row 11 "Figs" |  |
| 3 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 3 | P | nothing | — | none | "Receive Addition of 4" across, row 6 | label "U 3" only |
| 3 | pp | nothing | — | none |  |  |
| 3 | Carriage a | nothing | — | none | row 14 up arrow + "Carry" |  |
| 3 | ap | nothing | — | none |  | label "U 4" only |
| 3 | g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 3 | g1 | nothing | — | none |  |  |
| 3 | O | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 3 | T | nothing | — | none |  |  |
| 3 | Axis a Ver | nothing | — | none |  |  |
| 3 | Axis a Cir | nothing | — | none |  |  |
| 3 | Axis a10 | nothing | — | none |  |  |
| 3 | Figs on Axis A | nothing | — | none | row 15 "500" |  |
| 3 | N2 [?] | nothing | — | none |  |  |
| 3 | R2 [?] | nothing | — | none |  |  |
| 3 | Axis C Ver | short up arrow | .4 | row 12, down, double head, .4 |  | label "B 5" |
| 3 | Axis C Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 3 | C1 [?] | nothing | — | none | dashed shaft, head at the lower end; row 11 "0s" |  |
| 3 | C2 [?] | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | C3 [?] | nothing | — | none |  |  |
| 3 | C4 [?] | nothing | — | none |  |  |
| 3 | ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 | "Give off" across, row 6 | label "B 3" |
| 3 | ″p″p | nothing | — | none |  |  |
| 3 | Carriage c | nothing | — | none |  |  |
| 3 | cp | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 3 | ″g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  | label "B 2" |
| 3 | ″g1 | nothing | — | none |  | label "U 1" only |
| 3 | O4 | nothing | — | none |  | label "U" only |
| 3 | T4 | nothing | — | none |  |  |
| 3 | Axis c Ver | nothing | — | none |  |  |
| 3 | Axis c Cir | nothing | — | none |  |  |
| 3 | Axis c10 | nothing | — | none |  |  |
| 3 | Figs on Axis C | nothing | — | none | row 15 "300" |  |
| 3 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 3 | D-C Ver | nothing | — | none |  |  |
| 3 | D-C Cir | nothing | — | none |  |  |
| 3 | D-Fig wh. 1 | nothing | — | none | long down arrow; row 11 "Fig" / "0" |  |
| 3 | D-Fig wh. 2 | nothing | — | none |  |  |
| 3 | D-″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 3 | D-″p″p | nothing | — | none |  |  |
| 3 | D-Carriage c | nothing | — | none | row 14 down arrow + "Carry" |  |
| 3 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Suffer Subtraction of 3" across, row 6 |  |
| 3 | D-″g1 | nothing | — | none |  |  |
| 3 | O2 ca | nothing | — | none |  |  |
| 3 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 3 | V1 Ver | short up arrow | .2 | row 12, down, double head, .2 (×1.6) |  | label "B 6" |
| 3 | V1 Cir | nothing | — | none | long solid down arrow rows 2–10, short down arrow row 13; "Bring to Zero" written vertically |  |
| 3 | J1 | nothing | — | none |  | label "U 4" only |
| 3 | Carriage ′c | nothing | — | none |  |  |
| 3 | ″g2 | nothing | — | none |  |  |
| 3 | ″g3 | nothing | — | none |  |  |
| 3 | O3 ′ca | nothing | — | none |  |  |
| 3 | T3 ′cs | nothing | — | none |  |  |
| 3 | V2 Ver | nothing | — | none |  |  |
| 3 | V2 Cir | nothing | — | none |  |  |
| 3 | J2 | short up arrow | .6 | row 12, down, double head, .6 (×1.6) | "Receive Divisor" written vertically | label "B 4" |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | nothing | — | none |  |  |
| 3 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 3 | Figs on Div axis | nothing | — | none | row 15 "000601" |  |
| 3 | R1 | nothing | — | none | row 3 short up arrow |  |
| 3 | QA Ver | nothing | — | none |  |  |
| 3 | QA Cir | nothing | — | none |  |  |
| 3 | Figure wheels (QA) N.º 3 | nothing | — | none | row 3 short up arrow; "Third" across, row 9 |  |
| 3 | Figure wheels (QA) N.º 4 | nothing | — | none | row 3 "0" |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | nothing | — | none |  |  |
| 3 | n | nothing | — | none | row 3 "0" |  |
| 3 | n−1 | nothing | — | none | row 3 "0" |  |
| 3 | n−2 | nothing | — | none | row 3 "1" |  |
| 3 | Platforms Long time | nothing | — | none |  |  |
| 3 | Platforms Short time | nothing | — | none |  |  |
| 3 | Bolting to platforms | nothing | — | none |  |  |
| 4 | N [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis A Ver | short up arrow | cropped [?.2] | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 6" |
| 4 | Axis A Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | pp | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | Carriage a | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ap | short up arrow | cropped [?.6] | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | g | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 2" |
| 4 | g1 | short up arrow | cropped [?1.1] | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 1" |
| 4 | O | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | T | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis A | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | N2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 5" |
| 4 | Axis C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C1 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C3 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C4 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 3" |
| 4 | ″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | cp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U.4" |
| 4 | ″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O4 | short up arrow | cropped [?.45] | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B" |
| 4 | T4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis C | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after the heavy rule) | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″P | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O2 ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T2 cs | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 6" |
| 4 | V1 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | Carriage ′c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O3 ′ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T3 ′cs | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Ver | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 6" |
| 4 | V2 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | ′S′S | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ′S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Wire axes | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Div axis | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | QA Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | QA Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | SS | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Platforms Long time | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Platforms Short time | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Bolting to platforms | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |

### F027

Platforms Long time, Short time and Bolting to platforms: nothing in any row of any band (row-1 strips and bodies), as in `F021-F033-inputs.md` §3.

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | N [?] | nothing | — | none |  |  |
| 1 | R [?] | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "B 6" |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 1 | Figure wheels N.º 1 | nothing | — | none | long up arrow rows 5–10; row 11 "Figs" |  |
| 1 | Figure wheels N.º 2 | nothing | — | none | long down arrow; row 11 "Zeros" |  |
| 1 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 1 | P | nothing | — | none |  |  |
| 1 | pp | short up arrow | .6 | row 12, down, double head, .6 | "Give off" across, row 6 | label "B 4" |
| 1 | Carriage a | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 1 | g | nothing | — | none |  | label "U 2" only |
| 1 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  | label "B 1" |
| 1 | O | nothing | — | none |  |  |
| 1 | T | nothing | — | none |  |  |
| 1 | Axis a Ver | nothing | — | none |  |  |
| 1 | Axis a Cir | nothing | — | none |  |  |
| 1 | Axis a10 | nothing | — | none |  |  |
| 1 | Figs on Axis A | nothing | — | none | row 15 "500" |  |
| 1 | N2 [?] | nothing | — | none |  |  |
| 1 | R2 [?] | nothing | — | none | long up arrow rows 5–9 (x ≈ 2693) |  |
| 1 | Axis C Ver | nothing | — | none |  | label "U 5" only |
| 1 | Axis C Cir | nothing | — | none |  |  |
| 1 | C1 [?] | nothing | — | none | row 11 "Zeros" |  |
| 1 | C2 [?] | nothing | — | none | long up arrow rows 5–10; row 11 "Figs"; "Receive Addition of 4" across, row 6 |  |
| 1 | C3 [?] | nothing | — | none |  |  |
| 1 | C4 [?] | nothing | — | none |  |  |
| 1 | ″P | nothing | — | none |  | label "U" only |
| 1 | ″p″p | nothing | — | none |  |  |
| 1 | Carriage c | nothing | — | none | row 14 up arrow + "Carry" |  |
| 1 | cp | nothing | — | none |  | label "U 4" only |
| 1 | ″g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 1 | ″g1 | nothing | — | none |  |  |
| 1 | O4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | T4 | nothing | — | none |  |  |
| 1 | Axis c Ver | nothing | — | none |  |  |
| 1 | Axis c Cir | nothing | — | none |  |  |
| 1 | Axis c10 | nothing | — | none |  |  |
| 1 | Figs on Axis C | nothing | — | none | row 15 "700" |  |
| 1 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 1 | D-C Ver | nothing | — | none |  |  |
| 1 | D-C Cir | nothing | — | none |  |  |
| 1 | D-Fig wh. 1 | nothing | — | none | long down arrow; row 11 "Figs" / "Zeros" |  |
| 1 | D-Fig wh. 2 | nothing | — | none |  |  |
| 1 | D-″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | D-″p″p | nothing | — | none |  |  |
| 1 | D-Carriage c | nothing | — | none | rows 14–15 "Carriage pre[vented]" |  |
| 1 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Suffer Subtraction" across, row 6; "Sign changed from + to −" rows 8–9 |  |
| 1 | D-″g1 | nothing | — | none |  |  |
| 1 | O2 ca | nothing | — | none |  |  |
| 1 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | V1 Ver | nothing | — | none |  |  |
| 1 | V1 Cir | nothing | — | none |  |  |
| 1 | J1 | short up arrow | .6 | row 12, down, double head, .6 | "Receive Divisor" written vertically; rows 14–15 "[?unmut] / up / prevent / unbolt- / ing" | label "B 4" |
| 1 | Carriage ′c | nothing | — | none | row 15 "Zeros" |  |
| 1 | ″g2 | nothing | — | none |  |  |
| 1 | ″g3 | nothing | — | none |  |  |
| 1 | O3 ′ca | nothing | — | none |  |  |
| 1 | T3 ′cs | short up arrow | **no figure** | rows 15–1/3, down, double head, **no figure** |  |  |
| 1 | V2 Ver | short up arrow | .2 | row 12, down, double head, **no figure** |  | label "B 6" |
| 1 | V2 Cir | nothing | — | none | long solid down arrow rows 2–10, short down arrow row 13; "Bring to Zero" written vertically |  |
| 1 | J2 | nothing | — | none |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 1 | Figs on Div axis | nothing | — | none | row 15 "050601" |  |
| 1 | R1 | nothing | — | none | row 3 short up arrow |  |
| 1 | QA Ver | nothing | — | none |  |  |
| 1 | QA Cir | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 3 | nothing | — | none | row 3 short up arrow; row 4 "Figs" "Zeros"; "Fourth" across, row 7 |  |
| 1 | Figure wheels (QA) N.º 4 | nothing | — | none |  |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "2" |  |
| 1 | Platforms Long time | nothing | — | none |  |  |
| 1 | Platforms Short time | nothing | — | none |  |  |
| 1 | Bolting to platforms | nothing | — | none |  |  |
| 2 | N [?] | nothing | — | none | rows 11–15 "Lowered / one / Cage" |  |
| 2 | R [?] | nothing | — | none | short down arrow, row 9 |  |
| 2 | Axis A Ver | nothing | — | none |  | label "U 6" only |
| 2 | Axis A Cir | nothing | — | none |  |  |
| 2 | Figure wheels N.º 1 | nothing | — | none | short down arrow rows 9–10; row 11 "Figs" "Zeros" |  |
| 2 | Figure wheels N.º 2 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 2 | P | nothing | — | none | "Suffer Subtraction of 1" across, row 6 |  |
| 2 | pp | nothing | — | none |  | label "U 4" only |
| 2 | Carriage a | nothing | — | none | row 14 down arrow + "Carry" |  |
| 2 | ap | nothing | — | none |  | label "U 4" only |
| 2 | g | nothing | — | none |  |  |
| 2 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 (×1.0) |  |  |
| 2 | O | short up arrow | .45 | rows 15–1/3, down, double head, **1.1** (×1.0; as written) |  | label "B" |
| 2 | T | nothing | — | none |  |  |
| 2 | Axis a Ver | nothing | — | none |  |  |
| 2 | Axis a Cir | nothing | — | none |  |  |
| 2 | Axis a10 | nothing | — | none |  |  |
| 2 | Figs on Axis A | nothing | — | none | row 15 "400" |  |
| 2 | N2 [?] | nothing | — | none |  |  |
| 2 | R2 [?] | nothing | — | none |  |  |
| 2 | Axis C Ver | nothing | — | none |  |  |
| 2 | Axis C Cir | nothing | — | none |  |  |
| 2 | C1 [?] | nothing | — | none | row 6 "Zero Figs"; "Change sign of Carriage from + to −" across, row 6 |  |
| 2 | C2 [?] | nothing | — | none |  |  |
| 2 | C3 [?] | nothing | — | none |  |  |
| 2 | C4 [?] | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | ″p″p | nothing | — | none |  |  |
| 2 | Carriage c | nothing | — | none | row 14 down arrow + "Carry" |  |
| 2 | cp | nothing | — | none |  |  |
| 2 | ″g | nothing | — | none |  | label "U 2" only |
| 2 | ″g1 | nothing | — | none |  |  |
| 2 | O4 | nothing | — | none |  | label "U" only |
| 2 | T4 | nothing | — | none |  |  |
| 2 | Axis c Ver | nothing | — | none | rows 11–12: "B" + short up arrow + "25" (single head; no point seen, ×1.0) |  |
| 2 | Axis c Cir | nothing | — | none | short up arrow rows 13–14 |  |
| 2 | Axis c10 | **up arrow, double head** (two heads on the shaft, in row 1) | .3 (×1.3) | none |  | label "B" |
| 2 | Figs on Axis C | nothing | — | none | row 15 "700" |  |
| 2 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 2 | D-C Ver | nothing | — | none |  |  |
| 2 | D-C Cir | nothing | — | none |  |  |
| 2 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" "Zeros" |  |
| 2 | D-Fig wh. 2 | nothing | — | none |  |  |
| 2 | D-″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | D-″p″p | nothing | — | none |  |  |
| 2 | D-Carriage c | nothing | — | none | rows 14–15 "Carriage prevented"; "[?pre]vented" written over the band rule above row 1 |  |
| 2 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Return the Divisor" across, row 6; "Sign changed from − to +" [?] rows 8–9 |  |
| 2 | D-″g1 | nothing | — | none |  |  |
| 2 | O2 ca | nothing | — | none |  |  |
| 2 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 2 | V1 Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "B 6" |
| 2 | V1 Cir | nothing | — | none | long solid down arrow rows 2–10, short down arrow row 13 |  |
| 2 | J1 | short up arrow | **no figure** | row 12, down, double head, "6" [?point] (0.3 only) | row 14 "Zeros" |  |
| 2 | Carriage ′c | nothing | — | none |  |  |
| 2 | ″g2 | nothing | — | none |  |  |
| 2 | ″g3 | nothing | — | none |  |  |
| 2 | O3 ′ca | nothing | — | none |  |  |
| 2 | T3 ′cs | short up arrow | **no figure** | rows 15–1/3, down, double head, **no figure** |  |  |
| 2 | V2 Ver | nothing | — | none | "Rest" written across V2 | label "U 6" only |
| 2 | V2 Cir | nothing | — | none |  |  |
| 2 | J2 | nothing | — | none |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 2 | Figs on Div axis | nothing | — | none | row 15 "000601" |  |
| 2 | R1 | nothing | — | none |  |  |
| 2 | QA Ver | nothing | — | none |  |  |
| 2 | QA Cir | nothing | — | none |  |  |
| 2 | Figure wheels (QA) N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels (QA) N.º 4 | nothing | — | none | "Fifth" across, row 8 |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "0" |  |
| 2 | n−1 | nothing | — | none | row 3 "0" |  |
| 2 | n−2 | nothing | — | none | row 3 "2" |  |
| 2 | Platforms Long time | nothing | — | none |  |  |
| 2 | Platforms Short time | nothing | — | none |  |  |
| 2 | Bolting to platforms | nothing | — | none |  |  |
| 3 | N [?] | nothing | — | none |  |  |
| 3 | R [?] | nothing | — | none | short up arrow, row 10 |  |
| 3 | Axis A Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 | "Step up quotient" written vertically (Axis A Ver / Cir) | label "B 7" |
| 3 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–9 |  |
| 3 | Figure wheels N.º 1 | nothing | — | none | short up arrow row 10; row 11 "Figs" "Zeros" |  |
| 3 | Figure wheels N.º 2 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 3 | P | nothing | — | none | "Receive Addition of 01" across, row 6 |  |
| 3 | pp | nothing | — | none |  |  |
| 3 | Carriage a | nothing | — | none | row 14 down arrow + "Carry" |  |
| 3 | ap | nothing | — | none |  |  |
| 3 | g | nothing | — | none |  |  |
| 3 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 3 | O | short up arrow | **1.1** | rows 15–1/3, down, double head, 1.1 |  |  |
| 3 | T | nothing | — | none |  |  |
| 3 | Axis a Ver | nothing | — | none |  |  |
| 3 | Axis a Cir | nothing | — | none |  |  |
| 3 | Axis a10 | nothing | — | none |  |  |
| 3 | Figs on Axis A | nothing | — | none | row 15 "410" |  |
| 3 | N2 [?] | nothing | — | none | rows 12–15 "Lowered / one / Cage" |  |
| 3 | R2 [?] | nothing | — | none | long down arrow rows 8–10 (x ≈ 2707) |  |
| 3 | Axis C Ver | nothing | — | none |  |  |
| 3 | Axis C Cir | nothing | — | none |  |  |
| 3 | C1 [?] | nothing | — | none | long down arrow; row 11 "Zeros" "Figs"; "Subtract 3" across, row 6 |  |
| 3 | C2 [?] | nothing | — | none |  |  |
| 3 | C3 [?] | nothing | — | none |  |  |
| 3 | C4 [?] | nothing | — | none |  |  |
| 3 | ″P | nothing | — | none |  |  |
| 3 | ″p″p | nothing | — | none |  |  |
| 3 | Carriage c | nothing | — | none | row 14 down arrow + "Carry" |  |
| 3 | cp | nothing | — | none |  |  |
| 3 | ″g | nothing | — | none |  |  |
| 3 | ″g1 | short up arrow | .6 | rows 15–1/3, down, double head, **no figure** (×1.0) |  | label "B 2" |
| 3 | O4 | nothing | — | none |  |  |
| 3 | T4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 3 | Axis c Ver | **down arrow, double head**, heads on the rule under row 1 | **no figure** | none | row 2 "U" |  |
| 3 | Axis c Cir | nothing | — | none |  |  |
| 3 | Axis c10 | short up arrow | .3 (×1.3) | none |  |  |
| 3 | Figs on Axis C | nothing | — | none | row 15 "400" |  |
| 3 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 3 | D-C Ver | short up arrow | .4 | row 12, down, double head, .4 |  | label "B 5" |
| 3 | D-C Cir | nothing | — | none | long solid down arrow rows 2–10, short down arrow row 13 |  |
| 3 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | D-Fig wh. 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | D-″P | nothing | — | none |  | label "U" only |
| 3 | D-″p″p | nothing | — | none |  |  |
| 3 | D-Carriage c | nothing | — | none | row 15 "Zeros"; "[?pre]vented" over the band rule above row 1 |  |
| 3 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Step up Dividend" across, row 6 |  |
| 3 | D-″g1 | nothing | — | none |  |  |
| 3 | O2 ca | nothing | — | none |  |  |
| 3 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | V1 Ver | nothing | — | none | "Put back" written across V1 Ver / V1 Cir in row 1; "The levers upon b10" rows 2–3 (V1–J1) | label "U 6" only |
| 3 | V1 Cir | nothing | — | none |  |  |
| 3 | J1 | nothing | — | none | "Rest" written across | label "U 4" only |
| 3 | Carriage ′c | nothing | — | none | row 15 "Figs" |  |
| 3 | ″g2 | nothing | — | none |  |  |
| 3 | ″g3 | short up arrow | .6 | rows 15–1/3, down, double head, **6** (no point seen, 0.8) |  | label "B 2" |
| 3 | O3 ′ca | nothing | — | none |  |  |
| 3 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** |  |  |
| 3 | V2 Ver | nothing | — | none |  |  |
| 3 | V2 Cir | nothing | — | none |  |  |
| 3 | J2 | nothing | — | none |  |  |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | short up arrow | 1.1 | row 12, down, double head, **no figure** (×1.0) |  | label "B 3" |
| 3 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 3 | Figs on Div axis | nothing | — | none | row 15 "00b010" [?"000010"] |  |
| 3 | R1 | nothing | — | none |  |  |
| 3 | QA Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 |  | label "B 7" |
| 3 | QA Cir | nothing | — | none | long solid down arrow rows 2–10, short down arrow row 13 |  |
| 3 | Figure wheels (QA) N.º 3 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | Figure wheels (QA) N.º 4 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs"; "Sixth" row 5, "Step up quotient" row 7 (across) |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | short **down** arrow | .6 | row 12, **up**, double head, .6 |  | label "B 9" |
| 3 | n | nothing | — | none | row 11 "0" |  |
| 3 | n−1 | nothing | — | none | row 11 "2" |  |
| 3 | n−2 | nothing | — | none | row 11 "0" |  |
| 3 | Platforms Long time | nothing | — | none |  |  |
| 3 | Platforms Short time | nothing | — | none |  |  |
| 3 | Bolting to platforms | nothing | — | none |  |  |
| 4 | N [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis A Ver | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 7" over "B 5" |
| 4 | Axis A Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | P | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 3" |
| 4 | pp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage a | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ap | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 2" |
| 4 | g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 1" |
| 4 | O | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | T | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis A | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | N2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C1 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C3 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C4 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | cp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | ″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 2" |
| 4 | O4 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B" |
| 4 | T4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | Axis c Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis C | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after the heavy rule) | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 5" |
| 4 | D-C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″p″p | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | D-Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 1" |
| 4 | D-″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O2 ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T2 cs | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | Carriage ′c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g3 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O3 ′ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T3 ′cs | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ′S′S | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ′S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 3" |
| 4 | Wire axes | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Div axis | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | QA Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 7" |
| 4 | QA Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | SS | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 9" |
| 4 | n | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Platforms Long time | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Platforms Short time | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Bolting to platforms | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |

### F028

After n−2 there are three unheaded columns (no platform heads) before the row numbers; nothing in any band.

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | N [?] | nothing | — | none |  |  |
| 1 | R [?] | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  | label "B 5" |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 1 | Figure wheels N.º 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 1 | Figure wheels N.º 2 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 1 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 1 | P | short up arrow | 1.1 | row 12, down, double head, 1.1 | "Give off" across, row 6 | label "B 3" |
| 1 | pp | nothing | — | none |  |  |
| 1 | Carriage a | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 1 | g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  | label "B 2" |
| 1 | g1 | nothing | — | none |  |  |
| 1 | O | nothing | — | none |  |  |
| 1 | T | nothing | — | none |  |  |
| 1 | Axis a Ver | nothing | — | none |  |  |
| 1 | Axis a Cir | nothing | — | none |  |  |
| 1 | Axis a10 | nothing | — | none |  |  |
| 1 | Figs on Axis A | nothing | — | none | row 15 "410" |  |
| 1 | N2 [?] | nothing | — | none |  |  |
| 1 | R2 [?] | nothing | — | none | long up arrow rows 7–9 (x ≈ 2693); "Add 03 and C1[?]" across, row 6 |  |
| 1 | Axis C Ver | nothing | — | none |  |  |
| 1 | Axis C Cir | nothing | — | none |  |  |
| 1 | C1 [?] | nothing | — | none |  |  |
| 1 | C2 [?] | nothing | — | none | long up arrow rows 5–10; row 11 "Zeros" "Figs" (C1/C2) |  |
| 1 | C3 [?] | nothing | — | none | "Change sign of Carriage from − to +" across, row 6 |  |
| 1 | C4 [?] | nothing | — | none |  |  |
| 1 | ″P | nothing | — | none |  |  |
| 1 | ″p″p | nothing | — | none |  |  |
| 1 | Carriage c | nothing | — | none | row 14 "Carry" |  |
| 1 | cp | nothing | — | none |  |  |
| 1 | ″g | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 1 | ″g1 | nothing | — | none |  |  |
| 1 | O4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 1 | T4 | nothing | — | none |  |  |
| 1 | Axis c Ver | nothing | — | none | rows 11–12 "B" + short up arrow + ".25" |  |
| 1 | Axis c Cir | nothing | — | none | short down arrow, rows 13–14 |  |
| 1 | Axis c10 | short down arrow (head on the rule under row 1; ×1.4 on 299) | .3 | none | row 2 "Lower" over "U" [?] |  |
| 1 | Figs on Axis C | nothing | — | none | row 15 "430" |  |
| 1 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 1 | D-C Ver | nothing | — | none |  | label "U 5" only |
| 1 | D-C Cir | nothing | — | none |  |  |
| 1 | D-Fig wh. 1 | nothing | — | none |  |  |
| 1 | D-Fig wh. 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" "Figs" |  |
| 1 | D-″P | nothing | — | none |  |  |
| 1 | D-″p″p | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 1 | D-Carriage c | nothing | — | none | rows 14–15 "Zero[s]" |  |
| 1 | D-″g | nothing | — | none | "Suffer Subtraction", "Sign Changed from + to −" across, rows 6–8 |  |
| 1 | D-″g1 | nothing | — | none |  |  |
| 1 | O2 ca | nothing | — | none |  |  |
| 1 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (0.3) |  |  |
| 1 | V1 Ver | nothing | — | none |  |  |
| 1 | V1 Cir | nothing | — | none |  |  |
| 1 | J1 | short up arrow | .6 | row 12, down, double head, .6 | "Receive Divisor" written vertically | label "B 4" |
| 1 | Carriage ′c | nothing | — | none | rows 14–15 "Carriage pre[vented]" |  |
| 1 | ″g2 | nothing | — | none |  |  |
| 1 | ″g3 | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 1 | O3 ′ca | nothing | — | none |  |  |
| 1 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (0.3) |  |  |
| 1 | V2 Ver | nothing | — | none | "Rest" written across |  |
| 1 | V2 Cir | nothing | — | none |  |  |
| 1 | J2 | nothing | — | none |  |  |
| 1 | ′S′S | nothing | — | none |  |  |
| 1 | ′S1 | nothing | — | none |  | label "U 3" only |
| 1 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 1 | Figs on Div axis | nothing | — | none | row 2 "041"; row 15 "065010" |  |
| 1 | R1 | nothing | — | none |  |  |
| 1 | QA Ver | nothing | — | none |  | label "U 5" only |
| 1 | QA Cir | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 4 | nothing | — | none | "Seventh" across, row 8 |  |
| 1 | SS | nothing | — | none |  |  |
| 1 | S1 | nothing | — | none |  | label "U 9" only |
| 1 | n | nothing | — | none | row 3 "0" |  |
| 1 | n−1 | nothing | — | none | row 3 "2" |  |
| 1 | n−2 | nothing | — | none | row 3 "0" |  |
| 1 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 1 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 1 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 2 | N [?] | nothing | — | none | rows 11–15 "Lowered / one / Cage" |  |
| 2 | R [?] | nothing | — | none | short down arrow, row 9 |  |
| 2 | Axis A Ver | nothing | — | none |  | label "U 5" only |
| 2 | Axis A Cir | nothing | — | none |  |  |
| 2 | Figure wheels N.º 1 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 2 | nothing | — | none | short down arrow, row 9 |  |
| 2 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 2 | P | nothing | — | none | "Subtract 01" across, row 6 | label "U 3" only |
| 2 | pp | nothing | — | none |  |  |
| 2 | Carriage a | nothing | — | none | row 14 up arrow + "Carry" |  |
| 2 | ap | nothing | — | none |  | label "U 4" only |
| 2 | g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 2 | g1 | nothing | — | none |  |  |
| 2 | O | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 2 | T | nothing | — | none |  |  |
| 2 | Axis a Ver | nothing | — | none |  |  |
| 2 | Axis a Cir | nothing | — | none |  |  |
| 2 | Axis a10 | nothing | — | none |  |  |
| 2 | Figs on Axis A | nothing | — | none | row 15 "400" |  |
| 2 | N2 [?] | nothing | — | none |  |  |
| 2 | R2 [?] | nothing | — | none |  |  |
| 2 | Axis C Ver | nothing | — | none |  |  |
| 2 | Axis C Cir | nothing | — | none |  |  |
| 2 | C1 [?] | nothing | — | none | row 11 "Zeros" "Figs"; "Change sign of Carriage from + to −" across, row 6 |  |
| 2 | C2 [?] | nothing | — | none |  |  |
| 2 | C3 [?] | nothing | — | none |  |  |
| 2 | C4 [?] | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | ″p″p | nothing | — | none |  |  |
| 2 | Carriage c | nothing | — | none | row 14 "Carry" |  |
| 2 | cp | nothing | — | none |  |  |
| 2 | ″g | nothing | — | none |  | label "U 4" only |
| 2 | ″g1 | nothing | — | none |  |  |
| 2 | O4 | nothing | — | none |  | label "U" only |
| 2 | T4 | nothing | — | none |  |  |
| 2 | Axis c Ver | short **down** arrow (single head, ×1.2) | .25 | none | row 2 "U"; rows 11–12 "B" + short up arrow + ".25" |  |
| 2 | Axis c Cir | nothing | — | none | short up arrow, rows 13–14 |  |
| 2 | Axis c10 | **up arrow, double head** | .3 (×1.2) | none |  | label "B" |
| 2 | Figs on Axis C | nothing | — | none | row 15 "430" |  |
| 2 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 2 | D-C Ver | nothing | — | none |  |  |
| 2 | D-C Cir | nothing | — | none |  |  |
| 2 | D-Fig wh. 1 | nothing | — | none |  |  |
| 2 | D-Fig wh. 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" "Figs" |  |
| 2 | D-″P | nothing | — | none |  |  |
| 2 | D-″p″p | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 2 | D-Carriage c | nothing | — | none | row 15 "Zeros" |  |
| 2 | D-″g | nothing | — | none | "Return the Divisor" across, row 6; "Sign changed from − to +" row 8 |  |
| 2 | D-″g1 | nothing | — | none |  |  |
| 2 | O2 ca | nothing | — | none |  |  |
| 2 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 2 | V1 Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "B 6" |
| 2 | V1 Cir | nothing | — | none | long solid down arrow to row 10, short down arrow row 13 |  |
| 2 | J1 | short up arrow | .6 | row 12, down, double head, .6 | "Give off" written vertically |  |
| 2 | Carriage ′c | nothing | — | none | rows 14–15 "Carriage pre[vented]"; "vented" over the band rule above row 1 |  |
| 2 | ″g2 | nothing | — | none |  |  |
| 2 | ″g3 | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 2 | O3 ′ca | nothing | — | none |  |  |
| 2 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 2 | V2 Ver | nothing | — | none | "Rest" written across |  |
| 2 | V2 Cir | nothing | — | none |  |  |
| 2 | J2 | nothing | — | none |  |  |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 2 | Figs on Div axis | nothing | — | none | row 15 "006010" |  |
| 2 | R1 | nothing | — | none |  |  |
| 2 | QA Ver | nothing | — | none |  |  |
| 2 | QA Cir | nothing | — | none |  |  |
| 2 | Figure wheels (QA) N.º 3 | nothing | — | none | "Eighth" across, row 7 |  |
| 2 | Figure wheels (QA) N.º 4 | nothing | — | none |  |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "0" |  |
| 2 | n−1 | nothing | — | none | row 3 "2" |  |
| 2 | n−2 | nothing | — | none | row 3 "0" |  |
| 2 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 2 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 2 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 3 | N [?] | nothing | — | none |  |  |
| 3 | R [?] | nothing | — | none | short up arrow, row 9 |  |
| 3 | Axis A Ver | short **down** arrow | **4** (no point; ×1.2) | row 12, **up**, double head, **no figure** (×1.2) | "Step up quotient" written vertically (Axis A Ver / Cir) | label "B 8" |
| 3 | Axis A Cir | nothing | — | none |  |  |
| 3 | Figure wheels N.º 1 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 2 | nothing | — | none | short up arrow row 9; row 11 "Zero Figs" |  |
| 3 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 3 | P | nothing | — | none | "Receive Addition of 001" across, row 6 |  |
| 3 | pp | nothing | — | none |  |  |
| 3 | Carriage a | nothing | — | none | row 14 "Carry" |  |
| 3 | ap | nothing | — | none |  |  |
| 3 | g | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 3 | g1 | nothing | — | none |  |  |
| 3 | O | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 3 | T | nothing | — | none |  |  |
| 3 | Axis a Ver | nothing | — | none |  |  |
| 3 | Axis a Cir | nothing | — | none |  |  |
| 3 | Axis a10 | nothing | — | none |  |  |
| 3 | Figs on Axis A | nothing | — | none | row 15 "401" |  |
| 3 | N2 [?] | nothing | — | none | rows 12–15 "Lowered / one / Cage" |  |
| 3 | R2 [?] | nothing | — | none | long down arrow rows 8–10 (x ≈ 2690) |  |
| 3 | Axis C Ver | nothing | — | none |  |  |
| 3 | Axis C Cir | nothing | — | none |  |  |
| 3 | C1 [?] | nothing | — | none |  |  |
| 3 | C2 [?] | nothing | — | none | long down arrow; row 11 "Zero Figs"; "Subtract 03" across, row 6 |  |
| 3 | C3 [?] | nothing | — | none |  |  |
| 3 | C4 [?] | nothing | — | none |  |  |
| 3 | ″P | nothing | — | none |  |  |
| 3 | ″p″p | nothing | — | none |  |  |
| 3 | Carriage c | nothing | — | none | row 14 "Carry" |  |
| 3 | cp | nothing | — | none |  |  |
| 3 | ″g | nothing | — | none |  |  |
| 3 | ″g1 | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  | label "B 2" |
| 3 | O4 | nothing | — | none |  |  |
| 3 | T4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 3 | Axis c Ver | short **down** arrow | .25 (×1.2) | none | row 2 "U" |  |
| 3 | Axis c Cir | nothing | — | none |  |  |
| 3 | Axis c10 | short up arrow | .3 (×1.2) | none |  |  |
| 3 | Figs on Axis C | nothing | — | none | row 15 "400" |  |
| 3 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 3 | D-C Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "B 6" |
| 3 | D-C Cir | nothing | — | none | long solid down arrow, short down arrow row 13 |  |
| 3 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | D-Fig wh. 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros" |  |
| 3 | D-″P | nothing | — | none |  |  |
| 3 | D-″p″p | nothing | — | none |  | label "U" only |
| 3 | D-Carriage c | nothing | — | none | row 15 "Figs" |  |
| 3 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Step up Dividend" across, row 6 | label "B 1" |
| 3 | D-″g1 | nothing | — | none |  |  |
| 3 | O2 ca | nothing | — | none |  |  |
| 3 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 3 | V1 Ver | nothing | — | none | "Put back" across V1 Ver / J1 in row 1; "the levers upon b10" rows 2–3 | label "U 6" only |
| 3 | V1 Cir | nothing | — | none |  |  |
| 3 | J1 | nothing | — | none | "Rest" written across | label "U 4" only |
| 3 | Carriage ′c | nothing | — | none | row 15 "Zeros" |  |
| 3 | ″g2 | nothing | — | none |  |  |
| 3 | ″g3 | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  |  |
| 3 | O3 ′ca | nothing | — | none |  |  |
| 3 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 3 | V2 Ver | nothing | — | none |  |  |
| 3 | V2 Cir | nothing | — | none |  |  |
| 3 | J2 | nothing | — | none |  |  |
| 3 | ′S′S | short up arrow | 1.1 | row 12, down, double head, 1.1 |  | label "B 3" |
| 3 | ′S1 | nothing | — | none |  |  |
| 3 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 3 | Figs on Div axis | nothing | — | none | row 15 "060100" |  |
| 3 | R1 | nothing | — | none |  |  |
| 3 | QA Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 |  | label "B 8" |
| 3 | QA Cir | nothing | — | none | long solid down arrow, rows 2–10 |  |
| 3 | Figure wheels (QA) N.º 3 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 3 | Figure wheels (QA) N.º 4 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros"; "Ninth" row 5, "Step up quotient" row 7 (across) |  |
| 3 | SS | short **down** arrow | .6 | row 12, **up**, double head, .6 |  | label "B 9" |
| 3 | S1 | nothing | — | none |  |  |
| 3 | n | nothing | — | none | row 12 "2" |  |
| 3 | n−1 | nothing | — | none | row 12 "0" |  |
| 3 | n−2 | nothing | — | none | row 12 "0" |  |
| 3 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 3 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 3 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 4 | N [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis A Ver | short up arrow | cropped [?.2] | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 8" over "B 6" |
| 4 | Axis A Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | pp | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | Carriage a | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ap | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | g | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | g1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 1" |
| 4 | O | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | T | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis A | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | N2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C1 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C3 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C4 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | cp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | ″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 2" |
| 4 | O4 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B" |
| 4 | T4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | Axis c Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis C | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after the heavy rule) | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 6" |
| 4 | D-C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″P | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 3" |
| 4 | D-″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O2 ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T2 cs | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 4" |
| 4 | Carriage ′c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 2" |
| 4 | O3 ′ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T3 ′cs | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ′S′S | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 3" |
| 4 | ′S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Wire axes | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Div axis | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | QA Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 8" |
| 4 | QA Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | SS | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 9" |
| 4 | S1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |

### F029

After n−2 the rulings show three unheaded columns before the row-number column (`F021-F033-inputs.md` §3 counts four); nothing in any band.

At the foot of band 2 (the 1/3 row above the band-3 rule, y ≈ 4500–4530, image 301) "U 6" is written in Axis C Ver, "U" in ″p″p and "U 4" in cp; they are not in `F021-F033-inputs.md` and are recorded here under Other (read at 0.7).

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | N [?] | nothing | — | none |  |  |
| 1 | R [?] | nothing | — | none |  |  |
| 1 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 (×1.0) |  | label "B 6" |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 1 | Figure wheels N.º 1 | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 1 | Figure wheels N.º 2 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zeros"; "Give off" across, row 6 |  |
| 1 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 1 | P | nothing | — | none |  |  |
| 1 | pp | short up arrow | .6 | row 12, down, double head, .6 (×1.0) |  | label "B 4" |
| 1 | Carriage a | nothing | — | none |  |  |
| 1 | ap | short up arrow | .6 | row 12, down, double head, .6 (×1.0) |  | label "B 4" |
| 1 | g | nothing | — | none | a long vertical line on the ap / g rule, rows 4–15 [?re-inked ruling] | label "U 6" only |
| 1 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  | label "B 1" |
| 1 | O | nothing | — | none |  | label "U" only |
| 1 | T | nothing | — | none |  |  |
| 1 | Axis a Ver | nothing | — | none |  |  |
| 1 | Axis a Cir | nothing | — | none |  |  |
| 1 | Axis a10 | nothing | — | none |  |  |
| 1 | Figs on Axis A | nothing | — | none | "401" above row 1 |  |
| 1 | N2 [?] | nothing | — | none |  |  |
| 1 | R2 [?] | nothing | — | none | long up arrow rows 6–9; "Add 003 and Change sign of carriage from − to +" across, row 6 |  |
| 1 | Axis C Ver | nothing | — | none |  |  |
| 1 | Axis C Cir | nothing | — | none |  |  |
| 1 | C1 [?] | nothing | — | none | long up arrow rows 5–10; row 11 "Zero Figs" |  |
| 1 | C2 [?] | nothing | — | none |  |  |
| 1 | C3 [?] | nothing | — | none |  |  |
| 1 | C4 [?] | nothing | — | none |  |  |
| 1 | ″P | nothing | — | none |  |  |
| 1 | ″p″p | nothing | — | none |  |  |
| 1 | Carriage c | nothing | — | none |  |  |
| 1 | cp | nothing | — | none |  |  |
| 1 | ″g | short up arrow | .6 | row 12, down, double head, .6 |  | label "B 4" |
| 1 | ″g1 | nothing | — | none |  | label "U 2" only |
| 1 | O4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 1 | T4 | nothing | — | none |  | label "U" only |
| 1 | Axis c Ver | nothing | — | none | row 12 short up arrow + ".25" (a small mark at its top right [?]) |  |
| 1 | Axis c Cir | nothing | — | none | a short stroke, row 14 |  |
| 1 | Axis c10 | **down arrow, double head** | .3 (×1.3) | none |  |  |
| 1 | Figs on Axis C | nothing | — | none | row 15 "403" |  |
| 1 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 1 | D-C Ver | nothing | — | none |  | label "U 6" only |
| 1 | D-C Cir | nothing | — | none |  |  |
| 1 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" "Zero" |  |
| 1 | D-Fig wh. 2 | nothing | — | none |  |  |
| 1 | D-″P | short up arrow | 1.1 | row 12, down, double head, 1.1 | "Suffer Subtraction" across, row 6 | label "B 3" |
| 1 | D-″p″p | nothing | — | none |  |  |
| 1 | D-Carriage c | nothing | — | none | row 14 "Carry" |  |
| 1 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 1 | D-″g1 | nothing | — | none |  |  |
| 1 | O2 ca | nothing | — | none |  |  |
| 1 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | V1 Ver | nothing | — | none |  |  |
| 1 | V1 Cir | nothing | — | none |  |  |
| 1 | J1 | short up arrow | .6 | row 12, down, double head, .6 | "Receive Divisor" written vertically | label "B 4" |
| 1 | Carriage ′c | nothing | — | none | row 14 "Zero" |  |
| 1 | ″g2 | nothing | — | none |  |  |
| 1 | ″g3 | nothing | — | none |  | label "U 2" only |
| 1 | O3 ′ca | nothing | — | none |  |  |
| 1 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 1 | V2 Ver | nothing | — | none |  |  |
| 1 | V2 Cir | nothing | — | none | "Rest" written across |  |
| 1 | J2 | nothing | — | none |  |  |
| 1 | ′S′S | nothing | — | none |  | label "U 3" only |
| 1 | ′S1 | nothing | — | none |  |  |
| 1 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 1 | Figs on Div axis | nothing | — | none | "401" above row 1; row 15 "020000" [?] |  |
| 1 | R1 | nothing | — | none |  |  |
| 1 | QA Ver | nothing | — | none |  | label "U" + ink blot only |
| 1 | QA Cir | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 3 | nothing | — | none |  |  |
| 1 | Figure wheels (QA) N.º 4 | nothing | — | none | "Tenth" across, row 8 |  |
| 1 | SS | nothing | — | none |  | label "U 9" only |
| 1 | S1 | nothing | — | none |  |  |
| 1 | n | nothing | — | none | row 3 "2" |  |
| 1 | n−1 | nothing | — | none | row 3 "0" |  |
| 1 | n−2 | nothing | — | none | row 3 "0" |  |
| 1 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 1 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 1 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 2 | N [?] | nothing | — | none |  |  |
| 2 | R [?] | nothing | — | none | long up arrow, rows 4–8 |  |
| 2 | Axis A Ver | nothing | — | none |  | label "U" only |
| 2 | Axis A Cir | nothing | — | none |  |  |
| 2 | Figure wheels N.º 1 | nothing | — | none | long up arrow; row 11 "Figs" "Zero"; "Receive Addition of 4" across, row 6 |  |
| 2 | Figure wheels N.º 2 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 2 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 2 | P | nothing | — | none |  |  |
| 2 | pp | nothing | — | none |  | label "U 4" only |
| 2 | Carriage a | nothing | — | none | row 14 up arrow + "Carry" |  |
| 2 | ap | nothing | — | none |  | label "U 4" only |
| 2 | g | nothing | — | none |  |  |
| 2 | g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, **no figure** (×1.0) |  |  |
| 2 | O | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (×1.0) |  | label "B" |
| 2 | T | nothing | — | none |  |  |
| 2 | Axis a Ver | nothing | — | none |  |  |
| 2 | Axis a Cir | nothing | — | none |  |  |
| 2 | Axis a10 | nothing | — | none |  |  |
| 2 | Figs on Axis A | nothing | — | none | row 15 "505" |  |
| 2 | N2 [?] | nothing | — | none |  |  |
| 2 | R2 [?] | nothing | — | none |  |  |
| 2 | Axis C Ver | short up arrow | .2 | row 12, down, double head, .2 | "U 6" written in the 1/3 row at the foot of this band, above the next band rule | label "B 6" |
| 2 | Axis C Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 2 | C1 [?] | nothing | — | none | dashed shaft, head at the top; row 11 "Figs" |  |
| 2 | C2 [?] | nothing | — | none | dashed shaft, head at the lower end; row 11 "Zero"; "Give off" across, row 6 |  |
| 2 | C3 [?] | nothing | — | none |  |  |
| 2 | C4 [?] | nothing | — | none |  |  |
| 2 | ″P | nothing | — | none |  |  |
| 2 | ″p″p | short up arrow | .6 | row 12, down, double head, .6 (×1.0) | "U" written in the 1/3 row at the foot of this band | label "B 4" |
| 2 | Carriage c | nothing | — | none |  |  |
| 2 | cp | short up arrow | .6 | row 12, down arrow, .6 (head [?single]; ×1.0) | "U 4" written in the 1/3 row at the foot of this band | label "B 4" |
| 2 | ″g | nothing | — | none |  | label "U" only |
| 2 | ″g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 (×0.7) |  | label "B 3" |
| 2 | O4 | nothing | — | none |  | label "U" only |
| 2 | T4 | nothing | — | none |  |  |
| 2 | Axis c Ver | short **down** arrow (head [?double]; ×1.2) | .25 | none | row 2 "U"; rows 11–12 "B" + short up arrow + ".25"; short up arrow rows 13–14 (Axis c Cir) |  |
| 2 | Axis c Cir | nothing | — | none |  |  |
| 2 | Axis c10 | short **down** arrow, single head | **no figure** (×1.3) | none | row 2 "Lower" over "U" |  |
| 2 | Figs on Axis C | nothing | — | none | row 15 "403" |  |
| 2 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 2 | D-C Ver | nothing | — | none |  |  |
| 2 | D-C Cir | nothing | — | none |  |  |
| 2 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" "Zero" |  |
| 2 | D-Fig wh. 2 | nothing | — | none |  |  |
| 2 | D-″P | short up arrow | 1.1 | row 12, down, double head, **no figure** |  |  |
| 2 | D-″p″p | nothing | — | none |  |  |
| 2 | D-Carriage c | nothing | — | none | rows 14–15 "Carri / age / pre / vented" |  |
| 2 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Suffer Subtraction" row 6, "Sign changed from + to −" row 8 (across) |  |
| 2 | D-″g1 | nothing | — | none |  |  |
| 2 | O2 ca | nothing | — | none |  |  |
| 2 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 2 | V1 Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "B 6" |
| 2 | V1 Cir | nothing | — | none | long solid down arrow to row 9, short down arrow row 13; "Bring to Zero" written vertically |  |
| 2 | J1 | nothing | — | none |  | label "U" only |
| 2 | Carriage ′c | nothing | — | none | row 14 "Zeros" |  |
| 2 | ″g2 | nothing | — | none |  |  |
| 2 | ″g3 | nothing | — | none |  |  |
| 2 | O3 ′ca | nothing | — | none |  |  |
| 2 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  |  |
| 2 | V2 Ver | nothing | — | none |  |  |
| 2 | V2 Cir | nothing | — | none |  |  |
| 2 | J2 | short up arrow | .6 | row 12, down, double head, .6 | "Receive Divisor" written vertically | label "B 4" |
| 2 | ′S′S | nothing | — | none |  |  |
| 2 | ′S1 | nothing | — | none |  |  |
| 2 | Wire axes | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 2 | Figs on Div axis | nothing | — | none | row 15 "080700" |  |
| 2 | R1 | nothing | — | none | row 3 short up arrow |  |
| 2 | QA Ver | nothing | — | none |  |  |
| 2 | QA Cir | nothing | — | none |  |  |
| 2 | Figure wheels (QA) N.º 3 | nothing | — | none | row 3 short up arrow; "Eleventh" across, row 8 |  |
| 2 | Figure wheels (QA) N.º 4 | nothing | — | none |  |  |
| 2 | SS | nothing | — | none |  |  |
| 2 | S1 | nothing | — | none |  |  |
| 2 | n | nothing | — | none | row 3 "2" |  |
| 2 | n−1 | nothing | — | none | row 3 "0" |  |
| 2 | n−2 | nothing | — | none | row 3 "1" |  |
| 2 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 2 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 2 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 3 | N [?] | nothing | — | none |  |  |
| 3 | R [?] | nothing | — | none |  |  |
| 3 | Axis A Ver | nothing | — | none |  |  |
| 3 | Axis A Cir | nothing | — | none |  |  |
| 3 | Figure wheels N.º 1 | nothing | — | none | row 11 "Figs" "Zero" (no arrow seen) |  |
| 3 | Figure wheels N.º 2 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels N.º 4 | nothing | — | none |  |  |
| 3 | P | nothing | — | none |  |  |
| 3 | pp | nothing | — | none |  |  |
| 3 | Carriage a | nothing | — | none | row 14 "Carry"; "Change sign of Carriage from + to −" across, row 6 |  |
| 3 | ap | nothing | — | none |  |  |
| 3 | g | nothing | — | none |  |  |
| 3 | g1 | nothing | — | none |  | label "U" only (the band-2 return heads lie on the rule just above it) |
| 3 | O | nothing | — | none |  | label "U" only |
| 3 | T | nothing | — | none |  |  |
| 3 | Axis a Ver | nothing | — | none | row 12 short up arrow + ".25" |  |
| 3 | Axis a Cir | nothing | — | none | short up arrow, row 14 |  |
| 3 | Axis a10 | nothing | — | none | a long double vertical stroke, rows 4–10 (on or beside the a10 / Figs rule) |  |
| 3 | Figs on Axis A | nothing | — | none | row 15 "505" |  |
| 3 | N2 [?] | nothing | — | none | rows 12–15 "Lowered / one / Cage" |  |
| 3 | R2 [?] | nothing | — | none | short down arrow, row 9 |  |
| 3 | Axis C Ver | nothing | — | none |  |  |
| 3 | Axis C Cir | nothing | — | none |  |  |
| 3 | C1 [?] | nothing | — | none | short down arrow row 10; row 11 "Figs" "Zeros"; "Subtract 001" across, row 6 |  |
| 3 | C2 [?] | nothing | — | none |  |  |
| 3 | C3 [?] | nothing | — | none |  |  |
| 3 | C4 [?] | nothing | — | none |  |  |
| 3 | ″P | nothing | — | none |  |  |
| 3 | ″p″p | nothing | — | none |  |  |
| 3 | Carriage c | nothing | — | none | row 14 "Carry" |  |
| 3 | cp | nothing | — | none |  |  |
| 3 | ″g | nothing | — | none |  |  |
| 3 | ″g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 3 | O4 | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| 3 | T4 | nothing | — | none |  |  |
| 3 | Axis c Ver | nothing | — | none |  |  |
| 3 | Axis c Cir | nothing | — | none |  |  |
| 3 | Axis c10 | nothing | — | none |  |  |
| 3 | Figs on Axis C | nothing | — | none | row 15 "402" |  |
| 3 | (no head, after the heavy rule) | nothing | — | none |  |  |
| 3 | D-C Ver | nothing | — | none |  |  |
| 3 | D-C Cir | nothing | — | none |  |  |
| 3 | D-Fig wh. 1 | nothing | — | none | dashed shaft, head at the lower end; row 11 "Figs" "Zeros" |  |
| 3 | D-Fig wh. 2 | nothing | — | none |  |  |
| 3 | D-″P | short up arrow | **no figure** | row 12, down, double head, **no figure** | "Return the Divisor" across, row 6 |  |
| 3 | D-″p″p | short up arrow | **no figure** | none |  | label "B 3" |
| 3 | D-Carriage c | nothing | — | none | rows 14–15 "Carri / age / pre / vented" |  |
| 3 | D-″g | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 | "Sign changed from − to +" across, row 8 |  |
| 3 | D-″g1 | nothing | — | none |  |  |
| 3 | O2 ca | nothing | — | none |  |  |
| 3 | T2 cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (×0.7) |  |  |
| 3 | V1 Ver | nothing | — | none | "Rest" written across | label "U 6" only |
| 3 | V1 Cir | nothing | — | none |  |  |
| 3 | J1 | nothing | — | none |  |  |
| 3 | Carriage ′c | nothing | — | none | row 14 "Zeros" |  |
| 3 | ″g2 | nothing | — | none |  |  |
| 3 | ″g3 | nothing | — | none |  |  |
| 3 | O3 ′ca | nothing | — | none |  |  |
| 3 | T3 ′cs | short up arrow | .45 | rows 15–1/3, down, double head, **no figure** (×0.7) |  |  |
| 3 | V2 Ver | short up arrow | .2 | row 12, down, double head, .2 | "Put back" and "the levers upon b10" across V2 Ver / V2 Cir, rows 11–14 | label "B.6" |
| 3 | V2 Cir | nothing | — | none | long solid down arrow to row 10, short down arrow row 13 |  |
| 3 | J2 | short up arrow | .6 | row 12, down, double head, .6 | "Give off" written vertically | no label |
| 3 | ′S′S | nothing | — | none |  |  |
| 3 | ′S1 | nothing | — | none |  |  |
| 3 | Wire axes | nothing | — | none | **nothing** (no up/down pair in this band) |  |
| 3 | Figs on Div axis | nothing | — | none | figures above row 1 cut by the strip (not read); row 15 "020000" |  |
| 3 | R1 | nothing | — | none |  |  |
| 3 | QA Ver | nothing | — | none |  |  |
| 3 | QA Cir | nothing | — | none |  |  |
| 3 | Figure wheels (QA) N.º 3 | nothing | — | none |  |  |
| 3 | Figure wheels (QA) N.º 4 | nothing | — | none | "Twelfth" across, row 8 |  |
| 3 | SS | nothing | — | none |  |  |
| 3 | S1 | nothing | — | none |  |  |
| 3 | n | nothing | — | none | row 3 "2" |  |
| 3 | n−1 | nothing | — | none | row 3 "0" |  |
| 3 | n−2 | nothing | — | none | row 3 "1" |  |
| 3 | (no head, after n−2) 1 | nothing | — | none |  |  |
| 3 | (no head, after n−2) 2 | nothing | — | none |  |  |
| 3 | (no head, after n−2) 3 | nothing | — | none |  |  |
| 4 | N [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis A Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis A Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | pp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage a | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ap | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 1" |
| 4 | g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B" |
| 4 | Axis a Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis a10 | short up arrow (head [?double]) | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B" |
| 4 | Figs on Axis A | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | N2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C1 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C2 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C3 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | C4 [?] | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | cp | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O4 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Axis c10 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Axis C | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after the heavy rule) | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-C Ver | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 5" |
| 4 | D-C Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Fig wh. 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″P | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U" |
| 4 | D-″p″p | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-Carriage c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | D-″g1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | O2 ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T2 cs | short up arrow | cropped [?.45] | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V1 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Carriage ′c | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ″g3 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 2" |
| 4 | O3 ′ca | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | T3 ′cs | short up arrow | cropped [?.45] | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | V2 Ver | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U.6" |
| 4 | V2 Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | J2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  | label "U 4" |
| 4 | ′S′S | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | ′S1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 3" |
| 4 | Wire axes | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figs on Div axis | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | R1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | QA Ver | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B [?7]" (blotted) |
| 4 | QA Cir | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | Figure wheels (QA) N.º 4 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | SS | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | S1 | short up arrow | cropped | cropped/not photographed (paper or photograph ends inside row 1) |  | label "B 9" |
| 4 | n | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | n−2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 1 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 2 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |
| 4 | (no head, after n−2) 3 | nothing (in the visible part) | — | cropped/not photographed (paper or photograph ends inside row 1) |  |  |

## 3. F/032, "Ordinary cycle of 16" (image 311)

**Rows** as `F021-F033-inputs.md` §4: the label and row 1 share the ruled
cell under each band rule (y ≈ 704, 2384, 4080); rows 2–15 follow, 1/3 closes
the band. Below band 3's row 1 the sheet is ruled but empty to its foot
(title "Ordinary Cycle of 16" written across it).

**Columns** (x on 311, from the rules at y 1000–2300): Axis A Ver 245–436,
Cir 436–629; Figure wheel N.º 1 629–829, N.º 2 829–1021; no head 1021–1213,
1213–1413; pp 1413–1599; ″P 1599–1799; ap 1799–1991; g 1991–2187; g1
2187–2379; Fig wh. N.º 1 on B 2379–2568; no head 2568–2693; ′p′p 2693–2888;
Carr b 2888–3080; ′g1 3080–3268; Wire Axes E 3268–3462; Lock Cent.
3462–3654; Lock Fig wh. 3654–3853; Lock Carr. 3853–4048; Long time
4048–4239; Short time 4239–4429; Bolt 4429–4631; three no-head columns
4631–5235.

**Regions.** Row 1: x 200–5257, y 680–920, 2360–2600, 4055–4300 at 0.6.
Rows 2–10: y 880–1900 and 2560–3560 at 0.33. Rows 11–1/3: y 1850–2400 and
3530–4085 at 0.4. Whole sheet at 0.17.

Columns read per band: 26.

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| 1 | Axis A Ver | short up arrow | .4 | row 12, down, double head, .4 |  | no label |
| 1 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 1 | Figure wheel N.º 1 | nothing | — | none | dashed shaft rows 2–10, head at the lower end; "Give off" written vertically |  |
| 1 | Figure wheel N.º 2 | nothing | — | none | dashed shaft rows 2–10, head at the lower end; a vertical word struck through [?"~~Reserve~~"], and "Receive" / "Retain" [?] written vertically rows 11–15 (read at 0.17–0.33 only) |  |
| 1 | (no head, x 1021–1213) | nothing | — | none |  |  |
| 1 | (no head, x 1213–1413) | nothing | — | none |  |  |
| 1 | Cen. pinion pp | nothing | — | none |  |  |
| 1 | Cent pin. ″P | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 1 | Cen pin. ap | short up arrow | .6 | row 12, down, double head, .6 |  | label "L 4" |
| 1 | Carr. pin. g | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 1 | Carr. pin. g1 | nothing | — | none |  |  |
| 1 | Fig wh. N.º 1 on B | nothing | — | none | dashed shaft rows 2–10, head at the lower end; "Receive" written vertically; row 14 short down arrow with a dotted shaft |  |
| 1 | (no head, x 2568–2693) | nothing | — | none |  |  |
| 1 | Cen pinion ′p′p | short up arrow | 1.1 | row 12, down, double head, 1.1 |  | label "L N.º 3" |
| 1 | Carr b | nothing | — | none | dashed shaft rows 2–10, head at the lower end; row 14 down arrow + "Carry" |  |
| 1 | Carr. pin. ′g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  | label "L N.º 3" |
| 1 | Wire Axes E | nothing | — | none | row 12 short up arrow, row 13 short down arrow (single heads) |  |
| 1 | Lock Cent. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 1 | Lock Fig wh. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 1 | Lock Carr. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 1 | Platforms Long time | an up arrow and a down arrow side by side | no figures | rows 15–1/3: a down arrow, double head, and an up arrow, double head, side by side; no figures |  |  |
| 1 | Platforms Short time | an up arrow and a down arrow side by side | no figures | row 12: a down arrow, double head, and an up arrow, double head, side by side; no figures |  |  |
| 1 | Bolt to Platforms | nothing | — | none |  |  |
| 1 | (no head, x 4631–4817) | nothing | — | none |  |  |
| 1 | (no head, x 4817–5015) | nothing | — | none |  |  |
| 1 | (no head, x 5015–5235) | nothing | — | none |  |  |
| 2 | Axis A Ver | short up arrow | .2 | row 12, down, double head, .2 |  | label "U 5 B 6" |
| 2 | Axis A Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| 2 | Figure wheel N.º 1 | nothing | — | none | dashed shaft rows 2–10, head at the lower end; a vertical word struck through [?"~~Reserve~~"]; "Receive" written vertically rows 11–14 [?column] |  |
| 2 | Figure wheel N.º 2 | nothing | — | none | dashed shaft rows 2–10, head at the lower end; "Give off" written vertically |  |
| 2 | (no head, x 1021–1213) | nothing | — | none |  |  |
| 2 | (no head, x 1213–1413) | nothing | — | none |  |  |
| 2 | Cen. pinion pp | short up arrow | .6 | row 12, down, double head, .6 |  | label "L 4" |
| 2 | Cent pin. ″P | nothing | — | none |  | label "U 3" only |
| 2 | Cen pin. ap | short up arrow | .6 | row 12, down, double head, .6 |  |  |
| 2 | Carr. pin. g | nothing | — | none |  | label "U 4" only |
| 2 | Carr. pin. g1 | short up arrow | 1.1 | row 12, down, double head, 1.1 |  | label "L 3" |
| 2 | Fig wh. N.º 1 on B | nothing | — | none | dashed shaft rows 2–10, head at the lower end; "Receive" written vertically; row 14 short down arrow with a dotted shaft |  |
| 2 | (no head, x 2568–2693) | nothing | — | none |  |  |
| 2 | Cen pinion ′p′p | short up arrow | 1.1 | row 12, down, double head, 1.1 |  |  |
| 2 | Carr b | nothing | — | none | dashed shaft rows 2–10, head at the lower end; row 14 down arrow + "Carry" |  |
| 2 | Carr. pin. ′g1 | short up arrow | 1.1 | rows 15–1/3, down, double head, 1.1 |  |  |
| 2 | Wire Axes E | nothing | — | none | row 12 short up arrow, row 13 short down arrow |  |
| 2 | Lock Cent. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 2 | Lock Fig wh. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 2 | Lock Carr. | short up arrow + "U" | — | none | rows 10–11 short down arrow + "L"; row 13 short up arrow + "U"; row 14 short down arrow + "L" (staggered from column to column) |  |
| 2 | Platforms Long time | an up arrow and a down arrow side by side | no figures | rows 15–1/3: down arrow, double head, and up arrow, double head, side by side; no figures |  |  |
| 2 | Platforms Short time | an up arrow and a down arrow side by side | no figures | row 12: down arrow, double head, and up arrow, double head, side by side; no figures |  |  |
| 2 | Bolt to Platforms | short down arrow + "B&U" (written at the top of the cell, as the label) | — | none |  |  |
| 2 | (no head, x 4631–4817) | nothing | — | none |  |  |
| 2 | (no head, x 4817–5015) | nothing | — | none |  |  |
| 2 | (no head, x 5015–5235) | nothing | — | none |  |  |
| 3 | Axis A Ver | short up arrow | .4 | none (rows below empty to the foot of the sheet) |  | label "U 6 B 5" |
| 3 | Axis A Cir | nothing | — | none |  |  |
| 3 | Figure wheel N.º 1 | nothing | — | none |  |  |
| 3 | Figure wheel N.º 2 | nothing | — | none |  |  |
| 3 | (no head, x 1021–1213) | nothing | — | none |  |  |
| 3 | (no head, x 1213–1413) | nothing | — | none |  |  |
| 3 | Cen. pinion pp | nothing | — | none |  | label "U 4" only |
| 3 | Cent pin. ″P | short up arrow | 1.1 | none |  | label "B 3" |
| 3 | Cen pin. ap | short up arrow | .6 | none |  |  |
| 3 | Carr. pin. g | short up arrow | .6 | none |  | label "B 4" |
| 3 | Carr. pin. g1 | nothing | — | none |  | label "U 3" only |
| 3 | Fig wh. N.º 1 on B | nothing | — | none |  |  |
| 3 | (no head, x 2568–2693) | nothing | — | none |  |  |
| 3 | Cen pinion ′p′p | nothing | — | none |  |  |
| 3 | Carr b | nothing | — | none |  |  |
| 3 | Carr. pin. ′g1 | short up arrow | 1.1 | none |  |  |
| 3 | Wire Axes E | nothing | — | none |  |  |
| 3 | Lock Cent. | short up arrow + "U" | — | none |  |  |
| 3 | Lock Fig wh. | short up arrow + "U" | — | none |  |  |
| 3 | Lock Carr. | short up arrow + "U" | — | none |  |  |
| 3 | Platforms Long time | an up arrow and a down arrow side by side | no figures | none |  |  |
| 3 | Platforms Short time | an up arrow and a down arrow side by side | no figures | none |  |  |
| 3 | Bolt to Platforms | short down arrow + "B&U" (label part of the cell) | — | none |  |  |
| 3 | (no head, x 4631–4817) | nothing | — | none |  |  |
| 3 | (no head, x 4817–5015) | nothing | — | none |  |  |
| 3 | (no head, x 5015–5235) | nothing | — | none |  |  |

## 4. F/033, "Notation of carriage" (image 316)

Band names as `F021-F033-inputs.md` §5. Each table has a first label row
with row 1 (U1, L1), rows 2–15, and a second label row with row 1 (U2, L2)
after which the table ends; the off-row labels of §5 (U-mid, L-mid, L12,
"one row lower") fall inside these bands and are given under Other / Notes.
In the upper table the returns lie in row 12 or rows 15–1/3; in the lower
table in row 12, or in row 12 of the cycle-of-12 sub-table (whose own
"1/3", "2/3", "1" rows lie at y ≈ 5440–5540 in the narrow column).

**Columns:** x as in `F021-F033-inputs.md` §5; the Change-fig groups of the
lower table were split at x 4469 / 4630 / 4790 / 4940 and 4940 / 5110 / 5290
/ 5468.

**Regions.** Upper: U1 row 1 (250–5498, 780–1010) at 0.55 and (800–1600,
840–1000), (4400–5430, 840–1000) at 1.0; rows 2–10 (250–5498, 950–2000) at
0.3; rows 11–13 (250–5498, 1900–2300) and rows 14–1/3 (2300–2560) at 0.55;
row 12 (400–2400, 2020–2160) at 0.8–0.9; rows 15–1/3 (1750–4800, 2380–2520)
at 0.7; U2 (250–5498, 2560–2720) at 0.55 and (4400–5430, 2380–2720) at 1.0.
Lower: L1 row 1 (250–5498, 4130–4400) at 0.55; body (250–5498, 4300–6100) at
0.3; rows 11–13 (5280–5620), rows 15–L2 (5800–6120), and the row after
(6120–6260) at 0.55.

Columns read per band: 23 (upper table), 27 (lower table).

### Upper table

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| U1 | Red. Zero prep. Add — a Ver | short **down** arrow | .2 | row 12, **up**, double head, .2 |  | label "B 7" |
| U1 | Red. Zero prep. Add — Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| U1 | Red. Zero prep. Add — a Ver (3rd col.) | **down arrow, double head** + ".3", and beside it an **up arrow, double head**, no figure | .3 (with the down arrow) | none | row 12 short down arrow + ".3" (single head; ×0.9) | label "B"; read at ×1.0 |
| U1 | Red. Zero prep. Sub — a Ver | short **down** arrow | .4 | row 12, **up**, double head, .4 |  | label "B 8" |
| U1 | Red. Zero prep. Sub — Cir | nothing | — | none | long solid down arrow rows 2–10; short down arrow row 13 |  |
| U1 | Red. Zero prep. Sub — a 10 Ver | **down arrow, double head** + ".3", and beside it an **up arrow, double head**, no figure | .3 (with the down arrow) | none | row 12 short up arrow + ".3" (single head; ×0.9) | label "B"; ×1.0 |
| U1 | Rec. figs upper — ap Ver | short up arrow | .6 | row 12, down, double head, .6 (×0.9) |  | label "B 4" |
| U1 | Rec. figs upper — O Ver | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| U1 | Rec. figs lower — ap Ver | short **down** arrow | .6 | row 12, **up**, double head, .6 |  | label "B 9" |
| U1 | Rec. figs lower — O Ver | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| U1 | Rec. not thro' Cent — O Ver | short up arrow | .45 | none | rows 15–1/3 down arrow + ".45", head **[?single]** (×0.7) | label "B" |
| U1 | Rec. Add upper — ap Ver | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  | label "B 2" |
| U1 | Rec. Add upper — O Ver | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| U1 | Rec. Add lower — ap Ver | short **down** arrow | .6 | rows 15–1/3, **up**, double head, .6 |  | label "B 11" |
| U1 | Rec. Add lower — O Ver | short up arrow | .45 | none | rows 15–1/3 down arrow + ".45", head **[?single]** (×0.7) | label "B" |
| U1 | Suff. Sub up — ap Ver | short up arrow | .6 | rows 15–1/3, down, double head, .6 |  | label "B 2" |
| U1 | Suff. Sub up — T Ver | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| U1 | Suff. Sub low — ap Ver | short **down** arrow | .6 | rows 15–1/3, **up**, double head, .6 |  | label "B 11" |
| U1 | Suff. Sub low — T Ver | short up arrow | .45 | rows 15–1/3, down, double head, .45 |  | label "B" |
| U1 | Suff. Sub not thro' — T Ver | short up arrow | .45 | none | rows 15–1/3 short down arrow + ".45", single head (×1.0) | label "B" |
| U1 | Change fig Add→Sub — a Ver | nothing | — | none | rows 11–12: "B 7" + short up arrow + ".2" (single head); rows 15–1/3: short down arrow + ".2", head on the rule above "U 7", head [?double] (×1.0) | no label in this row |
| U1 | Change fig Add→Sub — Cir | nothing | — | none | rows 13–14 short down arrow + "36°" |  |
| U1 | Change fig Add→Sub — a 10 Ver | **up arrow, double head** | .3 (×1.0) | none | rows 15–1/3: short up arrow + ".3" (single head), foot on the rule above "U" | label "B" |
| U2 | Red. Zero prep. Add — a Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Red. Zero prep. Add — Cir | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Red. Zero prep. Add — a Ver (3rd col.) | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Red. Zero prep. Sub — a Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Red. Zero prep. Sub — Cir | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Red. Zero prep. Sub — a 10 Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. figs upper — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. figs upper — O Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. figs lower — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. figs lower — O Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. not thro' Cent — O Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. Add upper — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. Add upper — O Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. Add lower — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Rec. Add lower — O Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Suff. Sub up — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Suff. Sub up — T Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Suff. Sub low — ap Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Suff. Sub low — T Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Suff. Sub not thro' — T Ver | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Change fig Add→Sub — a Ver | nothing | — | none (the upper table ends) |  | labels written one row lower, "U 7"; the arrow above it belongs to rows 15–1/3 of U1 |
| U2 | Change fig Add→Sub — Cir | nothing | — | none (the upper table ends after this row) |  |  |
| U2 | Change fig Add→Sub — a 10 Ver | nothing | — | none (the upper table ends) |  | label "U" one row lower |

### Lower table

| Band | Column | Row-1 mark | Figure | Returns (row, direction, figure) | Other | Notes |
|---|---|---|---|---|---|---|
| L1 | Ch. fig Sub→Add — a Ver | nothing | — | none | memorandum rows 3–8 across the x group: "Mem.ᵐ 26 March 1836. The 10s axis <u>must</u> be neutral while changing fig. wh. of carriage"; rows 11–12 "B 7" + short up arrow + ".2" (single head) |  |
| L1 | Ch. fig Sub→Add — Cir | nothing | — | none | row 14 short up arrow + "36°" |  |
| L1 | Ch. fig Sub→Add — a 10 Ver | short down arrow | .3 | none |  | label "B" |
| L1 | "x" a 10 Ver | nothing | — | none | rows 2–10 "moved / by a / lever / a10 at / one end / plat.ᵐ / at other / fulc.ᵐ / between"; rows 11–12 "B 9" + short down arrow + ".3" (single head) |  |
| L1 | "y" a 10 Ver | nothing | — | row 12, **up**, double head, .3 (written under "B 4", row 11) |  |  |
| L1 | Red. Zero after Add prep. Add — a Ver | short down arrow | .2 | row 12, **up**, double head, .2 | memorandum rows 2–11 across this and the next column: "26 March The 10s axis need not be neutral while red.ᵍ to zero as it is not moved far enough to give notice"; a dashed vertical line rows 3–9 near the rule between the two columns | label "B 7" |
| L1 | Red. Zero after Sub prep. Sub — a Ver | short down arrow | .4 | row 12, **up**, double head, .4 |  | label "B 8" |
| L1 | Carry — Axis G Ver | nothing | — | none | a short down arrow in the head's 1/3 row above the band rule; row 2 an up arrow whose head is on the rule under row 1; rows 15–1/3 short down arrow (single) |  |
| L1 | Carry — Axis G Cir | a long down arrow from the head, its head in row 1 | no figure | none | "28½°" [?] and "180°" in the head; a long vertical stroke rows 10–14; row 14 "Carry"; a long down arrow through 15–1/3 into L2 row 1 |  |
| L1 | Carry — Wire Axis E Ver | nothing | — | none | row 12 short up arrow, row 13 short down arrow (single heads); a short down arrow in the head |  |
| L1 | Red. Zero after Add prep. Sub — a Ver | short down arrow | .4 | row 12, **up**, double head, .4 |  | label "B 8" |
| L1 | Red. Zero after Add prep. Sub — a 10 Ver | short up arrow | .6 | none |  | label "B" |
| L1 | (narrow, no head) | nothing | — | none | holds the sub-table's row names "12", "1/3", "2/3", "1" |  |
| L1 | Prep. to Addition — a Ver | short down arrow | .2 | sub-table row 12, **up**, double head, **no figure** (0.55) | then "U 7" in the sub-table's 2/3 row | label "B 7" |
| L1 | Prep. to Addition — Cir | nothing | — | none | long solid down arrow rows 2–10; sub-table 2/3 row short down arrow |  |
| L1 | Prep. to Addition — a 10 Ver | **up arrow, double head** + ".3", and beside it a **down arrow, double head**, no figure | .3 (with the up arrow) | none | sub-table row 12 short down arrow + ".3" (single head), then "U" | label "B" |
| L1 | Prep. to Subtraction — a Ver | short down arrow | .4 | sub-table row 12, **up**, double head, **no figure** (0.55) | then "U 8" | label "B 8" |
| L1 | Prep. to Subtraction — Cir | nothing | — | none | long solid down arrow rows 2–10; sub-table 2/3 row short down arrow |  |
| L1 | Prep. to Subtraction — a 10 Ver | **up arrow, double head** + ".3", and beside it a **down arrow, double head**, no figure | .3 (with the up arrow) | none | sub-table row 12 short up arrow + ".3" (single head), then "U" | label "B" |
| L1 | Red. Zero after Sub prep. Add — a Ver | short down arrow | .2 | none | at the end of the sub-table's 1/3 rule (row 11–12): short up arrow + ".2" (single head) | label "B 7" |
| L1 | Red. Zero after Sub prep. Add — a 10 Ver | short down arrow | .6 | none |  | label "B" |
| L1 | Ch. fig Add→Sub — a Ver | nothing | — | none | rows 3–9 "If fig wheel stands at 0 a 10 must be moved <u>before</u> cir. motion of a if at 9 <u>after</u>"; rows 11–12 "B 7" + short up arrow + "[?.]2" (single head) |  |
| L1 | Ch. fig Add→Sub — Cir | nothing | — | none | rows 13–14 short down arrow + "36°" |  |
| L1 | Ch. fig Add→Sub — a 10 Ver | nothing | — | none |  |  |
| L1 | Ch. fig Sub→Add (2nd) — a Ver | nothing | — | none | rows 3–8 "If fig wh. stands at 9 a 10 must be moved <u>be</u>fore cir. mo. of a if at 0 <u>after</u>" |  |
| L1 | Ch. fig Sub→Add (2nd) — Cir | nothing | — | none |  |  |
| L1 | Ch. fig Sub→Add (2nd) — a 10 Ver | nothing | — | none |  |  |
| L2 | Ch. fig Sub→Add — a Ver | short down arrow, head [?double] | .2 | none (the lower table ends) |  | label "U 7" one row lower |
| L2 | Ch. fig Sub→Add — Cir | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Sub→Add — a 10 Ver | short down arrow | .3 | none (the lower table ends) |  | label "U" one row lower |
| L2 | "x" a 10 Ver | short down arrow | .3 | none (the lower table ends) |  | label "U 9 B 4"; "U 4" one row lower |
| L2 | "y" a 10 Ver | short up arrow | .3 | none (the lower table ends) |  | label "U 4 B 9"; "U 9" one row lower |
| L2 | Red. Zero after Add prep. Add — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Red. Zero after Sub prep. Sub — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Carry — Axis G Ver | nothing | — | none (the lower table ends) | an up arrow from the rule under row 1 downward (head at its top) |  |
| L2 | Carry — Axis G Cir | long down arrow continued from L1 15–1/3, head in this row | no figure | none (the lower table ends) |  |  |
| L2 | Carry — Wire Axis E Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Red. Zero after Add prep. Sub — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Red. Zero after Add prep. Sub — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | (narrow, no head) | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Addition — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Addition — Cir | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Addition — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Subtraction — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Subtraction — Cir | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Prep. to Subtraction — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Red. Zero after Sub prep. Add — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Red. Zero after Sub prep. Add — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Add→Sub — a Ver | short down arrow, head [?double] | .2 | none (the lower table ends) |  | label "U 7" one row lower |
| L2 | Ch. fig Add→Sub — Cir | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Add→Sub — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Sub→Add (2nd) — a Ver | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Sub→Add (2nd) — Cir | nothing | — | none (the lower table ends after this row) |  |  |
| L2 | Ch. fig Sub→Add (2nd) — a 10 Ver | nothing | — | none (the lower table ends after this row) |  |  |

Below the lower table: memoranda and struck crosses (not read here), and
two horizontal double-headed arrows (↔) drawn across the Red. Zero after Add
prep. Add – Axis G Ver columns and across the Red. Zero after Add prep. Sub
columns at y ≈ 6180–6200 (read at 0.55; not motion arrows in a column).

## 5. What could not be read

- **Cropped/not photographed:** band 4 of F/021–024 below row 1 (the table
  ends); band 4 of F/026–029 below the top of row 1 (paper or photograph
  ends) — the figures of the band-4 row-1 arrows are cut off and are given
  as "cropped" (a few as `[?x]`).
- **Unreadable:** F/022 band 2 ′S1 row 5, a small scribbled mark; the blot
  over F/029 QA Ver's band-1 label (label only; no arrow under it).
- **Doubtful heads or figures:** F/026 band 2 J1 return "6" [?.6]; F/027
  band 2 J1 return "6" [?point] (0.3 only); F/029 band 2 Axis c Ver row-1
  head [?double], cp return head [?single]; F/033 Rec. not thro' Cent — O
  Ver and Rec. Add lower — O Ver returns (head [?single]); F/033 lower L2
  Ch. fig Sub→Add — a Ver and Ch. fig Add→Sub — a Ver row-1 heads
  [?double]; F/029 band 4 Axis a10 head [?double].
- **Not done:** the words and numbers in the bodies were read at 0.3 only
  and are given for orientation, not as transcriptions; memoranda were not
  transcribed beyond what is quoted.
