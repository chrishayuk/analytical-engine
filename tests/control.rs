//! The control machine of the Sketch Books (src/sketch.rs): which decks each
//! dated configuration accepts, what they compute, and the L/023 comparison.

use babbage::sketch::{accepts, expected, read, run, Config, Deck, CONFIGS, DECKS};

fn deck(name: &str) -> Deck {
    read(DECKS.iter().find(|d| d.0 == name).unwrap().1).unwrap()
}

fn config(key: &str) -> &'static Config {
    CONFIGS.iter().find(|c| c.key == key).unwrap()
}

/// The first configuration, by date, that accepts each deck; and every
/// accepting configuration gets what the deck expects.
#[test]
fn which_configurations_accept_which_decks() {
    let first = |name: &str| {
        let d = deck(name);
        CONFIGS.iter().find(|c| accepts(c, &d).is_ok()).map(|c| c.key)
    };
    let want = [
        ("multiply-1836", "1836-03"),
        ("multiply-1837", "1837-12"),
        ("sum-1837", "1837-12"),
        ("factorial-1837", "1837-12"),
        ("L023-1837", "1837-12"),
        ("L023-sheet", "1838-05"),
        ("collatz-table", "1837-12"),
        ("tower-table", "1837-12"),
        ("product-halting", "not-found"),
        ("collatz-halting", "not-found"),
        ("maximum", "not-found"),
        ("gcd", "not-found"),
        // Refutes argument C as first written: the repetition count is read
        // from the store (formal/Babbage/Tower.lean proves it for every n).
        ("tower-halting", "1837-12"),
    ];
    assert_eq!(want.len(), DECKS.len());
    for (name, key) in want {
        assert_eq!(first(name), Some(key), "{name}");
    }
    for (name, text) in DECKS {
        let d = read(text).unwrap();
        for c in CONFIGS.iter().filter(|c| accepts(c, &d).is_ok()) {
            let o = run(c, &d).unwrap_or_else(|e| panic!("{name} under {}: {e}", c.key));
            assert_eq!(expected(&d, &o), Vec::<String>::new(), "{name} under {}", c.key);
        }
    }
    // Only the configuration labelled as not found accepts a combinatorial
    // card inside the group it counts.
    assert!(CONFIGS.iter().filter(|c| c.set_in_group).all(|c| !c.found));
}

/// L/023 run two ways: by the interpreter of its table (the counter a store
/// column, counted down by a mill subtraction) and by this machine (the
/// count on the combinatorial wheels). The same four coefficients; the mill
/// subtractions of the table become subtractions of unity on the wheels.
#[test]
fn l023_two_ways() {
    use babbage::corpus::PAGES;
    let page = PAGES.iter().find(|p| p.0 == "L023").unwrap().1;
    let table = babbage::loops::run(&babbage::page::read("", page).unwrap());
    for name in ["L023-sheet", "L023-1837"] {
        let d = deck(name);
        let o = run(config("1838-05"), &d).unwrap();
        for k in 0..4 {
            assert!(o.results[k].same(&table.results[&format!("c{k}")]), "{name} c{k}");
        }
        // For coefficients 1 to 4: 1 + 2 + 3 + 4 products, and as many
        // subtractions of unity from the wheels; no mill subtraction.
        assert_eq!(o.mill.get(&'×'), Some(&10));
        assert_eq!(o.mill.get(&'−'), None);
        assert_eq!(o.wheel_steps, 10);
    }
}

