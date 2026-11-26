//! Printing a run.

use crate::expr::{pretty, Held};
use crate::machine::{Run, Source, Step};
use crate::page::Page;
use crate::rat::Rat;
use std::collections::BTreeMap;
use std::fmt::Write;

pub struct Options {
    pub at: Option<BTreeMap<String, Rat>>,
    pub store: bool,
}

fn show(h: &Held, at: &Option<BTreeMap<String, Rat>>) -> String {
    // A whole number on a page of wheels is shown with its figures.
    if let (Held::Plain(v), None) = (h, at) {
        if let (Some(n), Some(d)) = (v.num.as_constant(), v.den.as_constant()) {
            let r = n / d;
            if r.is_int() && r.numer() >= 0 && WHEELS.with(|w| w.get()) > 0 {
                return format!("{:0w$}", r.numer(), w = WHEELS.with(|w| w.get()));
            }
        }
    }
    match (h, at) {
        (Held::Plain(v), Some(at)) => v.eval(at).map(|r| r.to_string()).unwrap_or_else(|| "?".into()),
        (Held::Complement(v), Some(at)) => v.eval(at).map(|r| format!("C{r}")).unwrap_or_else(|| "C?".into()),
        (h, None) => h.to_string(),
    }
}

thread_local! {
    /// The places of the wheels of the page being shown, 0 for none.
    static WHEELS: std::cell::Cell<usize> = const { std::cell::Cell::new(0) };
}

pub fn header(p: &Page) -> String {
    WHEELS.with(|w| w.set(p.wheels.unwrap_or(0) as usize));
    let mut s = format!("{}  No. {}", p.sheet, p.number);
    if !p.date.is_empty() {
        s += &format!(", {}", p.date);
    }
    if !p.title.is_empty() {
        s += &format!("\n{}", p.title);
    }
    s
}

/// The parts of a step's line: number, star and operation; the formula; what
/// the engine did; the marks.
fn step_parts(s: &Step, o: &Options) -> (String, String, String, String) {
    let r = &s.row;
    let op = r.op.map(|o| o.sign().to_string()).unwrap_or_else(|| " ".into());
    let mut what = vec![];
    for (src, v) in &s.cards.operands {
        if let Source::Table = src {
            what.push(format!("table of {} standing", show(v, &o.at)));
        }
    }
    if s.cards.table_formed {
        if let Some((_, v)) = s.cards.operands.first() {
            what.push(format!("table of {} made", show(v, &o.at)));
        }
    }
    if !s.cards.reads.is_empty() {
        let rs: Vec<String> = s.cards.reads.iter().map(|r| crate::expr::col_name(*r)).collect();
        what.push(format!("{} → 0", rs.join(" ")));
    }
    for (c, v) in &s.cards.writes {
        what.push(format!("{} = {}", crate::expr::col_name(*c), show(v, &o.at)));
    }
    let n = s.checks.len();
    let bad = s.checks.iter().filter(|c| !c.ok).count();
    let mark = if bad == 0 {
        format!("✓ {n}")
    } else {
        format!("✗ {bad} of {n}")
    };
    (
        if r.input {
            " in    ".to_string()
        } else {
            format!("{:>3} {} {}", r.number, if r.star { "*" } else { " " }, op)
        },
        pretty(&r.card_text),
        what.join("; "),
        mark,
    )
}

