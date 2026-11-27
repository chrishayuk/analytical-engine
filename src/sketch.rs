//! A machine of the control mechanisms in Babbage's Sketch Books, kept apart
//! from the L/023 interpreter (`loops.rs`). That interpreter follows L/023's
//! table, where the counter is a store column and counting down is a mill
//! subtraction. This machine follows the Sketch Books: the count is on the
//! combinatorial wheels, outside the store, and counting down and backing
//! are orders of their own, not operations of the mill.
//!
//! A program is a deck of cards (`control/*.txt`). Each configuration is
//! what the pages of one date describe, and either accepts a deck or says
//! which card or arrangement it does not have. Nothing is added to make a
//! deck run. The one configuration that goes beyond the pages read is
//! labelled so, and exists only to show what the missing step would change.
//!
//! Sources (transcribed in `sources/notes/sketchbooks-control.md` and
//! `codesign-L023.md`; no person has checked them):
//! - 7 Mar 1836, Vol 2 p 84: an operation "terminated after a given variable
//!   number of repetitions": the number is put on an axis and unity
//!   subtracted before each operation.
//! - Dec 1837, Vol 3 pp 161-165: combinatorial figure wheels that "have run
//!   up by coming to 0"; numbers "transferred from the combinatorial cards"
//!   or "computed by the constant part of formula cards"; a card that backs
//!   the operation cards "to 0 or their commencing point", "ineffective if
//!   the combinatorial wheels have run up", and one that "always orders the
//!   backing". The group subject to repetition comes first, then the
//!   constant group.
//! - 30 May [1838], Vol 3 reverse pp 74-75: six groups of cards; wheels
//!   "each of which can be set to back any No of cards"; the combinatorial
//!   number for each repeated group made by a group of cards before it.

use crate::algebra::Value;
use crate::expr::{eval, parse, Held};
use crate::rat::Rat;
use std::collections::BTreeMap;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Op {
    Add,
    Sub,
    Mul,
    Div,
}

impl Op {
    fn sign(self) -> char {
        match self {
            Op::Add => '+',
            Op::Sub => '−',
            Op::Mul => '×',
            Op::Div => '÷',
        }
    }
}

/// What a variable card brings to the mill.
#[derive(Clone, Debug)]
pub enum Src {
    /// A column of the store.
    Col(usize),
    /// A number card.
    Num(i64),
    /// A letter, as the L series writes its numbers.
    Letter(String),
    /// A row of letter cards, by its name: the letter at its place.
    Row(String),
}

#[derive(Clone, Debug)]
pub enum Card {
    /// An operation card and its variable cards: the mill takes `a` and
    /// `b`, and the result goes to each column listed.
    Op { op: Op, a: Src, b: Src, to: Vec<usize> },
    /// One operation repeated as many times as the number given: `col =
    /// col op b`, n times (7 Mar 1836).
    Repeat { op: Op, col: usize, b: Src, n: Src },
    /// A combinatorial card: a number put on the combinatorial wheels,
    /// from the card itself or from the store (computed).
    Set(Src),
    /// A backing card. `counted`: unity is subtracted from the wheels, and
    /// the order is ineffective when they come to 0. Otherwise it always
    /// backs.
    Back { to: usize, label: String, counted: bool },
    /// A backing card made effective by a result of the mill: it backs while
    /// the number in column `col` is greater than zero, and lets the cards
    /// go on when it is zero or less. Lovelace's Note G (1843): "the engine
    /// follows the one or the other of the two courses … contingently on" a
    /// result "equal to zero" or "greater than zero"; V₁₀ "decides which of
    /// two courses the succeeding processes are to follow". Only the
    /// configuration of the published accounts, 1842–1843, has it.
    BackIf { to: usize, label: String, col: usize },
    /// A result: the number in the column, given off and retained, or
    /// given off and the column left at zero (`off`).
    Result { col: usize, off: bool },
}

/// A row of letter cards, standing at the place an expression in the store
/// and the wheels gives (counting from 0). Where letter cards stand is not
/// said on L/023 or in the Sketch Books; as in `loops.rs`, it is read from
/// the numbers that set the counts.
#[derive(Clone, Debug)]
pub struct LetterRow {
    pub name: String,
    pub letters: Vec<String>,
    /// Terms: (sign, Some(column) or None for the wheels, or a constant).
    pub at: Vec<(i64, Place)>,
}

