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
