# 6. What the sheet states

Besides its rows, a table states things about the whole calculation, and a
page writes them down to be checked.

```bab
Sheet tutorial
No. 9
Letters a b c a' b' c'
Unknowns x y
Equation a x + b y + c = 0
Equation a' x + b' y + c' = 0
Find x = (bc'-b'c)/(b'a-ba')
Store v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'
Working v7
Op 1     ×  | b'a                 | v1 0, v5 0, v7 b'a        | v7 = v5·v1
Op 2     ×  | b'c                 | v1 b'c, v3 0              | v1' = v5·v3
Op 3     ×  | ba'                 | v2 0, v3 ba', v4 0        | v3' = v2·v4
Op 4     ×  | bc'                 | v2 bc', v6 0              | v2' = v2·v6
Op 5     −  | bc'-b'c             | v1 0, v2 0, v4 bc'-b'c    | v4' = v2'-v1'
Op 6     −  | b'a-ba'             | v1 b'a-ba', v3 0, v7 0    | v1'' = v7-v3'
Op 7  *  ÷  | (bc'-b'c)/(b'a-ba') | v1 0, v3 =x, v4 0         | x = v3'' = v4'/v1''
Composition x = v4'/v1'' = (v2'-v1')/(v7-v3') = (bc'-b'c)/(b'a-ba')
States great 5, small 2, total 7, variables 6, working 1, occupied 7
Remark "a remark is kept, and printed, but not run"
Unrun "pencil in the margin, transcribed and not run"
```

```
tutorial  No. 9
Store  v1 = a, v2 = b, v3 = c, v4 = a', v5 = b', v6 = c'   working v7

  1   ×  v7 = v5·v1         table of b′ made; v1 v5 → 0; v7 = ab′    ✓ 4
  2   ×  v1′ = v5·v3        table of b′ standing; v3 → 0; v1 = b′c   ✓ 4
  3   ×  v3′ = v2·v4        table of b made; v2 v4 → 0; v3 = a′b     ✓ 4
  4   ×  v2′ = v2·v6        table of b standing; v6 → 0; v2 = bc′    ✓ 4
  5   −  v4′ = v2′-v1′      v1 v2 → 0; v4 = bc′ - b′c                ✓ 4
  6   −  v1″ = v7-v3′       v3 v7 → 0; v1 = ab′ - a′b                ✓ 4
  7 * ÷  x = v3″ = v4′/v1″  v1 v4 → 0; v3 = (bc′ - b′c)/(ab′ - a′b)  ✓ 5

✓ x = (bc′-b′c)/(b′a-ba′)
✓ x solves the equations
✓ composition: x = v4′/v1″
✓ composition: v4′/v1″ = (v2′-v1′)/(v7-v3′)
✓ composition: (v2′-v1′)/(v7-v3′) = (bc′-b′c)/(b′a-ba′)
✓ great = 5
✓ small = 2
✓ total = 7
✓ variables = 6
✓ working = 1
✓ occupied = 7

Operations: great 5, small 2, total 7. Tables of multiples made: 2.
x = (bc′ - b′c)/(ab′ - a′b)

40 statements of the sheet checked: 40 agree, 0 do not.

Remark (quoted, not run): "a remark is kept, and printed, but not run"
Also on the sheet (not run): pencil in the margin, transcribed and not run
```

- `Find x = …` is a result as the sheet states it. The cell `=x` (operation
  7) names the result; the run compares the two.
- `Equation` and `Unknowns` are the equations the sheet solves. The run
  solves them itself, as algebra, and checks that x is their solution.
- `Composition` is Babbage's working of a result back to the letters. Every
  member must be equal to the first.
- `States` are the counts at the foot of the table. Babbage's *great*
  operations are multiplication and division; *small* are addition,
  subtraction and transfers. `variables` are the store's columns at the
  start, `working` the others used, `occupied` all of them.
- `Remark` and `Unrun` are kept and printed, not run.

A count that is wrong:

```bab
Sheet tutorial
No. 10
Letters a b
Store v1 = a, v2 = b
Working v3
Op 1  ×  | ab | v1 0, v2 0, v3 ab | v3 = v1·v2
States great 1, small 1, total 2
```

```
tutorial  No. 10
Store  v1 = a, v2 = b   working v3

  1   ×  v3 = v1·v2  table of a made; v1 v2 → 0; v3 = ab  ✓ 4

✓ great = 1
✗ small = 1: the run counts 0
✗ total = 2: the run counts 1

Operations: great 1, small 0, total 1. Tables of multiples made: 1.

7 statements of the sheet checked: 5 agree, 2 do not.
```
