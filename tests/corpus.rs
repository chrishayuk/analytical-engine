//! Every page of the corpus, and probes: a page changed in one cell must be
//! caught, so that agreement means something.

use babbage::corpus::PAGES;
use babbage::machine::run;
use babbage::page::read;

fn page(name: &str) -> String {
    PAGES.iter().find(|p| p.0 == name).unwrap().1.to_string()
}

fn failures(text: &str) -> Vec<String> {
    let p = read("probe", text).unwrap();
    let r = run(&p);
    let mut out: Vec<String> = r
        .all_checks()
        .filter(|c| !c.ok)
        .map(|c| format!("{}: {}", c.what, c.detail))
        .collect();
    if let Some(s) = r.stopped {
        out.push(format!("stopped: {s}"));
    }
    out
}

#[test]
fn no_1_agrees_throughout() {
    assert_eq!(failures(&page("L001-1")), Vec::<String>::new());
}

#[test]
fn no_2_disagrees_only_at_operation_12() {
    let f = failures(&page("L001-2"));
    assert_eq!(f.len(), 1, "{f:#?}");
    assert!(f[0].contains("-v3″-v5″") && f[0].contains("neither order"), "{f:#?}");
}

#[test]
fn counts_of_no_1() {
    let p = read("", &page("L001-1")).unwrap();
    let r = run(&p);
    assert_eq!((r.tally.great, r.tally.small, r.tally.tables), (5, 2, 2));
}

fn probe(name: &str, from: &str, to: &str) -> Vec<String> {
    let t = page(name);
    assert!(t.contains(from), "probe text not found: {from}");
    failures(&t.replacen(from, to, 1))
}

#[test]
fn a_wrong_accent_is_caught() {
    let f = probe("L001-1", "| v1'' = v7-v3'", "| v1' = v7-v3'");
    assert!(f.iter().any(|f| f.contains("v1′ written")), "{f:#?}");
}

#[test]
fn a_wrong_product_is_caught() {
    let f = probe("L001-1", "v1 b'c, v3 0 ", "v1 bc', v3 0 ");
    assert!(f.iter().any(|f| f.starts_with("v1 = bc′")), "{f:#?}");
}

const TABLE: &str = "Sheet probe
No. 0
Letters a b c d
Store v1 = a, v2 = b, v3 = c, v4 = d
Working v5 v6 v7
Op 1  ×  | ab   | v1 0, v2 0, v5 ab   | v5 = v1·v2
OTHER
Op 3  ×  | ad   | v4 0, v7 ad         | v7 = v1·v4
";

#[test]
fn a_table_is_kept_only_until_another_operation() {
    // a·b then a·d: the table of a is still standing, though v1 is at zero.
    let kept = TABLE.replace("OTHER\n", "").replace("v5 v6 v7", "v5 v7");
    assert_eq!(failures(&kept), Vec::<String>::new());
    // a subtraction between them destroys it, and a is nowhere to hand.
    let gone = TABLE.replace("OTHER", "Op 2  −  | ab-c | v3 0, v5 0, v6 ab-c | v6 = v5-v3");
    let f = failures(&gone);
    assert!(
        f.iter().any(|f| f.contains("nor the table standing in the mill")),
        "{f:#?}"
    );
}

#[test]
fn a_column_read_but_not_zeroed_is_caught() {
    let f = probe("L001-1", "| v1 0, v5 0, v7 b'a", "| v1 0, v7 b'a");
    assert!(f.iter().any(|f| f.contains("v5 (b′) is not in a column")), "{f:#?}");
}

#[test]
fn a_complement_of_a_number_not_read_is_caught() {
    let f = probe("L001-2", "v7 b'a, v8 Ca", "v7 b'a, v8 Cc");
    assert!(
        f.iter()
            .any(|f| f.contains("no column this row leaves at zero holds c")),
        "{f:#?}"
    );
}

#[test]
fn a_wrong_count_is_caught() {
    let f = probe("L001-2", "States great 7, small 6", "States great 6, small 7");
    assert!(f.iter().any(|f| f.starts_with("great = 6")), "{f:#?}");
}

#[test]
fn a_wrong_composition_is_caught() {
    let f = probe("L001-2", "(-cb'a+cba'-c'ba+cb'a)", "(-cb'a+cba'-c'ba-cb'a)");
    assert!(f.iter().any(|f| f.contains("composition")), "{f:#?}");
}

