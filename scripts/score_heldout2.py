"""Score held-out test 2: the frozen predictions against the blind transcription.

Predictions: docs/predictions/held-out-2-predictions.md (v1, 64ca93e) and
-v2.md (1732e2f). Observations: sources/notes/F021-F033-arrows.md (read by a
reader not shown the predictions). Rules and protocol: held-out-2-rules.md,
held-out-2-protocol.md. Nothing in the predictions is changed here.

A "motion" is any arrow transcribed in the band's first motion row (row 1).
Its direction is read from the words "up"/"down" in the transcription; an
up and a down arrow side by side is "both". A figure is compared with the
predicted lift digit for digit; the right digits without the point is
reported apart ("point missing"), and scored as a miss for the lift.
"nothing (in the visible part)" and "cropped" are cropped; "unreadable" is
unreadable; neither is a pass or a miss.

  python3 scripts/score_heldout2.py
"""

import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OBS = ROOT / "sources/notes/F021-F033-arrows.md"
V1 = ROOT / "docs/predictions/held-out-2-predictions.md"
V2 = ROOT / "docs/predictions/held-out-2-predictions-v2.md"
LIFT = {1: 1.1, 2: .6, 3: 1.1, 4: .6, 5: .4, 6: .2, 7: -.2, 8: -.4, 9: -.6, 10: -1.1, 11: -.6, 12: -1.1}
DESIGN = {"F/021": "division without table", "F/022": "division without table", "F/023": "division without table",
          "F/024": "division without table", "F/026": "square root", "F/027": "square root",
          "F/028": "square root", "F/029": "square root", "F/032": "ordinary cycle", "F/033": "carriage"}


def norm(s):
    return re.sub(r"\s+", " ", s.replace("*", "")).strip()


def observations():
    obs, sheet = {}, None
    for ln in OBS.read_text().splitlines():
        m = re.match(r"### F0?(\d\d\d)?", ln)
        h = re.match(r"### F(\d{3})", ln)
        if h:
            sheet = f"F/{h.group(1)}"
        elif ln.startswith("## 4.") or ln.startswith("### Upper table"):
            sheet = "F/033"
        elif ln.startswith("## 3."):
            sheet = "F/032"
        if not ln.startswith("| ") or ln.startswith("| Band") or ln.startswith("|---"):
            continue
        c = [x.strip() for x in ln.strip().strip("|").split("|")]
        if len(c) < 5 or sheet is None:
            continue
        band, col, mark, fig, ret = c[0], norm(c[1]), norm(c[2]), c[3].strip(), c[4]
        other = c[5] if len(c) > 5 else ""
        obs[(sheet, band, col)] = (mark, fig, ret, other)
    return obs


# How a cell read "nothing (in the visible part)" is scored: the paper ends
# inside row 1 there (F/026-029 band 4). "cropped" drops it; "nothing" scores it
# as empty, as the arrows seen in the same row are scored. Both are reported.
VISIBLE_EMPTY = "cropped"


def classify(mark):
    m = mark.lower()
    if "visible part" in m and "arrow" not in m:
        return VISIBLE_EMPTY, None
    if "cropped" in m or "not photographed" in m:
        return "cropped", None
    if "unreadable" in m or "illegible" in m:
        return "unreadable", None
    if "arrow" not in m and "stroke" not in m:
        return "nothing", None
    up, down = "up" in m, "down" in m
    d = "both" if up and down else "up" if up else "down" if down else "?"
    return "motion", d


def lift_score(fig, k):
    want = abs(LIFT[k])
    s = fig.replace("—", "").strip()
    m = re.search(r"(\d*\.\d+|\d+)", s)
    if not m:
        return "no figure"
    txt = m.group(1)
    exact = f"{want:g}".lstrip("0") if want < 1 else f"{want:g}"
    if txt == exact or txt == f"{want:g}":
        return "lift right" + (" (uncertain)" if "?" in s else "")
    if txt.replace(".", "") == exact.replace(".", "") and "." not in txt:
        return "point missing" + (" (uncertain)" if "?" in s else "")
    return f"lift WRONG ({txt})"


