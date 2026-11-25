# 1. Babbage's sheets, and a first run

Charles Babbage designed the Analytical Engine from 1834 and never finished
it. What survives is drawings, and notes. Among the notes, in the Babbage
Papers at the Science Museum, is a series of tables Babbage called
*Notations of Calculation*: series BAB/L, "27 sets of notations consisting
of 36 sheets", 1836 to 1840. Each table is a calculation written out for the
engine one operation to a row: what the operation was, which numbers of the
store it took, what it made, and where the result went.

The first sheet of the series, BAB/L/001, has a cover dated "4 Aug 1837"
listing two programs. No. 1 eliminates x between two equations of the first
degree,

    ax + by + c = 0
    a′x + b′y + c′ = 0

and so computes x = (bc′ − b′c)/(b′a − ba′). No. 2, dated "Aug. 5", finds
both x and y.

## The store and the mill

The engine has two parts. The **store** holds numbers, each in a column of
figure wheels; Babbage calls a column a *variable* and writes them v1, v2,
v3, …. The **mill** does arithmetic. An operation brings numbers from the
store to the mill, works on them, and sends the result back to a column of
the store.

Babbage's table has a row for each operation. Across the top are the store's
columns, and under each, in the row of an operation, what that column now
holds. To the right is the operation written as a formula in the variables:
`v7 = v5·v1` is "multiply v5 by v1 and put the result in v7".

## A first run

`babbage` reads a transcription of one table (a *page*, a `.bab` file),
does each operation in turn, and checks every number the table writes
against what the operation gives. The pages of the archive are compiled into
the program; `babbage no` runs one.

```console
$ babbage no L001-1
BAB/L/001  No. 1, 4 Aug 1837
Elimination between two equations of the first degree ax + by + c = 0  a'x + b'y + c' = 0 which is equivalent to calculating the value of x from the eqn x = (bc'-b'c)/(b'a-ba')
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
x = (bc′ - b′c)/(ab′ - a′b)

42 statements of the sheet checked: 42 agree, 0 do not.

Remark (quoted, not run): "It at first appeared that variables v7 and v3' might have been saved by making b'a-ba' at the fourth operation but this would have caused the table of b' made in the third operation to be destroyed and it must have been recomputed in the operation for b'c thus causing the loss of about ten turns of the hand."
```

Each row of the run is one row of the sheet: its number, the star Babbage
puts against a division, the operation, the formula as he writes it, and
then what the run did: the columns it read, which are left at zero (`→ 0`),
and what it wrote. The mark at the end says how many statements of that row
it checked and whether they agree.

The values are written in Babbage's letters, as algebra: `ab′` is a times
b′. `babbage` never puts numbers in for the letters to compare two values;
it compares them as rational functions of the letters, so a check that
passes holds for every value of a, b, c, a′, b′, c′.

After the rows come the statements about the whole table: the value of x
the sheet states, that it does solve the equations, every step of the
sheet's "Composition" of x, and the counts Babbage writes at the foot of the
table.

The next chapter writes a page of its own.
