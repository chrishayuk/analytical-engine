//! The mechanical notation of Series F, as far as one cycle of BAB/F/001
//! (about 1835) can be read: the first two of four layers.
//!
//! 1. **The notation**: every mark of the transcription, as written, with
//!    its row and column (`mechanical/F001-cycle1.txt`).
//! 2. **Timing**: which parts act in which time unit, and in what order.
//!
//! The other two layers are not built, and cannot be yet:
//! 3. **Mechanical state** (axes, pinions, wheels) needs the 1835 mill
//!    drawings, including the multiplying-pinion drawing the cover refers
//!    to, whose number is left blank. It also needs the meaning of the
//!    marks no source explains: "IF", the Y mark, double arrows, hatching.
//! 4. **Arithmetic** must come out of layer 3, not be put in beside it. The
//!    cycle writes the multiplier's digits and their complements, and no
//!    value of a, b, c or d.
//!
//! Each kind of mark carries what is known of its meaning, and from where.
//! Nothing is guessed: a mark no source explains is "unknown".

pub const F001: &str = include_str!("../mechanical/F001-cycle1.txt");

/// Every cycle of the multiplication: F/001 cycles 1-3 and F/002 cycles
/// 4-6, numbered as the pencil figures in the right margin number them.
/// F/002 has no column heads; its d01-d56 are identified with F/001's
/// c01-c56 by the ruling (an inference: see sources/notes/F002.md).
pub const CYCLES: &[(&str, u8, &str)] = &[
    ("BAB/F/001", 1, include_str!("../mechanical/F001-cycle1.txt")),
    ("BAB/F/001", 2, include_str!("../mechanical/F001-cycle2.txt")),
    ("BAB/F/001", 3, include_str!("../mechanical/F001-cycle3.txt")),
    ("BAB/F/002", 4, include_str!("../mechanical/F002-cycle4.txt")),
    ("BAB/F/002", 5, include_str!("../mechanical/F002-cycle5.txt")),
    ("BAB/F/002", 6, include_str!("../mechanical/F002-cycle6.txt")),
];

/// The figures written on the multiplier's wheels (n to n-3) in a cycle,
/// as written, in order of the columns; "" where a wheel has none.
pub fn multiplier(marks: &[Mark]) -> String {
    let mut ds: Vec<(u32, char)> = marks
        .iter()
        .filter(|m| m.kind == Kind::Figure && m.mark.starts_with("digit"))
        .filter(|m| (46..=49).contains(&col_no(&m.column)))
        .filter_map(|m| m.mark.chars().last().map(|c| (col_no(&m.column), c)))
        .collect();
    ds.sort();
    ds.dedup_by_key(|d| d.0);
    ds.iter().map(|d| d.1).collect()
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub enum Kind {
    /// An arrow: a motion, downward or upward on the page.
    Arrow,
    /// A dotted line with no head.
    Rest,
    /// Babbage's words ("Gears with n.", "Carry", "Put in.").
    Words,
    /// A figure on a wheel.
    Figure,
    /// A mark no source found explains.
    Unknown,
    /// A stray mark, outside the table.
    Stray,
}

impl Kind {
    /// What is known of the meaning, and from where.
    pub fn meaning(self) -> &'static str {
        match self {
            Kind::Arrow => "a motion, its length its duration: Swade 2020 p. 22 (DE2, 1848), Bromley 1982 p. 207 (the 1838 mill); not yet shown for 1835",
            Kind::Rest => "rest: Babbage 1826 p. 259",
            Kind::Words => "Babbage's own words",
            Kind::Figure => "a figure, as written",
            Kind::Unknown => "unknown",
            Kind::Stray => "outside the table",
        }
    }
}

pub struct Mark {
    /// The time units it spans, first and last; `top` for the partial
    /// cycle above the first rule.
    pub top: bool,
    pub from: u8,
    pub to: u8,
    pub column: String,
    pub mark: String,
    pub note: String,
    pub kind: Kind,
}