#[test]
fn every_page_reads() {
    for (n, t) in PAGES {
        read(n, t).unwrap_or_else(|e| panic!("{e}"));
    }
}

// BAB/L/002, 14 August 1837: the quotient of A0 + A1x + … + A6x⁶ by a + bx.

#[test]
fn l002_agrees_throughout() {
    assert_eq!(failures(&page("L002")), Vec::<String>::new());
}

#[test]
fn l002_counts_two_great_and_three_small_to_each_coefficient() {
    // The pencil on the cover, as far as it can be read: λ0 by one division,
    // λ1 by 2 great and 2 small, each later λm by 2 great and 3 small.
    let r = run(&read("", &page("L002")).unwrap());
    assert_eq!((r.tally.great, r.tally.small), (1 + 2 + 5 * 2, 2 + 5 * 3));
}

/// Where the run's λ0 … λ6 differ from the coefficients of the quotient,
/// worked out independently of the sheet's recurrence: 1/(a + bx) is the sum
/// of (-b)^j x^j / a^(j+1), so λm is the sum over k ≤ m of A_k (-b)^(m-k) / a^(m-k+1).
fn l002_against_the_series(text: &str) -> Vec<String> {
    use babbage::algebra::Value;
    let r = run(&read("", text).unwrap());
    let (a, b) = (Value::letter("a"), Value::letter("b"));
    let mut out = vec![];
    for m in 0..=6 {
        let mut want = Value::zero();
        for k in 0..=m {
            let mut t = Value::letter(&format!("A{k}"));
            for _ in 0..m - k {
                t = t.mul(&b.neg()).div(&a).unwrap();
            }
            want = want.add(&t.div(&a).unwrap());
        }
        match r.results.get(&format!("λ{m}")) {
            Some(got) if got.same(&want) => {}
            Some(got) => out.push(format!("λ{m} = {got}, the series gives {want}")),
            None => out.push(format!("no λ{m}")),
        }
    }
    out
}

#[test]
fn l002_finds_the_coefficients_of_the_quotient() {
    assert_eq!(l002_against_the_series(&page("L002")), Vec::<String>::new());
}

#[test]
fn l002_a_number_laid_over_another_is_caught() {
    // λ2 laid in v8, over λ1, instead of in v9.
    let f = probe("L002", "v6 =λ2, v9 λ2", "v6 =λ2, v8 λ2");
    assert!(f.iter().any(|f| f.contains("v8 still holds")), "{f:#?}");
}

#[test]
fn l002_a_subtraction_the_wrong_way_round_is_caught_by_the_series() {
    // With no right-hand column the mill column gives the order of a
    // subtraction, so the run alone cannot catch this; the series does.
    let t = page("L002").replacen("| A3-bλ2 ", "| bλ2-A3 ", 1);
    assert_eq!(failures(&t), Vec::<String>::new());
    assert!(!l002_against_the_series(&t).is_empty());
}

// The sheets of 16 August 1837 and after.

/// Every page, and how many of its statements do not agree: the slips of
/// the pen found so far, each described in its page and in the README.
const DISAGREEMENTS: &[(&str, usize)] = &[
    ("L001-2", 1),
    ("L004-2", 2),
    ("L007", 2),
    ("L010", 3),
    ("L013-2", 1),
    ("L014-1", 4),
    ("L014-2", 2),
    ("L015", 5),
    ("L017", 9),
    ("L018", 3),
    ("L021", 3),
    ("L024-1", 3),
    ("L024-2", 7),
    ("L025", 4),
];

#[test]
fn every_page_agrees_but_for_its_known_slips() {
    for (name, text) in PAGES {
        let want = DISAGREEMENTS.iter().find(|d| d.0 == *name).map_or(0, |d| d.1);
        let f = failures(text);
        assert_eq!(f.len(), want, "{name}: {f:#?}");
        assert!(f.iter().all(|f| !f.starts_with("stopped")), "{name}: {f:#?}");
    }
}

#[test]
fn l019_and_l020_cards_agree_with_the_run() {
    // Every card Babbage lists for the 36 operations of No. 19 and the 25 of
    // No. 20, and his totals: 136 for No. 19, carried over to 225.
    for name in ["L019", "L020", "L022"] {
        let r = run(&read("", &page(name)).unwrap());
        let cards: Vec<_> = r.all_checks().filter(|c| c.what.starts_with("cards ")).collect();
        assert!(cards.len() >= 18, "{name}");
        assert!(cards.iter().all(|c| c.ok), "{name}");
    }
}

