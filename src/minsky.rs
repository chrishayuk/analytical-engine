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
//! With `compile` and the trap endings, the deck has no card that chooses
//! between cards; `Ending::Cond1843` has one, the backing of Note G. One pass of a loop is one
//! step of the machine, and everything is done with + − ×, on whole numbers:
//! - the state is held one-hot: column S_j is 1 if the machine is in state j,
//!   and 0 otherwise;
//! - [c_r > 0] for each counter is the flag of `docs/expressiveness.md`: a
//!   group passed c_r + 1 times, which writes 0 on its first pass and 1 after;
//! - each instruction i adds its effect times S_i into new state columns N_j
//!   and into the counters, so only the instruction of the current state acts;
//! - (`compile`) the loop's backing is counted, and its count is set inside the loop to
//!   2 − (S_j summed over halt states j): the backing is effective until the
//!   machine halts. That is the step no page read gives.
//!
//! The same translation is defined and proved correct in Lean
//! (`formal/Babbage/Minsky.lean`); the column layout here is the same.

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

/// The columns, as in `formal/Babbage/Minsky.lean`, for k counters and n
/// states.
pub struct Layout {
    pub k: usize,
    pub n: usize,
}

impl Layout {
    pub const WAS: usize = 1;
    pub const CNT: usize = 2;
    pub const T: usize = 3;
    pub const W: usize = 4;
    pub fn c(&self, r: usize) -> usize {
        5 + r
    }
    pub fn f(&self, r: usize) -> usize {
        5 + self.k + r
    }
    pub fn s(&self, j: usize) -> usize {
        5 + 2 * self.k + j
    }
    pub fn next(&self, j: usize) -> usize {
        5 + 2 * self.k + self.n + j
    }
}

/// How the deck ends each pass and how it computes [c_r > 0].
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Ending {
    /// `not-found`: the loop's count is set inside the loop (`compile` in
    /// `Minsky.lean`).
    CountInLoop,
    /// Model D, 30 May 1838: the flag groups as above; the pass ends
    /// `W := W − 1; 1 ÷ W; back to card 0 always`, which the mill cannot do
    /// once the machine has halted (`trapDeck` in `Trap.lean`).
    Trap1838,
    /// Model D, December 1837: backing only to card 0, so each flag is one
    /// operation repeated c_r times, its count read from the store
    /// (`trapDeck37`). No combinatorial card and no counted backing.
    Trap1837,
    /// The published accounts, 1842–1843: no combinatorial card, no counted
    /// backing and no repetition count. Each flag is a cycle that a result of
    /// the mill ends (Note G's V₁₀), and so is the loop: it backs while
    /// W − 1 = 1 − [halted] is greater than zero, and then the counters are
    /// given off and the deck halts by passing its last card (`deck43` in
    /// `formal/Babbage/Note43.lean`).
    Cond1843,
    /// Reading B of Note G (`1843-B`): each flag is a forward course chosen
    /// by a result (F := 0; ahead if c_r is zero; F := 1), and the loop is an
    /// unconditional backing (Vol 3 p 162) passed over, by a forward course,
    /// once W − 1 = 1 − [halted] is zero; then the counters are given off and
    /// the deck halts by passing its last card (`deckB` in `Note43.lean`).
    ForwardB,
}

/// The deck, as text for `sketch::read`. The machine starts in state 0 with
/// the counters `regs`; the deck's results are the counters when it halts.
pub fn compile(name: &str, prog: &[Ins], regs: &[i64]) -> String {
    compile_with(name, prog, regs, Ending::CountInLoop)
}

