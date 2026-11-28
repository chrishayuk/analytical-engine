"""Arithmetic-dependent control in the mill, February-March 1836: three dated
designs, each as an abstract model of the behaviour Babbage writes down.

BEHAVIOUR, NOT MECHANISM. Each model executes only what its page states, with
the page quoted at every transition. Two kinds of thing the pages leave out
are kept apart:

  Gap     a physical mechanism the page does not show (how an arm reaches a
          barrel, how a running up turns an axis). The page states the
          behaviour; the model follows the text and records the gap. A gap is
          never given a value.
  Event   something that decides the course and that the page does not
          derive: when the positive cycle ends, when "the next running up"
          comes. A run must supply it by name, or the model refuses
          (NotSpecified). A model whose course depends on a supplied event is
          not shown to end by itself, and the trace says so.

Counters are wheels turned one tooth at a time, with borrow, as in
scripts/f_control.py; a running up is the top wheel passing from 0 to 9.
Inputs outside a design's domain or capacity are refused (OutOfDomain).

Sources: sources/notes/running-up-designs-1836.md (sections 4, 8, 13),
docs/c1836-control.md.

  D-0301  1 March 1836, Vol II p 76
  D-0307  7 March 1836, Vol II p 84
  D-0322  22 March 1836, Vol II pp 94-95

  python3 scripts/c1836.py            run the three designs on example cases
  python3 -m unittest scripts/test_c1836.py
"""


class NotSpecified(Exception):
    """A required event was not supplied."""


class OutOfDomain(ValueError):
    """An input outside the design's stated domain or the model's capacity."""


class Gap:
    """A mechanism the page does not show. Recorded, never valued."""

    def __init__(self, name, page, missing):
        self.name, self.page, self.missing = name, page, missing

    def note(self, run):
        run.log("gap", f"{self.name}: {self.missing}; behaviour taken from the text", self.page)
        run.gaps.append(self.name)


class Event:
    """A course-deciding event the page does not derive. Must be supplied."""

    def __init__(self, name, page, says, allowed):
        self.name, self.page, self.says, self.allowed = name, page, says, allowed

    def take(self, run):
        if self.name not in run.events:
            raise NotSpecified(f"{self.name} ({self.page}): {self.says}")
        v = run.events[self.name]
        if v not in self.allowed:
            raise OutOfDomain(f"{self.name}: {v!r} is not one of {self.allowed}")
        run.log("supplied", f"{self.name} = {v!r} (supplied, not derived)", self.page)
        run.supplied.append(self.name)
        return v


class Run:
    def __init__(self, design, events=None):
        self.design, self.events = design, dict(events or {})
        self.trace, self.gaps, self.supplied = [], [], []
        self.outcome = None

    def log(self, kind, what, page=""):
        self.trace.append((kind, what, page))


# ---------------------------------------------------------------- counters as wheels

def wheels(n, cages, what):
    if not isinstance(n, int) or isinstance(n, bool) or n < 0:
        raise OutOfDomain(f"{what} must be a whole number ≥ 0, not {n!r}")
    if n >= 10 ** cages:
        raise OutOfDomain(f"{what} = {n} does not fit {cages} wheels")
    return [int(f) for f in reversed(str(n).rjust(cages, "0"))]


def subtract_unity(w):
    """Turn back one tooth, with borrow. True on a running up (the top wheel passes 0 -> 9)."""
    for c in range(len(w)):
        old = w[c]
        w[c] = (old - 1) % 10
        if old != 0:
            return False
    return True


def subtract(w, other):
    """Subtract a number tooth by tooth, cage by cage with borrow. True if a borrow left the top wheel."""
    ran = False
    for c, f in enumerate(other):
        for _ in range(f):
            for cc in range(c, len(w)):
                old = w[cc]
                w[cc] = (old - 1) % 10
                if old != 0:
                    break
            else:
                ran = True
    return ran


def value(w):
    return "".join(map(str, reversed(w)))


# ---------------------------------------------------------------- 1 March 1836, p 76

COUNTING_LIMIT = 30   # p 82 (4 March) sets its counting wheels from 30: "30 / p−30" (sketchbooks-control.md)

