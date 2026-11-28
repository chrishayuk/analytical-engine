"""A provisional controller for multiplication without table: the multiplier
sets the sequence of bands, the bands set the bolting, the bolting sets the
gearing, the gearing turns the figure wheels.

A COMPUTATIONAL HYPOTHESIS, NOT A RECONSTRUCTION, and not a claim about
which part of the engine did the counting. Rules: docs/f-control-rules.md.

  multiplier figure  -> counter K        (stepped out of the multiplier's top cage, tooth by tooth)
  K, P               -> band sequence    (count down by unity before each operation; a "running up"
                                          suspends it: Vol II p 84, 7 March 1836)
  band               -> bolting          (Ver to platform 5 or 6, S1 or SS, ′p′p or ′P)
  bolting            -> engagements      (E0-E2 of docs/f-engage-rules.md, E3 exploratory)
  engagements        -> tooth turns      (T1-T6 of docs/f-mill-rules.md)

No number is added, multiplied or compared in the execution path. The only
operations on figures are turning one wheel one tooth, and noticing that a
wheel has passed between 9 and 0 (a warning, a running up). Host-language
multiplication appears once, in `check`, after a run, as an independent
checker.

  python3 scripts/f_control.py                     F/018-019's operands, then the test operands
  python3 scripts/f_control.py 1028 201            one run, with its bands
  python3 scripts/f_control.py --md OUT --json OUT
"""

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

# ---------------------------------------------------------------- wheels


class Wheels:
    """Figure wheels in cages: w[(axis, n)][cage], cage 0 the lowest. Counters K and P."""

    def __init__(self, multiplicand, multiplier, cages):
        self.cages = {"A": cages, "B": cages, "C": len(multiplier)}
        self.w = {(x, n): [0] * self.cages[x] for x in "ABC" for n in (1, 2)}
        self.turns = 0
        # the operands are set on the wheels figure by figure, as written
        for i, f in enumerate(reversed(multiplicand)):
            self.w[("A", 1)][i] = int(f)
        for i, f in enumerate(reversed(multiplier)):   # the multiplier fills its axis: first figure in the top cage
            self.w[("C", 1)][i] = int(f)
        self.K = [0]                                   # the count of additions (one wheel)
        self.P = [int(f) for f in reversed(str(len(multiplier)))]  # the count of places: see M-P
        self.warn = {}
        self.overflow = []
        self.longest_chain = 0

    def turn(self, wheel, cage, by):
        """One wheel, one tooth. True when a forward turn passes 9 -> 0 or a backward turn 0 -> 9."""
        self.turns += 1
        old = wheel[cage]
        wheel[cage] = (old + by) % 10
        return (by > 0 and old == 9) or (by < 0 and old == 0)

    def count_down(self, counter):
        """Subtract unity from a counter, tooth by tooth with borrow. True on a running up
        (the top cage passing 0 -> 9: the count was exhausted)."""
        cage = 0
        while cage < len(counter):
            if not self.turn(counter, cage, -1):
                return False
            cage += 1
        return True

    def restore(self, counter):
        """After a running up the counter stands at 9 in every cage; turn it on one tooth (assumed)."""
        cage = 0
        while cage < len(counter) and self.turn(counter, cage, +1):
            cage += 1

    def figures(self, key):
        return "".join(str(d) for d in reversed(self.w[key]))


# ---------------------------------------------------------------- bolting -> engagements


def engagements(bolted):
    """E0-E2 (docs/f-engage-rules.md) and E3 (exploratory, fitted): from the bolted state
    to (giver, receiver, cage offset)."""
    pairs = {}
    for x, ver, s1, ss in (("A", "A Ver", None, None), ("B", "B Ver", "′S1", "′S′S"), ("C", "C Ver", "″S1", "″S″S")):
        v = bolted.get(ver)
        if v not in ("P5", "P6"):
            continue                                        # E0
        g = 1 if v == "P5" else 2                           # E1
        step = bool((s1 and bolted.get(s1)) or (ss and bolted.get(ss)))
        if step:
            e2 = 1 if bolted.get(s1) else 2                 # E2
            if e2 != g:
                raise ValueError(f"{x}: S part and Ver disagree")
        pairs[x] = [((x, g), (x, 3 - g), 1 if step else 0)]
    if "A" in pairs:                                        # E3: the product's receiving wheel
        if bolted.get("′p′p"):
            pairs["A"].append((pairs["A"][0][0], ("B", 1), 0))
        elif bolted.get("′P"):
            pairs["A"].append((pairs["A"][0][0], ("B", 2), 0))
    return [p for ps in pairs.values() for p in ps]


