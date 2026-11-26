# BAB/L/008 (image 222/659): run the 16 turns as the sheet's own numbered
# instructions describe them, on three-figure wheels (mod 1000), and compare
# every cell the table writes. Carriages C1..C3; "-0" is negative zero, held as 0.
M = 1000
sheet = {  # turn: {cell: value as written}
 1: {"C1": 998, "v1": 0, "v6": 998, "v7": 998},
 2: {"C1": 995, "C2": 997, "v2": 0, "v7": 995},
 3: {"C1": 0, "C2": 0, "C3": 997, "v8": 997},
 4: {"C3": 994, "v3": 0, "v8": 994},
 5: {"C1": 2, "v1": 2, "v2": 2, "v6": 0},
 6: {"C1": 7, "C2": 5, "v2": 7, "v7": 0},
 7: {"C1": 0, "C2": 0, "C3": 5, "v3": 5},
 8: {"C3": 11, "v3": 11, "v8": 0},
 9: {"C1": 998, "v1": 0, "v6": 998, "v7": 998},
10: {"C1": 991, "C2": 993, "v2": 0, "v7": 991},
11: {"C1": 0, "C2": 0, "C3": 993, "v8": 993},
12: {"C3": 982, "v3": 0, "v8": 982},
13: {"C1": 2, "v1": 2, "v2": 2, "v6": 0},
14: {"C1": 11, "C2": 9, "v2": 11, "v7": 0},
15: {"C1": 0, "C2": 0, "C3": 9, "v3": 9},
16: {"C3": 27, "v3": 27, "v8": 0},
}
s = {"v1": 2, "v2": 3, "v3": 3, "v6": 0, "v7": 0, "v8": 0, "C1": 0, "C2": 0, "C3": 0}
def turn(k, s):
    s = dict(s)
    # rounds alternate: plain numbers in v1-v3 -> complements in v6-v8, and back
    a, b, c = ("v1", "v2", "v3") if k % 8 in (1, 2, 3, 4) else ("v6", "v7", "v8")
    A, B, Cc = ("v6", "v7", "v8") if a == "v1" else ("v1", "v2", "v3")
    step = (k - 1) % 4
    if step == 0:   # subtract Δ² from C1 (at zero), reducing it to zero; put the result on the two others
        s["C1"] = (s["C1"] - s[a]) % M; s[a] = 0; s[A] = s["C1"]; s[B] = s["C1"]
    elif step == 1: # subtract Δ from C1 and from B; and from C2 (at zero), reducing Δ to zero
        d = s[b]; s["C1"] = (s["C1"] - d) % M; s[B] = (s[B] - d) % M; s["C2"] = (s["C2"] - d) % M; s[b] = 0
    elif step == 2: # C1, C2 to zero; C2's number to C3 and to the third column
        s["C3"] = s["C2"]; s[Cc] = s["C2"]; s["C1"] = 0; s["C2"] = 0
    else:           # subtract T from C3 and from the third column, reducing T to zero
        t = s[c]; s["C3"] = (s["C3"] - t) % M; s[Cc] = (s[Cc] - t) % M; s[c] = 0
    return s
ok = bad = 0
for k in range(1, 17):
    s = turn(k, s)
    for cell, v in sheet[k].items():
        if s[cell] == v: ok += 1
        else: bad += 1; print(f"turn {k}: {cell} sheet {v:03d}, run {s[cell]:03d}")
T = lambda n: n * n + 2 * n + 3
print(f"{ok} cells agree, {bad} do not")
print("T1..T4 =", [T(n) for n in range(1, 5)], "; the run: C3 after 4, 8, 12, 16 =", "994 (=1000-6), 011, 982 (=1000-18), 027")
