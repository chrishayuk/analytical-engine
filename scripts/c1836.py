"""Arithmetic-dependent control in the mill, February-March 1836: three dated
designs, each as an abstract model of the behaviour Babbage writes down.

BEHAVIOUR, NOT MECHANISM. Each model executes only what its page states, with
the page quoted at every transition. Where the page names an effect but not
the part that produces it, or leaves a trigger unnamed, the model stops at an
explicit Interface: a run must supply that interface's outcome by name, and
the trace records that it was supplied, not derived. Nothing here invents a
linkage. Sources: sources/notes/running-up-designs-1836.md (sections 4, 8, 13)
and docs/control-flow.md.

  D-0301  1 March 1836, Vol II p 76: a counting wheel's stop ends one cycle and
          throws in another.
  D-0307  7 March 1836, Vol II p 84: a count put on an axis, unity subtracted
          before each operation; a running up suspends the operation.
  D-0322  22 March 1836, Vol II pp 94-95: whether q-p runs up chooses the
          negative or the positive cycle; C, on the next running up, ends the
          negative cycle.

Counters are wheels turned one tooth at a time, with borrow, as in
scripts/f_control.py; a running up is the top wheel passing from 0 to 9.

  python3 scripts/c1836.py            run the three designs on example cases
"""

import sys


class NotSpecified(Exception):
    """A run reached an interface whose outcome it did not supply."""


class Interface:
    """Something the page needs and does not show. Its outcome must be given."""

    def __init__(self, name, page, says, missing):
        self.name, self.page, self.says, self.missing = name, page, says, missing

    def consult(self, run, *key):
        k = (self.name,) + key
        if k not in run.given:
            raise NotSpecified(f"{self.name}{key}: {self.missing} ({self.page})")
        run.log("interface", f"{self.name}{key if key else ''} = {run.given[k]!r} (supplied: {self.missing})",
                self.page)
        return run.given[k]


class Run:
    def __init__(self, design, given=None):
        self.design, self.given, self.trace = design, given or {}, []

    def log(self, kind, what, page=""):
        self.trace.append((kind, what, page))


# ---------------------------------------------------------------- counters as wheels

def wheels(n, cages):
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
    """Subtract a number tooth by tooth (unity, other times over, cage by cage with borrow).
    True if the result ran up at any point. Used only where the page has a difference formed."""
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

ARM_0301 = Interface("arm thrown in by the stop of q", "Vol II p 76",
                     "the stop of the count.g wh. q throws an arm in which … throws in on the barrel of the product "
                     "axis the cycle for stepping up",
                     "no drawing: how the arm reaches the gathering-up teeth and the barrel")
END_0301 = Interface("q−d throws out Mult.n", "Vol II p 76", "the count.g wh. q−d determines the number of "
                     "steppings up. This throws out Mult.n", "how the count ends Mult.n is not said")
SET_0301 = Interface("q and q−d set", "Vol II pp 75–76", "p was previously thrown out of gear with p−d and q out "
                     "of gear with q−d", "how the digit counts reach the wheels (the spiral axis of pp 72–75)")


def d0301(q, d, given=None):
    """Steppings down counted by wheel q until its stop; then steppings up counted by q−d."""
    r = Run("D-0301 (1 March 1836, p 76)", given)
    SET_0301.consult(r)
    r.log("state", f"counting wheel q set to {q}, q−d to {q - d}", "p 76")
    r.log("event", "table finished: gathering-up tooth on q, Mult.n cycle in gear", "p 76: “Table being finished throws into gear …”")
    for i in range(q):
        r.log("cycle", f"stepping down {i + 1}", "p 76: q “determines the No. of steppings down”")
    r.log("event", "stop of q reached", "p 76")
    ARM_0301.consult(r)
    r.log("event", "gathering out of q, into q−d; stepping-up cycle in on the product barrel", "p 76")
    for i in range(q - d):
        r.log("cycle", f"stepping up {i + 1}", "p 76: q−d “determines the number of steppings up”")
    END_0301.consult(r)
    r.log("event", "Mult.n thrown out", "p 76")
    return r


# ---------------------------------------------------------------- 7 March 1836, p 84

PUT_0307 = Interface("count put on the axis", "Vol II p 84", "let the number of rep.ns be put on an axis having a "
                     "carriage connected with it", "where the number comes from (the page does not say)")
SUSPEND_0307 = Interface("what the running up suspends", "Vol II p 84", "a running up will take place at end and "
                         "thus the op.n be suspended", "no barrel, lever, lock or card is named")