def execute(m, pairs, carry):
    """Rows 1-9 (T1-T5), then row 13 (T6). Returns the figure stepped out of C's top cage, as
    teeth turned onto the counter K."""
    givers = sorted({g for g, _, _ in pairs})
    receivers_b = {r for _, r, _ in pairs if r[0] == "B"}
    for _row in range(1, 10):
        for g in givers:
            for cage in range(m.cages[g[0]]):
                if m.w[g][cage] == 0:
                    continue
                m.turn(m.w[g], cage, -1)
                for g2, r, off in pairs:
                    if g2 != g:
                        continue
                    j = cage + off
                    if j >= m.cages[r[0]]:
                        if g[0] == "C":
                            m.turn(m.K, 0, +1)               # T4: out of the top, onto the counter
                        else:
                            m.overflow.append(r)
                        continue
                    if m.turn(m.w[r], j, +1) and r[0] == "B" and g[0] != "B":
                        m.warn[(r, j)] = True                # T5: warnings on the product only in an addition
    if carry:                                                # T6, row 13
        chain = 0
        while m.warn:
            chain += 1
            m.longest_chain = max(m.longest_chain, chain)
            pending, m.warn = sorted(m.warn), {}
            for (r, j) in pending:
                if j + 1 < m.cages["B"]:
                    if m.turn(m.w[r], j + 1, +1):
                        m.warn[(r, j + 1)] = True
                else:
                    m.overflow.append(r)
    return receivers_b


# ---------------------------------------------------------------- the controller


def multiply(multiplicand, multiplier, cages=None):
    """Run the controller. Operands are strings of figures, as written; nothing reads them as numbers."""
    cages = cages or len(multiplicand) + len(multiplier) + 1
    m = Wheels(multiplicand, multiplier, cages)
    on = {"A": 1, "B": 1, "C": 1}         # which wheel of each axis holds its number: the controller's own state
    bolted, bands, first = {}, [], True

    def band(kind, want, words, carry=False):
        labels = {}
        for col in sorted(set(bolted) | set(want)):
            old, new = bolted.get(col), want.get(col)
            if old != new:
                labels[col] = (f"U{old[1:]} " if old else "") + (f"B{new[1:]}" if new else "")
                labels[col] = labels[col].strip()
        bolted.clear()
        bolted.update({k: v for k, v in want.items() if v})
        pairs = engagements(bolted)
        execute(m, pairs, carry)
        bands.append({"kind": kind, "words": words, "labels": labels, "bolted": dict(bolted),
                      "engagements": [f"{g[0]} N.o {g[1]}→{r[0]} N.o {r[1]}{' +1' if off else ''}" for g, r, off in pairs],
                      "K": m.K[0], "product": m.figures(("B", on["B"])),
                      "wheels": {f"{x}{n}": m.figures((x, n)) for x in "ABC" for n in (1, 2)}})

    def step_config(axes):
        want = {}
        for x in axes:
            g = on[x]
            want[f"{x} Ver"] = "P5" if g == 1 else "P6"
            p = "′" if x == "B" else "″"
            want[f"{p}S1" if g == 1 else f"{p}S{p}S"] = "P3"
        return want

    while True:
        # a notice of stepping up (or the start): count down the places
        if m.count_down(m.P):
            break
        axes = ["C"] if first else ["B", "C"]
        names = {1: "one", 2: "two"}
        words = "; ".join(f"{x}: Step up from {names[on[x]]} to {names[3 - on[x]]}" for x in axes)
        band("step", step_config(axes), words)
        for x in axes:
            on[x] = 3 - on[x]
        bands[-1]["product"] = m.figures(("B", on["B"]))
        first = False
        while True:
            if m.count_down(m.K):              # a running up: the additions for this figure are done
                m.restore(m.K)
                break
            a = on["A"]
            want = {"A Ver": "P5" if a == 1 else "P6", **({"′p′p": "P3"} if on["B"] == 1 else {"′P": "P4"})}
            band("add", want, f"Give off from N.o {names[a]} retain on N.o {names[3 - a]}; "
                              f"add to N.os {names[on['B']]}", carry=True)
            on["A"] = 3 - a
    product = m.figures(("B", on["B"]))
    other = m.figures(("B", 3 - on["B"]))
    return {"multiplicand": multiplicand, "multiplier": multiplier, "cages": cages, "bands": bands,
            "product": product, "other_product_wheel": other, "multiplicand_retained": m.figures(("A", on["A"])),
            "turns": m.turns, "overflow": m.overflow, "longest_chain": m.longest_chain}


