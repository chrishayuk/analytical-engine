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
