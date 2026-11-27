import Babbage.Tower

/-!
# Counter machines in the `not-found` configuration (argument E)

A counter machine (Minsky) is translated into a deck (`compile`, the same
translation as `src/minsky.rs`). The deck simulates the machine one step per
pass of a loop whose counted backing has its count set inside the loop: the
step of `not-found` that no page read gives. The theorems:

* `compile_accepted`: the deck is accepted by `not-found`;
* `compile_halts`: if the machine halts, the deck halts and gives off the
  counters of the halted machine;
* `machine_halts_of_compile`: if the deck halts, the machine halts.

Assumptions, all explicit: whole numbers of unbounded size (`intArith`); a
store with as many columns as the layout uses (5 + 2k + 2n, fixed by the
machine); the machine well formed (`WF`). Machines with two counters are
universal (Minsky 1967), with inputs and outputs coded as 2^x 3^y; that
classical result is cited, not formalised here.
-/

namespace Babbage.Minsky

open Babbage

inductive Ins where
  | inc (r to : Nat)
  | dec (r a b : Nat)
  | halt
  deriving DecidableEq

abbrev Prog := List Ins

structure MConf where
  q : Nat
  c : Nat → Nat

def mstep (P : Prog) (m : MConf) : MConf :=
  match P[m.q]? with
  | some (.inc r to) => ⟨to, upd m.c r (m.c r + 1)⟩
  | some (.dec r a b) => if 0 < m.c r then ⟨a, upd m.c r (m.c r - 1)⟩ else ⟨b, m.c⟩
  | _ => m

def mrun (P : Prog) : Nat → MConf → MConf
  | 0, m => m
  | t + 1, m => mrun P t (mstep P m)

abbrev Halted (P : Prog) (m : MConf) : Prop := P[m.q]? = some .halt

/-- Every state named is a state of the machine, every counter one of `k`. -/
def InsOK (k n : Nat) : Ins → Prop
  | .inc r to => r < k ∧ to < n
  | .dec r a b => r < k ∧ a < n ∧ b < n
  | .halt => True

def WF (P : Prog) (k : Nat) : Prop :=
  ∀ (i : Nat) ins, P[i]? = some ins → InsOK k P.length ins

/-! ## The layout and the deck -/

def WAS : Nat := 1
def CNT : Nat := 2
def T : Nat := 3
def W : Nat := 4
def C (r : Nat) : Nat := 5 + r
def F (k r : Nat) : Nat := 5 + k + r
def S (k j : Nat) : Nat := 5 + 2 * k + j
def N (k n j : Nat) : Nat := 5 + 2 * k + n + j

/-- `f 0 ++ f 1 ++ … ++ f (m - 1)`. -/
def upTo (f : Nat → List Card) : Nat → List Card
  | 0 => []
  | m + 1 => upTo f m ++ f m

/-- [c_r > 0] into F_r: a group passed c_r + 1 times, at card 6r. -/
def flagBlock (k r : Nat) : List Card :=
  [.op .mul (.col WAS) (.num 0) WAS,
   .op .add (.col (C r)) (.num 1) CNT,
   .set (.col CNT),
   .op .add (.col WAS) (.num 0) (F k r),
   .op .add (.num 0) (.num 1) WAS,
   .back (6 * r + 3) true]

def zeroCard (k n j : Nat) : List Card := [.op .mul (.col (N k n j)) (.num 0) (N k n j)]

def insBlock (k n i : Nat) : Ins → List Card
  | .inc r to =>
    [.op .add (.col (C r)) (.col (S k i)) (C r),
     .op .add (.col (N k n to)) (.col (S k i)) (N k n to)]
  | .dec r a b =>
    [.op .mul (.col (S k i)) (.col (F k r)) T,
     .op .sub (.col (C r)) (.col T) (C r),
     .op .add (.col (N k n a)) (.col T) (N k n a),
     .op .sub (.col (S k i)) (.col T) T,
     .op .add (.col (N k n b)) (.col T) (N k n b)]
  | .halt => [.op .add (.col (N k n i)) (.col (S k i)) (N k n i)]

def bodyCard (P : Prog) (k i : Nat) : List Card :=
  match P[i]? with
  | some ins => insBlock k P.length i ins
  | none => []

def copyCard (k n j : Nat) : List Card := [.op .add (.col (N k n j)) (.num 0) (S k j)]

def haltCard (P : Prog) (k j : Nat) : List Card :=
  match P[j]? with
  | some .halt => [.op .sub (.col W) (.col (S k j)) W]
  | _ => []

def resultCard (r : Nat) : List Card := [.result (C r)]

/-- The straight cards of one pass, after the flags. -/
def straight (P : Prog) (k : Nat) : List Card :=
  upTo (zeroCard k P.length) P.length ++ upTo (bodyCard P k) P.length ++
  upTo (copyCard k P.length) P.length ++ [.op .add (.num 0) (.num 2) W] ++
  upTo (haltCard P k) P.length

def compile (P : Prog) (k : Nat) : Deck :=
  upTo (flagBlock k) k ++ straight P k ++ [.set (.col W), .back 0 true] ++ upTo resultCard k

/-- The store the deck starts with: state 0, and the counters. -/
def initStore (k : Nat) (c : Nat → Nat) : Nat → Int :=
  fun x => if x = S k 0 then 1 else if C 0 ≤ x ∧ x < C k then (c (x - 5) : Int) else 0

/-! ## Running cards in place -/

/-- The cards `blk` stand at `p` in `d`. -/
def Seg (d : Deck) (p : Nat) (blk : List Card) : Prop :=
  ∀ i, i < blk.length → d[p + i]? = blk[i]?

theorem seg_append {d : Deck} {p : Nat} {a b : List Card} (h : Seg d p (a ++ b)) :
    Seg d p a ∧ Seg d (p + a.length) b := by
  constructor
  · intro i hi
    have := h i (by simp; omega)
    rw [this, List.getElem?_append_left hi]
  · intro i hi
    have := h (a.length + i) (by simp; omega)
    rw [← Nat.add_assoc] at this
    rw [this, List.getElem?_append_right (by omega)]
    simp

theorem seg_self (d : Deck) : Seg d 0 d := by intro i _; simp

theorem length_upTo (f : Nat → List Card) (l : Nat) (hf : ∀ m, (f m).length = l) :
    ∀ m, (upTo f m).length = l * m
  | 0 => by simp [upTo]
  | m + 1 => by simp [upTo, length_upTo f l hf m, hf, Nat.mul_succ]

theorem seg_upTo {d : Deck} {p : Nat} {f : Nat → List Card} {m : Nat}
    (h : Seg d p (upTo f m)) : ∀ j, j < m → Seg d (p + (upTo f j).length) (f j) := by
  induction m with
  | zero => intro j hj; omega
  | succ m ih =>
    intro j hj
    have ⟨h1, h2⟩ := seg_append h
    rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hj) with hj | rfl
    · exact ih h1 j hj
    · exact h2

/-- The value of an operation on whole numbers. -/
def ev : Op → Int → Int → Int
  | .add, a, b => a + b
  | .sub, a, b => a - b
  | .mul, a, b => a * b
  | .div, _, _ => 0

def val (st : Nat → Int) : Src → Int
  | .col i => st i
  | .num v => v

/-- An operation card other than division. -/
def IsOp : Card → Prop
  | .op o _ _ _ => o ≠ .div
  | _ => False

