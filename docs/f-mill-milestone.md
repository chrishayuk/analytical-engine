# Multiplication without table: the milestone closed (28 November 2026)

The reconstruction of BAB/F/018–020 ("Multiplication without table", 11
January 1836) stops here. Published as the note *Making Babbage's 1836 Mill
Multiply* (chrishayuk.com, N-BABBAGE-MILL 1.0). What it established, and what
it leaves open, so that later work starts from the right place.

## Established

| Result | Where | Strength |
|---|---|---|
| Figure wheels turned tooth by tooth give the products Babbage wrote: 4/5 from the marks, 5/5 with band 6's words | `f-mill-rules.md`, `f-mill-f018.md` | rules committed before the run; answers known; fitted |
| Three rules each needed (cage higher, retain, carriage) | `f-mill-f018.md` §3 | ablation on the same sheets |
| Ver bolted to platform 5 → the lower wheel gives off, 6 → the higher (E1) | `f-engage-rules.md`, `f-engage-result.md` | 6/6 on unseen held-out cases where scorable; 5/5 seen |
| Whether an axis gives off (E0) | same | frozen 21/29 (unseen); afterwards 28/34 against giving off alone; 33/34 with the D-C cells re-read. All three kept |
| A controller that counts the multiplier down until it runs up regenerates F/018–019's bands, the modelled labels and the products from 201 | `f-control-result.md` | fitted; written knowing the chart |
| F/020: 11 of 13 operations agree (multiplier 631, chosen to fit); block 3 repeats block 2 | `f-control-result.md` §4, `f020-schedule.md` | the divergence is on the sheet |
| The controller multiplies correctly: 110,000 exhaustive and 2,000 random runs, every band's invariants; mutations caught | `f-control-tests.md` | a property of the controller |
| A Lean model of the controller is proved correct within capacity, bands = p + Σd | `formal/Babbage/Mill.lean` | proof of the model, not of the Python, not of the engine |

## Left open, deliberately

- **Lean–Python correspondence.** Rows and carriage rounds are cage by
  cage in Lean, sequential in Python; the equivalence is argued in the
  module docstring, not proved; no run compares the two.
- **Bolting to gearing in the proof.** E0–E3 are not in the Lean model;
  it names the giving and receiving wheels directly.
- **E2** (S1/SS and the direction of a step): untested on held-out sheets.
  **E3** (′p′p/′P choose the product's receiving wheel): fitted on
  F/018–019 and F/020.
- **The counter.** Which part counted is unknown. R2 does not fit this
  counter (no motion in additions; F/013's R-wheels are gearing), which
  argues against R2 as this counter, not against every counting role.
- **The multiplier's length (p).** Supplied with the operand. The
  digit-counting designs of February–March 1836 limit the steppings of
  multiplication *by table* and do not supply a plain p
  (`sources/notes/running-up-designs-1836.md`, Q5).
- **How a running up suspends an operation or gives notice.** Not on any
  page read; "notice" occurs only on F/020.
- **Gearing geometry**: how a lift of .4 rather than .2 engages one wheel
  rather than the other; the bolting of P, pp, ap, g, g1, R2, ′g1, 02,
  ′g2/′g3, 03 and the carriage parts.
- **The D-C stepped wheel** on F/026–029 (single shaft, pointing down,
  under "Figs"): what it does is not settled.
- **F/032 band 3**: Ver on 5 and no give-off marked; unexplained.
- **The transcriptions** are readings by coding agents from the Science
  Museum Group's images; no person has verified them.

The next track (`c1836-control.md`) takes up arithmetic-dependent control
as a question of its own, and does not extend this simulator.
