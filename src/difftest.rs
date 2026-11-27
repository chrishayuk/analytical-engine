//! Differential testing of `sketch.rs` against the Lean model
//! (`formal/Babbage/Machine.lean`, run by `formal/Diff.lean`).
//!
//! Each case is a deck in a form both read, and what the Rust machine does
//! with it. `scripts/lean-diff.sh` writes the cases, runs the Lean `step` on
//! each and compares. This is a test on the decks generated, not a proof that
//! the two agree on every deck.
//!
//! The decks are those the Lean model has: one destination for an operation,
//! no letters or rows of letter cards, no `result … off`, and no count of 0 on
//! the wheels before the first card. The Rust machine computes in `i128`
//! fractions and stops with an error when a number is too large; those cases
//! are left out, because the Lean fractions are unbounded.

use crate::minsky::{compile_with, Ending, Ins};
use crate::sketch::{as_rat, read, run_model, Card, Deck, Op, Outcome, Src, CONFIGS, DECKS};

fn op(o: Op) -> &'static str {
    match o {
        Op::Add => "add",
        Op::Sub => "sub",
        Op::Mul => "mul",
        Op::Div => "div",
    }
}

fn src(s: &Src) -> Option<String> {
    match s {
        Src::Col(c) => Some(format!("c{c}")),
        Src::Num(n) => Some(format!("n{n}")),
        _ => None,
    }
}

fn rat(r: crate::rat::Rat) -> String {
    if r.denom() == 1 {
        format!("{}", r.numer())
    } else {
        format!("{}/{}", r.numer(), r.denom())
    }
}

/// The deck in the form `formal/Diff.lean` reads, if the Lean model has it.
/// An operation card with several destinations becomes the operation into the
/// first and a copy into each of the others (`run_expand` in
/// `formal/Babbage/Multi.lean`: the same store), and the targets of backing
/// and forward cards move with the cards. The Lean side is given fuel for the
/// extra cards; decks with such cards are compared only when they halt.
pub fn lean_form(d: &Deck, fuel: usize, trap: bool) -> Option<String> {
    if !d.rows.is_empty() || d.wheels.is_some_and(|w| w < 1) {
        return None;
    }
    let size = |c: &Card| match c {
        Card::Op { to, .. } => to.len().max(1),
        _ => 1,
    };
    let mut at = vec![0usize];
    for c in &d.cards {
        at.push(at.last().unwrap() + size(c));
    }
    let widest = d.cards.iter().map(size).max().unwrap_or(1);
    let mut out = vec![format!("fuel {}", fuel * widest)];
    if trap {
        out.push("trap".into());
    }
    if let Some(w) = d.wheels {
        out.push(format!("wheels {w}"));
    }
    for (c, v) in &d.store {
        out.push(format!("store {c} {}", rat(as_rat(v)?)));
    }
    for card in &d.cards {
        match card {
            Card::Op { op: o, a, b, to } => {
                let (first, rest) = to.split_first()?;
                out.push(format!("op {} {} {} {first}", op(*o), src(a)?, src(b)?));
                for t in rest {
                    out.push(format!("op add c{first} n0 {t}"));
                }
            }
            Card::Repeat { op: o, col, b, n } => out.push(format!("rep {} {col} {} {}", op(*o), src(b)?, src(n)?)),
            Card::Set(s) => out.push(format!("set {}", src(s)?)),
            Card::Back { to, counted, .. } => out.push(format!("back {} {}", at[*to], u8::from(*counted))),
            Card::BackIf { to, col, .. } => out.push(format!("backif {} {col}", at[*to])),
            Card::AheadIf { to, col, .. } => out.push(format!("aheadif {} {col}", at[*to])),
            Card::Result { col, off: false } => out.push(format!("result {col}")),
            Card::Result { off: true, .. } => return None,
        }
    }
    Some(out.join("\n") + "\n")
}

/// What the Rust machine did, in the form `formal/Diff.lean` prints; `None`
/// if a number grew too large for `i128`.
pub fn outcome_form(r: &Result<Outcome, String>) -> Option<String> {
    let o = match r {
        Err(e) if e.contains("too large") => return None,
        Err(_) => return Some("err\n".into()),
        Ok(o) => o,
    };
    let status = if o.halted {
        "halt"
    } else if o.trapped.is_some() {
        "trap"
    } else {
        "running"
    };
    let mut outs = vec![];
    for v in &o.results {
        outs.push(rat(as_rat(v)?));
    }
    let mut store = vec![];
    for (c, v) in &o.store {
        let r = as_rat(v)?;
        if !r.is_zero() {
            store.push(format!("{c}={}", rat(r)));
        }
    }
    Some(format!("{status}\nout {}\nstore {}\n", outs.join(" "), store.join(" ")))
}

/// A small generator, so that the cases are the same on every run.
struct Rng(u64);
impl Rng {
    fn next(&mut self) -> u64 {
        self.0 ^= self.0 << 13;
        self.0 ^= self.0 >> 7;
        self.0 ^= self.0 << 17;
        self.0
    }
    fn below(&mut self, n: u64) -> u64 {
        self.next() % n
    }
    fn int(&mut self, lo: i64, hi: i64) -> i64 {
        lo + self.below((hi - lo + 1) as u64) as i64
    }
}