ALIAS = {("F/026", "cs (T2)"): "T2 cs", ("F/028", "′g3 [? ″g3]"): "″g3"}


def predictions(path):
    rows = []
    for ln in path.read_text().splitlines():
        if not ln.startswith("| F/0"):
            continue
        c = [x.strip() for x in ln.strip().strip("|").split("|")]
        sheet, band, col, kind, k = c[0], c[2], norm(c[3]), c[4], c[5]
        # Names only (documented in the scores): the inputs note wrote some band
        # and column names differently from the transcription.
        if "mid" in band:  # F/033 mid-band rows: scored on rows 12-13 of the band they sit in
            kind = "MID-BAND " + ("negative: " if ("lone U" in kind or "no motion" in kind.split(":")[0]) else "") + kind
        if band.startswith("L12") or "one row lower" in band:
            # F/033: label rows that close a band (the inputs note lists them as rows of
            # their own); they have no motion row of their own, so nothing is scored.
            kind = "NO MOTION ROW " + kind
        band = {"U-mid": "U1", "L-mid": "L1"}.get(band.split(" ")[0], band)
        col = ALIAS.get((sheet, col), col)
        rows.append((sheet, band, col, kind, int(k) if k.isdigit() else None))
    return rows


def returns(o, k, want, g, miss, name):
    """R2 (return row) is untestable here. Scored: is there a return; its direction
    (opposite to the motion); its figure (the lift again)."""
    r = o[2]
    if not r or r.strip().lower().startswith("none"):
        g["no return transcribed"] += 1
        return
    if "cropped" in r.lower() or "not photographed" in r.lower():
        g["return cropped"] += 1
        return
    rl = r.replace("*", "").lower()
    d = "up" if re.search(r"\bup\b", rl) else "down" if re.search(r"\bdown\b", rl) else "?"
    opp = "down" if want == "up" else "up"
    g["return direction opposite"] += 1 if d == opp else 0
    if d != opp:
        g[f"return direction NOT opposite ({d})"] += 1
        miss.append(f"{name}: return {r!r}")
    fig = re.sub(r"^.*?\b(up|down)\b[^,]*,", "", rl, count=1)
    if "no figure" in fig or not re.search(r"\d", fig):
        g["return without figure"] += 1
    else:
        ls = lift_score(fig, k)
        g["return figure: " + ls] += 1
        if ls != "lift right" and "uncertain" not in ls:
            miss.append(f"{name}: return figure {r!r} ({ls})")


def e2(obs, out):
    """E2 (exploratory, v1 only): F/032 return row by F/013's Long/Short grouping."""
    out.append("\n## E2 (exploratory): F/032 return row by F/013's Long/Short grouping\n")
    for ln in V1.read_text().splitlines():
        if not ln.startswith("| F/032"):
            continue
        c = [x.strip() for x in ln.strip().strip("|").split("|")]
        if not c[8].startswith("row"):
            continue
        o = obs.get(("F/032", c[2], norm(c[3])))
        got = o[2] if o else "(not transcribed)"
        want = "12" if c[8] == "row 12" else "15"
        ok = got.startswith("row " + want) or got.startswith("rows " + want)
        out.append(f"- band {c[2]} {c[3]} ({c[4]}, k {c[5]}): predicted {c[8]}; transcribed {got!r}: {'right' if ok else 'WRONG'}")


