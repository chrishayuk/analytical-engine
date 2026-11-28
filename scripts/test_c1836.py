"""Tests of scripts/c1836.py: the behaviour stated, the refusals, the domains."""

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import c1836 as c  # noqa: E402

POS_DONE = {c.ENDPOS_0322.name: True, c.TABLE_0322.name: True}
NEG_DONE = {c.NEXT_0322.name: True, c.TABLE_0322.name: True}


class D0301(unittest.TestCase):
    def test_counts(self):
        for q in range(0, 31):
            for d in range(0, q + 1):
                o = c.d0301(q, d).outcome
                self.assertEqual((o["steppings down"], o["steppings up"]), (q, q - d))

    def test_gaps_recorded_never_valued(self):
        r = c.d0301(4, 1)
        self.assertEqual(r.gaps, [c.SET_0301.name, c.ARM_0301.name, c.END_0301.name])
        self.assertEqual(r.supplied, [])

    def test_domain(self):
        for q, d in ((3, 4), (-1, 0), (31, 0), (2.5, 0), (True, 0)):
            with self.assertRaises(c.OutOfDomain):
                c.d0301(q, d)


class D0307(unittest.TestCase):
    def test_n_operations_then_running_up(self):
        for n in range(0, 100):
            self.assertEqual(c.d0307(n).outcome["operations"], n)
        self.assertEqual(c.d0307(345, cages=3).outcome["operations"], 345)

    def test_capacity_and_domain(self):
        for n in (100, -1, 1.0, "3"):
            with self.assertRaises(c.OutOfDomain):
                c.d0307(n)


class D0322(unittest.TestCase):
    def test_course_by_running_up(self):
        for q in range(0, 30):
            for p in range(0, 30):
                if q == p:
                    continue
                r = c.d0322(q, p, events=NEG_DONE if q < p else POS_DONE)
                self.assertEqual(r.outcome["cycle"], "Neg." if q < p else "Pos.")
                self.assertTrue(r.outcome["division cycle"])
                self.assertFalse(r.outcome["ends by itself"])

    def test_refuses_without_the_next_running_up(self):
        with self.assertRaises(c.NotSpecified):
            c.d0322(4, 6, events={c.TABLE_0322.name: True})

    def test_refuses_without_the_end_of_pos(self):
        with self.assertRaises(c.NotSpecified):
            c.d0322(6, 4, events={c.TABLE_0322.name: True})

    def test_refuses_without_table_making(self):
        with self.assertRaises(c.NotSpecified):
            c.d0322(6, 4, events={c.ENDPOS_0322.name: True})

    def test_cycle_left_open_is_not_ended(self):
        r = c.d0322(4, 6, events={c.NEXT_0322.name: False})
        self.assertEqual(r.outcome, {"cycle": "Neg.", "division cycle": False, "ends by itself": False})

    def test_equality_is_not_decided_silently(self):
        with self.assertRaises(c.NotSpecified):
            c.d0322(5, 5, events=POS_DONE)
        self.assertIsNone(c.d0322(5, 5, events={c.EQUAL_0322.name: "undecided"}).outcome["cycle"])
        r = c.d0322(5, 5, events={c.EQUAL_0322.name: "text: no running up, so Pos.", **POS_DONE})
        self.assertEqual(r.outcome["cycle"], "Pos.")
        self.assertIn(c.EQUAL_0322.name, r.supplied)

    def test_no_numbered_verticals(self):
        r = c.d0322(4, 6, events=NEG_DONE)
        self.assertFalse(any("vertical 2" in w for _, w, _ in r.trace))

    def test_supplied_values_checked(self):
        with self.assertRaises(c.OutOfDomain):
            c.d0322(4, 6, events={c.NEXT_0322.name: "soon", c.TABLE_0322.name: True})

    def test_domain(self):
        for q, p in ((100, 1), (-1, 2), (1.5, 1)):
            with self.assertRaises(c.OutOfDomain):
                c.d0322(q, p)


if __name__ == "__main__":
    unittest.main()
