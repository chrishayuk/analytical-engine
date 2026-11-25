# 5. Complements and transfers

No. 1 finds only x, and it can use up a, b and c, which it does. No. 2 needs
a, b and c again, to find y from x, so it has to keep them. On the back of
the sheet Babbage writes:

> C, C or C before any number signifies the Complement of that number as Ca
> means complement of a

and in No. 2's first row, under v8, he writes `Ca`. While a is taken from v1
to the mill, its complement is laid in v8. At operation 8, a row with no
operation, v8 is left at zero and v1 receives a again: complementing twice
gives the number back.

`babbage` takes these as rules: a number read may at the same time be laid
in another column as its complement; and a row with no operation is a
transfer from one column to another, which complements.

```bab
Sheet tutorial
No. 7
Letters a b
Store v1 = a, v2 = b
Working v3 v4
Op 1  ×  | ab |  v1 0, v2 0, v3 ab, v4 Ca | v3 = v1·v2
Op 2     |    |  v1 a, v4 0              | v1' = v1 = a
```

```
tutorial  No. 7
Store  v1 = a, v2 = b   working v3 v4

  1   ×  v3 = v1·v2    table of a made; v1 v2 → 0; v3 = ab; v4 = Ca  ✓ 5
  2      v1′ = v1 = a  v4 → 0; v1 = a                                ✓ 4

Operations: great 1, small 1, total 2. Tables of multiples made: 1.

9 statements of the sheet checked: 9 agree, 0 do not.
```

A transfer is a "small" operation, as Babbage counts. The complement laid
must be of a number the row reads. Here c is still in v3, untouched, so its
complement cannot be laid:

```bab
Sheet tutorial
No. 8
Letters a b c
Store v1 = a, v2 = b, v3 = c
Working v4 v5
Op 1  ×  | ab |  v1 0, v2 0, v4 ab, v5 Cc | v4 = v1·v2
```

```
tutorial  No. 8
Store  v1 = a, v2 = b, v3 = c   working v4 v5

  1   ×  v4 = v1·v2  table of a made; v1 v2 → 0; v4 = ab; v5 = Cc  ✗ 1 of 5
        ✗ v5 = Cc: no column this row leaves at zero holds c

Operations: great 1, small 0, total 1. Tables of multiples made: 1.

5 statements of the sheet checked: 4 agree, 1 do not.
```

`Cb` would have been allowed: b is read in that row too.

What the complement is, digit by digit, the sheet does not say; Rojas (2023)
explains it by the wheels of the receiving column turning the other way.
`babbage` needs only that two complements make the number.

No. 2 keeps a, c and b this way, in v8, v5 and v9:

```console
$ babbage cards L001-2
BAB/L/001  No. 2, 5 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0 & a'x + b'y + c' = 0 which is equivalent to calculating x & y from the equations x = (bc'-b'c)/(b'a-ba') & y = (a'c-ac')/(b'a-ba')

     operation  to the mill                        to the store
  1  ×          v5, v1                             v7, C → v8
  2  ×          (table kept), v3                   v1, C → v5
  3  ×          v2, v4                             v3, C → v9
  4  ×          (table kept), v6                   v2
  5  −          v2, v1                             v6
  6  −          v7, v3                             v2
  7  ÷          v6, v2                             v4, v7
  8  (transfer)                                    v8 → v1
  9  (transfer)                                    v9 → v2
 10  (transfer)                                    v5 → v3
 11  ×          v1, v4                             v5
 12  −          v3, v5                             v1
 13  ÷          v1, v2                             v5
```
