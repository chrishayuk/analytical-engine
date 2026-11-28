# From bolting to gearing: which wheel gives off, read from the configuration

Committed **before** `scripts/f_engage.py` was written or run. The rules
connect the two simulators: the B/U state of `f_sim.py` (persistent
attachment, tested in `predictions/held-out-2-result.md`) is used to
predict which figure wheels give off and receive, which `f_mill.py` (rules
in `f-mill-rules.md`) took from the stepped shafts and the words.

## 1. Where the rules come from (F/018–019, seen)

F/018–019 label each axis's Ver column in row 15, for the next band. The
attachment of each Ver and S column during rows 1–9 of each band, with what
the band's stepped shafts and words do (from `F018.md` §3):

| Band | A Ver | B Ver | C Ver | S parts bolted | What the marks do |
|---|---|---|---|---|---|
| 1 | — | — | 5 | ″S1 | C: N.<sup>o</sup> 1 Zeros, N.<sup>o</sup> 2 Figs, "Step up from one to two" |
| 2 | 5 | — | — | — | A: 1 Zeros, 2 Figs; B N.<sup>o</sup> 1 receives |
| 3 | 6 | — | — | — | A: 2 Zeros, 1 Figs; B N.<sup>o</sup> 1 receives |
| 4 | — | 5 | 6 | ′S1, ″S″S | B: 1 Zeros, 2 Figs "one to two"; C: 2 Zeros, 1 Figs "two to one" |
| 5 | — | 6 | 5 | ′S′S, ″S1 | B: 2 Zeros, 1 Figs "two to one"; C: 1 Zeros, 2 Figs "one to two" |
| 6 | 5 | — | — | — | words only, "Give off and retain" (A holds the number on N.<sup>o</sup> 1) |

These were noticed by looking at this table; they are fitted to six bands.

## 2. The rules

Only two-wheel axes are predicted: an axis with a Ver column and exactly
two figure wheel columns next to it (in F/021–024 Axis A, N.<sup>os</sup>
1–2, and A₂, N.<sup>os</sup> 3–4; in F/026–029 D-C, wheels 1–2, and QA,
N.<sup>os</sup> 3–4; in F/032 Axis A, N.<sup>os</sup> 1–2). Axes with four
wheels (B in division, A and C in square root) are not predicted: which
pair is meant is not settled by the rules.

The attachment of a Ver or S column in a band is its state after that
band's label row, with bolts persisting until a U (hypothesis P as tested),
exactly as `scripts/f_sim.py` computes it from `sources/notes/F021-F033-inputs.md`.

- **E0. Whether the axis gives off.** An axis gives off in a band if its Ver
  is attached to platform 5 or 6 then. If its Ver is detached, or has never
  been labelled on the sheet and is not in the unknown state, it does not
  give off. Attached to any other platform, attached by a bare B, or in the
  unknown state: **no prediction**.
- **E1. Which wheel.** Attached to platform 5: the lower-numbered wheel
  gives off ("Zeros") and the higher receives ("Figs"). Attached to 6: the
  higher gives off and the lower receives.
- **E2. Which way a step goes.** If the axis's group has S1 attached in the
  band, the lower-numbered wheel gives off and the higher receives; SS
  attached, the reverse. (In F/018–019, S1 goes with "one to two" and SS
  with "two to one", on both the product and the multiplier.)

## 3. The test

Targets: the words "Zeros" and "Figs" in the two wheel columns of the axis,
in rows 10–11 of the band, as read in `sources/notes/F021-F033-arrows.md`
(the blind transcription, cdb7aac). A band where neither wheel has either
word is "no give-off".

Scored per (sheet, band, axis):
- E0: give-off predicted against observed (either word present);
- E1 and E2, where they predict and a give-off is observed: the predicted
  giving wheel against the wheel marked "Zeros" (and the receiver against
  "Figs").

**Exposure.** While searching for these columns, before writing this file,
lines of `F021-F033-arrows.md` were seen that give the Zeros/Figs of Axis A
in F/021 bands 1–3, of Axis A and B in F/022 bands 1–3, and of A₂ in F/022
band 2. Those cases are scored and reported apart, as **seen**. The rest
(F/023, F/024, F/026–029, F/032, and F/021–022 apart from those) are
**unseen**.

The 1836 lifts are not used: only the platform number. Nothing here says
how a lift of .4 rather than .2 puts one wheel rather than the other into
gear (that mechanism is not shown on any sheet read).

## 4. Then, on F/018–019

`f_engage.py` will run `f_mill.py` with its engagements chosen by E0–E2
from the B/U state instead of from the stepped shafts (variant E), with the
cross-axis receiver kept from the marks or words (rule T2 of
`f-mill-rules.md`), and compare it with W and M. This part is fitted:
E0–E2 were read off F/018–019.