def execCard (st : Nat → Int) : Card → (Nat → Int)
  | .op o a b dst => upd st dst (ev o (val st a) (val st b))
  | _ => st

def exec (blk : List Card) (st : Nat → Int) : Nat → Int := blk.foldl execCard st

theorem exec_append (a b : List Card) (st : Nat → Int) :
    exec (a ++ b) st = exec b (exec a st) := by simp [exec, List.foldl_append]

theorem run_straight {d : Deck} :
    ∀ (blk : List Card) (p : Nat) (st : Nat → Int) (wh : Option Nat) (out : List Int),
      Seg d p blk → (∀ c ∈ blk, IsOp c) →
      run intArith d blk.length ⟨p, st, wh, out⟩ =
        .run ⟨p + blk.length, exec blk st, wh, out⟩
  | [], p, st, wh, out, _, _ => by simp [run, exec]
  | c :: rest, p, st, wh, out, hs, hop => by
    have hc : d[p]? = some c := by simpa using hs 0 (by simp)
    have hrest : Seg d (p + 1) rest := by
      intro i hi
      have := hs (i + 1) (by simp; omega)
      rw [show p + 1 + i = p + (i + 1) by omega, this]; simp
    have hstep : step intArith d ⟨p, st, wh, out⟩ = .run ⟨p + 1, execCard st c, wh, out⟩ := by
      have hc' := hop c (by simp)
      unfold step
      simp only [hc]
      cases c with
      | op o a b dst =>
        cases o with
        | div => exact absurd rfl hc'
        | add | sub | mul =>
          cases a <;> cases b <;> simp [fetch, intOp, execCard, ev, val]
      | _ => exact absurd hc' id
    simp only [List.length_cons, run, hstep]
    rw [run_straight rest (p + 1) _ wh out hrest (fun c h => hop c (by simp [h]))]
    simp [exec, Nat.add_assoc, Nat.add_comm 1]

theorem seg_get {d : Deck} {p : Nat} {blk : List Card} (h : Seg d p blk) {i : Nat}
    (hi : i < blk.length) : d[p + i]? = some blk[i] := by
  rw [h i hi]; simp [hi]

/-! ## The flag group -/

theorem intCount_succ (c : Nat) : intCount ((c : Int) + 1) = some (c + 1) := by
  unfold intCount
  split
  · congr 1
  · omega

section flag
variable {d : Deck} {k r : Nat} (hseg : Seg d (6 * r) (flagBlock k r))
include hseg

theorem flag_get (i : Nat) (hi : i < 6) : d[6 * r + i]? = some ((flagBlock k r)[i]'(by
    simp [flagBlock]; omega)) := seg_get hseg _

theorem flag_loop (hFW : F k r ≠ WAS) (out : List Int) :
    ∀ w (st : Nat → Int), st WAS = 1 →
      ∃ st', run intArith d (3 * (w + 1)) ⟨6 * r + 3, st, some (w + 1), out⟩ =
          .run ⟨6 * r + 6, st', some 0, out⟩ ∧ st' (F k r) = 1 ∧ st' WAS = 1 ∧
        ∀ x, x ≠ WAS → x ≠ F k r → st' x = st x := by
  have g3 : d[6 * r + 3]? = some (.op .add (.col WAS) (.num 0) (F k r)) := by
    simpa [flagBlock] using flag_get hseg 3 (by omega)
  have g4 : d[6 * r + 4]? = some (.op .add (.num 0) (.num 1) WAS) := by
    simpa [flagBlock] using flag_get hseg 4 (by omega)
  have g5 : d[6 * r + 5]? = some (.back (6 * r + 3) true) := by
    simpa [flagBlock] using flag_get hseg 5 (by omega)
  intro w
  induction w with
  | zero =>
    intro st h1
    refine ⟨upd (upd st (F k r) (st WAS + 0)) WAS (0 + 1), ?_, ?_, ?_, ?_⟩
    · simp [run, step, g3, g4, g5, fetch, intOp, Nat.add_assoc]
    · simp [upd, hFW, h1]
    · simp [upd]
    · intro x h1 h2; simp [upd, h1, h2]
  | succ w ih =>
    intro st h1
    let st1 := upd (upd st (F k r) (st WAS + 0)) WAS (0 + 1)
    have h1' : st1 WAS = 1 := by simp [st1, upd]
    obtain ⟨st', hrun, hF, hW, hx⟩ := ih st1 h1'
    refine ⟨st', ?_, hF, hW, ?_⟩
    · rw [show 3 * (w + 1 + 1) = 3 + 3 * (w + 1) by omega, run_add]
      simp [run, step, g3, g4, g5, fetch, intOp, Nat.add_assoc]
      simpa [st1] using hrun
    · intro x hx1 hx2; rw [hx x hx1 hx2]; simp [st1, upd, hx1, hx2]