def score(path, label, obs, out):
    preds = predictions(path)
    per = defaultdict(Counter)
    misses = defaultdict(list)
    unmatched = []
    for sheet, band, col, kind, k in preds:
        o = obs.get((sheet, band, col))
        key = kind.split(":")[0].split(" (")[0]
        if "MID-BAND" in kind:
            if o is None:
                unmatched.append((sheet, band, col, kind)); continue
            other = o[3].lower()  # single-headed later arrows are under Other; returns are not motions
            m = re.search(r"rows? 1[1-3](?:–1[1-3])?[^;]*?short (up|down) arrow(?: \+ \"([^\"]*)\")?", other)
            hit = m is not None
            if not hit and re.search(r"row 1[23]\b[^;]*double head", o[2].lower()):
                per[(label, "MID-BAND variant: a double-headed row-12 arrow counted as motion", sheet)][f"{col}: {o[2]}"] += 1
            if hit and not kind.startswith("MID-BAND negative") and k:
                g = per[(label, "MID-BAND motion: direction and lift", sheet)]
                g["direction right" if m.group(1) == ("up" if LIFT[k] > 0 else "down") else "direction WRONG"] += 1
                ls = lift_score(m.group(2) or "", k)
                g[ls] += 1
                if "WRONG" in ls:
                    misses[(label, "MID-BAND motion: direction and lift")].append(f"{sheet} {band} {col} B{k}: {m.group(0)}")
            neg = kind.startswith("MID-BAND negative")
            name = "MID-BAND " + ("no-motion" if neg else "motion") + (" (v1 persistent)" if "persistent" in kind else "")
            per[(label, name, sheet)]["motion in row 12–13 seen" if hit else "no motion in row 12–13 transcribed"] += 1
            if hit and neg or not hit and not neg:
                misses[(label, name)].append(f"{sheet} {band} {col}: returns {o[2]!r}; other {o[3]!r}")
            continue
        if kind.startswith("NO MOTION ROW"):
            per[(label, "label row closing a band (F/033): not scored", sheet)]["predictions"] += 1
            continue
        if o is None:
            unmatched.append((sheet, band, col, kind)); continue
        st, d = classify(o[0])
        g = per[(label, key, sheet)]
        if st in ("cropped", "unreadable"):
            g[st] += 1
            continue
        if kind.startswith("FRESH B") or kind.startswith("R1/M0/M1") or kind.startswith("E1"):
            want = "up" if LIFT[k] > 0 else "down"
            if st != "motion":
                g["motion MISSED"] += 1; misses[(label, key)].append(f"{sheet} b{band} {col} B{k}: nothing")
                continue
            g["motion seen"] += 1
            if d == want:
                g["direction right"] += 1
            else:
                g[f"direction WRONG ({d})"] += 1; misses[(label, key)].append(f"{sheet} b{band} {col} B{k}: {o[0]}")
            ls = lift_score(o[1], k)
            g[ls] += 1
            if "WRONG" in ls or ls.startswith("point missing"):
                misses[(label, key)].append(f"{sheet} b{band} {col} B{k}: figure {o[1]!r} ({ls})")
            returns(o, k, want, per[(label, key + ": returns", sheet)], misses[(label, key + ": returns")], f"{sheet} b{band} {col} B{k}")
        elif kind.startswith("PERSISTENT") or kind.startswith("M1 persistent"):
            want = "up" if LIFT[k] > 0 else "down"
            if st == "motion":
                g["moved (M1 right, M0 wrong)"] += 1
                g["… direction right" if d == want else f"… direction WRONG ({d})"] += 1
                g["… " + lift_score(o[1], k)] += 1
                returns(o, k, want, per[(label, key + ": returns", sheet)], misses[(label, key + ": returns")], f"{sheet} b{band} {col} B{k}")
            else:
                g["did not move (M0 right, M1 wrong)"] += 1
        else:  # negative predictions: lone U, detached, unknown, bare B, attached ?
            g["no motion, as predicted" if st != "motion" else "MOTION (false for a no-motion prediction)"] += 1
            if st == "motion":
                misses[(label, key)].append(f"{sheet} b{band} {col}: {o[0]} {o[1]}")
    out.append(f"\n## {label}\n")
    keys = sorted({(k1, k2) for (l, k1, k2) in per if l == label})
    bykind = defaultdict(Counter)
    for (l, kind, sheet), c in per.items():
        if l == label:
            bykind[kind].update(c)
    for kind, c in bykind.items():
        out.append(f"**{kind}** (all sheets): " + "; ".join(f"{a} {b}" for a, b in sorted(c.items())))
        bydesign = defaultdict(Counter)
        for (l, kd, sheet), cc in per.items():
            if l == label and kd == kind:
                bydesign[DESIGN.get(sheet, sheet)].update(cc)
        for dsg, cc in bydesign.items():
            out.append(f"- {dsg}: " + "; ".join(f"{a} {b}" for a, b in sorted(cc.items())))
        out.append("")
    for (l, kind), ms in misses.items():
        if l == label and ms:
            out.append(f"Misses, {kind} ({len(ms)}):")
            out.extend(f"- {m}" for m in ms)
            out.append("")
    out.append(f"Predictions whose column/band is not in the transcription: {len(unmatched)}")
    out.extend(f"- {u}" for u in unmatched[:40])
    return per


