"""BAB/L/009 (22 Aug 1837): replay the 24 rows by the rule Babbage's own
right-hand column states for each ("1st Car = 1st Car(1) - v2", "3rd Car =
2nd Car(2)", ...), three-figure columns, arithmetical complement = 1000 - x,
and compare with every cell of the table as transcribed."""
M = 1000
# Transcription: carriages written (None = blank, 'z' = "-0") and store cells.
T = [
 # C1,   C2,    C3,   store cells
 ("994", None, None, {1:"0", 6:"994", 7:"994"}),
 ("988","994", None, {2:"0", 7:"988"}),
 ("z",  "z",  "994", {8:"994"}),
 ("999", None, "993", {3:"0", 8:"993"}),
 ("z",  "999", "z",  {9:"999"}),          # C2 999 struck through
 (None, "999", None, {4:"0", 9:"999"}),
 ("006","z",  None, {1:"006", 2:"006", 6:"0"}),
 ("018","012", None, {2:"018", 7:"0"}),
 ("z",  "z",  "012", {3:"012"}),
 ("007", None, "019", {3:"019", 8:"0"}),  # C2: a faint figure, erased
 ("z",  "007", "z",  {4:"007"}),
 (None, "008", None, {4:"008", 9:"0"}),
 ("994","z",  None, {1:"0", 6:"994", 7:"994"}),
 ("976","982", None, {2:"0", 7:"976"}),
 ("z",  "z",  "982", {8:"982"}),
 ("981", None, "963", {3:"0", 8:"963"}),
 ("z",  "981", "z",  {9:"981"}),
 (None, "973", None, {4:"0", 9:"973"}),
 ("006","z",  None, {1:"006", 2:"006", 6:"0"}),
 ("030","024", None, {2:"030", 7:"0"}),
 ("z",  "z",  "024", {3:"024"}),
 ("037", None, "061", {3:"061", 8:"0"}),
 ("z",  "037", "z",  {4:"037"}),
 (None, "064", None, {4:"064", 9:"0"}),
]
v = {1:6, 2:6, 3:1, 4:0, 6:0, 7:0, 8:0, 9:0}
C = {1:0, 2:0, 3:0}
ok = bad = 0
out = []
def take(j):
    x = v[j]; v[j] = 0; return x
for r, (c1, c2, c3, cells) in enumerate(T, 1):
    k = (r - 1) % 6           # place in the cycle of six
    src = 0 if ((r - 1) // 6) % 2 == 0 else 5   # odd n: read v1-4, write v6-9; even: the reverse
    dst = 5 if src == 0 else -5
    a, b, c, d = 1 + src, 2 + src, 3 + src, 4 + src
    if k == 0:   # 1st Car = v6 = v7 = ar co v1; the sheet writes -0 for the 2nd Car
        C[2] = 0; C[1] = (C[1] - take(a)) % M; v[a+dst] = C[1]; v[b+dst] = C[1]
    elif k == 1: # 1st Car = v7 = 1st Car(1) - v2;  2nd Car = ar co v2
        x = take(b); C[1] = (C[1] - x) % M; v[b+dst] = C[1]; C[2] = (C[2] - x) % M
    elif k == 2: # 3rd Car = 2nd Car(2) = v8; 1st Car = 2nd Car = 0
        C[3] = C[2]; v[c+dst] = C[3]; C[1] = C[2] = 0
    elif k == 3: # 1st Car = 1st Car(3) - v3; 3rd Car = v8 = 3rd Car(3) - v3
        x = take(c); C[1] = (C[1] - x) % M; C[3] = (C[3] - x) % M; v[c+dst] = C[3]
    elif k == 4: # 1st Car = 3rd Car = 0; 2nd Car = v9 = 1st Car(4)
        C[2] = C[1]; v[d+dst] = C[2]; C[1] = C[3] = 0
    elif k == 5: # 2nd Car = v9 = 2nd Car(5) - v4
        C[2] = (C[2] - take(d)) % M; v[d+dst] = C[2]
    # compare
    for name, want in (("1st Carr", c1), ("2nd Carr", c2), ("3rd Carr", c3)):
        if want is None: continue
        got = C[int(name[0])]
        w = 0 if want == "z" else int(want)
        if got == w: ok += 1
        else: bad += 1; out.append(f"row {r} {name}: sheet {want}, run {got:03d}")
    for j, want in cells.items():
        got = v[j]
        if got == int(want): ok += 1
        else: bad += 1; out.append(f"row {r} v{j}: sheet {want}, run {got:03d}")
    if k == 5:
        n = (r + 5) // 6
        t = v[4] if src == 5 else (M - v[9]) % M
        out.append(f"after row {r}: T{n} = {t} ({'in v4' if src == 5 else 'as its complement in v9'}); n^3 = {n**3}")
print("\n".join(out)); print(f"{ok + bad} cells checked: {ok} agree, {bad} do not")
