//! Lovelace's Note G table (1843) on the control machine (src/sketch.rs):
//! the deck as printed, and with the three corrections of
//! sources/notes/note-g-table.md §6.

use babbage::sketch::{accepts, expected, read, run, Deck, Outcome, CONFIGS};

const PRINTED: &str = include_str!("../control/note-g-printed.txt");
const CORRECTED: &str = include_str!("../control/note-g-corrected.txt");

fn config(key: &str) -> &'static babbage::sketch::Config {
    CONFIGS.iter().find(|c| c.key == key).unwrap()
}

fn go(d: &Deck) -> Outcome {
    run(config("1843"), d).unwrap()
}

fn col(o: &Outcome, c: usize) -> String {
    o.store.get(&c).map(|v| v.to_string()).unwrap_or_else(|| "0".into())
}

/// The deck with other data: replace whole lines (`from` must occur once).
fn edit(text: &str, swaps: &[(&str, &str)]) -> Deck {
    let mut t = text.to_string();
    for (from, to) in swaps {
        assert_eq!(t.matches(from).count(), 1, "{from}");
        t = t.replace(from, to);
    }
    read(&t).unwrap()
}

/// Only the configuration of the published accounts has the backing made
/// effective by a result of the mill (Operation 23's test on V10).
#[test]
fn only_1843_accepts_note_g() {
    for text in [PRINTED, CORRECTED] {
        let d = read(text).unwrap();
        let ok: Vec<_> = CONFIGS
            .iter()
            .filter(|c| accepts(c, &d).is_ok())
            .map(|c| c.key)
            .collect();
        assert_eq!(ok, ["1843"], "{}", d.name);
        for c in CONFIGS.iter().filter(|c| c.key != "1843") {
            assert!(accepts(c, &d)
                .unwrap_err()
                .contains("a backing made effective by a result of the mill"));
        }
    }
}

/// As printed (Operation 4 = V5 ÷ V4, Operation 21 reading V22 on both
/// passes, Operation 24 adding): V24 = −95/126, not B7 = −1/30.
#[test]
fn printed_gives_minus_95_over_126() {
    let d = read(PRINTED).unwrap();
    let o = go(&d);
    assert!(o.halted);
    assert_eq!(expected(&d, &o), Vec::<String>::new());
    assert_eq!(col(&o, 24), "-95/126");
    assert_eq!(col(&o, 10), "0");
    // 13…23 twice: one backing.
    assert_eq!(o.backings, 1);
    // Operation 25 has made V3 = n + 1, and the zeroing cards have left
    // V4–V9, V12, V13 at zero, as the table's indications say.
    assert_eq!(col(&o, 3), "5");
    for c in [4, 5, 6, 7, 8, 9, 12, 13] {
        assert_eq!(col(&o, c), "0", "v{c}");
    }
}

/// Each correction alone and together (note §6, table of results).
#[test]
fn corrections_one_by_one() {
    let op4 = ("÷ v5 v4 > v11", "÷ v4 v5 > v11");
    let op24 = ("+ v13 v24 > v24", "- v24 v13 > v24");
    assert_eq!(col(&go(&edit(PRINTED, &[op4])), 24), "-1/2");
    assert_eq!(col(&go(&edit(PRINTED, &[op4, op24])), 24), "1/2");
    // Corrections 1 and 2 without 3: the magnitude, with the sign of −B7.
    let no3 = edit(
        CORRECTED,
        &[
            ("- v24 v13 > v24", "+ v13 v24 > v24"),
            ("Expect column v24 = -1/30", ""),
        ],
    );
    assert_eq!(col(&go(&no3), 24), "1/30");
}

/// Corrected: B7 = −1/30 (modern B8), the cycle 13…23 run twice.
#[test]
fn corrected_gives_b7() {
    let d = read(CORRECTED).unwrap();
    let o = go(&d);
    assert!(o.halted);
    assert_eq!(expected(&d, &o), Vec::<String>::new());
    assert_eq!(col(&o, 24), "-1/30");
    assert_eq!(o.backings, 1);
}

const STORE4: &str = "Store v1 = 1, v2 = 2, v3 = 4, v21 = 1/6, v22 = -1/30, v23 = 1/42";