def unlabelled(obs, out):
    """Columns never labelled on their sheet (unknown state): R4 as written and M0 predict
    no motion; R4u and M1 abstain."""
    labelled = defaultdict(set)
    for path in (V2,):
        for sheet, band, col, kind, k in predictions(path):
            labelled[sheet].add(col)
    c = Counter()
    moving = []
    for (sheet, band, col), o in obs.items():
        if col in labelled[sheet] or NOT_PART.search(col) or NOT_LABELLABLE.search(col):
            continue
        st, d = classify(o[0])
        c[st] += 1
        if st == "motion":
            moving.append(f"{sheet} b{band} {col}: {o[0]} {o[1]}")
    out.append("\n## Part columns never labelled on their sheet (unknown state)\n")
    out.append("R4 as written and M0 predict no motion; R4u and M1 abstain. " + "; ".join(f"{a} {b}" for a, b in sorted(c.items())))
    out.append(f"Motions in never-labelled columns ({len(moving)}), false for R4 as written and M0:")
    out.extend(f"- {m}" for m in moving)


# What each model predicts for each v2 category: 1 motion, 0 no motion, None abstains.
# FROZEN is the frozen v2 text (held-out-2-predictions-v2.md): R4 and R4u predict
# no motion for persistent and unknown-platform parts, and a bare B predicts no
# motion for every model. PROTOCOL_M1 differs in one place: the protocol's M1
# ("moves if it has a fresh B") predicts motion for a bare B. Both are reported.
MODELS = ["M0", "M1", "R4", "R4u"]
FROZEN = {
    "FRESH B": (1, 1, 1, 1),
    "bare B this band": (0, 0, 0, 0),
    "unknown, no label": (0, None, 0, None),
    "never labelled": (0, None, 0, None),
    "U this band": (0, 0, 0, 0),
    "PERSISTENT": (0, 1, 0, 0),
    "attached to unknown platform": (0, 1, 0, 0),
    "detached, no label": (0, 0, 0, 0),
}
PROTOCOL_M1 = dict(FROZEN, **{"bare B this band": (0, 1, 0, 0)})

# Columns that are not parts: Lock, platform and bolting columns (set aside by the
# rules), and, among never-labelled columns, the unheaded, circular-motion,
# figure-wheel and carry columns, which take no B/U label on any sheet.
NOT_PART = re.compile(r"^(Lock|Platform|Bolt)", re.I)
NOT_LABELLABLE = re.compile(r"no head|Cir\b|Fig|Carry|^Carr b|^Carr ′b|^\(", re.I)


def cases_of(obs):
    cases = []
    labelled = defaultdict(set)
    for sheet, band, col, kind, k in predictions(V2):
        labelled[sheet].add(col)
        key = kind.split(":")[0]
        if key in FROZEN and not kind.startswith(("MID-BAND", "NO MOTION ROW")) and not NOT_PART.search(col):
            o = obs.get((sheet, band, col))
            if o:
                cases.append((sheet, key, classify(o[0])[0]))
    for (sheet, band, col), o in obs.items():
        if col not in labelled[sheet] and not NOT_PART.search(col) and not NOT_LABELLABLE.search(col):
            cases.append((sheet, "never labelled", classify(o[0])[0]))
    return cases


