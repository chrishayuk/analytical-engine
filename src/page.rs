//! A `.bab` page: one table of a sheet, cell for cell. See `docs/notation.md`.

use crate::expr::{parse, Expr};

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Op {
    Mul,
    Div,
    Add,
    Sub,
}

impl Op {
    pub fn sign(self) -> char {
        match self {
            Op::Mul => '×',
            Op::Div => '÷',
            Op::Add => '+',
            Op::Sub => '−',
        }
    }
    /// Babbage's "great" operations are multiplication and division.
    pub fn great(self) -> bool {
        matches!(self, Op::Mul | Op::Div)
    }
}

#[derive(Clone, Debug)]
pub enum Cell {
    /// `0`: the column is left at zero.
    Zero,
    /// `=x`: the column now holds what the sheet calls x.
    Named(String),
    Value(Expr, String),
    /// `G.R` (BAB/L/016: "G.R signifies give off & retain"), or `0 x`
    /// (BAB/L/020: "0 'B"): the column gives its number to the mill and keeps
    /// it; with `x`, the number it keeps, as the sheet writes it.
    Retain(Option<(Expr, String)>),
    /// `x 0` (BAB/L/020: "C.'B 0"): the column holds x during the row, the
    /// complement on its way back, and is at zero after it.
    Transit(Expr, String),
}

#[derive(Clone, Debug)]
pub struct Card {
    /// The names the result is given (`x =`).
    pub names: Vec<String>,
    /// The variable written, with its accents.
    pub dest: (usize, usize),
    pub rhs: Expr,
    pub rhs_text: String,
    /// Anything after, in the letters: `v1'' = v1 = a`.
    pub tails: Vec<(Expr, String)>,
}

/// A count of cards the sheet writes, after so many rows.
#[derive(Clone, Debug)]
pub enum CardCount {
    /// `Carried 136`: the running count starts here.
    Carried(i64),
    /// `Group`: a group of cards begins, counted afresh.
    Group,
    /// `Total 12 148`: the group so far, and the running count if given.
    Total(i64, Option<i64>),
    /// `Running 98`: the running count alone.
    Running(i64),
}

/// The cards a sheet writes for a row: pairs (from, to), 0 for the mill;
/// the count it gives; the line.
pub type CardsWritten = (Vec<(usize, usize)>, Option<i64>, usize);

#[derive(Clone, Debug)]
pub struct Row {
    pub line: usize,
    pub number: usize,
    pub star: bool,
    pub op: Option<Op>,
    pub mill: Option<(Expr, String)>,
    pub cells: Vec<(usize, Cell)>,
    pub card: Option<Card>,
    pub card_text: String,
    /// Numbers brought in from outside the table, not an operation.
    pub input: bool,
    /// The variable cards the sheet writes for the row (BAB/L/019, L/020):
    /// pairs (from, to), 0 for the mill; the count it gives; the line.
    pub cards_written: Option<CardsWritten>,
    /// A turn of the store and its carriages (BAB/L/008 to L/012): what is
    /// done, in order, `Car1 = Car1 - v2`, each a column and what it is given.
    pub actions: Option<Vec<(usize, Expr, String)>>,
}

#[derive(Clone, Debug)]
pub struct Chain {
    pub line: usize,
    pub parts: Vec<(Expr, String)>,
    /// Each member is an equation, "= 0": members agree up to a factor
    /// free of the unknowns.
    pub equation: bool,
}

#[derive(Clone, Debug, Default)]
pub struct Page {
    pub path: String,
    pub sheet: String,
    pub number: String,
    pub date: String,
    pub title: String,
    pub image: Vec<String>,
    pub letters: Vec<String>,
    pub store: Vec<(usize, Expr, String)>,
    pub working: Vec<usize>,
    pub unknowns: Vec<String>,
    pub equations: Vec<(Expr, String)>,
    pub finds: Vec<(String, Expr, String, usize)>,
    pub rows: Vec<Row>,
    pub states: Vec<(String, i64, usize)>,
    pub compositions: Vec<Chain>,
    pub remarks: Vec<String>,
    /// Words of the sheet quoted on a directive, by line.
    pub quotes: Vec<(usize, String)>,
    /// Lines of the sheet transcribed but not run: pencil, scribbles.
    pub unrun: Vec<String>,
    /// Figures on wheels of this many places: a complement is 10^k − x.
    pub wheels: Option<u32>,
    /// Names the sheet uses, defined in its letters: `Let M1 = M0 + ΔM0`.
    pub lets: Vec<(String, Expr, String, usize)>,
    /// What a column holds after a row, as the sheet's right-hand column
    /// states it: `Gives 4 v8 = C(T1)`.
    pub gives: Vec<(usize, usize, Expr, String, usize)>,
    /// The sheet's counts of cards: `Carried 136` (from the sheet before),
    /// `Total 12 148` (this group, and running), each after so many rows.
    pub card_counts: Vec<(usize, CardCount, usize)>,
    /// The first line of each directive, for pointing at it.
    pub lines: std::collections::BTreeMap<String, usize>,
}

