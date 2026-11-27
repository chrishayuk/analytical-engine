import Babbage.Separation

/-!
# Growth with repetition counts from the store (argument C3)

`tower_halts` shows that with a repetition count read from the store a deck of
December 1837 halts with 2↑↑n. This file bounds what such decks can do. Take a
deck accepted by a configuration of the pages (no combinatorial card inside a
counted group), with repetition counts from number cards or from the store.
Then everything it gives off is at most a tower of 2(L + 1) tetrations on the
input plus a constant of the deck (`out_le_ptw`), and so no such deck gives
2↑↑↑n for every n (`no_pentation`).

Here `pent n` is 2↑↑↑n with 2↑↑↑0 = 1: `pent (n + 1) = tet (pent n)`, so
`pent 1 = 2`, `pent 2 = 4`, `pent 3 = 65536`.
-/

namespace Babbage

variable {V : Type}

/-- What one card can make of numbers within X, when a repetition count may be
any number within X. -/
def growS (X : Nat) : Nat := X ^ (3 ^ X)

theorem le_growS (X : Nat) : X ≤ growS X := by
  unfold growS
  rcases Nat.eq_zero_or_pos X with h | h
  · subst h; simp
  · calc X = X ^ 1 := (Nat.pow_one X).symm
      _ ≤ X ^ (3 ^ X) := Nat.pow_le_pow_right h (Nat.one_le_pow _ _ (by omega))

theorem growS_mono {X Y : Nat} (h : X ≤ Y) : growS X ≤ growS Y := by
  unfold growS
  rcases Nat.eq_zero_or_pos X with h0 | h0
  · subst h0
    rcases Nat.eq_zero_or_pos Y with h1 | h1
    · subst h1; simp
    · simp
  · exact Nat.le_trans (Nat.pow_le_pow_left h _)
      (Nat.pow_le_pow_right (by omega) (Nat.pow_le_pow_right (by omega) h))

