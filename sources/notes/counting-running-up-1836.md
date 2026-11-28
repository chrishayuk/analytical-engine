# Counting the digits, "running up", R2 and the registers, Feb–March 1836 (Vol II pp 67–95, Vol XIII history, F/013, F/014, F/018–019)

Read by a coding agent from the Science Museum Group images (CC BY-NC-SA
4.0, The Babbage Papers at the Science Museum, London), 28 November 2026.
**No person has checked these readings.**

Questions:

1. What do the Feb–March 1836 pages say about counting the digits of a
   number (p, q, "p−d"), counting wheels, putting a count on an axis,
   **running up** (what it is mechanically), suspending an operation,
   stepping limited by a count, lifters and registers?
2. (Answered in `F027-F029-dc-wheels.md`.)
3. What marks stand in the **R2** (or R, ′R) columns of F/013, F/014 and
   F/018–019, and does anything of Dec 1835 – Mar 1836 name R2 or a
   "register" wheel?
4. Does anything of Dec 1835 – Mar 1836 say which pinions or carriage parts
   (″P, pp, ap, g, g1, ′g1, 02, ′g2, 03, cp, carriage pinions) are put in
   gear for "Give off", "Add", "Step up" or "Carry"?

**Method.** Tiles only from the local cache (`scripts/smg_cache.py`), crops
stitched and viewed at the scale given; crops kept in the session
scratchpad, not in the repo. Regions are x, y, w, h in full-resolution
pixels of the stored image. Vol II = BAB/S/1/02, zoom
`<a>/<b>/Scribbling_Book_Volume_II__1835_November_1837_February.ptif`,
image n = `322/(956+n)` up to image 43, then `323/(n−44)`. Vol XIII =
BAB/S/1/13, `229/<b>/Babbage_Papers_S19__Scribbling_Book_Volume_XIII.ptif`,
history pages stored inverted (rotated 180° for reading).

**What was read at full resolution in this session:** pp 67, 68 (part), 72,
73 (part), 74 (labels), 75 (all), 79 (upper half), 88 (workings and foot),
89 (text), 90 (head, note, foot), 91 (all); Vol XIII images 86 (part) and
87 (left half); F/013 ′R column and its 6 Feb note; F/014 ′R column;
F/018–019 R2 column, every band. **Taken from earlier notes, not re-read
here** (cited each time): pp 76, 78 (preview, legible), 81, 82, 84, 92–95
(full resolution in `sketchbooks-control.md` §1 and
`repetition-count-1836-1842.md` §1). pp 77, 80, 83, 85–87 carry no text on
these questions (`sketchbooks-control.md`). Vol II pp 1–66 (Dec 1835 –
mid Feb 1836) were **not** re-read; for them this note relies on
`bolting-plates-sources.md` and `platforms-1835-1836.md`.

Conventions as in `repetition-count-1836-1842.md`: (a) on the page,
(b) what it means, (c) hypothesis, labelled. `[?x]` doubtful;
`~~x~~` struck; `⟨x⟩` interlined; `.n` etc. raised endings.

---

## 1. Summary

- **Running up, on the pages, is a wheel train passing through zero.** It
  is never defined in words. What the pages show: on p 88 (11 March 1836)
  Babbage marks "R" against exactly those additions and subtractions of
  four-figure numbers whose result crosses 0000/9999 (0019 − 0021 =
  9998 R; 0000 − 0019 = 9981 R; 9981 + 21 = 0002 R), and not against those
  that do not (0023 − 0021 = 0002; 9977 + 0021 = 9998). p 84 (7 March)
  puts a count "on an axis having a carriage connected with it", subtracts
  unity before each operation, and "a running up will take place at end";
  p 94 (22 March) says "Carriage is ⟨in some cases⟩ to be prevented when
  running up occurs and the ⟨lowest⟩ wheel put back to 0"; p 91 (12 March)
  writes "Carr Sub.n runs up" against a subtraction that goes below zero.
  So running up is the carriage out of the top of an axis (or past zero),
  and the pages use it as a **signal**: it "suspends" an operation (p 84),
  "directs which is to be Multiplier" (p 92), and decides which cycle is
  put in gear (p 94). It is not called a stop, a warning or "notice" on
  these pages; the word "notice" does not occur in pp 67–95.
