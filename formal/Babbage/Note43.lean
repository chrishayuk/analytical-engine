import Babbage.Minsky

/-!
# The configuration of the published accounts, 1842–1843

Menabrea (1842) and Lovelace's Note G (1843) describe what no page of the
Sketch Books up to April 1842 gives: a result of the mill deciding the course
of the cards. Note G, p. 728: Operation 7 "must either bring out a result
equal to zero … or a result greater than zero … and the engine follows the one
or the other of the two courses … contingently on the one or the other result
of Operation 7"; pp. 730–731: "V₁₀ always decides which of two courses the
succeeding processes are to follow, by feeling for the value of n through
means of a subtraction". Read as the repository reads it
(`sources/notes/menabrea-lovelace-1843-control.md` §8, Reading A), the cycle
(13…23) is repeated until V₁₀ comes to zero, and no counter is loaded.

This file adds two cards to the machine of `Machine.lean`, without changing it:
`backIf t c` (Reading A), a backing to card `t` made effective while the
number in column `c` is greater than zero (`pos`); and `aheadIf t c`
(Reading B), a forward course to card `t` taken when it is zero (`zero`).
Every other card acts as in `step` (`step43_lift`). Reading B's theorems
(`haltsB`, `machine_halts_of_B`, `deckB_plain`, `deckB_accepted`,
`deckB_refused`) are at the end; the halting arguments are generic (`haltsG`,
`machineG`).

* `deck43_plain`: the deck below has only operation cards, result cards and
  `backIf`: no combinatorial card, no counted or unconditional backing, no
  repetition card.
* `deck43_accepted`, `deck43_refused`: the configuration of 30 May 1838 with
  `backIf` accepts it; a configuration without `backIf` does not.
* `halts43`, `machine_halts_of_43`: a counter machine translates into a deck
  that **halts by passing its last card** exactly when the machine halts, and
  gives off its counters. With Minsky's theorem (cited), the configuration is
  general under the ordinary meaning of a halt.

`pos` is a parameter: the theorems need only that on whole numbers ≥ 0 it says
"greater than zero" (`hpos`), which "not zero" also satisfies. The deck tests
no negative number.
-/

namespace Babbage

variable {V : Type}

inductive Card43 where
  | c (card : Card)
  /-- A backing to card `t`, effective while column `col` holds a number
  greater than zero (Note G, 1843). -/
  | backIf (t col : Nat)
  /-- Reading B: when column `col` holds zero, the cards go on from card `t`,
  a later card; otherwise from the next card. -/
  | aheadIf (t col : Nat)

abbrev Deck43 := List Card43

/-- One step. The cards of `Machine.lean` act exactly as in `step`. -/
def step43 (A : Arith V) (pos zero : V → Bool) (d : Deck43) (s : State V) : Res V :=
  match d[s.pc]? with
  | none => .halt s
  | some (.backIf t c) => if pos (s.store c) then .run { s with pc := t } else .run { s with pc := s.pc + 1 }
  | some (.aheadIf t c) => if zero (s.store c) then .run { s with pc := t } else .run { s with pc := s.pc + 1 }
  | some (.c (.op o a b dst)) =>
    match A.op o (fetch A s a) (fetch A s b) with
    | some r => .run { s with pc := s.pc + 1, store := upd s.store dst r }
    | none => .err
  | some (.c (.rep o c b n)) =>
    match A.count (fetch A s n) with
    | none => .err
    | some k =>
      match iter A o (fetch A s b) k (s.store c) with
      | some r => .run { s with pc := s.pc + 1, store := upd s.store c r }
      | none => .err
  | some (.c (.set src)) =>
    match A.count (fetch A s src) with
    | some (k + 1) => .run { s with pc := s.pc + 1, wheels := some (k + 1) }
    | _ => .err
  | some (.c (.back t false)) => .run { s with pc := t }
  | some (.c (.back t true)) =>
    match s.wheels with
    | some (w + 2) => .run { s with pc := t, wheels := some (w + 1) }
    | some 1 => .run { s with pc := s.pc + 1, wheels := some 0 }
    | _ => .err
  | some (.c (.result c)) => .run { s with pc := s.pc + 1, out := s.out ++ [s.store c] }

def run43 (A : Arith V) (pos zero : V → Bool) (d : Deck43) : Nat → State V → Res V
  | 0, s => .run s
  | n + 1, s =>
    match step43 A pos zero d s with
    | .run s' => run43 A pos zero d n s'
    | r => r

/-- **A conservative extension**: a deck of `Machine.lean`, read as a deck here,
runs exactly as it did. -/
theorem step43_lift (A : Arith V) (pos zero : V → Bool) (d : Deck) (s : State V) :
    step43 A pos zero (d.map Card43.c) s = step A d s := by
  unfold step43 step
  rw [List.getElem?_map]
  cases d[s.pc]? with
  | none => rfl
  | some card =>
    cases card with
    | back t b => cases b <;> rfl
    | _ => rfl

theorem run43_lift (A : Arith V) (pos zero : V → Bool) (d : Deck) :
    ∀ n (s : State V), run43 A pos zero (d.map Card43.c) n s = run A d n s
  | 0, _ => rfl
  | n + 1, s => by simp only [run43, run, step43_lift]; split <;> simp [*, run43_lift]

theorem run43_add (A : Arith V) (pos zero : V → Bool) (d : Deck43) (a b : Nat) (s : State V) :
    run43 A pos zero d (a + b) s =
      match run43 A pos zero d a s with
      | .run s' => run43 A pos zero d b s'
      | r => r := by
  induction a generalizing s with
  | zero => simp [run43]
  | succ a ih =>
    rw [Nat.add_right_comm, run43, run43]
    cases step43 A pos zero d s with
    | run s' => exact ih s'
    | halt s' => rfl
    | err => rfl

/-- The rules of a configuration, with `backIf` allowed only when `condBack`
(Reading A) and `aheadIf` only when `condSkip` (Reading B). -/
def Accepts43 (c : Config) (condBack condSkip : Bool) (d : Deck43) : Prop :=
  ∀ i card, d[i]? = some card →
    match card with
    | Card43.backIf t _ => condBack = true ∧ c.backing = true ∧ t ≤ i ∧ (c.anyTarget = true ∨ t = 0)
    | Card43.aheadIf t _ => condSkip = true ∧ i < t
    | Card43.c (Card.set _) => c.backing = true
    | Card43.c (Card.back t counted) =>
      c.backing = true ∧ t ≤ i ∧ (c.anyTarget = true ∨ t = 0) ∧
      (counted = true → c.setInGroup = false →
        ∀ j card', t ≤ j → j < i → d[j]? = some (Card43.c card') → isSet card' = false)
    | _ => True

/-! ## Cards in place -/

namespace Minsky

/-- `f 0 ++ … ++ f (m − 1)`, for the new cards. -/
def upTo43 (f : Nat → List Card43) : Nat → List Card43
  | 0 => []
  | m + 1 => upTo43 f m ++ f m

def Seg43 (d : Deck43) (p : Nat) (blk : List Card43) : Prop :=
  ∀ i, i < blk.length → d[p + i]? = blk[i]?

theorem seg43_append {d : Deck43} {p : Nat} {a b : List Card43} (h : Seg43 d p (a ++ b)) :
    Seg43 d p a ∧ Seg43 d (p + a.length) b := by
  constructor
  · intro i hi
    have := h i (by simp; omega)
    rw [this, List.getElem?_append_left hi]
  · intro i hi
    have := h (a.length + i) (by simp; omega)
    rw [← Nat.add_assoc] at this
    rw [this, List.getElem?_append_right (by omega)]
    simp