fn random_deck(rng: &mut Rng) -> Deck {
    let mut d = read("Deck random\nCards\nresult v0\n").unwrap();
    d.cards.clear();
    let len = 2 + rng.below(10) as usize;
    let col = |rng: &mut Rng| rng.below(5) as usize;
    let s = |rng: &mut Rng| {
        if rng.below(2) == 0 {
            Src::Col(rng.below(5) as usize)
        } else {
            Src::Num(rng.int(-3, 3))
        }
    };
    let ops = [Op::Add, Op::Sub, Op::Mul, Op::Div];
    for i in 0..len {
        let card = match rng.below(10) {
            0..=3 => Card::Op {
                op: ops[rng.below(4) as usize],
                a: s(rng),
                b: s(rng),
                to: vec![col(rng)],
            },
            4 => Card::Repeat {
                op: ops[rng.below(4) as usize],
                col: col(rng),
                b: s(rng),
                n: if rng.below(2) == 0 {
                    Src::Col(col(rng))
                } else {
                    Src::Num(rng.int(-1, 3))
                },
            },
            5 => Card::Set(if rng.below(2) == 0 {
                Src::Col(col(rng))
            } else {
                Src::Num(rng.int(0, 3))
            }),
            8 if i > 0 && rng.below(2) == 0 => Card::BackIf {
                to: rng.below(i as u64 + 1) as usize,
                label: String::new(),
                col: col(rng),
            },
            6 | 7 => Card::Back {
                to: rng.below(i as u64 + 1) as usize,
                label: String::new(),
                counted: rng.below(4) != 0,
            },
            _ => Card::Result {
                col: col(rng),
                off: false,
            },
        };
        d.cards.push(card);
    }
    // A backing made effective by a result can pass a card many times, and a
    // repetition count read from a column it has grown would take too long to
    // run: in those decks the repetition counts are number cards.
    if d.cards.iter().any(|c| matches!(c, Card::BackIf { .. })) {
        for c in d.cards.iter_mut() {
            if let Card::Repeat { n, .. } = c {
                if matches!(n, Src::Col(_)) {
                    *n = Src::Num(2);
                }
            }
        }
    }
    for c in 0..5 {
        if rng.below(2) == 0 {
            let v = rng.int(-4, 6);
            d.store
                .push((c, crate::algebra::Value::constant(crate::rat::Rat::int(v as i128))));
        }
    }
    if rng.below(2) == 0 {
        d.wheels = Some(rng.int(1, 4));
    }
    d
}

/// Every case: (name, the deck for Lean, what Rust did). The control decks
/// under the first configuration that accepts them; the counter-machine decks
/// of `minsky.rs`; and `n` random decks, each with and without the trap.
pub fn cases(n: usize) -> Vec<(String, String, String)> {
    let mut all = vec![];
    let mut push = |name: String, d: &Deck, fuel: usize, trap: bool| {
        let Some(c) = CONFIGS.iter().find(|c| crate::sketch::accepts(c, d).is_ok()) else {
            return;
        };
        let mut d2 = read("Deck x\nCards\nresult v0\n").unwrap();
        d2.cards = d.cards.clone();
        d2.store = d.store.clone();
        d2.rows = d.rows.clone();
        d2.wheels = d.wheels;
        d2.stop_cards = fuel;
        let (Some(l), Some(r)) = (lean_form(d, fuel, trap), outcome_form(&run_model(c, &d2, trap))) else {
            return;
        };
        all.push((name, l, r));
    };
    for (name, text) in DECKS {
        let d = read(text).unwrap();
        push(format!("deck-{name}"), &d, d.stop_cards.min(200_000), d.trap);
    }
    // Note G, as printed and corrected (operation cards with several
    // destinations, fractions, the backing of Note G).
    for (name, text) in [
        ("note-g-printed", include_str!("../control/note-g-printed.txt")),
        ("note-g-corrected", include_str!("../control/note-g-corrected.txt")),
        ("note-g-reading-b", include_str!("../control/note-g-reading-b.txt")),
    ] {
        let d = read(text).unwrap();
        push(format!("deck-{name}"), &d, 100_000, false);
    }
    let add = [Ins::Dec(1, 1, 2), Ins::Inc(0, 0), Ins::Halt];
    for (e, tag) in [
        (Ending::CountInLoop, "loop"),
        (Ending::Trap1838, "trap1838"),
        (Ending::Trap1837, "trap1837"),
        (Ending::Cond1843, "cond1843"),
        (Ending::ForwardB, "forwardB"),
    ] {
        for regs in [[3, 4], [0, 2]] {
            let d = read(&compile_with("add", &add, &regs, e)).unwrap();
            push(format!("minsky-add-{tag}-{}-{}", regs[0], regs[1]), &d, 100_000, d.trap);
        }
    }
    let mut rng = Rng(0x9e37_79b9_7f4a_7c15);
    for i in 0..n {
        let d = random_deck(&mut rng);
        for trap in [false, true] {
            push(
                format!("random-{i:05}-{}", if trap { "trap" } else { "plain" }),
                &d,
                300,
                trap,
            );
        }
    }
    all
}
