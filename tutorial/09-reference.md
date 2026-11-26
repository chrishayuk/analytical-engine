# 9. Reference

## Commands

```console
$ babbage --help
babbage FILE                 run a page: every operation, every cell of the sheet checked (- reads standard input)
babbage no L001-1            a page of the corpus (babbage list)
babbage FILE --strict        never go on with the sheet's value where it differs (also with verify)
babbage FILE --store         the whole store after each operation
babbage FILE --at a=2,b=3,…  the same run, its values shown at these numbers
babbage cards FILE           the program as operation and variable cards
babbage verify               run every page, and say what agrees
babbage list                 the pages
babbage decisions            the rules of the machine, and what each rests on
babbage json FILE [--at …]   the run as JSON, for the playground
babbage lsp                  a language server on standard input and output
```

```console
$ babbage list
L001-1   BAB/L/001  No. 1, 4 Aug 1837  Elimination between two equations of the first degree ax + by + c = 0  a'x + b'y + c' = 0 which is equivalent to calculating the value of x from the eqn x = (bc'-b'c)/(b'a-ba')
L001-2   BAB/L/001  No. 2, 5 Aug 1837  Elimination between two equations of the first degree ax + by + c = 0 & a'x + b'y + c' = 0 which is equivalent to calculating x & y from the equations x = (bc'-b'c)/(b'a-ba') & y = (a'c-ac')/(b'a-ba')
L002     BAB/L/002  No. 2, 14 Aug 1837  Computation of λ0, λ1, λ2, &c from (A0 + A1x + A2x² + &c)/(a + bx) = λ0 + λ1x + λ2x² + &c by Means of the relation λm = (Am - bλm-1)/a = Nm/a & λ0 = A0/a
L004-1   BAB/L/004  No. 4.1, 16 Aug 1837  Determination of x from the Equation ax - b = 0
L004-2   BAB/L/004  No. 4.2, 16 Aug 1837  Reduction of the two equations ax + by + c = 0, a'x + b'y + c' = 0 to a single equation of the form Hx - M = 0
L004-3   BAB/L/004  No. 4.3, 16 Aug 1837  Reduction of the same two equations ax + by + c = 0, a'x + b'y + c' = 0 to a single equation of the form Ky - M = 0
L005     BAB/L/005  No. 5, 16 Aug 1837  Reductions of the three equations ax + by + cz + d = 0, a'x + b'y + c'z + d' = 0, a''x + b''y + c''z + d'' = 0 to two equations of the form Hx + Ky + M = 0 and H'x + K'y + M' = 0
L006     BAB/L/006  No. 6,   Notation For the reduction of the three Equations ax + by + cz + d = 0, a'x + b'y + c'z + d' = 0, a''x + b''y + c''z + d'' = 0 To two Equations of the form Hx + Ky + M = 0, H'x + K'y + M' = 0
L007     BAB/L/007  No. 7, before 22 Aug 1837  Notation of the Reduction of the four equations ax + by + cz + du + e = 0, a'x + b'y + c'z + d'u + e' = 0, a''x + … = 0, a'''x + … = 0 (A) To three equations of the following form Hx + Ky + Lz + M = 0, H'x + K'y + L'z + M' = 0, H''x + K''y + L''z + M'' = 0 (B)
L008     BAB/L/008  No. 8, 20 Aug 1837  Calculation of a rational Integral Function, of the Second Degree by Differences
L009     BAB/L/009  No. 9, 22 Aug 1837  Computation of Tn = n³
L010     BAB/L/010  No. 10, 23 Aug 1837  Computation of Tn = n⁴ By means of differences
L011-1   BAB/L/011  No. 11.1, 28 Aug 1837  Computation of u(z+1) = fz.uz + f1z from z = 0 to z = 1 = 2 &c
L011-2   BAB/L/011  No. 11.2, 28 Aug 1837  Computation of u(z+2) = fz.u(z+1) + f1z.uz + f2z from z = 0 to z = 1 = 2 &c
L012     BAB/L/012  No. 12, 29 Aug 1837  Calculation of Pk = (Mk-1/Nk-1) Pk-1. M and N rational functions of the second degree
L013-1   BAB/L/013  No. 13.1, 11 Dec 1837  Calculation of the 7th coeffecient of ΣAm x^m × Σan x^n = Σλp x^p = ΣAq ap-q . x^p; λ6 = A0a6 + A1a5 + A2a4 + A3a3 + A4a2 + A5a1 + A6a0
L013-2   BAB/L/013  No. 13.2, 11 Dec 1837  Calculation of the first seven coeffecients of the foregoing product viz. {A0a0, A0a1 + A1a0, A0a2 + A1a1 + A2a0, ... A0a6 + A1a5 + A2a4 + A3a3 + ...}
L014-1   BAB/L/014  No. 14.1,   Calculation of the 7th coeffecient of ΣAm x^m × Σan x^n = Σλp x^p, m = 0,1,2,&c n = 0,1,2,&c p = 0,1,2,&c, λp = ΣAq ap-q q = 0,1,2,&c ...p. λ6 = A0a6 + A1a5 + A2a4 + A3a3 + A4a2 + A5a1 + A6a0
L014-2   BAB/L/014  No. 14.2,   Calculation of the first six coeffecients of the above product. λ0 = A0a0, λ1 = A0a1 + A1a0 ..... λ5 = A0a5 + A1a4 + A2a3 + A3a2 + A4a1 + A5a0
L015     BAB/L/015  No. 15, 23 Dec 1837  Notation for determining the value of x from the three equations ax + by + cz + ∂ = 0, a'x + b'y + c'z + ∂' = 0, a''x + b''y + c''z + ∂'' = 0 (A); First by reducing them to two equations of the form Hx + Ky + M = 0, H'x + K'y + M' = 0 (B); Secondly by reducing these two to one equivalent to H''x = M'' when x = M''/H''
L016-1   BAB/L/016/1  No. 16, Jun 1838  Reduction of the equations ax + by + cz + d = 0, a'x + b'y + c'z + d' = 0, a''x + b''y + c''z + d'' = 0 to three others Ax + By + Cz + D = 0, A'x + B'y + C'z + D' = 0, A''x + B''y + C''z + D'' = 0 = By + Ax + Cz + D wherein A = 0, A' = 0, A'' = 0, which in like manner are reduced to βy + αx + γz + δ = 0, β'y + α'x + γ'z + δ' = 0, β''y + α''x + γ''z + δ'' = 0 wherein β = 0 α = 0
L016-2   BAB/L/016/2  No. 16, Jun 1838  Successive reduction of simultaneous equations: three equations in three variables, and five in five
L017     BAB/L/017  No. 17, 1 Oct 1838  Notation For computing the elliptic radius vector by having the eccentricity and mean anomaly
L018     BAB/L/018  No. 18, 9 Aug 1841  Notation For Computing the Elliptic radius vector by having the eccentricity ε & mean Anomaly Ξ
L019     BAB/L/019  No. 19, 31 Jul 1840  Notation of the Reduction of the Four Equations
L020     BAB/L/020  No. 20, 31 Jul 1840  Notation of the Reduction of the Three Equations Bx + Cy + Dz + E = 0, 'Bx + 'Cy + 'Dz + 'E = 0, ''Bx + ''Cy + ''Dz + ''E = 0 to two viz γy + δz + ε = 0, 'γy + 'δz + 'ε = 0 and these to ∂z + e = 0 with the solution
L021     BAB/L/021  No. 21, 15 Aug 1840  Reduction of the four Equations
L022     BAB/L/022  No. 22, 15 Aug 1840  Reduction of the three Equations Bx + Cy + Dz + E = 0, 'Bx + 'Cy + 'Dz + 'E = 0, ''Bx + ''Cy + ''Dz + ''E = 0 to two others viz γy + δz + ε = 0, 'γy + 'δz + 'ε = 0 and of these to ∂z + e = 0
L023     BAB/L/023  No. 23, 7 Jun 1838  Notation of a Formula for the Multn of A + Bx + Cx² + ... by a + bx + cx² + ...
L024-1   BAB/L/024  No. 24.1,   Notations for determining Px+1 from Px, Px+1 = (Wx/Vx).Px, Wx & Vx being both quadratic functions of x
L024-2   BAB/L/024  No. 24.2,   bs(i+1) = (Pi.bs(i) − Qi.bs(i−1))/Ri
L025     BAB/L/025  No. 25,   Algebraic Notation
L026-1   BAB/L/026  No. 26.1,   Calculation of the numerical value of x = (ab + cd)/(a + c)
L026-2   BAB/L/026  No. 26.2,   Another method for the same x = (ab + cd)/(a + c) = (ab + bc - bc + cd)/(a + c) = b + (∂ - b)c/(a + c)
L027     BAB/L/027  No. 27,   List of Variables their signs & coefficients
```