fn quoted(s: &str) -> (String, Option<String>) {
    match s.find('"') {
        Some(i) => {
            let q = s[i + 1..].trim_end().trim_end_matches('"').to_string();
            (s[..i].trim().to_string(), Some(q))
        }
        None => (s.trim().to_string(), None),
    }
}

fn op_of(s: &str) -> Result<Option<Op>, String> {
    Ok(match s {
        "" => None,
        "×" | "x" => Some(Op::Mul),
        "÷" | "/" => Some(Op::Div),
        "+" => Some(Op::Add),
        "−" | "-" | "–" => Some(Op::Sub),
        o => return Err(format!("`{o}` is not an operation")),
    })
}

fn var_index(s: &str) -> Result<usize, String> {
    let s = s.trim();
    if let Some(n) = s.strip_prefix("Car").and_then(|n| n.parse::<usize>().ok()) {
        return Ok(crate::expr::CAR + n);
    }
    s.strip_prefix('v')
        .and_then(|n| n.parse().ok())
        .ok_or_else(|| format!("`{s}` is not a variable"))
}

fn parse_cell(s: &str) -> Result<(usize, Cell), String> {
    let s = s.trim();
    let (v, rest) = s
        .split_once(' ')
        .ok_or_else(|| format!("`{s}`: a cell is `vN value`"))?;
    let rest = rest.trim();
    let cell = if rest == "0" {
        Cell::Zero
    } else if matches!(rest, "G.R" | "G. R" | "GR" | "←") {
        Cell::Retain(None)
    } else if let Some(x) = rest.strip_prefix("0 ") {
        Cell::Retain(Some((parse(x.trim())?, x.trim().to_string())))
    } else if let Some(x) = rest.strip_suffix(" 0") {
        Cell::Transit(parse(x.trim())?, x.trim().to_string())
    } else if let Some(n) = rest.strip_prefix('=') {
        Cell::Named(crate::expr::plain_name(n.trim()))
    } else {
        Cell::Value(parse(rest)?, rest.to_string())
    };
    Ok((var_index(v)?, cell))
}

fn is_name(s: &str) -> bool {
    let s = s.trim();
    !s.is_empty()
        && s.chars().next().is_some_and(|c| c.is_alphabetic())
        && s.chars().all(|c| {
            c.is_alphabetic()
                || matches!(c, '\'' | '′' | '″' | '‴')
                || crate::expr::plain_name(&c.to_string())
                    .chars()
                    .all(|d| d.is_ascii_digit())
        })
        && !s.starts_with('v')
}

fn parse_card(s: &str) -> Result<Card, String> {
    let parts: Vec<&str> = s.split('=').map(str::trim).collect();
    let mut i = 0;
    let mut names = vec![];
    while i < parts.len() && is_name(parts[i]) {
        names.push(crate::expr::plain_name(
            &parts[i].replace('′', "'").replace('″', "''").replace('‴', "'''"),
        ));
        i += 1;
    }
    let dest = match parse(parts.get(i).ok_or("a card with no variable")?)? {
        Expr::Var(n, p) => (n, p),
        _ => return Err(format!("`{s}`: the card should name the variable written")),
    };
    let rhs_text = parts.get(i + 1).ok_or("a card with nothing written")?.to_string();
    let rhs = parse(&rhs_text)?;
    let tails = parts[i + 2..]
        .iter()
        .map(|t| Ok((parse(t)?, t.to_string())))
        .collect::<Result<_, String>>()?;
    Ok(Card {
        names,
        dest,
        rhs,
        rhs_text,
        tails,
    })
}

fn parse_row(n: usize, s: &str) -> Result<Row, String> {
    let f: Vec<&str> = s.split('|').collect();
    if f.len() != 4 {
        return Err("an operation is `number [*] [op] | mill | store | card`".into());
    }
    let mut head = f[0].split_whitespace();
    let number = head
        .next()
        .ok_or("no number")?
        .parse()
        .map_err(|_| "the number of the operation")?;
    let mut star = false;
    let mut op = None;
    for w in head {
        if w == "*" || w == "✱" {
            star = true
        } else {
            op = op_of(w)?
        }
    }
    let mill = match f[1].trim() {
        "" => None,
        m => Some((parse(m)?, m.to_string())),
    };
    let cells = f[2]
        .split(',')
        .filter(|c| !c.trim().is_empty())
        .map(parse_cell)
        .collect::<Result<_, _>>()?;
    let card_text = f[3].trim().to_string();
    let card = if card_text.is_empty() {
        None
    } else {
        Some(parse_card(&card_text)?)
    };
    Ok(Row {
        line: n,
        number,
        star,
        op,
        mill,
        cells,
        card,
        card_text,
        input: false,
        actions: None,
        cards_written: None,
    })
}