- **Counting the digits.** p 75 (24 Feb – 1 March): A and B go to "Notched
  axes"; a driven spiral axis, moved back, is turned one tooth for every
  leading zero; this is passed to counting wheels "p and p−d" and "q and
  q−d", whose stop is set to d (the number of decimals). p 91 (12 March)
  replaces this with a rack with 30 feelers that feels all the digits "in 2
  turns"; p 88 (11 March) "planned the method of using digit Counting
  app.s entirely in Mill and plan of p. 74 superseded". Vol XIII's history
  dates "Page 67 Remarks on digit counting app.s" (Feb), "24 Plan of
  counting digits", "10 March Counting rack various stages", and (24 March)
  counting tens and units separately so that no more than nine need be
  counted.
- **A count limits stepping.** p 76: the gathering-up tooth acting on the
  counting wheel q "determines the No. of steppings down"; q−d "determines
  the number of steppings up". p 81: the multiplication repeats barrel rows
  9–12 "after which steps up q−d times". p 92: the multiplier is
  "transferred to No 1 to ⟨have 1 subtracted from it and to⟩ limit the No.
  of steppings down, and to No 2 to have d+1 subtracted from it and to limit
  the No. of steppings up". p 91's table: "+1 +1 +1 … = p−d at end of
  Mul.n".
- **"Register."** p 67 (Feb 1836): "The two Registers connected with table
  must be set by Digit Counting App. one to the p th & the other to the p+1
  th cage"; "Quotient register must always be in the lowest cage". p 68:
  "Set register to ⟨lowest⟩ fig. of A connect it with the lifters". p 79:
  "the regis.r whs of divi.n" set to "the p.th and the p+1.th cages". p 84:
  "by a register axis subtr.g unity". The registers are wheels or axes that
  record a position (a cage) or a count; none is called R2.
- **"Lifters"**: p 68 ("connect it with the lifters") and p 90 (a
  sketch headed "Lifters 13 March", no text). Vol II p 24 (5 Dec 1835, from
  `bolting-plates-sources.md`): "Step up multiplier which reduces its first
  figure to zero and sets lifters", "Lift lifters". Nothing more on what
  the lifters are.
- **R2.** On F/018–019 the column headed "R2" (multiplier group) holds only
  bolt labels and lift arrows of 1.1 and .6: listed in §4. F/013's note of
  6 Feb 1836 says "R2 R3 are wanted for the other operation". F/013 and
  F/014 have only "′R". **Nothing in the pages read names R2 or ties it to
  a register.** A/030 lists R2 and R3 among the axes of its plan (preview
  reading in `platforms-1835-1836.md` §4; not re-read here).
- **Q4: nothing found** in pp 67–95 that names ″P, pp, ap, g, g1, ′g1, 02,
  ′g2, 03 or cp, or says which pinions are put in gear to give off, add,
  step up or carry. The nearest statements are listed in §5.

---

## 2. Vol II, page by page

### p 67, image 36 (`322/992`), right page; no date (between 9 Feb, p 63, and 18 Feb, p 69)

(a) Full resolution, regions 2550,1450,2300,600; 2550,2000,2300,650;
2550,750,800,700 (all at 0.6).

Top: a worked division-like stepping, heads "p = 5", "A", "q = 7", "B";
"0008697903", lines labelled "Step down q−p", "Step up 1", "Step up",
"Step", "Step", "Step" with the figures moving one place each time. At
left:

> feel on the 5th & 6th generally fell on p th and p+1 th of Dividend

Text:

> The two Registers connected with table must be set by Digit Counting
> App. one to ~~the~~ the p th & the other to the p+1 th cage by means of
> the spirals [?axis]
> The Dividend must be prepared by stepping it down q−p times
> Quotient register must always be in the lowest cage ⟨and the number of
> figs registered in quotient⟩ must arise ⟨from its first subtraction⟩ from
> stepping quotient up, and it must be equal to ⟨one plus⟩ the No of
> times Dividend was previously stepped down that is to q−p+1 times
> If ~~each~~ Div.r & Div.nd have each d decimals then division quotient
> must be continued to q−p+d+1
> This plan is equally true whether p >= < q