```console
$ babbage verify
L001-1    42 statements,  42 agree
L001-2    81 statements,  80 agree
         ✗ line 37: − on v3 (c) and v5 ((abc′ - ab′c)/(ab′ - a′b)) gives -v3″-v5″: the operation gives v3″ − v5″, but the sheet writes -v3″-v5″: neither order of the two operands gives that. The run goes on with the value on the sheet
L002      68 statements,  68 agree
L004-1     7 statements,   7 agree
L004-2    21 statements,  19 agree
         ✗ line 38: composition: v1′x + v2″ = (v2′-v4)x - (v6-v3′): v3′ would be v3 after 1 change, but v3 has changed 0 times so far
         ✗ line 38: composition: v1′x + v2″ = (v7v1-a′)x - (c′-v7v3): v1′x + v2″ is (abb′x - a′b^2x - bb′c + b^2c′)/b^2, but this is (abb′x - a′b^2x + bb′c - b^2c′)/b^2
L004-3    16 statements,  16 agree
L005     199 statements, 199 agree
L006     107 statements, 107 agree
L007      79 statements,  77 agree
         ✗ line 48: where v22″ comes from: v22″ (d′′′/d) is not in a column this row leaves at zero, nor the table standing in the mill
         ✗ line 61: mill: (d′/d)b-b″: the operation gives (-bd′′ + b′′d)/d
L008      66 statements,  66 agree
L009      99 statements,  99 agree
L010     128 statements, 125 agree
         ✗ line 62: v3 = 320: the turn gives 302
         ✗ line 64: Car2 = 469: the turn gives 369
         ✗ line 64: v4 = 469: the turn gives 369
L011-1     8 statements,   8 agree
L011-2    14 statements,  14 agree
L012     124 statements, 124 agree
L013-1    27 statements,  27 agree
L013-2    19 statements,  18 agree
         ✗ line 39: v18 at zero to receive: v18 still holds Ca4, which would be lost
L014-1    37 statements,  33 agree
         ✗ line 28: where v5 comes from: v5 (A4) is not in a column this row leaves at zero, nor the table standing in the mill
         ✗ line 29: where v6 comes from: v6 (A5) is not in a column this row leaves at zero, nor the table standing in the mill
         ✗ line 29: v5 at zero to receive: v5 still holds A4, which would be lost
         ✗ line 30: v6 at zero to receive: v6 still holds A5, which would be lost
L014-2    94 statements,  92 agree
         ✗ line 59: where v14″ comes from: v14″ (Ca0) is not in a column this row leaves at zero
         ✗ line 60: v2 = Ca0: no column this row leaves at zero holds a0
L015      69 statements,  64 agree
         ✗ line 36: where v4 comes from: v4 (d) is not in a column this row leaves at zero
         ✗ line 36: v4 at zero to receive: v4 still holds d, which would be lost
         ✗ line 42: v4 at zero to receive: v4 still holds c′d, which would be lost
         ✗ line 62: where v4‴ comes from: v4‴ (bc′c′′d′ - bc′^2d′′ + b′cc′d′′ - b′c′c′′d - b′′cc′d′ + b′′c′^2d) is not in a column this row leaves at zero
         ✗ line 62: where v1″ comes from: v1″ (ab′c′c′′ - ab′′c′^2 - a′bc′c′′ + a′b′′cc′ + a′′bc′^2 - a′′b′cc′) is not in a column this row leaves at zero
L016-1   156 statements, 156 agree
L016-2     0 statements,   0 agree
L017     127 statements, 118 agree
         ✗ line 80: v6 left at 0: v6 was already zero
         ✗ line 80: where v6 comes from: v6 (168) is not in a column this row leaves at zero
         ✗ line 109: composition: v16 = (v1/v6)·v16: v16 is B66, but this is 12/7B66
         ✗ line 113: composition: v18 = (v1′/v6′)·v16: v18 is 135/112B66, but this is 45/64B66
         ✗ line 113: composition: (P1/Q1)·v16 = ((P0+ΔP)/(Q0+ΔQ0))·(P0/Q0)·B66: (P1/Q1)·v16 is 45/64B66, but this is 135/112B66
         ✗ line 119: composition: v20 = v14″·v17: v20 is 81/640B66, but this is 27/56B66
         ✗ line 119: composition: ((v1′+v4)/(v7+v8′))·v17 = ((v2+v3+v4)/(v6+v8+v9′+v10))·v17: ((v1′+v4)/(v7+v8′))·v17 is 27/56B66, but this is 3645/9128B66
         ✗ line 119: composition: ((v2+v3+v4)/(v6+v8+v9′+v10))·v17 = ((P0+ΔP+ΔP)/(Q0+ΔQ0+ΔQ0+Δ²Q0))·v18: ((v2+v3+v4)/(v6+v8+v9′+v10))·v17 is 3645/9128B66, but this is 27/56B66
         ✗ line 135: composition: B68 = -(6·6/4)·((6+2)/(1·7·6))·B66: B68 is 12/7B66, but this is -12/7B66
L018      91 statements,  88 agree
         ✗ line 81: mill: P1/Q1: the operation gives 184320
         ✗ line 82: mill: (P1/Q1)·B68: the operation gives 45/64/81/140a
         ✗ line 96: mill: ΔQ2+ΔQ2: the operation gives 1160
L019     167 statements, 167 agree
L020     148 statements, 147 agree
         ✗ line 126: mill: -e/d: the operation gives (-BB′C′D′′ + BB′C′′D′ - B′B′′CD′ + B′B′′C′D + B′^2CD′′ - B′^2C′′D)/(-BB′C′E′′ + BB′C′′E′ - B′B′′CE′ + B′B′′C′E + B′^2CE′′ - B′^2C′′E)
L021     182 statements, 179 agree
         ✗ line 88: v26 = C(d′) on its way: no column this row reads holds the number Cd′ is the complement of
         ✗ line 89: cards (v23 v24)(v14 v26)(v24 v23)(v26 v14)(0 v29): the run needs (v23 v24)(v14 0)(v24 v23)(0 v29)
         ✗ line 70: 48 cards in all: the count comes to 49
L022      99 statements,  99 agree
L023     123 statements, 123 agree
L024-1    59 statements,  56 agree
         ✗ line 63: where v1‴ comes from: v1‴ (W0 + 3ΔW0 + 3Δ²W) is not in a column this row leaves at zero
         ✗ line 63: v2 = W3: the operation of the row gives (W0 + 3ΔW0 + 3Δ²W)/(V0 + 3ΔV0 + 3Δ²V)
         ✗ line 64: mill: (W3/V3)·P3: the operation gives (3P0W0ΔW0Δ²W + 3P0W0ΔW0^2 + 4P0W0^2ΔW0 + 3P0W0^2Δ²W + P0W0^3)/(3V0ΔV0Δ²V + 3V0ΔV0^2 + 4V0^2ΔV0 + 3V0^2Δ²V + V0^3)
L024-2    64 statements,  57 agree
         ✗ line 45: mill: Q1+ΔQ: the operation gives (P1b1 + Q1R1 - Q1b0 + R1ΔQ)/R1
         ✗ line 47: v15 left at 0: v15 was already zero
         ✗ line 47: where v15′ comes from: v15′ ((P1b1 - Q1b0)/R1) is not in a column this row leaves at zero
         ✗ line 47: v17 = b2: the operation of the row gives (-P1Q1b0 + P1b1ΔP + P1^2b1 - Q1b0ΔP)/R1
         ✗ line 55: v20 = Q3·b3: the operation of the row gives (P1Q1b1 + 2P1b1ΔQ - 2Q1b0ΔQ - Q1^2b0)/R1
         ✗ line 56: mill: P3·b3 - Q3·b2: the operation gives (-3P1Q1R1b0ΔPΔR + 2P1Q1R1b0ΔQΔR - P1Q1R1b1ΔPΔR - 3P1Q1R1^2b0ΔP + 2P1Q1R1^2b0ΔQ - P1Q1R1^2b1ΔP - P1Q1R1^2b1ΔR - P1Q1R1^3b1 + P1Q1^2R1b0ΔR + P1Q1^2R1^2b0 - 2P1R1b1ΔPΔQΔR + 2P1R1b1ΔP^2ΔR - 2P1R1^2b1ΔPΔQ + 2P1R1^2b1ΔP^2 - P1R1^2b1ΔQΔR - P1R1^3b1ΔQ - P1^2Q1R1b0ΔR - P1^2Q1R1b1ΔR - P1^2Q1R1^2b0 - P1^2Q1R1^2b1 + 3P1^2R1b1ΔPΔR - 2P1^2R1b1ΔQΔR + 3P1^2R1^2b1ΔP - 2P1^2R1^2b1ΔQ + P1^3R1b1ΔR + P1^3R1^2b1 + 2Q1R1b0ΔPΔQΔR - 2Q1R1b0ΔP^2ΔR + 2Q1R1^2b0ΔPΔQ - 2Q1R1^2b0ΔP^2 - 2Q1R1^2b1ΔPΔR + 3Q1R1^2b1ΔQΔR - 2Q1R1^3b1ΔP + 3Q1R1^3b1ΔQ + Q1^2R1b0ΔPΔR + Q1^2R1^2b0ΔP + Q1^2R1^2b1ΔR + Q1^2R1^3b1 - 2R1^2b1ΔPΔQΔR + 2R1^2b1ΔQ^2ΔR - 2R1^3b1ΔPΔQ + 2R1^3b1ΔQ^2)/(R1^2ΔR^2 + 2R1^3ΔR + R1^4)
         ✗ line 57: where v13‴ comes from: v13‴ ((-3P1Q1R1b0ΔP - P1Q1R1b1ΔR - 2P1Q1R1^2b1 + 2P1R1b1ΔP^2 - 2P1R1b1ΔQΔR - 3P1R1^2b1ΔQ - P1^2Q1R1b0 + 3P1^2R1b1ΔP + P1^3R1b1 - 2Q1R1b0ΔP^2 + 2Q1R1b0ΔQΔR + 2Q1R1^2b0ΔQ - 2Q1R1^2b1ΔP + Q1^2R1b0ΔR + Q1^2R1^2b0 - 2R1^2b1ΔPΔQ)/(R1^2ΔR + R1^3)) is not in a column this row leaves at zero
L025      93 statements,  89 agree
         ✗ line 69: v18 = B610: the operation of the row gives 45/64
         ✗ line 69: v19 = B610: the operation of the row gives 45/64
         ✗ line 70: v18 at zero to receive: v18 still holds 729/1792a, which would be lost
         ✗ line 70: v19 at zero to receive: v19 still holds 729/1792a, which would be lost
L026-1    27 statements,  27 agree
L026-2    31 statements,  31 agree
L027       0 statements,   0 agree

35 pages; 2672 statements of the sheets checked, 2622 agree.
15 page(s) with statements that do not agree.
```