#[derive(Clone, Debug)]
pub enum Place {
    Col(usize),
    Wheels,
    Num(i64),
}

#[derive(Clone, Debug, PartialEq)]
pub enum Expect {
    Halts,
    Endless,
    /// Stops at an operation the mill cannot do (Model D).
    Trapped,
    /// The number in a column when the run ends.
    Column(usize, String),
    /// The first results, in order.
    Results(Vec<String>),
    Last(String),
    Count(usize),
}

pub struct Deck {
    pub name: String,
    pub title: String,
    pub letters: Vec<String>,
    pub store: Vec<(usize, Value)>,
    pub rows: Vec<LetterRow>,
    /// A number on the wheels before the first card: "Any numbers may be
    /// transferred from the combinatorial cards to the combinatorial wheels".
    pub wheels: Option<i64>,
    pub stop_results: Option<usize>,
    pub stop_cards: usize,
    /// Model D (`formal/Babbage/Trap.lean`): an operation the mill cannot do
    /// ends the run, and what stands in the store is its result. No page read
    /// says so; the deck must ask for it (`Trap halts`).
    pub trap: bool,
    pub expect: Vec<Expect>,
    pub cards: Vec<Card>,
}

/// What the pages of one date describe.
pub struct Config {
    pub key: &'static str,
    pub date: &'static str,
    pub source: &'static str,
    /// Combinatorial cards and backing cards.
    pub backing: bool,
    /// Backing to any card; otherwise only "to 0 or their commencing point".
    pub any_target: bool,
    /// A combinatorial card among the cards a counted backing repeats.
    pub set_in_group: bool,
    /// A backing made effective or not by a result of the mill (`BackIf`).
    pub cond_back: bool,
    /// Beyond the pages read.
    pub found: bool,
}

pub const CONFIGS: &[Config] = &[
    Config {
        key: "1836-03",
        date: "March 1836",
        source: "Vol 2 pp 80-94: one operation repeated a variable number of times (7 Mar); the sign choosing a mill cycle inside an operation (22 Mar)",
        backing: false,
        any_target: false,
        set_in_group: false,
        cond_back: false,
        found: true,
    },
    Config {
        key: "1837-12",
        date: "December 1837",
        source: "Vol 3 pp 161-165: combinatorial wheels and cards; conditional and unconditional backing, to the first card",
        backing: true,
        any_target: false,
        set_in_group: false,
        cond_back: false,
        found: true,
    },
    Config {
        key: "1838-05",
        date: "30 May 1838",
        source: "Vol 3 reverse pp 74-75: six groups; wheels set to back any number of cards",
        backing: true,
        any_target: true,
        set_in_group: false,
        cond_back: false,
        found: true,
    },
    Config {
        key: "1843",
        date: "1842–1843, published",
        source: "Menabrea (1842) and Lovelace's Note G (1843): as 30 May 1838, and a backing made effective by a result of the mill, read (Reading A) as Note G's cycle repeated until V10 comes to zero; the mechanism is not described",
        backing: true,
        any_target: true,
        set_in_group: false,
        cond_back: true,
        found: true,
    },
    Config {
        key: "not-found",
        date: "not found",
        source: "as 30 May 1838, and a count may be set within the group it counts: no page read says so",
        backing: true,
        any_target: true,
        set_in_group: true,
        cond_back: false,
        found: false,
    },
];

pub const DECKS: &[(&str, &str)] = &[
    ("multiply-1836", include_str!("../control/multiply-1836.txt")),
    ("multiply-1837", include_str!("../control/multiply-1837.txt")),
    ("sum-1837", include_str!("../control/sum-1837.txt")),
    ("factorial-1837", include_str!("../control/factorial-1837.txt")),
    ("L023-1837", include_str!("../control/L023-1837.txt")),
    ("L023-sheet", include_str!("../control/L023-sheet.txt")),
    ("collatz-table", include_str!("../control/collatz-table.txt")),
    ("tower-table", include_str!("../control/tower-table.txt")),
    ("product-halting", include_str!("../control/product-halting.txt")),
    ("collatz-halting", include_str!("../control/collatz-halting.txt")),
    ("maximum", include_str!("../control/maximum.txt")),
    ("gcd", include_str!("../control/gcd.txt")),
    ("tower-halting", include_str!("../control/tower-halting.txt")),
];