/// `Turn 2 | Car1 = Car1 - v2, Car2 = Car2 - v2, v7 = Car1 | Car1 995, v2 0, v7 995`
fn parse_turn(n: usize, s: &str) -> Result<Row, String> {
    let f: Vec<&str> = s.split('|').collect();
    if f.len() != 3 {
        return Err("a turn is `number | actions | cells`".into());
    }
    let number = f[0].trim().parse().map_err(|_| "the number of the turn")?;
    let mut actions = vec![];
    for a in f[1].split(',').filter(|a| !a.trim().is_empty()) {
        let (to, e) = a
            .split_once('=')
            .ok_or_else(|| format!("`{a}`: an action is `Car1 = Car1 - v2`"))?;
        let t = e.trim().to_string();
        actions.push((var_index(to)?, parse(&t)?, format!("{} = {t}", to.trim())));
    }
    let cells = f[2]
        .split(',')
        .filter(|c| !c.trim().is_empty())
        .map(parse_cell)
        .collect::<Result<_, _>>()?;
    Ok(Row {
        line: n,
        number,
        star: false,
        op: None,
        mill: None,
        cells,
        card: None,
        card_text: f[1].trim().to_string(),
        input: false,
        actions: Some(actions),
        cards_written: None,
    })
}

/// Read a page, stopping at the first line that is not in the notation.
pub fn read(path: &str, text: &str) -> Result<Page, String> {
    let (p, errors) = read_all(path, text);
    match errors.first() {
        Some((n, e)) => Err(format!("{path}:{n}: {e}")),
        None => Ok(p),
    }
}