pub fn run_text(p: &Page, run: &Run, o: &Options) -> String {
    let mut out = String::new();
    writeln!(out, "{}", header(p)).unwrap();
    let st: Vec<String> = p.store.iter().map(|(v, _, t)| format!("v{v} = {t}")).collect();
    let wk: Vec<String> = p.working.iter().map(|v| format!("v{v}")).collect();
    writeln!(out, "Store  {}   working {}\n", st.join(", "), wk.join(" ")).unwrap();
    let parts: Vec<_> = run.steps.iter().map(|s| step_parts(s, o)).collect();
    let cw = parts.iter().map(|p| p.1.chars().count()).max().unwrap_or(0);
    let ww = parts.iter().map(|p| p.2.chars().count()).max().unwrap_or(0);
    for (s, (head, card, what, mark)) in run.steps.iter().zip(&parts) {
        writeln!(out, "{head}  {card:<cw$}  {what:<ww$}  {mark}").unwrap();
        for c in s.checks.iter().filter(|c| !c.ok) {
            writeln!(out, "        ✗ {}: {}", c.what, c.detail).unwrap();
        }
        if o.store {
            let cells: Vec<String> = s
                .store_after
                .iter()
                .filter(|(_, h)| !h.is_zero())
                .map(|(c, h)| format!("{} {}", crate::expr::col_name(*c), show(h, &o.at)))
                .collect();
            writeln!(out, "        store: {}", cells.join(", ")).unwrap();
        }
    }
    if let Some(e) = &run.stopped {
        writeln!(out, "\nStopped at {e}. Nothing after it is checked.").unwrap();
    }
    if !run.checks.is_empty() {
        writeln!(out).unwrap();
    }
    for c in &run.checks {
        if c.ok {
            writeln!(out, "✓ {}", c.what).unwrap();
        } else {
            writeln!(out, "✗ {}: {}", c.what, c.detail).unwrap();
        }
    }
    let t = &run.tally;
    writeln!(
        out,
        "\nOperations: great {}, small {}, total {}. Tables of multiples made: {}.",
        t.great,
        t.small,
        t.great + t.small,
        t.tables
    )
    .unwrap();
    for (name, v) in &run.results {
        let shown = match &o.at {
            Some(at) => v.eval(at).map(|r| r.to_string()).unwrap_or_else(|| "?".into()),
            None => v.to_string(),
        };
        writeln!(out, "{name} = {shown}").unwrap();
    }
    let all: Vec<_> = run.all_checks().collect();
    let ok = all.iter().filter(|c| c.ok).count();
    writeln!(
        out,
        "\n{} statements of the sheet checked: {} agree, {} do not.",
        all.len(),
        ok,
        all.len() - ok
    )
    .unwrap();
    if !p.remarks.is_empty() || !p.unrun.is_empty() {
        writeln!(out).unwrap();
    }
    for r in &p.remarks {
        writeln!(out, "Remark (quoted, not run): \"{r}\"").unwrap();
    }
    for r in &p.unrun {
        writeln!(out, "Also on the sheet (not run): {r}").unwrap();
    }
    out
}

/// The program as cards: an operation card, and the variable cards that
/// bring numbers to the mill and take the result back.
pub fn cards_text(p: &Page, run: &Run) -> String {
    let mut out = String::new();
    writeln!(out, "{}\n", header(p)).unwrap();
    writeln!(out, "     {:<10} {:<34} to the store", "operation", "to the mill").unwrap();
    for s in run.steps.iter().filter(|s| !s.row.input && s.row.actions.is_none()) {
        let op = match s.cards.op {
            Some(o) => o.sign().to_string(),
            None => "(transfer)".into(),
        };
        let ins: Vec<String> = if s.cards.op.is_some() {
            s.cards
                .operands
                .iter()
                .map(|(src, _)| match src {
                    Source::Read(n) => format!("v{n}"),
                    Source::Table => "(table kept)".into(),
                })
                .collect()
        } else {
            vec![]
        };
        let mut outs: Vec<String> = vec![];
        for (c, h) in &s.cards.writes {
            let comp = matches!(h, Held::Complement(_)) && s.cards.op.is_some();
            outs.push(if comp {
                format!("C → v{c}")
            } else {
                crate::expr::col_name(*c)
            });
        }
        let from = if s.cards.op.is_none() {
            format!("v{} → ", s.cards.reads.first().copied().unwrap_or(0))
        } else {
            String::new()
        };
        writeln!(
            out,
            "{:>3}  {:<10} {:<34} {from}{}",
            s.row.number,
            op,
            ins.join(", "),
            outs.join(", ")
        )
        .unwrap();
    }
    out
}
