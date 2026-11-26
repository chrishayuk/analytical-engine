# python3 -I sources/checks/L023.py corpus/L023.bab.draft
#
# Run BAB/L/023's cards as a loop and print the trace, to compare with the
# sheet's 35 rows: Tab += Δ'; Comb = Tab; then Comb times: ×, +, Comb −= 1,
# Y backs to the formula cards while Comb ≠ 0; Z backs to the start.
G, S = "ABCD", "abcd"
rows = []
tab, gi, si = 0, 0, 0
for k in range(1, 5):
    rows.append(("+", f"{tab}+1", f"Tab {tab+1} Comb {tab+1}")); tab += 1; comb = tab
    # new coefficient: great letter back to A, small letter on to the k-th
    moves = f"Great back {gi} Small back {k-1-si}" if k > 1 else ""
    gi, si = 0, k - 1
    s = ""
    for j in range(k):
        if j > 0:
            gi += 1; si -= 1; moves = "Great advance 1 Small advance 1"
        p = G[gi] + S[si]
        rows.append(("×", p, moves)); moves = ""
        s = f"({s})+{p}" if s else f"0+{p}"
        rows.append(("+", s, ""))
        rows.append(("−", f"{comb}-1", f"Comb {comb-1}" + (" Y back" if comb > 1 else " Z back")))
        comb -= 1
rows.append(("+", f"{tab}+1", f"Tab {tab+1} Comb {tab+1}"))
for i, r in enumerate(rows, 1):
    print(i, *r)
n = 100
ops = sum(1 + 3 * k for k in range(1, n + 1)); terms = n * (n + 1) // 2
print("100 coefficients:", ops, "operations,", terms, "products;", 3 * terms / 60, "hours at a minute for each ×, + and −")

# Against the transcription: each row's operation and mill entry.
import re
import sys

if len(sys.argv) > 1:
    sheet = []
    for line in open(sys.argv[1], encoding="utf-8"):
        m = re.match(r"^Op\s+(\d+)\s+(\S)\s*\|\s*([^|]*?)\s*\|", line)
        if m:
            sheet.append((int(m.group(1)), m.group(2), m.group(3)))
    # Sums are compared without their brackets: the sheet writes (0+Ac+Bb)+Ca
    # for ((0+Ac)+Bb)+Ca.
    def norm(t):
        return t.replace("−", "-").replace(" ", "").replace("(", "").replace(")", "")
    agree = 0
    for (n, op, mill), (rop, rmill, _) in zip(sheet, rows):
        if op.replace("−", "-") == rop.replace("−", "-") and norm(mill) == norm(rmill):
            agree += 1
        else:
            print(f"row {n}: sheet {op} {mill}, the cards {rop} {norm(rmill)}")
    print(f"{len(sheet)} rows of the sheet, {len(rows)} of the cards: {agree} agree")
