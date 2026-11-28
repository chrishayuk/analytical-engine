/-!
# Multiplication without table, at the level of tooth turns

A model of `scripts/f_control.py` (rules: `docs/f-mill-rules.md` T1–T6,
`docs/f-engage-rules.md`) and the proof that its mechanism multiplies. Nothing in the
model adds or multiplies numbers: a figure is turned one tooth (`fwd`, `bwd`: forward
or back, modulo 10), a counter notices a running up, a wheel's warning is set when it
turns from 9 to 0. Values (`val`, `valW`) appear only in the statements.

* `give_off_retain` (1): nine rows of give off leave the giver at zero and the retaining
  wheel holding its figures.
* `add_band` (2): give off into the product, then row 13's carriage, is exact addition
  when the sum fits (`val b + val g < 10 ^ n`); the carriage stops by itself.
* `step_band`, `step_multiplier` (3): a step multiplies by ten, the top figure leaving
  the axis; for the multiplier it goes onto K.
* `countDown_spec`, `add_loop` (4): with K at `d`, exactly `d` additions and then K's
  running up, K left at zero.
* `multiply_correct`, `multiply_invariant`, `multiply_stays`, `multiply_lists` (5): the
  controller ends, after `2p + ΣM + 1` decisions, with the product `a · value M`, after
  `p + ΣM` bands; after `i` figures the product is `a · value (first i figures)`.

**How it follows the Python.** Rows are given cage by cage (`addRow`, `stepRow`,
`carryRound`): within one row, or one round of carriage, each cage of a receiving wheel
is turned only by one cage of the giver (the same cage, or the one below for a step, or
the warning below for carriage), so the order in which `execute` visits the cages does
not matter; that is argued here, not proved against a sequential loop. The nine rows are
iterated as written (`iter … 9`), not collapsed. A band moving B and C together
(`stepRow2`) turns both axes in each row. The while loop of carriage is `carriage` with
a bound of `n` rounds, and `carriage_spec` shows no warning is left, so the bound is
never what stops it. Warnings start clear in each addition band (in the Python they are
cleared by the carriage of the band before, and no step sets one).

**Not modelled:** the bolting and the engagements E0–E3 (`ctl` names the giving and
receiving wheels directly from the controller's state `on`, as E0–E3 do in the Python
run); the band labels; the overflow record is a count, not a list.
-/

namespace Babbage.Mill

/-! ## Figures, wheels and values -/

/-- A figure wheel: cage `c` (cage 0 the lowest) to its figure. Only cages below the
axis's number of cages are ever turned. -/
abbrev Wheel := Nat → Nat

/-- One tooth forward, and one tooth back. -/
def fwd (d : Nat) : Nat := (d + 1) % 10
def bwd (d : Nat) : Nat := (d + 9) % 10

/-- `f` applied `k` times. -/
def iter {α : Type} (f : α → α) : Nat → α → α
  | 0, x => x
  | k + 1, x => f (iter f k x)

theorem iter_add {α : Type} (f : α → α) (a b : Nat) (x : α) :
    iter f (a + b) x = iter f a (iter f b x) := by
  induction a with
  | zero => simp [iter]
  | succ a ih => rw [Nat.add_right_comm]; simp [iter, ih]

theorem iter_succ' {α : Type} (f : α → α) (k : Nat) (x : α) :
    iter f (k + 1) x = iter f k (f x) := by
  rw [iter_add]; rfl

/-- The value of the first `n` cages. -/
def val (f : Wheel) : Nat → Nat
  | 0 => 0
  | n + 1 => f 0 + 10 * val (fun c => f (c + 1)) n

/-- Every cage below `n` at a figure 0–9. -/
def Fig (n : Nat) (f : Wheel) : Prop := ∀ c, c < n → f c < 10
/-- Every cage below `n` at 0. -/
def Zero (n : Nat) (f : Wheel) : Prop := ∀ c, c < n → f c = 0

theorem val_congr {n : Nat} {f g : Wheel} (h : ∀ c, c < n → f c = g c) :
    val f n = val g n := by
  induction n generalizing f g with
  | zero => rfl
  | succ n ih =>
    simp only [val]
    rw [h 0 (by omega), ih (fun c hc => h (c + 1) (by omega))]

theorem val_add (f g : Wheel) (n : Nat) :
    val (fun c => f c + g c) n = val f n + val g n := by
  induction n generalizing f g with
  | zero => rfl
  | succ n ih =>
    simp only [val]
    rw [ih (fun c => f (c + 1)) (fun c => g (c + 1))]
    omega

theorem val_mul (k : Nat) (f : Wheel) (n : Nat) :
    val (fun c => k * f c) n = k * val f n := by
  induction n generalizing f with
  | zero => simp [val]
  | succ n ih =>
    simp only [val]
    rw [ih (fun c => f (c + 1)), Nat.mul_add, Nat.mul_left_comm]

theorem val_zero {n : Nat} {f : Wheel} (h : Zero n f) : val f n = 0 := by
  rw [val_congr (g := fun _ => 0) h]
  have := val_mul 0 (fun _ => 0) n
  simpa using this

theorem val_succ' (f : Wheel) (n : Nat) : val f (n + 1) = val f n + f n * 10 ^ n := by
  induction n generalizing f with
  | zero => simp [val]
  | succ n ih =>
    rw [val, ih (fun c => f (c + 1)), val, Nat.pow_succ]
    simp only [Nat.mul_add, Nat.add_assoc, Nat.mul_comm, Nat.mul_left_comm]

theorem val_lt {n : Nat} {f : Wheel} (h : Fig n f) : val f n < 10 ^ n := by
  induction n generalizing f with
  | zero => simp [val]
  | succ n ih =>
    have h1 := ih (f := fun c => f (c + 1)) (fun c hc => h (c + 1) (by omega))
    have h0 := h 0 (by omega)
    simp only [val, Nat.pow_succ]
    omega