/-- One card, with repetition counts from the store allowed. -/
theorem step_invS {A : Arith V} (S : Sized A) {K X : Nat} {d : Deck} (hl : LitsLe A S K d)
    {s s' : State V} (hi : Inv A S K X s) (hstep : step A d s = .run s') :
    Inv A S K (growS X) s' := by
  have hX := le_growS X
  obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card := by
    cases h : d[s.pc]? with
    | none => simp [step, h] at hstep
    | some card => exact ⟨card, rfl⟩
  have base : ∀ j, S.sz (s.store j) ≤ growS X := fun j => Nat.le_trans (hi.store j) hX
  have hX2 : 2 ≤ X := hi.two
  have powle : ∀ e, e ≤ 3 ^ X → X ^ e ≤ growS X :=
    fun e he => Nat.pow_le_pow_right (by omega) he
  have cube : ∀ y : Nat, y ≤ X ^ 3 → y ≤ growS X := by
    intro y hy
    refine Nat.le_trans hy (powle 3 ?_)
    calc 3 = 3 ^ 1 := rfl
      _ ≤ 3 ^ X := Nat.pow_le_pow_right (by omega) (by omega)
  unfold step at hstep
  rw [hget] at hstep
  cases card with
  | op o a b dst =>
    simp only at hstep
    split at hstep
    · rename_i r hr
      cases hstep
      have ha := fetch_le hl hi hget (src := a) (by simp [srcs])
      have hb := fetch_le hl hi hget (src := b) (by simp [srcs])
      have hr' : S.sz r ≤ X ^ 3 := Nat.le_trans (S.op_le _ _ _ _ hr)
        (Nat.pow_le_pow_left (Nat.max_le.mpr ⟨Nat.max_le.mpr ⟨ha, hb⟩, hX2⟩) 3)
      exact ⟨by omega, Nat.le_trans hi.lits hX, upd_le base (cube _ hr'),
        Nat.le_trans hi.wheels hX, fun v hv => Nat.le_trans (hi.out v hv) hX⟩
    · cases hstep
  | rep o col b n =>
    simp only at hstep
    split at hstep
    · cases hstep
    · rename_i k hk
      split at hstep
      · rename_i r hr
        cases hstep
        have hkX : k ≤ X := Nat.le_trans (S.count_le _ _ hk)
          (fetch_le hl hi hget (src := n) (by simp [srcs]))
        have hb := fetch_le hl hi hget (src := b) (by simp [srcs])
        have hr' := iter_le S k _ r X hX2 (hi.store col) hb hr
        have : X ^ (3 ^ k) ≤ growS X := powle _ (Nat.pow_le_pow_right (by omega) hkX)
        exact ⟨by omega, Nat.le_trans hi.lits hX, upd_le base (Nat.le_trans hr' this),
          Nat.le_trans hi.wheels hX, fun v hv => Nat.le_trans (hi.out v hv) hX⟩
      · cases hstep
  | set src =>
    simp only at hstep
    split at hstep
    · rename_i k hk
      cases hstep
      have := Nat.le_trans (S.count_le _ _ hk) (fetch_le hl hi hget (src := src) (by simp [srcs]))
      exact ⟨by omega, Nat.le_trans hi.lits hX, base, by simp; omega,
        fun v hv => Nat.le_trans (hi.out v hv) hX⟩
    · cases hstep
  | back t counted =>
    cases counted with
    | false =>
      simp only at hstep; cases hstep
      exact ⟨by omega, Nat.le_trans hi.lits hX, base, Nat.le_trans hi.wheels hX,
        fun v hv => Nat.le_trans (hi.out v hv) hX⟩
    | true =>
      simp only at hstep
      have hw := hi.wheels
      split at hstep
      · rename_i w hw'
        cases hstep
        rw [hw'] at hw
        exact ⟨by omega, Nat.le_trans hi.lits hX, base, by simp at hw ⊢; omega,
          fun v hv => Nat.le_trans (hi.out v hv) hX⟩
      · cases hstep
        exact ⟨by omega, Nat.le_trans hi.lits hX, base, by simp,
          fun v hv => Nat.le_trans (hi.out v hv) hX⟩
      · cases hstep
  | result col =>
    simp only at hstep; cases hstep
    refine ⟨by omega, Nat.le_trans hi.lits hX, base, Nat.le_trans hi.wheels hX, ?_⟩
    intro v hv
    simp only [List.mem_append, List.mem_singleton] at hv
    rcases hv with hv | rfl
    · exact Nat.le_trans (hi.out v hv) hX
    · exact Nat.le_trans (hi.store col) hX

/-- `out_le_Q`, for any per-card growth `g` that bounds one card. -/
theorem out_le_Q_gen {A : Arith V} (S : Sized A) {c : Config} {K : Nat} {d : Deck}
    (g : Nat → Nat) (hg : ∀ x, x ≤ g x)
    (hstepI : ∀ X (s s' : State V), Inv A S K X s → step A d s = .run s' → Inv A S K (g X) s')
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) :
    ∀ n a m X (s s' : State V), Inv A S K X s → setsFrom d s.pc ≤ a → phi d s ≤ m →
      run A d n s = .halt s' → ∀ v ∈ s'.out, S.sz v ≤ Q g d.length a m X := by
  intro n
  induction n with
  | zero => intro a m X s s' _ _ _ h; simp [run] at h
  | succ n ih =>
    intro a m X s s' hi ha hm h
    simp only [run] at h
    cases hstep : step A d s with
    | err => rw [hstep] at h; cases h
    | halt s'' =>
      rw [hstep] at h; cases h
      obtain ⟨rfl, _⟩ := step_halt_eq hstep
      intro v hv
      exact Nat.le_trans (hi.out v hv) (Q_ge _ hg _ m a X)
    | run s'' =>
      rw [hstep] at h
      simp only at h
      have hi' := hstepI X s s'' hi hstep
      rcases phi_step hacc hno (A := A) hstep with ⟨src, hset⟩ | hphi
      · have hsf := setsFrom_of_get hset
        simp [isSet] at hsf
        have hm' := step_moves hset hstep
        simp [Moves] at hm'
        obtain ⟨a', rfl⟩ : ∃ a', a = a' + 1 := ⟨a - 1, by omega⟩
        obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by
          have := pc_lt_of_run hstep; unfold phi at hm; omega⟩
        intro v hv
        have := ih a' _ _ s'' s' hi' (by rw [hm']; omega) (phi_set S hi') h v hv
        rw [Q]; exact Nat.le_trans this (Nat.le_max_right _ _)
      · obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
        intro v hv
        have := ih a m' _ s'' s' hi'
          (Nat.le_trans (setsFrom_le_of_step hacc hsg hno hstep) ha) (by omega) h v hv
        cases a with
        | zero => rw [Q]; exact this
        | succ a => rw [Q]; exact Nat.le_trans this (Nat.le_max_left _ _)

/-! ## Tetration and its towers -/

theorem tet_le_succ (t : Nat) : tet t < tet (t + 1) := Nat.lt_two_pow_self

theorem lt_tet (t : Nat) : t < tet t := by
  induction t with
  | zero => decide
  | succ t ih => exact Nat.lt_of_le_of_lt ih (tet_le_succ t)

theorem tet_mono {x y : Nat} (h : x ≤ y) : tet x ≤ tet y := by
  obtain ⟨k, rfl⟩ : ∃ k, y = x + k := ⟨y - x, by omega⟩
  induction k with
  | zero => exact Nat.le_refl _
  | succ k ih => exact Nat.le_trans (ih (by omega)) (Nat.le_of_lt (tet_le_succ _))

theorem tet_add (t : Nat) : ∀ e, tet t + e ≤ tet (t + e) := by
  intro e
  induction e with
  | zero => exact Nat.le_refl _
  | succ e ih =>
    have := tet_le_succ (t + e)
    show tet t + (e + 1) ≤ tet (t + e + 1)
    omega

/-- `k` tetrations on `y`. -/
def ptw (k y : Nat) : Nat := it tet k y

/-- 2↑↑↑n, with 2↑↑↑0 = 1. -/
def pent : Nat → Nat
  | 0 => 1
  | n + 1 => tet (pent n)

theorem pent_eq_ptw (n : Nat) : pent n = ptw n 1 := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [pent, ih]; rfl

theorem ptw_mono (k : Nat) : ∀ x y, x ≤ y → ptw k x ≤ ptw k y :=
  it_mono (fun _ _ h => tet_mono h) k

theorem ptw_add (k : Nat) : ∀ y e, ptw k y + e ≤ ptw k (y + e) := by
  induction k with
  | zero => intro y e; simp [ptw, it]
  | succ k ih =>
    intro y e
    show tet (ptw k y) + e ≤ tet (ptw k (y + e))
    exact Nat.le_trans (tet_add _ _) (tet_mono (ih y e))

theorem ptw_comp (a b y : Nat) : ptw a (ptw b y) = ptw (a + b) y := it_add _ a b y

theorem tet_le_pent (p : Nat) : tet p ≤ pent p := by
  have hp : ∀ q, q + 1 ≤ pent q := by
    intro q
    induction q with
    | zero => exact Nat.le_refl _
    | succ q ih => exact Nat.le_trans (Nat.succ_le_succ ih) (lt_tet (pent q))
  cases p with
  | zero => exact Nat.le_refl _
  | succ p => exact tet_mono (hp p)

theorem tw_le_tet (k y : Nat) : tw k y ≤ tet (k + y) := by
  have hy : y ≤ tw y 1 := Nat.le_trans (Nat.le_of_lt Nat.lt_two_pow_self) (pow_le_tw y)
  rw [tet_eq_tw, ← tw_comp]
  exact tw_mono k _ _ hy

/-! ## One card, one phase -/

theorem growS_le (x : Nat) : growS x ≤ tw 3 (x + 2) := by
  unfold growS
  have hx : x ≤ 2 ^ x := Nat.le_of_lt Nat.lt_two_pow_self
  have h3 : 3 ^ x ≤ 2 ^ (2 * x) := by
    rw [Nat.pow_mul]; exact Nat.pow_le_pow_left (by decide) x
  have h4 : 3 * x ≤ 2 ^ (x + 2) := by
    have := Nat.lt_two_pow_self (n := x)
    rw [Nat.pow_add]; omega
  calc x ^ (3 ^ x) ≤ (2 ^ x) ^ (3 ^ x) := Nat.pow_le_pow_left hx _
    _ = 2 ^ (x * 3 ^ x) := (Nat.pow_mul 2 x _).symm
    _ ≤ 2 ^ (2 ^ x * 2 ^ (2 * x)) := pow2_mono _ _ (Nat.mul_le_mul hx h3)
    _ = 2 ^ 2 ^ (3 * x) := by rw [← Nat.pow_add]; congr 2; omega
    _ ≤ 2 ^ 2 ^ 2 ^ (x + 2) := pow2_mono _ _ (pow2_mono _ _ h4)

theorem it_growS_le : ∀ m Y, it growS m Y ≤ tw (3 * m) (Y + 2 * m) := by
  intro m
  induction m with
  | zero => intro Y; simp [it, tw]
  | succ m ih =>
    intro Y
    show growS (it growS m Y) ≤ _
    refine Nat.le_trans (growS_mono (ih Y)) (Nat.le_trans (growS_le _) ?_)
    refine Nat.le_trans (tw_mono 3 _ _ (tw_add _ _ _)) ?_
    rw [tw_comp, show 3 + 3 * m = 3 * (m + 1) by omega]
    exact tw_mono _ _ _ (by omega)

/-- One phase, as one tetration. -/
def T (L Y : Nat) : Nat := tet ((5 * L + 6) * (Y + 1))

theorem H_growS_le (L Y : Nat) : H growS L Y ≤ T L Y := by
  unfold H T
  refine Nat.le_trans (it_growS_le _ _) (Nat.le_trans (tw_le_tet _ _) (tet_mono ?_))
  have e1 : Y * (L + 1) = Y * L + Y := by rw [Nat.mul_add Y L 1, Nat.mul_one]
  have e2 : (5 * L + 6) * (Y + 1) = 5 * (Y * L) + 6 * Y + 5 * L + 6 := by
    rw [Nat.add_mul, Nat.mul_add (5 * L), Nat.mul_one, Nat.mul_add 6, Nat.mul_one,
      Nat.mul_assoc, Nat.mul_comm L Y]
    omega
  rw [e1, e2]
  omega

theorem T_mono (L : Nat) {x y : Nat} (h : x ≤ y) : T L x ≤ T L y :=
  tet_mono (Nat.mul_le_mul_left _ (by omega))

theorem T_le (L x : Nat) : T L x ≤ tet (tet (x + (5 * L + 6))) := by
  unfold T
  apply tet_mono
  generalize 5 * L + 6 = D
  have h1 : x + 1 ≤ 2 ^ x := Nat.lt_two_pow_self
  have h2 : D + 1 ≤ 2 ^ D := Nat.lt_two_pow_self
  calc D * (x + 1) ≤ (D + 1) * (x + 1) := Nat.mul_le_mul_right _ (by omega)
    _ ≤ 2 ^ D * 2 ^ x := Nat.mul_le_mul h2 h1
    _ = 2 ^ (x + D) := by rw [← Nat.pow_add, Nat.add_comm]
    _ ≤ tw (x + D) 1 := pow_le_tw _
    _ = tet (x + D) := (tet_eq_tw _).symm

theorem it_T_le (L : Nat) : ∀ j X, it (T L) j X ≤ ptw (2 * j) (X + j * (5 * L + 6)) := by
  intro j
  induction j with
  | zero => intro X; simp [it, ptw]
  | succ j ih =>
    intro X
    show T L (it (T L) j X) ≤ _
    refine Nat.le_trans (T_mono L (ih X)) (Nat.le_trans (T_le L _) ?_)
    have := ptw_add (2 * j) (X + j * (5 * L + 6)) (5 * L + 6)
    refine Nat.le_trans (tet_mono (tet_mono this)) ?_
    show ptw 2 (ptw (2 * j) _) ≤ _
    rw [ptw_comp, show 2 + 2 * j = 2 * (j + 1) by omega]
    exact ptw_mono _ _ _ (by rw [Nat.add_mul j 1, Nat.one_mul]; omega)

theorem it_le_of_le {f h : Nat → Nat} (hfh : ∀ x, f x ≤ h x)
    (hm : ∀ x y, x ≤ y → h x ≤ h y) : ∀ j x, it f j x ≤ it h j x := by
  intro j
  induction j with
  | zero => intro x; exact Nat.le_refl _
  | succ j ih => intro x; exact Nat.le_trans (hfh _) (hm _ _ (ih x))

/-- **The growth bound, counts from the store.** A deck of the pages, started
from numbers within X ≥ 2, gives off nothing larger than 2(L + 1) tetrations on
X + (L + 1)(5L + 6). -/
theorem out_le_ptw {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false) (hl : LitsLe A S K d)
    {s : State V} (hs : Inv A S K X s) (h0 : s.pc = 0)
    {n : Nat} {s' : State V} (hrun : run A d n s = .halt s') :
    ∀ v ∈ s'.out,
      S.sz v ≤ ptw (2 * (d.length + 1)) (X + (d.length + 1) * (5 * d.length + 6)) := by
  have hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false) := fun i t hi =>
    never_halts_from_start (backward_of_accepts hacc) hi s h0 ⟨n, s', hrun⟩
  intro v hv
  have hm : ∀ x y, x ≤ y → growS x ≤ growS y := fun _ _ => growS_mono
  have hi := le_growS
  have ha : setsFrom d s.pc ≤ d.length := by
    rw [h0]; unfold setsFrom
    suffices ∀ l : List Card, setsIn l ≤ l.length by simpa using this d
    intro l; induction l with
    | nil => simp [setsIn]
    | cons x xs ih => simp only [setsIn, List.length_cons]; split <;> omega
  have h1 := out_le_Q_gen S growS hi (fun X s s' hi' h => step_invS S hl hi' h) hacc hsg hno
    n _ _ X s s' hs ha (phi_set S hs) hrun v hv
  refine Nat.le_trans h1 (Nat.le_trans (Q_le hm hi _ _ _ _) ?_)
  have h2 : it growS (X * (d.length + 1) + d.length) X = H growS d.length X := rfl
  rw [h2, ← it_succ']
  refine Nat.le_trans (it_le_it (H_infl hi _) X (Nat.succ_le_succ (Nat.le_refl _))) ?_
  refine Nat.le_trans (it_le_of_le (H_growS_le d.length) (fun _ _ h => T_mono _ h) _ X) ?_
  exact it_T_le d.length _ X

/-- **The separation, counts from the store.** Inputs within n + K₀: a deck of
the pages, its repetition counts from number cards or the store, does not give
2↑↑↑n for every n. For some n, everything it gives off is smaller. -/
theorem no_pentation {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false) (hl : LitsLe A S K d)
    (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State V), run A d k (init n) = .halt s' → ∀ v ∈ s'.out, S.sz v < pent n := by
  let J := 2 * (d.length + 1)
  let C := K₀ + (d.length + 1) * (5 * d.length + 6)
  let p := J + 1 + C
  refine ⟨J + p + 1, fun k s' hrun v hv => ?_⟩
  have h := out_le_ptw S hacc hsg hl (hinit _) (h0 _) hrun v hv
  have hp : J + p + 1 + C ≤ pent p :=
    Nat.le_trans (by have := two_mul_le_two_pow p; omega)
      (Nat.le_trans (pow_le_tw p) (by rw [← tet_eq_tw]; exact tet_le_pent p))
  have h3 : ptw J (J + p + 1 + C) ≤ pent (J + p) := by
    rw [pent_eq_ptw, ← ptw_comp, ← pent_eq_ptw]; exact ptw_mono J _ _ hp
  show S.sz v < tet (pent (J + p))
  have : S.sz v ≤ pent (J + p) := by
    refine Nat.le_trans h (Nat.le_trans ?_ h3)
    exact ptw_mono J _ _ (by omega)
  exact Nat.lt_of_le_of_lt this (lt_tet _)

/-- The number cards of the tower deck are 0, 1 and 2. -/
theorem towerDeck_lits : LitsLe intArith intSized 2 towerDeck := by
  intro i card h v hv
  match i, h with
  | 0, h | 1, h | 2, h | 3, h =>
    simp only [towerDeck, List.getElem?_cons_succ, List.getElem?_cons_zero,
      Option.some.injEq] at h
    subst h
    simp only [srcs, List.mem_cons, List.mem_nil_iff, or_false, reduceCtorEq,
      Src.num.injEq, false_or] at hv
    subst hv
    decide
  | 4, h | 5, h =>
    simp only [towerDeck, List.getElem?_cons_succ, List.getElem?_cons_zero,
      Option.some.injEq] at h
    subst h
    simp [srcs] at hv
  | i + 6, h => simp [towerDeck] at h

/-- The tower deck's start, with n on the wheels. -/
def towerInit (n : Nat) : State Int := ⟨0, fun j => if j = 1 then 1 else 0, some n, []⟩

theorem towerInit_inv (n : Nat) : Inv intArith intSized 2 (n + 2) (towerInit n) where
  two := by omega
  lits := by omega
  store := by intro j; simp only [towerInit, intSized]; split <;> simp
  wheels := by simp [towerInit]
  out := by simp [towerInit]

/-- The hypotheses of `no_pentation` are met by a deck that gives 2↑↑n
(`tower_halts`): with counts from the store, the deck of December 1837 reaches
tetration and, for some n, stays below 2↑↑↑n. -/
theorem tower_below_pentation :
    ∃ n, ∀ k (s' : State Int), run intArith towerDeck k (towerInit n) = .halt s' →
      ∀ v ∈ s'.out, v.natAbs < pent n :=
  no_pentation intSized towerDeck_accepted rfl towerDeck_lits towerInit (fun _ => rfl)
    towerInit_inv

end Babbage
