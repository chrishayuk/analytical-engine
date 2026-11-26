//! What a run used of the machine: each capability, by a stable name, and
//! the rows that needed it. Found from the steps after the run, so that the
//! engine's rules are not changed by being counted.
//!
//! Only capabilities of the machine are listed here: what the engine could
//! do. How a sheet's notation is read (accents, the order of operands where
//! there is no right-hand column) and how the run checks (values as algebra,
//! strict runs) are not capabilities and have no dates.

use crate::expr::Held;
use crate::machine::{Run, Source};
use crate::page::{Cell, Op, Page};
use std::collections::BTreeMap;

/// A capability: its name, and what it is.
pub const CAPABILITIES: &[(&str, &str)] = &[
    ("read-to-zero", "Reading a column for the mill leaves it at zero"),
    (
        "table-kept",
        "The mill keeps a table of multiples for the next multiplication",
    ),
    (
        "table-of-second",
        "The table is made of the factor the next multiplication uses again, even when written second",
    ),
    (
        "transfer",
        "A number is moved from one column to another, not through an operation",
    ),
    ("complement", "A number is laid in a column as its complement"),
    (
        "complement-read",
        "A complement read into the mill gives the number it stands for",
    ),
    (
        "copy",
        "A number read is laid, as it is, in another column in the same row",
    ),
    (
        "move-with-operation",
        "A row moves a number while the mill operates on others",
    ),
    ("give-off-retain", "A column gives its number to the mill and keeps it"),
    ("sign-changed", "The mill gives out a result with its sign changed"),
    ("many-addends", "An addition takes more than two numbers"),
    (
        "input",
        "Numbers are given to the store from outside, between operations",
    ),
    (
        "carriages",
        "The store works as a difference engine, with carriages, and no mill",
    ),
    (
        "wheels",
        "Numbers on figure wheels of a fixed number of places; a complement is 10^k − x",
    ),
    (
        "loop",
        "Groups of cards backed by an apparatus, repeated until a column is at zero",
    ),
    (
        "letter-cards",
        "Rows of letter cards that advance and go back, choosing the quantities",
    ),
];

/// The capabilities a run used, each with the numbers of the rows that
/// used it (0 where the page as a whole does).
pub fn used(page: &Page, run: &Run) -> BTreeMap<&'static str, Vec<usize>> {
    let mut out: BTreeMap<&'static str, Vec<usize>> = BTreeMap::new();
    let mut add = |k: &'static str, n: usize| out.entry(k).or_default().push(n);
    if !page.decks.is_empty() {
        add("loop", 0);
    }
    if !page.letter_cards.is_empty() {
        add("letter-cards", 0);
    }
    if page.wheels.is_some() {
        add("wheels", 0);
    }
    let mut before: BTreeMap<usize, Held> = run
        .history
        .iter()
        .filter_map(|(c, h)| h.first().map(|v| (*c, v.clone())))
        .collect();
    for s in &run.steps {
        let r = &s.row;
        let n = r.number;
        if r.input {
            add("input", n);
        } else if r.actions.is_some() {
            add("carriages", n);
        } else if page.decks.is_empty() {
            let c = &s.cards;
            if !c.reads.is_empty() {
                add("read-to-zero", n);
            }
            if c.operands.iter().any(|(src, _)| matches!(src, Source::Table)) {
                add("table-kept", n);
            }
            if c.sign_changed {
                add("sign-changed", n);
            }
            if c.table_of_second {
                add("table-of-second", n);
            }
            if c.op.is_none() && !c.reads.is_empty() {
                add("transfer", n);
            }
            if c.op.is_some() && c.writes.iter().any(|(_, h)| matches!(h, Held::Complement(_))) {
                add("complement", n);
            }
            if c.op.is_none() && c.writes.iter().any(|(_, h)| matches!(h, Held::Complement(_))) {
                add("complement", n);
            }
            if c.reads
                .iter()
                .any(|x| matches!(before.get(x), Some(Held::Complement(_))))
                && c.op.is_some()
            {
                add("complement-read", n);
            }
            if c.op.is_some() {
                let read_vals: Vec<&Held> = c.reads.iter().filter_map(|x| before.get(x)).collect();
                let laid_again =
                    |h: &Held| !s.result.as_ref().is_some_and(|res| res.same(h)) && read_vals.iter().any(|v| v.same(h));
                // A complement read and laid again is a complement laid
                // (BAB/L/014); a plain number, a copy (BAB/L/017).
                if c.writes
                    .iter()
                    .any(|(_, h)| matches!(h, Held::Plain(_)) && laid_again(h))
                {
                    add("copy", n);
                }
                if c.writes
                    .iter()
                    .any(|(_, h)| matches!(h, Held::Complement(_)) && laid_again(h))
                {
                    add("complement", n);
                }
                let to_mill: Vec<usize> = c
                    .operands
                    .iter()
                    .filter_map(|(src, _)| match src {
                        Source::Read(x) => Some(*x),
                        Source::Table => None,
                    })
                    .collect();
                if c.reads.iter().any(|x| !to_mill.contains(x)) {
                    add("move-with-operation", n);
                }
            }
            if r.cells.iter().any(|(_, cell)| matches!(cell, Cell::Retain(_))) {
                add("give-off-retain", n);
            }
            if c.op == Some(Op::Add) && c.operands.len() > 2 {
                add("many-addends", n);
            }
        }
        before = s.store_after.clone();
    }
    out
}