(b) The registers are set **to a cage** (a vertical place on an axis) by
the digit-counting apparatus. The number of quotient figures is a count
derived from p and q (q−p+1, or q−p+d+1). This is the passage the
history calls "Page 67 Remarks on digit counting app.s".

### p 68, image 37 (`322/993`), left page (about 18–20 Feb)

Read at full resolution in `platforms-1835-1836.md` §5.1; the middle
re-read here (250,1450,2200,750 at 0.6), agreeing with it except as
marked:

> plan to find which ~~[?has]~~ the greatest N.o Dig.ts
> R = rack put into gear first with counting wh.l of A then with that of B
> — according as p or q is greatest so will lever L be up or down and
> decide
> To Multiply A by B
> Add over A and B to the two ⟨Dig.t⟩ Counting App. and let them be applied
> successively to the above app. for finding greatest
> Tabulate B the greatest
> Set register to ⟨lowest⟩ ~~[?unit]~~ fig. of A connect it with the lifters
> and reduce ⟨[?it to]⟩ ~~[?zero]~~ by stepping down
> Continue on thus to p or p+1? terms
> But while table is making Reduce C. Wh.l of A to zero and add p over to a
> wheel having a stop at −d (d = no. of decimals) then ~~after the last fig
> of mult.r is~~ ⟨used⟩ gather up ⟨the p−d⟩ teeth of this wh.l and
> ~~[?…] the mult.n is complete~~ at each tooth step up product —

(The "R" here is a rack, not R2.)

### pp 72–73, image 39 (`322/995`), 24–29 Feb

(a) Whole image at 0.25; head and p 73 workings at 0.6–0.8.

p 72 head: "24 Feb. 1834 This date must be wrong; it ought to be 1836 see
page 81 of this Vol." (the correction in lighter ink); "29 Feb" lower;
sketches of stepped racks, a spiral, sectors. p 73: sketches of sectors and
an axis frame, labelled "Gathering" and "G.r gathering up tooth / G"; a
working

> 003421 A
> −3000 B
> 000421

and below it "p [?— d]". No sentence.

### pp 74–75, image 40 (`322/996`), "Counting App. for Mult.n" (1836; between 29 Feb and 1 March)

(a) Full resolution: 2500,60,2389,640; 2500,600,2389,1200;
2500,1750,2389,1150 (0.6); 4100,100,789,220 and 2550,330,900,160 (1.2);
p 74 300,900,1500,1000 (0.75).

p 74 (sketch, "1836"): "Driven spiral axis", "Notched wh. on ax. No 1",
"Notched wh. on ax. No 2", "Driven spiral of [?] No 2", "Gathering up
spirals"[?]; "p−d", "30−p", "α", "b", "p", "q", "q−d", "q−p", "p−q";
"Left hand counting wheel", "Directing cam", "stop for −d", "Gather.g up
tooth for Stepp.g up after Mult.n" (twice), "Right hand counting wheel",
"Driven spiral", "Driving spiral axis".

p 75:

> Counting App. for Mult.n
> A is transfer[d] to one Notched axis (No 1) ~~[?two]~~ [blot] & B to the
> other A having p digits and B having q digits
> Let driving spiral move back, the top arm will [?receive] if the top fig.
> is zero, the top notched wheel thus driven will drive the top arm of the
> spiral axis which will bring the second arm of the same spiral into a
> position to be acted on by the second notched wheel if it is at zero and
> so on.
> It may be necessary to make the spiral take 2 turns at 2 different
> elevations.
> The driven spiral axis is thus moved as many teeth as there are zeros on
> the top of the number which it communicates to the ⟨two⟩ counting
> wheels p ⟨and p−d⟩ and similar mechanism from other notched wheel to
> other counting wheels q ⟨and q−d.⟩ Superposition of motion thus carries
> the directing cam over no teeth if p = q but over p−q in one direc.n if
> p > q or over q−p in the other direction if p < q.
> p−d and q−d are wheels in which the stop has been set to d.
> d = No. of decimals
> If p [?=]> q directing arm governs the barrel of multiplier axis which
> orders [?A] to be [?rub] out ⟨on the multiplier axis and [?q to be]⟩
> ~~and also it~~ to be tabulated; and the gathering up axis to ⟨be⟩ put
> into gear with q