fn kind(mark: &str, column: &str) -> Kind {
    let m = mark.to_lowercase();
    if column.starts_with("margin") {
        Kind::Stray
    } else if m.starts_with("digit") || m.starts_with("number") {
        Kind::Figure
    } else if m.starts_with("word") {
        Kind::Words
    } else if m.starts_with("dotted") {
        Kind::Rest
    } else if m.contains("double") || m.contains("y mark") || m.contains("y-type") {
        Kind::Unknown
    } else if m.contains("arrow") {
        Kind::Arrow
    } else {
        // IF, hatching, erased and unread marks.
        Kind::Unknown
    }
}

/// `top-11`, `6`, `7-11`, `~7`.
fn rows(s: &str) -> Option<(bool, u8, u8)> {
    let s = s.trim().trim_start_matches('~');
    let (top, s) = match s.strip_prefix("top-") {
        Some(r) => (true, r),
        None => (false, s),
    };
    let (a, b) = s.split_once('-').unwrap_or((s, s));
    Some((top, a.parse().ok()?, b.parse().ok()?))
}

pub fn read(text: &str) -> Result<Vec<Mark>, String> {
    let mut out = vec![];
    for (i, line) in text.lines().enumerate() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('%') {
            continue;
        }
        let f: Vec<&str> = line.split('|').map(str::trim).collect();
        if f.len() < 3 {
            return Err(format!("line {}: `{line}`", i + 1));
        }
        let (top, from, to) = rows(f[0]).ok_or_else(|| format!("line {}: the row `{}`", i + 1, f[0]))?;
        out.push(Mark {
            top,
            from,
            to,
            column: f[1].to_string(),
            mark: f[2].to_string(),
            note: f.get(3).map(|s| s.to_string()).unwrap_or_default(),
            kind: kind(f[2], f[1]),
        });
    }
    Ok(out)
}

/// The column's number on the sheet, `c18` → 18, for ordering.
fn col_no(c: &str) -> u32 {
    c.trim_start_matches(['c', 'd'])
        .chars()
        .take_while(|c| c.is_ascii_digit())
        .collect::<String>()
        .parse()
        .unwrap_or(999)
}

/// The timing chart of the complete cycle: for each column with a mark,
/// what it has in each of the 13 time units.
pub fn chart(marks: &[Mark]) -> String {
    use std::collections::BTreeMap;
    let mut cols: BTreeMap<(u32, String), Vec<&Mark>> = BTreeMap::new();
    for m in marks.iter().filter(|m| !m.top && m.kind != Kind::Stray) {
        cols.entry((col_no(&m.column), m.column.clone())).or_default().push(m);
    }
    let sym = |m: &Mark| match m.kind {
        Kind::Arrow if m.mark.contains("down") => '↓',
        Kind::Arrow => '↑',
        Kind::Rest => '·',
        Kind::Words => 'w',
        Kind::Figure => m.mark.chars().last().unwrap_or('#'),
        Kind::Unknown => '?',
        Kind::Stray => ' ',
    };
    let mut out = String::new();
    out.push_str(&format!(
        "{:<52} {}\n",
        "column",
        (1..=13).map(|r| format!("{r:>3}")).collect::<String>()
    ));
    for ((_, name), ms) in &cols {
        let mut cells = vec![String::new(); 13];
        for m in ms {
            for r in m.from..=m.to.min(13) {
                let c = &mut cells[(r - 1) as usize];
                let s = if r == m.from {
                    sym(m)
                } else if m.kind == Kind::Arrow {
                    '|'
                } else {
                    sym(m)
                };
                if !c.contains(s) {
                    c.push(s);
                }
            }
        }
        let name: String = name.chars().take(52).collect();
        out.push_str(&format!(
            "{name:<52} {}\n",
            cells.iter().map(|c| format!("{c:>3}")).collect::<String>()
        ));
    }
    out
}

/// For each time unit of the complete cycle, the columns in which some
/// motion (an arrow) is under way.
pub fn in_motion(marks: &[Mark]) -> Vec<usize> {
    (1..=13u8)
        .map(|r| {
            let mut cols: Vec<&str> = marks
                .iter()
                .filter(|m| !m.top && m.kind == Kind::Arrow && m.from <= r && r <= m.to)
                .map(|m| m.column.split_whitespace().next().unwrap_or(""))
                .collect();
            cols.sort();
            cols.dedup();
            cols.len()
        })
        .collect()
}
