# Arithmetic-dependent control in the mill, 1835–1836, and on the cards, 1836–1843

A new track, opened 28 November 2026 after the multiplication milestone
(`f-mill-milestone.md`). The question: **how did a result computed in the
mill come to decide what the machine does next, and did that happen in the
mill before it happened on the cards?**

The sources are readings by coding agents from the Science Museum Group's
images; no person has verified them. Coverage is incomplete and is stated
where it matters.

## 0. Prior work, and a conflict to resolve first

From `priority-register.md` (28 November 2026). **This page's chronology
is provisional until these are reconciled:**

- **Bromley (1990, p 76)** dates loops and "alternate sequences dependent
  on arithmetic results" in the barrels, with looping and branching super
  barrels, to **late 1834**. That is earlier than anything found here, where
  nothing before 7 March 1836 was found to use a result passing through
  zero. The two may differ in sources (Bromley read papers this project has
  not, from 1834–1835) or in what counts as a branch (a barrel's stops and
  reducing apparatus against a running up). Not yet resolved; the 1834–1835
  pages he relies on should be identified and read.
- **Bromley (1982, pp 206–207, 212)** already describes running up as a
  sign change used for control, "multiway branches", and division as the
  origin of "conditional processes conditioned by events occurring during
  the calculation".
- **Swade (Plan 28 blog, 16 November 2017)** already draws the distinction
  between "multi-way conditional branching at the 'microcode' level" and
  user-level conditional control, and dates the first user-level
  conditional to an entry of **19 March 1842** ("minor operations"), which
  this project has not read; set it against F/227 (April 1842) here.

So the mill-against-cards distinction, and running up as a control signal,
are prior work. What may remain distinct is narrower: the dated sequence of
1, 7 and 22 March 1836 read page by page, the executable behavioural models
with their unresolved interfaces, and the same counting device appearing on
the cards in December 1837. None of that is claimed as new.

## 1. The dated designs in the mill (Vol II, December 1835 – March 1836)

From `sources/notes/running-up-designs-1836.md` (pages read at full
resolution unless it says otherwise). Kept separate, by date:

| Date | Page | What changes the course | Acted on | The signal |
|---|---|---|---|---|
| 5 Dec 1835 | p 24 | — (a time count: division takes "n + No of runnings up" cycles of 28) | not said | running up occurs; what it moves is not said |
| about 10–20 Feb 1836 | pp 67–68 | which of two numbers has more digits | "lever L … up or down and decide" | a comparison of digit counts |
| 24 Feb – 1 Mar | pp 72–75 | the digit counts, by a spiral axis; their difference on a directing cam | "directing arm governs the barrel of multiplier axis" | a counted position |
| 1 Mar | pp 76, 78–81 | **a stop** on a counting wheel | an arm; gathering-up teeth; barrel cycles in or out of gear | the count reaching its stop |
| 7 Mar | p 84 | **a running up** of a count on an axis with a carriage | "the op.n be suspended" (nothing named) | the count passing through zero |
| 10–16 Mar | pp 88–92 | a running up | "directs which is to be Multiplier" (nothing named) | a computed difference passing through zero |
| 22 Mar | pp 94–95 | whether **q − p runs up** | barrels A, B, C, by a drawn "running up axis" with three arms | the sign of a computed difference |

Nothing found before 7 March 1836 says that a result passing through zero
moves anything. From 7 March, running up replaces the stop as the signal.
The Vol XIII history records the same date: "7 March Running up applied to
<u>any</u> op." (`repetition-count-1836-1842.md` §2).

## 2. Three of them, executable as behaviour

`scripts/c1836.py` runs three designs as **abstract models of what the page
states**, quoted at each transition. What the pages leave out is of two
kinds, kept apart:

- a **gap**: a physical mechanism not shown (how an arm reaches a barrel,
  how a running up turns an axis). The page states the behaviour; the model
  follows the text and records the gap, which is never given a value;
- an **event**: something that decides the course and that the page does
  not derive (when the positive cycle ends, when "the next running up"
  comes, which way q = p goes). A run must supply it by name, or the model
  refuses. A model whose course depends on a supplied event is not shown to
  end by itself, and its outcome says so.