theorem top_le_val (f : Wheel) (n : Nat) : f n * 10 ^ n ≤ val f (n + 1) := by
  rw [val_succ']; omega

/-- A wheel whose figures are those of `f` moved one cage up, 0 in cage 0. -/
theorem val_shift (f : Wheel) (n : Nat) :
    val (fun c => if c = 0 then 0 else f (c - 1)) (n + 1) = 10 * val f n := by
  simp [val]


theorem fwd_lt (d : Nat) : fwd d < 10 := Nat.mod_lt _ (by omega)

theorem fwd_add (x j : Nat) : fwd ((x + j) % 10) = (x + (j + 1)) % 10 := by
  simp only [fwd]; omega

/-! ## Give off with retain, into a product (rows 1–9, T1–T3, T5)

The state of the three wheels engaged in an addition band: the giving wheel `g`
(the multiplicand's wheel that holds it), the retaining wheel `a` (its other wheel,
same cage), the product wheel `b` (same cage), and the product's warnings `w`. -/

structure AddS where
  g : Wheel
  a : Wheel
  b : Wheel
  w : Nat → Bool

/-- One row: every cage of the giver not at 0 turns back one tooth, and for that tooth
the retaining wheel's and the product's same cage turn forward one tooth; a product
cage turned from 9 to 0 sets its warning (T5). Cages are independent within a row
(each touches only its own cage of each wheel), so the row is given cage by cage. -/
def addRow (n : Nat) (s : AddS) : AddS where
  g c := if c < n ∧ s.g c ≠ 0 then bwd (s.g c) else s.g c
  a c := if c < n ∧ s.g c ≠ 0 then fwd (s.a c) else s.a c
  b c := if c < n ∧ s.g c ≠ 0 then fwd (s.b c) else s.b c
  w c := if c < n ∧ s.g c ≠ 0 ∧ s.b c = 9 then true else s.w c

/-- After `k` rows, cage by cage. -/
theorem addRow_iter (n : Nat) (s : AddS) (hg : Fig n s.g) (ha : Fig n s.a) (hb : Fig n s.b)
    (k c : Nat) :
    (iter (addRow n) k s).g c = (if c < n then s.g c - k else s.g c) ∧
    (iter (addRow n) k s).a c = (if c < n then (s.a c + min k (s.g c)) % 10 else s.a c) ∧
    (iter (addRow n) k s).b c = (if c < n then (s.b c + min k (s.g c)) % 10 else s.b c) ∧
    (iter (addRow n) k s).w c =
      (if c < n then (s.w c || decide (10 ≤ s.b c + min k (s.g c))) else s.w c) := by
  induction k with
  | zero =>
    by_cases hc : c < n
    · have := hg c hc; have := ha c hc; have := hb c hc
      simp only [iter, hc, ↓reduceIte, Nat.sub_zero]
      refine ⟨trivial, ?_, ?_, ?_⟩ <;> grind
    · simp [iter, hc]
  | succ k ih =>
    obtain ⟨h1, h2, h3, h4⟩ := ih
    simp only [iter] at *
    simp only [addRow]
    rw [h1, h2, h3, h4]
    by_cases hc : c < n
    · have := hg c hc
      have := hb c hc
      simp only [hc, ↓reduceIte, true_and]
      refine ⟨?_, ?_, ?_, ?_⟩ <;> grind [fwd, bwd]
    · simp [hc]

/-- **Theorem 1 (give off with retain).** After the nine rows the giving wheel stands at
zero and the retaining wheel, at zero before, holds the giver's figures, cage for cage;
so its value is the giver's. -/
theorem give_off_retain (n : Nat) (s : AddS) (hg : Fig n s.g) (ha : Zero n s.a)
    (hb : Fig n s.b) :
    Zero n (iter (addRow n) 9 s).g ∧ (∀ c, c < n → (iter (addRow n) 9 s).a c = s.g c) ∧
    val (iter (addRow n) 9 s).a n = val s.g n := by
  have ha' : Fig n s.a := fun c hc => by rw [ha c hc]; omega
  have key : ∀ c, c < n → (iter (addRow n) 9 s).a c = s.g c := by
    intro c hc
    rw [(addRow_iter n s hg ha' hb 9 c).2.1]; simp only [hc, ↓reduceIte]; rw [ha c hc]
    have := hg c hc
    rw [Nat.min_eq_right (by omega), Nat.zero_add, Nat.mod_eq_of_lt this]
  refine ⟨fun c hc => ?_, key, val_congr key⟩
  rw [(addRow_iter n s hg ha' hb 9 c).1]; simp only [hc, ↓reduceIte]
  have := hg c hc
  omega


/-! ## Carriage (row 13, T6) -/

structure CarS where
  b : Wheel
  w : Nat → Bool
  /-- Carriages that would pass above the top cage (none, under the capacity condition). -/
  over : Nat

/-- One round of carriage: each warned cage turns the cage above it forward one tooth, a
turn from 9 to 0 setting a new warning there; the old warnings are cleared. A warning in
the top cage would carry above the axis: it is counted in `over`. (Within a round each
cage is turned only by the warning below it, so the round is given cage by cage.) -/
def carryRound (n : Nat) (s : CarS) : CarS where
  b c := if 0 < c ∧ c < n ∧ s.w (c - 1) = true then fwd (s.b c) else s.b c
  w c := decide (0 < c ∧ c < n ∧ s.w (c - 1) = true ∧ s.b c = 9)
  over := if 0 < n ∧ s.w (n - 1) = true then s.over + 1 else s.over

/-- Whether any cage below `n` has a warning. -/
def anyWarn (n : Nat) (w : Nat → Bool) : Bool := (List.range n).any w

/-- Row 13: rounds of carriage while any warning remains, at most `fuel` rounds. -/
def carriage (n : Nat) : Nat → CarS → CarS
  | 0, s => s
  | f + 1, s => if anyWarn n s.w then carriage n f (carryRound n s) else s

/-- The product with its warnings: a warning in cage `c` stands for the ten it owes. -/
def wval (n : Nat) (s : CarS) : Nat := val (fun c => s.b c + if s.w c then 10 else 0) n

theorem anyWarn_false {n : Nat} {w : Nat → Bool} (h : anyWarn n w = false) :
    ∀ c, c < n → w c = false := by
  intro c hc
  simp only [anyWarn, List.any_eq_false, List.mem_range] at h
  simpa using h c hc

theorem carryRound_fig {n : Nat} (s : CarS) (h : Fig n s.b) : Fig n (carryRound n s).b := by
  intro c hc
  simp only [carryRound]
  split
  · exact fwd_lt _
  · exact h c hc

theorem carryRound_w {n : Nat} (s : CarS) (c : Nat) (h : (carryRound n s).w c = true) :
    0 < c ∧ c < n ∧ s.w (c - 1) = true := by
  simp only [carryRound, decide_eq_true_eq] at h
  exact ⟨h.1, h.2.1, h.2.2.1⟩

/-- A round of carriage keeps the value with warnings, less what passes above the top. -/
theorem carryRound_wval {n : Nat} (s : CarS) (h : Fig n s.b) :
    wval n (carryRound n s) + (if 0 < n ∧ s.w (n - 1) = true then 10 ^ n else 0) =
      wval n s := by
  cases n with
  | zero => simp [wval, val]
  | succ m =>
    let W : Wheel := fun c => if s.w c then 1 else 0
    have e1 : wval (m + 1) (carryRound (m + 1) s) =
        val s.b (m + 1) + val (fun c => if c = 0 then 0 else W (c - 1)) (m + 1) := by
      rw [wval, ← val_add]
      apply val_congr
      intro c hc
      have := h c hc
      simp only [carryRound, W]
      by_cases h0 : c = 0
      · simp [h0]
      · by_cases hw : s.w (c - 1) = true
        · simp only [hw, h0, hc, ↓reduceIte, true_and, decide_eq_true_eq]
          have : 0 < c := by omega
          simp only [this, true_and]
          by_cases h9 : s.b c = 9 <;> simp [h9, fwd] <;> omega
        · simp [hw, h0]
    have e2 : wval (m + 1) s = val s.b (m + 1) + 10 * val W (m + 1) := by
      rw [wval, ← val_mul, ← val_add]
      apply val_congr
      intro c _
      simp only [W]
      split <;> simp
    rw [e1, e2, val_shift, val_succ' W m]
    simp only [W, Nat.add_sub_cancel]
    by_cases hw : s.w m = true <;> simp [hw, Nat.pow_succ] <;> omega

/-- The value with warnings is at least the ten owed by a warning in the top cage. -/
theorem wval_top {n : Nat} (s : CarS) (hn : 0 < n) (hw : s.w (n - 1) = true) :
    10 ^ n ≤ wval n s := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  have := top_le_val (fun c => s.b c + if s.w c then 10 else 0) m
  simp only [Nat.add_sub_cancel] at hw
  simp only [hw, ↓reduceIte] at this
  rw [wval, Nat.pow_succ]
  have : 10 ^ m * 10 ≤ (s.b m + 10) * 10 ^ m := by
    rw [Nat.mul_comm, Nat.add_mul]; omega
  omega

/-- **Carriage.** Started with warnings only below the top `fuel` cages, and with the value
with warnings below `10 ^ n` (nothing to carry above the top cage), row 13 ends with no
warning (the loop stops by itself: the bound on rounds is never reached), the figures 0–9,
the value kept, and nothing carried above the axis. -/
theorem carriage_spec (n : Nat) : ∀ (f : Nat) (s : CarS), Fig n s.b →
    (∀ c, s.w c = true → n - f ≤ c ∧ c < n) → wval n s < 10 ^ n →
    (∀ c, (carriage n f s).w c = false) ∧ Fig n (carriage n f s).b ∧
    wval n (carriage n f s) = wval n s ∧ (carriage n f s).over = s.over := by
  intro f
  induction f with
  | zero =>
    intro s hb hw _
    refine ⟨fun c => ?_, hb, rfl, rfl⟩
    cases h : s.w c
    · simpa [carriage] using h
    · have := hw c h; omega
  | succ f ih =>
    intro s hb hw hv
    simp only [carriage]
    split
    · have hnt : ¬ (0 < n ∧ s.w (n - 1) = true) := by
        intro ⟨hn, ht⟩
        have := wval_top s hn ht
        omega
      have hr := carryRound_wval s hb
      simp only [hnt, ↓reduceIte, Nat.add_zero] at hr
      have := ih (carryRound n s) (carryRound_fig s hb)
        (fun c hc => by
          have := carryRound_w s c hc
          have := hw (c - 1) this.2.2
          omega)
        (by omega)
      refine ⟨this.1, this.2.1, by rw [this.2.2.1, hr], ?_⟩
      rw [this.2.2.2]
      simp [carryRound, hnt]
    · rename_i hno
      refine ⟨fun c => ?_, hb, rfl, rfl⟩
      by_cases hc : c < n
      · exact anyWarn_false (by simpa using hno) c hc
      · cases h : s.w c
        · rfl
        · have := hw c h; omega


/-! ## An addition band: rows 1–9 and row 13 -/

/-- The addition band: give off from `g` retaining on `a` and adding to the product `b`,
nine rows, then row 13's carriage (at most `n` rounds; `carriage_spec` shows it stops by
itself). Warnings start clear. -/
def addBand (n : Nat) (g a b : Wheel) (over : Nat) : AddS × CarS :=
  let r := iter (addRow n) 9 ⟨g, a, b, fun _ => false⟩
  (r, carriage n n ⟨r.b, r.w, over⟩)

/-- **Theorem 2 (addition).** With the product's value plus the giver's below `10 ^ n`
(nothing carried above the top cage), the addition band leaves the product holding the
sum, figures 0–9, no warning and nothing carried out; the giver at zero and the retaining
wheel holding the giver's figures. -/
theorem add_band (n : Nat) (g a b : Wheel) (over : Nat) (hg : Fig n g) (ha : Zero n a)
    (hb : Fig n b) (hcap : val b n + val g n < 10 ^ n) :
    Zero n (addBand n g a b over).1.g ∧ (∀ c, c < n → (addBand n g a b over).1.a c = g c) ∧
    val (addBand n g a b over).2.b n = val b n + val g n ∧ Fig n (addBand n g a b over).2.b ∧
    (∀ c, (addBand n g a b over).2.w c = false) ∧ (addBand n g a b over).2.over = over := by
  have ha' : Fig n a := fun c hc => by rw [ha c hc]; omega
  have R := addRow_iter n ⟨g, a, b, fun _ => false⟩ hg ha' hb 9
  have T := give_off_retain n ⟨g, a, b, fun _ => false⟩ hg ha hb
  let r := iter (addRow n) 9 ⟨g, a, b, fun _ => false⟩
  have rb : ∀ c, c < n → r.b c = (b c + g c) % 10 := by
    intro c hc
    have := hg c hc
    rw [(R c).2.2.1]; simp only [hc, ↓reduceIte]; rw [Nat.min_eq_right (by omega)]
  have rw' : ∀ c, r.w c = decide (c < n ∧ 10 ≤ b c + g c) := by
    intro c
    have e := (R c).2.2.2
    by_cases hc : c < n
    · have := hg c hc
      rw [e]; simp only [hc, ↓reduceIte, Bool.false_or, true_and]
      rw [Nat.min_eq_right (by omega)]
    · rw [e]; simp [hc]
  have hfig : Fig n r.b := fun c hc => by rw [rb c hc]; exact Nat.mod_lt _ (by omega)
  have hval : wval n ⟨r.b, r.w, over⟩ = val b n + val g n := by
    rw [wval, ← val_add]
    apply val_congr
    intro c hc
    simp only [rb c hc, rw' c, hc, true_and]
    have := hg c hc; have := hb c hc
    by_cases h : 10 ≤ b c + g c <;> simp [h] <;> omega
  have C := carriage_spec n n ⟨r.b, r.w, over⟩ hfig
    (fun c h => by
      simp only [rw', decide_eq_true_eq] at h
      omega)
    (by rw [hval]; exact hcap)
  refine ⟨T.1, T.2.1, ?_, C.2.1, C.1, C.2.2.2⟩
  have hw0 := C.1
  have e : wval n (carriage n n ⟨r.b, r.w, over⟩) = val (carriage n n ⟨r.b, r.w, over⟩).b n := by
    apply val_congr; intro c _; simp [hw0 c]
  show val (carriage n n ⟨r.b, r.w, over⟩).b n = _
  rw [← e, C.2.2.1, hval]


/-! ## A step (rows 1–9, T1–T4): giver to a cage higher -/

/-- A step's wheels: the giver `g`, the receiver `r` (same axis, one cage higher), and
whatever takes the teeth of the giver's top cage, which leave the axis (`o`, turned by
`out` once for each tooth: the counter K for the multiplier, a count of overflows for
the product). -/
structure StepS (σ : Type) where
  g : Wheel
  r : Wheel
  o : σ

/-- One row of a step: every cage of the giver not at 0 turns back one tooth; for that
tooth the receiver's cage one higher turns forward one tooth, or, from the top cage, the
tooth leaves the axis. -/
def stepRow {σ : Type} (n : Nat) (out : σ → σ) (s : StepS σ) : StepS σ where
  g c := if c < n ∧ s.g c ≠ 0 then bwd (s.g c) else s.g c
  r c := if 0 < c ∧ c < n ∧ s.g (c - 1) ≠ 0 then fwd (s.r c) else s.r c
  o := if 0 < n ∧ s.g (n - 1) ≠ 0 then out s.o else s.o

theorem stepRow_iter {σ : Type} (n : Nat) (out : σ → σ) (s : StepS σ) (hg : Fig n s.g)
    (hr : Fig n s.r) (k : Nat) :
    (∀ c, (iter (stepRow n out) k s).g c = (if c < n then s.g c - k else s.g c)) ∧
    (∀ c, (iter (stepRow n out) k s).r c =
      (if 0 < c ∧ c < n then (s.r c + min k (s.g (c - 1))) % 10 else s.r c)) ∧
    (iter (stepRow n out) k s).o = (if 0 < n then iter out (min k (s.g (n - 1))) s.o else s.o) := by
  induction k with
  | zero =>
    refine ⟨fun c => by split <;> simp [iter], fun c => ?_, by split <;> simp [iter]⟩
    by_cases hc : 0 < c ∧ c < n
    · have := hr c hc.2
      simp only [iter, hc, and_self, ↓reduceIte]
      exact (Nat.mod_eq_of_lt this).symm
    · simp [iter, hc]
  | succ k ih =>
    obtain ⟨h1, h2, h3⟩ := ih
    simp only [iter] at *
    refine ⟨fun c => ?_, fun c => ?_, ?_⟩
    · simp only [stepRow]; rw [h1 c]
      by_cases hc : c < n
      · have := hg c hc
        simp only [hc, ↓reduceIte, true_and]; grind [bwd]
      · simp [hc]
    · simp only [stepRow]; rw [h1 (c - 1), h2 c]
      by_cases hc : 0 < c ∧ c < n
      · have := hg (c - 1) (by omega)
        have hc' : c - 1 < n := by omega
        simp only [hc, hc', and_self, ↓reduceIte, true_and]
        grind [fwd]
      · grind
    · simp only [stepRow]; rw [h1 (n - 1), h3]
      by_cases hn : 0 < n
      · have := hg (n - 1) (by omega)
        have hn' : n - 1 < n := by omega
        simp only [hn, hn', ↓reduceIte, true_and]
        by_cases hk : s.g (n - 1) - k ≠ 0
        · have e : min (k + 1) (s.g (n - 1)) = min k (s.g (n - 1)) + 1 := by omega
          rw [e]; exact (ite_eq_left_of_eq_true _ _ (eq_true hk)).trans rfl
        · have e : min (k + 1) (s.g (n - 1)) = min k (s.g (n - 1)) := by omega
          simp only [hk, ↓reduceIte, e]
      · simp [hn]

/-- **Theorem 3 (a step multiplies by ten).** A step from `g` to an empty receiver, one cage
higher: after the nine rows the giver stands at zero, the receiver holds the figures one
cage up, its value and the top figure (which left the axis) together are ten times the
giver's, and what took the teeth from the top was turned exactly the top figure's
number of times. -/
theorem step_band {σ : Type} (n : Nat) (out : σ → σ) (g r : Wheel) (o : σ) (hn : 0 < n)
    (hg : Fig n g) (hr : Zero n r) :
    let t := iter (stepRow n out) 9 ⟨g, r, o⟩
    Zero n t.g ∧ (∀ c, c < n → t.r c = if c = 0 then 0 else g (c - 1)) ∧ Fig n t.r ∧
    val t.r n + g (n - 1) * 10 ^ n = 10 * val g n ∧ t.o = iter out (g (n - 1)) o := by
  intro t
  have hr' : Fig n r := fun c hc => by rw [hr c hc]; omega
  have R := stepRow_iter n out ⟨g, r, o⟩ hg hr' 9
  have tr : ∀ c, c < n → t.r c = if c = 0 then 0 else g (c - 1) := by
    intro c hc
    rw [R.2.1 c]
    by_cases h0 : c = 0
    · subst h0; simp [hr 0 hc]
    · have := hg (c - 1) (by omega)
      simp only [show 0 < c by omega, hc, and_self, ↓reduceIte, h0, hr c hc, Nat.zero_add]
      rw [Nat.min_eq_right (by omega), Nat.mod_eq_of_lt this]
  refine ⟨fun c hc => ?_, tr, fun c hc => ?_, ?_, ?_⟩
  · rw [R.1 c]; have := hg c hc; simp only [hc, ↓reduceIte]; omega
  · rw [tr c hc]; split
    · omega
    · exact hg _ (by omega)
  · obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
    rw [val_congr tr, val_shift, val_succ' g m, Nat.add_sub_cancel, Nat.pow_succ]
    simp only [Nat.mul_add]
    rw [Nat.mul_comm 10 (g m * 10 ^ m), Nat.mul_assoc]
  · rw [R.2.2]; have := hg (n - 1) (by omega)
    simp only [hn, ↓reduceIte]; rw [Nat.min_eq_right (by omega)]

/-- K: one tooth forward in its (single) cage. -/
def turnK (K : Wheel) : Wheel := fun c => if c = 0 then fwd (K 0) else K c

theorem iter_turnK (K : Wheel) (d : Nat) (h : K 0 + d < 10) : iter turnK d K 0 = K 0 + d := by
  induction d with
  | zero => rfl
  | succ d ih =>
    simp only [iter, turnK, ↓reduceIte, fwd]
    rw [ih (by omega)]; omega

/-- **Theorem 3, for the multiplier.** Stepped onto its other wheel with K at zero, the
multiplier's top figure leaves the axis onto K: K then stands at that figure. -/
theorem step_multiplier (p : Nat) (g r K : Wheel) (hp : 0 < p) (hg : Fig p g) (hr : Zero p r)
    (hK : K 0 = 0) :
    (iter (stepRow p turnK) 9 ⟨g, r, K⟩).o 0 = g (p - 1) := by
  rw [(step_band p turnK g r K hp hg hr).2.2.2.2, iter_turnK K _ (by have := hg (p - 1) (by omega); omega), hK,
    Nat.zero_add]


/-! ## Counters (P and K) -/

/-- The wheel with figure `x` in cage 0 and `f`'s figures one cage up. -/
def cons (x : Nat) (f : Wheel) : Wheel := fun c => if c = 0 then x else f (c - 1)
/-- The cages above cage 0. -/
def shift (f : Wheel) : Wheel := fun c => f (c + 1)

/-- Turn a counter of `m` cages back by unity: cage 0 back one tooth, and while a cage
passes from 0 to 9, the next cage back one tooth. `true` is a running up: the top cage
passed from 0 to 9 (or the counter has no cages), so the count was exhausted. -/
def countDown (f : Wheel) : Nat → Wheel × Bool
  | 0 => (f, true)
  | m + 1 =>
    if f 0 = 0 then
      let r := countDown (shift f) m
      (cons (bwd (f 0)) r.1, r.2)
    else (cons (bwd (f 0)) (shift f), false)

/-- After a running up: cage 0 forward one tooth, and while a cage passes from 9 to 0,
the next forward one tooth (`restore` in `scripts/f_control.py`; assumed there). -/
def restore (f : Wheel) : Nat → Wheel
  | 0 => f
  | m + 1 => if f 0 = 9 then cons (fwd (f 0)) (restore (shift f) m) else cons (fwd (f 0)) (shift f)

theorem val_cons (x : Nat) (f : Wheel) (m : Nat) : val (cons x f) (m + 1) = x + 10 * val f m := by
  simp [val, cons]

theorem val_eq_shift (f : Wheel) (m : Nat) : val f (m + 1) = f 0 + 10 * val (shift f) m := rfl

theorem fig_cons {x : Nat} {f : Wheel} {m : Nat} (hx : x < 10) (hf : Fig m f) :
    Fig (m + 1) (cons x f) := by
  intro c hc; simp only [cons]; split
  · exact hx
  · exact hf _ (by omega)

theorem fig_shift {f : Wheel} {m : Nat} (hf : Fig (m + 1) f) : Fig m (shift f) :=
  fun c hc => hf (c + 1) (by omega)

/-- The counter counts down: from a value `v + 1` it goes to `v` without a running up;
from 0 it runs up. -/
theorem countDown_spec (m : Nat) : ∀ f : Wheel, Fig m f →
    ((countDown f m).2 = true ↔ val f m = 0) ∧ Fig m (countDown f m).1 ∧
    ((countDown f m).2 = false → val (countDown f m).1 m = val f m - 1) ∧
    ((countDown f m).2 = true → ∀ c, c < m → (countDown f m).1 c = 9) := by
  induction m with
  | zero => intro f _; simp [countDown, val, Fig]
  | succ m ih =>
    intro f hf
    have h0 := hf 0 (by omega)
    obtain ⟨i1, i2, i3, i4⟩ := ih (shift f) (fig_shift hf)
    by_cases hz : f 0 = 0
    · simp only [countDown, hz, ↓reduceIte]
      refine ⟨?_, fig_cons (by simp [bwd]) i2, fun h => ?_, fun h c hc => ?_⟩
      · rw [i1, val_eq_shift, hz]; omega
      · rw [val_cons, i3 h, val_eq_shift, hz]
        have : val (shift f) m ≠ 0 := fun e => by rw [← i1] at e; simp [e] at h
        simp only [bwd]; omega
      · simp only [cons]; split
        · simp [bwd]
        · exact i4 h _ (by omega)
    · simp only [countDown, hz, ↓reduceIte]
      refine ⟨?_, fig_cons (by simp only [bwd]; omega) (fig_shift hf), fun _ => ?_, fun h => ?_⟩
      · simp only [Bool.false_eq_true, false_iff]; rw [val_eq_shift]; omega
      · rw [val_cons, val_eq_shift]; simp only [bwd]; omega
      · simp at h

theorem restore_spec (m : Nat) : ∀ f : Wheel, (∀ c, c < m → f c = 9) → Zero m (restore f m) := by
  induction m with
  | zero => intro f _ c hc; omega
  | succ m ih =>
    intro f hf c hc
    simp only [restore, hf 0 (by omega), ↓reduceIte, cons]
    split
    · simp [fwd]
    · exact ih (shift f) (fun c hc => hf (c + 1) (by omega)) _ (by omega)

/-- K, one cage: turned back from `d + 1` it stands at `d`, no running up. -/
theorem countDown_K_succ (K : Wheel) (d : Nat) (h : K 0 = d + 1) (hd : d < 9) :
    (countDown K 1).2 = false ∧ (countDown K 1).1 0 = d := by
  simp [countDown, h, cons, bwd]; omega

/-- K, one cage: turned back from 0 it runs up, and `restore` brings it to 0 again. -/
theorem countDown_K_zero (K : Wheel) (h : K 0 = 0) :
    (countDown K 1).2 = true ∧ restore (countDown K 1).1 1 0 = 0 := by
  refine ⟨by simp [countDown, h], ?_⟩
  have := (countDown_spec 1 K (fun c hc => by rw [show c = 0 by omega, h]; omega)).2.2.2
    (by simp [countDown, h])
  exact restore_spec 1 _ this 0 (by omega)


/-! ## The controller -/

/-- An axis's two figure wheels, N.o 1 and N.o 2, and which of them holds the axis's
number (the controller's own state, `on` in `scripts/f_control.py`). -/
structure Axis where
  one : Wheel
  two : Wheel
  /-- `true` when N.o 1 holds the number. -/
  on : Bool

namespace Axis
def held (x : Axis) : Wheel := if x.on then x.one else x.two
def spare (x : Axis) : Wheel := if x.on then x.two else x.one
/-- The axis with N.o 1 holding when `on`, given the holding and the other wheel. -/
def of (on : Bool) (h s : Wheel) : Axis := if on then ⟨h, s, true⟩ else ⟨s, h, false⟩
@[simp] theorem held_of (on : Bool) (h s : Wheel) : (of on h s).held = h := by cases on <;> rfl
@[simp] theorem spare_of (on : Bool) (h s : Wheel) : (of on h s).spare = s := by cases on <;> rfl
@[simp] theorem on_of (on : Bool) (h s : Wheel) : (of on h s).on = on := by cases on <;> rfl
end Axis

inductive Phase
  /-- before a step: count down the places -/
  | places
  /-- before an addition: count down the additions -/
  | adds
  /-- P has run up -/
  | done
  deriving DecidableEq

/-- The engine's state: axes A (multiplicand), B (product), C (multiplier), the counters
K (one cage) and P, whether the next step is the first, the phase of the control, and,
as records, the bands executed and the figures carried above a top cage. -/
structure Mach where
  A : Axis
  B : Axis
  C : Axis
  K : Wheel
  P : Wheel
  first : Bool
  phase : Phase
  bands : Nat
  over : Nat

/-- A step of the product and the multiplier together: in each of the nine rows, both axes
turn (they share no wheel). -/
def stepRow2 (n p : Nat) (x : StepS Nat × StepS Wheel) : StepS Nat × StepS Wheel :=
  (stepRow n Nat.succ x.1, stepRow p turnK x.2)

theorem iter_stepRow2 (n p k : Nat) (x : StepS Nat) (y : StepS Wheel) :
    iter (stepRow2 n p) k (x, y) = (iter (stepRow n Nat.succ) k x, iter (stepRow p turnK) k y) := by
  induction k with
  | zero => rfl
  | succ k ih => simp [iter, ih, stepRow2]

/-- One decision of the controller, with the band it sets going (`multiply` in
`scripts/f_control.py`). `n`: cages of A and B; `p`: cages of C; `q`: cages of P.

* places: P turned back by unity; a running up ends the multiplication. Otherwise a step:
  the first moves the multiplier alone, later ones the product and the multiplier
  together, each onto its other wheel.
* adds: K turned back by unity; a running up (K restored to 0) gives notice of stepping
  up. Otherwise an addition band: A gives off from the wheel that holds it, retaining on
  its other wheel, adding into the wheel of B that holds the product; then carriage. -/
def ctl (n p q : Nat) (s : Mach) : Mach :=
  match s.phase with
  | .done => s
  | .places =>
    if (countDown s.P q).2 then { s with P := (countDown s.P q).1, phase := .done }
    else if s.first then
      let c := iter (stepRow p turnK) 9 ⟨s.C.held, s.C.spare, s.K⟩
      { s with P := (countDown s.P q).1, C := Axis.of (!s.C.on) c.r c.g, K := c.o,
               first := false, phase := .adds, bands := s.bands + 1 }
    else
      let bc := iter (stepRow2 n p) 9 (⟨s.B.held, s.B.spare, s.over⟩, ⟨s.C.held, s.C.spare, s.K⟩)
      { s with P := (countDown s.P q).1, B := Axis.of (!s.B.on) bc.1.r bc.1.g, over := bc.1.o,
               C := Axis.of (!s.C.on) bc.2.r bc.2.g, K := bc.2.o,
               first := false, phase := .adds, bands := s.bands + 1 }
  | .adds =>
    if (countDown s.K 1).2 then { s with K := restore (countDown s.K 1).1 1, phase := .places }
    else
      let r := addBand n s.A.held s.A.spare s.B.held s.over
      { s with K := (countDown s.K 1).1, A := Axis.of (!s.A.on) r.1.a r.1.g,
               B := Axis.of s.B.on r.2.b s.B.spare, over := r.2.over, bands := s.bands + 1 }

theorem ctl_done (n p q : Nat) (s : Mach) (h : s.phase = .done) : ctl n p q s = s := by
  simp [ctl, h]

theorem iter_ctl_done (n p q k : Nat) (s : Mach) (h : s.phase = .done) :
    iter (ctl n p q) k s = s := by
  induction k with
  | zero => rfl
  | succ k ih => simp only [iter, ih, ctl_done n p q s h]

/-- **Theorem 4 (the counter of additions).** In the adds phase with K at `j` (0–9), the
next `j + 1` decisions are `j` additions of the multiplicand into the product and then
K's running up: the control returns to the places phase with K at zero. The multiplicand
is kept (on one wheel or the other), C, P and the record of overflows are untouched. -/
theorem add_loop (n p q a : Nat) : ∀ (j : Nat) (s : Mach), s.phase = .adds → s.K 0 = j →
    j ≤ 9 → Fig n s.A.held → val s.A.held n = a → Zero n s.A.spare →
    Fig n s.B.held → Zero n s.B.spare → val s.B.held n + j * a < 10 ^ n →
    let t := iter (ctl n p q) (j + 1) s
    t.phase = .places ∧ t.K 0 = 0 ∧ t.bands = s.bands + j ∧
    val t.B.held n = val s.B.held n + j * a ∧
    Fig n t.A.held ∧ val t.A.held n = a ∧ Zero n t.A.spare ∧ Fig n t.B.held ∧
    Zero n t.B.spare ∧ t.C = s.C ∧ t.P = s.P ∧ t.first = s.first ∧ t.over = s.over := by
  intro j
  induction j with
  | zero =>
    intro s hph hK _ hA hAv hA2 hB hB2 _
    have := countDown_K_zero s.K hK
    simp only [iter, ctl, hph, this.1, ↓reduceIte]
    refine ⟨?_, this.2, ?_, ?_, hA, hAv, hA2, hB, hB2, ?_, ?_, ?_, ?_⟩ <;> simp
  | succ j ih =>
    intro s hph hK hj hA hAv hA2 hB hB2 hcap
    have hk := countDown_K_succ s.K j hK (by omega)
    have hcap' : val s.B.held n + val s.A.held n < 10 ^ n := by
      rw [hAv]; rw [Nat.succ_mul] at hcap; omega
    have AB := add_band n s.A.held s.A.spare s.B.held s.over hA hA2 hB hcap'
    intro t
    have e : t = iter (ctl n p q) (j + 1) (ctl n p q s) := iter_succ' _ _ _
    obtain ⟨r, hr⟩ : ∃ r, r = addBand n s.A.held s.A.spare s.B.held s.over := ⟨_, rfl⟩
    rw [← hr] at AB
    let u := ctl n p q s
    have hu : u = { s with K := (countDown s.K 1).1, A := Axis.of (!s.A.on) r.1.a r.1.g, B := Axis.of s.B.on r.2.b s.B.spare, over := r.2.over, bands := s.bands + 1 } := by
      simp only [u, ctl, hph, hk.1, hr]; rfl
    have huA : Fig n u.A.held := by
      rw [hu]; intro c hc; simp only [Axis.held_of]; rw [AB.2.1 c hc]; exact hA c hc
    have huAv : val u.A.held n = a := by
      rw [hu]; simp only [Axis.held_of]; rw [val_congr AB.2.1, hAv]
    have I := ih u (by rw [hu]; exact hph) (by rw [hu]; exact hk.2) (by omega) huA huAv
      (by rw [hu]; simpa using AB.1) (by rw [hu]; simpa using AB.2.2.2.1) (by rw [hu]; simpa using hB2)
      (by rw [hu]; simp only [Axis.held_of]; rw [AB.2.2.1, hAv]; rw [Nat.succ_mul] at hcap; omega)
    rw [e]
    obtain ⟨i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13⟩ := I
    refine ⟨i1, i2, ?_, ?_, i5, i6, i7, i8, i9, ?_, ?_, ?_, ?_⟩
    · rw [i3, hu]; dsimp only; omega
    · rw [i4, hu]; simp only [Axis.held_of]; rw [AB.2.2.1, hAv, Nat.succ_mul]; omega
    · rw [i10, hu]
    · rw [i11, hu]
    · rw [i12, hu]
    · rw [i13, hu]; exact AB.2.2.2.2.2


/-! ## The multiplier as written, and the whole multiplication -/

/-- The value of figures as written, first figure the highest. -/
def valW (M : List Nat) : Nat := M.foldl (fun acc d => 10 * acc + d) 0

theorem valW_nil : valW [] = 0 := rfl

theorem valW_snoc (D : List Nat) (d : Nat) : valW (D ++ [d]) = 10 * valW D + d := by
  simp [valW, List.foldl_append]

theorem foldl_ge (E : List Nat) : ∀ acc, acc ≤ E.foldl (fun acc d => 10 * acc + d) acc := by
  induction E with
  | nil => intro acc; simp
  | cons e E ih => intro acc; simp only [List.foldl_cons]; exact Nat.le_trans (by omega) (ih _)

theorem valW_le_append (D E : List Nat) : valW D ≤ valW (D ++ E) := by
  simp only [valW, List.foldl_append]; exact foldl_ge _ _

theorem getD_lt {L : List Nat} (h : ∀ x ∈ L, x < 10) (i : Nat) : L.getD i 0 < 10 := by
  rw [List.getD_eq_getElem?_getD]
  cases hi : L[i]? with
  | none => simp
  | some x => simpa using h x (List.mem_of_getElem? hi)

/-- After a step, the multiplier's figures stand a cage higher, a 0 entering cage 0. -/
theorem getD_step (d : Nat) (L : List Nat) (p c : Nat) (hp : L.length + 1 = p) (hc : c < p) :
    (if c = 0 then 0 else (d :: L).getD (p - 1 - (c - 1)) 0) = (L ++ [0]).getD (p - 1 - c) 0 := by
  by_cases h0 : c = 0
  · subst h0
    simp only [↓reduceIte, Nat.sub_zero]
    rw [List.getD_eq_getElem?_getD, List.getElem?_append_right (by omega)]
    simp [show p - 1 - L.length = 0 by omega]
  · simp only [h0, ↓reduceIte]
    rw [show p - 1 - (c - 1) = (p - 1 - c) + 1 by omega, List.getD_cons_succ,
      List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
      List.getElem?_append_left (by omega)]

/-- A wheel whose value, times ten, still fits has 0 in its top cage. -/
theorem top_zero {n : Nat} {f : Wheel} (hn : 0 < n) (h : 10 * val f n < 10 ^ n) : f (n - 1) = 0 := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  have := top_le_val f m
  simp only [Nat.add_sub_cancel]
  rw [Nat.pow_succ] at h
  by_cases hz : f m = 0
  · exact hz
  · have : 10 ^ m ≤ f m * 10 ^ m := Nat.le_mul_of_pos_left _ (by omega)
    omega

/-- The state before a step, with `D` the multiplier's figures already used, `R` those still
on its axis (`R` in the top cages, then `Z`, the figures stepped in below them), and `a`
the multiplicand's value. -/
structure Inv (n p q a : Nat) (s : Mach) (D R Z : List Nat) : Prop where
  phase : s.phase = .places
  first : s.first = true ↔ D = []
  A : Fig n s.A.held
  Av : val s.A.held n = a
  A2 : Zero n s.A.spare
  B : Fig n s.B.held
  Bv : val s.B.held n = a * valW D
  B2 : Zero n s.B.spare
  len : R.length + Z.length = p
  dig : ∀ x ∈ R ++ Z, x < 10
  C : ∀ c, c < p → s.C.held c = (R ++ Z).getD (p - 1 - c) 0
  C2 : Zero p s.C.spare
  K : s.K 0 = 0
  P : Fig q s.P
  Pv : val s.P q = R.length

/-- One place of the multiplier: P turned back by unity, a step (the multiplier's top
figure `d` onto K; the product, but not at the first step, times ten), `d` additions and
K's running up: `d + 2` decisions. -/
theorem place (n p q a : Nat) (hn : 0 < n) (s : Mach) (D R Z : List Nat) (d : Nat)
    (I : Inv n p q a s D (d :: R) Z) (hcap : a * valW (D ++ [d]) < 10 ^ n) :
    let t := iter (ctl n p q) (d + 2) s
    Inv n p q a t (D ++ [d]) R (Z ++ [0]) ∧ t.bands = s.bands + 1 + d ∧ t.over = s.over := by
  intro t
  have hlen := I.len
  simp only [List.length_cons] at hlen
  have hp : 0 < p := by omega
  have hd : d < 10 := I.dig d (by simp)
  have Pc := countDown_spec q s.P I.P
  have hP2 : (countDown s.P q).2 = false := by
    cases h : (countDown s.P q).2
    · rfl
    · have := Pc.1.1 h; rw [I.Pv] at this; simp at this
  have hPv : val (countDown s.P q).1 q = R.length := by rw [Pc.2.2.1 hP2, I.Pv]; simp
  have hCf : Fig p s.C.held := fun c hc => by rw [I.C c hc]; exact getD_lt I.dig _
  have SC := step_band p turnK s.C.held s.C.spare s.K hp hCf I.C2
  have hKd := step_multiplier p s.C.held s.C.spare s.K hp hCf I.C2 I.K
  have hC0 : s.C.held (p - 1) = d := by rw [I.C _ (by omega)]; simp
  rw [hC0] at hKd
  have Cnew : ∀ c, c < p → (if c = 0 then 0 else s.C.held (c - 1)) =
      (R ++ (Z ++ [0])).getD (p - 1 - c) 0 := by
    intro c hc
    rw [← List.append_assoc, ← getD_step d (R ++ Z) p c (by simp; omega) hc]
    by_cases h0 : c = 0
    · simp [h0]
    · simp only [h0, ↓reduceIte]; rw [I.C (c - 1) (by omega)]; rfl
  have hsnoc := valW_snoc D d
  have hten : 10 * (a * valW D) + d * a = a * valW (D ++ [d]) := by
    rw [hsnoc, Nat.mul_add, Nat.mul_comm d a, Nat.mul_left_comm]
  have hBten : 10 * val s.B.held n < 10 ^ n := by rw [I.Bv]; omega
  have U : (ctl n p q s).phase = .adds ∧ (ctl n p q s).K 0 = d ∧ (ctl n p q s).A = s.A ∧
      Fig n (ctl n p q s).B.held ∧ val (ctl n p q s).B.held n = 10 * (a * valW D) ∧
      Zero n (ctl n p q s).B.spare ∧
      (∀ c, c < p → (ctl n p q s).C.held c = (R ++ (Z ++ [0])).getD (p - 1 - c) 0) ∧
      Zero p (ctl n p q s).C.spare ∧ (ctl n p q s).P = (countDown s.P q).1 ∧
      (ctl n p q s).first = false ∧ (ctl n p q s).bands = s.bands + 1 ∧
      (ctl n p q s).over = s.over := by
    by_cases hf : s.first = true
    · have hD : D = [] := I.first.1 hf
      simp only [ctl, I.phase, hP2, hf, ↓reduceIte, Bool.false_eq_true]
      refine ⟨by trivial, hKd, by trivial, I.B, by rw [I.Bv, hD, valW_nil]; simp, I.B2,
        fun c hc => ?_, ?_, by trivial, by trivial, by trivial, by trivial⟩
      · simp only [Axis.held_of]; rw [SC.2.1 c hc]; exact Cnew c hc
      · simp only [Axis.spare_of]; exact SC.1
    · have SB := step_band n Nat.succ s.B.held s.B.spare s.over hn I.B I.B2
      have hB0 : s.B.held (n - 1) = 0 := top_zero hn hBten
      rw [hB0] at SB
      simp only [ctl, I.phase, hP2, hf, ↓reduceIte, Bool.false_eq_true, iter_stepRow2]
      refine ⟨by trivial, hKd, by trivial, ?_, ?_, ?_, fun c hc => ?_, ?_, by trivial, by trivial,
        by trivial, ?_⟩
      · simp only [Axis.held_of]; exact SB.2.2.1
      · simp only [Axis.held_of]; rw [← I.Bv]; have := SB.2.2.2.1; simp at this; omega
      · simp only [Axis.spare_of]; exact SB.1
      · simp only [Axis.held_of]; rw [SC.2.1 c hc]; exact Cnew c hc
      · simp only [Axis.spare_of]; exact SC.1
      · rw [SB.2.2.2.2]; rfl
  obtain ⟨u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, u11, u12⟩ := U
  have L := add_loop n p q a d (ctl n p q s) u1 u2 (by omega) (by rw [u3]; exact I.A)
    (by rw [u3]; exact I.Av) (by rw [u3]; exact I.A2) u4 u6 (by rw [u5, hten]; exact hcap)
  have e : t = iter (ctl n p q) (d + 1) (ctl n p q s) := iter_succ' _ _ _
  rw [← e] at L
  obtain ⟨l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13⟩ := L
  refine ⟨⟨l1, ?_, l5, l6, l7, l8, ?_, l9, ?_, ?_, ?_, ?_, l2, ?_, ?_⟩, ?_, ?_⟩
  · rw [l12, u10]; simp
  · rw [l4, u5, hten]
  · simp; omega
  · intro x hx
    simp only [List.mem_append, List.mem_singleton] at hx
    rcases hx with hx | hx | hx
    · exact I.dig x (by simp [hx])
    · exact I.dig x (by simp [hx])
    · omega
  · rw [l10]; exact u7
  · rw [l10]; exact u8
  · rw [l11, u9]; exact Pc.2.1
  · rw [l11, u9]; exact hPv
  · rw [l3, u11]
  · rw [l13, u12]

/-- When P has been counted down to zero, the next decision is its running up: the end. -/
theorem finish (n p q a : Nat) (s : Mach) (D Z : List Nat) (I : Inv n p q a s D [] Z) :
    ctl n p q s = { s with P := (countDown s.P q).1, phase := .done } := by
  have := (countDown_spec q s.P I.P).1.2 (by rw [I.Pv]; rfl)
  simp [ctl, I.phase, this]

/-- The places one after another: after the figures `E` of the multiplier, in
`2 · |E| + ΣE` decisions, the invariant holds with `E` added to the figures used. -/
theorem places_spec (n p q a : Nat) (hn : 0 < n) : ∀ (E R D Z : List Nat) (s : Mach),
    Inv n p q a s D (E ++ R) Z → a * valW (D ++ E) < 10 ^ n →
    let t := iter (ctl n p q) (2 * E.length + E.sum) s
    Inv n p q a t (D ++ E) R (Z ++ List.replicate E.length 0) ∧
      t.bands = s.bands + E.length + E.sum ∧ t.over = s.over := by
  intro E
  induction E with
  | nil => intro R D Z s I _; simpa [iter] using I
  | cons d E ih =>
    intro R D Z s I hcap
    have hc1 : a * valW (D ++ [d]) < 10 ^ n :=
      Nat.lt_of_le_of_lt (Nat.mul_le_mul_left _ (by
        rw [show D ++ d :: E = (D ++ [d]) ++ E by simp]; exact valW_le_append _ _)) hcap
    have P1 := place n p q a hn s D (E ++ R) Z d I hc1
    have P2 := ih R (D ++ [d]) (Z ++ [0]) _ P1.1 (by simpa using hcap)
    have e : 2 * (d :: E).length + (d :: E).sum = (2 * E.length + E.sum) + (d + 2) := by
      simp; omega
    intro t
    have ht : t = iter (ctl n p q) (2 * E.length + E.sum) (iter (ctl n p q) (d + 2) s) := by
      show iter (ctl n p q) (2 * (d :: E).length + (d :: E).sum) s = _
      rw [e, iter_add]
    rw [ht]
    obtain ⟨Q1, Q2, Q3⟩ := P2
    refine ⟨by simpa [List.replicate_succ] using Q1, ?_, ?_⟩
    · rw [Q2, P1.2.1]; simp; omega
    · rw [Q3, P1.2.2]

/-- **Theorem 5 (multiplication).** Started as `scripts/f_control.py` starts it — the
multiplicand (value `a`) on A's N.o 1, the product wheels and A's N.o 2 at zero, the
multiplier's figures `M` (as written, `p` of them) on C's N.o 1 with its first figure in
the top cage, K at zero, P holding `p`, the first step to come — and with the product
fitting on the `n` cages (`a · value M < 10 ^ n`), the controller ends after exactly
`2p + ΣM + 1` decisions, with the product wheel holding `a · value M`, the other product
wheel at zero, the multiplicand retained, `p + ΣM` bands executed and nothing carried
above a top cage. -/
theorem multiply_correct (n p q : Nat) (M : List Nat) (s : Mach) (hn : 0 < n)
    (hM : M.length = p) (hdig : ∀ x ∈ M, x < 10)
    (hA : Fig n s.A.held) (hA2 : Zero n s.A.spare) (hB : Zero n s.B.held) (hB2 : Zero n s.B.spare)
    (hC : ∀ c, c < p → s.C.held c = M.getD (p - 1 - c) 0) (hC2 : Zero p s.C.spare)
    (hK : s.K 0 = 0) (hP : Fig q s.P) (hPv : val s.P q = p)
    (hfirst : s.first = true) (hph : s.phase = .places)
    (hcap : val s.A.held n * valW M < 10 ^ n) :
    let t := iter (ctl n p q) (2 * p + M.sum + 1) s
    t.phase = .done ∧ val t.B.held n = val s.A.held n * valW M ∧ Fig n t.B.held ∧
      Zero n t.B.spare ∧ val t.A.held n = val s.A.held n ∧ Zero n t.A.spare ∧
      t.bands = s.bands + p + M.sum ∧ t.over = s.over := by
  intro t
  have I : Inv n p q (val s.A.held n) s [] (M ++ []) [] :=
    { phase := hph, first := by simp [hfirst], A := hA, Av := rfl, A2 := hA2,
      B := fun c hc => by rw [hB c hc]; omega, Bv := by rw [val_zero hB]; simp [valW_nil],
      B2 := hB2, len := by simp [hM], dig := by simpa using hdig,
      C := by simpa using hC, C2 := hC2, K := hK, P := hP, Pv := by simp [hM, hPv] }
  have S := places_spec n p q (val s.A.held n) hn M [] [] [] s I (by simpa using hcap)
  simp only [List.nil_append, hM] at S
  obtain ⟨I', h2, h3⟩ := S
  have F := finish n p q _ _ M _ I'
  have e : t = ctl n p q (iter (ctl n p q) (2 * p + M.sum) s) := rfl
  rw [e, F]
  exact ⟨rfl, I'.Bv, I'.B, I'.B2, I'.Av, I'.A2, h2, h3⟩

/-- Terminates: once the controller has ended, further decisions change nothing. -/
theorem multiply_stays (n p q : Nat) (s : Mach) (N k : Nat)
    (h : (iter (ctl n p q) N s).phase = .done) (hk : N ≤ k) :
    iter (ctl n p q) k s = iter (ctl n p q) N s := by
  obtain ⟨j, rfl⟩ : ∃ j, k = j + N := ⟨k - N, by omega⟩
  rw [iter_add, iter_ctl_done n p q j _ h]

/-- **The invariant.** After the first `i` figures of the multiplier (`2i + Σ` of them
decisions from the start) the control is before a step and the product wheel holds
`a · value (first i figures)`. -/
theorem multiply_invariant (n p q : Nat) (M : List Nat) (s : Mach) (hn : 0 < n)
    (hM : M.length = p) (hdig : ∀ x ∈ M, x < 10)
    (hA : Fig n s.A.held) (hA2 : Zero n s.A.spare) (hB : Zero n s.B.held) (hB2 : Zero n s.B.spare)
    (hC : ∀ c, c < p → s.C.held c = M.getD (p - 1 - c) 0) (hC2 : Zero p s.C.spare)
    (hK : s.K 0 = 0) (hP : Fig q s.P) (hPv : val s.P q = p)
    (hfirst : s.first = true) (hph : s.phase = .places)
    (hcap : val s.A.held n * valW M < 10 ^ n) (i : Nat) (hi : i ≤ p) :
    let t := iter (ctl n p q) (2 * i + (M.take i).sum) s
    t.phase = .places ∧ val t.B.held n = val s.A.held n * valW (M.take i) ∧
      t.bands = s.bands + i + (M.take i).sum := by
  intro t
  have I : Inv n p q (val s.A.held n) s [] (M.take i ++ M.drop i) [] :=
    { phase := hph, first := by simp [hfirst], A := hA, Av := rfl, A2 := hA2,
      B := fun c hc => by rw [hB c hc]; omega, Bv := by rw [val_zero hB]; simp [valW_nil],
      B2 := hB2, len := by simp [hM], dig := by simpa using hdig,
      C := by simpa using hC, C2 := hC2, K := hK, P := hP, Pv := by simp [hM, hPv] }
  have hcap' : val s.A.held n * valW ([] ++ M.take i) < 10 ^ n := by
    refine Nat.lt_of_le_of_lt (Nat.mul_le_mul_left _ ?_) hcap
    have := valW_le_append (M.take i) (M.drop i)
    simpa using this
  have S := places_spec n p q (val s.A.held n) hn (M.take i) (M.drop i) [] [] s I hcap'
  have hl : (M.take i).length = i := by simp; omega
  simp only [List.nil_append, hl] at S
  exact ⟨S.1.phase, S.1.Bv, S.2.1⟩

/-! ## The operands as written, set on the wheels as `scripts/f_control.py` sets them -/

/-- Figures as written set on a wheel figure by figure, the last in cage 0 (so the first
in cage `L.length - 1`); higher cages at 0. -/
def setW (L : List Nat) : Wheel := fun c => if c < L.length then L.getD (L.length - 1 - c) 0 else 0

theorem setW_snoc (L : List Nat) (x : Nat) (c : Nat) : setW (L ++ [x]) c = cons x (setW L) c := by
  simp only [setW, cons, List.length_append, List.length_singleton]
  by_cases h0 : c = 0
  · subst h0
    simp only [Nat.zero_lt_succ, ↓reduceIte, Nat.sub_zero, Nat.add_sub_cancel]
    rw [List.getD_eq_getElem?_getD, List.getElem?_append_right (by omega)]
    simp
  · simp only [h0, ↓reduceIte]
    by_cases hc : c < L.length + 1
    · simp only [hc, show c - 1 < L.length by omega, ↓reduceIte]
      rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD,
        List.getElem?_append_left (by omega)]
      congr 2; omega
    · simp only [hc, show ¬ (c - 1 < L.length) by omega, ↓reduceIte]

theorem setW_fig {L : List Nat} (h : ∀ x ∈ L, x < 10) (n : Nat) : Fig n (setW L) := by
  intro c _; simp only [setW]; split
  · exact getD_lt h _
  · omega

theorem val_setW_rev : ∀ (R : List Nat) (n : Nat), R.length ≤ n →
    val (setW R.reverse) n = valW R.reverse := by
  intro R
  induction R with
  | nil => intro n _; rw [val_zero (fun c _ => by simp [setW])]; rfl
  | cons x R ih =>
    intro n hn
    simp only [List.length_cons] at hn
    obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
    simp only [List.reverse_cons]
    rw [val_congr (fun c _ => setW_snoc R.reverse x c), val_cons, ih m (by omega), valW_snoc]
    omega

theorem val_setW (L : List Nat) (n : Nat) (h : L.length ≤ n) : val (setW L) n = valW L := by
  have := val_setW_rev L.reverse n (by simpa using h)
  simpa using this

theorem valW_lt {L : List Nat} (h : ∀ x ∈ L, x < 10) : valW L < 10 ^ L.length := by
  rw [← val_setW L L.length (Nat.le_refl _)]; exact val_lt (setW_fig h _)

/-- `x` set on a counter of `q` cages, figure by figure. -/
def setN (x : Nat) : Wheel := fun c => x / 10 ^ c % 10

theorem val_setN (q : Nat) : ∀ x, val (setN x) q = x % 10 ^ q := by
  induction q with
  | zero => intro x; simp [val, Nat.mod_one]
  | succ q ih =>
    intro x
    have e : (fun c => setN x (c + 1)) = setN (x / 10) := by
      funext c; simp only [setN, Nat.pow_succ', Nat.div_div_eq_div_mul]
    rw [val, e, ih, Nat.pow_succ', Nat.mod_mul]
    simp [setN]

/-- The engine as `scripts/f_control.py` sets it up: the multiplicand `Af` on A's N.o 1,
the multiplier `M` on C's N.o 1 (first figure in the top cage), P holding the number of
the multiplier's figures, everything else at zero. -/
def init (Af M : List Nat) : Mach where
  A := ⟨setW Af, fun _ => 0, true⟩
  B := ⟨fun _ => 0, fun _ => 0, true⟩
  C := ⟨setW M, fun _ => 0, true⟩
  K := fun _ => 0
  P := setN M.length
  first := true
  phase := .places
  bands := 0
  over := 0

/-- **Theorem 5, for operands as written.** With `n ≥ len A + len M` cages on A and B
(`scripts/f_control.py` uses `len A + len M + 1`) and `q` cages on P enough to hold
`len M`, the controller ends after `2p + ΣM + 1` decisions with the product wheel holding
`value A · value M`, having executed `p + ΣM` bands, with nothing carried above a top
cage. -/
theorem multiply_lists (Af M : List Nat) (n q : Nat) (hA : ∀ x ∈ Af, x < 10)
    (hM : ∀ x ∈ M, x < 10) (hn : Af.length + M.length ≤ n) (hn0 : 0 < n)
    (hq : M.length < 10 ^ q) :
    let t := iter (ctl n M.length q) (2 * M.length + M.sum + 1) (init Af M)
    t.phase = .done ∧ val t.B.held n = valW Af * valW M ∧ Zero n t.B.spare ∧
      val t.A.held n = valW Af ∧ t.bands = M.length + M.sum ∧ t.over = 0 := by
  have hAv : val (init Af M).A.held n = valW Af := val_setW Af n (by omega)
  have hcap : val (init Af M).A.held n * valW M < 10 ^ n := by
    rw [hAv]
    have h1 := valW_lt hA
    have h2 := valW_lt hM
    calc valW Af * valW M < 10 ^ Af.length * 10 ^ M.length :=
          Nat.mul_lt_mul_of_lt_of_lt h1 h2
      _ = 10 ^ (Af.length + M.length) := (Nat.pow_add _ _ _).symm
      _ ≤ 10 ^ n := Nat.pow_le_pow_right (by omega) hn
  have R := multiply_correct n M.length q M (init Af M) hn0 rfl hM (setW_fig hA n)
    (fun _ _ => rfl) (fun _ _ => rfl) (fun _ _ => rfl)
    (fun c hc => by simp [init, Axis.held, setW, hc]) (fun _ _ => rfl) rfl
    (fun c _ => Nat.mod_lt _ (by omega)) (by rw [show (init Af M).P = setN M.length from rfl,
      val_setN, Nat.mod_eq_of_lt hq]) rfl rfl hcap
  intro t
  obtain ⟨r1, r2, _, r4, r5, _, r7, r8⟩ := R
  rw [hAv] at r2 r5
  exact ⟨r1, r2, r4, r5, by rw [r7]; simp [init], r8⟩

end Babbage.Mill
