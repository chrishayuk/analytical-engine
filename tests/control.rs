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
