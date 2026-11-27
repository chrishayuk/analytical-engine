//! The mechanical notation of Series F: three designs for multiplication
//! (F/001-002, about 1835; F/013, 5 Jan 1836; F/018-019, 11 Jan 1836), as
//! far as the sheets can be read: the first two of four layers.
//!
//! 1. **The notation**: every mark of the transcription, as written, with
//!    its row and column (`mechanical/*.txt`).
//! 2. **Timing**: which parts act in which row of a band, and in what order.
//!
//! The other two layers are not built, and cannot be yet:
//! 3. **Mechanical state** (axes, pinions, wheels) needs the mill drawings,
//!    including the multiplying-pinion drawing F/001's cover refers to,
//!    whose number is left blank. It also needs the meaning of the marks no
//!    source explains: "IF", the Y mark, double arrows, hatching.
//! 4. **Arithmetic** must come out of layer 3, not be put in beside it.
//!
//! One check of figures is made, and it is not layer 4: F/018-019 write the
//! product in every band, and [`f018_states`] compares each with the one
//! before by Babbage's own word for the band ("Add", "Step up").
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

/// The designs transcribed: a name, and each band as (sheet, number, text).
pub struct Design {
    pub key: &'static str,
    pub name: &'static str,
    pub bands: &'static [(&'static str, u8, &'static str)],
}

pub const DESIGNS: &[Design] = &[
    Design {
        key: "F001",
        name: "Multiply a, b, c, d by 1021, without table (F/001-002, about 1835)",
        bands: CYCLES,
    },
    Design {
        key: "F013",
        name: "Table multiplication (F/013, 5 Jan 1836)",
        bands: &[
            ("BAB/F/013", 1, include_str!("../mechanical/F013-cycle1.txt")),
            ("BAB/F/013", 2, include_str!("../mechanical/F013-cycle2.txt")),
            ("BAB/F/013", 3, include_str!("../mechanical/F013-cycle3.txt")),
            ("BAB/F/013", 4, include_str!("../mechanical/F013-cycle4.txt")),
            ("BAB/F/013", 5, include_str!("../mechanical/F013-cycle5.txt")),
        ],
    },
    Design {
        key: "F018",
        name: "1028 × 201, without table (F/018-019, 11 Jan 1836)",
        bands: &[
            ("BAB/F/018", 1, include_str!("../mechanical/F018-cycle1.txt")),
            ("BAB/F/018", 2, include_str!("../mechanical/F018-cycle2.txt")),
            ("BAB/F/018", 3, include_str!("../mechanical/F018-cycle3.txt")),
            ("BAB/F/019", 4, include_str!("../mechanical/F019-cycle4.txt")),
            ("BAB/F/019", 5, include_str!("../mechanical/F019-cycle5.txt")),
            ("BAB/F/019", 6, include_str!("../mechanical/F019-cycle6.txt")),
        ],
    },
];

/// A figure Babbage wrote in a column (by its id, `e33`) in a band's own
/// rows (not the repeated top rows), of the given number of places (the
/// product is written to six; F/019 band 5 also writes a working "1028"
/// under it).
pub fn written(marks: &[Mark], col: &str, places: usize) -> Option<String> {
    marks
        .iter()
        .filter(|m| !m.top && m.kind == Kind::Figure)
        .filter(|m| m.column.split_whitespace().next() == Some(col))
        .filter_map(|m| m.mark.split('"').nth(1).map(str::to_string))
        .find(|f| f.chars().all(|c| c.is_ascii_digit()) && f.len() == places)
}

/// A band of F/018-019: its number, its word, the product written, and
/// whether the product follows from the one before by that word.
pub type BandState = (u8, String, Option<i64>, Result<(), String>);

/// The recorded states of F/018-019, checked against the words of each
/// band: where a band says "Add", the product it writes is the one before
/// plus the multiplicand that band writes; where it says "Step up", the one
/// before times ten. This checks Babbage's own figures against his own
/// words. It is not a simulation of the mechanism, and no mark is given a
/// meaning.
pub fn f018_states() -> Result<Vec<BandState>, String> {
    let texts: Vec<(u8, &str)> = DESIGNS[2].bands.iter().map(|(_, n, t)| (*n, *t)).collect();
    recorded_states(&texts)
}

