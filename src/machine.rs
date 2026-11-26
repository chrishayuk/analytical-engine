//! The engine of August 1837, as far as BAB/L/001 shows it, and a page run on
//! it. Each rule is in `decisions()`, with what it rests on.
//!
//! A row of a table says three things: which store columns are left at zero
//! (read), which receive a number and what number, and, in the right-hand
//! column, the operation as a formula in the variables with their accents.
//! The run takes the operation and the columns from the row, does them, and
//! checks everything the row and the page state against what it did.

use crate::algebra::Value;
use crate::expr::{changes, eval, pretty, show_var, vars, Expr, Held};
use crate::page::{Cell, Op, Page, Row};
use crate::rat::Rat;
use std::collections::BTreeMap;

pub struct Check {
    pub line: usize,
    pub what: String,
    pub ok: bool,
    pub detail: String,
}

/// Where an operand came from.
#[derive(Clone)]
pub enum Source {
    Read(usize),
    /// The table of multiples already standing in the mill.
    Table,
}

/// The cards an operation needs: what the run recovers from a row.
pub struct Cards {
    pub op: Option<Op>,
    pub operands: Vec<(Source, Held)>,
    pub reads: Vec<usize>,
    pub writes: Vec<(usize, Held)>,
    pub table_formed: bool,
}

pub struct Step {
    pub row: Row,
    pub cards: Cards,
    pub result: Option<Held>,
    pub checks: Vec<Check>,
    pub store_after: BTreeMap<usize, Held>,
}

#[derive(Default)]
pub struct Tally {
    pub great: i64,
    pub small: i64,
    pub tables: i64,
}

pub struct Run {
    pub steps: Vec<Step>,
    pub checks: Vec<Check>,
    pub tally: Tally,
    pub results: BTreeMap<String, Value>,
    pub stopped: Option<String>,
    /// The line of the operation the run stopped at.
    pub stopped_line: Option<usize>,
    /// Every number each variable has held, in order: `v3''` is `history[3][2]`.
    pub history: BTreeMap<usize, Vec<Held>>,
}

impl Run {
    pub fn all_checks(&self) -> impl Iterator<Item = &Check> {
        self.steps
            .iter()
            .flat_map(|s| s.checks.iter())
            .chain(self.checks.iter())
    }
}