/// n = 5: B9 = 5/66 (modern B10) on V25, the cycle run three times (two
/// backings: n − 2 passes, "Σ(+1)ⁿ⁻²(13…23)"). n = 3: B5 = 1/42, one pass,
/// no backing.
#[test]
fn corrected_n5_and_n3() {
    let n5 = edit(
        CORRECTED,
        &[
            (
                STORE4,
                "Store v1 = 1, v2 = 2, v3 = 5, v21 = 1/6, v22 = -1/30, v23 = 1/42, v24 = -1/30",
            ),
            ("- v24 v13 > v24", "- v25 v13 > v25"),
            ("Expect column v24 = -1/30", "Expect column v25 = 5/66"),
        ],
    );
    let o = go(&n5);
    assert_eq!(expected(&n5, &o), Vec::<String>::new());
    assert_eq!(col(&o, 25), "5/66");
    assert_eq!(col(&o, 24), "-1/30");
    assert_eq!(o.backings, 2);

    let n3 = edit(
        CORRECTED,
        &[
            (STORE4, "Store v1 = 1, v2 = 2, v3 = 3, v21 = 1/6, v22 = -1/30"),
            ("- v24 v13 > v24", "- v23 v13 > v23"),
            ("Expect column v24 = -1/30", "Expect column v23 = 1/42"),
        ],
    );
    let o = go(&n3);
    assert_eq!(expected(&n3, &o), Vec::<String>::new());
    assert_eq!(o.backings, 0);

    // As printed, n = 5 reuses B3 on every pass and gives −241/90.
    let p5 = edit(
        PRINTED,
        &[
            (
                STORE4,
                "Store v1 = 1, v2 = 2, v3 = 5, v21 = 1/6, v22 = -1/30, v23 = 1/42, v24 = -1/30",
            ),
            ("+ v13 v24 > v24", "+ v13 v25 > v25"),
        ],
    );
    let o = go(&p5);
    assert_eq!(col(&o, 25), "-241/90");
    assert_eq!(o.backings, 2);
}

/// n = 1, 2: the forward course of Operations 7 and 12 cannot be expressed,
/// so the deck goes on through 8…23. The values still come out (the extra
/// terms multiply a column still at zero), but V10 ends below zero, which
/// the text's course never produces.
#[test]
fn corrected_n1_n2_fall_through() {
    let n1 = edit(
        CORRECTED,
        &[
            (STORE4, "Store v1 = 1, v2 = 2, v3 = 1"),
            ("- v24 v13 > v24", "- v21 v13 > v21"),
            ("Expect column v24 = -1/30", ""),
        ],
    );
    let o = go(&n1);
    assert_eq!(col(&o, 21), "1/6");
    assert_eq!(col(&o, 10), "-2");
    let n2 = edit(
        CORRECTED,
        &[
            (STORE4, "Store v1 = 1, v2 = 2, v3 = 2, v21 = 1/6"),
            ("- v24 v13 > v24", "- v22 v13 > v22"),
            ("Expect column v24 = -1/30", ""),
        ],
    );
    let o = go(&n2);
    assert_eq!(col(&o, 22), "-1/30");
    assert_eq!(col(&o, 10), "-1");
}

// Reading B (menabrea-lovelace-1843-control.md §8): the repetition of
// 13…23 is a counted backing of count n − 2, set from Operation 12's result
// on V10, and the zero test on V10 at Operations 7 and 12 chooses a forward
// course to Operation 24 (sources/notes/note-g-table.md, "Reading B deck").

const READING_B: &str = include_str!("../control/note-g-reading-b.txt");

fn go_b(d: &Deck) -> Outcome {
    run(config("1843-B"), d).unwrap()
}

/// The Reading B deck for n, with Operation 24's result column moved to
/// V(20 + n) and B1 … B(2n−3) as data, as in the tests above.
fn reading_b(n: usize) -> Deck {
    let stores = [
        "Store v1 = 1, v2 = 2, v3 = 1",
        "Store v1 = 1, v2 = 2, v3 = 2, v21 = 1/6",
        "Store v1 = 1, v2 = 2, v3 = 3, v21 = 1/6, v22 = -1/30",
        STORE4,
        "Store v1 = 1, v2 = 2, v3 = 5, v21 = 1/6, v22 = -1/30, v23 = 1/42, v24 = -1/30",
    ];
    if n == 4 {
        return read(READING_B).unwrap();
    }
    let c = 20 + n;
    edit(
        READING_B,
        &[
            (STORE4, stores[n - 1]),
            ("- v24 v13 > v24", &format!("- v{c} v13 > v{c}")),
            ("Expect column v24 = -1/30", ""),
        ],
    )
}

