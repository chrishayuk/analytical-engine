# 7. Operation 12

Here is No. 2 in full.

```console
$ babbage no L001-2
BAB/L/001  No. 2, 5 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0 & a'x + b'y + c' = 0 which is equivalent to calculating x & y from the equations x = (bc'-b'c)/(b'a-ba') & y = (a'c-ac')/(b'a-ba')
Store  v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'   working v7 v8 v9

  1   ×  v7 = v5·v1         table of b′ made; v1 v5 → 0; v7 = ab′; v8 = Ca                         ✓ 5
  2   ×  v1′ = v5·v3        table of b′ standing; v3 → 0; v1 = b′c; v5 = Cc                        ✓ 5
  3   ×  v3′ = v2·v4        table of b made; v2 v4 → 0; v3 = a′b; v9 = Cb                          ✓ 5
  4   ×  v2′ = v2·v6        table of b standing; v6 → 0; v2 = bc′                                  ✓ 4
  5   −  v6′ = v2′-v1′      v1 v2 → 0; v6 = bc′ - b′c                                              ✓ 4
  6   −  v2″ = v7-v3′       v3 v7 → 0; v2 = ab′ - a′b                                              ✓ 4
  7 * ÷  x = v4′ = v6′/v2″  v2 v6 → 0; v4 = (bc′ - b′c)/(ab′ - a′b); v7 = (bc′ - b′c)/(ab′ - a′b)  ✓ 6
  8      v1″ = v1 = a       v8 → 0; v1 = a                                                         ✓ 4
  9      v2‴ = v2 = b       v9 → 0; v2 = b                                                         ✓ 4
 10      v3″ = v3 = c       v5 → 0; v3 = c                                                         ✓ 4
 11   ×  v5″ = v1″·v4′      table of a made; v1 v4 → 0; v5 = (abc′ - ab′c)/(ab′ - a′b)             ✓ 4
 12   −  v1‴ = -v3″-v5″     v3 v5 → 0; v1 = (-abc′ + a′bc)/(ab′ - a′b)                             ✗ 1 of 4
        ✗ − on v3 (c) and v5 ((abc′ - ab′c)/(ab′ - a′b)) gives -v3″-v5″: the operation gives v3″ − v5″, but the sheet writes -v3″-v5″: neither order of the two operands gives that. The run goes on with the value on the sheet
 13 * ÷  y = v5‴ = v1‴/v2‴  v1 v2 → 0; v5 = (-abc′ + a′bc)/(abb′ - a′b^2)                          ✓ 5

✓ x = (bc′-b′c)/(b′a-ba′)
✓ y = (a′c-ac′)/(b′a-ba′)
✓ x solves the equations
✓ y solves the equations
✓ composition: x = v4′
✓ composition: v4′ = v6′/v2″
✓ composition: v6′/v2″ = (v2′-v1′)/(v7-v3′)
✓ composition: (v2′-v1′)/(v7-v3′) = (v2·v6-v5·v3)/(v5·v1-v2·v4)
✓ composition: (v2·v6-v5·v3)/(v5·v1-v2·v4) = (bc′-b′c)/(b′a-ba′)
✓ composition: y = v5‴
✓ composition: v5‴ = v1‴/v2‴
✓ composition: v1‴/v2‴ = (-v3″-v5″)/b
✓ composition: (-v3″-v5″)/b = (-c-v1″·v4′)/b
✓ composition: (-c-v1″·v4′)/b = (-c-ax)/b
✓ composition: (-c-ax)/b = (-c-a(bc′-b′c)/(b′a-ba′))/b
✓ composition: (-c-a(bc′-b′c)/(b′a-ba′))/b = (-cb′a+cba′-c′ba+cb′a)/(b(b′a-ba′))
✓ composition: (-cb′a+cba′-c′ba+cb′a)/(b(b′a-ba′)) = (a′c-ac′)/(b′a-ba′)
✓ great = 7
✓ small = 6
✓ total = 13
✓ variables = 6
✓ working = 3
✓ occupied = 9

Operations: great 7, small 6, total 13. Tables of multiples made: 3.
x = (bc′ - b′c)/(ab′ - a′b)
y = (-abc′ + a′bc)/(abb′ - a′b^2)

81 statements of the sheet checked: 80 agree, 1 do not.

Also on the sheet (not run): pencil, right of the counts: '6 Mult = 18 / 1 Div = 5 / 6 add = 1', ruled off, '24'; a word above the column of figures, perhaps 'Mov'
Also on the sheet (not run): pencil, beside the right-hand column: the value of each operation in letters (= b'a, = b'c, ...)
Also on the sheet (not run): pencil, faint, centre: 'ε^(a + bx + cx² + ...) = A + Bx + Cx² + ...'
Also on the sheet (not run): pencil, foot of the sheet: '085', '075 035', '6 66', 'a fa fa·a' (unclear)
```

Of its 81 statements, one does not agree. Operation 12 is marked `−`. Its
mill column says `−c − ax`, and its formula is `v1‴ = −v3″ − v5″`: it takes
c from v3 and ax from v5. A subtraction of those two numbers gives c − ax
or ax − c. Neither is −c − ax.

For the row to be right, the mill must take both numbers negatively. No other
row of the sheet asks that of it, and the sheet does not say how. `babbage`
does not decide it: it reports the row, and goes on with the value the sheet
writes, so that the rest of the table is still checked. Every cell after it,
both compositions and the y it leads to agree.

It is the y of the first equation, ax + by + c = 0, that Babbage wants:
by = −c − ax. The formula is right as algebra. What is open is how the
engine of August 1837 would make it in one operation.