pub fn decisions() -> Vec<(&'static str, &'static str)> {
    vec![
        (
            "Reading a column leaves it at zero.",
            "BAB/L/001: every column an operation takes from is written 0 in that row, and is not used again until it is given a new number. The run requires it: an operand must come from a column the row leaves at zero, or from the mill.",
        ),
        (
            "The mill keeps the table of multiples of the multiplicand until another operation comes between.",
            "BAB/L/001 remark: making b′a − ba′ fourth \"would have caused the table of b′ made in the third operation to be destroyed and it must have been recomputed in the operation for b′c\". In No. 1 and No. 2, operation 2 multiplies by b′ although v5 was left at zero by operation 1. So a multiplication whose first factor is the multiplicand of the multiplication just before reads only the multiplier. Any other operation of the mill destroys the table.",
        ),
        (
            "The first factor written is the multiplicand.",
            "The remark names the table of b′ for b′a and b′c, written v5·v1 and v5·v3: the factor the table is of is written first.",
        ),
        (
            "A number taken from a column may at the same time be laid in another as its complement.",
            "Back of BAB/L/001: \"C … before any number signifies the Complement of that number as Ca means complement of a\". No. 2 writes Ca, Cc and Cb in v8, v5 and v9 in the rows where a, c and b are read. The run requires the complemented number to be one read in that row.",
        ),
        (
            "A transfer from one column to another complements; complementing twice restores.",
            "No. 2, operations 8 to 10: v8, v5, v9 (Ca, Cc, Cb) are left at zero and v1, v3, v2 receive a, c, b, with no operation of the mill. The mechanism (the receiving wheels turned the opposite way) is Rojas's explanation (2023), not stated on the sheet; the sheet shows only Ca in and a out.",
        ),
        (
            "A transfer does not touch the mill, and leaves its table standing.",
            "Not shown by BAB/L/001 either way: no multiplication there follows a transfer and reuses a table. A choice, which no result here depends on.",
        ),
        (
            "Accents count the numbers a column has been given.",
            "BAB/L/001: v₁′ is the first number given to v1 after a, v₁″ the second. A complement laid in a column counts (No. 2 calls the column holding Cc v5′, so ax is v₅″). Zeroing does not. A working variable's first number has no accent (v7 = v5·v1). The run checks every accent on the right-hand column against its own count.",
        ),
        (
            "An accented name means that number, wherever it now is.",
            "No. 2, operation 8 is written v₁″ = v₁ = a: the a in v1 had been read away at operation 1 and comes back from v8. So v₁ (no accent) names the first number v1 held, not the column. The run looks every accented name up in the column's history.",
        ),
        (
            "A column is given a number only when it is at zero.",
            "BAB/L/001 and BAB/L/002: every column any row gives a number to is at zero, never yet used or left at zero by an earlier row. Not stated on a sheet; the run requires it, so that a number laid over another is caught.",
        ),
        (
            "Where a sheet has no right-hand column, a subtraction or division takes its operands in the order the mill column writes.",
            "BAB/L/002 writes each row as the operation, the mill's result (A₁ − bλ₀, N₁/a) and the cells, with no formula in the variables. The run then has no other statement of the order, so on such a sheet the mill column is checked for what is taken and made, not for which way round.",
        ),
        (
            "Where a sheet has no right-hand column, the first factor the mill column writes is the multiplicand.",
            "BAB/L/004 No. 2 writes Aa and then Ac, with A = b′/b in no column at the second: the table of A is still standing. BAB/L/007 does the same four times over (d′/d times a, b, c, e), reading one column in each row after the first.",
        ),
        (
            "A composition written as equations agrees up to a factor free of the unknowns.",
            "BAB/L/004 No. 2 writes each member of its composition \"= 0\", and its last member is b times the one before. Each = is checked against the member before it.",
        ),
        (
            "An addition may take more than two numbers in one operation.",
            "BAB/L/011, second table, operations 3 and 6: f₀u₁ + g₀u₀ + h₀ in one row, three columns read.",
        ),
        (
            "Numbers may be given to the store from outside the table between operations.",
            "BAB/L/011 writes \"Calculate f(1) f₁(1)\" across the columns between cycles, with no operation that puts them there. The run gives the columns the numbers (each must be at zero), counts no operation and checks nothing else.",
        ),
        (
            "Great operations are multiplication and division; small are addition, subtraction and transfers.",
            "BAB/L/001 No. 2: \"great 7 small 6\" with 5 multiplications, 2 divisions, 3 subtractions and 3 transfers.",
        ),
        (
            "Values are compared as algebra.",
            "Every number the sheet writes is in letters (b′a, bc′ − b′c). The run holds rational functions of the page's letters exactly and compares by cross-multiplying, so a check holds for all values of the letters, not for chosen numbers.",
        ),
    ]
}

struct State<'a> {
    page: &'a Page,
    store: BTreeMap<usize, Held>,
    history: BTreeMap<usize, Vec<Held>>,
    table: Option<Value>,
    results: BTreeMap<String, Value>,
}

impl State<'_> {
    fn letter(&self, n: &str) -> Result<Held, String> {
        if self.page.letters.iter().any(|l| l == n) {
            return Ok(Held::Plain(Value::letter(n)));
        }
        if let Some(v) = self.results.get(n) {
            return Ok(Held::Plain(v.clone()));
        }
        Err(format!("`{n}` is not a letter of the page, nor a result found yet"))
    }
    fn version(&self, n: usize, p: usize) -> Result<Held, String> {
        let h = self
            .history
            .get(&n)
            .ok_or_else(|| format!("v{n} has never held a number"))?;
        h.get(p).cloned().ok_or_else(|| {
            format!(
                "{} would be v{n} {}, but v{n} has changed {} so far",
                show_var(n, p),
                changes(p),
                crate::expr::times(h.len() - 1)
            )
        })
    }
    fn eval(&self, e: &Expr) -> Result<Held, String> {
        eval(e, &|n| self.letter(n), &|n, p| self.version(n, p))
    }
    fn get(&self, n: usize) -> Held {
        self.store.get(&n).cloned().unwrap_or(Held::Plain(Value::zero()))
    }
}

pub fn ordinal(n: usize) -> String {
    match n {
        1 => "1st".into(),
        2 => "2nd".into(),
        3 => "3rd".into(),
        n => format!("{n}th"),
    }
}