/// A date as precise as the record gives it: year, month, day (0 where not
/// given); `before` where the record says only "before".
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct When {
    pub year: u16,
    pub month: u8,
    pub day: u8,
    pub before: bool,
}

impl std::fmt::Display for When {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        const M: [&str; 13] = [
            "", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
        ];
        if self.before {
            write!(f, "before ")?;
        }
        match (self.day, self.month) {
            (0, 0) => write!(f, "{}", self.year),
            (0, m) => write!(f, "{} {}", M[m as usize], self.year),
            (d, m) => write!(f, "{d} {} {}", M[m as usize], self.year),
        }
    }
}

impl When {
    /// Whether this is known to be no later than `o`; `None` where the
    /// record is too coarse to say (the same month, a day not given).
    pub fn not_after(&self, o: &When) -> Option<bool> {
        let a = (self.year, self.month);
        let b = (o.year, o.month);
        if a != b || self.month == 0 || o.month == 0 {
            if self.month == 0 || o.month == 0 {
                return (self.year != o.year).then_some(self.year < o.year);
            }
            return Some(a < b);
        }
        if self.day == 0 || o.day == 0 {
            return None;
        }
        Some(self.day <= o.day)
    }
}

/// `1836-03-07`, `1836-03`, `<1835-02-05`.
pub fn parse_iso(s: &str) -> Option<When> {
    let (before, s) = match s.strip_prefix('<') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let mut p = s.split('-').map(|x| x.parse::<u16>().ok());
    let year = p.next()??;
    let month = p.next().flatten().unwrap_or(0) as u8;
    let day = p.next().flatten().unwrap_or(0) as u8;
    Some(When {
        year,
        month,
        day,
        before,
    })
}

/// A sheet's date as the corpus writes it: `4 Aug 1837`, `Jun 1838`,
/// `before 22 Aug 1837`; `None` for an undated sheet.
pub fn sheet_date(s: &str) -> Option<When> {
    const M: [&str; 12] = [
        "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec",
    ];
    let mut w = When {
        year: 0,
        month: 0,
        day: 0,
        before: false,
    };
    for t in s.split_whitespace() {
        let l = t.to_lowercase();
        if l == "before" {
            w.before = true;
        } else if let Some(m) = M.iter().position(|m| l.starts_with(m)) {
            w.month = m as u8 + 1;
        } else if let Ok(n) = t.trim_end_matches(['.', ',']).parse::<u16>() {
            if n > 31 {
                w.year = n;
            } else {
                w.day = n as u8;
            }
        }
    }
    (w.year > 0).then_some(w)
}

pub struct Entry {
    pub capability: String,
    pub kind: String,
    pub when: When,
    pub source: String,
    pub direct: bool,
    pub words: String,
}

pub const CHRONOLOGY: &str = include_str!("../history/chronology.txt");

pub fn chronology() -> Result<Vec<Entry>, String> {
    let mut out = vec![];
    for (i, line) in CHRONOLOGY.lines().enumerate() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('%') {
            continue;
        }
        let f: Vec<&str> = line.split('|').map(str::trim).collect();
        let bad = || format!("history/chronology.txt:{}: `{line}`", i + 1);
        if f.len() != 6 {
            return Err(bad());
        }
        if !CAPABILITIES.iter().any(|c| c.0 == f[0]) {
            return Err(format!("{}: no capability `{}`", bad(), f[0]));
        }
        if !["conceived", "designed", "revised"].contains(&f[1]) || !["direct", "related"].contains(&f[4]) {
            return Err(bad());
        }
        out.push(Entry {
            capability: f[0].to_string(),
            kind: f[1].to_string(),
            when: parse_iso(f[2]).ok_or_else(bad)?,
            source: f[3].to_string(),
            direct: f[4] == "direct",
            words: f[5].to_string(),
        });
    }
    Ok(out)
}

/// How a page's use of a capability stands against the record before it.
#[derive(Debug, PartialEq)]
pub enum Standing {
    /// Babbage's record has the capability itself (direct) by then.
    Recorded,
    /// Only something it depends on or belongs with is recorded by then.
    RelatedOnly,
    /// An earlier dated sheet already uses it.
    UsedBefore,
    /// Nothing earlier: this sheet is the first evidence.
    FirstHere,
    /// The same month as the first record, and the record gives no day.
    SameMonth,
}

/// The standing of a capability used on a sheet of the given date, given
/// the record and the dates of the sheets that use it.
pub fn standing(cap: &str, at: &When, record: &[Entry], users: &[When]) -> Standing {
    let mut related = false;
    let mut same_month = false;
    for e in record.iter().filter(|e| e.capability == cap) {
        match e.when.not_after(at) {
            Some(true) if e.direct => return Standing::Recorded,
            Some(true) => related = true,
            None if e.direct => same_month = true,
            _ => {}
        }
    }
    if users.iter().any(|u| u.not_after(at) == Some(true) && u < at) {
        return Standing::UsedBefore;
    }
    if same_month {
        return Standing::SameMonth;
    }
    if related {
        return Standing::RelatedOnly;
    }
    Standing::FirstHere
}