(b) The digits are counted by counting **leading zeros**: the spiral is
advanced once per zero at the top of the number, and the count goes on to
counting wheels. The difference p−q (or q−p) is formed by superposition
of motion on a "directing cam". The p−d and q−d wheels carry a stop set to
d. The directing arm chooses, through a barrel, which number is
tabulated and which is the multiplier.

### p 76, image 41 (`322/997`) (preview; as `sketchbooks-control.md` §1)

> N.B. p was previously thrown out of gear with p−d and q out of gear with
> q−d. At the same ⟨time⟩ A and B are put on Mult.n axis ⟨each⟩ ~~one~~ is
> received on the fig wh. of ⟨one of the⟩ carriages belonging to Mult.n
> axis. Table being ~~made~~ ⟨finished⟩ throws into gear ⟨circularly⟩
> gathering up tooth of p & q which acting on the gathering up wheel q (in
> this case) determines the No. of steppings down. It also throws into
> gear the Mult.n cycle of the barrels of Mult.r & Product axes here ends
> Mult.n but the stop of the count.g wh. q throws an arm in which in the
> subsequent part of its revolution throws out the gathering up tooth from
> q and throws in the gathering up teeth on q−d It also throws in on the
> barrel of the product axis the cycle for stepping up. the count.g wh. q−d
> determines the number of steppings up. This throws out Mult.n
> See page 78

(b) The **count is held on a counting wheel**; a "gathering up tooth"
takes it back one tooth per stepping, and the **stop** on the counting
wheel, when it is reached, throws parts in and out of gear (ends one phase,
starts the next).

### pp 78–79, image 42 (`322/998`), 1 March, "for Division", "Division Contin.d"

p 78 (preview, legible; as `sketchbooks-control.md`): "… q−p upon the
counting wheel of the directing cam … into gear with one of the red
gathering up teeth which steps up or down the dividend q−p times. There is
a stop or cam at the end of this which in concurrence with the stop at the
end of the Table ⟨making⟩ app.s throws into gear division cycles".

p 79, upper half at full resolution (2500,60,2389,1500 at 0.55):

> Division Contin.d
> The wheel q is connected with the second counting wheel which has a stop
> upon it at d+1 which after q is counted stands at q+d+1
> As soon as direc.g cam is out of gear p is reduced to zero and
> conseque.y the stop on the dec coun.g wh. ~~now~~ marks q−p+d+1 The
> gath.g up tooth of q ~~are~~ ⟨~~and the division cycle~~⟩ now thrown into
> gear ~~as well as the regis.r~~ vertically ⟨its[?elf]⟩ ~~being~~ thrown
> into gear circularly ~~it [?is] done~~ at the same time that the division
> cycle is thrown into gear.
> The reduct.n of coun wh. p to zero also sets the spi. ax. belonging to
> the regis.r whs of divi.n to the p.th and the p+1.th cages

Lower half ("Extr.n of Root of A") as `sketchbooks-control.md`, not
re-read.

### pp 80–81, image 43 (`322/999`), 1 March 1836

Not re-read; full-resolution readings in `sketchbooks-control.md` and
`platforms-1835-1836.md` §5.2. Key lines: "These repetitions continue 29
advances of barrel after which steps up q−d times and the multiplication
is done. The counting wh. by its stop then throws out barrel and into gear
with a ~~backing~~ ⟨zero⟩ app.s which brings it to zero … These
alternations are continued q−d times when stop of q−d counting wh. throws
all out and mult.n is ended."

### pp 82–83, image 44 (`323/0`), 4 March (preview)

p 82: six counting wheels labelled (top / bottom) "30 / p−30", "0 / q−p",
"0 / p−d", "0 / q−d", "d+1 / q−p+d+1", "0 / p−q", under "Counting App.
p 74". No text.

### p 84, image 45 (`323/1`), 7 March (full resolution in `repetition-count-1836-1842.md` §1)