/-- The flag group from its first card: [c_r > 0] in F_r, and the wheels at 0. -/
theorem flag_block (hC : 5 ≤ C r) (hF : 5 ≤ F k r) (out : List Int) (wh : Option Nat)
    (st : Nat → Int) (c : Nat) (hc : st (C r) = c) :
    ∃ n st', run intArith d n ⟨6 * r, st, wh, out⟩ = .run ⟨6 * r + 6, st', some 0, out⟩ ∧
      st' (F k r) = (if 0 < c then 1 else 0) ∧
      ∀ x, x ≠ WAS → x ≠ CNT → x ≠ F k r → st' x = st x := by
  have g0 : d[6 * r]? = some (.op .mul (.col WAS) (.num 0) WAS) := by
    simpa [flagBlock] using flag_get hseg 0 (by omega)
  have g1 : d[6 * r + 1]? = some (.op .add (.col (C r)) (.num 1) CNT) := by
    simpa [flagBlock] using flag_get hseg 1 (by omega)
  have g2 : d[6 * r + 2]? = some (.set (.col CNT)) := by
    simpa [flagBlock] using flag_get hseg 2 (by omega)
  have g3 : d[6 * r + 3]? = some (.op .add (.col WAS) (.num 0) (F k r)) := by
    simpa [flagBlock] using flag_get hseg 3 (by omega)
  have g4 : d[6 * r + 4]? = some (.op .add (.num 0) (.num 1) WAS) := by
    simpa [flagBlock] using flag_get hseg 4 (by omega)
  have g5 : d[6 * r + 5]? = some (.back (6 * r + 3) true) := by
    simpa [flagBlock] using flag_get hseg 5 (by omega)
  have hCW : C r ≠ WAS := by unfold WAS; omega
  have hFW : F k r ≠ WAS := by unfold WAS; omega
  have hFC : F k r ≠ CNT := by unfold CNT; omega
  -- after the three cards that set the count
  let st2 := upd (upd st WAS (st WAS * 0)) CNT ((c : Int) + 1)
  have h3 : run intArith d 3 ⟨6 * r, st, wh, out⟩ = .run ⟨6 * r + 3, st2, some (c + 1), out⟩ := by
    simp [run, step, g0, g1, g2, fetch, intOp, upd, hCW, hc, st2, Nat.add_assoc]
    simp [WAS, CNT, intCount_succ]
  -- the first pass writes 0
  let st3 := upd (upd st2 (F k r) (st2 WAS + 0)) WAS (0 + 1)
  have h30 : st2 WAS = 0 := by simp [st2, upd, WAS, CNT]
  have hframe3 : ∀ x, x ≠ WAS → x ≠ CNT → x ≠ F k r → st3 x = st x := by
    intro x h1 h2 h3; simp [st3, st2, upd, h1, h2, h3]
  cases c with
  | zero =>
    refine ⟨3 + 3, st3, ?_, ?_, hframe3⟩
    · rw [run_add, h3]
      simp [run, step, g3, g4, g5, fetch, intOp, Nat.add_assoc, st3]
    · simp [st3, upd, hFW, h30]
  | succ w =>
    have h3' : st3 WAS = 1 := by simp [st3, upd]
    obtain ⟨st', hrun, hF', _, hx⟩ := flag_loop hseg hFW out w st3 h3'
    refine ⟨3 + (3 + 3 * (w + 1)), st', ?_, ?_, ?_⟩
    · rw [run_add, h3]
      simp only
      rw [run_add]
      simp [run, step, g3, g4, g5, fetch, intOp, Nat.add_assoc]
      simpa [st3] using hrun
    · simp [hF']
    · intro x h1 h2 h3; rw [hx x h1 h3, hframe3 x h1 h2 h3]

end flag

theorem length_flags (k : Nat) : ∀ m, (upTo (flagBlock k) m).length = 6 * m :=
  length_upTo _ 6 (fun _ => by simp [flagBlock])

/-- All k flag groups: F_r = [c_r > 0] for every r < m; the counters, the
state and everything from column 5 on outside the flags left as they were. -/
theorem flags_run {d : Deck} {k : Nat} (hseg : Seg d 0 (upTo (flagBlock k) k)) (out : List Int)
    (c : Nat → Nat) : ∀ m, m ≤ k → ∀ (wh : Option Nat) (st : Nat → Int),
      (∀ r, r < k → st (C r) = c r) →
      ∃ n st' wh', run intArith d n ⟨0, st, wh, out⟩ = .run ⟨6 * m, st', wh', out⟩ ∧
        (∀ r, r < m → st' (F k r) = (if 0 < c r then 1 else 0)) ∧
        ∀ x, 5 ≤ x → (x < F k 0 ∨ F k m ≤ x) → st' x = st x := by
  intro m
  induction m with
  | zero => intro _ wh st _; exact ⟨0, st, wh, by simp [run], by simp, by simp⟩
  | succ m ih =>
    intro hm wh st hc
    obtain ⟨n, st1, wh1, h1, hF1, hx1⟩ := ih (by omega) wh st hc
    have hs : Seg d (6 * m) (flagBlock k m) := by
      have := seg_upTo hseg m (by omega)
      simpa [length_flags] using this
    have hcm : st1 (C m) = c m := by
      rw [hx1 _ (by unfold C; omega) (Or.inl (by unfold C F; omega))]; exact hc m (by omega)
    obtain ⟨n2, st2, h2, hF2, hx2⟩ :=
      flag_block hs (by unfold C; omega) (by unfold F; omega) out wh1 st1 (c m) hcm
    refine ⟨n + n2, st2, some 0, ?_, ?_, ?_⟩
    · rw [run_add, h1]; simpa [Nat.mul_succ] using h2
    · intro r hr
      rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hr) with hr | rfl
      · rw [hx2 _ (by unfold WAS F; omega) (by unfold CNT F; omega) (by unfold F; omega)]
        exact hF1 r hr
      · exact hF2
    · intro x h5 hx
      rw [hx2 _ (by unfold WAS; omega) (by unfold CNT; omega) (by unfold F at *; omega)]
      exact hx1 x h5 (by unfold F at *; omega)

/-! ## The straight cards: what they do to the store -/

theorem exec_frame {x : Nat} : ∀ (blk : List Card) (st : Nat → Int),
    (∀ c ∈ blk, ∀ o a b dst, c = Card.op o a b dst → dst ≠ x) → exec blk st x = st x
  | [], st, _ => rfl
  | c :: rest, st, h => by
    show exec rest (execCard st c) x = st x
    rw [exec_frame rest _ (fun c' hc' => h c' (by simp [hc']))]
    cases c with
    | op o a b dst => simp [execCard, upd, Ne.symm (h _ (by simp) o a b dst rfl)]
    | _ => rfl

theorem mem_upTo {f : Nat → List Card} {c : Card} : ∀ {m}, c ∈ upTo f m → ∃ j, j < m ∧ c ∈ f j
  | 0, h => by simp [upTo] at h
  | m + 1, h => by
    simp only [upTo, List.mem_append] at h
    rcases h with h | h
    · obtain ⟨j, hj, hc⟩ := mem_upTo h; exact ⟨j, by omega, hc⟩
    · exact ⟨m, by omega, h⟩

theorem exec_upTo_succ (f : Nat → List Card) (m : Nat) (st : Nat → Int) :
    exec (upTo f (m + 1)) st = exec (f m) (exec (upTo f m) st) := by
  simp [upTo, exec_append]

/-- What instruction i adds to column x, with v in S_i and z_r in F_r. -/
def delta (k n i : Nat) (v : Int) (z : Nat → Int) (x : Nat) : Ins → Int
  | .inc r to => (if x = C r then v else 0) + (if x = N k n to then v else 0)
  | .dec r a b => (if x = C r then -(v * z r) else 0) + (if x = N k n a then v * z r else 0) +
      (if x = N k n b then v - v * z r else 0)
  | .halt => if x = N k n i then v else 0