/// Mutations: the machine must refuse what the pages do not give, and fail
/// rather than make up a count.
#[test]
fn control_mutations() {
    let text = DECKS.iter().find(|d| d.0 == "L023-1837").unwrap().1;
    // Moving the combinatorial card into the repeated group is refused by
    // every configuration found.
    let moved = text.replace("formula:\n", "formula:\nset v2\n");
    let d = read(&moved).unwrap();
    for c in CONFIGS.iter().filter(|c| c.found) {
        assert!(accepts(c, &d).is_err(), "{}", c.key);
    }
    // A count of 0 is an error, not a pass.
    let zero = read(&text.replace("Wheels 1", "Wheels 0")).unwrap();
    assert!(run(config("1837-12"), &zero).is_err());
    // A negative count on the wheels is refused, not run on (found by review).
    let neg = read("Store v1 = 0\nWheels -1\nCards\na:\n+ v1 1 > v1\nback a counted\nresult v1\n").unwrap();
    assert!(run(config("1837-12"), &neg).is_err());
    let set0 = read(&text.replace("set v2", "set 0")).unwrap();
    assert!(run(config("1837-12"), &set0).is_err());
    // No number on the wheels when a counted backing is reached.
    let none = read(&text.replace("Wheels 1\n", "")).unwrap();
    assert!(run(config("1837-12"), &none).is_err());
    // A backing to a card ahead is not a backing.
    assert!(read("Store v1 = 0\nCards\n+ v1 1 > v1\nback end always\nend:\nresult v1\n").is_err());
    // A wrong expectation is caught.
    let wrong = read(&text.replace("Ab + Ba", "Ab + Bb")).unwrap();
    let o = run(config("1837-12"), &wrong).unwrap();
    assert_eq!(expected(&wrong, &o).len(), 1);
    // Numbers too large for the machine are an error, not wrapped.
    let tower = DECKS.iter().find(|d| d.0 == "tower-table").unwrap().1;
    let five = read(&tower.replace("Stop 4 results", "Stop 5 results")).unwrap();
    assert!(run(config("1837-12"), &five).is_err());
}

/// Counter machines translated into decks (src/minsky.rs) and run under the
/// configuration labelled as not found: the same counters as the machine run
/// directly. Every configuration of the pages refuses the decks. A test on
/// these machines, not a proof that the translation is correct for all.
#[test]
fn counter_machines_under_not_found() {
    use babbage::minsky::{compile, simulate, Ins};
    let add = [Ins::Dec(1, 1, 2), Ins::Inc(0, 0), Ins::Halt];
    let mul = [
        Ins::Dec(0, 1, 6),
        Ins::Dec(1, 2, 4),
        Ins::Inc(2, 3),
        Ins::Inc(3, 1),
        Ins::Dec(3, 5, 0),
        Ins::Inc(1, 4),
        Ins::Halt,
    ];
    let cases: [(&str, &[Ins], Vec<i64>); 6] = [
        ("add", &add, vec![3, 4]),
        ("add", &add, vec![0, 0]),
        ("add", &add, vec![5, 0]),
        ("mul", &mul, vec![3, 4, 0, 0]),
        ("mul", &mul, vec![0, 7, 0, 0]),
        ("mul", &mul, vec![6, 1, 0, 0]),
    ];
    for (name, prog, regs) in cases {
        let want = simulate(prog, &regs, 10_000).unwrap();
        let d = read(&compile(name, prog, &regs)).unwrap();
        for c in CONFIGS.iter().filter(|c| c.found) {
            assert!(accepts(c, &d).is_err(), "{name} under {}", c.key);
        }
        let o = run(config("not-found"), &d).unwrap();
        assert!(o.halted, "{name} {regs:?}");
        let got: Vec<String> = o.results.iter().map(|v| v.to_string()).collect();
        let want: Vec<String> = want.iter().map(|v| v.to_string()).collect();
        assert_eq!(got, want, "{name} {regs:?}");
    }
}