fn check(line: usize, what: impl Into<String>, r: Result<(), String>) -> Check {
    let (ok, detail) = match r {
        Ok(()) => (true, String::new()),
        Err(e) => (false, pretty(&e)),
    };
    Check {
        line,
        what: pretty(&what.into()),
        ok,
        detail,
    }
}

fn apply(op: Op, a: &Value, b: &Value) -> Result<Value, String> {
    Ok(match op {
        Op::Mul => a.mul(b),
        Op::Div => a.div(b).ok_or("division by zero")?,
        Op::Add => a.add(b),
        Op::Sub => a.sub(b),
    })
}

pub fn run(page: &Page) -> Run {
    let mut st = State {
        page,
        store: BTreeMap::new(),
        history: BTreeMap::new(),
        table: None,
        results: BTreeMap::new(),
    };
    let at = |w: &str| page.lines.get(w).copied().unwrap_or(1);
    let mut checks = vec![];
    for (v, e, t) in &page.store {
        match st.eval(e) {
            Ok(h) => {
                st.store.insert(*v, h.clone());
                st.history.insert(*v, vec![h]);
            }
            Err(e) => checks.push(check(at("Store"), format!("v{v} = {t}"), Err(e))),
        }
    }
    let mut steps = vec![];
    let mut tally = Tally::default();
    let mut stopped = None;
    let mut stopped_line = None;
    for row in &page.rows {
        if row.input {
            // Numbers brought into the store from outside the table
            // ("Calculate f(1) f₁(1)", BAB/L/011): no operation, nothing to check
            // but that each column is at zero to receive.
            let mut checks = vec![];
            for (c, cell) in &row.cells {
                if let Cell::Value(e, t) = cell {
                    if !st.get(*c).is_zero() {
                        checks.push(check(
                            row.line,
                            format!("v{c} at zero to receive"),
                            Err(format!("v{c} still holds {}", st.get(*c))),
                        ));
                    }
                    match st.eval(e) {
                        Ok(v) => {
                            st.store.insert(*c, v.clone());
                            st.history.entry(*c).or_default().push(v);
                        }
                        Err(e) => checks.push(check(row.line, format!("v{c} = {t}"), Err(e))),
                    }
                }
            }
            let writes = row.cells.iter().map(|(c, _)| (*c, st.get(*c))).collect();
            steps.push(Step {
                row: row.clone(),
                cards: Cards {
                    op: None,
                    operands: vec![],
                    reads: vec![],
                    writes,
                    table_formed: false,
                },
                result: None,
                checks,
                store_after: st.store.clone(),
            });
            continue;
        }
        match step(&mut st, row, &mut tally) {
            Ok(s) => steps.push(s),
            Err(e) => {
                stopped = Some(format!("operation {} (line {}): {e}", row.number, row.line));
                stopped_line = Some(row.line);
                break;
            }
        }
    }
    let reached = stopped.is_none();

    // The results against what the page says they are, and against the equations.
    if reached {
        for (name, e, t, line) in &page.finds {
            let r = (|| {
                let got = st.results.get(name).ok_or(format!("the run gives no {name}"))?;
                let said = st.eval(e)?;
                if Held::Plain(got.clone()).same(&said) {
                    Ok(())
                } else {
                    Err(format!("the run gives {name} = {got}"))
                }
            })();
            checks.push(check(*line, format!("{name} = {t}"), r));
        }
        if !page.equations.is_empty() {
            match solve(&st, page) {
                Ok(sol) => {
                    for (name, v) in sol {
                        if let Some(got) = st.results.get(&name) {
                            let r = if got.same(&v) {
                                Ok(())
                            } else {
                                Err(format!("the equations give {name} = {v}; the run {got}"))
                            };
                            checks.push(check(at("Equation"), format!("{name} solves the equations"), r));
                        }
                    }
                }
                Err(e) => checks.push(check(at("Equation"), "the equations", Err(e))),
            }
        }
        // Each "=" of a composition says that the members either side of it
        // are equal: so each member is checked against the one before it
        // (or the last before it that could be worked out), and one slip
        // in a chain is one disagreement.
        for c in &page.compositions {
            let mut prev: Option<(Value, &str)> = None;
            for (k, (e, t)) in c.parts.iter().enumerate() {
                let here = st
                    .eval(e)
                    .and_then(|h| h.plain().cloned().ok_or_else(|| "a complement".to_string()));
                if k == 0 {
                    match here {
                        Ok(v) => prev = Some((v, t)),
                        Err(e) => checks.push(check(c.line, format!("composition: {t}"), Err(e))),
                    }
                    continue;
                }
                let r = match (&prev, &here) {
                    (Some((a, _)), Ok(b)) if a.same(b) => Ok(()),
                    (Some((a, at)), Ok(b)) => {
                        let ratio = b.div(a);
                        let scaled = c.equation
                            && ratio
                                .as_ref()
                                .is_some_and(|r| !r.is_zero() && !page.unknowns.iter().any(|u| r.depends_on(u)));
                        if scaled {
                            Ok(())
                        } else {
                            Err(format!("{} is {a}, but this is {b}", pretty(at)))
                        }
                    }
                    (None, Ok(_)) => Err("nothing before it could be worked out".into()),
                    (_, Err(e)) => Err(e.to_string()),
                };
                let before = prev.as_ref().map_or(c.parts[0].1.as_str(), |p| p.1);
                checks.push(check(c.line, format!("composition: {before} = {t}"), r));
                if let Ok(v) = here {
                    prev = Some((v, t));
                }
            }
        }
        let touched: std::collections::BTreeSet<usize> = st.history.keys().copied().collect();
        let declared: std::collections::BTreeSet<usize> = page
            .store
            .iter()
            .map(|s| s.0)
            .chain(page.working.iter().copied())
            .collect();
        if touched != declared {
            checks.push(check(
                at("Working"),
                "the variables used are those declared",
                Err(format!("used {touched:?}, declared {declared:?}")),
            ));
        }
        for (k, v, line) in &page.states {
            let got = match k.as_str() {
                "great" => tally.great,
                "small" => tally.small,
                "total" => tally.great + tally.small,
                "variables" => page.store.len() as i64,
                "working" => touched.len() as i64 - page.store.len() as i64,
                "occupied" => touched.len() as i64,
                _ => {
                    checks.push(check(
                        *line,
                        k.clone(),
                        Err(format!("`{k}` is not a count the run keeps")),
                    ));
                    continue;
                }
            };
            let r = if got == *v {
                Ok(())
            } else {
                Err(format!("the run counts {got}"))
            };
            checks.push(check(*line, format!("{k} = {v}"), r));
        }
    }
    Run {
        steps,
        checks,
        tally,
        results: st.results.clone(),
        stopped,
        stopped_line,
        history: st.history.clone(),
    }
}