def check(r):
    """The independent checker, outside the execution path: host-language arithmetic."""
    want = int(r["multiplicand"]) * int(r["multiplier"])
    return {"expected": want, "got": int(r["product"]), "ok": int(r["product"]) == want
            and int(r["other_product_wheel"]) == 0 and int(r["multiplicand_retained"]) == int(r["multiplicand"])
            and not r["overflow"]}


TESTS = [
    ("1028", "201", "F/018–019's operands"),
    ("1028", "102", "the multiplier reversed"),
    ("7", "0", "multiplier zero"),
    ("0", "57", "multiplicand zero"),
    ("1234", "1000", "trailing zeros"),
    ("1234", "0001", "leading zeros"),
    ("31415", "9", "one figure, nine additions"),
    ("4321", "999", "repeated figures"),
    ("9999", "99999", "repeated nines: long carry chains"),
    ("99999", "1", "nothing to carry"),
    ("1", "99999", "single-figure multiplicand"),
    ("909090", "1010", "alternating figures"),
    ("5555", "5555", "repeated fives"),
    ("123456789", "987654321", "every figure"),
    ("99999999", "99999999", "eight nines each"),
    ("1", "1", "one by one"),
]


# ---------------------------------------------------------------- validation

F018_COLS = {"e01": "A Ver", "e14": "B Ver", "e35": "C Ver", "e18": "′P", "e19": "′p′p",
             "e26": "′S′S", "e27": "′S1", "e39": "″S″S", "e40": "″S1"}
F018_KINDS = ["step", "add", "add", "step", "step", "add"]   # from the bands' words (F018.md §3)


def f018_labels():
    """Babbage's labels for the generated columns, as written before each band of F/018-019
    (the rows above band 1; row 15 of the band before)."""
    import f_mill
    out = []
    for sheet, n in f_mill.BANDS:
        # band 1: the rows above it; band 4: F/019's rows above it repeat F/018 band 3's row 15, read there
        src, row = ((f_mill.band_file(sheet, 1), "top-15") if n == 1 else
                    (f_mill.band_file(*f_mill.BANDS[n - 2]), "15"))
        labels = {}
        for line in src.read_text().splitlines():
            parts = [x.strip() for x in line.split("|")]
            if len(parts) >= 3 and parts[0] == row and parts[2].startswith("words"):
                code = parts[1].split()[0]
                if code in F018_COLS:
                    text = parts[2].split('"')[1].replace(".", "")
                    labels[F018_COLS[code]] = " ".join(text.split()).replace("U ", "U").replace("B ", "B")
        out.append(labels)
    return out


# F/020, "Bolting plates / Multiplication without Table", as transcribed in sources/notes/F018.md §4
# (block and line), re-read at the top of 216/278 for block 3's step. Each operation: kind, A's giving
# wheel, the product's receiving wheel where written, step directions where written, notice.
F020 = [
    ("b1 l1", "step", None, None, {"C": (1, 2)}, False),
    ("b1 l3", "add", 1, 1, None, False),
    ("b1 l5", "add", 2, None, None, False),
    ("b1 l7", "add", 1, None, None, False),
    ("b1 l9", "add", 2, None, None, False),
    ("b1 l11", "add", 1, None, None, False),
    ("b2 l2", "add", 2, None, None, True),
    ("b2 l4", "step", None, None, {"B": (1, 2), "C": (2, 1)}, False),
    ("b2 l6", "add", 1, 2, None, False),
    ("b2 l8", "add", 2, None, None, False),
    ("b3 l2", "add", 1, None, None, True),
    ("b3 l4", "step", None, None, {"B": (1, 2), "C": (2, 1)}, False),
    ("b3 l6", "add", 2, 2, None, False),
]


def describe(b):
    import re
    if b["kind"] == "add":
        g = re.search(r"A N\.o (\d)→A", " ".join(b["engagements"]))
        r = re.search(r"→B N\.o (\d)", " ".join(b["engagements"]))
        return ("add", int(g.group(1)), int(r.group(1)), None)
    steps = {}
    for e in b["engagements"]:
        m = re.match(r"(\w) N\.o (\d)→\w N\.o (\d) \+1", e)
        steps[m.group(1)] = (int(m.group(2)), int(m.group(3)))
    return ("step", None, None, steps)