def tally(subset, table, m):
    c = Counter()
    for sheet, key, st in subset:
        p = table[key][m]
        if p is None:
            c["abstains"] += 1
            continue
        seen = st == "motion"
        c[("TP" if seen else "FP") if p else ("FN" if seen else "TN")] += 1
    return c


def models(obs, out):
    global VISIBLE_EMPTY
    out.append("\n## Models on movement detection\n")
    out.append("A case is one part in one band. TP motion predicted and seen; FP motion predicted, none seen "
               "(a false movement); FN no motion predicted, motion seen (a missed movement); TN neither. "
               "Cropped and unreadable cases are left out of every model alike. Never-labelled columns are "
               "parts only (not unheaded, Cir, figure-wheel, carry, Lock, platform or bolting columns).\n")
    for convention in ("cropped", "nothing"):
        VISIBLE_EMPTY = convention
        scorable = [x for x in cases_of(obs) if x[2] not in ("cropped", "unreadable")]
        for tname, table in (("as frozen in v2", FROZEN), ("protocol M1 on bare B", PROTOCOL_M1)):
            common = [x for x in scorable if all(table[x[1]][m] is not None for m in range(4))]
            out.append(f"\n### {tname}; visible-empty band-4 cells as {convention}\n")
            out.append(f"Scorable cases {len(scorable)}; predicted by all four models {len(common)}.\n")
            out.append("| Model | Population | Predicts | TP | FP (false movement) | FN (missed movement) | TN | Accuracy |")
            out.append("|---|---|---|---|---|---|---|---|")
            for pop, subset in (("identical cases", common), ("own coverage", scorable)):
                for m, name in enumerate(MODELS):
                    c = tally(subset, table, m)
                    n = c["TP"] + c["FP"] + c["FN"] + c["TN"]
                    acc = f"{(c['TP'] + c['TN']) / n:.3f}" if n else "—"
                    out.append(f"| {name} | {pop} | {n} of {len(subset)} | {c['TP']} | {c['FP']} | {c['FN']} | {c['TN']} | {acc} |")
            dis = [x for x in scorable if table[x[1]][0] is not None and table[x[1]][1] is not None
                   and table[x[1]][0] != table[x[1]][1]]
            m1 = sum(1 for x in dis if (x[2] == "motion") == bool(table[x[1]][1]))
            out.append(f"\nM0 against M1 where both predict and disagree: {len(dis)} cases; M1 right {m1}, M0 right {len(dis) - m1}.")
            if tname == "as frozen in v2":
                out.append("\n| Category | Motion seen | No motion seen |\n|---|---|---|")
                for key in FROZEN:
                    sub = [x for x in scorable if x[1] == key]
                    mv = sum(1 for x in sub if x[2] == "motion")
                    out.append(f"| {key} | {mv} | {len(sub) - mv} |")
    VISIBLE_EMPTY = "cropped"


def persistence_variants(obs, out):
    global VISIBLE_EMPTY
    out.append("\n## Persistence under each cropping convention\n")
    for convention in ("cropped", "nothing"):
        VISIBLE_EMPTY = convention
        c = Counter()
        for sheet, band, col, kind, k in predictions(V2):
            if kind.startswith("PERSISTENT"):
                o = obs.get((sheet, band, col))
                if o:
                    c[classify(o[0])[0]] += 1
        out.append(f"- visible-empty cells as {convention}: moved {c['motion']}, did not move {c['nothing']}, cropped {c['cropped']}")
    VISIBLE_EMPTY = "cropped"


if __name__ == "__main__":
    obs = observations()
    out = ["# Held-out test 2: scores (generated by scripts/score_heldout2.py)\n",
           f"Observations read: {len(obs)} (sheet, band, column) cells."]
    score(V2, "v2 (1732e2f)", obs, out)
    score(V1, "v1 (64ca93e)", obs, out)
    unlabelled(obs, out)
    e2(obs, out)
    models(obs, out)
    persistence_variants(obs, out)
    (ROOT / "docs/predictions/held-out-2-scores.md").write_text("\n".join(out) + "\n")
