# A glossary of the mechanical notation of Series F, January 1836

For the marks of the multiplication sheets F/013 (by table, 5 Jan 1836),
F/014, F/018–019 (without table, 11 Jan 1836) and F/020, with what each rests
on and how far it can be trusted. The full catalogue of marks, S1–S45, is in
`f-concordance.md`; the earlier sheets F/001–002 are in `f-cycles.md`. No
person has checked the transcriptions this rests on.

**Confidence**
- **Stated**: the sheet or a source says it in words.
- **Tested**: a hypothesis that made a prediction it could have failed, and
  did not (`f-bu-audit.md`). Still a hypothesis.
- **Reading**: the likeliest of the readings the evidence allows; others
  given.
- **Unknown**: kept as written; no meaning given.

## The frame

| Mark | Meaning | Confidence | Rests on |
|---|---|---|---|
| Column heads (axes, wheels, pinions: "Axis A Ver", "″S2 Cir", "Cen Pin ″P", "R2", "'g1") | The parts of the mill, one column each; "Ver" and "Cir" a part's vertical and circular motion | Stated (heads); the identity of each part with a drawn part is a reading | F/013.md §2, F018.md §2; A/029 names the same axes (g, g1–g3, P, pp, S, SS, S1, S2T, S2B, R, C) |
| Rows ("2/3", "1"…"15", "1/3" on F/013; "1"…"16" on F/018–019) | Units of time within a cycle (a band) | Reading | the margin numbering; F/014's margin "16" and "12" count rows (inference, `f-cycles.md`) |
| Bands (between heavy rules) | One cycle of the mill | Reading | the bands repeat the same pattern with different figures |
| "top-" partial rows (F/018, F/019) | The end of the previous band, restated | Reading | F/019's top row 15 repeats F/018 cycle 3's row 15 in 9 of 10 labels (`f-bu-audit.md`) |
| "Platforms" heads N.o 1–12 with signed figures (+1.1 … −1.1), "Long time" / "Short time" (F/013 t31–t42) | Twelve travelling platforms, each with a signed lift, grouped by how long they stay moved | Stated (heads); "travelling platform" from Vol II, Vol XIII | F013.md §2; `platforms-1835-1836.md` |

## Motions

| Mark | Meaning | Confidence | Rests on |
|---|---|---|---|
| Short up arrow (S2), short down arrow (S1), with a figure (".4", "1.1") | A part moves up or down, by the figure | Reading for direction; Tested for the figure as a displacement (each B figure predicts it, 42/44) | `f-concordance.md` S1, S2; `platform_model.py` |
| Arrow with a double head (S22 up, S40 down) | The part returns to its inactive position | Reading (Bromley 1982 p 207, a source of 1838: "double arrowheads indicate a return to the inactive position"); every S40 follows an S2 in its column with the same figure | `f-concordance.md` S22, S40 |
| Stepped broken shaft (S16), with words ("Gears with N.o 1 in bottom Cage") | A circular motion over several rows of a Cir column | Reading | F/013 t11, t24 |
| Long vertical arrow (S5), Y marks (S3, S4), converging and diverging double arrows (S6, S7), hatched arrow (S10), "IF" glyph (S11, S12) | — | Unknown (F/001–002) | `f-concordance.md` |

## Connections

| Mark | Meaning | Confidence | Rests on |
|---|---|---|---|
| **"B k"** ("B3", "B N.o 9"), at the head of a band over the start of a motion | The part in that column bolted (or locked) to travelling platform k | **Tested** (hypothesis P): every B stands over a motion (50/50); each figure predicts the direction (44/44) and size (42/44) of the motion; parts on one figure in one row move alike (8/9); a timing prediction committed in advance held (2 groups, 0 against). Not stated: no source expands B | `f-bu-audit.md`; Vol II p 42 ("Lock … to Pl. 4"); A/029 ("Method of bolting to platforms for vertical motion of Axes"); Vol XIII image 90 |
| **"U k"** | The part unbolted (or unlocked) from platform k | **Tested** with B: every U follows a B of its figure in its column (F/018–019, with the restatement), and between them the part goes and returns (24/24); a U standing alone is never over a motion (0/33) | `f-bu-audit.md` |
| "U j B k" ("U5 B6", "U5B6") | Unbolted from j and bolted to k, at once | Reading, from B and U | F/018–020 |
| "B" with no figure; "B′" (F/020 f13, F/018 e22) | — | Unknown | never followed by a U |
| "U&B" in F/013's column "Bolt to platforms" (t43) | Unbolt and bolt, for all the parts at once | Reading | the head; Vol II pp 23–24, "Lock or Unlock to Travell. Platforms 2/3" |
| "U" and "L" with arrows in F/013's Lock columns (t28 Lock Cen.l, t29 Lock Fig wh, t30 Lock Carr.e) | Unlock and lock | Reading; whether these locks are Vol XIII's "locking plates" is untested | the heads; the U/L pairing |

## Words

| Mark | Meaning | Confidence | Rests on |
|---|---|---|---|
| "Give off from N.o one Retain on N.o two" (and converse), "add", "Add to N.os one" | What the mill does to numbers in that band | Stated (as words); which motions do it is not stated | F/014, F/020 |
| "Step up from one to two", "Step Down product from 3 to 4", "Notice given of Stepping up" | A shift of the product or multiplier between figure wheels or cages | Stated (as words) | F/013, F/020 |
| "Gears with N.o 1 in bottom Cage" | The part gears with the numbered wheel of a cage | Stated (as words); its figure is not the B figure beside it | F/013 t11, t24 |

## Not settled by any source

- What B and U abbreviate. "Bolt" goes with platforms from 1835 (Vol XIII), but
  in Dec 1835 Babbage writes "lock … to Pl. 4" (Vol II p 42), and "B" is used
  for a barrel going back on Vol II p 81 (1 Mar 1836).
- Whether one platform gives every attached part the same lift: F/013's heads
  give one lift each, but on 6 Oct 1835 Babbage wanted "to make one platform
  move axes to various [?heights] in same time".
- What any motion does to a number. The words say what a band does (add, step
  up); which motion of which part does it is not recovered.