theorem ins_effect (k n i : Nat) (ins : Ins) (hi : i < n)
    (hwf : InsOK k n ins)
    (st : Nat → Int) (x : Nat) (hx : x ≠ T) :
    exec (insBlock k n i ins) st x =
      st x + delta k n i (st (S k i)) (fun r => st (F k r)) x ins := by
  have hT : ∀ y, 5 ≤ y → y ≠ T := by intro y h; unfold T; omega
  cases ins with
  | inc r to =>
    obtain ⟨hr, hto⟩ := hwf
    have d1 : C r ≠ S k i := by simp only [C, S]; omega
    have d2 : N k n to ≠ S k i := by simp only [N, S]; omega
    have d3 : N k n to ≠ C r := by simp only [N, C]; omega
    simp only [exec, insBlock, List.foldl, execCard, ev, val, delta, upd, d1, d2, d3,
      Ne.symm d1, Ne.symm d2, Ne.symm d3, if_neg, not_false_eq_true]
    by_cases h1 : x = N k n to
    · subst h1; simp only [if_pos, d3, if_neg, not_false_eq_true]; omega
    · by_cases h2 : x = C r
      · subst h2; simp only [h1, if_pos, if_neg, not_false_eq_true]; omega
      · simp only [h1, h2, if_neg, not_false_eq_true]; omega
  | dec r a b =>
    obtain ⟨hr, ha', hb'⟩ := hwf
    have e1 : T ≠ C r := by simp only [T, C]; omega
    have e2 : T ≠ S k i := by simp only [T, S]; omega
    have e3 : T ≠ F k r := by simp only [T, F]; omega
    have e4 : T ≠ N k n a := by simp only [T, N]; omega
    have e5 : T ≠ N k n b := by simp only [T, N]; omega
    have e6 : C r ≠ S k i := by simp only [C, S]; omega
    have e7 : C r ≠ F k r := by simp only [C, F]; omega
    have e8 : N k n a ≠ S k i := by simp only [N, S]; omega
    have e9 : N k n b ≠ S k i := by simp only [N, S]; omega
    have e10 : N k n a ≠ C r := by simp only [N, C]; omega
    have e11 : N k n b ≠ C r := by simp only [N, C]; omega
    have e12 : N k n a ≠ F k r := by simp only [N, F]; omega
    have e13 : N k n b ≠ F k r := by simp only [N, F]; omega
    have hst : exec (insBlock k n i (.dec r a b)) st =
        (let st1 := upd st T (st (S k i) * st (F k r))
         let st2 := upd st1 (C r) (st1 (C r) - st1 T)
         let st3 := upd st2 (N k n a) (st2 (N k n a) + st2 T)
         let st4 := upd st3 T (st3 (S k i) - st3 T)
         upd st4 (N k n b) (st4 (N k n b) + st4 T)) := rfl
    rw [hst]
    simp only [delta]
    have us : ∀ (f : Nat → Int) i v, upd f i v i = v := by intro f i v; simp [upd]
    have un : ∀ (f : Nat → Int) i v j, j ≠ i → upd f i v j = f j := by
      intro f i v j h; simp [upd, h]
    simp only [us, un _ _ _ _ e1, un _ _ _ _ e2, un _ _ _ _ e3, un _ _ _ _ e4, un _ _ _ _ e5,
      un _ _ _ _ e6, un _ _ _ _ e7, un _ _ _ _ e8, un _ _ _ _ e9, un _ _ _ _ e10, un _ _ _ _ e11,
      un _ _ _ _ e12, un _ _ _ _ e13, un _ _ _ _ (Ne.symm e1), un _ _ _ _ (Ne.symm e4),
      un _ _ _ _ (Ne.symm e2), un _ _ _ _ (Ne.symm e3), un _ _ _ _ (Ne.symm e6),
      un _ _ _ _ (Ne.symm e7), un _ _ _ _ (Ne.symm e8), un _ _ _ _ (Ne.symm e9),
      un _ _ _ _ (Ne.symm e12), un _ _ _ _ (Ne.symm e13),
      un _ _ _ _ (Ne.symm e5), un _ _ _ _ (Ne.symm e10), un _ _ _ _ (Ne.symm e11)]
    by_cases hab : a = b
    · subst hab
      by_cases h1 : x = N k n a
      · subst h1; simp only [us, un _ _ _ _ e10, un _ _ _ _ e4.symm, if_pos, if_neg, e10, not_false_eq_true]; omega
      · by_cases h2 : x = C r
        · subst h2
          simp only [us, un _ _ _ _ e11.symm, un _ _ _ _ e1.symm, un _ _ _ _ e10.symm, if_pos, h1,
            if_neg, not_false_eq_true]; omega
        · simp only [un _ _ _ _ h1, un _ _ _ _ h2, un _ _ _ _ hx, h1, h2, if_neg,
            not_false_eq_true]; omega
    · have e14 : N k n a ≠ N k n b := by simp only [N]; omega
      by_cases h1 : x = N k n b
      · subst h1
        simp only [us, un _ _ _ _ e14.symm, un _ _ _ _ e11, un _ _ _ _ e5.symm, if_pos, e11,
          e14.symm, if_neg, not_false_eq_true]; omega
      · by_cases h3 : x = N k n a
        · subst h3
          simp only [us, un _ _ _ _ e14, un _ _ _ _ e10, un _ _ _ _ e4.symm, if_pos, e10, e14,
            if_neg, not_false_eq_true]; omega
        · by_cases h2 : x = C r
          · subst h2
            simp only [us, un _ _ _ _ e11.symm, un _ _ _ _ e10.symm, un _ _ _ _ e1.symm, if_pos,
              h1, h3, if_neg, not_false_eq_true]; omega
          · simp only [un _ _ _ _ h1, un _ _ _ _ h2, un _ _ _ _ h3, un _ _ _ _ hx, h1, h2, h3,
              if_neg, not_false_eq_true]; omega
  | halt =>
    have d2 : N k n i ≠ S k i := by simp only [N, S]; omega
    simp only [exec, insBlock, List.foldl, execCard, ev, val, delta, upd, d2, if_neg,
      not_false_eq_true]
    by_cases h1 : x = N k n i
    · subst h1; simp only [if_pos]
    · simp only [h1, if_neg, not_false_eq_true]; omega