fn step(st: &mut State, row: &Row, tally: &mut Tally) -> Result<Step, String> {
    let line = row.line;
    let mut checks = vec![];
    let before = st.store.clone();
    let reads: Vec<usize> = row
        .cells
        .iter()
        .filter(|c| matches!(c.1, Cell::Zero))
        .map(|c| c.0)
        .collect();
    for r in &reads {
        if st.get(*r).is_zero() {
            checks.push(check(
                line,
                format!("v{r} left at 0"),
                Err(format!("v{r} was already zero")),
            ));
        }
    }

    // The operands, from the right-hand column where there is one, else the
    // columns read, in the order of the sheet.
    let mut operands: Vec<(Source, Held)> = vec![];
    let named: Vec<(usize, usize)> = match &row.card {
        Some(c) => {
            let mut v = vec![];
            vars(&c.rhs, &mut v);
            v
        }
        None => {
            let mut v: Vec<(usize, usize)> = reads
                .iter()
                .map(|r| (*r, st.history.get(r).map_or(0, |h| h.len().saturating_sub(1))))
                .collect();
            // With no right-hand column, the mill column says which way round
            // a subtraction or division goes (BAB/L/002 writes only A₁ − bλ₀).
            if let (Some(op @ (Op::Sub | Op::Div)), Some((e, _)), [x, y]) = (row.op, &row.mill, &v[..]) {
                let held = |(n, p): (usize, usize)| st.version(n, p).ok().and_then(|h| h.plain().cloned());
                if let (Some(a), Some(b), Ok(Held::Plain(m))) = (held(*x), held(*y), st.eval(e)) {
                    let same = |r: Result<Value, String>| r.is_ok_and(|r| Held::Plain(r).same(&Held::Plain(m.clone())));
                    if !same(apply(op, &a, &b)) && same(apply(op, &b, &a)) {
                        v.swap(0, 1);
                    }
                }
            }
            // And the first factor of a multiplication is the one the mill
            // column writes first (BAB/L/004 writes Aa, then Ac with A no
            // longer in the store: the table of A still standing).
            if let (Some(Op::Mul), Some((Expr::Mul(first, _), _))) = (row.op, &row.mill) {
                if let Ok(Held::Plain(f)) = st.eval(first) {
                    let is_f = |(n, p): &(usize, usize)| {
                        st.version(*n, *p).ok().is_some_and(|h| h.same(&Held::Plain(f.clone())))
                    };
                    if let Some(k) = v.iter().position(is_f) {
                        let x = v.remove(k);
                        v.insert(0, x);
                    } else if v.len() == 1 && st.table.as_ref().is_some_and(|t| t.same(&f)) {
                        // The multiplicand is in the mill only: name it by the
                        // column and number it was taken from.
                        let from = st
                            .history
                            .iter()
                            .find_map(|(n, h)| h.iter().position(|x| x.same(&Held::Plain(f.clone()))).map(|p| (*n, p)));
                        if let Some(x) = from {
                            v.insert(0, x);
                        }
                    } else if v.len() == 1 {
                        // Neither read nor in the mill, but standing in a
                        // column the row does not leave at zero: name it, so
                        // that the run says so and goes on (BAB/L/007, row 22).
                        let standing = st.store.iter().find_map(|(n, h)| {
                            (h.same(&Held::Plain(f.clone())) && !reads.contains(n))
                                .then(|| (*n, st.history.get(n).map_or(0, |h| h.len().saturating_sub(1))))
                        });
                        if let Some(x) = standing {
                            v.insert(0, x);
                        }
                    }
                }
            }
            v
        }
    };
    let mut table_formed = false;
    for (i, (n, p)) in named.iter().enumerate() {
        let want = st.version(*n, *p)?;
        let from_column = reads.contains(n) && before.get(n).is_some_and(|h| h.same(&want));
        let from_table =
            row.op == Some(Op::Mul) && i == 0 && st.table.as_ref().is_some_and(|t| Held::Plain(t.clone()).same(&want));
        let src = if from_table && !from_column {
            Source::Table
        } else if from_column {
            Source::Read(*n)
        } else {
            // A transfer's source is the column read, whatever the formula calls it.
            if row.op.is_none() && reads.len() == 1 {
                Source::Read(reads[0])
            } else {
                checks.push(check(
                    line,
                    format!("where {} comes from", show_var(*n, *p)),
                    Err(format!(
                        "{} ({want}) is not in a column this row leaves at zero{}",
                        show_var(*n, *p),
                        if row.op == Some(Op::Mul) && i == 0 {
                            ", nor the table standing in the mill"
                        } else {
                            ""
                        }
                    )),
                ));
                Source::Read(*n)
            }
        };
        if row.op == Some(Op::Mul) && i == 0 {
            table_formed = matches!(src, Source::Read(_));
        }
        operands.push((src, want));
    }
    // Every column left at zero must go somewhere: to the mill, or to another
    // column as its complement.
    for r in &reads {
        let to_mill = operands.iter().any(|o| matches!(o.0, Source::Read(n) if n == *r));
        let to_column = row.cells.iter().any(|(_, c)| match c {
            Cell::Value(Expr::Complement(inner), _) => {
                st.eval(inner).ok().zip(before.get(r)).is_some_and(|(v, h)| v.same(h))
            }
            _ => false,
        });
        let transfer = row.op.is_none() && reads.len() == 1;
        if !(to_mill || to_column || transfer) {
            checks.push(check(
                line,
                format!("v{r} left at 0"),
                Err(format!("v{r} is left at zero but its number goes nowhere")),
            ));
        }
    }

    // The operation.
    let (machine, said): (Held, Option<Held>) = match row.op {
        Some(op) => {
            // An addition may take more than two numbers at once
            // (BAB/L/011: f₀u₁ + g₀u₀ + h₀); every other operation two.
            if operands.len() != 2 && !(op == Op::Add && operands.len() > 2) {
                return Err(format!(
                    "{} needs two operands; the row gives {}",
                    op.sign(),
                    operands.len()
                ));
            }
            let mut m = operands[0].1.plain().ok_or("an operand is a complement")?.clone();
            for o in &operands[1..] {
                m = apply(op, &m, o.1.plain().ok_or("an operand is a complement")?)?;
            }
            let m = Held::Plain(m);
            let said = match &row.card {
                Some(c) => Some(st.eval(&c.rhs)?),
                None => None,
            };
            (m, said)
        }
        None => {
            if reads.len() != 1 {
                return Err(format!(
                    "a row with no operation is a transfer, from one column; this one leaves {} at zero",
                    reads.len()
                ));
            }
            let src = st.get(reads[0]);
            let said = match &row.card {
                Some(c) => Some(st.eval(&c.rhs)?),
                None => None,
            };
            (src.complemented(), said)
        }
    };
    let mut result = machine.clone();
    if let (Some(said), Some(c)) = (&said, &row.card) {
        let what = match row.op {
            Some(op) => format!("{} on {} gives {}", op.sign(), describe(&operands), pretty(&c.rhs_text)),
            None => format!("moving v{} gives {}", reads[0], pretty(&c.rhs_text)),
        };
        if said.same(&machine) {
            checks.push(check(line, what, Ok(())));
        } else if row.op.is_none() {
            checks.push(check(
                line,
                what,
                Err(format!(
                    "the transfer brings {machine}, but the sheet writes {}, which is {said}. The run goes on with the value on the sheet",
                    pretty(&c.rhs_text)
                )),
            ));
            result = said.clone();
        } else {
            let named: Vec<String> = named.iter().map(|(n, p)| show_var(*n, *p)).collect();
            let plain = match row.op {
                Some(op) if named.len() == 2 => format!("{} {} {}", named[0], op.sign(), named[1]),
                _ => machine.to_string(),
            };
            let swapped = match (row.op, operands.first(), operands.get(1)) {
                (Some(op), Some((_, Held::Plain(a))), Some((_, Held::Plain(b)))) => {
                    apply(op, b, a).ok().is_some_and(|v| said.same(&Held::Plain(v)))
                }
                _ => false,
            };
            let why = if swapped {
                "the sheet takes the operands the other way round".to_string()
            } else {
                "neither order of the two operands gives that".to_string()
            };
            checks.push(check(
                line,
                what,
                Err(format!(
                    "the operation gives {plain}, but the sheet writes {}: {why}. The run goes on with the value on the sheet",
                    pretty(&c.rhs_text)
                )),
            ));
            result = said.clone();
        }
    }
    if let Some((e, t)) = &row.mill {
        let r = st.eval(e).and_then(|v| {
            if v.same(&result) {
                Ok(())
            } else {
                Err(format!("the operation gives {result}"))
            }
        });
        checks.push(check(line, format!("mill: {t}"), r));
    }

    // What the row writes.
    let mut writes = vec![];
    for (col, cell) in &row.cells {
        let v = match cell {
            Cell::Zero => continue,
            Cell::Named(n) => {
                let r = match (st.results.get(n), result.plain()) {
                    (Some(prev), Some(now)) if !prev.same(now) => Err(format!("{n} was {prev} and is now {now}")),
                    (_, None) => Err(format!("{n} would be a complement")),
                    _ => Ok(()),
                };
                if let Some(v) = result.plain() {
                    st.results.insert(n.clone(), v.clone());
                }
                checks.push(check(line, format!("v{col} = {n}"), r));
                result.clone()
            }
            Cell::Value(e, t) => {
                let v = st.eval(e)?;
                let r = if v.same(&result) {
                    Ok(())
                } else if let Held::Complement(inner) = &v {
                    let ok = reads
                        .iter()
                        .any(|r| before.get(r).is_some_and(|h| h.same(&Held::Plain(inner.clone()))));
                    if ok {
                        Ok(())
                    } else {
                        Err(format!("no column this row leaves at zero holds {inner}"))
                    }
                } else {
                    Err(format!("the operation of the row gives {result}"))
                };
                checks.push(check(line, format!("v{col} = {t}"), r));
                v
            }
        };
        writes.push((*col, v));
    }
    for r in &reads {
        st.store.insert(*r, Held::Plain(Value::zero()));
    }
    // A column is given a number only when it is at zero.
    for (c, _) in &writes {
        if !st.get(*c).is_zero() {
            checks.push(check(
                line,
                format!("v{c} at zero to receive"),
                Err(format!("v{c} still holds {}, which would be lost", st.get(*c))),
            ));
        }
    }
    for (c, v) in &writes {
        st.store.insert(*c, v.clone());
        st.history.entry(*c).or_default().push(v.clone());
    }

    // The right-hand column: the variable written and its accents, the names.
    if let Some(c) = &row.card {
        let (n, p) = c.dest;
        let r = if !writes.iter().any(|w| w.0 == n) {
            Err(format!("the row gives v{n} no number"))
        } else {
            let k = st.history[&n].len() - 1;
            if k == p {
                Ok(())
            } else {
                Err(format!(
                    "v{n} has now changed {}, so it is {}",
                    crate::expr::times(k),
                    show_var(n, k)
                ))
            }
        };
        checks.push(check(line, format!("{} written", show_var(n, p)), r));
        for name in &c.names {
            let r = match st.results.get(name) {
                Some(v) if Held::Plain(v.clone()).same(&result) => Ok(()),
                Some(v) => Err(format!("{name} is {v}")),
                None => {
                    if let Some(v) = result.plain() {
                        st.results.insert(name.clone(), v.clone());
                    }
                    Ok(())
                }
            };
            checks.push(check(line, format!("{name} = {}", show_var(n, p)), r));
        }
        for (e, t) in &c.tails {
            let r = st.eval(e).and_then(|v| {
                if v.same(&result) {
                    Ok(())
                } else {
                    Err(format!("the operation gives {result}"))
                }
            });
            checks.push(check(line, format!("= {t}"), r));
        }
    }

    // The mill's table, and the tally.
    match row.op {
        Some(Op::Mul) => {
            if table_formed {
                tally.tables += 1;
            }
            st.table = operands[0].1.plain().cloned();
        }
        Some(_) => st.table = None,
        None => {}
    }
    match row.op {
        Some(op) if op.great() => tally.great += 1,
        _ => tally.small += 1,
    }

    Ok(Step {
        row: row.clone(),
        cards: Cards {
            op: row.op,
            operands,
            reads,
            writes,
            table_formed,
        },
        result: Some(result),
        checks,
        store_after: st.store.clone(),
    })
}