/// The deck for a given ending. With a trap, the results are the counters
/// left in the store (`Expect column`), and the deck says `Trap halts`.
pub fn compile_with(name: &str, prog: &[Ins], regs: &[i64], ending: Ending) -> String {
    let l = Layout {
        k: regs.len(),
        n: prog.len(),
    };
    let (was, cnt, t, w) = (Layout::WAS, Layout::CNT, Layout::T, Layout::W);
    let mut cards: Vec<String> = vec!["step:".into()];
    for r in 0..l.k {
        if ending == Ending::ForwardB {
            cards.push(format!("+ 0 0 > v{}", l.f(r)));
            cards.push(format!("ahead flagdone{r} if v{} zero", l.c(r)));
            cards.push(format!("+ 0 1 > v{}", l.f(r)));
            cards.push(format!("flagdone{r}:"));
            continue;
        }
        if ending == Ending::Cond1843 {
            cards.push(format!("+ 0 0 > v{was}"));
            cards.push(format!("flag{r}:"));
            cards.push(format!("+ v{was} 0 > v{}", l.f(r)));
            cards.push(format!("+ 0 1 > v{was}"));
            cards.push(format!("− 1 v{} > v{cnt}", l.f(r)));
            cards.push(format!("× v{} v{cnt} > v{cnt}", l.c(r)));
            cards.push(format!("back flag{r} if v{cnt}"));
            continue;
        }
        if ending == Ending::Trap1837 {
            cards.push(format!("+ 0 1 > v{}", l.f(r)));
            cards.push(format!("repeat × v{} 0 times v{}", l.f(r), l.c(r)));
            cards.push(format!("− 1 v{} > v{}", l.f(r), l.f(r)));
            continue;
        }
        cards.push(format!("× v{was} 0 > v{was}"));
        cards.push(format!("+ v{} 1 > v{cnt}", l.c(r)));
        cards.push(format!("set v{cnt}"));
        cards.push(format!("flag{r}:"));
        cards.push(format!("+ v{was} 0 > v{}", l.f(r)));
        cards.push(format!("+ 0 1 > v{was}"));
        cards.push(format!("back flag{r} counted"));
    }
    for j in 0..l.n {
        cards.push(format!("× v{} 0 > v{}", l.next(j), l.next(j)));
    }
    for (i, ins) in prog.iter().enumerate() {
        let si = l.s(i);
        match *ins {
            Ins::Inc(r, to) => {
                cards.push(format!("+ v{} v{si} > v{}", l.c(r), l.c(r)));
                cards.push(format!("+ v{} v{si} > v{}", l.next(to), l.next(to)));
            }
            Ins::Dec(r, a, b) => {
                cards.push(format!("× v{si} v{} > v{t}", l.f(r)));
                cards.push(format!("− v{} v{t} > v{}", l.c(r), l.c(r)));
                cards.push(format!("+ v{} v{t} > v{}", l.next(a), l.next(a)));
                cards.push(format!("− v{si} v{t} > v{t}"));
                cards.push(format!("+ v{} v{t} > v{}", l.next(b), l.next(b)));
            }
            Ins::Halt => cards.push(format!("+ v{} v{si} > v{}", l.next(i), l.next(i))),
        }
    }
    for j in 0..l.n {
        cards.push(format!("+ v{} 0 > v{}", l.next(j), l.s(j)));
    }
    cards.push(format!("+ 0 2 > v{w}"));
    for (j, _) in prog.iter().enumerate().filter(|(_, i)| matches!(i, Ins::Halt)) {
        cards.push(format!("− v{w} v{} > v{w}", l.s(j)));
    }
    let mut head = String::new();
    if ending == Ending::CountInLoop {
        cards.push(format!("set v{w}"));
        cards.push("back step counted".into());
        for r in 0..l.k {
            cards.push(format!("result v{}", l.c(r)));
        }
    } else if ending == Ending::ForwardB {
        cards.push(format!("− v{w} 1 > v{w}"));
        cards.push(format!("ahead done if v{w} zero"));
        cards.push("back step always".into());
        cards.push("done:".into());
        for r in 0..l.k {
            cards.push(format!("result v{}", l.c(r)));
        }
    } else if ending == Ending::Cond1843 {
        cards.push(format!("− v{w} 1 > v{w}"));
        cards.push(format!("back step if v{w}"));
        for r in 0..l.k {
            cards.push(format!("result v{}", l.c(r)));
        }
    } else {
        cards.push(format!("− v{w} 1 > v{w}"));
        cards.push(format!("÷ 1 v{w} > v{t}"));
        cards.push("back step always".into());
        head.push_str("Trap halts\n");
    }
    let store: Vec<String> = std::iter::once(format!("v{} = 1", l.s(0)))
        .chain(regs.iter().enumerate().map(|(r, v)| format!("v{} = {v}", l.c(r))))
        .collect();
    format!(
        "Deck {name}\nTitle \"counter machine {name}, translated\"\nStore {}\n{head}Cards\n{}\n",
        store.join(", "),
        cards.join("\n")
    )
}
