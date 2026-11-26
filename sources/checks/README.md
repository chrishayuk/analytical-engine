# Checks of the carriage sheets, outside the engine

BAB/L/008, L/009 and L/010 (20 to 23 August 1837) tabulate n² + 2n + 3, n³
and n⁴ by differences in the store: three-figure columns, complements as
numbers (994 for 6), and three "carriages" that accumulate, are cleared
("−0") and pass their figures to the columns. There is no mill. The engine
does not yet model this, so each sheet is checked here by a short script
that replays every row by the rule Babbage's right-hand column states for
it (where the column is written; by the same rule on the later rows where
it is not), and compares every figure the table writes.

    python3 -I sources/checks/L008.py   # 60 of 60 cells agree
    python3 -I sources/checks/L009.py   # 95 of 95
    python3 -I sources/checks/L010.py   # 121 of 124: row 28 v3 "320" for 302; row 30 Car2 and v4 "469" for 369

The transcriptions are in `corpus/L008.bab.draft`, `corpus/L010.bab.draft`
and in `../notes/L009.md`; each script carries its own copy of the table.
BAB/L/012 (29 August) uses the same carriages beside the mill and is
transcribed in `corpus/L012.bab.draft`, not yet checked. These scripts are
to be replaced by the engine's own model of the carriages.