## The rules of the machine

```console
$ babbage decisions
1. Reading a column leaves it at zero.
   BAB/L/001: every column an operation takes from is written 0 in that row, and is not used again until it is given a new number. The run requires it: an operand must come from a column the row leaves at zero, or from the mill.

2. The mill keeps the table of multiples of the multiplicand until another operation comes between.
   BAB/L/001 remark: making b′a − ba′ fourth "would have caused the table of b′ made in the third operation to be destroyed and it must have been recomputed in the operation for b′c". In No. 1 and No. 2, operation 2 multiplies by b′ although v5 was left at zero by operation 1. So a multiplication whose first factor is the multiplicand of the multiplication just before reads only the multiplier. Any other operation of the mill destroys the table.

3. The first factor written is the multiplicand.
   The remark names the table of b′ for b′a and b′c, written v5·v1 and v5·v3: the factor the table is of is written first.

4. A number taken from a column may at the same time be laid in another as its complement.
   Back of BAB/L/001: "C … before any number signifies the Complement of that number as Ca means complement of a". No. 2 writes Ca, Cc and Cb in v8, v5 and v9 in the rows where a, c and b are read. The run requires the complemented number to be one read in that row.

5. A transfer from one column to another complements; complementing twice restores.
   No. 2, operations 8 to 10: v8, v5, v9 (Ca, Cc, Cb) are left at zero and v1, v3, v2 receive a, c, b, with no operation of the mill. The mechanism (the receiving wheels turned the opposite way) is Rojas's explanation (2023), not stated on the sheet; the sheet shows only Ca in and a out.

6. A transfer does not touch the mill, and leaves its table standing.
   Not shown by BAB/L/001 either way: no multiplication there follows a transfer and reuses a table. A choice, which no result here depends on.

7. Accents count the numbers a column has been given.
   BAB/L/001: v₁′ is the first number given to v1 after a, v₁″ the second. A complement laid in a column counts (No. 2 calls the column holding Cc v5′, so ax is v₅″). Zeroing does not. A working variable's first number has no accent (v7 = v5·v1). The run checks every accent on the right-hand column against its own count.

8. An accented name means that number, wherever it now is.
   No. 2, operation 8 is written v₁″ = v₁ = a: the a in v1 had been read away at operation 1 and comes back from v8. So v₁ (no accent) names the first number v1 held, not the column. The run looks every accented name up in the column's history.

9. A column is given a number only when it is at zero.
   BAB/L/001 and BAB/L/002: every column any row gives a number to is at zero, never yet used or left at zero by an earlier row. Not stated on a sheet; the run requires it, so that a number laid over another is caught.

10. Where a sheet has no right-hand column, a subtraction or division takes its operands in the order the mill column writes.
   BAB/L/002 writes each row as the operation, the mill's result (A₁ − bλ₀, N₁/a) and the cells, with no formula in the variables. The run then has no other statement of the order, so on such a sheet the mill column is checked for what is taken and made, not for which way round.

11. Where a sheet has no right-hand column, the first factor the mill column writes is the multiplicand.
   BAB/L/004 No. 2 writes Aa and then Ac, with A = b′/b in no column at the second: the table of A is still standing. BAB/L/007 does the same four times over (d′/d times a, b, c, e), reading one column in each row after the first.

12. A composition written as equations agrees up to a factor free of the unknowns.
   BAB/L/004 No. 2 writes each member of its composition "= 0", and its last member is b times the one before. Each = is checked against the member before it.

13. An addition may take more than two numbers in one operation.
   BAB/L/011, second table, operations 3 and 6: f₀u₁ + g₀u₀ + h₀ in one row, three columns read.

14. Numbers may be given to the store from outside the table between operations.
   BAB/L/011 writes "Calculate f(1) f₁(1)" across the columns between cycles, with no operation that puts them there. The run gives the columns the numbers (each must be at zero), counts no operation and checks nothing else.

15. The store can work as a difference engine, with carriages, and no mill.
   BAB/L/008 to L/010 (20 to 23 August 1837) tabulate n² + 2n + 3, n³ and n⁴ in the store alone, with three "Carriages Negative". Each row is a turn: a column read is subtracted from the carriages the row names and left at zero; a carriage's number is laid on the columns the row names, which need not be at zero; "−0" clears a carriage. The actions of each turn are those the sheet's right-hand column or numbered instructions state, where written, and by the same rule where not.

16. On wheels of k places, a complement is 10^k − x; in letters, −x.
   BAB/L/008 writes 998 for the complement of 2 on three-figure wheels; L/012 writes C.ΔM in letters. 10^k − x and −x are the same figures below the highest place, so a carriage holding C.ΔM is held as −ΔM.

17. Carriage turns count as small operations.
   BAB/L/012 cover: "Twelve Operations are required for each value of P. Two Great and Ten Small": ten turns and a multiplication and a division. BAB/L/010 cover: "2m operations for each value of Tn", eight turns for n⁴.

18. How a carriage gives M and N to the mill's columns is not settled.
   BAB/L/012 writes M1 in v1 at row 7 while Car3 holds C.M1, and M2 at row 19 while Car3 holds M2 (likewise N in v9 at rows 12 and 24). The run gives the complement at rows 7, 12, 31, 36 and not at 19, 24, as the cells require; no single rule does both.

19. A number taken from a column may at the same time be laid, as it is, in another.
   BAB/L/018 (1838–41) does so 27 times: Q0 into v6 at row 1, ΔQ0 into v8 at row 4, ΔP into v3 and v4 alternately. BAB/L/001 lays only complements; whether the copy goes through a complement and back (Rojas's "give off and retain") the sheet does not say.

20. A table is made of the factor the next multiplication uses again.
   BAB/L/015 (23 December 1837), rows 23 to 26: HK′ then MK′ with K′ in no column, and H′K then M′K with K in none. The mill tabulates K′ and K, the factor written second. On sheets with no right-hand column the run makes the table of whichever factor the next multiplication, reading one column, needs.

21. A number may be given off to the mill and retained.
   BAB/L/026 (undated) marks every number going to the mill with an arrow, ←, and clears no column: a and c are each taken twice. BAB/L/016 (June 1838), back: "G.R signifies give off & retain"; BAB/L/019 (July 1840), back: the 0 above means the column is reduced to zero, the letter below that it is "retained at the same place … by means of its Complement previously put out". The run gives the number to the mill and leaves it in its column; its accents do not change. A complement written on its way back ("C.'B 0") is checked to be of the number retained.

22. A complement read into the mill gives the number it is the complement of.
   BAB/L/014, second table: each a is read again and again from a column holding "Comp a", and laid again as "Comp a", with no transfer ever bringing it back.

23. The variable cards are the pairs the run moves numbers by.
   BAB/L/019 and L/020 (1840) list beside each operation its variable cards, "(v23 v7) the first variable … is that which is given off the second … that which receive[s]", 0 for the mill, with their counts and running totals. The run derives the same pairs from the cells and checks the sheet's, as sets; the order is not checked.

24. Where the mill column and the operation differ, and no cell writes what the operation gives, the run goes on with the sheet's value.
   BAB/L/020 writes −e/∂ = z from a division of ∂ by e; BAB/L/018 marks rows 5 and 6 with each other's signs. One slip is then one disagreement, not a cascade.

25. With --strict, the run never goes on with the sheet's value: where they differ, it keeps its own.
   So that agreement counts only what the machine confirms unaided. A slip is then followed by the disagreements it causes.

26. A looped program is run from its cards. The groups run in order; after the last card of a group, a backing apparatus sends the cards to the start of another group, unless its condition holds.
   BAB/L/023 (7 June 1838), cover: "There are three groups of cards … The backing apparatus Y backs the cards to the beginning of the formulae cards. The backing apparatus Z backs them to the beginning of the cards forming the combinatorial numbers." In its table, Y backs after each subtraction that leaves Comb above 0, and Z after those that leave it at 0.

27. In a looped program, a column the cards read keeps its number.
   BAB/L/023 writes no 0 under Δ′, Tab or Const when they are read, and Tab and Const are read again in later passes. Comb, given a new number, is written "0 1": a 0, then the number.

28. Letter cards stand at a place given by the store. The sheet's advances and backs are checked against the moves needed between the letters the cards read.
   BAB/L/023 writes the moves ("Great back 1, Small back 2") and not what sets them. Placing the great cards at Tab − Comb and the small at Comb − 1 gives every move the sheet writes.

29. Great operations are multiplication and division; small are addition, subtraction and transfers.
   BAB/L/001 No. 2: "great 7 small 6" with 5 multiplications, 2 divisions, 3 subtractions and 3 transfers.

30. Values are compared as algebra.
   Every number the sheet writes is in letters (b′a, bc′ − b′c). The run holds rational functions of the page's letters exactly and compares by cross-multiplying, so a check holds for all values of the letters, not for chosen numbers.
```