#[test]
fn l004_2_disagrees_only_in_its_composition() {
    // Babbage's composition beside No. 4.2 writes v3′ for the Ac the table
    // lays in v5 (and calls v5′ in its next line), and begins v1′x + v2″
    // where every later member is Hx − M.
    let f = failures(&page("L004-2"));
    assert_eq!(f.len(), 2, "{f:#?}");
    assert!(f[0].contains("v3′") && f[1].contains("(v7v1-a′)x"), "{f:#?}");
}

#[test]
fn l004_the_table_of_a_quotient_serves_two_products() {
    // No. 4.2: A = b′/b is made at operation 1; operation 2 multiplies by it
    // and operation 3 again, with A in no column.
    let r = run(&read("", &page("L004-2")).unwrap());
    assert_eq!(r.tally.tables, 1);
}

#[test]
fn l007_disagrees_at_operations_22_and_35() {
    // 22: the sheet does not write 0 in v22, from which d‴/d is taken.
    // 35: the mill column writes (∂′/∂)b − b″ where the row makes (∂″/∂)b − b″.
    let f = failures(&page("L007"));
    assert_eq!(f.len(), 2, "{f:#?}");
    assert!(f[0].contains("v22″") && f[1].starts_with("mill: (d′/d)b-b″"), "{f:#?}");
}

// The carriage sheets, 20 to 29 August 1837.

#[test]
fn l010_disagrees_only_in_its_last_block() {
    // Row 28 writes v3 320 where the carriage beside it has 302; row 30
    // writes 469 for 194 + 175 = 369, in Car2 and v4.
    let f = failures(&page("L010"));
    assert_eq!(f.len(), 3, "{f:#?}");
    assert!(
        f[0].contains("v3 = 320") && f[1].contains("Car2 = 469") && f[2].contains("v4 = 469"),
        "{f:#?}"
    );
}

#[test]
fn the_difference_engines_tabulate_their_functions() {
    // Each starred value against n² + 2n + 3, n³ and n⁴ (Gives), every one
    // checked and agreeing, complements on the odd values.
    for (name, n) in [("L008", 4), ("L009", 4), ("L010", 4)] {
        let r = run(&read("", &page(name)).unwrap());
        let given: Vec<_> = r.all_checks().filter(|c| c.what.starts_with("after ")).collect();
        assert_eq!(given.len(), n, "{name}");
        assert!(given.iter().all(|c| c.ok), "{name}");
    }
}

#[test]
fn a_wrong_figure_on_a_carriage_is_caught() {
    let f = probe("L009", "Car1 976, Car2 982", "Car1 967, Car2 982");
    assert!(f.iter().any(|f| f.starts_with("Car1 = 967")), "{f:#?}");
}

#[test]
fn l012_needs_two_rules_for_bringing_m_and_n_to_the_mill() {
    // Rows 7, 12, 31 and 36 give v1 (or v9) the complement of what Car3
    // holds; rows 19 and 24 give it what Car3 holds. Either rule alone
    // leaves the other rows wrong.
    let t = page("L012");
    let plain = t.replace("= C(Car3), Car3 = 0", "= Car3, Car3 = 0");
    let comp = t
        .replace("v1 = Car3, Car3 = 0", "v1 = C(Car3), Car3 = 0")
        .replace("v9 = Car3, Car3 = 0", "v9 = C(Car3), Car3 = 0");
    assert_ne!(plain, t);
    assert_ne!(comp, t);
    assert!(!failures(&plain).is_empty());
    assert!(!failures(&comp).is_empty());
    assert_eq!(failures(&t), Vec::<String>::new());
}

#[test]
fn l021_cards_agree_but_for_row_19_and_the_first_running_total() {
    // Row 19 writes C'∂ for C''∂ in v26 (the complement, and its cards);
    // the first running total is written 48 over another figure, for 49.
    let f = failures(&page("L021"));
    assert!(
        f.iter()
            .any(|f| f.starts_with("48 cards in all: the count comes to 49")),
        "{f:#?}"
    );
}

#[test]
fn l026_computes_one_formula_two_ways() {
    // (ab + c∂)/(a + c), and b + (∂ − b)c/(a + c): the same x.
    let x = |name: &str| run(&read("", &page(name)).unwrap()).results.get("x").cloned().unwrap();
    assert!(x("L026-1").same(&x("L026-2")));
}