def f020_compare(multiplier="631"):
    r = multiply("1028", multiplier)
    gen = [describe(b) for b in r["bands"]]
    notices = []
    for i, b in enumerate(r["bands"]):
        notices.append(b["kind"] == "add" and (i + 1 == len(r["bands"]) or r["bands"][i + 1]["kind"] == "step"))
    rows = []
    for k, (where, kind, a, recv, steps, notice) in enumerate(F020):
        g = gen[k] if k < len(gen) else None
        diffs = []
        if g is None:
            diffs.append("not generated")
        else:
            if g[0] != kind:
                diffs.append(f"generated {g[0]}")
            if a is not None and g[1] != a:
                diffs.append(f"A gives from N.o {g[1]}")
            if recv is not None and g[2] != recv:
                diffs.append(f"adds to N.os {g[2]}")
            if steps:
                for x, d in steps.items():
                    if g[3] and g[3].get(x) != d:
                        diffs.append(f"{x} steps {g[3].get(x)[0]}→{g[3].get(x)[1]}")
            if notice and not notices[k]:
                diffs.append("no notice here")
        rows.append((where, kind, a, recv, steps, notice, diffs))
    return rows


def report():
    import f_mill
    L = ["# A provisional controller: the multiplier sets the bands", "",
         "Generated by `python3 scripts/f_control.py --md docs/f-control-result.md`. "
         "**A computational hypothesis**: it shows that a counting mechanism of the kind Babbage describes in "
         "December 1835 – March 1836 can generate the sequence of bands, the bolting and the gearing of "
         "F/018–019 from the multiplier alone. It does not show that Babbage's engine of January 1836 did so, "
         "or which part did the counting.", "",
         "## 1. Three claims, kept apart", "",
         "| Claim | Status | Evidence |", "|---|---|---|",
         "| A counter can generate the observed sequence | **shown here, computationally** | sections 3–5 |",
         "| Babbage intended a counter for this | **documented later than F/018, for related designs; not on these sheets** | Vol II p 24 (5 Dec 1835, multiplication by table): \"Step up multiplier which reduces its first figure to zero and sets lifters\"; Vol II p 68 (about 20 Feb 1836): \"Set register to … fig. of A connect it with the lifters and reduce it to zero by stepping down\", and a wheel of p − d teeth, \"at each tooth step up product\"; Vol II p 84 (7 March 1836): a count \"put on an axis having a carriage\", \"a register axis subtr.g unity previous each operation\", \"a running up will take place at end and thus the op.n be suspended\"; Vol XIII history (24 March 1836): an apparatus counting the digits p; Vol II p 88 (11 March 1836): \"R\" written after exactly the sums whose result passes through 0000/9999 (\"p−q = 9998 R\"), so a running up is a number passing through zero, as the counter here does; p 76: a counting wheel \"determines the No. of steppings\". Read in `sources/notes/bolting-plates-sources.md` §3.5, `repetition-count-1836-1842.md` §1–2 and `counting-running-up-1836.md` |",
         "| R2 is that counter | **not claimed** | see section 6 |", "",
         "## 2. The mechanism, as run", "",
         "- **K**, one counting wheel. When the multiplier steps up a cage, its top figure leaves the axis tooth by "
         "tooth (rule T4) and each tooth turns K on one tooth: the figure is *given off* onto K.",
         "- **Before each addition**, K is turned back one tooth (\"subtracting unity previous each operation\"). "
         "If it passes from 0 to 9, that is a **running up**: the addition is suspended, notice is given of "
         "stepping up, and K is turned on one tooth to stand at zero again (this restoring is assumed).",
         "- **P**, a counter of places, set to the number of figures in the multiplier as written, and turned back "
         "one tooth before each step (cage by cage, with borrow). Its running up ends the multiplication. How the "
         "engine would obtain p is **missing** (the digit-counting apparatus of February–March 1836 is not "
         "reconstructed): p is supplied with the operand.",
         "- **The first step** moves only the multiplier (F/018 band 1, F/020 block 1); later steps move the "
         "product and the multiplier together.",
         "- **Each band's bolting** is generated: A Ver to 5 or 6 by which wheel holds the multiplicand; a step's "
         "Ver to 5 or 6 and S1 or SS by which wheel holds that number; ′p′p (to 3) or ′P (to 4) by which wheel "
         "holds the product. Which wheel holds what is the controller's own state, flipped by each band; it never "
         "reads a figure.",
         "- **The gearing** comes from the bolting by E0–E2 (`f-engage-rules.md`) and E3 (exploratory: ′p′p means "
         "the product's N.<sup>o</sup> 1 receives, ′P its N.<sup>o</sup> 2; fitted on F/018 and F/020). "
         "**The tooth turns** follow T1–T6 (`f-mill-rules.md`).",
         "- **Not generated:** the bolting of P, pp, ap, g, g1, R2, ′g1, 02, ′g2/′g3, 03 and the rest. They have no "
         "role in the wheel model.", "",
         "## 3. F/018–019, regenerated from the multiplier 201", ""]
    r = multiply("1028", "201", cages=f_mill.CAGES)
    lab = f018_labels()
    L += ["| Band | Kind (generated / chart) | Generated labels | Babbage's labels, same columns | Product | Recorded |",
          "|---|---|---|---|---|---|"]
    recorded = [f_mill.read_band(s, n)["recorded"].get("B") for s, n in f_mill.BANDS]
    kinds_ok = labels_ok = prod_ok = 0
    for i, b in enumerate(r["bands"]):
        gen = b["labels"]
        bab = lab[i] if i < len(lab) else {}
        same = gen == bab
        labels_ok += same
        kinds_ok += i < 6 and b["kind"] == F018_KINDS[i]
        prod_ok += i < 6 and b["product"].lstrip("0") == (recorded[i] or "").lstrip("0")
        fmt = lambda d: ", ".join(f"{k} {v}" for k, v in sorted(d.items())) or "—"
        L.append(f"| {i + 1} | {b['kind']} / {F018_KINDS[i] if i < 6 else '—'} | {fmt(gen)} | {fmt(bab)}"
                 f"{'' if same else ' **≠**'} | {b['product']} | {recorded[i] if i < 6 else '—'} |")
    L += ["", f"Bands generated: {len(r['bands'])} (the chart has 6). Kinds: {kinds_ok}/6. Labels of the "
          f"generated columns identical to Babbage's: {labels_ok}/6 bands. Products: {prod_ok}/6. "
          "This is not a blind test: the controller was written knowing F/018–019, and E0–E3 were fitted on them.", "",
          "## 4. F/020, \"Bolting plates / Multiplication without Table\"", "",
          "F/020 has no operands. The controller was run on 1028 × 631, a multiplier chosen to give six additions, "
          "then three, then at least one, as F/020's blocks do; it is not assumed that F/020 is that run.", "",
          "| F/020 | Operation | As written | Generated, where it differs |", "|---|---|---|---|"]
    rows = f020_compare()
    nm = {1: "one", 2: "two"}
    agree = 0
    for where, kind, a, recv, steps, notice, diffs in rows:
        desc = (f"give off from {nm[a]}" + (f", add to N.os {nm[recv]}" if recv else "") if kind == "add" else
                "; ".join(f"{x} {nm[d[0]]}→{nm[d[1]]}" for x, d in steps.items())) + (", notice of stepping up" if notice else "")
        agree += not diffs
        L.append(f"| {where} | {kind} | {desc} | {'; '.join(diffs) if diffs else 'same'} |")
    L += ["", f"**{agree} of {len(rows)} operations agree.** The divergence is block 3: F/020 writes its second "
          "step exactly as its first (\"Step up from one to two\" for the product, \"two to one\" for the "
          "multiplier, the product's Ver bolted to 5 again), and then adds to N.<sup>os</sup> two again. In a "
          "continuous run the product would be on N.<sup>o</sup> 2 after the first step, so the second step "
          "would go from two to one and the next addition to N.<sup>os</sup> one, as F/019 bands 4–6 do. "
          "Block 3's step was re-read on the photograph (216/278) and is written as transcribed. Either F/020 "
          "is a schedule of patterns rather than one run, or its block 3 repeats block 2 in error; the sheet "
          "does not say.", "",
          "## 5. The historical pair and fifteen new operand pairs", "",
          "Checked afterwards, outside the execution path, by host-language multiplication.", "",
          "| Multiplicand | Multiplier | Why | Bands | Tooth turns | Longest carry chain | Product | Checker |",
          "|---|---|---|---|---|---|---|---|"]
    allok = 0
    for a, b, why in TESTS:
        rr = multiply(a, b)
        c = check(rr)
        allok += c["ok"]
        L.append(f"| {a} | {b} | {why} | {len(rr['bands'])} | {rr['turns']} | {rr['longest_chain']} | "
                 f"{rr['product']} | {'✓' if c['ok'] else '✗ ' + str(c['expected'])} |")
    L += ["", f"**{allok} of {len(TESTS)} correct** (the historical pair, 1028 × 201, and {len(TESTS) - 1} new pairs), the multiplicand retained on its axis and the other product "
          "wheel at zero in each. This shows the mechanism is general for multiplication without a table; it is "
          "not evidence about Babbage's engine.", "",
          "## 5a. Proved, for every operand", "",
          "`formal/Babbage/Mill.lean` (Lean 4, no Mathlib, no `sorry`, only the standard axioms propext, "
          "Classical.choice, Quot.sound) proves the controller's arithmetic at the level of tooth turns, for all "
          "operands within capacity: `give_off_retain` (nine rows leave the giver at zero and the retaining wheel "
          "holding its figures), `add_band` (give-off plus carriage adds exactly, if the sum fits the cages), "
          "`step_band` and `step_multiplier` (one cage higher is ×10, the top figure goes onto K), `countDown_spec` "
          "and `add_loop` (K set to d gives exactly d additions, then runs up), and `multiply_correct` / "
          "`multiply_lists` (the controller ends, the product wheel holds A × M, the multiplicand is retained, "
          "and the bands number p + ΣM), with `multiply_invariant` (after i figures the product is A × the first "
          "i figures).", "",
          "**What the proof does not cover.** Rows and carriage rounds are defined cage by cage, not in "
          "`execute`'s loop order; the equivalence is argued in the module's docstring, not proved. The bolting "
          "and the rules E0–E3 are not modelled: the proof names the giving and receiving wheels directly. No "
          "run compares the Lean definitions with the Python on the same operands. It proves the controller "
          "correct, not that it is Babbage's.", "",
          "## 6. R2", "",
          "R2 heads a column of the multiplier group. On F/018–019 it is bolted (B3, B4, B3, with lifts 1.1, .6, "
          "1.1) for exactly the three bands in which the multiplier steps, and unbolted in every addition band. "
          "That fits a part concerned with the stepping of the multiplier, for instance with receiving its top "
          "figure. On F/013 (table multiplication, 5 Jan 1836) its ′R column carries \"Gears with N.o 2\" and "
          "\"Gears with N.o 1\", and a note of 6 Feb 1836 says \"R & R1 gear with N.o 1 & 2 of A only and R2 R3 "
          "are wanted for the other operation\": R-wheels are gearing between figure wheels, not counters "
          "(`counting-running-up-1836.md` §3). It does not fit a part that counts the additions by moving: R2 shows no motion in any addition "
          "band, and a counter on these sheets would have to be turned back once in each. Nothing here identifies "
          "the counter with R2 or with any column.", "",
          "## 7. Missing, and assumed", "",
          "- **Missing:** how p, the number of the multiplier's figures, is obtained; how a running up suspends an "
          "operation (Vol II pp 84, 91, 94 use it to suspend an operation, choose the multiplier and choose a "
          "barrel cycle, but no page read says how; the word \"notice\" occurs only on F/020); which column, if any, is K.",
          "- **Assumed:** K restored to zero by one tooth after a running up; the first step moves the multiplier "
          "alone; enough cages for the product (multiplicand and multiplier figures, plus one).",
          "- **From the earlier layers, unchanged:** the platform 5/6 rule E1 (6 of 6 on unseen sheets where it "
          "predicts), E0 (fails on square root's D-C), E2 (untested on unseen sheets), E3 (fitted), and T1–T6 "
          "(fitted on F/018–019).", ""]
    return "\n".join(L)


if __name__ == "__main__":
    args = sys.argv[1:]
    if len(args) == 2 and not args[0].startswith("--"):
        r = multiply(args[0], args[1])
        for i, b in enumerate(r["bands"], 1):
            print(f"band {i:>2} {b['kind']:<4} labels {b['labels']}  [{'; '.join(b['engagements'])}]  "
                  f"K={b['K']} product {b['product']}")
        print(r["product"], check(r))
        sys.exit()
    if "--md" in args:
        Path(args[args.index("--md") + 1]).write_text(report())
    if "--json" in args:
        Path(args[args.index("--json") + 1]).write_text(json.dumps(
            {"f018": multiply("1028", "201", cages=6), "tests": [multiply(a, b) for a, b, _ in TESTS]},
            ensure_ascii=False, indent=1) + "\n")
    for a, b, why in TESTS:
        r = multiply(a, b)
        c = check(r)
        print(f"{a:>10} × {b:<10} {len(r['bands']):>3} bands {r['turns']:>6} turns  "
              f"{r['product']}  {'ok' if c['ok'] else 'WRONG ' + str(c)}  ({why})")
