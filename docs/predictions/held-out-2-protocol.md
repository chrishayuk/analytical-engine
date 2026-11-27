# Held-out test 2: the supplementary scoring protocol

Committed on 27 November 2026, after the rules (`held-out-2-rules.md`,
dc3bf1d) and before the inputs of F/021–024, F/026–029, F/032 and F/033 have
been seen here, and before any part arrow is read. The rules are not changed:
R1–R5 are scored exactly as written there. This file adds how they are scored,
and three further models scored beside them. Wherever the original rules and
this protocol would score a case differently, both scores are reported and the
disagreement is listed.

## Attachment state

Each part (column) is, at each band, in one of three states:
- **attached to k**: an earlier "B k" in its column on this sheet, with no U
  since;
- **detached**: an earlier "U" in its column on this sheet with no B since, or
  a band in which it carries a U and no B;
- **unknown**: no B or U in its column so far on this sheet. A sheet may begin
  in the middle of an operation, so "unknown" is not "detached".

## The models scored

- **R4 as written** (`held-out-2-rules.md`): a part with no attachment and no
  B in a band does not move; "no attachment" includes unknown.
- **R4u, unknown-aware.** As R4, but a part in the unknown state makes no
  prediction: it is reported as untestable, not as a pass or a miss.
- **M0, stateless.** Only a fresh "B k" in the band's label row predicts a
  motion (as R1); nothing else moves.
- **M1, persistent.** A part moves in a band if it has a fresh B, or is
  attached by an earlier B with no U since; direction and lift from k.
- **M2, platform-following.** As M1, but an attached part moves only in a band
  in which platform k's own column moves (on sheets with platform columns), in
  that row, and returns when platform k returns (R2). On a sheet without
  platform columns M2 is not scored.

**The comparison that matters** is on parts that move, or could move, in a
band **without a fresh B**: M0 predicts no motion; M1 and M2 predict motion
for attached parts. These cases are reported on their own, per sheet.

## Cases

- **Several attachments at once** (a part with two B's and no U between): the
  later B wins for prediction, and the case is listed as a conflict.
- **Compound labels** ("U 5 B 8"): the U applies, then the B, in that order.
- **Stacked labels** (`"U 7" over "B 5"`): read top first, as compound.
- **Carried-over rows** at the top of a sheet (rows before its first label
  row): not scored; a label in them sets state, as a label row would.
- **Sheet boundaries**: each sheet starts with every part unknown, even when
  it continues another sheet.
- **Struck figures**: the figure written after the struck one is used; the
  case is flagged, and scored.
- **Marks**: a mark the transcription reads is scored as read; one it marks
  unreadable ([?], hatched, blotted) is reported as **unreadable**; a part of
  the sheet that is cut off or not photographed is **cropped**. Neither is a
  pass or a miss. "Nothing" (a column read and found empty) is scored.
- **Platform schedule missing** (no platform columns, or the platform's column
  unreadable in that band): R2 and M2 are untestable there.

## What is scored

For every predicted motion: **direction**; **lift** (digit for digit, a figure
without its point a miss, reported separately as "point missing"); for every
predicted return: **row**, **direction** (opposite to the motion) and **figure**
(the lift again), each scored separately.

## Lift tables

On a sheet with its own platform heads, its table is used. On a sheet without
them, F/013's table is used as a fallback. Results with the sheet's own table
and with the fallback are reported separately.

## Reporting

Per sheet and per design (division without table F/021–024; square root
F/026–029; ordinary cycle F/032; carriage F/033), then pooled. Every miss is
listed. Untestable, unreadable and cropped cases are counted, not dropped.
