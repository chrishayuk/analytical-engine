# Sources

The downloaded images and records are not kept in the repository (see
`.gitignore`). This is where they came from, so they can be fetched again.

## The manuscripts

**The Babbage Papers**, Science Museum Group, London. Series L,
*Notations of calculations for the Analytical Engine* (BAB/L, document
`aa110000020`): "27 sets of notations consisting of 36 sheets", 1836-1840,
"arranged alpha-numerically in date order". The catalogue's titles are
Bromley's, as its description says.

- Records: `https://collection.sciencemuseumgroup.org.uk/documents/<id>`,
  as JSON with `Accept: application/json` (BAB/L/001 is `aa110000065`).
  The site refuses requests without a browser-like user agent.
- Images: the record lists each image's zoom path, e.g.
  `222/594/Solution_of_two_simultaneous_equations.ptif`. The IIIF service is
  `https://zoom.sciencemuseumgroup.org.uk/iiif/3/<path, url-encoded>/…`.
  It serves a region at full size (`/x,y,w,h/max/0/default.jpg`) and whole
  tiles; other sizes are refused, so regions are fetched at full size and
  reduced locally.
- Licence: the images are marked "Non-Commercial Use". They are not
  redistributed here.

`scripts/fetch-catalogue.py BAB/L/001 …` fetches the records;
`scripts/fetch-region.py` fetches a region of an image, as the transcriber
read it.

### BAB/L/001

Three images. `222/593`: the cover, "Notations of Calculation", listing
No. 1 (4 Aug 1837) and No. 2 (Aug. 5) with their counts; marked "E 1905" and
"BAB [L] 1". `222/594` (7817 × 6392): the opened sheet, No. 1 above and No. 2
below, "4 Aug 1837" at the top right. `222/595`: the back, "4 Augt 1837",
and the definition of the complement sign.

### BAB/L/002

Document `aa110000066`. Three images: `222/622`, the cover, "Notation for
the coeffecients of the powers of x", dated "14 Aug 1837 No 2"; `222/624`
(8064 × 6467), the opened sheet with one table of 30 operations; `222/626`,
the back. See [`notes/L002.md`](notes/L002.md).

### BAB/L/003

Document `aa110000067`, "Computation of the coefficients of a polynomial
from those of another divided by a quadratic term". The catalogue record has
no images. Rojas (2017, Table 3) lists program 3 as not in the archive.

### BAB/L/004 to BAB/L/027

See `notes/L004.md` to `notes/L027.md` for each sheet's images, cover and
readings. The engine runs the looped program of L/023 itself;
`checks/L023.py` is an earlier, independent script that also runs its cards
and compares them with the 35 rows.

## Secondary literature

- R. Rojas, "The first computer program", arXiv:2303.13740 (March 2023);
  published in *Communications of the ACM* (2024), doi:10.1145/3624731.
  Read in its arXiv version. A reading of BAB/L/001; see
  [`../docs/literature.md`](../docs/literature.md).

Not read, and so not relied on: R. Rojas, "The Computer Programs of Charles
Babbage", *IEEE Annals of the History of Computing* 43(1), 2021;
A. G. Bromley, "Charles Babbage's Analytical Engine, 1838", *Annals of the
History of Computing* 4(3), 1982; C. Babbage, "On the Mathematical Powers of
the Calculating Engine" (December 1837), printed in B. Randell (ed.), *The
Origins of Digital Computers* (1973 and later); the Plan 28 project's
publications.

### BAB/N/001 to BAB/N/008

The history sheets of the Analytical Engine, 1834 to 1841 (documents
`aa110000071` to `aa110000073`, `aa110001793` to `aa110001797`). See
`notes/N001.md` to `notes/N008.md`. Each note gives the images and their
zoom paths. Two drafts (N 1834 [a], N 1837 [a]) and one more (N 1839 [a])
are transcribed beside their fair copies. Some regions were read below full
resolution after the zoom server refused requests for a time; the notes say
which.

### BAB/F/001 and BAB/F/002

"Multiply a, b, c, d by 1021", about 1835, in the mechanical notation:
documents `aa110000050` and `aa110000051`. See `notes/F001.md`,
`notes/F002.md`, the data in `../mechanical/` and `../docs/f-concordance.md`.

### BAB/F/018 to BAB/F/020

"Multiplication without table", sheets 1 and 2, dated "11 Jan 1836" on the
covers, "1028 × 201" (documents `aa110000502`, `aa110000503`; images
216/270–273), and "Bolting plates to multiply without table"
(`aa110000504`; 216/277–278). See `notes/F018.md`, `notes/F020.md`,
`../mechanical/F018-cycle*.txt`, `F019-cycle*.txt` and `F020-plates.txt`.
F/020 has no date of its own; the date is in the image file names only.

### BAB/F/013

"Table multiplication.", document `aa110000497`, dated on its cover "5 Jan.y
1836". Two images: `216/258` the cover, `216/259` (9581 × 6933) the whole
opened table. The zoom server served it only as aligned 512-px tiles at
their own size; all 266 tiles of 259 were fetched and stitched. See
`notes/F013.md` and `../mechanical/F013-cycle*.txt`.

### BAB/F/014

"Bolting plates for multiplication by table.", document `aa110000498`,
undated. Two images: `216/260` the cover, `216/261` the table. See
`notes/F014.md` and `../mechanical/F014-plates.txt`.