/// The check behind [`f018_states`], on any bands. A band that cannot be
/// read is an error. A band that says neither word, or both, or that writes
/// no multiplicand where it says "Add", fails: nothing is supplied in place
/// of what the sheet does not write.
pub fn recorded_states(bands: &[(u8, &str)]) -> Result<Vec<BandState>, String> {
    let mut out = vec![];
    let mut prev: Option<i64> = None;
    for (n, text) in bands {
        let band = read(text).map_err(|e| format!("band {n}: {e}"))?;
        let marks = &band.marks;
        let words: Vec<&str> = marks
            .iter()
            .filter(|m| m.kind == Kind::Words)
            .map(|m| m.mark.as_str())
            .collect();
        let add = words.iter().any(|w| w.contains("Add"));
        let step = words.iter().any(|w| w.contains("Step up"));
        let product = match written(marks, "e33", 6) {
            Some(p) => Some(
                p.parse::<i64>()
                    .map_err(|e| format!("band {n}: the product {p}: {e}"))?,
            ),
            None => None,
        };
        let mult = written(marks, "e13", 4).and_then(|p| p.parse::<i64>().ok());
        let said = match (add, step) {
            (true, false) => "Add",
            (false, true) => "Step up",
            (true, true) => "both",
            (false, false) => "neither",
        };
        let r = match (prev, product) {
            (_, None) => Err("no product written".into()),
            (None, Some(0)) => Ok(()),
            (None, Some(p)) => Err(format!("starts at {p}")),
            (Some(a), Some(p)) => {
                let want = match (said, mult) {
                    ("Add", Some(m)) => Ok(a + m),
                    ("Add", None) => Err("says Add, and writes no multiplicand".to_string()),
                    ("Step up", _) => Ok(a * 10),
                    (w, _) => Err(format!("says {w} of Add and Step up")),
                };
                match want {
                    Ok(w) if w == p => Ok(()),
                    Ok(w) => Err(format!("{said}: {a} gives {w}, the sheet writes {p}")),
                    Err(e) => Err(e),
                }
            }
        };
        out.push((*n, said.to_string(), product, r));
        if product.is_some() {
            prev = product;
        }
    }
    Ok(out)
}

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

/// A row of a band, as the sheet writes it: F/013 opens each band with a
/// row "2/3" and closes it with a row "1/3"; other rows are numbered.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Row {
    TwoThirds,
    N(u8),
    OneThird,
}

impl std::fmt::Display for Row {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            Row::TwoThirds => write!(f, "2/3"),
            Row::N(n) => write!(f, "{n}"),
            Row::OneThird => write!(f, "1/3"),
        }
    }
}

fn row(s: &str) -> Option<Row> {
    match s {
        "2/3" => Some(Row::TwoThirds),
        "1/3" => Some(Row::OneThird),
        _ => s.parse().ok().map(Row::N),
    }
}

pub struct Mark {
    /// The partial band above the first rule: rows of the band before, not
    /// of this one.
    pub top: bool,
    /// The row was written `~7`: the mark's place is approximate.
    pub approx: bool,
    /// The rows it spans, first and last.
    pub from: Row,
    pub to: Row,
    pub column: String,
    pub mark: String,
    pub note: String,
    pub kind: Kind,
}

