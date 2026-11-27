"""A stateful mechanical simulator of travelling platforms and locking plates.

A HYPOTHESIS, NOT A RECONSTRUCTION. It executes sequences of mechanical
transitions on three kinds of entity, each kept separate:

  Axis            its height, which platform (if any) it is attached to, and
                  whether a locking plate holds it at a fixed point;
  Platform        a travelling platform: its height (0 is its neutral point);
  locking plate   modelled as the axis's `held` state: "locked to a fixed
                  point" (Vol XIII image 89).

Every transition cites the source that describes it. What the sources do not
settle is refused, not filled in:

  - an axis neither attached nor held has no defined motion: moving its
    platform leaves it where it is, but the simulator records the axis as
    `unconstrained`, and any later step that depends on its height is refused;
  - an axis both attached to a moving platform and held at a fixed point is a
    conflict, and the simulator stops;
  - how far a platform moves an attached axis is a parameter of each run
    (Vol XIII, 6 Oct 1835: "to make one platform move axes to various
    [?heights] in same time"), not a property of the platform: by default
    every attached axis moves by the platform's displacement, and a run may
    give an axis its own ratio. The January 1836 lift table of F/013 is one
    configuration, not a law of the platforms.

No arithmetic is modelled: nothing here says what a motion does to a number.

  python3 scripts/mech_sim.py
"""

from dataclasses import dataclass, field

SOURCES = {
    "attach": "Vol XIII image 89 (5 Mar 1835): 'locking axes to travelling platforms'; "
              "image 90: barrels 'bolted the necessary axes to travelling platforms'",
    "raise": "Vol XIII image 90: 'travelling platforms which being raised'; Vol II p 17 (1 Dec 1835): "
             "'Raise travelling platforms'",
    "detach": "Vol XIII image 89: 'it was found necessary to unlock an axis after raising it'",
    "hold": "Vol XIII image 89: 'then to leave it locked to a fixed point for a certain time' (a locking plate)",
    "release": "Vol XIII image 89: 'then to unlock it'",
    "reattach": "Vol XIII image 89: 'and relock it to a travelling platform'",
    "neutral": "Vol II p 17 (1 Dec 1835): 'Travelling platforms to neutral point'",
    "lower": "Vol XIII p 21 (image 12): 'lock and unlock axes … to trav.g platforms at top and … bottom'",
}


class Refused(Exception):
    """A step the sources do not settle."""


@dataclass
class Axis:
    name: str
    height: float = 0.0
    platform: str | None = None
    held: bool = False
    ratio: float = 1.0          # how far it moves per unit of its platform (default 1)
    unconstrained: bool = False


@dataclass
class Machine:
    axes: dict = field(default_factory=dict)
    platforms: dict = field(default_factory=dict)
    trace: list = field(default_factory=list)

    def axis(self, name, ratio=1.0):
        self.axes[name] = Axis(name, ratio=ratio)

    def platform(self, name):
        self.platforms[name] = 0.0

    def _log(self, kind, text):
        state = {a.name: (round(a.height, 3), a.platform, "held" if a.held else "",
                          "unconstrained" if a.unconstrained else "") for a in self.axes.values()}
        self.trace.append((kind, text, SOURCES.get(kind, ""), state, dict(self.platforms)))

    def attach(self, axis, platform, kind="attach"):
        a = self.axes[axis]
        if a.platform:
            raise Refused(f"{axis} is already attached to {a.platform}")
        if a.unconstrained:
            raise Refused(f"{axis}'s height is not known (it was left unconstrained)")
        a.platform = platform
        a.unconstrained = False
        self._log(kind, f"attach {axis} to platform {platform}")

    def detach(self, axis):
        a = self.axes[axis]
        if not a.platform:
            raise Refused(f"{axis} is not attached")
        a.platform = None
        if not a.held:
            a.unconstrained = True
        self._log("detach", f"detach {axis}")

    def hold(self, axis):
        a = self.axes[axis]
        if a.unconstrained:
            raise Refused(f"{axis}'s height is not known: it was detached before it was held")
        a.held = True
        self._log("hold", f"locking plate holds {axis} at {a.height}")

    def release(self, axis):
        a = self.axes[axis]
        if not a.held:
            raise Refused(f"{axis} is not held")
        a.held = False
        if not a.platform:
            a.unconstrained = True
        self._log("release", f"locking plate releases {axis}")

    def move(self, platform, dz, kind="raise"):
        for a in self.axes.values():
            if a.platform == platform and a.held:
                raise Refused(f"{a.name} is attached to {platform} and held at a fixed point: a conflict")
        self.platforms[platform] += dz
        for a in self.axes.values():
            if a.platform == platform:
                a.height += dz * a.ratio
        self._log(kind, f"platform {platform} moves {dz:+}")

    def to_neutral(self, platform):
        self.move(platform, -self.platforms[platform], kind="neutral")


def march_1835():
    """Vol XIII image 89: lock an axis to a travelling platform, raise it,
    unlock it, hold it at a fixed point while the platform moves on, then
    relock it to a travelling platform. The lift and the second platform's
    motion are illustrative numbers; the source gives none."""
    m = Machine()
    m.axis("X")
    m.platform("P1")
    m.platform("P2")
    m.attach("X", "P1")
    m.move("P1", 1.0)
    # The source says: unlock after raising, and leave it locked to a fixed
    # point. Holding before detaching keeps its height defined; the other
    # order would leave it unconstrained for an instant, which no source
    # describes, and is refused (see detach_first below).
    m.hold("X")
    m.detach("X")
    m.to_neutral("P1")          # the platform goes on without the axis
    m.move("P2", 1.0)           # another travelling platform comes to it
    m.attach("X", "P2", kind="reattach")
    m.release("X")
    m.to_neutral("P2")          # the axis moves again, with its new platform
    return m


def detach_first():
    """The same, detaching before holding: refused, since the sources do not
    say where a free axis goes."""
    m = Machine()
    m.axis("X")
    m.platform("P1")
    m.attach("X", "P1")
    m.move("P1", 1.0)
    m.detach("X")
    try:
        m.hold("X")
    except Refused as e:
        return m, str(e)
    return m, None


def conflict():
    m = Machine()
    m.axis("X")
    m.platform("P1")
    m.attach("X", "P1")
    m.hold("X")
    try:
        m.move("P1", 1.0)
    except Refused as e:
        return str(e)
    return None


if __name__ == "__main__":
    m = march_1835()
    print("The March 1835 sequence (Vol XIII image 89), as executed:\n")
    for kind, text, src, state, plats in m.trace:
        x = state["X"]
        print(f"  {text:<38} X height {x[0]:<5} on {x[1] or '-':<4} {x[2]:<5}  platforms {plats}")
        print(f"      source: {src}")
    print("\nDetaching before holding:", detach_first()[1])
    print("Holding while attached to a moving platform:", conflict())