## The notation

A line is a directive word and what follows it. `%` starts a note, at the
start of a line or after a space. Words in `"…"` at the end of a line are the
sheet's own words, quoted. Accents are `'`: `b'` is b′, `v1''` is v₁″. `·` or
`.` multiplies, and so does writing two things side by side (`b'a`). `C`
before a number is its complement.

| line | meaning |
|---|---|
| `Sheet BAB/L/001` | the archive reference |
| `No. 1` | Babbage's number for the program |
| `Date 4 Aug 1837` | the date the sheet gives |
| `Title "…"` | the heading, quoted |
| `Image 222/594 upper table` | the image it is read from |
| `Letters a b c a' b' c'` | the letters values are made of |
| `Unknowns x y` | the unknowns of the equations |
| `Equation a x + b y + c = 0` | an equation the sheet solves |
| `Find x = (bc'-b'c)/(b'a-ba')` | a result as the sheet states it |
| `Store v1 = a, v2 = b` | the store at the start |
| `Working v7` | the working columns |
| `Op N [*] [op] \| mill \| cells \| formula` | an operation |
| `Composition x = … = …` | every member must be equal |
| `States great 5, small 2, …` | the counts: great, small, total, variables, working, occupied |
| `Remark "…"` | kept, not run |
| `Unrun "…"` | transcribed, not run |

Store cells: `vN 0` (read, left at zero), `vN =x` (the result, named),
`vN value` (the result, or `Ca`, the complement of a number read in the
row). The formula: `[name =] vN'… = expression [= letters]`.

`docs/notation.md` says the same at more length.