/// Only 1843-B accepts it: the other configurations have no forward course
/// chosen by a result of the mill, and refuse at the card after Operation 7.
#[test]
fn only_1843_b_accepts_reading_b() {
    let d = read(READING_B).unwrap();
    let ok: Vec<_> = CONFIGS
        .iter()
        .filter(|c| accepts(c, &d).is_ok())
        .map(|c| c.key)
        .collect();
    assert_eq!(ok, ["1843-B"]);
    for c in CONFIGS.iter().filter(|c| c.key != "1843-B") {
        assert!(accepts(c, &d)
            .unwrap_err()
            .contains("card 11: a forward course chosen by a result of the mill"));
    }
}

/// n = 4: B7 = −1/30, the group passed twice (n − 2: two subtractions from
/// the wheels, one backing), V10 = 0 at the end. Three cards more than the
/// Reading A deck: two forward courses and the combinatorial card.
#[test]
fn reading_b_gives_b7() {
    let d = read(READING_B).unwrap();
    let o = go_b(&d);
    assert!(o.halted);
    assert_eq!(expected(&d, &o), Vec::<String>::new());
    assert_eq!(col(&o, 24), "-1/30");
    assert_eq!(col(&o, 10), "0");
    assert_eq!(col(&o, 3), "5");
    assert_eq!(o.wheel_steps, 2);
    assert_eq!(o.backings, 1);
    assert_eq!(o.cards, 63);
    assert_eq!(go(&read(CORRECTED).unwrap()).cards, 60);
}

/// n = 1 … 5: the right Number each time, V10 ends at 0 (under Reading A,
/// n = 1, 2 end at −2, −1), and the group passes n − 2 times for n ≥ 3.
/// n = 1 and n = 2 take the forward course to Operation 24 and never reach
/// the combinatorial card.
#[test]
fn reading_b_n1_to_n5() {
    // (n, B(2n−1), cards, passes of 13…23)
    for (n, b, cards, passes) in [
        (1, "1/6", 16, 0),
        (2, "-1/30", 23, 0),
        (3, "1/42", 45, 1),
        (4, "-1/30", 63, 2),
        (5, "5/66", 81, 3),
    ] {
        let o = go_b(&reading_b(n));
        assert!(o.halted, "n = {n}");
        assert_eq!(col(&o, 20 + n), b, "n = {n}");
        assert_eq!(col(&o, 10), "0", "n = {n}");
        assert_eq!(col(&o, 3), (n + 1).to_string(), "n = {n}");
        assert_eq!(o.cards, cards, "n = {n}");
        assert_eq!(o.wheel_steps, passes, "n = {n}");
        assert_eq!(o.backings, passes.saturating_sub(1), "n = {n}");
    }
}

/// Without the forward courses: n = 2 would put a count of 0 on the wheels,
/// and n = 1 a count of −1 (rule 13: an error). For n ≥ 3 the deck without
/// them is a deck of 30 May 1838: a counted backing set from a computed
/// number is all it needs.
#[test]
fn reading_b_needs_the_forward_courses() {
    let strip = |d: &str| -> String {
        d.lines()
            .filter(|l| !l.starts_with("ahead "))
            .map(|l| format!("{l}\n"))
            .collect()
    };
    let d = read(&strip(READING_B)).unwrap();
    assert!(accepts(config("1838-05"), &d).is_ok());
    assert!(accepts(config("1837-12"), &d)
        .unwrap_err()
        .contains("backing to `op13`"));
    let o = run(config("1838-05"), &d).unwrap();
    assert_eq!(col(&o, 24), "-1/30");
    for (n, count) in [(1, "-1"), (2, "0")] {
        let text = strip(READING_B).replace(STORE4, &format!("Store v1 = 1, v2 = 2, v3 = {n}"));
        let e = run(config("1843-B"), &read(&text).unwrap()).err().unwrap();
        assert!(e.contains(&format!("a count of {count}")), "{e}");
    }
}

/// A forward course on Operation 23's result as well (not in the deck):
/// the same B7, but the last pass leaves by that course and never reaches
/// the backing card, so the wheels are left at 1 and the count is not what
/// ends the cycle. Under Reading B the deck therefore has no card for
/// Operation 23's test.
#[test]
fn reading_b_test_at_23_would_bypass_the_count() {
    let d = edit(
        READING_B,
        &[(
            "% (Operation 23's test: under Reading B",
            "ahead op24 if v10 zero\n% (Operation 23's test: under Reading B",
        )],
    );
    let o = go_b(&d);
    assert_eq!(col(&o, 24), "-1/30");
    assert_eq!(o.wheel_steps, 1);
    assert_eq!(o.backings, 1);
}