SET_0301 = Gap("q and q−d set", "Vol II pp 75–76", "how the digit counts reach the counting wheels (the spiral axis of pp 72–75)")
ARM_0301 = Gap("the arm thrown in by the stop of q", "Vol II p 76", "no drawing: how the arm reaches the gathering-up teeth and the barrel")
END_0301 = Gap("q−d throws out Mult.n", "Vol II p 76", "how the count ends Mult.n is not said")


def d0301(q, d):
    """q steppings down counted by wheel q; at its stop the stepping-up cycle; q−d steppings up; Mult.n out."""
    for v, nm in ((q, "q"), (d, "d")):
        if not isinstance(v, int) or isinstance(v, bool) or v < 0:
            raise OutOfDomain(f"{nm} must be a whole number ≥ 0, not {v!r}")
    if q > COUNTING_LIMIT:
        raise OutOfDomain(f"q = {q}: the counting wheels of these pages count digits, at most {COUNTING_LIMIT}")
    if d > q:
        raise OutOfDomain(f"d = {d} > q = {q}: q−d would be negative, which p 76 does not provide for")
    r = Run("D-0301 (1 March 1836, p 76)")
    SET_0301.note(r)
    r.log("state", f"counting wheel q at {q}, q−d at {q - d}", "p 76")
    r.log("event", "table finished: gathering-up tooth on q, Mult.n cycle in gear", "p 76: “Table being finished throws into gear …”")
    r.log("cycles", f"{q} steppings down", "p 76: q “determines the No. of steppings down”")
    r.log("event", "stop of q", "p 76")
    ARM_0301.note(r)
    r.log("event", "gathering out of q, into q−d; stepping-up cycle in on the product barrel", "p 76")
    r.log("cycles", f"{q - d} steppings up", "p 76: q−d “determines the number of steppings up”")
    END_0301.note(r)
    r.log("event", "Mult.n thrown out", "p 76")
    r.outcome = {"steppings down": q, "steppings up": q - d, "ends by itself": True}
    return r


# ---------------------------------------------------------------- 7 March 1836, p 84

PUT_0307 = Gap("the count put on the axis", "Vol II p 84", "where the number comes from (the page says only “variable”)")
SUSPEND_0307 = Gap("what the running up suspends", "Vol II p 84", "no barrel, lever, lock or card is named")


def d0307(n, cages=2):
    """Unity subtracted before each operation; n operations; the running up suspends the operation."""
    w = wheels(n, cages, "the count n")
    r = Run("D-0307 (7 March 1836, p 84)")
    PUT_0307.note(r)
    r.log("state", f"count {value(w)} on an axis with a carriage", "p 84")
    ops = 0
    while not subtract_unity(w):
        ops += 1
    r.log("cycles", f"{ops} operations, unity subtracted before each", "p 84: “subtr.g unity previous each operation”")
    r.log("event", f"running up (axis now {value(w)})", "p 84: “a running up will take place at end”")
    SUSPEND_0307.note(r)
    r.log("event", "operation suspended", "p 84")
    r.outcome = {"operations": ops, "ends by itself": True}
    return r


# ---------------------------------------------------------------- 22 March 1836, pp 94-95

FORM_0322 = Gap("q−p formed on the wheels", "Vol II p 94", "how q−p is on wheels at step 5 (earlier pages form it by superposition)")
AXIS_0322 = Gap("the running up turns the running-up axis", "Vol II p 94", "no link from the q−p wheels to the axis is drawn")
MOVEB_0322 = Gap("what moves B when there is no running up", "Vol II p 94", "no arm or part is assigned to the not-running case")
CARRY_0322 = Gap("carriage prevented “in some cases”", "Vol II p 94", "which cases is not said")

EQUAL_0322 = Event("q = p", "Vol II p 94",
                   "the text chooses by running up (q − p = 0 does not run up: “If it do not run up … B into gear”), "
                   "but the drawing labels the cycles “q−p > 0” and “q−p < 0”, and neither covers q = p",
                   ("text: no running up, so Pos.", "undecided"))