def d0307(n, cages=2, given=None):
    """Unity subtracted before each operation; the operation is suspended at the running up."""
    r = Run("D-0307 (7 March 1836, p 84)", given)
    PUT_0307.consult(r)
    w = wheels(n, cages)
    r.log("state", f"count {value(w)} on an axis with a carriage", "p 84")
    k = 0
    while True:
        if subtract_unity(w):
            r.log("event", f"running up (axis now {value(w)})", "p 84: “a running up will take place at end”")
            SUSPEND_0307.consult(r)
            r.log("event", "operation suspended", "p 84")
            break
        k += 1
        r.log("cycle", f"operation {k} (axis {value(w)} after unity subtracted)", "p 84: “subtr.g unity previous each operation”")
    return r


# ---------------------------------------------------------------- 22 March 1836, pp 94-95

FORM_0322 = Interface("q−p formed on the wheels", "Vol II p 94", "If in 5 q−p runs up",
                      "how q−p comes to be on wheels at step 5 (earlier pages form it by superposition)")
AXIS_0322 = Interface("running up turns the running-up axis", "Vol II p 94",
                      "drawing: a “running up axis” with three arms over barrels B, A, C",
                      "no link from the q−p wheels to the axis is drawn")
NORUN_0322 = Interface("what moves B when q−p does not run up", "Vol II p 94",
                       "If it do not run up then A must be thrown out of gear and B into gear",
                       "no arm or part is assigned to the not-running case")
NEXT_0322 = Interface("the next running up", "Vol II p 94", "C on the next running up puts out the cycle Neg",
                      "which quantity runs up next, and when, is not said")
ENDPOS_0322 = Interface("the end of the positive cycle", "Vol II p 95",
                        "The term.n of Pos. or of Neg. Cyc acts jointly with the term.n of table making",
                        "what ends the positive cycle is not said")
TABLE_0322 = Interface("the end of table making", "Vol II p 95", "acts jointly with the term.n of table making",
                       "table making is not modelled here")


def d0322(q, p, cages=2, given=None):
    """At step 4 A in gear; at step 5, if q−p runs up, the negative cycle, else the positive; C ends Neg
    on the next running up; the end of either cycle, with the end of table making, puts in division."""
    r = Run("D-0322 (22 March 1836, pp 94–95)", given)
    r.log("event", "step 4: A thrown into gear", "p 94: “At No 4 throw A into gear”")
    FORM_0322.consult(r)
    w = wheels(q, cages)
    ran = subtract(w, wheels(p, cages))
    r.log("state", f"step 5: q−p on the wheels: {value(w)}{' (ran up)' if ran else ''}", "p 94: “If in 5 q−p runs up”")
    if ran:
        AXIS_0322.consult(r)
        r.log("event", "A moved: cycle Neg. in gear", "p 94: “A will be moved and cycle Neg. be put in gear”")
        r.log("event", "1st vertical of Cycle Neg.: A out, C in", "p 94: “The 1st vert.l of Cycle Neg. puts out A and puts in C”")
        v = 1
        while True:
            v += 1
            r.log("cycle", f"Cycle Neg. vertical {v}", "p 94")
            if NEXT_0322.consult(r, v):
                r.log("event", "C puts out the cycle Neg.", "p 94: “C on the next running up puts out the cycle Neg”")
                break
    else:
        NORUN_0322.consult(r)
        r.log("event", "A out of gear, B into gear: cycle Pos.", "p 94: “A must be thrown out of gear and B into gear”")
        ENDPOS_0322.consult(r)
        r.log("event", "cycle Pos. ends", "p 95")
    TABLE_0322.consult(r)
    r.log("event", "the real division cycle put in", "p 95: “to put in the real division cycle”")
    r.log("note", "not modelled: “Carriage is in some cases to be prevented when running up occurs and the lowest "
          "wheel put back to 0” (which cases is not said)", "p 94")
    return r


# ---------------------------------------------------------------- examples

def supply(*names, **keyed):
    g = {(n,): "as the page states" for n in names}
    g.update(keyed.get("extra", {}))
    return g


def show(r):
    print(f"\n{r.design}")
    for kind, what, page in r.trace:
        print(f"  {kind:<9} {what}" + (f"   [{page}]" if page else ""))


if __name__ == "__main__":
    show(d0301(4, 1, supply(SET_0301.name, ARM_0301.name, END_0301.name)))
    show(d0307(3, given=supply(PUT_0307.name, SUSPEND_0307.name)))
    show(d0307(0, given=supply(PUT_0307.name, SUSPEND_0307.name)))
    show(d0322(6, 4, given=supply(FORM_0322.name, NORUN_0322.name, ENDPOS_0322.name, TABLE_0322.name)))
    neg = supply(FORM_0322.name, AXIS_0322.name, TABLE_0322.name,
                 extra={(NEXT_0322.name, 2): False, (NEXT_0322.name, 3): False, (NEXT_0322.name, 4): True})
    show(d0322(4, 6, given=neg))
    try:
        d0322(4, 6, given=supply(FORM_0322.name, AXIS_0322.name, TABLE_0322.name))
    except NotSpecified as e:
        print(f"\nWithout the next running up supplied, D-0322 stops: {e}")
