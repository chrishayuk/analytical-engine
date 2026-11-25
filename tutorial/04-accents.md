# 4. Accents

Babbage puts accents on his variables. In No. 1, operation 2 is written
`v1′ = v5·v3`, and operation 6 `v1″ = v7 − v3′`. An accent counts the
numbers the column has been given: v1 starts with a; v₁′ is the first new
number it is given (b′c), v₁″ the second (b′a − ba′). Leaving a column at
zero does not count. A working column's first number has no accent: v7, not
v₇′.

`babbage` keeps every number each column has held, and checks every accent:
on the variable written, it must be the count; on a variable in a formula,
it names that number, and the run looks it up.

```bab
Sheet tutorial
No. 6
Letters a b c d
Store v1 = a, v2 = b, v3 = c, v5 = d
Working v4
Op 1  ×  | ab     | v1 0, v2 0, v4 ab     | v4 = v1·v2
Op 2  −  | ab-c   | v3 0, v4 0, v1 ab-c   | v1' = v4-v3
Op 3  −  | ab-c-d | v1 0, v5 0, v2 ab-c-d | v2 = v1'-v5
```

```
tutorial  No. 6
Store  v1 = a, v2 = b, v3 = c, v5 = d   working v4

  1   ×  v4 = v1·v2   table of a made; v1 v2 → 0; v4 = ab  ✓ 4
  2   −  v1′ = v4-v3  v3 v4 → 0; v1 = ab - c               ✓ 4
  3   −  v2 = v1′-v5  v1 v5 → 0; v2 = ab - c - d           ✗ 1 of 4
        ✗ v2 written: v2 has now changed once, so it is v2′

Operations: great 1, small 2, total 3. Tables of multiples made: 1.

12 statements of the sheet checked: 11 agree, 1 do not.
```

Operation 3 is written wrong. v2 started with b and has now been given
ab − c − d, its first new number, so it is v₂′, not v2. The formula's `v1'`
is right: v1's first new number, ab − c.

## Numbers, not columns

An accented name means a number, wherever that number now is. In No. 2,
operation 8 is written `v1″ = v1 = a`: v1 receives a back. The a it had at
the start was taken away at operation 1, and comes back from another column
(chapter 5). Babbage still writes it `v1`, with no accent: the first number
v1 held. `babbage` reads every name that way.

Over both tables of BAB/L/001 the formulas and compositions name variables
with accents 53 times, and every one names the number the run finds.

In an editor with the language server (`babbage lsp`), hovering over a
variable such as `v3''` shows the number it names.
