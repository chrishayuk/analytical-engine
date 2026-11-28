"""Correctness checks of scripts/f_control.py, the provisional multiplication controller.

The controller never multiplies; this file does, as the checker. It runs
  1. every multiplicand 0-999 against every multiplier written with one or two
     figures ("0"-"9", "00"-"99"), and
  2. 2000 deterministic random pairs of 1-20 figures (seed 1836), leading zeros allowed,
and checks after every band, not only the product at the end:
  - each addition band adds exactly the multiplicand to the product;
  - each step after the first multiplies the product by ten;
  - before each step, and at the end, the product is A x (the multiplier figures used so far);
  - the multiplicand is retained (one A wheel holds it, the other is at zero);
  - at most one product wheel is not at zero; nothing leaves the product axis (no overflow);
  - the number of additions after each multiplier step equals the figure stepped out;
  - the number of bands is p + (sum of the multiplier's figures);
  - the counter K ends at zero.

  python3 scripts/test_f_control.py [--md OUT]
"""

import random
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from f_control import multiply  # noqa: E402


def upon(b, x):
    v1, v2 = int(b["wheels"][f"{x}1"]), int(b["wheels"][f"{x}2"])
    return v1, v2


def verify(a, m):
    """All the invariants for one run. Returns a list of failures (empty when all hold)."""
    r = multiply(a, m)
    A, figs = int(a), [int(f) for f in m]
    fails, product, steps, adds_since, used = [], 0, 0, None, 0
    expect_adds = []
    for i, b in enumerate(r["bands"]):
        a1, a2 = upon(b, "A")
        b1, b2 = upon(b, "B")
        if sorted((a1, a2)) != sorted((0, A)):
            fails.append(f"band {i + 1}: multiplicand not retained ({a1}, {a2})")
        if b1 and b2:
            fails.append(f"band {i + 1}: both product wheels hold figures")
        now = b1 or b2
        if b["kind"] == "add":
            if now != product + A:
                fails.append(f"band {i + 1}: addition gave {now}, not {product} + {A}")
            adds_since += 1
        else:
            if adds_since is not None:
                expect_adds.append(adds_since)
            if product != A * int("".join(map(str, figs[:used])) or "0"):
                fails.append(f"before step {steps + 1}: product {product} is not A x prefix")
            if steps and now != product * 10:
                fails.append(f"band {i + 1}: step gave {now}, not {product} x 10")
            steps += 1
            used += 1
            adds_since = 0
        product = now
    expect_adds.append(adds_since or 0)
    if expect_adds != figs:
        fails.append(f"additions per figure {expect_adds}, figures {figs}")
    if product != A * int(m):
        fails.append(f"product {product}, expected {A * int(m)}")
    if len(r["bands"]) != len(figs) + sum(figs):
        fails.append(f"{len(r['bands'])} bands, formula gives {len(figs) + sum(figs)}")
    if r["overflow"]:
        fails.append(f"overflow {r['overflow']}")
    if r["bands"] and r["bands"][-1]["K"] != 0:
        fails.append("K not at zero at the end")
    return fails, r


def run():
    t0, out = time.time(), {}
    multipliers = [str(d) for d in range(10)] + [f"{d:02d}" for d in range(100)]
    n = bad = 0
    examples = []
    for a in range(1000):
        for m in multipliers:
            f, _ = verify(str(a), m)
            n += 1
            if f:
                bad += 1
                examples.append((a, m, f[:2]))
    out["exhaustive"] = (n, bad, examples[:5], time.time() - t0)
    rng = random.Random(1836)
    t1, n2, bad2, ex2, chain, bands_max, turns_max = time.time(), 0, 0, [], 0, 0, 0
    for _ in range(2000):
        a = "".join(rng.choice("0123456789") for _ in range(rng.randint(1, 20)))
        m = "".join(rng.choice("0123456789") for _ in range(rng.randint(1, 20)))
        f, r = verify(a, m)
        n2 += 1
        chain, bands_max, turns_max = max(chain, r["longest_chain"]), max(bands_max, len(r["bands"])), max(turns_max, r["turns"])
        if f:
            bad2 += 1
            ex2.append((a, m, f[:2]))
    out["random"] = (n2, bad2, ex2[:5], time.time() - t1, chain, bands_max, turns_max)
    out["mutations"] = mutations()
    return out