/// Strict: the run never goes on with the sheet's value. A slip is then
/// followed by what it causes, and the count is of statements the machine
/// confirms with no help from the sheet.
#[test]
fn strict_runs() {
    use babbage::machine::run_strict;
    let (mut all, mut ok) = (0, 0);
    let mut wrong_answer = vec![];
    for (n, t) in PAGES {
        let r = run_strict(&read(n, t).unwrap());
        assert!(r.stopped.is_none(), "{n} stopped: {:?}", r.stopped);
        for c in r.all_checks() {
            all += 1;
            if c.ok {
                ok += 1;
            } else if c.what.contains("solves the equations") {
                wrong_answer.push(*n);
            }
        }
    }
    assert_eq!((all, ok), (2676, 2536));
    // Run exactly as written, one page ends with a wrong answer: L/001's
    // back (−v3″−v5″ at operation 12). L/020's −e/∂ = z is the mill giving
    // out e/∂ with its sign changed (BAB/N/007, June 1840).
    wrong_answer.dedup();
    assert_eq!(wrong_answer, ["L001-2"]);
}

/// BAB/L/023: the looped program. The cards run, and the 35 rows are what
/// they do; each kind of statement on the sheet, changed, is caught.
#[test]
fn l023_the_cards_make_the_rows() {
    assert_eq!(failures(&page("L023")), Vec::<String>::new());
    let r = run(&read("", &page("L023")).unwrap());
    assert_eq!(r.steps.len(), 35);
    assert_eq!(r.all_checks().count(), 124);
    // The four results are the coefficients of the product of the series.
    let (great, small) = (["A", "B", "C", "D"], ["a", "b", "c", "d"]);
    for k in 0..4 {
        let mut want = babbage::algebra::Value::zero();
        for i in 0..=k {
            want = want
                .add(&babbage::algebra::Value::letter(great[i]).mul(&babbage::algebra::Value::letter(small[k - i])));
        }
        assert!(r.results[&format!("c{k}")].same(&want), "c{k}");
    }
    let cases = [
        ("Op 9   ×  | Ba ", "Op 9   ×  | Bb ", "mill: Bb"),
        (
            "Op 15  −  | 3−1         | v3 0 2",
            "Op 15  −  | 3−1         | v3 0 1",
            "v3 = 0, then 1",
        ),
        (
            "Moves Great back 2, Small back 3",
            "Moves Great back 1, Small back 3",
            "Great back 1",
        ),
        (
            "Op 18  −  | 2−1         | v3 0 1     |\n  Backing Y \"back\"",
            "Op 18  −  | 2−1         | v3 0 1     |\n  Backing Z \"back\"",
            "Z backs the cards",
        ),
        ("Op 26  ×", "Op 26  +", "operation +"),
        (
            "= 5050 cards of formula ×",
            "= 5000 cards of formula ×",
            "100 results: 5000 cards of formula ×",
        ),
        (
            "Find c2 = Ac + Bb + C a ",
            "Find c2 = Ac + Bc + C a ",
            "c2 = Ac + Bc + C a",
        ),
    ];
    for (from, to, want) in cases {
        let f = probe("L023", from, to);
        assert!(f.iter().any(|f| f.starts_with(want)), "{want}: {f:#?}");
    }
}

/// The three versions of the elliptic radius vector, run as written
/// (docs/revisions.md): L/017 loses Q0, L/018 swaps the signs of rows 5
/// and 6, L/025 is right.
#[test]
fn three_versions_strict() {
    use babbage::machine::run_strict;
    let count = |n: &str| {
        let r = run_strict(&read(n, &page(n)).unwrap());
        let all: Vec<_> = r.all_checks().collect();
        (all.iter().filter(|c| c.ok).count(), all.len())
    };
    assert_eq!(count("L017"), (84, 127));
    assert_eq!(count("L025"), (89, 93));
    assert_eq!(count("L018"), (73, 91));
}