theorem delta_congr (k n i : Nat) (v : Int) (z z' : Nat → Int) (x : Nat) (ins : Ins)
    (hok : InsOK k n ins) (h : ∀ r, r < k → z r = z' r) :
    delta k n i v z x ins = delta k n i v z' x ins := by
  cases ins with
  | inc => rfl
  | dec r a b => simp only [delta, h r hok.1]
  | halt => rfl

theorem exec_single (c : Card) (st : Nat → Int) : exec [c] st = execCard st c := rfl

theorem delta_zero (k n i : Nat) (z : Nat → Int) (x : Nat) (ins : Ins) :
    delta k n i 0 z x ins = 0 := by
  cases ins <;> simp [delta]

theorem upd_same' (f : Nat → Int) (i : Nat) (v : Int) : upd f i v i = v := by simp [upd]
theorem upd_ne' (f : Nat → Int) {i j : Nat} (v : Int) (h : j ≠ i) : upd f i v j = f j := by
  simp [upd, h]

/-- The machine's state, one-hot in S, and its counters in C. -/
structure Enc (k n : Nat) (m : MConf) (st : Nat → Int) : Prop where
  q_lt : m.q < n
  s : ∀ j, j < n → st (S k j) = if j = m.q then 1 else 0
  c : ∀ r, r < k → st (C r) = m.c r

theorem zero_effect (k n : Nat) (st : Nat → Int) : ∀ m (x : Nat),
    exec (upTo (zeroCard k n) m) st x = if N k n 0 ≤ x ∧ x < N k n m then 0 else st x := by
  intro m
  induction m with
  | zero => intro x; simp [upTo, exec, N]; omega
  | succ m ih =>
    intro x
    rw [exec_upTo_succ]
    simp only [zeroCard, exec_single, execCard, ev, val]
    by_cases h : x = N k n m
    · subst h; rw [upd_same', ih]; simp [N]
    · rw [upd_ne' _ _ h, ih]
      split <;> split <;> first | rfl | (simp only [N] at *; omega)

theorem copy_effect (k n : Nat) (st : Nat → Int) : ∀ m, m ≤ n → ∀ (x : Nat),
    exec (upTo (copyCard k n) m) st x =
      if S k 0 ≤ x ∧ x < S k m then st (N k n (x - S k 0)) else st x := by
  intro m
  induction m with
  | zero => intro _ x; simp [upTo, exec, S]; omega
  | succ m ih =>
    intro hm x
    rw [exec_upTo_succ]
    simp only [copyCard, exec_single, execCard, ev, val]
    have hN : ∀ j, exec (upTo (copyCard k n) m) st (N k n j) = st (N k n j) := by
      intro j; rw [ih (by omega)]; split <;> first | rfl | (simp only [S, N] at *; omega)
    by_cases h : x = S k m
    · subst h; rw [upd_same', hN]; simp [S]
    · rw [upd_ne' _ _ h, ih (by omega)]
      split <;> split <;> first | rfl | (simp only [S] at *; omega)

theorem halt_effect (P : Prog) (k : Nat) (st : Nat → Int) : ∀ m (x : Nat),
    exec (upTo (haltCard P k) m) st x =
      if x = W then st W - (List.range m).foldl
        (fun acc j => acc + (match P[j]? with | some .halt => st (S k j) | _ => 0)) 0
      else st x := by
  have hWS : ∀ j, W ≠ S k j := by intro j; simp only [W, S]; omega
  intro m
  induction m with
  | zero => intro x; simp [upTo, exec]; intro h; subst h; rfl
  | succ m ih =>
    intro x
    rw [exec_upTo_succ, List.range_succ, List.foldl_append]
    simp only [haltCard]
    have e0 : ∀ f : Nat → Int, exec [] f = f := fun _ => rfl
    cases hm : P[m]? with
    | none => simp only; rw [e0, ih]; simp [List.foldl, hm]
    | some ins =>
      cases ins with
      | inc => simp only; rw [e0, ih]; simp [List.foldl, hm]
      | dec => simp only; rw [e0, ih]; simp [List.foldl, hm]
      | halt =>
        simp only [exec_single, execCard, ev, val]
        by_cases h : x = W
        · subst h
          rw [upd_same', ih W, ih (S k m), if_pos rfl, if_neg (Ne.symm (hWS m)), if_pos rfl]
          simp only [List.foldl, hm]; omega
        · rw [upd_ne' _ _ h, ih, if_neg h, if_neg h]

theorem wf_get {P : Prog} {k i : Nat} {ins : Ins} (hwf : WF P k) (h : P[i]? = some ins) :
    InsOK k P.length ins := hwf i ins h

/-- The body writes only counters, new-state columns and T: so the flags and
the state are left as they were. -/
theorem body_frame {P : Prog} {k : Nat} (hwf : WF P k) (m : Nat) (st : Nat → Int) (y : Nat)
    (hy : F k 0 ≤ y ∧ y < S k P.length) : exec (upTo (bodyCard P k) m) st y = st y := by
  apply exec_frame
  intro c hc o a b dst hcd
  obtain ⟨j, _, hc⟩ := mem_upTo hc
  simp only [bodyCard] at hc
  cases hj : P[j]? with
  | none => rw [hj] at hc; simp at hc
  | some ins =>
    rw [hj] at hc
    have hw := wf_get hwf hj
    simp only [F, S] at hy
    cases ins with
    | inc r to =>
      obtain ⟨hr, hto⟩ := hw
      simp [insBlock] at hc
      rcases hc with h | h <;> rw [h] at hcd <;> cases hcd <;> simp only [C, N] <;> omega
    | dec r a' b' =>
      obtain ⟨hr, ha, hb⟩ := hw
      simp [insBlock] at hc
      rcases hc with h | h | h | h | h <;> rw [h] at hcd <;> cases hcd <;>
        simp only [C, N, T] <;> omega
    | halt =>
      simp [insBlock] at hc
      rw [hc] at hcd; cases hcd; simp only [N]; omega

theorem body_effect {P : Prog} {k : Nat} (hwf : WF P k) (st : Nat → Int) (q : Nat)
    (hs : ∀ j, j < P.length → st (S k j) = if j = q then 1 else 0) (z : Nat → Int)
    (hz : ∀ r, r < k → st (F k r) = z r) :
    ∀ m, m ≤ P.length → ∀ x, x ≠ T → ¬(F k 0 ≤ x ∧ x < S k P.length) →
      exec (upTo (bodyCard P k) m) st x =
        st x + (if q < m then
          (match P[q]? with | some ins => delta k P.length q 1 z x ins | none => 0) else 0) := by
  intro m
  induction m with
  | zero => intro _ x _ _; simp [upTo, exec]
  | succ m ih =>
    intro hm x hxT hx
    rw [exec_upTo_succ]
    simp only [bodyCard]
    have hmn : m < P.length := by omega
    obtain ⟨ins, hins⟩ : ∃ ins, P[m]? = some ins := ⟨P[m], List.getElem?_eq_getElem hmn⟩
    rw [hins]
    simp only
    rw [ins_effect k P.length m ins hmn (wf_get hwf hins) _ x hxT, ih (by omega) x hxT hx]
    have hSm : exec (upTo (bodyCard P k) m) st (S k m) = st (S k m) :=
      body_frame hwf m st _ (by simp only [F, S]; omega)
    have hFr : (fun r => exec (upTo (bodyCard P k) m) st (F k r)) =
        (fun r => if r < k then z r else exec (upTo (bodyCard P k) m) st (F k r)) := by
      funext r; split
      · rw [body_frame hwf m st _ (by simp only [F, S]; omega)]; exact hz r (by assumption)
      · rfl
    rw [hSm, hs m hmn]
    by_cases hq : m = q
    · subst hq
      rw [if_pos rfl, if_neg (Nat.lt_irrefl m), if_pos (Nat.lt_succ_self m), hins]
      simp only
      rw [delta_congr k P.length m 1 _ z x ins (wf_get hwf hins) (fun r hr => by
        rw [body_frame hwf m st _ (by simp only [F, S]; omega)]; exact hz r hr)]
      omega
    · rw [if_neg hq, delta_zero]
      by_cases hqm : q < m
      · rw [if_pos hqm, if_pos (by omega)]; omega
      · rw [if_neg hqm, if_neg (by omega)]; omega

/-- The current instruction's effect is one step of the machine. -/
theorem delta_correct {P : Prog} {k : Nat} (hwf : WF P k) (m : MConf) (hq : m.q < P.length)
    (ins : Ins) (hins : P[m.q]? = some ins) :
    (∀ j, j < P.length → delta k P.length m.q 1 (fun r => if 0 < m.c r then 1 else 0)
        (N k P.length j) ins = if j = (mstep P m).q then 1 else 0) ∧
    (∀ r, r < k → (m.c r : Int) + delta k P.length m.q 1 (fun r => if 0 < m.c r then 1 else 0)
        (C r) ins = ((mstep P m).c r : Int)) := by
  have hok := wf_get hwf hins
  have hNC : ∀ j r, r < k → N k P.length j ≠ C r := by intro j r hr; simp only [N, C]; omega
  have hNN : ∀ j a, N k P.length j = N k P.length a ↔ j = a := by intro j a; simp only [N]; omega
  have hCC : ∀ r s, C r = C s ↔ r = s := by intro r s; simp only [C]; omega
  cases ins with
  | inc r0 to =>
    obtain ⟨hr0, hto⟩ := hok
    simp only [mstep, hins]
    refine ⟨fun j _ => ?_, fun r hr => ?_⟩
    · simp only [delta, if_neg (hNC j r0 hr0), hNN]; omega
    · simp only [delta, if_neg (Ne.symm (hNC to r hr)), hCC, upd]
      by_cases h : r = r0
      · subst h; simp
      · simp [h]
  | dec r0 a b =>
    obtain ⟨hr0, ha, hb⟩ := hok
    simp only [mstep, hins]
    by_cases hc : 0 < m.c r0
    · simp only [if_pos hc]
      refine ⟨fun j _ => ?_, fun r hr => ?_⟩
      · simp only [delta, if_neg (hNC j r0 hr0), hNN, if_pos hc]
        by_cases h1 : j = a <;> by_cases h2 : j = b <;> simp [h1, h2]
      · simp only [delta, if_neg (Ne.symm (hNC a r hr)), if_neg (Ne.symm (hNC b r hr)), hCC, upd,
          if_pos hc]
        by_cases h : r = r0
        · subst h; simp; omega
        · simp [h]
    · simp only [if_neg hc]
      refine ⟨fun j _ => ?_, fun r hr => ?_⟩
      · simp only [delta, if_neg (hNC j r0 hr0), hNN, if_neg hc]
        by_cases h1 : j = a <;> by_cases h2 : j = b <;> simp [h1, h2]
      · simp only [delta, if_neg (Ne.symm (hNC a r hr)), if_neg (Ne.symm (hNC b r hr)), hCC,
          if_neg hc]
        by_cases h : r = r0 <;> simp [h]
  | halt =>
    simp only [mstep, hins]
    refine ⟨fun j _ => ?_, fun r hr => ?_⟩
    · simp only [delta, hNN]
    · simp only [delta, if_neg (Ne.symm (hNC m.q r hr))]; omega

theorem halt_sum (P : Prog) (k q : Nat) (st : Nat → Int)
    (hs : ∀ j, j < P.length → st (S k j) = if j = q then 1 else 0) :
    ∀ m, m ≤ P.length → (List.range m).foldl
      (fun acc j => acc + (match P[j]? with | some .halt => st (S k j) | _ => 0)) 0 =
      if q < m ∧ P[q]? = some .halt then 1 else 0 := by
  intro m
  induction m with
  | zero => intro _; simp
  | succ m ih =>
    intro hm
    rw [List.range_succ, List.foldl_append, ih (by omega)]
    simp only [List.foldl]
    cases hpm : P[m]? with
    | none =>
      simp only [Int.add_zero]
      by_cases hqm : q = m
      · subst hqm; simp [hpm]
      · have hiff : (q < m + 1) ↔ (q < m) := by omega
        simp only [hiff]
    | some ins =>
      cases ins with
      | halt =>
        simp only [hs m (by omega)]
        by_cases h : m = q
        · subst h; simp [hpm]
        · have hiff : (q < m + 1) ↔ (q < m) := by omega
          simp only [hiff, if_neg h, Int.add_zero]
      | inc =>
        simp only [Int.add_zero]
        by_cases hqm : q = m
        · subst hqm; simp [hpm]
        · have hiff : (q < m + 1) ↔ (q < m) := by omega
          simp only [hiff]
      | dec =>
        simp only [Int.add_zero]
        by_cases hqm : q = m
        · subst hqm; simp [hpm]
        · have hiff : (q < m + 1) ↔ (q < m) := by omega
          simp only [hiff]

/-- **One pass of straight cards is one step of the machine.** -/
theorem straight_effect {P : Prog} {k : Nat} (hwf : WF P k) (m : MConf) (st : Nat → Int)
    (henc : Enc k P.length m st)
    (hF : ∀ r, r < k → st (F k r) = if 0 < m.c r then 1 else 0) :
    Enc k P.length (mstep P m) (exec (straight P k) st) ∧
      exec (straight P k) st W = 2 - (if Halted P (mstep P m) then 1 else 0) := by
  have hq := henc.q_lt
  obtain ⟨ins, hins⟩ : ∃ ins, P[m.q]? = some ins := ⟨P[m.q], List.getElem?_eq_getElem hq⟩
  have hdc := delta_correct hwf m hq ins hins
  -- the five parts
  let st1 := exec (upTo (zeroCard k P.length) P.length) st
  let st2 := exec (upTo (bodyCard P k) P.length) st1
  let st3 := exec (upTo (copyCard k P.length) P.length) st2
  let st4 := exec [.op .add (.num 0) (.num 2) W] st3
  have hsplit : exec (straight P k) st = exec (upTo (haltCard P k) P.length) st4 := by
    simp only [straight, exec_append, st4, st3, st2, st1]
  have h1 : ∀ x, st1 x = if N k P.length 0 ≤ x ∧ x < N k P.length P.length then 0 else st x := zero_effect k P.length st P.length
  have hs1 : ∀ j, j < P.length → st1 (S k j) = if j = m.q then 1 else 0 := by
    intro j hj; rw [h1, if_neg (by simp only [N, S]; omega)]; exact henc.s j hj
  have hF1 : ∀ r, r < k → st1 (F k r) = if 0 < m.c r then 1 else 0 := by
    intro r hr; rw [h1, if_neg (by simp only [N, F]; omega)]; exact hF r hr
  have h2 := body_effect hwf st1 m.q hs1 _ hF1 P.length (Nat.le_refl _)
  simp only [hq, if_true, hins] at h2
  have h3 : ∀ x, st3 x = if S k 0 ≤ x ∧ x < S k P.length then st2 (N k P.length (x - S k 0)) else st2 x :=
    copy_effect k P.length st2 P.length (Nat.le_refl _)
  have hNj : ∀ j, j < P.length → st2 (N k P.length j) = if j = (mstep P m).q then 1 else 0 := by
    intro j hj
    show exec (upTo (bodyCard P k) P.length) st1 _ = _
    rw [h2 _ (by simp only [N, T]; omega) (by simp only [N, F, S]; omega), h1,
      if_pos (by simp only [N]; omega), (hdc.1 j hj)]; simp
  have hCr : ∀ r, r < k → st2 (C r) = (mstep P m).c r := by
    intro r hr
    show exec (upTo (bodyCard P k) P.length) st1 _ = _
    rw [h2 _ (by simp only [C, T]; omega) (by simp only [C, F, S]; omega), h1,
      if_neg (by simp only [N, C]; omega), henc.c r hr]
    exact hdc.2 r hr
  have hs4 : ∀ j, j < P.length → st4 (S k j) = if j = (mstep P m).q then 1 else 0 := by
    intro j hj
    simp only [st4, exec_single, execCard, ev, val]
    rw [upd_ne' _ _ (by simp only [W, S]; omega), h3, if_pos (by simp only [S]; omega)]
    rw [show S k j - S k 0 = j by simp only [S]; omega]; exact hNj j hj
  have hC4 : ∀ r, r < k → st4 (C r) = (mstep P m).c r := by
    intro r hr
    simp only [st4, exec_single, execCard, ev, val]
    rw [upd_ne' _ _ (by simp only [W, C]; omega), h3, if_neg (by simp only [S, C]; omega)]
    exact hCr r hr
  have hq' : (mstep P m).q < P.length := by
    have hok := wf_get hwf hins
    simp only [mstep, hins]
    cases ins with
    | inc r to => exact hok.2
    | dec r a b => simp only; split <;> simp [hok.2.1, hok.2.2]
    | halt => exact hq
  have h5 := halt_effect P k st4 P.length
  rw [hsplit]
  refine ⟨⟨hq', fun j hj => ?_, fun r hr => ?_⟩, ?_⟩
  · rw [h5, if_neg (by simp only [W, S]; omega)]; exact hs4 j hj
  · rw [h5, if_neg (by simp only [W, C]; omega)]; exact hC4 r hr
  · rw [h5, if_pos rfl, halt_sum P k _ st4 hs4 P.length (Nat.le_refl _)]
    simp only [st4, exec_single, execCard, ev, val, upd_same', Halted]
    by_cases h : P[(mstep P m).q]? = some .halt
    · simp [h, hq']
    · simp [h]

/-! ## The whole pass -/

theorem straight_ops (P : Prog) (k : Nat) : ∀ c ∈ straight P k, IsOp c := by
  intro c hc
  simp only [straight, List.mem_append, List.mem_singleton] at hc
  rcases hc with (((h | h) | h) | h) | h
  · obtain ⟨j, _, h⟩ := mem_upTo h; simp [zeroCard] at h; subst h; simp [IsOp]
  · obtain ⟨j, _, h⟩ := mem_upTo h
    simp only [bodyCard] at h
    split at h
    · rename_i ins _
      cases ins <;> simp [insBlock] at h <;> (try rcases h with h | h | h | h | h) <;>
        (try rcases h with h | h) <;> (try subst h) <;> simp [IsOp]
    · simp at h
  · obtain ⟨j, _, h⟩ := mem_upTo h; simp [copyCard] at h; subst h; simp [IsOp]
  · subst h; simp [IsOp]
  · obtain ⟨j, _, h⟩ := mem_upTo h
    simp only [haltCard] at h
    split at h
    · simp at h; subst h; simp [IsOp]
    · simp at h

theorem intCount_one : intCount 1 = some 1 := rfl
theorem intCount_two : intCount 2 = some 2 := rfl

/-- **One pass is one step.** From card 0 with the machine encoded, the deck
reaches either card 0 again (the next step encoded) or, when the step halts
the machine, the first result card. -/
theorem pass {P : Prog} {k : Nat} (hwf : WF P k) (m : MConf) (st : Nat → Int)
    (henc : Enc k P.length m st) (wh : Option Nat) (out : List Int) :
    ∃ np st', 0 < np ∧ Enc k P.length (mstep P m) st' ∧
      run intArith (compile P k) np ⟨0, st, wh, out⟩ =
        if Halted P (mstep P m) then
          .run ⟨6 * k + (straight P k).length + 2, st', some 0, out⟩
        else .run ⟨0, st', some 1, out⟩ := by
  have hseg : Seg (compile P k) 0 (upTo (flagBlock k) k ++ straight P k ++
      [.set (.col W), .back 0 true] ++ upTo resultCard k) := seg_self (compile P k)
  have ⟨hA, _⟩ := seg_append hseg
  have ⟨hB, hsb⟩ := seg_append hA
  have ⟨hfl, hst⟩ := seg_append hB
  simp only [Nat.zero_add, List.length_append, length_flags] at hst hsb
  -- the flags
  obtain ⟨n1, st1, wh1, h1, hF1, hx1⟩ := flags_run (by simpa using hfl) out m.c k (Nat.le_refl _) wh st
    (fun r hr => henc.c r hr)
  have henc1 : Enc k P.length m st1 := by
    refine ⟨henc.q_lt, fun j hj => ?_, fun r hr => ?_⟩
    · rw [hx1 _ (by simp only [S]; omega) (Or.inr (by simp only [S, F]; omega))]; exact henc.s j hj
    · rw [hx1 _ (by simp only [C]; omega) (Or.inl (by simp only [C, F]; omega))]; exact henc.c r hr
  -- the straight cards
  have h2 := run_straight (d := compile P k) (straight P k) (6 * k) st1 wh1 out
    (by simpa using hst) (straight_ops P k)
  obtain ⟨henc2, hW⟩ := straight_effect hwf m st1 henc1 hF1
  generalize hs2 : exec (straight P k) st1 = st2 at henc2 hW h2
  have gset : (compile P k)[6 * k + (straight P k).length]? = some (.set (.col W)) := by
    simpa using seg_get hsb (i := 0) (by simp)
  have gback : (compile P k)[6 * k + (straight P k).length + 1]? = some (.back 0 true) := by
    simpa using seg_get hsb (i := 1) (by simp)
  refine ⟨n1 + ((straight P k).length + 2), st2, by omega, henc2, ?_⟩
  rw [run_add, h1]
  simp only
  rw [run_add, h2]
  simp only
  by_cases hh : Halted P (mstep P m)
  · rw [if_pos hh] at hW ⊢
    simp [run, step, gset, gback, fetch, hW, intCount_one]
  · rw [if_neg hh] at hW ⊢
    simp [run, step, gset, gback, fetch, hW, intCount_two]

/-! ## Halting, both ways -/

theorem results_run {d : Deck} {p k : Nat} (hseg : Seg d p (upTo resultCard k))
    (st : Nat → Int) (wh : Option Nat) (out : List Int) :
    ∀ j, j ≤ k → run intArith d j ⟨p, st, wh, out⟩ =
      .run ⟨p + j, st, wh, out ++ (List.range j).map (fun r => st (C r))⟩ := by
  intro j
  induction j with
  | zero => intro _; simp [run]
  | succ j ih =>
    intro hj
    have hs := seg_upTo hseg j (by omega)
    rw [length_upTo _ 1 (fun _ => rfl)] at hs
    have g : d[p + j]? = some (.result (C j)) := by simpa [resultCard] using seg_get hs (i := 0) (by simp [resultCard])
    rw [run_add, ih (by omega)]
    simp [run, step, g, List.range_succ, Nat.add_assoc]

theorem mstep_halted {P : Prog} {m : MConf} (h : Halted P m) : mstep P m = m := by
  simp [mstep, Halted] at *; rw [h]

theorem mrun_halted {P : Prog} {m : MConf} (h : Halted P m) : ∀ t, mrun P t m = m
  | 0 => rfl
  | t + 1 => by simp only [mrun, mstep_halted h]; exact mrun_halted h t

theorem mrun_succ' (P : Prog) : ∀ t m, mrun P (t + 1) m = mstep P (mrun P t m)
  | 0, _ => rfl
  | t + 1, m => by simp only [mrun] at *; exact mrun_succ' P t _

theorem run_split {A : Arith V} {d : Deck} {s s1 s' : State V} {a n : Nat}
    (h1 : run A d a s = .run s1) (h2 : run A d n s = .halt s') :
    a ≤ n ∧ run A d (n - a) s1 = .halt s' := by
  by_cases h : a ≤ n
  · refine ⟨h, ?_⟩
    have := run_add A d a (n - a) s
    rw [Nat.add_sub_cancel' h, h1] at this
    simp only at this
    rw [← this]; exact h2
  · exfalso
    have := run_add A d n (a - n) s
    rw [Nat.add_sub_cancel' (by omega), h2, h1] at this
    cases this

theorem exit_halts {P : Prog} {k : Nat} (st : Nat → Int) (out : List Int) (wh : Option Nat) :
    ∃ n s', run intArith (compile P k) n ⟨6 * k + (straight P k).length + 2, st, wh, out⟩ =
      .halt s' ∧ s'.out = out ++ (List.range k).map (fun r => st (C r)) := by
  have hseg : Seg (compile P k) 0 (upTo (flagBlock k) k ++ straight P k ++
      [.set (.col W), .back 0 true] ++ upTo resultCard k) := seg_self (compile P k)
  have ⟨_, hres⟩ := seg_append hseg
  simp only [Nat.zero_add, List.length_append, length_flags, List.length_cons,
    List.length_nil] at hres
  have hlen : (compile P k).length = 6 * k + ((straight P k).length + 2) + k := by
    simp [compile, length_flags, length_upTo resultCard 1 (fun _ => rfl)]; omega
  refine ⟨k + 1, ⟨6 * k + ((straight P k).length + 2) + k, st, wh,
    out ++ (List.range k).map (fun r => st (C r))⟩, ?_, rfl⟩
  rw [run_add, results_run hres st wh out k (Nat.le_refl _)]
  have : (compile P k)[6 * k + ((straight P k).length + 2) + k]? = none :=
    List.getElem?_eq_none (by omega)
  simp [run, step, Nat.add_assoc] at this ⊢
  simp [this]

theorem loop_halts {P : Prog} {k : Nat} (hwf : WF P k) :
    ∀ t (m : MConf) (st : Nat → Int) (wh : Option Nat), Enc k P.length m st →
      Halted P (mrun P t (mstep P m)) →
      ∃ n s', run intArith (compile P k) n ⟨0, st, wh, []⟩ = .halt s' ∧
        s'.out = (List.range k).map (fun r => ((mrun P t (mstep P m)).c r : Int)) := by
  intro t
  induction t with
  | zero =>
    intro m st wh henc hh
    simp only [mrun] at hh ⊢
    obtain ⟨np, st', _, henc', hp⟩ := pass hwf m st henc wh []
    rw [if_pos hh] at hp
    obtain ⟨n2, s', h2, hout⟩ := exit_halts (P := P) (k := k) st' [] (some 0)
    refine ⟨np + n2, s', by rw [run_add, hp]; exact h2, ?_⟩
    rw [hout]; simp only [List.nil_append]
    exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
  | succ t ih =>
    intro m st wh henc hh
    obtain ⟨np, st', _, henc', hp⟩ := pass hwf m st henc wh []
    by_cases h0 : Halted P (mstep P m)
    · rw [if_pos h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := exit_halts (P := P) (k := k) st' [] (some 0)
      refine ⟨np + n2, s', by rw [run_add, hp]; exact h2, ?_⟩
      rw [hout, mrun_halted h0]; simp only [List.nil_append]
      exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
    · rw [if_neg h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := ih (mstep P m) st' (some 1) henc' (by simpa [mrun] using hh)
      exact ⟨np + n2, s', by rw [run_add, hp]; exact h2, by simpa [mrun] using hout⟩

theorem enc_init (P : Prog) (k : Nat) (hn : 0 < P.length) (c : Nat → Nat) :
    Enc k P.length ⟨0, c⟩ (initStore k c) := by
  refine ⟨hn, fun j hj => ?_, fun r hr => ?_⟩
  · simp only [initStore]
    by_cases h : j = 0
    · subst h; simp
    · rw [if_neg (by simp only [S]; omega), if_neg (by simp only [S, C]; omega)]; simp [h]
  · simp only [initStore]
    rw [if_neg (by simp only [S, C]; omega), if_pos (by simp only [C]; omega)]
    simp [C]

/-- **If the machine halts, the deck halts**, and gives off the counters of the
halted machine, counter 0 first. -/
theorem compile_halts {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length) (c : Nat → Nat)
    (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ n s', run intArith (compile P k) n ⟨0, initStore k c, none, []⟩ = .halt s' ∧
      s'.out = (List.range k).map (fun r => ((mrun P t ⟨0, c⟩).c r : Int)) := by
  have e : mrun P t (mstep P ⟨0, c⟩) = mrun P t ⟨0, c⟩ := by
    rw [← mrun, mrun_succ', mstep_halted h]
  rw [← e] at h ⊢
  exact loop_halts hwf t _ _ none (enc_init P k hn c) h

/-- **If the deck halts, the machine halts.** -/
theorem machine_halts_of_compile {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length)
    (c : Nat → Nat) (n : Nat) (s' : State Int)
    (h : run intArith (compile P k) n ⟨0, initStore k c, none, []⟩ = .halt s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) := by
  suffices H : ∀ n (m : MConf) (st : Nat → Int) wh out, Enc k P.length m st →
      run intArith (compile P k) n ⟨0, st, wh, out⟩ = .halt s' → ∃ t, Halted P (mrun P t m) from
    H n _ _ none [] (enc_init P k hn c) h
  intro n
  induction n using Nat.strongRecOn with
  | _ n ih =>
    intro m st wh out henc hrun
    obtain ⟨np, st', hnp, henc', hp⟩ := pass hwf m st henc wh out
    by_cases h0 : Halted P (mstep P m)
    · exact ⟨1, h0⟩
    · rw [if_neg h0] at hp
      obtain ⟨hle, hrest⟩ := run_split hp hrun
      obtain ⟨t, ht⟩ := ih (n - np) (by omega) _ _ _ _ henc' hrest
      exact ⟨t + 1, by simpa [mrun] using ht⟩

/-! ## Which configurations accept the deck -/

/-- Every backing card in `l`, standing at `off`, goes back. -/
def BackOK (l : List Card) (off : Nat) : Prop :=
  ∀ (i t : Nat) b, l[i]? = some (Card.back t b) → t ≤ off + i

theorem backOK_append {a b : List Card} {off : Nat} (ha : BackOK a off)
    (hb : BackOK b (off + a.length)) : BackOK (a ++ b) off := by
  intro i t c h
  by_cases hi : i < a.length
  · rw [List.getElem?_append_left hi] at h; exact ha i t c h
  · rw [List.getElem?_append_right (by omega)] at h
    have := hb _ t c h; omega

theorem backOK_noback {l : List Card} {off : Nat} (h : ∀ c ∈ l, IsOp c) : BackOK l off := by
  intro i t b hi
  have := h _ (List.mem_of_getElem? hi)
  simp [IsOp] at this

theorem backOK_flags (k : Nat) : ∀ m, BackOK (upTo (flagBlock k) m) 0 := by
  intro m
  induction m with
  | zero => intro i t b h; simp [upTo] at h
  | succ m ih =>
    apply backOK_append ih
    rw [length_flags]
    intro i t b h
    simp only [flagBlock] at h
    match i, h with
    | 5, h => simp at h; omega
    | 0, h | 1, h | 2, h | 3, h | 4, h => simp at h
    | i + 6, h => simp at h

theorem backOK_results (off : Nat) : ∀ k, BackOK (upTo resultCard k) off := by
  intro k
  induction k generalizing off with
  | zero => intro i t b h; simp [upTo] at h
  | succ k ih =>
    apply backOK_append (ih off)
    intro i t b h
    match i, h with
    | 0, h => simp [resultCard] at h
    | i + 1, h => simp [resultCard] at h

theorem compile_backward (P : Prog) (k : Nat) : Backward (compile P k) := by
  have h : BackOK (compile P k) 0 := by
    unfold compile
    refine backOK_append (backOK_append (backOK_append (backOK_flags k k)
      (backOK_noback (straight_ops P k))) ?_) (backOK_results _ k)
    intro i t b h
    match i, h with
    | 0, h => simp at h
    | 1, h => simp at h; omega
    | i + 2, h => simp at h
  intro i t b hi
  have := h i t b hi; omega

/-- The deck is accepted by `not-found`. -/
theorem compile_accepted (P : Prog) (k : Nat) : Accepts cNotFound (compile P k) := by
  intro i card h
  have hb := compile_backward P k
  cases card with
  | set => rfl
  | back t counted =>
    exact ⟨rfl, hb i t counted h, Or.inl rfl, fun _ h' => absurd h' (by decide)⟩
  | _ => trivial

/-- **No configuration of the pages accepts it**: its own count is set inside
the group its last backing card repeats. -/
theorem compile_refused (P : Prog) (k : Nat) (c : Config) (hc : c.setInGroup = false) :
    ¬ Accepts c (compile P k) := by
  intro hacc
  have hseg : Seg (compile P k) 0 (upTo (flagBlock k) k ++ straight P k ++
      [.set (.col W), .back 0 true] ++ upTo resultCard k) := seg_self (compile P k)
  have ⟨hA, _⟩ := seg_append hseg
  have ⟨_, hsb⟩ := seg_append hA
  simp only [Nat.zero_add, List.length_append, length_flags] at hsb
  have gset := seg_get hsb (i := 0) (by simp)
  have gback := seg_get hsb (i := 1) (by simp)
  simp only [Nat.add_zero] at gset gback
  have := hacc _ _ gback
  try simp only at this
  have := this.2.2.2 rfl hc _ _ (Nat.zero_le _) (by omega) gset
  simp [isSet] at this

end Babbage.Minsky