/// A band as transcribed: the rows the sheet rules for it, in order; why it
/// is incomplete, if it is; and its marks.
pub struct Band {
    pub rows: Vec<Row>,
    pub incomplete: Option<String>,
    pub marks: Vec<Mark>,
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

/// `top-11`, `6`, `7-11`, `~7`, `2/3`, `11-1/3`.
fn rows(s: &str) -> Option<(bool, bool, Row, Row)> {
    let s = s.trim();
    let (approx, s) = match s.strip_prefix('~') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let (top, s) = match s.strip_prefix("top-") {
        Some(r) => (true, r),
        None => (false, s),
    };
    let (a, b) = s.split_once('-').unwrap_or((s, s));
    let (a, b) = (row(a)?, row(b)?);
    (a <= b).then_some((top, approx, a, b))
}

/// A `rows` line: `1-13`, `2/3, 1-15, 1/3`.
fn ruled(s: &str) -> Option<Vec<Row>> {
    let mut out = vec![];
    for item in s.split(',').map(str::trim) {
        match item.split_once('-') {
            Some((a, b)) => {
                let (a, b): (u8, u8) = (a.parse().ok()?, b.parse().ok()?);
                if a > b {
                    return None;
                }
                out.extend((a..=b).map(Row::N));
            }
            None => out.push(row(item)?),
        }
    }
    let mut sorted = out.clone();
    sorted.sort();
    sorted.dedup();
    (sorted == out && !out.is_empty()).then_some(out)
}

/// Read a band. It must declare its rows (`rows | ...`), and every mark of
/// the band's own must lie in them: nothing is padded out to a full cycle,
/// and no mark outside the rows ruled is accepted.
pub fn read(text: &str) -> Result<Band, String> {
    let mut out = vec![];
    let mut declared: Option<(Vec<Row>, Option<String>)> = None;
    for (i, line) in text.lines().enumerate() {
        let line = line.trim();
        if line.is_empty() || line.starts_with('%') {
            continue;
        }
        let f: Vec<&str> = line.split('|').map(str::trim).collect();
        if f[0] == "rows" {
            if declared.is_some() {
                return Err(format!("line {}: a second `rows`", i + 1));
            }
            let r = f
                .get(1)
                .and_then(|s| ruled(s))
                .ok_or_else(|| format!("line {}: the rows `{line}`", i + 1))?;
            let why = match f.get(2) {
                None => None,
                Some(s) => Some(
                    s.strip_prefix("incomplete:")
                        .map(|w| w.trim().to_string())
                        .ok_or_else(|| format!("line {}: `{s}`", i + 1))?,
                ),
            };
            declared = Some((r, why));
            continue;
        }
        if f.len() < 3 {
            return Err(format!("line {}: `{line}`", i + 1));
        }
        let (top, approx, from, to) = rows(f[0]).ok_or_else(|| format!("line {}: the row `{}`", i + 1, f[0]))?;
        if !top {
            let r = &declared
                .as_ref()
                .ok_or_else(|| format!("line {}: a mark before `rows`", i + 1))?
                .0;
            if !r.contains(&from) || !r.contains(&to) {
                return Err(format!("line {}: row `{}` is not among the rows ruled", i + 1, f[0]));
            }
        }
        out.push(Mark {
            top,
            approx,
            from,
            to,
            column: f[1].to_string(),
            mark: f[2].to_string(),
            note: f.get(3).map(|s| s.to_string()).unwrap_or_default(),
            kind: kind(f[2], f[1]),
        });
    }
    let (rows, incomplete) = declared.ok_or("no `rows` line")?;
    Ok(Band {
        rows,
        incomplete,
        marks: out,
    })
}

/// The column's number on the sheet, `c18` → 18, for ordering.
fn col_no(c: &str) -> u32 {
    c.trim_start_matches(['c', 'd', 'e', 't'])
        .chars()
        .take_while(|c| c.is_ascii_digit())
        .collect::<String>()
        .parse()
        .unwrap_or(999)
}

/// The timing chart of a band: for each column with a mark, what it has in
/// each row the sheet rules for the band, and no other.
pub fn chart(band: &Band) -> String {
    use std::collections::BTreeMap;
    let mut cols: BTreeMap<(u32, String), Vec<&Mark>> = BTreeMap::new();
    for m in band.marks.iter().filter(|m| !m.top && m.kind != Kind::Stray) {
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
        band.rows
            .iter()
            .map(|r| format!("{:>4}", r.to_string()))
            .collect::<String>()
    ));
    for ((_, name), ms) in &cols {
        let mut cells = vec![String::new(); band.rows.len()];
        for m in ms {
            for (i, r) in band.rows.iter().enumerate() {
                if *r < m.from || *r > m.to {
                    continue;
                }
                let s = if *r != m.from && m.kind == Kind::Arrow {
                    '|'
                } else {
                    sym(m)
                };
                if !cells[i].contains(s) {
                    cells[i].push(s);
                }
            }
        }
        let name: String = name.chars().take(52).collect();
        out.push_str(&format!(
            "{name:<52} {}\n",
            cells.iter().map(|c| format!("{c:>4}")).collect::<String>()
        ));
    }
    out
}

/// For each row the sheet rules for a band, the columns in which some
/// motion (an arrow) is under way.
pub fn in_motion(band: &Band) -> Vec<usize> {
    band.rows
        .iter()
        .map(|&r| {
            let mut cols: Vec<&str> = band
                .marks
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