fn op(s: &str) -> Option<Op> {
    match s {
        "+" => Some(Op::Add),
        "-" | "−" => Some(Op::Sub),
        "*" | "×" => Some(Op::Mul),
        "/" | "÷" => Some(Op::Div),
        _ => None,
    }
}

fn col(s: &str) -> Option<usize> {
    s.strip_prefix('v')?.parse().ok()
}

fn place(s: &str) -> Result<Vec<(i64, Place)>, String> {
    let mut out = vec![];
    let mut sign = 1;
    for t in s.split_whitespace() {
        match t {
            "+" => sign = 1,
            "-" | "−" => sign = -1,
            "w" => out.push((sign, Place::Wheels)),
            _ => out.push((
                sign,
                match col(t) {
                    Some(c) => Place::Col(c),
                    None => Place::Num(t.parse().map_err(|_| format!("the place `{s}`"))?),
                },
            )),
        }
    }
    Ok(out)
}

fn value(s: &str, letters: &[String]) -> Result<Value, String> {
    let e = parse(s)?;
    let h = eval(
        &e,
        &|n| {
            if letters.iter().any(|l| l == n) {
                Ok(Held::Plain(Value::letter(n)))
            } else {
                Err(format!("`{n}` is not a letter of the deck"))
            }
        },
        &|_, _| Err("a variable".into()),
    )?;
    h.plain().cloned().ok_or_else(|| "a complement".into())
}