def mutations():
    """The checks must be able to fail: break one rule at a time and count failing runs on a sample."""
    import f_control as fc
    exe, eng = fc.execute, fc.engagements
    cases = [(str(a), m) for a in range(0, 1000, 7) for m in ("1", "9", "23", "90", "05")]
    broken = {
        "no carriage (T6)": ("execute", lambda m, p, c: exe(m, p, False)),
        "a step gives to the same cage (T3)": ("engagements", lambda b: [(g, r, 0) for g, r, o in eng(b)]),
        "nothing retained on the multiplicand axis (T2)": ("engagements",
            lambda b: [(g, r, o) for g, r, o in eng(b) if not (g[0] == r[0] == "A")]),
    }
    out = {}
    try:
        for name, (attr, fn) in broken.items():
            fc.execute, fc.engagements = exe, eng
            setattr(fc, attr, fn)
            out[name] = (sum(1 for a, m in cases if verify(a, m)[0]), len(cases))
    finally:
        fc.execute, fc.engagements = exe, eng
    return out


def report(o):
    n, bad, ex, t = o["exhaustive"]
    n2, bad2, ex2, t2, chain, bmax, tmax = o["random"]
    return "\n".join([
        "# The controller's correctness checks", "",
        "Generated by `python3 scripts/test_f_control.py --md docs/f-control-tests.md`. These check the "
        "**computational** mechanism of `scripts/f_control.py` (a hypothesis about Babbage's design); they say "
        "nothing about whether it is the mechanism of January 1836.", "",
        "Checked after every band: each addition adds exactly the multiplicand; each step after the first "
        "multiplies the product by ten; before each step and at the end the product is the multiplicand times "
        "the multiplier's figures used so far; the multiplicand is retained; at most one product wheel holds "
        "figures; no figure leaves the product axis; the additions after each multiplier step equal the figure "
        "stepped out; the bands number p + (sum of the multiplier's figures); the counter ends at zero. "
        "Host-language multiplication is used only here, as the checker.", "",
        "| Suite | Runs | Failing | Time |", "|---|---|---|---|",
        f"| Every multiplicand 0–999 × every multiplier written with one or two figures (\"0\"–\"9\", \"00\"–\"99\") | {n:,} | {bad} | {t:.0f} s |",
        f"| 2,000 random pairs of 1–20 figures, leading zeros allowed (seed 1836) | {n2:,} | {bad2} | {t2:.0f} s |", "",
        f"Largest random run: {bmax} bands, {tmax:,} tooth turns; longest carry chain {chain}.", "",
        "Failures: " + ("none." if not (ex or ex2) else str(ex + ex2)), "",
        "**The checks can fail.** With one rule broken at a time, on a sample of 715 runs:", "",
        "| Broken | Runs failing |", "|---|---|"] + [f"| {k} | {v[0]} of {v[1]} |" for k, v in o["mutations"].items()] + ["",
        "**The band count.** In every run the number of bands was p + d₁ + … + d_p, p the number of figures "
        "written in the multiplier and dᵢ its figures: one step band per figure and one addition band per unit "
        "of each figure. This is a property of this controller, not a measurement of Babbage's engine.", ""])


if __name__ == "__main__":
    o = run()
    text = report(o)
    if "--md" in sys.argv:
        Path(sys.argv[sys.argv.index("--md") + 1]).write_text(text)
    print(text)
    sys.exit(1 if o["exhaustive"][1] or o["random"][1] else 0)
