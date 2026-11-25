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
