//! A looped program (BAB/L/023, 7 June 1838): groups of operation cards,
//! backing apparatus that send the cards back, and rows of letter cards
//! that advance and go back. The rows of the sheet are the run of its cards
//! written out; here the cards are run, and each row is checked against
//! what they do.

use crate::algebra::Value;
use crate::expr::{eval, Expr, Held};
use crate::machine::{check, Cards, Check, Run, Step, Tally};
use crate::page::{Cell, Op, Page, Target};
use std::collections::BTreeMap;

struct St<'a> {
    page: &'a Page,
    store: BTreeMap<usize, Value>,
    names: BTreeMap<String, Value>,
    /// The letter cards read by the card being run: label, place.
    read: Vec<(String, i64)>,
    /// Counting only: letters are not looked up.
    count_only: bool,
}

impl St<'_> {
    fn get(&self, n: usize) -> Value {
        self.store.get(&n).cloned().unwrap_or_else(Value::zero)
    }
    fn number(&self, e: &Expr) -> Result<i64, String> {
        let v = self.value(e, false)?;
        match (v.num.as_constant(), v.den.as_constant()) {
            (Some(n), Some(d)) if (n / d).is_int() => Ok((n / d).numer() as i64),
            _ => Err(format!("{v} is not a whole number")),
        }
    }
    fn value(&self, e: &Expr, cards: bool) -> Result<Value, String> {
        let h = eval(
            e,
            &|n| {
                if let Some(lc) = self.page.letter_cards.iter().find(|l| l.name == n) {
                    if !cards {
                        return Err(format!("the letter cards {n} where only numbers are read"));
                    }
                    if self.count_only {
                        return Ok(Held::Plain(Value::zero()));
                    }
                    let k = self.number(&lc.at.0)?;
                    let l = usize::try_from(k)
                        .ok()
                        .and_then(|k| lc.letters.get(k))
                        .ok_or_else(|| format!("the {} letter cards have no place {}", lc.label, k + 1))?;
                    return Ok(Held::Plain(Value::letter(l)));
                }
                if self.page.letters.iter().any(|l| l == n) {
                    return Ok(Held::Plain(if self.count_only {
                        Value::zero()
                    } else {
                        Value::letter(n)
                    }));
                }
                self.names
                    .get(n)
                    .map(|v| Held::Plain(v.clone()))
                    .ok_or_else(|| format!("`{n}` has no value yet"))
            },
            &|n, _| Ok(Held::Plain(self.get(n))),
        )?;
        h.plain().cloned().ok_or_else(|| "a complement".into())
    }
    /// The letter cards an expression reads, with their places.
    fn reads(&self, e: &Expr, out: &mut Vec<(String, i64)>) -> Result<(), String> {
        match e {
            Expr::Letter(n) => {
                if let Some(lc) = self.page.letter_cards.iter().find(|l| &l.name == n) {
                    out.push((lc.label.clone(), self.number(&lc.at.0)?));
                }
                Ok(())
            }
            Expr::Var(..) | Expr::Num(_) => Ok(()),
            Expr::Neg(x) | Expr::Complement(x) => self.reads(x, out),
            Expr::Add(a, b) | Expr::Sub(a, b) | Expr::Mul(a, b) | Expr::Div(a, b) => {
                self.reads(a, out)?;
                self.reads(b, out)
            }
        }
    }
}

/// One card run: what the mill shows, the apparatus that then backs the
/// cards (if one does), the letter cards it read.
struct Done {
    op: Op,
    mill: Value,
    backed: Option<String>,
    deck: String,
    writes: Vec<(usize, Value)>,
}

/// Run the cards from the first card of the first group, `n` cards, or
/// until `results` results have been made; calls `each` after every card.
fn run_cards(
    st: &mut St,
    mut stop: impl FnMut(usize, usize) -> bool,
    mut each: impl FnMut(&St, &Done),
) -> Result<(), String> {
    let page = st.page;
    let (mut d, mut c) = (0usize, 0usize);
    let (mut cards, mut results) = (0usize, 0usize);
    while !stop(cards, results) {
        let deck = &page.decks[d];
        let card = &deck.cards[c];
        st.read.clear();
        let mut mill = None;
        let mut writes = vec![];
        for (to, e, _) in &card.sets {
            let mut r = vec![];
            st.reads(e, &mut r)?;
            st.read.extend(r);
            let v = st.value(e, true)?;
            mill.get_or_insert_with(|| v.clone());
            match to {
                Target::Col(n) => {
                    st.store.insert(*n, v.clone());
                    writes.push((*n, v));
                }
                Target::Name(n) => {
                    st.names.insert(n.clone(), v);
                }
            }
        }
        cards += 1;
        c += 1;
        let mut backed = None;
        if c == deck.cards.len() {
            c = 0;
            let mut next = None;
            for b in page.backings.iter().filter(|b| b.after == deck.name) {
                let holds = match &b.unless {
                    Some((a, v, _)) => st.value(a, false)?.same(&st.value(v, false)?),
                    None => false,
                };
                if !holds {
                    next = Some(&b.to);
                    backed = Some(b.name.clone());
                    break;
                }
            }
            d = match next {
                Some(to) => page
                    .decks
                    .iter()
                    .position(|x| &x.name == to)
                    .ok_or_else(|| format!("no group of cards called {to}"))?,
                None if d + 1 < page.decks.len() => d + 1,
                None => return Ok(()),
            };
        }
        if backed.is_some() && backed == page.result_at.as_ref().map(|r| r.1.clone()) {
            results += 1;
        }
        each(
            st,
            &Done {
                op: card.op,
                mill: mill.unwrap(),
                backed,
                deck: deck.name.clone(),
                writes,
            },
        );
    }
    Ok(())
}

