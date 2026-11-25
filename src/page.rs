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
}

#[derive(Clone, Debug)]
pub struct Chain {
    pub line: usize,
    pub parts: Vec<(Expr, String)>,
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
    s.trim()
        .strip_prefix('v')
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
    } else if let Some(n) = rest.strip_prefix('=') {
        Cell::Named(n.trim().to_string())
    } else {
        Cell::Value(parse(rest)?, rest.to_string())
    };
    Ok((var_index(v)?, cell))
}

fn is_name(s: &str) -> bool {
    let s = s.trim();
    !s.is_empty() && s.chars().all(|c| c.is_alphabetic()) && !s.starts_with('v')
}

fn parse_card(s: &str) -> Result<Card, String> {
    let parts: Vec<&str> = s.split('=').map(str::trim).collect();
    let mut i = 0;
    let mut names = vec![];
    while i < parts.len() && is_name(parts[i]) {
        names.push(parts[i].to_string());
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
                "Letters" => p.letters = body.split_whitespace().map(|s| s.replace('′', "'")).collect(),
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
                "Unknowns" => p.unknowns = body.split_whitespace().map(String::from).collect(),
                "Equation" => {
                    let lhs = body.split('=').next().unwrap().trim().to_string();
                    p.equations.push((parse(&lhs).map_err(err)?, body.clone()));
                }
                "Find" => {
                    let (name, e) = body.split_once('=').ok_or_else(|| err("Find x = ...".into()))?;
                    let t = e.trim().to_string();
                    p.finds.push((name.trim().to_string(), parse(&t).map_err(err)?, t, n));
                }
                "Op" => p.rows.push(parse_row(n, rest).map_err(err)?),
                "States" => {
                    for c in body.split(',') {
                        let mut w = c.split_whitespace();
                        let (k, v) = (w.next(), w.next());
                        let v: i64 = v.and_then(|v| v.parse().ok()).ok_or_else(|| err(format!("`{c}`")))?;
                        p.states.push((k.unwrap().to_string(), v, n));
                    }
                }
                "Composition" => {
                    let parts = body
                        .split('=')
                        .map(|t| Ok((parse(t.trim())?, t.trim().to_string())))
                        .collect::<Result<_, String>>()
                        .map_err(err)?;
                    p.compositions.push(Chain { line: n, parts });
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
