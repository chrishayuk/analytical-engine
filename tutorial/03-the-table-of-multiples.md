# 3. The table of multiples

Look again at the first two rows of No. 1:

```console
$ babbage cards L001-1
BAB/L/001  No. 1, 4 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0  a'x + b'y + c' = 0 which is equivalent to calculating the value of x from the eqn x = (bc'-b'c)/(b'a-ba')

     operation  to the mill                        to the store
  1  ×          v5, v1                             v7
  2  ×          (table kept), v3                   v1
  3  ×          v2, v4                             v3
  4  ×          (table kept), v6                   v2
  5  −          v2, v1                             v4
  6  −          v7, v3                             v1
  7  ÷          v4, v1                             v3
```

`babbage cards` writes the program as the cards the engine would need: an
operation card, and which columns go to the mill and which receive the
result. Operation 1 takes v5 and v1, b′ and a. Operation 2 multiplies b′ by
c, but it takes only v3: v5 was left at zero by operation 1.

So where does b′ come from? Babbage says, in a remark under the table:

> It at first appeared that variables v7 and v3′ might have been saved by
> making b′a − ba′ at the fourth operation but this would have caused the
> table of b′ made in the third operation to be destroyed and it must have
> been recomputed in the operation for b′c thus causing the loss of about
> ten turns of the hand.

The mill multiplies by making a **table** of the multiplicand's multiples,
and the table stays in the mill. A second multiplication by the same number
straight after the first uses the table already standing; it needs only the
multiplier from the store. Another operation in between destroys it.
`babbage` takes both halves as a rule, and takes the multiplicand to be the
first factor written: `v5·v3` is a multiplication by the table of b′.

Here is the rule working:

```bab
Sheet tutorial
No. 4
Letters a b d
Store v1 = a, v2 = b, v4 = d
Working v5 v7
Op 1  ×  | ab   | v1 0, v2 0, v5 ab   | v5 = v1·v2
Op 2  ×  | ad   | v4 0, v7 ad         | v7 = v1·v4
```

```
tutorial  No. 4
Store  v1 = a, v2 = b, v4 = d   working v5 v7

  1   ×  v5 = v1·v2  table of a made; v1 v2 → 0; v5 = ab   ✓ 4
  2   ×  v7 = v1·v4  table of a standing; v4 → 0; v7 = ad  ✓ 4

Operations: great 2, small 0, total 2. Tables of multiples made: 1.

8 statements of the sheet checked: 8 agree, 0 do not.
```

Operation 2 says "table of a standing". Put a subtraction between the two
multiplications, and the table is gone; a is nowhere to hand:

```bab
Sheet tutorial
No. 5
Letters a b c d
Store v1 = a, v2 = b, v3 = c, v4 = d
Working v5 v6 v7
Op 1  ×  | ab   | v1 0, v2 0, v5 ab   | v5 = v1·v2
Op 2  −  | ab-c | v3 0, v5 0, v6 ab-c | v6 = v5-v3
Op 3  ×  | ad   | v4 0, v7 ad         | v7 = v1·v4
```

```
tutorial  No. 5
Store  v1 = a, v2 = b, v3 = c, v4 = d   working v5 v6 v7

  1   ×  v5 = v1·v2  table of a made; v1 v2 → 0; v5 = ab  ✓ 4
  2   −  v6 = v5-v3  v3 v5 → 0; v6 = ab - c               ✓ 4
  3   ×  v7 = v1·v4  table of a made; v4 → 0; v7 = ad     ✗ 1 of 5
        ✗ where v1 comes from: v1 (a) is not in a column this row leaves at zero, nor the table standing in the mill

Operations: great 2, small 1, total 3. Tables of multiples made: 2.

13 statements of the sheet checked: 12 agree, 1 do not.
```

The run counts the tables it makes. No. 1 makes two, of b′ and of b; the
products are ordered so that each table serves two multiplications. The
"ten turns of the hand" are quoted, not checked: nothing on the sheet says
what a turn is.
