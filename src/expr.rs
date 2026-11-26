//! What is written in a cell: an expression in the sheet's letters (`b′a`,
//! `bc′ − b′c`), in its variables with their accents (`v₁″`, written `v1''`),
//! or in the names it gives its results (`x`). Juxtaposition multiplies, as on
//! the sheet; `C` before a number is its complement, as the back of BAB/L/001
//! defines it ("C before any number signifies the Complement of that number").

use crate::algebra::Value;
use crate::rat::Rat;

#[derive(Clone, Debug, PartialEq)]
pub enum Expr {
    Letter(String),
    /// A variable of the store and the number of accents on it: `v1''` is (1, 2).
    Var(usize, usize),
    Num(Rat),
    Neg(Box<Expr>),
    Add(Box<Expr>, Box<Expr>),
    Sub(Box<Expr>, Box<Expr>),
    Mul(Box<Expr>, Box<Expr>),
    Div(Box<Expr>, Box<Expr>),
    Complement(Box<Expr>),
}

#[derive(Clone, Debug, PartialEq)]
enum Tok {
    Letter(String),
    Var(usize, usize),
    Num(i128),
    Op(char),
    Open,
    Close,
    Comp,
}

fn primes(cs: &[char], i: &mut usize) -> usize {
    let mut n = 0;
    while *i < cs.len() {
        match cs[*i] {
            '\'' | '′' => n += 1,
            '″' => n += 2,
            '‴' => n += 3,
            _ => break,
        }
        *i += 1;
    }
    n
}

/// A digit of a subscript, as an ASCII digit: `0`–`9` or `₀`–`₉`.
fn subscript_digit(c: char) -> Option<char> {
    match c {
        '0'..='9' => Some(c),
        '₀'..='₉' => char::from_u32(c as u32 - '₀' as u32 + '0' as u32),
        _ => None,
    }
}

/// A name as the page writes it, with any subscript in ASCII digits: `λ₁` is `λ1`.
pub fn plain_name(s: &str) -> String {
    s.chars().map(|c| subscript_digit(c).unwrap_or(c)).collect()
}

fn lex(s: &str) -> Result<Vec<Tok>, String> {
    let cs: Vec<char> = s.chars().collect();
    let mut i = 0;
    let mut out = vec![];
    while i < cs.len() {
        let c = cs[i];
        match c {
            ' ' | '\t' => i += 1,
            '(' => {
                out.push(Tok::Open);
                i += 1
            }
            ')' => {
                out.push(Tok::Close);
                i += 1
            }
            '+' => {
                out.push(Tok::Op('+'));
                i += 1
            }
            '-' | '−' | '–' => {
                out.push(Tok::Op('-'));
                i += 1
            }
            '·' | '.' | '×' => {
                out.push(Tok::Op('*'));
                i += 1
            }
            '/' | '÷' => {
                out.push(Tok::Op('/'));
                i += 1
            }
            // A carriage of the store, `Car1` (BAB/L/008 to L/012).
            'C' if cs[i..].starts_with(&['C', 'a', 'r']) && cs.get(i + 3).is_some_and(|c| c.is_ascii_digit()) => {
                i += 3;
                let mut n = 0usize;
                while i < cs.len() && cs[i].is_ascii_digit() {
                    n = n * 10 + cs[i].to_digit(10).unwrap() as usize;
                    i += 1;
                }
                let p = primes(&cs, &mut i);
                out.push(Tok::Var(CAR + n, p));
            }
            'C' => {
                out.push(Tok::Comp);
                i += 1;
                // The sheets also write it "C." (BAB/L/012).
                if cs.get(i) == Some(&'.') {
                    i += 1
                }
            }
            'v' if i + 1 < cs.len() && cs[i + 1].is_ascii_digit() => {
                i += 1;
                let mut n = 0usize;
                while i < cs.len() && cs[i].is_ascii_digit() {
                    n = n * 10 + cs[i].to_digit(10).unwrap() as usize;
                    i += 1;
                }
                let p = primes(&cs, &mut i);
                out.push(Tok::Var(n, p));
            }
            d if d.is_ascii_digit() => {
                let mut n = 0i128;
                while i < cs.len() && cs[i].is_ascii_digit() {
                    n = n * 10 + cs[i].to_digit(10).unwrap() as i128;
                    i += 1;
                }
                out.push(Tok::Num(n));
            }
            l if l.is_alphabetic() => {
                i += 1;
                let mut name = l.to_string();
                // A difference is one name: Δ, its order, and what it is of
                // (ΔM0, Δ²M, Δ2N).
                if l == 'Δ' {
                    while i < cs.len() && matches!(cs[i], '²' | '³' | '⁴' | '⁵' | '⁶') {
                        name.push(cs[i]);
                        i += 1
                    }
                    if i < cs.len() && cs[i].is_alphabetic() && cs[i] != 'v' {
                        name.push(cs[i]);
                        i += 1
                    }
                }
                for _ in 0..primes(&cs, &mut i) {
                    name.push('\'');
                }
                // A subscript, written after the letter: A0 or A₀ is A₀
                // (BAB/L/002's coefficients), never A × 0.
                while i < cs.len() {
                    match subscript_digit(cs[i]) {
                        Some(d) => {
                            name.push(d);
                            i += 1
                        }
                        None => break,
                    }
                }
                out.push(Tok::Letter(name));
            }
            other => return Err(format!("`{other}` in `{s}`")),
        }
    }
    Ok(out)
}