pub fn read(text: &str) -> Result<Deck, String> {
    let mut d = Deck {
        name: String::new(),
        title: String::new(),
        letters: vec![],
        store: vec![],
        rows: vec![],
        wheels: None,
        stop_results: None,
        stop_cards: 1_000_000,
        trap: false,
        expect: vec![],
        cards: vec![],
    };
    let mut in_cards = false;
    let mut labels: BTreeMap<String, usize> = BTreeMap::new();
    let mut backs: Vec<(usize, String, usize)> = vec![];
    for (i, raw) in text.lines().enumerate() {
        let line = match raw.find('%') {
            Some(p) => &raw[..p],
            None => raw,
        }
        .trim();
        if line.is_empty() {
            continue;
        }
        let ln = i + 1;
        let err = |m: &str| format!("line {ln}: {m}: `{line}`");
        let (word, rest) = line.split_once(' ').unwrap_or((line, ""));
        let rest = rest.trim();
        if !in_cards {
            match word {
                "Deck" => d.name = rest.to_string(),
                "Title" => d.title = rest.trim_matches('"').to_string(),
                "Letters" => d.letters = rest.split_whitespace().map(str::to_string).collect(),
                "Store" => {
                    for item in rest.split(',') {
                        let (c, v) = item.split_once('=').ok_or_else(|| err("a store entry"))?;
                        let c = col(c.trim()).ok_or_else(|| err("a column"))?;
                        d.store.push((c, value(v.trim(), &d.letters).map_err(|e| err(&e))?));
                    }
                }
                "Row" => {
                    let (name, r) = rest.split_once('=').ok_or_else(|| err("a row of letter cards"))?;
                    let (ls, at) = r.split_once(" at ").ok_or_else(|| err("a row's place"))?;
                    d.rows.push(LetterRow {
                        name: name.trim().to_string(),
                        letters: ls.split_whitespace().map(str::to_string).collect(),
                        at: place(at).map_err(|e| err(&e))?,
                    });
                }
                "Wheels" => d.wheels = Some(rest.parse().map_err(|_| err("a number"))?),
                "Trap" if rest == "halts" => d.trap = true,
                "Stop" => {
                    let (n, what) = rest.split_once(' ').ok_or_else(|| err("Stop N results|cards"))?;
                    let n: usize = n.parse().map_err(|_| err("a number"))?;
                    match what {
                        "results" => d.stop_results = Some(n),
                        "cards" => d.stop_cards = n,
                        _ => return Err(err("Stop N results|cards")),
                    }
                }
                "Expect" => {
                    let (w, r) = rest.split_once(' ').unwrap_or((rest, ""));
                    d.expect.push(match w {
                        "halts" => Expect::Halts,
                        "endless" => Expect::Endless,
                        "trap" => Expect::Trapped,
                        "column" => {
                            let (c, v) = r.split_once('=').ok_or_else(|| err("Expect column vN = value"))?;
                            Expect::Column(col(c.trim()).ok_or_else(|| err("a column"))?, v.trim().to_string())
                        }
                        "results" => Expect::Results(r.split(',').map(|s| s.trim().to_string()).collect()),
                        "last" => Expect::Last(r.trim().to_string()),
                        "count" => Expect::Count(r.trim().parse().map_err(|_| err("a number"))?),
                        _ => return Err(err("an expectation")),
                    });
                }
                "Cards" => in_cards = true,
                _ => return Err(err("a directive")),
            }
            continue;
        }
        if let Some(l) = line.strip_suffix(':') {
            labels.insert(l.trim().to_string(), d.cards.len());
            continue;
        }
        let f: Vec<&str> = line.split_whitespace().collect();
        let src = |s: &str| -> Result<Src, String> {
            if let Some(c) = col(s) {
                Ok(Src::Col(c))
            } else if let Ok(n) = s.parse::<i64>() {
                Ok(Src::Num(n))
            } else if d.rows.iter().any(|r| r.name == s) {
                Ok(Src::Row(s.to_string()))
            } else if d.letters.iter().any(|l| l == s) {
                Ok(Src::Letter(s.to_string()))
            } else {
                Err(format!("line {ln}: `{s}` is not a column, number, letter or row"))
            }
        };
        let card = match f.as_slice() {
            ["set", x] => Card::Set(src(x)?),
            ["back", l, how] => {
                let counted = match *how {
                    "counted" => true,
                    "always" => false,
                    _ => return Err(err("back LABEL counted|always")),
                };
                backs.push((d.cards.len(), l.to_string(), ln));
                Card::Back {
                    to: 0,
                    label: l.to_string(),
                    counted,
                }
            }
            ["back", l, "if", c] => {
                backs.push((d.cards.len(), l.to_string(), ln));
                Card::BackIf {
                    to: 0,
                    label: l.to_string(),
                    col: col(c).ok_or_else(|| err("back LABEL if vN"))?,
                }
            }
            ["result", c] => Card::Result {
                col: col(c).ok_or_else(|| err("a column"))?,
                off: false,
            },
            ["result", c, "off"] => Card::Result {
                col: col(c).ok_or_else(|| err("a column"))?,
                off: true,
            },
            ["repeat", o, c, b, "times", n] => Card::Repeat {
                op: op(o).ok_or_else(|| err("an operation"))?,
                col: col(c).ok_or_else(|| err("a column"))?,
                b: src(b)?,
                n: src(n)?,
            },
            [o, a, b, ">", to @ ..] if op(o).is_some() && !to.is_empty() => Card::Op {
                op: op(o).unwrap(),
                a: src(a)?,
                b: src(b)?,
                to: to
                    .iter()
                    .map(|c| col(c).ok_or_else(|| err("a column")))
                    .collect::<Result<_, _>>()?,
            },
            _ => return Err(err("a card")),
        };
        d.cards.push(card);
    }
    for (i, l, ln) in backs {
        let t = *labels.get(&l).ok_or_else(|| format!("line {ln}: no label `{l}`"))?;
        if t > i {
            return Err(format!("line {ln}: backing goes back, and `{l}` is ahead"));
        }
        if let Card::Back { to, .. } | Card::BackIf { to, .. } = &mut d.cards[i] {
            *to = t;
        }
    }
    if d.cards.is_empty() {
        return Err("no cards".into());
    }
    Ok(d)
}

