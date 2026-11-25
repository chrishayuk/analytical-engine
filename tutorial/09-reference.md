# 9. Reference

## Commands

```console
$ babbage --help
babbage FILE                 run a page: every operation, every cell of the sheet checked (- reads standard input)
babbage no L001-1            a page of the corpus (babbage list)
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

9 pages; 620 statements of the sheets checked, 615 agree.
3 page(s) with statements that do not agree.
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

13. Great operations are multiplication and division; small are addition, subtraction and transfers.
   BAB/L/001 No. 2: "great 7 small 6" with 5 multiplications, 2 divisions, 3 subtractions and 3 transfers.

14. Values are compared as algebra.
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