fn describe(ops: &[(Source, Held)]) -> String {
    ops.iter()
        .map(|(s, v)| match s {
            Source::Read(n) => format!("v{n} ({v})"),
            Source::Table => format!("the table of {v}"),
        })
        .collect::<Vec<_>>()
        .join(" and ")
}

/// Solve the page's equations for its unknowns, as algebra: the coefficients
/// are read off by putting each unknown to 1 and the others to 0.
fn solve(st: &State, page: &Page) -> Result<Vec<(String, Value)>, String> {
    let n = page.unknowns.len();
    if page.equations.len() != n {
        return Err(format!("{} equations in {n} unknowns", page.equations.len()));
    }
    let at = |e: &Expr, which: Option<usize>| -> Result<Value, String> {
        let h = eval(
            e,
            &|name| {
                if let Some(j) = page.unknowns.iter().position(|u| u == name) {
                    return Ok(Held::Plain(Value::constant(if Some(j) == which {
                        Rat::ONE
                    } else {
                        Rat::ZERO
                    })));
                }
                st.letter(name)
            },
            &|_, _| Err("an equation names a variable".into()),
        )?;
        h.plain().cloned().ok_or("an equation with a complement".into())
    };
    let mut m: Vec<Vec<Value>> = vec![];
    for (e, _) in &page.equations {
        let c0 = at(e, None)?;
        let mut rowv = vec![];
        for j in 0..n {
            rowv.push(at(e, Some(j))?.sub(&c0));
        }
        rowv.push(c0.neg());
        m.push(rowv);
    }
    for col in 0..n {
        let piv = (col..n)
            .find(|&r| !m[r][col].is_zero())
            .ok_or("the equations are not independent")?;
        m.swap(col, piv);
        for r in 0..n {
            if r != col && !m[r][col].is_zero() {
                let f = m[r][col].div(&m[col][col]).unwrap();
                let pivot = m[col].clone();
                for (x, p) in m[r].iter_mut().zip(&pivot).skip(col) {
                    *x = x.sub(&p.mul(&f));
                }
            }
        }
    }
    Ok((0..n)
        .map(|j| (page.unknowns[j].clone(), m[j][n].div(&m[j][j]).unwrap()))
        .collect())
}
