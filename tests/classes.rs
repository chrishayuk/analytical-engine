//! Decks for docs/growth-classes.md: what the configuration of 30 May 1838
//! adds to that of December 1837 with no count set inside its own group.

use babbage::sketch::{accepts, expected, read, run, CONFIGS};

const MAX: &str = include_str!("../control/max-1838.txt");
const TRIPLE: &str = include_str!("../control/triple-1838.txt");

fn first(text: &str) -> Option<&'static str> {
    let d = read(text).unwrap();
    CONFIGS.iter().find(|c| accepts(c, &d).is_ok()).map(|c| c.key)
}

#[test]
fn both_decks_need_may_1838() {
    assert_eq!(first(MAX), Some("1838-05"));
    assert_eq!(first(TRIPLE), Some("1838-05"));
    for text in [MAX, TRIPLE] {
        let d = read(text).unwrap();
        for c in CONFIGS.iter().filter(|c| accepts(c, &d).is_ok()) {
            let o = run(c, &d).unwrap_or_else(|e| panic!("under {}: {e}", c.key));
            assert_eq!(expected(&d, &o), Vec::<String>::new(), "under {}", c.key);
        }
    }
}

#[test]
fn maximum_for_small_numbers() {
    let c = CONFIGS.iter().find(|c| c.key == "1838-05").unwrap();
    for x in 0..=4 {
        for y in 0..=4 {
            let text = MAX
                .replace("Store v1 = 3, v2 = 4", &format!("Store v1 = {x}, v2 = {y}"))
                .replace("Expect results 4", &format!("Expect results {}", x.max(y)));
            let d = read(&text).unwrap();
            let o = run(c, &d).unwrap_or_else(|e| panic!("max({x}, {y}): {e}"));
            assert_eq!(expected(&d, &o), Vec::<String>::new(), "max({x}, {y})");
        }
    }
}

#[test]
fn triple_exponential_for_n_1() {
    let c = CONFIGS.iter().find(|c| c.key == "1838-05").unwrap();
    let text = TRIPLE.replace("Wheels 2", "Wheels 1").replace("65536", "16");
    let d = read(&text).unwrap();
    let o = run(c, &d).unwrap();
    assert_eq!(expected(&d, &o), Vec::<String>::new());
}
