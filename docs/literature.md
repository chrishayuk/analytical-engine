# The literature, against the run

Read for this project: R. Rojas, "The first computer program"
(arXiv:2303.13740, 2023; *CACM* 2024), and R. Rojas, "Die Computerprogramme
von C. Babbage", *Informatik-Spektrum* 40(3), 2017, pp. 284-290. A short web
search (25 November 2026) found nothing else on BAB/L/001 in particular.
Bromley (2000), "Babbage's Analytical Engine Plans 28 and 28a: The
Programmer's Interface", *IEEE Annals* 22(4), and Rojas (2021) were found and
not read. Nothing here is claimed as new.

## Already published: the machine the run uses

Rojas (2017) describes, from the notations of Series L, the rules the run
relies on: reading a column is destructive; a number sent to the mill can be
laid at the same time in another column as its digit-wise ten's complement,
and moved back to restore it ((v1, v8) … (v8, v1)); a result cannot be
written to a column that is one of the operation's own arguments ("v1 = v1 +
v3 [war] aus unbekannten Gründen mechanisch nicht möglich"); operations and
addresses are on separate strings of cards. Rojas (2023) adds the reuse of
the multiplicand in the mill for b′a and b′c. The run's decisions 1, 2 (its
first half), 4 and 5 are therefore his readings too, reached here from the
sheet and the remark.

Rojas (2017, Table 3) lists BAB/L/001 as one program, "4.8.1837, Zwei
Simultangleichungen, Lösung für x und y", and BAB/L/026 as "Zwei Methoden für
die Lösung von zwei Simultangleichungen", 8.1837.

## Not found in what was read

These may be in Bromley (2000) or Rojas (2021), which were not read:

- that the cover dates No. 2 to 5 August, a day after No. 1;
- that operation 12 of No. 2 is a subtraction whose result is written
  −c − ax, which no order of its operands gives;
- that every cell, accent and count of both tables agrees with what the
  operations do (a check, rather than a historical claim);
- the pencil "6 Mult = 18 / 1 Div = 5 / 6 add = 1" against the table's five
  multiplications and two divisions.

## Where Rojas and this transcription agree

Every store cell, every mill entry and every formula of both tables, as
Rojas prints them, is the same as transcribed here, with the exceptions
below. His reading of the C before a number as the complement, of Ca, Cc, Cb
as complements laid in v8, v5, v9, and of rows 8-10 as transfers that
restore a, c, b, is the reading the run uses (decisions 4 and 5).

## Where they differ

1. **One program or two.** Rojas presents the 13-row table as the second
   part of one computation, dated 4 August 1837, "No. 1". The cover lists
   two numbered entries: No. 1, 4 Aug 1837, x only, 7 operations; No. 2,
   Aug. 5, x and y, 13 operations, with separate counts. The 13-row table
   is No. 2, of 5 August.
2. **Where the second table is.** Rojas writes that it is "in the same
   document (L26, kept in the Babbage archive)". It is on BAB/L/001's
   opened sheet (image 222/594), below No. 1.
3. **Row 7 of No. 2.** Rojas's table has x = v4 = v6′/v2″; his summary has
   v4′. The sheet has v₄′, and the run confirms it is v4's first new number.
4. **The table of b′.** Rojas says reuse of an operand in the mill "is not
   described in BAB L1", and also that "Babbage mentions explicitly that b′
   is reused for a multiplication table". The remark under No. 1 describes
   more than reuse: an operation between two multiplications by b′ destroys
   the table, and it must be made again. The run needs the first half
   (operation 2 of each table multiplies by b′ although v5 is at zero);
   the second half is decision 2's "another operation destroys it", which
   no row of BAB/L/001 tests.
5. **Operation 12 of No. 2.** Rojas prints v₁‴ = −v₃″ − v₅″ without comment.
   The operation is a subtraction; the run finds that neither order of
   subtraction of the two operands gives −c − ax.

## The later sheets, against Rojas (2017)

Rojas's Table 3 lists the programs by number and date. Against the sheets:

1. **Program 26** is described as "two methods for the solution of two
   simultaneous equations", 8.1837. The sheet (BAB/L/026, undated) computes
   one formula, (ab + c∂)/(a + c), by two methods; there are no equations.
   Rojas's own worked example (his Tables 4 and 5) is that formula, but
   written with give-off-and-retain ("0/a") and a complement in v9, which
   the sheet does not have: it marks each number going to the mill with an
   arrow and clears no column.
2. **Program 23** (7.6.1838). Rojas names the backing apparatus for the
   formula cards z and for the start y; the sheet's cover and table name
   them the other way, Y backing to the formula cards and Z to the
   combinatorial cards. The table works out four coefficients, x⁰ to x³,
   and begins a fifth, where Rojas describes three. The combinatorial index,
   which he finds unclear, is shown: Tab is stepped by a difference (Δ′ = 1),
   Comb is set from Tab and reduced by one at each pass.
3. **Program 14.** Rojas says the archive's description, two cosine series,
   is wrong and that the program multiplies polynomials. The sheet agrees:
   cosines are only in the catalogue's title.
4. **Programs 19 to 22.** Rojas doubts that Babbage had a way to coordinate
   loops of operations with the variable cards. The sheets list every card;
   L/021 and L/022 move each new coefficient into the column its multiplier
   left, so the reduced equations stand as the first did and the same
   pattern of cards could serve again. Whether that was meant to make the
   cards repeat the sheets do not say.

These are readings of the sheets, by agents, not yet checked by a person,
against two papers by Rojas; the papers not read may already have them.

## Not yet read

Rojas (2021) in the *IEEE Annals*, which reviews "some" of the 26 programs;
Bromley (1982), on the 1838 design; Babbage's "On the Mathematical Powers of
the Calculating Engine" (December 1837), Babbage's own description of the
engine, written four months after this sheet, which may say how a table of multiples is made and
so test the "about ten turns of the hand".