fn fresh(page: &Page, count_only: bool) -> Result<St<'_>, String> {
    let mut st = St {
        page,
        store: BTreeMap::new(),
        names: BTreeMap::new(),
        read: vec![],
        count_only,
    };
    for (v, e, _) in &page.store {
        let x = st.value(e, false)?;
        st.store.insert(*v, x);
    }
    Ok(st)
}

pub fn run(page: &Page) -> Run {
    let mut run = Run {
        steps: vec![],
        checks: vec![],
        tally: Tally::default(),
        results: BTreeMap::new(),
        stopped: None,
        stopped_line: None,
        history: BTreeMap::new(),
    };
    let mut st = match fresh(page, false) {
        Ok(s) => s,
        Err(e) => {
            run.stopped = Some(e);
            return run;
        }
    };
    let rows: Vec<_> = page.rows.iter().filter(|r| !r.input).collect();
    let mut made = vec![];
    // Where each row of letter cards stands, by its label: at its first.
    let mut at: BTreeMap<String, i64> = page.letter_cards.iter().map(|l| (l.label.clone(), 0)).collect();
    let mut steps = vec![];
    let r = run_cards(
        &mut st,
        |cards, _| cards >= rows.len(),
        |st, done| {
            let row = rows[steps.len()];
            let line = row.line;
            let mut checks: Vec<Check> = vec![];
            checks.push(check(
                line,
                format!("operation {}", row.op.map(|o| o.sign()).unwrap_or(' ')),
                if row.op == Some(done.op) {
                    Ok(())
                } else {
                    Err(format!("the card is {}", done.op.sign()))
                },
            ));
            if let Some((e, t)) = &row.mill {
                let r = match st.value(e, false) {
                    Ok(v) if v.same(&done.mill) => Ok(()),
                    Ok(_) => Err(format!("the card gives {}", done.mill)),
                    Err(e) => Err(e),
                };
                checks.push(check(line, format!("mill: {t}"), r));
            }
            for (col, cell) in &row.cells {
                let now = st.get(*col);
                let (what, want) = match cell {
                    Cell::Zero => (format!("v{col} = 0"), Ok(Value::zero())),
                    Cell::Value(e, t) => (format!("v{col} = {t}"), st.value(e, false)),
                    // "0 1": the column given off, and the result received.
                    Cell::Retain(Some((e, t))) => (format!("v{col} = 0, then {t}"), st.value(e, false)),
                    _ => (format!("v{col}"), Err("not a cell of a looped program".to_string())),
                };
                let r = match want {
                    Ok(w) if w.same(&now) => Ok(()),
                    Ok(_) => Err(format!("v{col} holds {now}")),
                    Err(e) => Err(e),
                };
                checks.push(check(line, what, r));
            }
            // The letter cards: each moves from where it last stood to
            // where the card reads it.
            let mut notes = vec![];
            for lc in &page.letter_cards {
                let now = st.read.iter().find(|(l, _)| l == &lc.label).map(|x| x.1);
                let forward = if lc.letters.last() == Some(&lc.towards) { 1 } else { -1 };
                let moved = now.map(|k| (k - at[&lc.label]) * forward);
                let written: Vec<_> = row.moves.iter().filter(|m| m.0 == lc.label).collect();
                let say = |m: i64| {
                    if m >= 0 {
                        format!("{} advance {m}", lc.label)
                    } else {
                        format!("{} back {}", lc.label, -m)
                    }
                };
                match (moved, written.first()) {
                    (Some(m), Some(w)) => checks.push(check(
                        w.2,
                        say(w.1),
                        if m == w.1 {
                            Ok(())
                        } else {
                            Err(format!("the cards go {}", say(m)))
                        },
                    )),
                    (Some(m), None) if m != 0 => checks.push(check(
                        line,
                        format!("{} letter cards", lc.label),
                        Err(format!("the cards go {}, and the sheet writes no move", say(m))),
                    )),
                    (None, Some(w)) => checks.push(check(
                        w.2,
                        say(w.1),
                        Err("the card reads no letter card of that row".into()),
                    )),
                    _ => {}
                }
                if let (Some(k), Some(m)) = (now, moved) {
                    if m != 0 {
                        notes.push(say(m));
                    }
                    let l = &lc.letters[k as usize];
                    notes.push(format!("{} at {l}", lc.label));
                    at.insert(lc.label.clone(), k);
                }
            }
            // The backing: "back" in an apparatus's column says it backs the
            // cards at this row. Other words (gear, ungear) are shown, not run.
            for (app, words, l) in &row.backing {
                if words.trim().eq_ignore_ascii_case("back") {
                    checks.push(check(
                        *l,
                        format!("{app} backs the cards"),
                        if done.backed.as_deref() == Some(app) {
                            Ok(())
                        } else {
                            Err(match &done.backed {
                                Some(b) => format!("{b} backs them"),
                                None => "no apparatus backs them here".into(),
                            })
                        },
                    ));
                }
            }
            if let Some(b) = &done.backed {
                let to = page
                    .backings
                    .iter()
                    .find(|x| &x.name == b)
                    .map(|x| x.to.clone())
                    .unwrap_or_default();
                notes.push(format!("{b} backs to {to}"));
                if !row
                    .backing
                    .iter()
                    .any(|(a, w, _)| a == b && w.trim().eq_ignore_ascii_case("back"))
                {
                    checks.push(check(
                        line,
                        format!("{b} backs the cards"),
                        Err("the sheet writes no \"back\" for it".into()),
                    ));
                }
                if Some(b) == page.result_at.as_ref().map(|r| &r.1) {
                    if let Some(v) = st.names.get(&page.result_at.as_ref().unwrap().0) {
                        made.push((line, v.clone()));
                    }
                }
            }
            let mut store_after: BTreeMap<usize, Held> =
                st.store.iter().map(|(k, v)| (*k, Held::Plain(v.clone()))).collect();
            store_after.retain(|_, h| !h.is_zero());
            steps.push(Step {
                row: row.clone(),
                cards: Cards {
                    op: Some(done.op),
                    operands: vec![],
                    reads: vec![],
                    writes: done.writes.iter().map(|(c, v)| (*c, Held::Plain(v.clone()))).collect(),
                    table_formed: false,
                    pairs: vec![],
                    table_of_second: false,
                },
                result: Some(Held::Plain(done.mill.clone())),
                checks,
                store_after,
                note: format!(
                    "{}{}",
                    done.deck,
                    if notes.is_empty() {
                        String::new()
                    } else {
                        format!(": {}", notes.join(", "))
                    }
                ),
            });
        },
    );
    run.steps = steps;
    if let Err(e) = r {
        run.stopped = Some(e);
    }
    for s in &run.steps {
        match s.cards.op {
            Some(Op::Mul | Op::Div) => run.tally.great += 1,
            Some(_) => run.tally.small += 1,
            None => {}
        }
    }
    // The time for so many results: the cards run, counting only.
    if let Some((k, hours, decks, line)) = &page.time {
        let r = fresh(page, true).and_then(|mut st| {
            let mut counted = 0usize;
            run_cards(
                &mut st,
                |_, results| results >= *k,
                |_, done| {
                    if decks.contains(&done.deck) {
                        counted += 1;
                    }
                },
            )?;
            let said: f64 = hours
                .replace('·', ".")
                .parse()
                .map_err(|_| format!("`{hours}` hours"))?;
            if (counted as f64 / 60.0 - said).abs() < 1e-9 {
                Ok(())
            } else {
                Err(format!(
                    "{k} results take {counted} cards of {}: {} hours",
                    decks.join(", "),
                    counted as f64 / 60.0
                ))
            }
        });
        run.checks
            .push(check(*line, format!("{k} results in {hours} hours"), r));
    }
    // The results, in order, against the sheet's.
    for (k, (name, e, t, line)) in page.finds.iter().enumerate() {
        let r = match (made.get(k), st.value(e, false)) {
            (Some((_, v)), Ok(w)) if v.same(&w) => Ok(()),
            (Some((_, v)), Ok(_)) => Err(format!("the cards make {v}")),
            (None, _) => Err(format!(
                "the cards make only {} results in the rows of the sheet",
                made.len()
            )),
            (_, Err(e)) => Err(e),
        };
        if let Ok(w) = st.value(e, false) {
            run.results.insert(name.clone(), w);
        }
        run.checks.push(check(*line, format!("{name} = {t}"), r));
    }
    run
}
