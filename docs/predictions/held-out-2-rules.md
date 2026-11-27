# Held-out test 2: the rules, frozen before the inputs are read

Written and committed on 27 November 2026, before the labels, platform heads
or platform motions of F/021–024, F/026–029, F/032 or F/033 have been read by
anyone in this project, and before any of their part arrows are read. The
predictions themselves are generated from these rules and the inputs
(`sources/notes/F021-F033-inputs.md`, when it exists) by `scripts/predict_f.py`,
committed before the part arrows are transcribed by a reader who is not shown
them. Nothing here is changed after the inputs or the arrows are read.

**Hypothesis P, revised after held-out test 1** (`f015-f016-result.md`): a part
labelled "B k" is attached to travelling platform k until a "U k" in its
column detaches it; while attached it moves as platform k moves. Platform k's
**displacement** (direction and lift) is a property of k, from the sheet's
platform heads (or, on a sheet without them, F/013's). Its **timing** (when it
moves and when it returns) is not a property of k: it is the sheet's own
schedule for that band, read from the platform columns.

## The rules

- **R1, motion.** A part labelled "B k" in a band's label row moves in the
  first motion row of that band, in the direction of platform k's lift, by
  that lift (figure compared digit for digit; a figure without its point is
  scored as a miss, as before).
- **R2, return with the platform.** On a sheet with platform columns, the part
  returns (a double-headed arrow in its column) in the row where platform k
  returns in that band. On a sheet without platform columns, R2 is
  untestable and is not scored.
- **R3, lone U.** A part whose only label in a band is "U k" (no B) does not
  move in that band's first motion row.
- **R4, persistence.** A part attached by an earlier "B k" and not since
  detached by a "U" moves again, as in R1, in any later band in which
  platform k moves. A part with no attachment and no B in a band does not move
  in that band's first motion row.
- **R5, the counter-observation stays open.** F/016 band 2 (parts with no
  return; returns that do not match their motion) is not explained by these
  rules and is not adjusted for.

## Extraction and its coverage

`scripts/predict_f.py` reads the label tables of the inputs note, including
stacked labels (`"U 7" over "B 5"`), compound labels, "B N.o k", struck
figures (the figure after the struck one is used, and the prediction is
flagged), and points. Before the predictions are frozen, it prints, for each
sheet, every label cell it read and every B/U token it took from it, and
fails if any label cell yields no token or any token is unparsed. That
coverage report is committed with the predictions.

## Scoring

Each rule is scored separately, with every miss listed and every untestable
case counted. Uncertain readings in the transcription are counted as they are
read, and flagged. Nothing is corrected after the fact.