/// Model D (`formal/Babbage/Trap.lean`): the same machines, translated with a
/// trap at the end of each pass and an unconditional backing card. The 1838
/// deck is accepted by 30 May 1838 and refused by December 1837; the 1837
/// deck, whose flags are repeated operations with counts from the store, is
/// accepted by both. Each stops at its trap with the machine's counters in
/// the store, and without `Trap halts` it is an error; a machine that never
/// halts gives a deck that runs on.
#[test]
fn counter_machines_with_a_trap() {
    use babbage::minsky::Ins;
    use babbage::minsky::{compile_with, simulate, Ending, Layout};
    use babbage::sketch::run_model;
    let add = [Ins::Dec(1, 1, 2), Ins::Inc(0, 0), Ins::Halt];
    let mul = [
        Ins::Dec(0, 1, 6),
        Ins::Dec(1, 2, 4),
        Ins::Inc(2, 3),
        Ins::Inc(3, 1),
        Ins::Dec(3, 5, 0),
        Ins::Inc(1, 4),
        Ins::Halt,
    ];
    let cases: [(&str, &[Ins], Vec<i64>); 5] = [
        ("add", &add, vec![3, 4]),
        ("add", &add, vec![0, 0]),
        ("mul", &mul, vec![3, 4, 0, 0]),
        ("mul", &mul, vec![0, 7, 0, 0]),
        ("mul", &mul, vec![6, 1, 0, 0]),
    ];
    for (name, prog, regs) in cases {
        let want = simulate(prog, &regs, 10_000).unwrap();
        let l = Layout {
            k: regs.len(),
            n: prog.len(),
        };
        for (ending, ok, refused) in [
            (
                Ending::Trap1838,
                &["1838-05", "not-found"][..],
                &["1836-03", "1837-12"][..],
            ),
            (
                Ending::Trap1837,
                &["1837-12", "1838-05", "not-found"][..],
                &["1836-03"][..],
            ),
        ] {
            let d = read(&compile_with(name, prog, &regs, ending)).unwrap();
            assert!(d.trap);
            for k in refused {
                assert!(accepts(config(k), &d).is_err(), "{name} {ending:?} under {k}");
            }
            for k in ok {
                let o = run(config(k), &d).unwrap_or_else(|e| panic!("{name} {ending:?} under {k}: {e}"));
                assert!(!o.halted && o.trapped.is_some(), "{name} {regs:?} {ending:?} under {k}");
                for (r, w) in want.iter().enumerate() {
                    let got = o.store.get(&l.c(r)).map(|v| v.to_string()).unwrap_or("0".into());
                    assert_eq!(got, w.to_string(), "{name} {regs:?} {ending:?} counter {r}");
                }
                // Without the trap read as the end, the same stop is an error.
                assert!(run_model(config(k), &d, false).is_err());
            }
        }
    }
    // A machine that never halts: the deck runs on until the observer stops it.
    let forever = [Ins::Inc(0, 0)];
    for ending in [Ending::Trap1838, Ending::Trap1837] {
        let text = compile_with("forever", &forever, &[0], ending).replace("Cards\n", "Stop 5000 cards\nCards\n");
        let o = run(config("1838-05"), &read(&text).unwrap()).unwrap();
        assert!(o.trapped.is_none() && !o.halted && o.stopped.is_some());
    }
}

/// The JSON the notebook's explorer reads (`babbage control run -`).
#[test]
fn report_json_for_the_notebook() {
    use babbage::sketch::report_json;
    let d = read(include_str!("../control/tower-halting.txt")).unwrap();
    let mut out = String::new();
    report_json(&d, None).write(&mut out);
    assert!(
        out.contains(r#""config":"1836-03","date":"March 1836","found":true,"accepted":false"#),
        "{out}"
    );
    assert!(out.contains(r#""config":"1837-12","date":"December 1837","found":true,"accepted":true,"status":"halts","results":["65536"]"#), "{out}");
}

/// The configuration of the published accounts (1842–1843): a backing made
/// effective while a result of the mill is greater than zero (Note G). The
/// counter machines translate with nothing else: no combinatorial card, no
/// counted backing, no repetition count, and the deck halts by passing its
/// last card, giving off the counters. Every earlier configuration refuses it.
#[test]
fn counter_machines_in_1843() {
    use babbage::minsky::{compile_with, simulate, Ending, Ins};
    let add = [Ins::Dec(1, 1, 2), Ins::Inc(0, 0), Ins::Halt];
    let mul = [
        Ins::Dec(0, 1, 6),
        Ins::Dec(1, 2, 4),
        Ins::Inc(2, 3),
        Ins::Inc(3, 1),
        Ins::Dec(3, 5, 0),
        Ins::Inc(1, 4),
        Ins::Halt,
    ];
    let cases: [(&str, &[Ins], Vec<i64>); 5] = [
        ("add", &add, vec![3, 4]),
        ("add", &add, vec![0, 0]),
        ("mul", &mul, vec![3, 4, 0, 0]),
        ("mul", &mul, vec![0, 7, 0, 0]),
        ("mul", &mul, vec![6, 1, 0, 0]),
    ];
    for (name, prog, regs) in cases {
        let want: Vec<String> = simulate(prog, &regs, 10_000)
            .unwrap()
            .iter()
            .map(|v| v.to_string())
            .collect();
        let d = read(&compile_with(name, prog, &regs, Ending::Cond1843)).unwrap();
        assert!(!d
            .cards
            .iter()
            .any(|c| matches!(c, babbage::sketch::Card::Set(_) | babbage::sketch::Card::Repeat { .. })));
        for k in ["1836-03", "1837-12", "1838-05", "not-found"] {
            assert!(accepts(config(k), &d).is_err(), "{name} under {k}");
        }
        let o = run(config("1843"), &d).unwrap();
        assert!(o.halted, "{name} {regs:?}");
        let got: Vec<String> = o.results.iter().map(|v| v.to_string()).collect();
        assert_eq!(got, want, "{name} {regs:?}");
    }
}