struct P {
    t: Vec<Tok>,
    i: usize,
}

impl P {
    fn peek(&self) -> Option<&Tok> {
        self.t.get(self.i)
    }
    fn expr(&mut self) -> Result<Expr, String> {
        let mut e = if self.peek() == Some(&Tok::Op('-')) {
            self.i += 1;
            Expr::Neg(Box::new(self.term()?))
        } else {
            self.term()?
        };
        while let Some(Tok::Op(o @ ('+' | '-'))) = self.peek().cloned() {
            self.i += 1;
            let r = self.term()?;
            e = if o == '+' {
                Expr::Add(Box::new(e), Box::new(r))
            } else {
                Expr::Sub(Box::new(e), Box::new(r))
            };
        }
        Ok(e)
    }
    fn term(&mut self) -> Result<Expr, String> {
        let mut e = self.factor()?;
        loop {
            match self.peek() {
                Some(Tok::Op('*')) => {
                    self.i += 1;
                    e = Expr::Mul(Box::new(e), Box::new(self.factor()?));
                }
                Some(Tok::Op('/')) => {
                    self.i += 1;
                    e = Expr::Div(Box::new(e), Box::new(self.factor()?));
                }
                Some(Tok::Letter(_) | Tok::Var(..) | Tok::Num(_) | Tok::Open | Tok::Comp) => {
                    e = Expr::Mul(Box::new(e), Box::new(self.factor()?));
                }
                _ => return Ok(e),
            }
        }
    }
    fn factor(&mut self) -> Result<Expr, String> {
        let t = self.peek().cloned().ok_or("an expression ends too soon")?;
        self.i += 1;
        Ok(match t {
            Tok::Letter(n) => Expr::Letter(n),
            Tok::Var(n, p) => Expr::Var(n, p),
            Tok::Num(n) => Expr::Num(Rat::int(n)),
            Tok::Comp => Expr::Complement(Box::new(self.factor()?)),
            Tok::Open => {
                let e = self.expr()?;
                if self.peek() != Some(&Tok::Close) {
                    return Err("a `(` is not closed".into());
                }
                self.i += 1;
                e
            }
            t => return Err(format!("{t:?} where a number was expected")),
        })
    }
}

pub fn parse(s: &str) -> Result<Expr, String> {
    let mut p = P { t: lex(s)?, i: 0 };
    let e = p.expr()?;
    if p.i != p.t.len() {
        return Err(format!("`{s}` has more after the expression"));
    }
    Ok(e)
}

/// What a cell holds: a number, or the complement of one.
#[derive(Clone)]
pub enum Held {
    Plain(Value),
    Complement(Value),
}

impl Held {
    pub fn same(&self, o: &Held) -> bool {
        match (self, o) {
            (Held::Plain(a), Held::Plain(b)) | (Held::Complement(a), Held::Complement(b)) => a.same(b),
            _ => false,
        }
    }
    pub fn is_zero(&self) -> bool {
        matches!(self, Held::Plain(v) if v.is_zero())
    }
    pub fn plain(&self) -> Option<&Value> {
        match self {
            Held::Plain(v) => Some(v),
            Held::Complement(_) => None,
        }
    }
    /// Complementing twice gives the number back.
    pub fn complemented(&self) -> Held {
        match self {
            Held::Plain(v) => Held::Complement(v.clone()),
            Held::Complement(v) => Held::Plain(v.clone()),
        }
    }
}

