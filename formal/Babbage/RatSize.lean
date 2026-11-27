import Babbage.GrowthStore

/-!
# Exact fractions satisfy the size condition

`src/sketch.rs` computes with exact fractions. This file shows that core
Lean's `Rat`, with size the larger of |numerator| and denominator, satisfies
the condition `Sized` of the growth theorems: one operation of the mill makes
nothing larger than the cube of the larger operand (or of 2). So `no_tetration`
and `no_pentation` hold for fractions as for whole numbers (`ratSized`).

Division by 0 is an error (`none`), as in the Rust; a count is a whole number
≥ 0.
-/

namespace Babbage

/-- The size of a fraction in lowest terms. -/
def rsz (q : Rat) : Nat := max q.num.natAbs q.den

def ratOp : Op → Rat → Rat → Option Rat
  | .add, a, b => some (a + b)
  | .sub, a, b => some (a - b)
  | .mul, a, b => some (a * b)
  | .div, a, b => if b = 0 then none else some (a / b)

def ratCount (v : Rat) : Option Nat :=
  if v.den = 1 ∧ 0 ≤ v.num then some v.num.toNat else none

/-- Exact fractions. -/
def ratArith : Arith Rat := ⟨0, fun v => (v : Rat), ratOp, ratCount⟩

/-- Reducing a fraction makes neither part larger. -/
theorem mkRat_le (n : Int) (d : Nat) (hd : d ≠ 0) :
    (mkRat n d).num.natAbs ≤ n.natAbs ∧ (mkRat n d).den ≤ d := by
  simp only [Rat.num_mkRat, Rat.den_mkRat, hd, ↓reduceIte]
  refine ⟨?_, Nat.div_le_self _ _⟩
  have hdvd : ((d.gcd n.natAbs : Nat) : Int) ∣ n :=
    Int.ofNat_dvd_left.2 (Nat.gcd_dvd_right _ _)
  rw [Int.natAbs_ediv_of_dvd hdvd]
  exact Nat.div_le_self _ _

theorem cube_of (M x y : Nat) (hM : 2 ≤ M) (hx : x ≤ M * M + M * M) (hy : y ≤ M * M) :
    max x y ≤ M ^ 3 := by
  have h2 : M * M + M * M ≤ M * M * M := by
    have := Nat.mul_le_mul_left (M * M) hM
    rw [Nat.mul_two] at this; exact this
  have h3 : M * M * M = M ^ 3 := by simp [Nat.pow_succ]
  have hMM : M * M ≤ M * M + M * M := Nat.le_add_right _ _
  omega

theorem den_le_rsz (q : Rat) : q.den ≤ rsz q := Nat.le_max_right _ _
theorem num_le_rsz (q : Rat) : q.num.natAbs ≤ rsz q := Nat.le_max_left _ _

theorem rsz_inv_le (b : Rat) : rsz b⁻¹ ≤ max (rsz b) 1 := by
  unfold rsz
  rw [Rat.num_inv, Rat.den_inv, Int.natAbs_mul]
  have hs : b.num.sign.natAbs ≤ 1 := by
    rcases Int.sign_trichotomy b.num with h | h | h <;> simp [h]
  have : b.num.sign.natAbs * (b.den : Int).natAbs ≤ b.den := by
    simp only [Int.natAbs_natCast]
    calc b.num.sign.natAbs * b.den ≤ 1 * b.den := Nat.mul_le_mul_right _ hs
      _ = b.den := Nat.one_mul _
  split <;> omega

/-- The two-operand bound, for `mkRat p q` with |p| and q bounded. -/
theorem rsz_mkRat {n : Int} {d M : Nat} (hd : d ≠ 0) (hM : 2 ≤ M)
    (hn : n.natAbs ≤ M * M + M * M) (hdM : d ≤ M * M) : rsz (mkRat n d) ≤ M ^ 3 := by
  obtain ⟨h1, h2⟩ := mkRat_le n d hd
  exact cube_of M _ _ hM (Nat.le_trans h1 hn) (Nat.le_trans h2 hdM)

