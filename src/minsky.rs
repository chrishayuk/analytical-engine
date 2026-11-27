//! A translation from counter machines (Minsky's register machines) into
//! decks for `sketch.rs`, to test what the configuration labelled
//! `not-found` adds: a count set inside the group it counts.
//!
//! Counter machines with two counters can compute every computable function
//! (Minsky 1967), so a correct translation for every machine would make the
//! `not-found` configuration general. The translation here is tested on
//! machines (`tests/control.rs`), not proved correct, and `not-found` is
//! not a configuration any page read gives.
//!
//! The deck has no card that chooses between cards. One pass of a loop is one
//! step of the machine, and everything is done by arithmetic:
//! - the state q is a number in the store; [q = i] is a polynomial in q
//!   (the Lagrange polynomial that is 1 at i and 0 at the other states),
//!   computed with + − × ÷;
//! - [r > 0] for each counter is the flag of `docs/expressiveness.md`: a
//!   group passed r + 1 times, which writes 0 on its first pass and 1 after;
//! - the counters and the state are updated by the sums of the instructions'
//!   effects, each multiplied by its [q = i];
//! - the loop's backing is counted, and its count is set inside the loop to
//!   2 − [q = halt]: the backing is effective until the machine halts.
//!   That is the step no page read gives.

/// An instruction. States are numbered from 0; the machine starts in 0.
#[derive(Clone, Copy, Debug)]
pub enum Ins {
    /// Add 1 to counter r, then go to state n.
    Inc(usize, usize),
    /// If counter r > 0, subtract 1 and go to state a; otherwise go to b.
    Dec(usize, usize, usize),
    Halt,
}

/// Run the machine directly. `None` if it has not halted within `steps`.
pub fn simulate(prog: &[Ins], regs: &[i64], steps: usize) -> Option<Vec<i64>> {
    let mut r = regs.to_vec();
    let mut q = 0;
    for _ in 0..steps {
        match prog[q] {
            Ins::Inc(i, n) => {
                r[i] += 1;
                q = n;
            }
            Ins::Dec(i, a, b) => {
                if r[i] > 0 {
                    r[i] -= 1;
                    q = a;
                } else {
                    q = b;
                }
            }
            Ins::Halt => return Some(r),
        }
    }
    None
}

/// The deck, as text for `sketch::read`. Column 1 holds the state, column
/// 10 + i counter i, and columns from 100 the working.
pub fn compile(name: &str, prog: &[Ins], regs: &[i64]) -> String {
    let q = 1;
    let reg = |i: usize| 10 + i;
    let n = prog.len();
    let halt = prog.iter().position(|i| matches!(i, Ins::Halt)).expect("a halt state");
    let mut next = 100;
    let mut cards: Vec<String> = vec![];
    let store: Vec<String> = std::iter::once(format!("v{q} = 0"))
        .chain(regs.iter().enumerate().map(|(i, v)| format!("v{} = {v}", reg(i))))
        .collect();
    cards.push("step:".into());
    // [r > 0] for each counter tested.
    let mut flag = vec![0; regs.len()];
    let tested: std::collections::BTreeSet<usize> = prog
        .iter()
        .filter_map(|i| match i {
            Ins::Dec(r, _, _) => Some(*r),
            _ => None,
        })
        .collect();
    for (k, &r) in tested.iter().enumerate() {
        let (cnt, was, f) = (col(&mut next), col(&mut next), col(&mut next));
        cards.push(format!("× v{was} 0 > v{was}"));
        cards.push(format!("+ v{} 1 > v{cnt}", reg(r)));
        cards.push(format!("set v{cnt}"));
        cards.push(format!("flag{k}:"));
        cards.push(format!("+ v{was} 0 > v{f}"));
        cards.push(format!("+ 0 1 > v{was}"));
        cards.push(format!("back flag{k} counted"));
        flag[r] = f;
    }
    // The new state and counters, from each instruction's effect times [q = i].
    let q2 = col(&mut next);
    cards.push(format!("× v{q2} 0 > v{q2}"));
    for (i, ins) in prog.iter().enumerate() {
        let e = indicator(&mut cards, &mut next, n, q, i);
        let t = col(&mut next);
        match *ins {
            Ins::Inc(r, to) => {
                cards.push(format!("+ v{} v{e} > v{}", reg(r), reg(r)));
                cards.push(format!("× v{e} {to} > v{t}"));
                cards.push(format!("+ v{q2} v{t} > v{q2}"));
            }
            Ins::Dec(r, a, b) => {
                let z = flag[r];
                // r −= e·z; q' += e·(z·a + (1 − z)·b) = e·(b + z·(a − b)).
                cards.push(format!("× v{e} v{z} > v{t}"));
                cards.push(format!("− v{} v{t} > v{}", reg(r), reg(r)));
                if a >= b {
                    cards.push(format!("× v{z} {} > v{t}", a - b));
                    cards.push(format!("+ v{t} {b} > v{t}"));
                } else {
                    cards.push(format!("× v{z} {} > v{t}", b - a));
                    cards.push(format!("− {b} v{t} > v{t}"));
                }
                cards.push(format!("× v{e} v{t} > v{t}"));
                cards.push(format!("+ v{q2} v{t} > v{q2}"));
            }
            Ins::Halt => {
                cards.push(format!("× v{e} {halt} > v{t}"));
                cards.push(format!("+ v{q2} v{t} > v{q2}"));
            }
        }
    }
    cards.push(format!("+ v{q2} 0 > v{q}"));
    // The count for the loop's own backing: 2 − [q = halt].
    let e = indicator(&mut cards, &mut next, n, q, halt);
    let w = col(&mut next);
    cards.push(format!("− 2 v{e} > v{w}"));
    cards.push(format!("set v{w}"));
    cards.push("back step counted".into());
    for i in 0..regs.len() {
        cards.push(format!("result v{}", reg(i)));
    }
    format!(
        "Deck {name}\nTitle \"counter machine {name}, translated\"\nStore {}\nCards\n{}\n",
        store.join(", "),
        cards.join("\n")
    )
}

fn col(next: &mut usize) -> usize {
    *next += 1;
    *next
}

/// [x = i] for states 0..n, x in column x, into a new column.
fn indicator(cards: &mut Vec<String>, next: &mut usize, n: usize, x: usize, i: usize) -> usize {
    let e = col(next);
    cards.push(format!("× v{e} 0 > v{e}"));
    cards.push(format!("+ v{e} 1 > v{e}"));
    let t = col(next);
    for j in (0..n).filter(|&j| j != i) {
        cards.push(format!("− v{x} {j} > v{t}"));
        if i > j {
            cards.push(format!("÷ v{t} {} > v{t}", i - j));
        } else {
            cards.push(format!("÷ v{t} {} > v{t}", j - i));
            cards.push(format!("− 0 v{t} > v{t}"));
        }
        cards.push(format!("× v{e} v{t} > v{e}"));
    }
    e
}