/// Read a page, keeping every line that can be read and saying, by line,
/// what could not: what the language server needs while a page is typed.
pub fn read_all(path: &str, text: &str) -> (Page, Vec<(usize, String)>) {
    let mut errors = vec![];
    let mut p = Page {
        path: path.to_string(),
        ..Default::default()
    };
    for (i, raw) in text.lines().enumerate() {
        let n = i + 1;
        let line = raw.split(" %").next().unwrap();
        let line = line.trim();
        if line.is_empty() || line.starts_with('%') {
            continue;
        }
        let err = |e: String| e;
        let (word, rest) = line.split_once(char::is_whitespace).unwrap_or((line, ""));
        let (body, quote) = quoted(rest);
        if let Some(q) = &quote {
            if word != "Remark" && word != "Unrun" {
                p.quotes.push((n, q.clone()));
            }
        }
        p.lines.entry(word.to_string()).or_insert(n);
        let one = || -> Result<(), String> {
            match word {
                "Sheet" => p.sheet = body,
                "No." => p.number = body,
                "Date" => p.date = body,
                "Title" => p.title = quote.unwrap_or(body),
                "Image" => p.image.push(body),
                "Letters" => {
                    p.letters = body
                        .split_whitespace()
                        .map(|s| crate::expr::plain_name(&s.replace('′', "'")))
                        .collect()
                }
                "Store" => {
                    for c in body.split(',') {
                        let (v, e) = c.split_once('=').ok_or_else(|| err("Store v1 = a, ...".into()))?;
                        let t = e.trim().to_string();
                        p.store.push((var_index(v).map_err(err)?, parse(&t).map_err(err)?, t));
                    }
                }
                "Working" => {
                    p.working = body
                        .split_whitespace()
                        .map(var_index)
                        .collect::<Result<_, _>>()
                        .map_err(err)?;
                }
                "Unknowns" => p.unknowns = body.split_whitespace().map(crate::expr::plain_name).collect(),
                "Equation" => {
                    let lhs = body.split('=').next().unwrap().trim().to_string();
                    p.equations.push((parse(&lhs).map_err(err)?, body.clone()));
                }
                "Find" => {
                    let (name, e) = body.split_once('=').ok_or_else(|| err("Find x = ...".into()))?;
                    let t = e.trim().to_string();
                    p.finds
                        .push((crate::expr::plain_name(name.trim()), parse(&t).map_err(err)?, t, n));
                }
                "Op" => p.rows.push(parse_row(n, rest).map_err(err)?),
                "Turn" => p.rows.push(parse_turn(n, &body).map_err(err)?),
                // Cards [N] (v7 v17)(v3 0)(v17 v7)(0 v18) [4]
                "Cards" => {
                    let open = body.find('(').ok_or_else(|| err("Cards (v7 v17)(v3 0) 2".into()))?;
                    let close = body.rfind(')').ok_or_else(|| err("Cards (v7 v17)(v3 0) 2".into()))?;
                    let number: Option<usize> = body[..open].trim().parse().ok();
                    let count: Option<i64> = body[close + 1..].trim().parse().ok();
                    let mut pairs = vec![];
                    for pr in body[open + 1..close].split(')') {
                        let pr = pr.trim().trim_start_matches('(');
                        if pr.is_empty() {
                            continue;
                        }
                        let mut w = pr.split_whitespace();
                        let side = |x: Option<&str>| -> Result<usize, String> {
                            match x {
                                Some("0") => Ok(0),
                                Some(v) => var_index(v),
                                None => Err("a card is a pair (from to)".into()),
                            }
                        };
                        pairs.push((side(w.next()).map_err(err)?, side(w.next()).map_err(err)?));
                    }
                    let row = p
                        .rows
                        .last_mut()
                        .ok_or_else(|| err("Cards follow the row they belong to".into()))?;
                    if number.is_some_and(|k| k != row.number) {
                        return Err(err(format!(
                            "these cards are numbered {} after row {}",
                            number.unwrap(),
                            row.number
                        )));
                    }
                    row.cards_written = Some((pairs, count, n));
                }
                "Carried" => {
                    let k = body.trim().parse().map_err(|_| err("Carried 136".into()))?;
                    p.card_counts.push((p.rows.len(), CardCount::Carried(k), n));
                }
                "Group" => p.card_counts.push((p.rows.len(), CardCount::Group, n)),
                "Running" => {
                    let k = body.trim().parse().map_err(|_| err("Running 98".into()))?;
                    p.card_counts.push((p.rows.len(), CardCount::Running(k), n));
                }
                "Total" => {
                    let mut w = body.split_whitespace().map(|x| x.parse::<i64>());
                    let group = w
                        .next()
                        .and_then(|x| x.ok())
                        .ok_or_else(|| err("Total 12 148".into()))?;
                    let running = w.next().and_then(|x| x.ok());
                    p.card_counts.push((p.rows.len(), CardCount::Total(group, running), n));
                }
                "Wheels" => p.wheels = Some(body.trim().parse().map_err(|_| err("Wheels 3".into()))?),
                "Let" => {
                    let (name, e) = body.split_once('=').ok_or_else(|| err("Let M1 = M0 + ΔM0".into()))?;
                    let t = e.trim().to_string();
                    p.lets
                        .push((crate::expr::plain_name(name.trim()), parse(&t).map_err(err)?, t, n));
                }
                "Gives" => {
                    // Gives 4 v8 = C(T1)
                    let (head, e) = body.split_once('=').ok_or_else(|| err("Gives 4 v8 = C(T1)".into()))?;
                    let mut w = head.split_whitespace();
                    let row: usize = w
                        .next()
                        .and_then(|x| x.parse().ok())
                        .ok_or_else(|| err("Gives 4 v8 = C(T1)".into()))?;
                    let col = var_index(w.next().unwrap_or("")).map_err(err)?;
                    let t = e.trim().to_string();
                    p.gives.push((row, col, parse(&t).map_err(err)?, t, n));
                }
                // `In v1 f1, v2 g1  "Calculate f(1) f1(1)"`: numbers given to
                // the store from outside, between operations.
                "In" => {
                    let cells = body
                        .split(',')
                        .filter(|c| !c.trim().is_empty())
                        .map(parse_cell)
                        .collect::<Result<_, _>>()
                        .map_err(err)?;
                    p.rows.push(Row {
                        line: n,
                        number: 0,
                        star: false,
                        op: None,
                        mill: None,
                        cells,
                        card: None,
                        card_text: String::new(),
                        input: true,
                        actions: None,
                        cards_written: None,
                    });
                }
                "States" => {
                    for c in body.split(',') {
                        let mut w = c.split_whitespace();
                        let (k, v) = (w.next(), w.next());
                        let v: i64 = v.and_then(|v| v.parse().ok()).ok_or_else(|| err(format!("`{c}`")))?;
                        p.states.push((k.unwrap().to_string(), v, n));
                    }
                }
                "Composition" => {
                    let mut texts: Vec<&str> = body.split('=').map(str::trim).collect();
                    // Ending "= 0", each member is an equation: BAB/L/004.
                    let equation = texts.len() > 2 && texts.last() == Some(&"0");
                    if equation {
                        texts.pop();
                    }
                    let parts = texts
                        .iter()
                        .map(|t| Ok((parse(t)?, t.to_string())))
                        .collect::<Result<_, String>>()
                        .map_err(err)?;
                    p.compositions.push(Chain {
                        line: n,
                        parts,
                        equation,
                    });
                }
                "Remark" => p.remarks.push(quote.unwrap_or(body)),
                "Unrun" => p.unrun.push(quote.unwrap_or(body)),
                w => return Err(err(format!("`{w}` is not a line of a page"))),
            }
            Ok(())
        };
        if let Err(e) = one() {
            errors.push((n, e));
        }
    }
    (p, errors)
}