theorem seg43_self (d : Deck43) : Seg43 d 0 d := by intro i _; simp

theorem length_upTo43 (f : Nat → List Card43) (l : Nat) (hf : ∀ m, (f m).length = l) :
    ∀ m, (upTo43 f m).length = l * m
  | 0 => by simp [upTo43]
  | m + 1 => by simp [upTo43, length_upTo43 f l hf m, hf, Nat.mul_succ]

theorem seg43_upTo {d : Deck43} {p : Nat} {f : Nat → List Card43} {m : Nat}
    (h : Seg43 d p (upTo43 f m)) : ∀ j, j < m → Seg43 d (p + (upTo43 f j).length) (f j) := by
  induction m with
  | zero => intro j hj; omega
  | succ m ih =>
    intro j hj
    have ⟨h1, h2⟩ := seg43_append h
    rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hj) with hj | rfl
    · exact ih h1 j hj
    · exact h2

theorem seg43_get {d : Deck43} {p : Nat} {blk : List Card43} (h : Seg43 d p blk) {i : Nat}
    (hi : i < blk.length) : d[p + i]? = some blk[i] := by
  rw [h i hi]; simp [hi]

section
variable {pos zero : Int → Bool}

theorem run43_straight {d : Deck43} :
    ∀ (blk : List Card) (p : Nat) (st : Nat → Int) (wh : Option Nat) (out : List Int),
      Seg43 d p (blk.map Card43.c) → (∀ c ∈ blk, IsOp c) →
      run43 intArith pos zero d blk.length ⟨p, st, wh, out⟩ =
        .run ⟨p + blk.length, exec blk st, wh, out⟩
  | [], p, st, wh, out, _, _ => by simp [run43, exec]
  | c :: rest, p, st, wh, out, hs, hop => by
    have hc : d[p]? = some (Card43.c c) := by simpa using hs 0 (by simp)
    have hrest : Seg43 d (p + 1) (rest.map Card43.c) := by
      intro i hi
      have := hs (i + 1) (by simp at hi ⊢; omega)
      rw [show p + 1 + i = p + (i + 1) by omega, this]; simp
    have hstep : step43 intArith pos zero d ⟨p, st, wh, out⟩ = .run ⟨p + 1, execCard st c, wh, out⟩ := by
      have hc' := hop c (by simp)
      unfold step43
      simp only [hc]
      cases c with
      | op o a b dst =>
        cases o with
        | div => exact absurd rfl hc'
        | add | sub | mul =>
          cases a <;> cases b <;> simp [fetch, intOp, execCard, ev, val]
      | _ => exact absurd hc' id
    simp only [List.length_cons, run43, hstep]
    rw [run43_straight rest (p + 1) _ wh out hrest (fun c h => hop c (by simp [h]))]
    simp [exec, Nat.add_assoc, Nat.add_comm 1]

end

/-! ## A flag by a cycle a result ends -/

/-- [c_r > 0] into F_r with the new card only: K := 0; then, from card 6r + 1,
F := K; K := 1; U := c_r × (1 − F); back while U > 0. The first pass writes 0
and leaves U = c_r; if c_r > 0 a second pass writes 1 and leaves U = 0. -/
def flag43 (k r : Nat) : List Card43 :=
  [.c (.op .add (.num 0) (.num 0) WAS),
   .c (.op .add (.col WAS) (.num 0) (F k r)),
   .c (.op .add (.num 0) (.num 1) WAS),
   .c (.op .sub (.num 1) (.col (F k r)) CNT),
   .c (.op .mul (.col (C r)) (.col CNT) CNT),
   .backIf (6 * r + 1) CNT]

section flag
variable {pos zero : Int → Bool} (hpos : ∀ n : Nat, pos (n : Int) = decide (0 < n))
variable {d : Deck43} {k r : Nat} (hseg : Seg43 d (6 * r) (flag43 k r)) (hr : r < k)
include hpos hseg hr