> When any operation is to be terminated ~~or at~~ after a given ⟨variable⟩
> number of repetitions, let the number of rep.ns be put on an axis having
> a carriage connected with it. Then ~~a running~~ on ⟨[?b]y a register
> axis⟩ subtr.g unity ⟨previous⟩ ~~at~~ each operation a running up will
> take place at end and thus the op.n be suspended

### pp 88–89, image 47 (`323/3`), 10–11 March

(a) Full resolution: 250,650,2200,1150 and 300,1750,2200,1000 (p 88,
0.6); 2600,60,2289,1300 (p 89, 0.6).

p 88, under "11 March":

```
p = 0023                         9977
q = 21          9999[?]          0021
                                 ----
       0023                      9998
       0021                      0002
       ----
       0002

p = 19   +p = 0019              −p = 9981  R    [?99]80 (struck 99)
q = 21   −q = 0021              +q = ~~9999~~ 21     21
p − q =      9998 R                  ----          [?]901
                                     0002 R
             0000
               19
             0·091
          + [?]  21
               111
```

The letter after 9998, 9981 and 0002 is a capital "R" (the same form
three times). At the foot:

> Today planned the method of using digit Counting app.s entirely in Mill
> and plan of p. 74 superseded except spiral Axis and Notched Whl.

p 89:

> to put on ~~[?hundreds]~~ units of Mill [beside a rack, top]
> tens / hundreds [beside two more racks]
> If A have 10 on rising 1/10 it is thrown into gear with the tens at the
> 2nd ~~[?tooth]~~ ⟨tooth⟩. If B has 10 it is also thrown into gear with
> the tens but not untill the 3rd tooth
> 3 0 / units 2 n / tens 1 n′ / hund.s 0 n″

(b) **What "R" marks (reading).** R stands against the three operations
whose result passes through zero on a four-figure register — 0019 − 0021
(borrow out of the top), 0000 − 0019 (forming −p as 9981), 9981 + 0021
(carry out of the top) — and against none of the operations that stay on
one side (0023 − 0021, 9977 + 0021 = 9998). On this page, running up =
the number on the wheels passing 0000 / 9999, i.e. a carriage (or
borrow) out of the highest wheel.

### pp 90–91, image 48 (`323/4`), [?1]2 March – 13 March

(a) Full resolution: 250,60,1300,250 and 750,400,1100,400 and
900,1850,1500,1000 (p 90, 0.6–0.8); p 91 2500,60,2389,960;
2500,1000,2389,880; 2500,1850,2389,1100 (0.6); 2500,2150,800,700 (1.0);
3200,2150,1500,350 (0.8).

p 90 head: "[?1]2 March" (a faint stroke before the "2"; p 88 is 11 March,
p 91 12 March); a row of figures "9 8 7 6 5 4 3 2 1" over dots and a slotted
bar. Top right working: "0019 / 9981 / 19 / 0000 / 1 / 1 / 0002",
"21 = 19 + 2", "p − q". Note:

> gears with units
> fig. wh. on which p or q is put. This fig wh. is connected with add.n
> carriage

Lower: "Lifters 13 March" over a sketch (no text about the lifters); "9 =
18"[?]; "a moveable snail like that at page 132 in old book"; "Would not
100 divisions be sufficient for snail instead of 2110 [?]" with a note
"Units move [?…] 1 division. Tens [?…] the divisions"; then

> d — a disc which ~~[?follows]~~ always moves the same distance, it does
> not touch the snail. b a rack which is stopped by the snail and then
> turns the pinion e in a similar manner to the digit count.g app.s above.

p 91:

> Digit counting app.s 12 March 36
> 5. A rack a with 30 feelers upon it and sliding on the base d. Another
> rack ⟨b⟩ gearing with a by means of pinion c and also with a pinion e
> upon the axis of which is a bevel wheel working into another bevel wheel
> which moves vertically on its axis
> When d descends a and b descend with it until a is stopped by one of its
> feelers when b is made to descend with twice the velocity of d by which
> means e and all gearing with it are made to revolve.
> d is to descend ~~15 cages~~ ⟨so that the feelers on a will pass 15 wheels
> if they are all⟩ in .9 of a turn then ⟨at 0⟩ stop .1 thus feeling and
> transfer.g all the digits in 2 turns
> The interposed pinion c may have the bevel wheel upon it, thus
> dispensing with b and e.
> The feelers are to be in 3 or 4 different parts of the circle on
> different wheels, so that a may pass thro' a space = 3 or 4 Cages if all
> the wheels are at zero. — — Let q > p. Then Tab.n of mult. p multiplier