/// Whether a configuration has every card and arrangement the deck uses;
/// the first it lacks, if not.
pub fn accepts(c: &Config, d: &Deck) -> Result<(), String> {
    if !c.backing && d.wheels.is_some() {
        return Err("combinatorial wheels".into());
    }
    for (i, card) in d.cards.iter().enumerate() {
        match card {
            Card::Set(_) if !c.backing => return Err(format!("card {}: a combinatorial card", i + 1)),
            Card::Back { .. } if !c.backing => return Err(format!("card {}: a backing card", i + 1)),
            Card::BackIf { .. } if !c.cond_back => {
                return Err(format!(
                    "card {}: a backing made effective by a result of the mill",
                    i + 1
                ))
            }
            Card::Back { to, label, .. } if !c.any_target && *to != 0 => {
                return Err(format!(
                    "card {}: backing to `{label}` (card {}), not \"to 0 or their commencing point\"",
                    i + 1,
                    to + 1
                ))
            }
            Card::Back {
                to,
                label,
                counted: true,
            } if !c.set_in_group => {
                if let Some(j) = (*to..i).find(|&j| matches!(d.cards[j], Card::Set(_))) {
                    return Err(format!(
                        "card {}: a combinatorial card inside the group that card {} repeats (from `{label}`)",
                        j + 1,
                        i + 1
                    ));
                }
            }
            _ => {}
        }
    }
    Ok(())
}

#[derive(Default)]
pub struct Outcome {
    pub results: Vec<Value>,
    pub halted: bool,
    /// Model D: the operation the mill could not do, which ended the run.
    pub trapped: Option<String>,
    /// The store when the run ended.
    pub store: BTreeMap<usize, Value>,
    /// Why the run stopped short, if it did: a card count reached, or an
    /// error.
    pub stopped: Option<String>,
    pub cards: usize,
    /// Operations of the mill, by sign; and subtractions of unity from the
    /// combinatorial wheels.
    pub mill: BTreeMap<char, usize>,
    pub wheel_steps: usize,
    pub backings: usize,
}

fn arith(op: Op, a: &Value, b: &Value) -> Result<Value, String> {
    if let (Some(x), Some(y)) = (as_rat(a), as_rat(b)) {
        let r = match op {
            Op::Add => x.try_add(y),
            Op::Sub => x.try_sub(y),
            Op::Mul => x.try_mul(y),
            Op::Div if y.is_zero() => return Err("division by zero".into()),
            Op::Div => x.try_div(y),
        };
        return r
            .map(Value::constant)
            .ok_or_else(|| "a number too large for this machine (i128)".into());
    }
    match op {
        Op::Add => Ok(a.add(b)),
        Op::Sub => Ok(a.sub(b)),
        Op::Mul => Ok(a.mul(b)),
        Op::Div => a.div(b).ok_or_else(|| "division by zero".into()),
    }
}

pub(crate) fn as_rat(v: &Value) -> Option<Rat> {
    Some(v.num.as_constant()? / v.den.as_constant()?)
}

fn whole(v: &Value) -> Result<i64, String> {
    match as_rat(v) {
        Some(r) if r.is_int() => i64::try_from(r.numer()).map_err(|_| format!("{v} is too large for a count")),
        _ => Err(format!("{v} is not a whole number")),
    }
}

/// Run a deck under a configuration that accepts it, a trap ending the run
/// only if the deck asks for it.
pub fn run(c: &Config, d: &Deck) -> Result<Outcome, String> {
    run_model(c, d, d.trap)
}