theorem flag43_block (out : List Int) (wh : Option Nat) (st : Nat → Int) (c : Nat)
    (hc : st (C r) = c) :
    ∃ n st', run43 intArith pos zero d n ⟨6 * r, st, wh, out⟩ = .run ⟨6 * r + 6, st', wh, out⟩ ∧
      st' (F k r) = (if 0 < c then 1 else 0) ∧
      ∀ x, x ≠ WAS → x ≠ CNT → x ≠ F k r → st' x = st x := by
  have g : ∀ i (hi : i < 6), d[6 * r + i]? = some ((flag43 k r)[i]'(by simp [flag43]; omega)) :=
    fun i hi => seg43_get hseg _
  have g0 := g 0 (by omega); have g1 := g 1 (by omega); have g2 := g 2 (by omega)
  have g3 := g 3 (by omega); have g4 := g 4 (by omega); have g5 := g 5 (by omega)
  simp only [flag43, Nat.add_zero] at g0 g1 g2 g3 g4 g5
  simp only [List.getElem_cons_succ, List.getElem_cons_zero] at g0 g1 g2 g3 g4 g5
  have hFW : F k r ≠ WAS := by unfold F WAS; omega
  have hFC : F k r ≠ CNT := by unfold F CNT; omega
  have hCW : C r ≠ WAS := by unfold C WAS; omega
  have hCC : C r ≠ CNT := by unfold C CNT; omega
  have hCF : C r ≠ F k r := by unfold C F; omega
  have hWC : WAS ≠ CNT := by decide
  -- the first card, and one pass from card 6r + 1 with K on WAS
  let s1 := upd st WAS 0
  have h1 : run43 intArith pos zero d 1 ⟨6 * r, st, wh, out⟩ = .run ⟨6 * r + 1, s1, wh, out⟩ := by
    simp [run43, step43, g0, fetch, intOp, s1]
  have pass : ∀ σ : Nat → Int, σ (C r) = c →
      run43 intArith pos zero d 4 ⟨6 * r + 1, σ, wh, out⟩ =
        .run ⟨6 * r + 5, upd (upd (upd (upd σ (F k r) (σ WAS)) WAS 1) CNT (1 - σ WAS)) CNT
          (c * (1 - σ WAS)), wh, out⟩ := by
    intro σ hσ
    have e2 : 6 * r + 1 + 1 = 6 * r + 2 := rfl
    simp [run43, step43, g1, g2, g3, g4, fetch, intOp, upd_same', upd_ne' _ _ hFW,
      upd_ne' _ _ hCW, upd_ne' _ _ hCC, upd_ne' _ _ hCF, hσ, Nat.add_assoc]
  have hs1 : s1 (C r) = c := by simp only [s1]; rw [upd_ne' _ _ hCW, hc]
  have h2 := pass s1 hs1
  simp only [s1, upd_same'] at h2
  generalize ha : upd (upd (upd (upd (upd st WAS 0) (F k r) 0) WAS 1) CNT (1 - 0)) CNT
    ((c : Int) * (1 - 0)) = a5 at h2
  have a5C : a5 CNT = c := by rw [← ha]; simp [upd_same']
  have a5W : a5 WAS = 1 := by
    rw [← ha, upd_ne' _ _ hWC, upd_ne' _ _ hWC, upd_same']
  have a5F : a5 (F k r) = 0 := by
    rw [← ha, upd_ne' _ _ hFC, upd_ne' _ _ hFC, upd_ne' _ _ hFW, upd_same']
  have a5C' : a5 (C r) = c := by
    rw [← ha, upd_ne' _ _ hCC, upd_ne' _ _ hCC, upd_ne' _ _ hCW, upd_ne' _ _ hCF, upd_ne' _ _ hCW, hc]
  have a5x : ∀ x, x ≠ WAS → x ≠ CNT → x ≠ F k r → a5 x = st x := by
    intro x h1 h2 h3
    rw [← ha, upd_ne' _ _ h2, upd_ne' _ _ h2, upd_ne' _ _ h1, upd_ne' _ _ h3, upd_ne' _ _ h1]
  have g5' : d[6 * r + 5]? = some (Card43.backIf (6 * r + 1) CNT) := g5
  cases c with
  | zero =>
    refine ⟨1 + (4 + 1), a5, ?_, by simpa using a5F, a5x⟩
    rw [run43_add, h1]; simp only; rw [run43_add, h2]; simp only
    have : pos (a5 CNT) = false := by rw [a5C]; simpa using hpos 0
    simp [run43, step43, g5', this]
  | succ w =>
    have hb : pos (a5 CNT) = true := by rw [a5C]; simpa using hpos (w + 1)
    have h3 := pass a5 a5C'
    rw [a5W] at h3
    generalize hb5 : upd (upd (upd (upd a5 (F k r) 1) WAS 1) CNT (1 - 1)) CNT
      (((w + 1 : Nat) : Int) * (1 - 1)) = b5 at h3
    have b5C : b5 CNT = 0 := by rw [← hb5]; simp [upd_same']
    have b5F : b5 (F k r) = 1 := by
      rw [← hb5, upd_ne' _ _ hFC, upd_ne' _ _ hFC, upd_ne' _ _ hFW, upd_same']
    have b5x : ∀ x, x ≠ WAS → x ≠ CNT → x ≠ F k r → b5 x = st x := by
      intro x h1 h2 h3
      rw [← hb5, upd_ne' _ _ h2, upd_ne' _ _ h2, upd_ne' _ _ h1, upd_ne' _ _ h3, a5x x h1 h2 h3]
    have hb' : pos (b5 CNT) = false := by rw [b5C]; simpa using hpos 0
    refine ⟨1 + (4 + (1 + (4 + 1))), b5, ?_, by simpa using b5F, b5x⟩
    rw [run43_add, h1]; simp only; rw [run43_add, h2]; simp only
    rw [run43_add]
    have hback : run43 intArith pos zero d 1 ⟨6 * r + 5, a5, wh, out⟩ = .run ⟨6 * r + 1, a5, wh, out⟩ := by
      simp [run43, step43, g5', hb]
    rw [hback]; simp only; rw [run43_add, h3]; simp only
    simp [run43, step43, g5', hb']

end flag

theorem length_flags43 (k : Nat) : ∀ m, (upTo43 (flag43 k) m).length = 6 * m :=
  length_upTo43 _ 6 (fun _ => by simp [flag43])

theorem flags43_run {pos zero : Int → Bool} (hpos : ∀ n : Nat, pos (n : Int) = decide (0 < n))
    {d : Deck43} {k : Nat} (hseg : Seg43 d 0 (upTo43 (flag43 k) k)) (out : List Int)
    (c : Nat → Nat) : ∀ m, m ≤ k → ∀ (wh : Option Nat) (st : Nat → Int),
      (∀ r, r < k → st (C r) = c r) →
      ∃ n st', run43 intArith pos zero d n ⟨0, st, wh, out⟩ = .run ⟨6 * m, st', wh, out⟩ ∧
        (∀ r, r < m → st' (F k r) = (if 0 < c r then 1 else 0)) ∧
        ∀ x, 5 ≤ x → (x < F k 0 ∨ F k m ≤ x) → st' x = st x := by
  intro m
  induction m with
  | zero => intro _ wh st _; exact ⟨0, st, by simp [run43], by simp, by simp⟩
  | succ m ih =>
    intro hm wh st hc
    obtain ⟨n, st1, h1, hF1, hx1⟩ := ih (by omega) wh st hc
    have hs : Seg43 d (6 * m) (flag43 k m) := by
      have := seg43_upTo hseg m (by omega)
      simpa [length_flags43] using this
    have hcm : st1 (C m) = c m := by
      rw [hx1 _ (by unfold C; omega) (Or.inl (by unfold C F; omega))]; exact hc m (by omega)
    obtain ⟨n2, st2, h2, hF2, hx2⟩ := flag43_block hpos hs (by omega) out wh st1 (c m) hcm
    refine ⟨n + n2, st2, ?_, ?_, ?_⟩
    · rw [run43_add, h1]; simpa [Nat.mul_succ] using h2
    · intro r hr
      rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hr) with hr | rfl
      · rw [hx2 _ (by unfold WAS F; omega) (by unfold CNT F; omega) (by unfold F; omega)]
        exact hF1 r hr
      · exact hF2
    · intro x h5 hx
      rw [hx2 _ (by unfold WAS; omega) (by unfold CNT; omega) (by unfold F at *; omega)]
      exact hx1 x h5 (by unfold F at *; omega)

/-! ## The deck -/

/-- The end of each pass: W := W − 1, which is 1 while the machine runs and 0
once it has halted; back to card 0 while it is greater than zero. -/
def tail43 : List Card43 := [.c (.op .sub (.col W) (.num 1) W), .backIf 0 W]

/-- **The deck of the published accounts**: the flags, the straight cards of
`compile`, `tail43`, and the counters given off. -/
def deck43 (P : Prog) (k : Nat) : Deck43 :=
  upTo43 (flag43 k) k ++ (straight P k).map Card43.c ++ tail43 ++ (upTo resultCard k).map Card43.c

theorem deck43_seg (P : Prog) (k : Nat) :
    Seg43 (deck43 P k) 0 (upTo43 (flag43 k) k) ∧
      Seg43 (deck43 P k) (6 * k) ((straight P k).map Card43.c) ∧
      Seg43 (deck43 P k) (6 * k + (straight P k).length) tail43 ∧
      Seg43 (deck43 P k) (6 * k + (straight P k).length + 2) ((upTo resultCard k).map Card43.c) := by
  have hseg := seg43_self (deck43 P k)
  have ⟨hA, hR⟩ := seg43_append hseg
  have ⟨hB, hT⟩ := seg43_append hA
  have ⟨hF, hS⟩ := seg43_append hB
  simp only [Nat.zero_add, List.length_append, List.length_map, length_flags43, tail43,
    List.length_cons, List.length_nil] at hS hT hR
  exact ⟨hF, hS, hT, by simpa [Nat.add_assoc] using hR⟩

section run
variable {pos zero : Int → Bool} (hpos : ∀ n : Nat, pos (n : Int) = decide (0 < n))
include hpos

/-- **One pass is one step**: back at card 0 with the next step encoded, or,
once that step halts the machine, at the first result card. -/
theorem pass43 {P : Prog} {k : Nat} (hwf : WF P k) (m : MConf) (st : Nat → Int)
    (henc : Enc k P.length m st) (wh : Option Nat) (out : List Int) :
    ∃ np st', 0 < np ∧ Enc k P.length (mstep P m) st' ∧
      run43 intArith pos zero (deck43 P k) np ⟨0, st, wh, out⟩ =
        if Halted P (mstep P m) then .run ⟨6 * k + (straight P k).length + 2, st', wh, out⟩
        else .run ⟨0, st', wh, out⟩ := by
  obtain ⟨hfl, hst, htl, _⟩ := deck43_seg P k
  obtain ⟨n1, st1, h1, hF1, hx1⟩ := flags43_run hpos hfl out m.c k (Nat.le_refl _) wh st
    (fun r hr => henc.c r hr)
  have henc1 : Enc k P.length m st1 := by
    refine ⟨henc.q_lt, fun j hj => ?_, fun r hr => ?_⟩
    · rw [hx1 _ (by simp only [S]; omega) (Or.inr (by simp only [S, F]; omega))]; exact henc.s j hj
    · rw [hx1 _ (by simp only [C]; omega) (Or.inl (by simp only [C, F]; omega))]; exact henc.c r hr
  have h2 := run43_straight (pos := pos) (zero := zero) (d := deck43 P k) (straight P k) (6 * k) st1 wh out hst
    (straight_ops P k)
  obtain ⟨henc2, hW⟩ := straight_effect hwf m st1 henc1 hF1
  generalize hs2 : exec (straight P k) st1 = st2 at henc2 hW h2
  have gsub : (deck43 P k)[6 * k + (straight P k).length]? =
      some (.c (.op .sub (.col W) (.num 1) W)) := by
    simpa [tail43] using seg43_get htl (i := 0) (by simp [tail43])
  have gback : (deck43 P k)[6 * k + (straight P k).length + 1]? = some (.backIf 0 W) := by
    simpa [tail43] using seg43_get htl (i := 1) (by simp [tail43])
  have gback' : (deck43 P k)[6 * k + ((straight P k).length + 1)]? = some (.backIf 0 W) := by
    rw [← Nat.add_assoc]; exact gback
  let st3 := upd st2 W (st2 W - 1)
  have henc3 : Enc k P.length (mstep P m) st3 :=
    ⟨henc2.q_lt, fun j hj => by simp only [st3]; rw [upd_ne' _ _ (by simp only [S, W]; omega)]; exact henc2.s j hj,
      fun r hr => by simp only [st3]; rw [upd_ne' _ _ (by simp only [C, W]; omega)]; exact henc2.c r hr⟩
  have hsub : run43 intArith pos zero (deck43 P k) 1 ⟨6 * k + (straight P k).length, st2, wh, out⟩ =
      .run ⟨6 * k + (straight P k).length + 1, st3, wh, out⟩ := by
    simp [run43, step43, gsub, fetch, intOp, st3]
  refine ⟨n1 + ((straight P k).length + (1 + 1)), st3, by omega, henc3, ?_⟩
  rw [run43_add, h1]; simp only; rw [run43_add, h2]; simp only; rw [run43_add, hsub]; simp only
  by_cases hh : Halted P (mstep P m)
  · rw [if_pos hh] at hW ⊢
    have : pos (st3 W) = false := by
      have e : st3 W = ((0 : Nat) : Int) := by simp [st3, upd, hW]
      rw [e, hpos]; rfl
    simp [run43, step43, gback', this, Nat.add_assoc]
  · rw [if_neg hh] at hW ⊢
    have : pos (st3 W) = true := by
      have e : st3 W = ((1 : Nat) : Int) := by simp [st3, upd, hW]
      rw [e, hpos]; rfl
    simp [run43, step43, gback, this]

omit hpos in
theorem results43_run {d : Deck43} {p k : Nat}
    (hseg : Seg43 d p ((upTo resultCard k).map Card43.c))
    (st : Nat → Int) (wh : Option Nat) (out : List Int) :
    ∀ j, j ≤ k → run43 intArith pos zero d j ⟨p, st, wh, out⟩ =
      .run ⟨p + j, st, wh, out ++ (List.range j).map (fun r => st (C r))⟩ := by
  intro j
  induction j with
  | zero => intro _; simp [run43]
  | succ j ih =>
    intro hj
    have hlen : ((upTo resultCard k).map Card43.c).length = k := by
      simp [length_upTo resultCard 1 (fun _ => rfl)]
    have g : d[p + j]? = some (.c (.result (C j))) := by
      have := seg43_get hseg (i := j) (by omega)
      rw [this]
      congr 1
      simp only [List.getElem_map]
      have hs := seg_upTo (seg_self (upTo resultCard k)) j (by omega)
      rw [length_upTo _ 1 (fun _ => rfl)] at hs
      have := seg_get hs (i := 0) (by simp [resultCard])
      simp [resultCard] at this
      have hjl : j < (upTo resultCard k).length := by
        rw [length_upTo _ 1 (fun _ => rfl)]; omega
      rw [List.getElem?_eq_getElem hjl] at this
      rw [Option.some.inj this]
    rw [run43_add, ih (by omega)]
    simp [run43, step43, g, List.range_succ, Nat.add_assoc]

theorem exit43 {P : Prog} {k : Nat} (st : Nat → Int) (wh : Option Nat) (out : List Int) :
    ∃ n s', run43 intArith pos zero (deck43 P k) n ⟨6 * k + (straight P k).length + 2, st, wh, out⟩ =
      .halt s' ∧ s'.out = out ++ (List.range k).map (fun r => st (C r)) := by
  obtain ⟨_, _, _, hres⟩ := deck43_seg P k
  have hlen : (deck43 P k).length = 6 * k + (straight P k).length + 2 + k := by
    simp [deck43, length_flags43, tail43, length_upTo resultCard 1 (fun _ => rfl)]; omega
  refine ⟨k + 1, ⟨6 * k + (straight P k).length + 2 + k, st, wh,
    out ++ (List.range k).map (fun r => st (C r))⟩, ?_, rfl⟩
  rw [run43_add, results43_run hres st wh out k (Nat.le_refl _)]
  have : (deck43 P k)[6 * k + (straight P k).length + 2 + k]? = none :=
    List.getElem?_eq_none (by omega)
  simp [run43, step43, this]

theorem loop43 {P : Prog} {k : Nat} (hwf : WF P k) :
    ∀ t (m : MConf) (st : Nat → Int) (wh : Option Nat), Enc k P.length m st →
      Halted P (mrun P t (mstep P m)) →
      ∃ n s', run43 intArith pos zero (deck43 P k) n ⟨0, st, wh, []⟩ = .halt s' ∧
        s'.out = (List.range k).map (fun r => ((mrun P t (mstep P m)).c r : Int)) := by
  intro t
  induction t with
  | zero =>
    intro m st wh henc hh
    simp only [mrun] at hh ⊢
    obtain ⟨np, st', _, henc', hp⟩ := pass43 hpos hwf m st henc wh []
    rw [if_pos hh] at hp
    obtain ⟨n2, s', h2, hout⟩ := exit43 hpos (P := P) (k := k) st' wh []
    refine ⟨np + n2, s', by rw [run43_add, hp]; exact h2, ?_⟩
    rw [hout]; simp only [List.nil_append]
    exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
  | succ t ih =>
    intro m st wh henc hh
    obtain ⟨np, st', _, henc', hp⟩ := pass43 hpos hwf m st henc wh []
    by_cases h0 : Halted P (mstep P m)
    · rw [if_pos h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := exit43 hpos (P := P) (k := k) st' wh []
      refine ⟨np + n2, s', by rw [run43_add, hp]; exact h2, ?_⟩
      rw [hout, mrun_halted h0]; simp only [List.nil_append]
      exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
    · rw [if_neg h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := ih (mstep P m) st' wh henc' hh
      exact ⟨np + n2, s', by rw [run43_add, hp]; exact h2, hout⟩

/-- **If the machine halts, the deck of 1842–1843 halts**, by passing its last
card, and gives off the counters of the halted machine, counter 0 first. -/
theorem halts43 {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length) (c : Nat → Nat)
    (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ n s', run43 intArith pos zero (deck43 P k) n ⟨0, initStore k c, none, []⟩ = .halt s' ∧
      s'.out = (List.range k).map (fun r => ((mrun P t ⟨0, c⟩).c r : Int)) := by
  have e : mrun P t (mstep P ⟨0, c⟩) = mrun P t ⟨0, c⟩ := by
    rw [← mrun, mrun_succ', mstep_halted h]
  rw [← e] at h ⊢
  exact loop43 hpos hwf t _ _ none (enc_init P k hn c) h

omit hpos in
theorem run43_split {d : Deck43} {s s1 s' : State Int} {a n : Nat}
    (h1 : run43 intArith pos zero d a s = .run s1) (h2 : run43 intArith pos zero d n s = .halt s') :
    a ≤ n ∧ run43 intArith pos zero d (n - a) s1 = .halt s' := by
  by_cases h : a ≤ n
  · refine ⟨h, ?_⟩
    have := run43_add intArith pos zero d a (n - a) s
    rw [Nat.add_sub_cancel' h, h1] at this
    simp only at this
    rw [← this]; exact h2
  · exfalso
    have := run43_add intArith pos zero d n (a - n) s
    rw [Nat.add_sub_cancel' (by omega), h2, h1] at this
    cases this

/-- **If the deck of 1842–1843 halts, the machine halts.** -/
theorem machine_halts_of_43 {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length)
    (c : Nat → Nat) (n : Nat) (s' : State Int)
    (h : run43 intArith pos zero (deck43 P k) n ⟨0, initStore k c, none, []⟩ = .halt s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) := by
  suffices H : ∀ n (m : MConf) (st : Nat → Int) wh out, Enc k P.length m st →
      run43 intArith pos zero (deck43 P k) n ⟨0, st, wh, out⟩ = .halt s' → ∃ t, Halted P (mrun P t m) from
    H n _ _ none [] (enc_init P k hn c) h
  intro n
  induction n using Nat.strongRecOn with
  | _ n ih =>
    intro m st wh out henc hrun
    obtain ⟨np, st', hnp, henc', hp⟩ := pass43 hpos hwf m st henc wh out
    by_cases h0 : Halted P (mstep P m)
    · exact ⟨1, h0⟩
    · rw [if_neg h0] at hp
      obtain ⟨hle, hrest⟩ := run43_split hp hrun
      obtain ⟨t, ht⟩ := ih (n - np) (by omega) _ _ _ _ henc' hrest
      exact ⟨t + 1, by simpa [mrun] using ht⟩

end run

/-! ## Which cards, and which configurations accept them -/

/-- Only operation cards, result cards and backings made effective by a result,
each backing going back. -/
def Good43 (l : List Card43) (off : Nat) : Prop :=
  ∀ (i : Nat) card, l[i]? = some card →
    match card with
    | .backIf t _ => t ≤ off + i
    | .c (.op _ _ _ _) => True
    | .c (.result _) => True
    | _ => False

theorem good43_append {a b : List Card43} {off : Nat} (ha : Good43 a off)
    (hb : Good43 b (off + a.length)) : Good43 (a ++ b) off := by
  intro i card h
  by_cases hi : i < a.length
  · rw [List.getElem?_append_left hi] at h; exact ha i card h
  · rw [List.getElem?_append_right (by omega)] at h
    have := hb _ card h
    rw [show off + a.length + (i - a.length) = off + i by omega] at this
    exact this

theorem good43_map {l : List Card} {off : Nat}
    (h : ∀ c ∈ l, (∃ o a b dst, c = Card.op o a b dst) ∨ ∃ r, c = Card.result r) :
    Good43 (l.map Card43.c) off := by
  intro i card hi
  rw [List.getElem?_map] at hi
  cases hl : l[i]? with
  | none => rw [hl] at hi; cases hi
  | some c =>
    rw [hl] at hi; cases hi
    rcases h c (List.mem_of_getElem? hl) with ⟨o, a, b, dst, rfl⟩ | ⟨r, rfl⟩ <;> trivial

theorem good43_flags (k : Nat) : ∀ m, Good43 (upTo43 (flag43 k) m) 0 := by
  intro m
  induction m with
  | zero => intro i card h; simp [upTo43] at h
  | succ m ih =>
    apply good43_append ih
    rw [length_flags43]
    intro i card h
    simp only [flag43] at h
    match i, h with
    | 0, h | 1, h | 2, h | 3, h | 4, h => simp at h; subst h; trivial
    | 5, h => simp at h; subst h; show 6 * m + 1 ≤ 0 + 6 * m + 5; omega
    | i + 6, h => simp at h

theorem good43_deck (P : Prog) (k : Nat) : Good43 (deck43 P k) 0 := by
  unfold deck43
  refine good43_append (good43_append (good43_append (good43_flags k k) ?_) ?_) ?_
  · apply good43_map
    intro c hc
    have := straight_ops P k c hc
    cases c with
    | op o a b dst => exact Or.inl ⟨o, a, b, dst, rfl⟩
    | _ => simp [IsOp] at this
  · intro i card h
    match i, h with
    | 0, h => simp [tail43] at h; subst h; trivial
    | 1, h => simp [tail43] at h; subst h; show 0 ≤ _; omega
    | i + 2, h => simp [tail43] at h
  · apply good43_map
    intro c hc
    obtain ⟨j, _, hj⟩ := mem_upTo hc
    simp [resultCard] at hj
    exact Or.inr ⟨_, hj⟩

/-- **Only what the published accounts describe**: every card of the deck is an
operation card, a result card, or a backing made effective by a result of the
mill. There is no combinatorial card, no counted or unconditional backing and
no repetition card. -/
theorem deck43_plain (P : Prog) (k : Nat) :
    ∀ card ∈ deck43 P k, (∃ o a b dst, card = .c (.op o a b dst)) ∨
      (∃ r, card = .c (.result r)) ∨ ∃ t col, card = .backIf t col := by
  intro card hc
  obtain ⟨i, hi⟩ := List.getElem?_of_mem hc
  have := good43_deck P k i card hi
  cases card with
  | backIf t col => exact Or.inr (Or.inr ⟨t, col, rfl⟩)
  | aheadIf => exact this.elim
  | c card =>
    cases card with
    | op o a b dst => exact Or.inl ⟨o, a, b, dst, rfl⟩
    | result r => exact Or.inr (Or.inl ⟨r, rfl⟩)
    | rep => exact this.elim
    | set => exact this.elim
    | back => exact this.elim

/-- The configuration of 30 May 1838 with the backing of Note G accepts the deck. -/
theorem deck43_accepted (P : Prog) (k : Nat) : Accepts43 c1838 true false (deck43 P k) := by
  intro i card h
  have hg := good43_deck P k i card h
  cases card with
  | backIf t col => exact ⟨rfl, rfl, by simpa using hg, Or.inl rfl⟩
  | aheadIf => exact hg.elim
  | c card =>
    cases card with
    | op => trivial
    | result => trivial
    | rep => exact hg.elim
    | set => exact hg.elim
    | back => exact hg.elim

/-- **No configuration without it accepts the deck**: its loop ends on a result. -/
theorem deck43_refused (P : Prog) (k : Nat) (c : Config) (b : Bool) :
    ¬ Accepts43 c false b (deck43 P k) := by
  intro hacc
  obtain ⟨_, _, htl, _⟩ := deck43_seg P k
  have g : (deck43 P k)[6 * k + (straight P k).length + 1]? = some (.backIf 0 W) := by
    simpa [tail43] using seg43_get htl (i := 1) (by simp [tail43])
  have := hacc _ _ g
  simp at this

/-! ## Halting, for any deck whose passes are steps -/

section gen
variable {pos zero : Int → Bool} {P : Prog} {k : Nat} {d : Deck43} {R : Nat}
  (hpass : ∀ (m : MConf) (st : Nat → Int) (wh : Option Nat) (out : List Int),
    Enc k P.length m st →
    ∃ np st' wh', 0 < np ∧ Enc k P.length (mstep P m) st' ∧
      run43 intArith pos zero d np ⟨0, st, wh, out⟩ =
        if Halted P (mstep P m) then .run ⟨R, st', wh', out⟩ else .run ⟨0, st', wh', out⟩)
  (hexit : ∀ (st : Nat → Int) (wh : Option Nat) (out : List Int), ∃ n s',
    run43 intArith pos zero d n ⟨R, st, wh, out⟩ = .halt s' ∧
      s'.out = out ++ (List.range k).map (fun r => st (C r)))
include hpass hexit

theorem loopG : ∀ t (m : MConf) (st : Nat → Int) (wh : Option Nat), Enc k P.length m st →
    Halted P (mrun P t (mstep P m)) →
    ∃ n s', run43 intArith pos zero d n ⟨0, st, wh, []⟩ = .halt s' ∧
      s'.out = (List.range k).map (fun r => ((mrun P t (mstep P m)).c r : Int)) := by
  intro t
  induction t with
  | zero =>
    intro m st wh henc hh
    simp only [mrun] at hh ⊢
    obtain ⟨np, st', wh', _, henc', hp⟩ := hpass m st wh [] henc
    rw [if_pos hh] at hp
    obtain ⟨n2, s', h2, hout⟩ := hexit st' wh' []
    refine ⟨np + n2, s', by rw [run43_add, hp]; exact h2, ?_⟩
    rw [hout]; simp only [List.nil_append]
    exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
  | succ t ih =>
    intro m st wh henc hh
    obtain ⟨np, st', wh', _, henc', hp⟩ := hpass m st wh [] henc
    by_cases h0 : Halted P (mstep P m)
    · rw [if_pos h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := hexit st' wh' []
      refine ⟨np + n2, s', by rw [run43_add, hp]; exact h2, ?_⟩
      rw [hout, mrun_halted h0]; simp only [List.nil_append]
      exact List.map_congr_left (fun r hr => henc'.c r (List.mem_range.mp hr))
    · rw [if_neg h0] at hp
      obtain ⟨n2, s', h2, hout⟩ := ih (mstep P m) st' wh' henc' hh
      exact ⟨np + n2, s', by rw [run43_add, hp]; exact h2, hout⟩

theorem haltsG (hn : 0 < P.length) (c : Nat → Nat) (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ n s', run43 intArith pos zero d n ⟨0, initStore k c, none, []⟩ = .halt s' ∧
      s'.out = (List.range k).map (fun r => ((mrun P t ⟨0, c⟩).c r : Int)) := by
  have e : mrun P t (mstep P ⟨0, c⟩) = mrun P t ⟨0, c⟩ := by
    rw [← mrun, mrun_succ', mstep_halted h]
  rw [← e] at h ⊢
  exact loopG hpass hexit t _ _ none (enc_init P k hn c) h

omit hexit in
theorem machineG (hn : 0 < P.length) (c : Nat → Nat) (n : Nat) (s' : State Int)
    (h : run43 intArith pos zero d n ⟨0, initStore k c, none, []⟩ = .halt s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) := by
  suffices H : ∀ n (m : MConf) (st : Nat → Int) wh out, Enc k P.length m st →
      run43 intArith pos zero d n ⟨0, st, wh, out⟩ = .halt s' → ∃ t, Halted P (mrun P t m) from
    H n _ _ none [] (enc_init P k hn c) h
  intro n
  induction n using Nat.strongRecOn with
  | _ n ih =>
    intro m st wh out henc hrun
    obtain ⟨np, st', wh', hnp, henc', hp⟩ := hpass m st wh out henc
    by_cases h0 : Halted P (mstep P m)
    · exact ⟨1, h0⟩
    · rw [if_neg h0] at hp
      obtain ⟨hle, hrest⟩ := run43_split hp hrun
      obtain ⟨t, ht⟩ := ih (n - np) (by omega) _ _ _ _ henc' hrest
      exact ⟨t + 1, by simpa [mrun] using ht⟩

end gen

/-! ## Reading B: a forward course chosen by a result -/

/-- [c_r > 0] into F_r: F := 0; ahead to 3r + 3 if c_r is zero; F := 1. -/
def flagB (k r : Nat) : List Card43 :=
  [.c (.op .add (.num 0) (.num 0) (F k r)),
   .aheadIf (3 * r + 3) (C r),
   .c (.op .add (.num 0) (.num 1) (F k r))]

/-- The end of each pass, at card q: W := W − 1; ahead past the next card when
it is zero (the machine has halted); otherwise back to card 0, always. -/
def tailB (q : Nat) : List Card43 :=
  [.c (.op .sub (.col W) (.num 1) W), .aheadIf (q + 3) W, .c (.back 0 false)]

/-- **The deck of Reading B**: flags by forward courses, the straight cards of
`compile`, `tailB`, and the counters given off. -/
def deckB (P : Prog) (k : Nat) : Deck43 :=
  upTo43 (flagB k) k ++ (straight P k).map Card43.c ++ tailB (3 * k + (straight P k).length) ++
    (upTo resultCard k).map Card43.c

theorem length_flagsB (k : Nat) : ∀ m, (upTo43 (flagB k) m).length = 3 * m :=
  length_upTo43 _ 3 (fun _ => by simp [flagB])

theorem deckB_seg (P : Prog) (k : Nat) :
    Seg43 (deckB P k) 0 (upTo43 (flagB k) k) ∧
      Seg43 (deckB P k) (3 * k) ((straight P k).map Card43.c) ∧
      Seg43 (deckB P k) (3 * k + (straight P k).length) (tailB (3 * k + (straight P k).length)) ∧
      Seg43 (deckB P k) (3 * k + (straight P k).length + 3) ((upTo resultCard k).map Card43.c) := by
  have hseg := seg43_self (deckB P k)
  have ⟨hA, hR⟩ := seg43_append hseg
  have ⟨hB, hT⟩ := seg43_append hA
  have ⟨hF, hS⟩ := seg43_append hB
  simp only [Nat.zero_add, List.length_append, List.length_map, length_flagsB, tailB,
    List.length_cons, List.length_nil] at hS hT hR
  exact ⟨hF, hS, hT, by simpa [Nat.add_assoc] using hR⟩

section runB
variable {pos zero : Int → Bool} (hz : ∀ n : Nat, zero (n : Int) = decide (n = 0))
include hz

theorem flagB_block {d : Deck43} {k r : Nat} (hseg : Seg43 d (3 * r) (flagB k r)) (hr : r < k)
    (out : List Int) (wh : Option Nat) (st : Nat → Int) (c : Nat) (hc : st (C r) = c) :
    ∃ n st', run43 intArith pos zero d n ⟨3 * r, st, wh, out⟩ = .run ⟨3 * r + 3, st', wh, out⟩ ∧
      st' (F k r) = (if 0 < c then 1 else 0) ∧ ∀ x, x ≠ F k r → st' x = st x := by
  have g : ∀ i (hi : i < 3), d[3 * r + i]? = some ((flagB k r)[i]'(by simp [flagB]; omega)) :=
    fun i hi => seg43_get hseg _
  have g0 := g 0 (by omega); have g1 := g 1 (by omega); have g2 := g 2 (by omega)
  simp only [flagB, Nat.add_zero] at g0 g1 g2
  simp only [List.getElem_cons_succ, List.getElem_cons_zero] at g0 g1 g2
  have hCF : C r ≠ F k r := by unfold C F; omega
  have e1 : (upd st (F k r) 0) (C r) = c := by rw [upd_ne' _ _ hCF, hc]
  cases c with
  | zero =>
    have hzz : zero ((upd st (F k r) 0) (C r)) = true := by rw [e1]; simpa using hz 0
    refine ⟨2, upd st (F k r) 0, ?_, by simp [upd_same'], fun x hx => upd_ne' _ _ hx⟩
    simp [run43, step43, g0, g1, fetch, intOp, hzz]
  | succ w =>
    have hzz : zero ((upd st (F k r) 0) (C r)) = false := by rw [e1]; simpa using hz (w + 1)
    refine ⟨3, upd (upd st (F k r) 0) (F k r) 1, ?_, by simp [upd_same'],
      fun x hx => by rw [upd_ne' _ _ hx, upd_ne' _ _ hx]⟩
    simp [run43, step43, g0, g1, g2, fetch, intOp, hzz, Nat.add_assoc]

theorem flagsB_run {d : Deck43} {k : Nat} (hseg : Seg43 d 0 (upTo43 (flagB k) k)) (out : List Int)
    (c : Nat → Nat) : ∀ m, m ≤ k → ∀ (wh : Option Nat) (st : Nat → Int),
      (∀ r, r < k → st (C r) = c r) →
      ∃ n st', run43 intArith pos zero d n ⟨0, st, wh, out⟩ = .run ⟨3 * m, st', wh, out⟩ ∧
        (∀ r, r < m → st' (F k r) = (if 0 < c r then 1 else 0)) ∧
        ∀ x, 5 ≤ x → (x < F k 0 ∨ F k m ≤ x) → st' x = st x := by
  intro m
  induction m with
  | zero => intro _ wh st _; exact ⟨0, st, by simp [run43], by simp, by simp⟩
  | succ m ih =>
    intro hm wh st hc
    obtain ⟨n, st1, h1, hF1, hx1⟩ := ih (by omega) wh st hc
    have hs : Seg43 d (3 * m) (flagB k m) := by
      have := seg43_upTo hseg m (by omega)
      simpa [length_flagsB] using this
    have hcm : st1 (C m) = c m := by
      rw [hx1 _ (by unfold C; omega) (Or.inl (by unfold C F; omega))]; exact hc m (by omega)
    obtain ⟨n2, st2, h2, hF2, hx2⟩ := flagB_block hz hs (by omega) out wh st1 (c m) hcm
    refine ⟨n + n2, st2, ?_, ?_, ?_⟩
    · rw [run43_add, h1]; simpa [Nat.mul_succ] using h2
    · intro r hr
      rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hr) with hr | rfl
      · rw [hx2 _ (by unfold F; omega)]; exact hF1 r hr
      · exact hF2
    · intro x h5 hx
      rw [hx2 _ (by unfold F at *; omega)]
      exact hx1 x h5 (by unfold F at *; omega)

theorem passB {P : Prog} {k : Nat} (hwf : WF P k) (m : MConf) (st : Nat → Int) (wh : Option Nat)
    (out : List Int) (henc : Enc k P.length m st) :
    ∃ np st' wh', 0 < np ∧ Enc k P.length (mstep P m) st' ∧
      run43 intArith pos zero (deckB P k) np ⟨0, st, wh, out⟩ =
        if Halted P (mstep P m) then .run ⟨3 * k + (straight P k).length + 3, st', wh', out⟩
        else .run ⟨0, st', wh', out⟩ := by
  obtain ⟨hfl, hst, htl, _⟩ := deckB_seg P k
  obtain ⟨n1, st1, h1, hF1, hx1⟩ := flagsB_run (pos := pos) hz hfl out m.c k (Nat.le_refl _) wh st
    (fun r hr => henc.c r hr)
  have henc1 : Enc k P.length m st1 := by
    refine ⟨henc.q_lt, fun j hj => ?_, fun r hr => ?_⟩
    · rw [hx1 _ (by simp only [S]; omega) (Or.inr (by simp only [S, F]; omega))]; exact henc.s j hj
    · rw [hx1 _ (by simp only [C]; omega) (Or.inl (by simp only [C, F]; omega))]; exact henc.c r hr
  have h2 := run43_straight (pos := pos) (zero := zero) (d := deckB P k) (straight P k) (3 * k) st1 wh
    out hst (straight_ops P k)
  obtain ⟨henc2, hW⟩ := straight_effect hwf m st1 henc1 hF1
  generalize hs2 : exec (straight P k) st1 = st2 at henc2 hW h2
  generalize hq : 3 * k + (straight P k).length = q at htl h2 ⊢
  have gsub : (deckB P k)[q]? = some (.c (.op .sub (.col W) (.num 1) W)) := by
    simpa [tailB] using seg43_get htl (i := 0) (by simp [tailB])
  have gah : (deckB P k)[q + 1]? = some (.aheadIf (q + 3) W) := by
    simpa [tailB] using seg43_get htl (i := 1) (by simp [tailB])
  have gbk : (deckB P k)[q + 2]? = some (.c (.back 0 false)) := by
    simpa [tailB] using seg43_get htl (i := 2) (by simp [tailB])
  let st3 := upd st2 W (st2 W - 1)
  have henc3 : Enc k P.length (mstep P m) st3 :=
    ⟨henc2.q_lt, fun j hj => by simp only [st3]; rw [upd_ne' _ _ (by simp only [S, W]; omega)]; exact henc2.s j hj,
      fun r hr => by simp only [st3]; rw [upd_ne' _ _ (by simp only [C, W]; omega)]; exact henc2.c r hr⟩
  have hsub : run43 intArith pos zero (deckB P k) 1 ⟨q, st2, wh, out⟩ = .run ⟨q + 1, st3, wh, out⟩ := by
    simp [run43, step43, gsub, fetch, intOp, st3]
  by_cases hh : Halted P (mstep P m)
  · rw [if_pos hh] at hW
    have hzz : zero (st3 W) = true := by
      have e : st3 W = ((0 : Nat) : Int) := by simp [st3, upd, hW]
      rw [e, hz]; rfl
    refine ⟨n1 + ((straight P k).length + (1 + 1)), st3, wh, by omega, henc3, ?_⟩
    rw [if_pos hh, run43_add, h1]; simp only; rw [run43_add, h2]; simp only; rw [run43_add, hsub]
    simp only
    simp [run43, step43, gah, hzz]
  · rw [if_neg hh] at hW
    have hzz : zero (st3 W) = false := by
      have e : st3 W = ((1 : Nat) : Int) := by simp [st3, upd, hW]
      rw [e, hz]; rfl
    have gah' : (deckB P k)[q + 1]? = some (.aheadIf (q + 3) W) := gah
    refine ⟨n1 + ((straight P k).length + (1 + 2)), st3, wh, by omega, henc3, ?_⟩
    rw [if_neg hh, run43_add, h1]; simp only; rw [run43_add, h2]; simp only; rw [run43_add, hsub]
    simp only
    have gbk' : (deckB P k)[q + 1 + 1]? = some (.c (.back 0 false)) := gbk
    simp [run43, step43, gah', hzz, gbk']

theorem exitB {P : Prog} {k : Nat} (st : Nat → Int) (wh : Option Nat) (out : List Int) :
    ∃ n s', run43 intArith pos zero (deckB P k) n ⟨3 * k + (straight P k).length + 3, st, wh, out⟩ =
      .halt s' ∧ s'.out = out ++ (List.range k).map (fun r => st (C r)) := by
  obtain ⟨_, _, _, hres⟩ := deckB_seg P k
  have hlen : (deckB P k).length = 3 * k + (straight P k).length + 3 + k := by
    simp [deckB, length_flagsB, tailB, length_upTo resultCard 1 (fun _ => rfl)]; omega
  refine ⟨k + 1, ⟨3 * k + (straight P k).length + 3 + k, st, wh,
    out ++ (List.range k).map (fun r => st (C r))⟩, ?_, rfl⟩
  rw [run43_add, results43_run hres st wh out k (Nat.le_refl _)]
  have : (deckB P k)[3 * k + (straight P k).length + 3 + k]? = none :=
    List.getElem?_eq_none (by omega)
  simp [run43, step43, this]

/-- **Reading B: if the machine halts, the deck halts**, by passing its last
card, and gives off the counters. -/
theorem haltsB {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length) (c : Nat → Nat)
    (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ n s', run43 intArith pos zero (deckB P k) n ⟨0, initStore k c, none, []⟩ = .halt s' ∧
      s'.out = (List.range k).map (fun r => ((mrun P t ⟨0, c⟩).c r : Int)) :=
  haltsG (fun m st wh out henc => passB hz hwf m st wh out henc) (fun st wh out => exitB hz st wh out)
    hn c t h

/-- **Reading B: if the deck halts, the machine halts.** -/
theorem machine_halts_of_B {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length)
    (c : Nat → Nat) (n : Nat) (s' : State Int)
    (h : run43 intArith pos zero (deckB P k) n ⟨0, initStore k c, none, []⟩ = .halt s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) :=
  machineG (fun m st wh out henc => passB hz hwf m st wh out henc) hn c n s' h

end runB

/-- Operation cards, result cards, forward courses chosen by a result, and
backing to card 0 always. -/
def GoodB (l : List Card43) (off : Nat) : Prop :=
  ∀ (i : Nat) card, l[i]? = some card →
    match card with
    | .aheadIf t _ => off + i < t
    | .c (.back t false) => t = 0
    | .c (.op _ _ _ _) => True
    | .c (.result _) => True
    | _ => False

theorem goodB_append {a b : List Card43} {off : Nat} (ha : GoodB a off)
    (hb : GoodB b (off + a.length)) : GoodB (a ++ b) off := by
  intro i card h
  by_cases hi : i < a.length
  · rw [List.getElem?_append_left hi] at h; exact ha i card h
  · rw [List.getElem?_append_right (by omega)] at h
    have := hb _ card h
    rw [show off + a.length + (i - a.length) = off + i by omega] at this
    exact this

theorem goodB_map {l : List Card} {off : Nat}
    (h : ∀ c ∈ l, (∃ o a b dst, c = Card.op o a b dst) ∨ ∃ r, c = Card.result r) :
    GoodB (l.map Card43.c) off := by
  intro i card hi
  rw [List.getElem?_map] at hi
  cases hl : l[i]? with
  | none => rw [hl] at hi; cases hi
  | some c =>
    rw [hl] at hi; cases hi
    rcases h c (List.mem_of_getElem? hl) with ⟨o, a, b, dst, rfl⟩ | ⟨r, rfl⟩ <;> trivial

theorem goodB_deck (P : Prog) (k : Nat) : GoodB (deckB P k) 0 := by
  unfold deckB
  refine goodB_append (goodB_append (goodB_append ?_ ?_) ?_) ?_
  · intro m
    exact (show ∀ m, GoodB (upTo43 (flagB k) m) 0 from by
      intro m
      induction m with
      | zero => intro i card h; simp [upTo43] at h
      | succ m ih =>
        apply goodB_append ih
        rw [length_flagsB]
        intro i card h
        simp only [flagB] at h
        match i, h with
        | 0, h | 2, h => simp at h; subst h; trivial
        | 1, h => simp at h; subst h; show 0 + 3 * m + 1 < 3 * m + 3; omega
        | i + 3, h => simp at h) k m
  · apply goodB_map
    intro c hc
    have := straight_ops P k c hc
    cases c with
    | op o a b dst => exact Or.inl ⟨o, a, b, dst, rfl⟩
    | _ => simp [IsOp] at this
  · intro i card h
    match i, h with
    | 0, h | 2, h => simp [tailB] at h; subst h; trivial
    | 1, h => simp [tailB] at h; subst h; simp [length_flagsB]
    | i + 3, h => simp [tailB] at h
  · apply goodB_map
    intro c hc
    obtain ⟨j, _, hj⟩ := mem_upTo hc
    simp [resultCard] at hj
    exact Or.inr ⟨_, hj⟩

/-- **Only Reading B's cards**: operation cards, result cards, forward courses
chosen by a result, and an unconditional backing to card 0. No combinatorial
card, counted backing, repetition card or `backIf`. -/
theorem deckB_plain (P : Prog) (k : Nat) :
    ∀ card ∈ deckB P k, (∃ o a b dst, card = .c (.op o a b dst)) ∨ (∃ r, card = .c (.result r)) ∨
      (∃ t col, card = .aheadIf t col) ∨ card = .c (.back 0 false) := by
  intro card hc
  obtain ⟨i, hi⟩ := List.getElem?_of_mem hc
  have := goodB_deck P k i card hi
  cases card with
  | backIf => exact this.elim
  | aheadIf t col => exact Or.inr (Or.inr (Or.inl ⟨t, col, rfl⟩))
  | c card =>
    cases card with
    | op o a b dst => exact Or.inl ⟨o, a, b, dst, rfl⟩
    | result r => exact Or.inr (Or.inl ⟨r, rfl⟩)
    | back t b =>
      cases b with
      | false => simp at this; subst this; exact Or.inr (Or.inr (Or.inr rfl))
      | true => exact this.elim
    | rep => exact this.elim
    | set => exact this.elim

/-- **December 1837 with Reading B's card accepts it**: it backs only to card 0.
So does every configuration with backing cards. -/
theorem deckB_accepted (P : Prog) (k : Nat) (c : Config) (hb : c.backing = true) :
    Accepts43 c false true (deckB P k) := by
  intro i card h
  have hg := goodB_deck P k i card h
  cases card with
  | backIf => exact hg.elim
  | aheadIf t col => exact ⟨rfl, by simpa using hg⟩
  | c card =>
    cases card with
    | op => trivial
    | result => trivial
    | back t b =>
      cases b with
      | false =>
        simp at hg; subst hg
        exact ⟨hb, Nat.zero_le _, Or.inr rfl, fun h => absurd h (by decide)⟩
      | true => exact hg.elim
    | rep => exact hg.elim
    | set => exact hg.elim

theorem deckB_refused (P : Prog) (k : Nat) (c : Config) (b : Bool) :
    ¬ Accepts43 c b false (deckB P k) := by
  intro hacc
  obtain ⟨_, _, htl, _⟩ := deckB_seg P k
  have g : (deckB P k)[3 * k + (straight P k).length + 1]? =
      some (.aheadIf (3 * k + (straight P k).length + 3) W) := by
    simpa [tailB] using seg43_get htl (i := 1) (by simp [tailB])
  have := hacc _ _ g
  simp at this

end Minsky

end Babbage
