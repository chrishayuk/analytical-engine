# 8. Numbers

Everything so far has been algebra. `--at` shows the same run with numbers
put in for the letters. The checks are not changed: they are still made as
algebra. Only what is shown is different.

The equations 2x + 3y − 8 = 0 and 5x − y − 3 = 0 are a = 2, b = 3, c = −8,
a′ = 5, b′ = −1, c′ = −3:

```console
$ babbage no L001-2 --at a=2,b=3,c=-8,a'=5,b'=-1,c'=-3
BAB/L/001  No. 2, 5 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0 & a'x + b'y + c' = 0 which is equivalent to calculating x & y from the equations x = (bc'-b'c)/(b'a-ba') & y = (a'c-ac')/(b'a-ba')
Store  v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'   working v7 v8 v9

  1   ×  v7 = v5·v1         table of -1 made; v1 v5 → 0; v7 = -2; v8 = C2   ✓ 5
  2   ×  v1′ = v5·v3        table of -1 standing; v3 → 0; v1 = 8; v5 = C-8  ✓ 5
  3   ×  v3′ = v2·v4        table of 3 made; v2 v4 → 0; v3 = 15; v9 = C3    ✓ 5
  4   ×  v2′ = v2·v6        table of 3 standing; v6 → 0; v2 = -9            ✓ 4
  5   −  v6′ = v2′-v1′      v1 v2 → 0; v6 = -17                             ✓ 4
  6   −  v2″ = v7-v3′       v3 v7 → 0; v2 = -17                             ✓ 4
  7 * ÷  x = v4′ = v6′/v2″  v2 v6 → 0; v4 = 1; v7 = 1                       ✓ 6
  8      v1″ = v1 = a       v8 → 0; v1 = 2                                  ✓ 4
  9      v2‴ = v2 = b       v9 → 0; v2 = 3                                  ✓ 4
 10      v3″ = v3 = c       v5 → 0; v3 = -8                                 ✓ 4
 11   ×  v5″ = v1″·v4′      table of 2 made; v1 v4 → 0; v5 = 2              ✓ 4
 12   −  v1‴ = -v3″-v5″     v3 v5 → 0; v1 = 6                               ✗ 1 of 4
        ✗ − on v3 (c) and v5 ((abc′ - ab′c)/(ab′ - a′b)) gives -v3″-v5″: the operation gives v3″ − v5″, but the sheet writes -v3″-v5″: neither order of the two operands gives that. The run goes on with the value on the sheet
 13 * ÷  y = v5‴ = v1‴/v2‴  v1 v2 → 0; v5 = 2                               ✓ 5

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
x = 1
y = 2

81 statements of the sheet checked: 80 agree, 1 do not.

Also on the sheet (not run): pencil, right of the counts: '6 Mult = 18 / 1 Div = 5 / 6 add = 1', ruled off, '24'; a word above the column of figures, perhaps 'Mov'
Also on the sheet (not run): pencil, beside the right-hand column: the value of each operation in letters (= b'a, = b'c, ...)
Also on the sheet (not run): pencil, faint, centre: 'ε^(a + bx + cx² + ...) = A + Bx + Cx² + ...'
Also on the sheet (not run): pencil, foot of the sheet: '085', '075 035', '6 66', 'a fa fa·a' (unclear)
```

x = 1 and y = 2. The complements are shown as `C` before the number they are
of: `C2` in v8 after operation 1 is the complement of a = 2, not a number of
its own.

`--store` shows the whole store after each operation:

```console
$ babbage no L001-1 --store --at a=2,b=3,c=-8,a'=5,b'=-1,c'=-3
BAB/L/001  No. 1, 4 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0  a'x + b'y + c' = 0 which is equivalent to calculating the value of x from the eqn x = (bc'-b'c)/(b'a-ba')
Store  v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'   working v7

  1   ×  v7 = v5·v1         table of -1 made; v1 v5 → 0; v7 = -2  ✓ 4
        store: v2 3, v3 -8, v4 5, v6 -3, v7 -2
  2   ×  v1′ = v5·v3        table of -1 standing; v3 → 0; v1 = 8  ✓ 4
        store: v1 8, v2 3, v4 5, v6 -3, v7 -2
  3   ×  v3′ = v2·v4        table of 3 made; v2 v4 → 0; v3 = 15   ✓ 4
        store: v1 8, v3 15, v6 -3, v7 -2
  4   ×  v2′ = v2·v6        table of 3 standing; v6 → 0; v2 = -9  ✓ 4
        store: v1 8, v2 -9, v3 15, v7 -2
  5   −  v4′ = v2′-v1′      v1 v2 → 0; v4 = -17                   ✓ 4
        store: v3 15, v4 -17, v7 -2
  6   −  v1″ = v7-v3′       v3 v7 → 0; v1 = -17                   ✓ 4
        store: v1 -17, v4 -17
  7 * ÷  x = v3″ = v4′/v1″  v1 v4 → 0; v3 = 1                     ✓ 5
        store: v3 1

✓ x = (bc′-b′c)/(b′a-ba′)
✓ x solves the equations
✓ composition: x = v3″
✓ composition: v3″ = v4′/v1″
✓ composition: v4′/v1″ = (v2′-v1′)/(v7-v3′)
✓ composition: (v2′-v1′)/(v7-v3′) = (v2·v6-v5·v3)/(v5·v1-v2·v4)
✓ composition: (v2·v6-v5·v3)/(v5·v1-v2·v4) = (bc′-b′c)/(b′a-ba′)
✓ great = 5
✓ small = 2
✓ total = 7
✓ variables = 6
✓ working = 1
✓ occupied = 7

Operations: great 5, small 2, total 7. Tables of multiples made: 2.
x = 1

42 statements of the sheet checked: 42 agree, 0 do not.

Remark (quoted, not run): "It at first appeared that variables v7 and v3' might have been saved by making b'a-ba' at the fourth operation but this would have caused the table of b' made in the third operation to be destroyed and it must have been recomputed in the operation for b'c thus causing the loss of about ten turns of the hand."
```