theorem prod_le {x y M : Nat} (hx : x ≤ M) (hy : y ≤ M) : x * y ≤ M * M := Nat.mul_le_mul hx hy

def ratSized : Sized ratArith where
  sz := rsz
  op_le := by
    intro o a b r h
    generalize hM : max (max (rsz a) (rsz b)) 2 = M
    have haM : rsz a ≤ M := by omega
    have hbM : rsz b ≤ M := by omega
    have h2 : 2 ≤ M := by omega
    have an := Nat.le_trans (num_le_rsz a) haM
    have ad := Nat.le_trans (den_le_rsz a) haM
    have bn := Nat.le_trans (num_le_rsz b) hbM
    have bd := Nat.le_trans (den_le_rsz b) hbM
    have hden : a.den * b.den ≠ 0 := Nat.mul_ne_zero a.den_nz b.den_nz
    have hdd : a.den * b.den ≤ M * M := prod_le ad bd
    have cross : (a.num * b.den).natAbs + (b.num * a.den).natAbs ≤ M * M + M * M := by
      simp only [Int.natAbs_mul, Int.natAbs_natCast]
      exact Nat.add_le_add (prod_le an bd) (prod_le bn ad)
    -- a · c, for c within M: the product bound
    have mulb : ∀ c : Rat, rsz c ≤ M → rsz (a * c) ≤ M ^ 3 := by
      intro c hc
      rw [Rat.mul_def']
      refine rsz_mkRat (Nat.mul_ne_zero a.den_nz c.den_nz) h2 ?_ ?_
      · rw [Int.natAbs_mul]
        exact Nat.le_trans (prod_le an (Nat.le_trans (num_le_rsz c) hc)) (Nat.le_add_right _ _)
      · exact prod_le ad (Nat.le_trans (den_le_rsz c) hc)
    cases o with
    | add =>
      simp only [ratArith, ratOp, Option.some.injEq] at h; subst h
      show rsz (a + b) ≤ M ^ 3
      rw [Rat.add_def']
      exact rsz_mkRat hden h2 (Nat.le_trans (Int.natAbs_add_le _ _) cross) hdd
    | sub =>
      simp only [ratArith, ratOp, Option.some.injEq] at h; subst h
      show rsz (a - b) ≤ M ^ 3
      rw [Rat.sub_def']
      exact rsz_mkRat hden h2 (Nat.le_trans (Int.natAbs_sub_le _ _) cross) hdd
    | mul =>
      simp only [ratArith, ratOp, Option.some.injEq] at h; subst h
      exact mulb b hbM
    | div =>
      simp only [ratArith, ratOp] at h
      split at h
      · cases h
      · cases h
        show rsz (a / b) ≤ M ^ 3
        rw [Rat.div_def]
        exact mulb _ (Nat.le_trans (rsz_inv_le b) (by omega))
  count_le := by
    intro v n h
    simp only [ratArith, ratCount] at h
    split at h
    · cases h
      have := num_le_rsz v
      omega
    · cases h

/-- `no_tetration` for exact fractions. -/
theorem no_tetration_rat {c : Config} {K K₀ : Nat} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hl : LitsLe ratArith ratSized K d) (hc : ConstReps d)
    (init : Nat → State Rat) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv ratArith ratSized K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State Rat), run ratArith d k (init n) = .halt s' →
      ∀ v ∈ s'.out, rsz v < tet n :=
  no_tetration ratSized hacc hsg hl hc init h0 hinit

/-- `no_pentation` for exact fractions. -/
theorem no_pentation_rat {c : Config} {K K₀ : Nat} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hl : LitsLe ratArith ratSized K d)
    (init : Nat → State Rat) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv ratArith ratSized K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State Rat), run ratArith d k (init n) = .halt s' →
      ∀ v ∈ s'.out, rsz v < pent n :=
  no_pentation ratSized hacc hsg hl init h0 hinit

end Babbage