Inputs outside a design's domain or capacity are refused (counts are whole
numbers ≥ 0 that fit the wheels, on at least one wheel; d ≤ q; and q ≤ 30
for the 1 March counting wheels, a **modelling restriction** taken from
nearby pages (p 82, 4 March, "30 / p−30"; p 91, 12 March, a rack of 30
feelers), not stated on p 76). Supplied events are checked by type as well
as value: a yes/no event takes True or False, not 1 or 0. The negative and positive cycles have no
internal schedule in the model: the page gives none. `scripts/test_c1836.py`
(16 tests) checks the stated behaviour, every refusal, and that gaps are
never valued. Counters are wheels turned one tooth at a time, a running up
being the top wheel passing from 0 to 9.

| Model | Behaviour stated | Unresolved interfaces |
|---|---|---|
| **D-0301** (1 Mar, p 76) | q steppings down, counted on wheel q; its stop throws an arm in, which moves the gathering to q−d and puts the stepping-up cycle in gear; q−d steppings up; then Mult.n thrown out | how q and q−d are set (the spiral axis of pp 72–75); how the arm reaches teeth and barrel (no drawing); how q−d "throws out Mult.n" |
| **D-0307** (7 Mar, p 84) | a count n on an axis; unity subtracted before each operation; n operations, then a running up and the operation suspended | where n comes from; what the running up acts on (nothing named) |
| **D-0322** (22 Mar, pp 94–95) | A in gear at step 4; at step 5, q − p on the wheels: if it runs up, A moved, Neg. cycle; its first vertical puts A out and C in; C, on the next running up, ends Neg.; if it does not run up, A out and B in, Pos. cycle; the end of either, with the end of table making, puts in the division cycle | how q − p is on the wheels at step 5; how the running up turns the axis (no link drawn); what moves B when there is no running up; **which quantity runs up next** to end Neg.; what ends Pos.; table making; which cases have carriage prevented; **q = p** (the text's "if it do not run up" sends it to Pos., but the drawing labels Pos. "q−p > 0" and Neg. "q−p < 0"; the model refuses unless the reading is supplied) |

## 3. What each can express

Modern categories, applied to the behaviour stated; not Babbage's words.

| | D-0301 stop | D-0307 running up | D-0322 sign choice |
|---|---|---|---|
| Repetition | yes: q, then q−d times | yes: n times | the Neg. cycle runs until "the next running up"; how it runs inside is not given |
| Ends by itself, in the model | yes | yes | **no**: its end is a supplied event |
| When the number of repetitions is fixed | before the loop (the counts are set from the digit counts, then the table is made) | before the loop (n is put on the axis) | **not fixed by the page**: it depends on the unresolved "next running up" |
| What the trigger reads | the position of a counting wheel | a counter passing through zero | **the sign of a difference computed in the mill** |
| Chooses between alternatives | no: one fixed sequence (down, then up) | no: continue or suspend | **yes: Neg. or Pos.** |
| Size of the count | a counting wheel (digit counts, up to about 30, p 82) | any number the axis's wheels hold, with carriage | — |

So the three are different kinds of control:

- **D-0301 and D-0307 are counted repetition.** Both fix the number of
  repetitions before the loop starts. They differ in mechanism and in
  generality, not in what they can express: D-0307 makes the end of a
  count an arithmetic event on a figure-wheel number, of any size, for
  "any op.".
- **D-0322 is a choice on a computed result**: the course taken depends on
  the sign of q − p, formed in the mill during the operation. In the pages
  read here it first appears on 22 March; Bromley (1990) dates branching on
  arithmetic results to late 1834 (section 0).
- **Whether D-0322 also ends a loop on a result computed inside it** turns
  on the unresolved event: if the "next running up" is of a quantity the
  Neg. cycle itself changes, the Neg. cycle repeats until the data say stop,
  which neither counted design can do. p 94 does not say which quantity it
  is. Read with p 95, p 78 and p 102 (`sources/notes/next-running-up-1836-1837.md`),
  the favoured interpretation is a count fixed before the loop, set from the
  computed difference q − p: the negative cycle steps the dividend |q − p|
  times before division proper (p 102, 3 April 1836: stepping ends when "q−p
  is gath.d up", by a rack and tooth N). On that reading D-0322 adds a
  branch on a computed sign, not data-dependent termination. No support was
  found for a quantity computed inside the cycle; another mechanical state
  is not excluded. The model keeps the end as a supplied event.

## 4. Against the cards, 1836–1843

From `control-flow.md`, `sources/notes/sketchbooks-control.md`,
`codesign-L023.md`, `vol4-control-1839-1840.md` and
`published-control-1843.md`. Dates as written on the pages.

| Capability | In the mill | On the cards |
|---|---|---|
| Counted repetition | 1 Mar 1836 (stop, p 76); 7 Mar 1836 (running up of a count, p 84) | 30–31 Jul 1836: sets of cards passing a counted number of times (Vol II pp 178–179) |
| Repetition ended by a counter running up | 7 Mar 1836 (p 84) | Dec 1837: a backing card "ineffective if the combinatorial wheels have run up" (Vol III pp 161–162); 30 May [1838]: "if running up in Combin.l Axis occur this order is destroyed" |
| A choice on the sign of a result computed in the mill | 22 Mar 1836: Neg. or Pos. cycle on q − p (p 94) — a choice between mechanical cycles inside one operation | **not found in the pages read, 1836–1840.** Nearest: 25 June 1839, a running up of F in long addition throws in a cam inside the mill, and "the running up or non running up must turn a card over before it acts" in a variant not adopted (Vol IV p 12). April 1842, BAB/F/227: zero and sign tests, outcome not governing cards. First stated for the cards in print: Menabrea 1842 ("the mill will order other cards"), Note G 1843 (two courses, "contingently on" Operation 7's result) |

**What this shows, within the pages read:**

1. **In this order, in the pages read** (and the order itself is Swade's
   2017 distinction, with an earlier mill date in Bromley 1990; section 0). A choice made on the sign of a result computed in
   the mill is specified inside the mill on 22 March 1836. The first
   statement found that a mill result governs the cards is the published
   account of 1842–1843; in the manuscripts read, the nearest is a variant
   of June 1839 that was not adopted. That is a gap of about six years in
   the record read, not a proven order of invention: Vol II images 1–8,
   14–19, 23–26, 31–32 and 36, Vol III pp 143–155 (Nov 1837, three-way
   orders on running up, read only in part), and most of Vol IV were not
   read for this.
2. **One device appears at both levels.** The 7 March 1836 device — a count
   on wheels with a carriage, unity subtracted each time, the running up
   ending the repetition — is what the combinatorial wheels do for the
   backing cards in December 1837. Babbage's own history records the
   generalisation on the earlier date ("Running up applied to <u>any</u>
   op."). That he carried the device from the mill's cycles to the cards is
   not stated on any page read; the record shows the same device, dated
   twenty-one months apart.
3. **The two kinds of choice are not the same.** The mill's choice of 22
   March is between barrel cycles inside one operation (which way to step
   in division). A choice between groups of operation cards on a computed
   result is what Note G needs, and what the 1843 configuration of the
   engine adds (`published-control-1843.md`). Nothing read connects the
   two.

## 5. Not done, and not to be done by filling gaps

- No physical signal path is reconstructed: every interface above stays
  open.
- The Pos. cycle's end, and the quantity whose "next running up" ends the
  Neg. cycle, are not guessed.
- The models are not wired into the multiplication controller; the
  controller's count (`f-control-result.md`) is a separate, provisional
  mechanism, and its length p is still supplied.

## 6. What to read next

- Vol III pp 143–155 (Nov 1837) at full resolution: orders that depend on a
  running up three ways (step down / no stepping / step up), the nearest
  card-era analogue of 22 March.
- Vol II images 1–8, 14–19, 23–26, 31–32, 36 (Nov 1835 – Feb 1836): to
  settle whether anything before 7 March uses a result through zero.
- pp 94–95 again, for which quantity's "next running up" C reads (the
  division context of p 95 may say).