/// Run a deck; with `trap`, an operation the mill cannot do (division by 0)
/// ends the run with the store as it stands (Model D), instead of an error.
pub fn run_model(c: &Config, d: &Deck, trap: bool) -> Result<Outcome, String> {
    accepts(c, d)?;
    let mut store: BTreeMap<usize, Value> = d.store.iter().cloned().collect();
    // A count on the wheels is a whole number ≥ 1, as a combinatorial card
    // gives it; the Lean model holds the wheels as a natural number.
    if let Some(w) = d.wheels.filter(|&w| w < 1) {
        return Err(format!("a count of {w} on the wheels before the first card"));
    }
    let mut wheels: Option<i64> = d.wheels;
    let mut o = Outcome::default();
    let mut pc = 0;
    let get = |store: &BTreeMap<usize, Value>, n: usize| store.get(&n).cloned().unwrap_or_else(Value::zero);
    let fetch = |store: &BTreeMap<usize, Value>, wheels: Option<i64>, s: &Src| -> Result<Value, String> {
        Ok(match s {
            Src::Col(n) => get(store, *n),
            Src::Num(n) => Value::constant(Rat::int(*n as i128)),
            Src::Letter(l) => Value::letter(l),
            Src::Row(r) => {
                let row = d.rows.iter().find(|x| &x.name == r).unwrap();
                let mut k = 0i64;
                for (sign, p) in &row.at {
                    k += sign
                        * match p {
                            Place::Col(n) => whole(&get(store, *n))?,
                            Place::Wheels => wheels.ok_or("the wheels hold no number")?,
                            Place::Num(n) => *n,
                        };
                }
                let l = usize::try_from(k)
                    .ok()
                    .and_then(|k| row.letters.get(k))
                    .ok_or_else(|| format!("the letter cards {r} have no place {k}"))?;
                Value::letter(l)
            }
        })
    };
    let result = loop {
        if pc >= d.cards.len() {
            o.halted = true;
            break Ok(());
        }
        if o.cards >= d.stop_cards {
            o.stopped = Some(format!("stopped after {} cards", o.cards));
            break Ok(());
        }
        if d.stop_results.is_some_and(|n| o.results.len() >= n) {
            o.stopped = Some(format!("stopped after {} results", o.results.len()));
            break Ok(());
        }
        o.cards += 1;
        let at = format!("card {}", pc + 1);
        match &d.cards[pc] {
            Card::Op { op, a, b, to } => {
                let r = (|| arith(*op, &fetch(&store, wheels, a)?, &fetch(&store, wheels, b)?))()
                    .map_err(|e| format!("{at}: {e}"));
                let r = match r {
                    Ok(r) => r,
                    Err(e) if trap && e.ends_with("division by zero") => {
                        o.trapped = Some(e);
                        break Ok(());
                    }
                    Err(e) => break Err(e),
                };
                *o.mill.entry(op.sign()).or_default() += 1;
                for t in to {
                    store.insert(*t, r.clone());
                }
                pc += 1;
            }
            Card::Repeat { op, col, b, n } => {
                let n = match fetch(&store, wheels, n).and_then(|v| whole(&v)) {
                    Ok(n) if n >= 0 => n,
                    Ok(n) => break Err(format!("{at}: {n} repetitions")),
                    Err(e) => break Err(format!("{at}: {e}")),
                };
                let bv = match fetch(&store, wheels, b) {
                    Ok(v) => v,
                    Err(e) => break Err(format!("{at}: {e}")),
                };
                let mut x = get(&store, *col);
                for _ in 0..n {
                    // A repeated operation that fails is an error in every
                    // model: the traps of Trap.lean are operation cards only.
                    x = match arith(*op, &x, &bv) {
                        Ok(v) => v,
                        Err(e) => return Err(format!("{at}: {e}")),
                    };
                    *o.mill.entry(op.sign()).or_default() += 1;
                }
                store.insert(*col, x);
                pc += 1;
            }
            Card::Set(s) => {
                match fetch(&store, wheels, s).and_then(|v| whole(&v)) {
                    Ok(n) if n >= 1 => wheels = Some(n),
                    Ok(n) => {
                        break Err(format!(
                            "{at}: a count of {n}: the group passes once before its backing card, and the wheels would not come to 0"
                        ))
                    }
                    Err(e) => break Err(format!("{at}: {e}")),
                }
                pc += 1;
            }
            Card::Back { to, counted, .. } => {
                let back = if *counted {
                    match wheels {
                        None => break Err(format!("{at}: the wheels hold no number")),
                        Some(0) => break Err(format!("{at}: the wheels have already run up")),
                        Some(w) => {
                            o.wheel_steps += 1;
                            wheels = Some(w - 1);
                            w - 1 != 0
                        }
                    }
                } else {
                    true
                };
                if back {
                    o.backings += 1;
                    pc = *to;
                } else {
                    pc += 1;
                }
            }
            Card::BackIf { to, col, .. } => match as_rat(&get(&store, *col)) {
                None => break Err(format!("{at}: v{col} is not a number")),
                Some(r) if r > Rat::ZERO => {
                    o.backings += 1;
                    pc = *to;
                }
                Some(_) => pc += 1,
            },
            Card::Result { col, off } => {
                o.results.push(get(&store, *col));
                if *off {
                    store.remove(col);
                }
                pc += 1;
            }
        }
    };
    o.store = store;
    result.map(|_| o)
}