NEXT_0322 = Event("the next running up reaches C", "Vol II p 94",
                  "“C on the next running up puts out the cycle Neg”: which quantity runs up, and when, is not said",
                  (True, False))
ENDPOS_0322 = Event("the positive cycle ends", "Vol II p 95",
                    "“The term.n of Pos. or of Neg. Cyc acts jointly …”: what ends the positive cycle is not said",
                    (True, False))
TABLE_0322 = Event("table making ends", "Vol II p 95", "“… jointly with the term.n of table making”", (True, False))


def d0322(q, p, cages=2, events=None):
    """At step 4 A in gear; at step 5 the course is chosen by whether q−p runs up; the cycle chosen ends
    only on a supplied event; the division cycle is put in only when that and table making have ended."""
    wq, wp = wheels(q, cages, "q"), wheels(p, cages, "p")
    r = Run("D-0322 (22 March 1836, pp 94–95)", events)
    r.log("event", "step 4: A thrown into gear", "p 94: “At No 4 throw A into gear”")
    FORM_0322.note(r)
    ran = subtract(wq, wp)
    r.log("state", f"step 5: q−p on the wheels: {value(wq)}{' (ran up)' if ran else ''}", "p 94: “If in 5 q−p runs up”")
    if not ran and q == p:
        if EQUAL_0322.take(r) == "undecided":
            r.log("refused", "q = p left undecided: the model takes no course", "p 94")
            r.outcome = {"cycle": None, "ends by itself": False}
            return r
    if ran:
        AXIS_0322.note(r)
        r.log("event", "A moved: cycle Neg. in gear", "p 94: “A will be moved and cycle Neg. be put in gear”")
        r.log("event", "first vertical of Cycle Neg.: A out, C in", "p 94: “The 1st vert.l of Cycle Neg. puts out A and puts in C”")
        r.log("cycles", "Cycle Neg. runs (its internal schedule is not given)", "p 94")
        cycle, ended = "Neg.", NEXT_0322.take(r)
        if ended:
            r.log("event", "C puts out the cycle Neg.", "p 94: “C on the next running up puts out the cycle Neg”")
    else:
        MOVEB_0322.note(r)
        r.log("event", "A out of gear, B into gear: cycle Pos.", "p 94: “A must be thrown out of gear and B into gear”")
        r.log("cycles", "Cycle Pos. runs (its internal schedule is not given)", "p 95")
        cycle, ended = "Pos.", ENDPOS_0322.take(r)
        if ended:
            r.log("event", "cycle Pos. ends", "p 95")
    if not ended:
        r.log("open", f"cycle {cycle} has not ended: the model does not end it", "p 94–95")
        r.outcome = {"cycle": cycle, "division cycle": False, "ends by itself": False}
        CARRY_0322.note(r)
        return r
    if TABLE_0322.take(r):
        r.log("event", "the real division cycle put in", "p 95: “to put in the real division cycle”")
    else:
        r.log("open", "table making has not ended: the division cycle is not put in", "p 95")
    CARRY_0322.note(r)
    r.outcome = {"cycle": cycle, "division cycle": bool(r.events.get(TABLE_0322.name)), "ends by itself": False}
    return r


# ---------------------------------------------------------------- examples

def show(r):
    print(f"\n{r.design}")
    for kind, what, page in r.trace:
        print(f"  {kind:<9} {what}" + (f"   [{page}]" if page else ""))
    print(f"  outcome   {r.outcome}")


if __name__ == "__main__":
    show(d0301(4, 1))
    show(d0307(3))
    show(d0307(0))
    show(d0322(6, 4, events={ENDPOS_0322.name: True, TABLE_0322.name: True}))
    show(d0322(4, 6, events={NEXT_0322.name: True, TABLE_0322.name: True}))
    show(d0322(5, 5, events={EQUAL_0322.name: "undecided"}))
    for call in (lambda: d0322(4, 6), lambda: d0322(5, 5), lambda: d0307(100), lambda: d0301(3, 4)):
        try:
            call()
        except (NotSpecified, OutOfDomain) as e:
            print(f"\nrefused: {type(e).__name__}: {e}")
