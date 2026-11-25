# 2. A page: the store, the mill, and zero

A page starts by saying what is in the store, and which columns are working
columns, used for results along the way:

```bab
Sheet tutorial
No. 1
Letters a b c
Store v1 = a, v2 = b, v3 = c
Working v4
Op 1  ×  | ab   | v1 0, v2 0, v4 ab   | v4 = v1·v2
Op 2  −  | ab-c | v3 0, v4 0, v1 ab-c | v1' = v4-v3
```

```
tutorial  No. 1
Store  v1 = a, v2 = b, v3 = c   working v4

  1   ×  v4 = v1·v2   table of a made; v1 v2 → 0; v4 = ab  ✓ 4
  2   −  v1′ = v4-v3  v3 v4 → 0; v1 = ab - c               ✓ 4

Operations: great 1, small 1, total 2. Tables of multiples made: 1.

8 statements of the sheet checked: 8 agree, 0 do not.
```

`Letters` are the letters the values are made of. `Store` gives each column's
number at the start. Each `Op` line is one row of the table, in four fields
separated by `|`:

1. the number of the operation and the operation: `×`, `÷`, `+`, `−`;
2. what Babbage writes in the "variables in Mill" column: the value made;
3. the store cells the row writes, `vN value`;
4. the right-hand column: the variable written, `=`, and the formula.

## Zero

In the store cells, `0` means the column is left at zero. On Babbage's sheet
a column the operation takes a number from is written 0 in that row: taking
a number to the mill empties the column. `babbage` takes this as the first
rule of the engine (`babbage decisions` lists them all): **reading a column
leaves it at zero**. So an operand must come from a column the row leaves at
zero.

Operation 2 takes ab from v4 and c from v3, so both are written 0, and puts
ab − c in v1, which operation 1 emptied. (The accent on `v1'` is the subject
of chapter 4.) On BAB/L/001 a result never goes into a column the same
operation reads: the column is being emptied as the number goes to the
mill.

If the row does not leave the column at zero, the number was not taken:

```bab
Sheet tutorial
No. 2
Letters a b
Store v1 = a, v2 = b
Working v3
Op 1  ×  | ab | v1 0, v3 ab | v3 = v1·v2
```

```
tutorial  No. 2
Store  v1 = a, v2 = b   working v3

  1   ×  v3 = v1·v2  table of a made; v1 → 0; v3 = ab  ✗ 1 of 5
        ✗ where v2 comes from: v2 (b) is not in a column this row leaves at zero

Operations: great 1, small 0, total 1. Tables of multiples made: 1.

5 statements of the sheet checked: 4 agree, 1 do not.
```

and if a cell says something the operation does not give, that is caught
too:

```bab
Sheet tutorial
No. 3
Letters a b
Store v1 = a, v2 = b
Working v3
Op 1  ×  | ab | v1 0, v2 0, v3 ba+1 | v3 = v1·v2
```

```
tutorial  No. 3
Store  v1 = a, v2 = b   working v3

  1   ×  v3 = v1·v2  table of a made; v1 v2 → 0; v3 = 1 + ab  ✗ 1 of 4
        ✗ v3 = ba+1: the operation of the row gives ab

Operations: great 1, small 0, total 1. Tables of multiples made: 1.

4 statements of the sheet checked: 3 agree, 1 do not.
```

`ba` would have been right: `b′a` and `ab′` are the same value, since values
are compared as algebra, not as text.