Table at the foot (columns headed B, C, D, E):

```
B                      C              D               E
+p Carr Sub.n          +p No Car      +q No Car       +q Car Sub.n
−q runs up             [?−] [faint]   −[?]            −p
                                      0               0  — During Tabu.n
[left: "this should be −(d+1)"]
0
−d Carr Sub.n runs up       } 2
Change Car from − to +      }
During {  +1
Mul.n  {  +1
       {  +1
       {  = p−d at end of Mul.n
```

(b) Counting the digits now by **feelers**: a rack descends until a feeler
meets a wheel not at zero; the remaining motion turns the counting train.
The table pairs signed numbers with a kind of carriage: "Carr Sub.n" (a
subtraction with carriage) of q from p "runs up"; "No Car" is written
against the additions without carriage. Below, −d is put on, with
"Carr Sub.n runs up", then "Change Car from − to +", and during the
multiplication +1 is added at each step until the wheel holds p−d. So the
**count is built by adding 1 per stepping on a wheel set to −d, with
carriage**, and its running up is what signals.

### p 92, image 49 (`323/5`), between 12 and 16 March

Full resolution in `sketchbooks-control.md` §1; checked against its crop
(280,90,2160,1640). Key lines:

> Put p upon ⟨1st⟩ A ⟨2 and No 1 on B⟩ ~~and~~ q ⟨and No 3 on E⟩ upon
> ~~E~~ ⟨2⟩ F
> ~~Give off (… retain) p to No 1 on B and q to No 3 of E~~
> Do — −p to No 3. on E and −q to No 1 on A
> A or E runs up and directs which is to be Multiplier.
> If q is Mul.r it must be transferred to A … after which the mul.r of
> first Mul.n must be transferred to No 1 to ⟨have 1 subtracted from it and
> to⟩ limit the No. of steppings down, and to No 2 to have d+1 subtracted
> from it and to limit the No. of steppings up — but both 1 & 2 will want
> carriage

(b) p and −q (and q and −p) are added on two wheels; whichever **runs up**
(passes zero) shows which is greater, and so "directs which is to be
Multiplier". The step limits are set by putting the multiplier's count on
wheels "No 1" and "No 2" with 1 or d+1 subtracted, and "both … will want
carriage" — i.e. they are counted down with carriage so that they run up.

### p 93, image 49, 16 March

> 16 March — Decided that whenever transfers are made from Mill to Store or
> from Store to Mill the two central wheels should be ~~u~~ used together
> as one wheel

(`sketchbooks-control.md`, full resolution.)

### pp 94–95, image 50 (`323/6`), 22 March (full resolution in `sketchbooks-control.md` §1)