/// Whether the outcome is what the deck expects; each failure, if not.
pub fn expected(d: &Deck, o: &Outcome) -> Vec<String> {
    let mut bad = vec![];
    for e in &d.expect {
        match e {
            Expect::Halts if !o.halted => bad.push("does not halt".into()),
            Expect::Trapped if o.trapped.is_none() => bad.push("does not stop at a trap".into()),
            Expect::Column(c, r) => match value(r, &d.letters) {
                Ok(w) if o.store.get(c).cloned().unwrap_or_else(Value::zero).same(&w) => {}
                _ => bad.push(format!(
                    "v{c}: {r} expected, {}",
                    o.store.get(c).cloned().unwrap_or_else(Value::zero)
                )),
            },
            Expect::Endless if o.halted => bad.push("halts".into()),
            Expect::Results(rs) => {
                for (i, r) in rs.iter().enumerate() {
                    match (value(r, &d.letters), o.results.get(i)) {
                        (Ok(w), Some(g)) if w.same(g) => {}
                        (_, g) => bad.push(format!(
                            "result {}: {} expected, {}",
                            i + 1,
                            r,
                            g.map(|g| g.to_string()).unwrap_or("none".into())
                        )),
                    }
                }
            }
            Expect::Last(r) => match (value(r, &d.letters), o.results.last()) {
                (Ok(w), Some(g)) if w.same(g) => {}
                (_, g) => bad.push(format!(
                    "last result: {r} expected, {}",
                    g.map(|g| g.to_string()).unwrap_or("none".into())
                )),
            },
            Expect::Count(n) if o.results.len() != *n => bad.push(format!("{n} results expected, {}", o.results.len())),
            _ => {}
        }
    }
    bad
}

/// What every configuration does with a deck, as JSON for the notebook's
/// explorer (`babbage control run -`): whether it accepts the deck, and if
/// so how the run ends, its results and the store. `trap` overrides the
/// deck's own `Trap halts`.
pub fn report_json(d: &Deck, trap: Option<bool>) -> crate::json::Json {
    use crate::json::{obj, Json};
    let trap = trap.unwrap_or(d.trap);
    let runs = CONFIGS
        .iter()
        .map(|c| {
            let refusal = accepts(c, d).err();
            let mut fields = vec![
                ("config".to_string(), Json::from(c.key)),
                ("date".to_string(), Json::from(c.date)),
                ("found".to_string(), Json::from(c.found)),
                ("accepted".to_string(), Json::from(refusal.is_none())),
            ];
            if let Some(r) = refusal {
                fields.push(("refusal".into(), r.into()));
                return Json::Obj(fields);
            }
            match run_model(c, d, trap) {
                Err(e) => {
                    fields.push(("status".into(), "error".into()));
                    fields.push(("error".into(), e.into()));
                }
                Ok(o) => {
                    let status = if o.halted {
                        "halts"
                    } else if o.trapped.is_some() {
                        "trap"
                    } else {
                        "runs on"
                    };
                    fields.push(("status".into(), status.into()));
                    if let Some(t) = &o.trapped {
                        fields.push(("trap".into(), t.clone().into()));
                    }
                    if let Some(s) = &o.stopped {
                        fields.push(("stopped".into(), s.clone().into()));
                    }
                    fields.push((
                        "results".into(),
                        o.results
                            .iter()
                            .map(|v| Json::from(v.to_string()))
                            .collect::<Vec<_>>()
                            .into(),
                    ));
                    let store = o
                        .store
                        .iter()
                        .filter(|(_, v)| !v.is_zero())
                        .map(|(c, v)| (format!("v{c}"), Json::from(v.to_string())))
                        .collect();
                    fields.push(("store".into(), Json::Obj(store)));
                    fields.push(("cards".into(), o.cards.into()));
                    fields.push(("backings".into(), o.backings.into()));
                    fields.push(("wheelSteps".into(), o.wheel_steps.into()));
                    let bad = expected(d, &o);
                    fields.push(("expected".into(), bad.is_empty().into()));
                }
            }
            Json::Obj(fields)
        })
        .collect::<Vec<_>>();
    obj([
        ("deck", d.name.clone().into()),
        ("title", d.title.clone().into()),
        ("trap", trap.into()),
        ("runs", runs.into()),
    ])
}