impl std::fmt::Display for Held {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            Held::Plain(v) => write!(f, "{v}"),
            Held::Complement(v) => {
                let s = v.to_string();
                if s.contains(' ') {
                    write!(f, "C({s})")
                } else {
                    write!(f, "C{s}")
                }
            }
        }
    }
}

/// Evaluate, looking up letters with `letter` and variables with `var`.
pub fn eval(
    e: &Expr,
    letter: &dyn Fn(&str) -> Result<Held, String>,
    var: &dyn Fn(usize, usize) -> Result<Held, String>,
) -> Result<Held, String> {
    let plain = |e: &Expr| -> Result<Value, String> {
        match eval(e, letter, var)? {
            Held::Plain(v) => Ok(v),
            Held::Complement(v) => Err(format!("arithmetic on the complement C({v})")),
        }
    };
    Ok(Held::Plain(match e {
        Expr::Letter(n) => return letter(n),
        Expr::Var(n, p) => return var(*n, *p),
        Expr::Num(r) => Value::constant(*r),
        Expr::Complement(x) => return Ok(eval(x, letter, var)?.complemented()),
        Expr::Neg(x) => plain(x)?.neg(),
        Expr::Add(a, b) => plain(a)?.add(&plain(b)?),
        Expr::Sub(a, b) => plain(a)?.sub(&plain(b)?),
        Expr::Mul(a, b) => plain(a)?.mul(&plain(b)?),
        Expr::Div(a, b) => plain(a)?.div(&plain(b)?).ok_or("division by zero")?,
    }))
}

/// The variables an expression names, in the order it names them.
pub fn vars(e: &Expr, out: &mut Vec<(usize, usize)>) {
    match e {
        Expr::Var(n, p) => out.push((*n, *p)),
        Expr::Letter(_) | Expr::Num(_) => {}
        Expr::Neg(x) | Expr::Complement(x) => vars(x, out),
        Expr::Add(a, b) | Expr::Sub(a, b) | Expr::Mul(a, b) | Expr::Div(a, b) => {
            vars(a, out);
            vars(b, out)
        }
    }
}

/// Where the carriages of the store are numbered: `Car1` is column CAR + 1.
pub const CAR: usize = 1000;

/// A column's name: `v3`, or `Car1` for a carriage.
pub fn col_name(n: usize) -> String {
    if n > CAR {
        format!("Car{}", n - CAR)
    } else {
        format!("v{n}")
    }
}

pub fn show_var(n: usize, p: usize) -> String {
    let accents = match p {
        0 => String::new(),
        1 => "′".into(),
        2 => "″".into(),
        3 => "‴".into(),
        p => "′".repeat(p),
    };
    format!("{}{accents}", col_name(n))
}

/// A formula as typed (`v1''`), with its accents as the sheet writes them (`v1″`).
pub fn pretty(typed: &str) -> String {
    typed.replace("'''", "‴").replace("''", "″").replace('\'', "′")
}

/// "1 time", "2 times".
pub fn times(k: usize) -> String {
    if k == 1 {
        "once".into()
    } else {
        format!("{k} times")
    }
}

/// "after 2 changes": what the accents on a variable count.
pub fn changes(p: usize) -> String {
    match p {
        0 => "before any change".into(),
        1 => "after 1 change".into(),
        p => format!("after {p} changes"),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn sheet_forms() {
        assert_eq!(
            parse("b'a").unwrap(),
            Expr::Mul(Box::new(Expr::Letter("b'".into())), Box::new(Expr::Letter("a".into())))
        );
        assert_eq!(parse("v1''").unwrap(), Expr::Var(1, 2));
        assert!(matches!(parse("Ca").unwrap(), Expr::Complement(_)));
        assert!(matches!(parse("-v3''-v5''").unwrap(), Expr::Sub(..)));
        assert!(parse("(bc'-b'c)/(b'a-ba')").is_ok());
    }
}