> Carriage is ⟨in some cases⟩ to be prevented when running up occurs and
> the ⟨lowest⟩ wheel put back to 0
> [figure: a "running up axis" with three arms over barrels A "Neg. Cyc /
> q−p < 0", B "Pos. Cyc / q−p > 0", C]
> At No 4 throw A into gear
> If in 5 q−p runs up A will be moved and cycle Neg. be put in gear. If it
> do not run up then A must be thrown out of gear and B into gear.
> The 1st vert.l of Cycle Neg. puts out A and puts in C which C on the next
> running up puts out the cycle Neg
> The term.n of Pos. or of Neg. Cyc acts jointly with the term.n of table
> making to put in the real division cycle

(b) A "**running up axis**" carries arms which, when q−p runs up, move a
lever and put one of two barrel cycles in gear. Running up is therefore a
mechanical motion (of the running-up axis), produced by the carriage out of
the top of the q−p wheels, and used to select. "Carriage … to be prevented
when running up occurs and the lowest wheel put back to 0": the carriage
that runs up is not to be propagated as a figure.

## 3. Vol XIII history, Feb–March 1836 (image 87, `229/48`; image 86, `229/47`)

(a) Image 87, left half of the stored image (0,0,2560,3126 at 0.35;
0,60,2560,820 at 0.6), rotated 180°:

> 6 Feb. Plan to make drums act without spring but with teeth cut out
> 1st Plan of raising axes by sectors moved by central drums
> see drawing 27 Feb
> 10 Central drum changed for small drums all round
> Page 67 Remarks on digit counting app.s
> 24 Plan of counting digits
> 1 March 1st plan of Zero Apparatus applied to barrels
> 7 March Running up applied to <u>any</u> op.
> 9 March feelin[g] [paper torn] without spring

At the head of the same page (24 March 1836, "Counting App.") the passage
quoted in `repetition-count-1836-1842.md` §2 (count tens and units
separately: "never be necessary to count more than nine & be recorded on a
units wh. and not more than 3 for a tens wh.").

Image 86 (2400,1700,2569,1426 at 0.5, rotated):

> 10 March Counting rack various stages up to 3rd [?Upp…]
> 6 April Time of backing type sector saved by [?printing] …

(b) The history ties the Feb pages (p 67, "Remarks on digit counting
app.s") and the 24 Feb "Plan of counting digits" (p 72–75) to the 7 March
"Running up applied to any op." (p 84), the 10 March counting rack (p 91,
dated 12 March on the page) and the 24 March tens/units refinement.

## 4. R2, R and ′R on the sheets (question 3)

All at full resolution or 0.45 strips with zooms; regions below.

**F/018–019, column e34 "R2"** (271 and 273, x ≈ 6136–6298 / 6144–6304;
strips 5950,0,560,full height at 0.45; 271 6130,6020,170,170 at 2.5). The
head is "R2", first column after the heavy rule that follows "Figures upon
Axis B", before "Axis C Ver". Every mark in the column:

| Sheet | Where | Mark |
|---|---|---|
| F/018 | above cycle 1 (rows 15–16) | "B3" over ↑ "1.1" |
| F/018 | cycle 1 row 11 | ↓ with two heads, "1.1" |
| F/018 | cycle 1 row 15 | "U3" (no arrow) |
| F/018 | cycle 2 | nothing |
| F/018 | cycle 3 rows 15–16 | "B 4" over ↑ "6" (no point at ×2.5) |
| F/019 | above cycle 4 (rows 15–16) | "B 4" over ↑ ".6" |
| F/019 | cycle 4 row 11 | ↓ with two heads, ".6" |
| F/019 | cycle 4 rows 15–16 | "U4 B3" over ↑ "1.1" |
| F/019 | cycle 5 row 11 | ↓ with two heads, "1.1" |
| F/019 | cycle 5 row 15 | "U3" (no arrow) |
| F/019 | cycle 6 | nothing |

No word, no stepped shaft and no figure other than these is in R2. (This
agrees with `mechanical/F018-cycle*.txt` and `F019-cycle*.txt`.)

**F/013, column t25 "′R" / "Ver"** (259, x 5050–5250; strip 4800,0,560,
full height at 0.45): cycle 1 row 1 ↑ ".6", rows 3–5 "Gears with N.o 2",
row 12 ↓ (two heads) ".6"; cycle 2 row 2/3 "U 4" ("Gears with N.o 4 in Top
Cage" belongs to t24 and runs into t25); cycle 3 "B 3", row 1 ↑ "1.1", rows
5–7 "Gears with N.o 1", row 12 ↓ "1.1"; cycle 4 "U 3"; on the rule before
cycle 5 "B 4" over three horizontal strokes. As `mechanical/F013-cycle*.txt`.

**F/013 note** (259, 4000,60,1350,420 at 0.8; 4430,60,220,110 and
4560,60,140,110 at 3–4):

> N.B. Mul[?t].[?n/?r] <u>must</u> be on an axis with <u>one</u> wheel R as
> R & R1 gear with N.o 1 & 2 of A <u>only</u> and R2 R3 are wanted for the
> other operation (6 Feb 36)

The raised ending of the first word is a small two-humped letter with two
dots under it; it can be "n" (Mult.n, as `F013.md`) or "r" (Mul.r,
multiplier). Not settled.

**F/014, column k17 "′R"** (261, strip 3200,0,480,full height at 0.45):
labels only, B3, U3, B4, U4, B3, U3, B4, U4, B3 in blocks 1–9; no arrows,
no words. As `mechanical/F014-plates.txt`.

**Vol II, Dec 1835 – Mar 1836.** In the pages read here (67–95) no wheel
or axis is called R2, R1 or R3. "R" occurs as "R = rack" (p 68) and as the
mark "R" on p 88 (§2), and in the p 81 barrel table ("11 5 R", not
re-read). "Register" occurs on pp 67, 68, 79 (struck "regis.r" and "regis.r
whs of divi.n"), 84 ("register axis") — always for a wheel set to a
cage or a count, never with a number or the letter R2. pp 1–66 were not
re-read; the earlier readings (`bolting-plates-sources.md`,
`platforms-1835-1836.md`) record no R2 there.

**Drawings.** A/030 (27 Feb 1836) names "R2, R3" among the axes of its
plan (preview reading in `platforms-1835-1836.md` §4; not re-read here).
A/029 and A/031, as read there, do not name R2. Nothing found says what R2
is.

## 5. Pinions put in gear for give off, add, step up, carry (question 4)

**Nothing in pp 67–95 names ″P, pp, ap, g, g1, ′g1, 02, ′g2, 03, cp or
"carriage pinions".** The nearest statements:

- p 76: "A and B are put on Mult.n axis ⟨each⟩ is received on the fig
  wh. of ⟨one of the⟩ carriages belonging to Mult.n axis."
- p 90: "fig. wh. on which p or q is put. This fig wh. is connected with
  add.n carriage"; "gears with units".
- p 89: "If A have 10 on rising 1/10 it is thrown into gear with the tens
  at the 2nd tooth. If B has 10 it is also thrown into gear with the tens
  but not untill the 3rd tooth" (counting apparatus, units/tens).
- p 93 (16 March): for transfers Mill↔Store "the two central wheels should
  be used together as one wheel".
- p 94: "Carriage is ⟨in some cases⟩ to be prevented when running up
  occurs".
- Earlier, from other notes (not re-read): Vol II p 42 (21–23 Dec 1835),
  "Receive from table / Lock — centre pinion ⟨to N.o 3⟩ — carr. pin.s — on
  platform N.o 1 … For Stepping up / Lock — Step. Ax. … to Pl. 3 … Lock —
  the 2 centre pin.ns to Pl. 4 — Carr. pins to N.o 2"
  (`bolting-plates-sources.md` §3.7); p 24 (5 Dec 1835), "Step up multiplier
  … and sets lifters / Lift lifters / Lower stepping axis lower and giving
  off axis / Give off from Table to Product / Carry (see page 23)" (§3.5);
  p 63 (9 Feb 1836), "For each fig. wh. ~~Give off~~ = Short time / Receive
  = Short / D.o as part of Mult = Long time" (§3.9).

These name "centre pinion(s)" and "carr. pin.s" by kind, not by the
letters of the F sheets, and say which platform they are locked to, not
which motion (give off, add, step, carry) they serve.

## 6. Hypotheses (labelled; none adopted)

- HYPOTHESIS. "Running up" is the carriage (or borrow) out of the highest
  wheel of a counting or figure axis, i.e. the passage through 0000/9999;
  the pages use the motion it gives (to a "running up axis", p 94) to
  throw parts in or out of gear. Basis: the "R" marks of p 88, "Carr Sub.n
  runs up" on p 91, p 84's "axis having a carriage connected with it",
  p 94's "Carriage … to be prevented when running up occurs". No page
  states it as a definition.
- HYPOTHESIS. A count is put on an axis as a complement (e.g. −d, or the
  count less 1), and 1 is added (p 91) or subtracted (p 84) with carriage at
  each stepping or repetition, so that the running up happens on the last
  one. Basis: p 91's "−d Carr Sub.n runs up … +1 +1 +1 = p−d at end of
  Mul.n", p 92's "have 1 subtracted … have d+1 subtracted … both 1 & 2 will
  want carriage".
- No hypothesis is offered for R2.