/// What each page needs of the machine: the capability each rule describes
/// is found where the rule came from.
#[test]
fn capabilities_used() {
    let uses = |n: &str| {
        let p = read(n, &page(n)).unwrap();
        babbage::history::used(&p, &run(&p))
    };
    assert!(uses("L015").contains_key("table-of-second"));
    assert!(uses("L014-2").contains_key("complement-read"));
    assert!(uses("L023").contains_key("loop"));
    assert!(uses("L011-2").contains_key("many-addends"));
    assert!(uses("L008").contains_key("carriages"));
    assert!(uses("L001-1").contains_key("table-kept"));
    assert!(!uses("L001-1").contains_key("transfer"));
    assert!(uses("L001-2").contains_key("transfer"));
}

/// The capabilities against Babbage's history sheets (history/chronology.txt).
#[test]
fn chronology_against_the_corpus() {
    use babbage::history::{chronology, sheet_date, standing, Standing};
    let record = chronology().unwrap();
    let at = |s: &str| sheet_date(s).unwrap();
    // The sign changed: recorded in June 1840, used by L/020 in July.
    assert_eq!(
        standing("sign-changed", &at("31 Jul 1840"), &record, &[]),
        Standing::Recorded
    );
    // Many numbers added at once: used by L/011 eleven months before the
    // record's "Principles of Compound Addn" (July 1838).
    assert_eq!(
        standing("many-addends", &at("28 Aug 1837"), &record, &[]),
        Standing::FirstHere
    );
    // Repetition recorded in March 1836, before L/023 (June 1838).
    assert_eq!(standing("loop", &at("7 Jun 1838"), &record, &[]), Standing::Recorded);
    // Multiplication by table planned in March 1835, before L/001.
    assert_eq!(
        standing("table-kept", &at("4 Aug 1837"), &record, &[]),
        Standing::Recorded
    );
    assert_eq!(sheet_date("before 22 Aug 1837").unwrap().day, 22);
    assert!(sheet_date("").is_none());
}

/// BAB/F/001's first cycle: every line of the transcription reads, and the
/// count of marks no source explains is kept honest.
#[test]
fn f001_cycle_reads() {
    use babbage::mechanical::{in_motion, read, Kind, F001};
    let marks = read(F001).unwrap();
    assert_eq!(marks.len(), 87);
    assert_eq!(marks.iter().filter(|m| m.kind == Kind::Unknown).count(), 34);
    assert_eq!(in_motion(&marks).iter().max(), Some(&10));
}

/// Competing models of the complement (docs/discrepancies.md, item 1): a
/// transfer that keeps the complement contradicts L/001 No. 2's own
/// right-hand column and five other sheets; taking a complement as −x in
/// the mill changes nothing in the corpus.
#[test]
fn competing_complement_models() {
    use babbage::machine::{run_model, Model};
    let total = |m: Model| {
        PAGES
            .iter()
            .map(|(n, t)| run_model(&read(n, t).unwrap(), m).all_checks().filter(|c| c.ok).count())
            .sum::<usize>()
    };
    assert_eq!(total(Model::default()), 2624);
    assert_eq!(
        total(Model {
            complement_as_held: true,
            ..Model::default()
        }),
        2624
    );
    assert_eq!(
        total(Model {
            transfer_keeps: true,
            ..Model::default()
        }),
        2580
    );
}

/// The whole multiplication, F/001 and F/002: six cycles read, and the
/// multiplier's figures as written count down to 0000.
#[test]
fn f001_f002_six_cycles() {
    use babbage::mechanical::{multiplier, read, CYCLES};
    let seq: Vec<String> = CYCLES.iter().map(|(_, _, t)| multiplier(&read(t).unwrap())).collect();
    assert_eq!(seq, ["1021", "0021", "0021", "0011", "0001", "0000"]);
}

/// F/018-019 (11 Jan 1836): every product Babbage wrote follows from the
/// one before by his band's own word, "Add" (the multiplicand written) or
/// "Step up" (times ten): 1028 × 201 = 206628. And every band of the three
/// multiplication designs reads.
#[test]
fn series_f_designs() {
    use babbage::mechanical::{f018_states, read, DESIGNS};
    for d in DESIGNS {
        for (sheet, n, t) in d.bands {
            assert!(read(t).is_ok(), "{sheet} band {n}");
        }
    }
    let s = f018_states();
    assert_eq!(s.len(), 6);
    assert!(
        s.iter().all(|x| x.3.is_ok()),
        "{:?}",
        s.iter().map(|x| &x.3).collect::<Vec<_>>()
    );
    assert_eq!(s.last().unwrap().2, Some(206628));
    assert_eq!(1028 * 201, 206628);
}
