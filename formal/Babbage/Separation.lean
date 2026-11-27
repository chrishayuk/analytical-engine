import Babbage.Growth
import Babbage.Tower

/-!
# The separation: no deck of the pages gives 2↑↑n and halts, if its repetition
counts are number cards

`out_le_tower`: what such a deck gives off from numbers within X is at most a
tower of 2s of height 3(L + 1) on X + (L + 1)E, with L the number of cards and
E fixed by the deck. `no_tetration`: so for some n it does not give 2↑↑n.
`tower_halts` (in `Tower.lean`) shows the condition is needed: with a
repetition count read from the store, a deck of December 1837 gives 2↑↑n.
-/

namespace Babbage

variable {V : Type}

/-- `f` applied `n` times. -/
def it (f : Nat → Nat) : Nat → Nat → Nat
  | 0, x => x
  | n + 1, x => f (it f n x)

theorem it_succ' (f : Nat → Nat) (n x : Nat) : it f (n + 1) x = it f n (f x) := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [it] at *; rw [ih]

theorem it_add (f : Nat → Nat) (a b x : Nat) : it f a (it f b x) = it f (a + b) x := by
  induction a with
  | zero => simp [it]
  | succ a ih => rw [Nat.add_right_comm]; simp only [it, ih]

theorem it_mono {f : Nat → Nat} (hf : ∀ x y, x ≤ y → f x ≤ f y) (n : Nat) :
    ∀ x y, x ≤ y → it f n x ≤ it f n y := by
  induction n with
  | zero => intro x y h; exact h
  | succ n ih => intro x y h; exact hf _ _ (ih x y h)

theorem it_infl {f : Nat → Nat} (hf : ∀ x, x ≤ f x) (n x : Nat) : x ≤ it f n x := by
  induction n with
  | zero => exact Nat.le_refl _
  | succ n ih => exact Nat.le_trans ih (hf _)

theorem it_le_it {f : Nat → Nat} (hf : ∀ x, x ≤ f x) (x : Nat) :
    ∀ {n n'}, n ≤ n' → it f n x ≤ it f n' x := by
  intro n n' h
  obtain ⟨k, rfl⟩ : ∃ k, n' = k + n := ⟨n' - n, by omega⟩
  rw [← it_add]; exact it_infl hf k _

/-- A phase: from numbers within Y, the cards that pass before the next
combinatorial card. -/
def H (g : Nat → Nat) (L Y : Nat) : Nat := it g (Y * (L + 1) + L) Y

section
variable {g : Nat → Nat} (hm : ∀ x y, x ≤ y → g x ≤ g y) (hi : ∀ x, x ≤ g x) (L : Nat)
include hm hi

theorem H_mono : ∀ x y, x ≤ y → H g L x ≤ H g L y := by
  intro x y h
  unfold H
  refine Nat.le_trans (it_mono hm _ x y h) (it_le_it hi y ?_)
  exact Nat.add_le_add_right (Nat.mul_le_mul_right _ h) _

omit hm in
theorem H_infl : ∀ x, x ≤ H g L x := fun x => it_infl hi _ x

theorem Q_le : ∀ a m X, Q g L a m X ≤ it (H g L) a (it g m X) := by
  intro a
  induction a with
  | zero =>
    intro m
    induction m with
    | zero => intro X; simp [Q, it]
    | succ m ih => intro X; rw [Q, it_succ']; exact ih _
  | succ a iha =>
    intro m
    induction m with
    | zero => intro X; rw [Q]; exact it_infl (H_infl hi L) _ _
    | succ m ih =>
      intro X
      rw [Q]
      refine Nat.max_le.mpr ⟨?_, ?_⟩
      · rw [it_succ' g m X]; exact ih _
      · refine Nat.le_trans (iha _ _) ?_
        show it (H g L) a (H g L (g X)) ≤ _
        rw [← it_succ']
        apply it_mono (H_mono hm hi L)
        rw [it_succ']
        exact it_infl hi _ _
end

/-! ## Towers -/

/-- A tower of `k` 2s on `y`. -/
def tw (k y : Nat) : Nat := it (fun x => 2 ^ x) k y

theorem pow2_mono : ∀ x y : Nat, x ≤ y → 2 ^ x ≤ 2 ^ y :=
  fun _ _ h => Nat.pow_le_pow_right (by omega) h

theorem tw_mono (k : Nat) : ∀ x y, x ≤ y → tw k x ≤ tw k y := it_mono pow2_mono k

theorem two_pow_add (t E : Nat) : 2 ^ t + E ≤ 2 ^ (t + E) := by
  rw [Nat.pow_add]
  have h1 : 1 ≤ 2 ^ t := Nat.one_le_two_pow
  have h2 : E + 1 ≤ 2 ^ E := Nat.lt_two_pow_self
  have := Nat.mul_le_mul h1 h2
  have h3 := Nat.mul_le_mul_left (2 ^ t) h2
  rw [Nat.mul_add, Nat.mul_one] at h3
  have : E ≤ 2 ^ t * E := by
    calc E = 1 * E := (Nat.one_mul E).symm
      _ ≤ 2 ^ t * E := Nat.mul_le_mul_right E h1
  omega

theorem tw_add (k : Nat) : ∀ y E, tw k y + E ≤ tw k (y + E) := by
  induction k with
  | zero => intro y E; simp [tw, it]
  | succ k ih =>
    intro y E
    show 2 ^ tw k y + E ≤ 2 ^ tw k (y + E)
    exact Nat.le_trans (two_pow_add _ _) (pow2_mono _ _ (ih y E))

theorem tw_comp (a b y : Nat) : tw a (tw b y) = tw (a + b) y := it_add _ a b y

theorem it_grow (K : Nat) : ∀ m X, it (grow K) m X = X ^ ((3 ^ (K + 1)) ^ m) := by
  intro m
  induction m with
  | zero => intro X; simp [it]
  | succ m ih => intro X; simp only [it, ih, grow]; rw [← Nat.pow_mul, ← Nat.pow_succ]

theorem it_grow_le (K m X : Nat) : it (grow K) m X ≤ tw 2 (X + 3 ^ (K + 1) * m) := by
  rw [it_grow]
  generalize hc : 3 ^ (K + 1) = c
  show X ^ (c ^ m) ≤ 2 ^ 2 ^ (X + c * m)
  have hX : X ≤ 2 ^ X := Nat.le_of_lt Nat.lt_two_pow_self
  have hcm : c ^ m ≤ 2 ^ (c * m) := by
    rw [Nat.pow_mul]; exact Nat.pow_le_pow_left (Nat.le_of_lt Nat.lt_two_pow_self) m
  calc X ^ (c ^ m) ≤ (2 ^ X) ^ (c ^ m) := Nat.pow_le_pow_left hX _
    _ = 2 ^ (X * c ^ m) := (Nat.pow_mul 2 X _).symm
    _ ≤ 2 ^ (2 ^ X * 2 ^ (c * m)) := pow2_mono _ _ (Nat.mul_le_mul hX hcm)
    _ = 2 ^ 2 ^ (X + c * m) := by rw [← Nat.pow_add]

/-- The constant of one phase. -/
def E (K L : Nat) : Nat := 1 + 3 ^ (K + 1) * (L + 1) + 3 ^ (K + 1) * L + 1

theorem H_le (K L Y : Nat) : H (grow K) L Y ≤ tw 3 (Y + E K L) := by
  unfold H
  refine Nat.le_trans (it_grow_le K _ Y) (tw_mono 2 _ _ ?_)
  generalize hc : 3 ^ (K + 1) = c
  have hE : E K L = 1 + c * (L + 1) + c * L + 1 := by simp [E, hc]
  rw [hE]
  generalize hD : 1 + c * (L + 1) + c * L = D
  have lin : Y + c * (Y * (L + 1) + L) ≤ (Y + 1) * D := by
    rw [← hD, Nat.mul_add c, Nat.mul_comm c (Y * (L + 1)), Nat.mul_assoc Y (L + 1) c,
      Nat.mul_comm (L + 1) c, Nat.add_mul, Nat.mul_add Y, Nat.mul_add Y, Nat.one_mul, Nat.mul_one]
    have : c * L ≤ 1 + c * (L + 1) + c * L := by omega
    omega
  calc Y + c * (Y * (L + 1) + L) ≤ (Y + 1) * D := lin
    _ ≤ 2 ^ (Y + 1) * 2 ^ D :=
        Nat.mul_le_mul (Nat.le_of_lt Nat.lt_two_pow_self) (Nat.le_of_lt Nat.lt_two_pow_self)
    _ = 2 ^ (Y + (D + 1)) := by rw [← Nat.pow_add]; congr 1; omega

theorem itH_le (K L : Nat) : ∀ j X, it (H (grow K) L) j X ≤ tw (3 * j) (X + j * E K L) := by
  intro j
  induction j with
  | zero => intro X; simp [it, tw]
  | succ j ih =>
    intro X
    show H (grow K) L (it (H (grow K) L) j X) ≤ _
    refine Nat.le_trans (H_mono (fun _ _ => grow_mono K) (le_grow K) L _ _ (ih X)) ?_
    refine Nat.le_trans (H_le K L _) ?_
    refine Nat.le_trans (tw_mono 3 _ _ (tw_add _ _ _)) ?_
    rw [tw_comp, show 3 + 3 * j = 3 * (j + 1) by omega]
    apply tw_mono; rw [Nat.succ_mul]; omega

/-- **The growth bound.** A deck of the pages whose repetition counts are number
cards, started from numbers within X ≥ 2 (number cards included), gives off
nothing larger than a tower of 2s of height 3(L + 1) on X + (L + 1)·E. -/
theorem out_le_tower {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false) (hl : LitsLe A S K d)
    (hc : ConstReps d) {s : State V} (hs : Inv A S K X s) (h0 : s.pc = 0)
    {n : Nat} {s' : State V} (hrun : run A d n s = .halt s') :
    ∀ v ∈ s'.out, S.sz v ≤ tw (3 * (d.length + 1)) (X + (d.length + 1) * E K d.length) := by
  have hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false) := fun i t hi =>
    never_halts_from_start (backward_of_accepts hacc) hi s h0 ⟨n, s', hrun⟩
  intro v hv
  have hm : ∀ x y, x ≤ y → grow K x ≤ grow K y := fun _ _ => grow_mono K
  have hi := le_grow K
  have ha : setsFrom d s.pc ≤ d.length := by
    rw [h0]; unfold setsFrom
    suffices ∀ l : List Card, setsIn l ≤ l.length by simpa using this d
    intro l; induction l with
    | nil => simp [setsIn]
    | cons x xs ih => simp only [setsIn, List.length_cons]; split <;> omega
  have h1 := out_le_Q S hacc hsg hno hl hc n _ _ X s s' hs ha (phi_set S hs) hrun v hv
  refine Nat.le_trans h1 (Nat.le_trans (Q_le hm hi _ _ _ _) ?_)
  have h2 : it (grow K) (X * (d.length + 1) + d.length) X = H (grow K) d.length X := rfl
  rw [h2, ← it_succ']
  refine Nat.le_trans (it_le_it (H_infl hi _) X (Nat.succ_le_succ (Nat.le_refl _))) ?_
  exact itH_le K d.length _ X

theorem tet_eq_tw (n : Nat) : tet n = tw n 1 := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [tet, ih]; rfl

theorem two_mul_le_two_pow : ∀ p : Nat, 2 * p ≤ 2 ^ p
  | 0 => by simp
  | 1 => by simp
  | p + 2 => by
    have := two_mul_le_two_pow (p + 1)
    have h : 2 ≤ 2 ^ (p + 1) := by
      calc 2 = 2 ^ 1 := rfl
        _ ≤ 2 ^ (p + 1) := Nat.pow_le_pow_right (by omega) (by omega)
    rw [Nat.pow_succ 2 (p + 1)]; omega

theorem pow_le_tw (p : Nat) : 2 ^ p ≤ tw p 1 := by
  induction p with
  | zero => simp [tw, it]
  | succ p ih =>
    show 2 ^ (p + 1) ≤ 2 ^ tw p 1
    exact pow2_mono _ _ (Nat.le_trans (Nat.lt_two_pow_self) ih)

/-- **The separation.** Inputs n put in the store or on the wheels, everything
within n + K₀: a deck of the pages whose repetition counts are number cards
does not give 2↑↑n for every n. For some n, everything it gives off is smaller. -/
theorem no_tetration {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false) (hl : LitsLe A S K d)
    (hc : ConstReps d) (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State V), run A d k (init n) = .halt s' → ∀ v ∈ s'.out, S.sz v < tet n := by
  let J := 3 * (d.length + 1)
  let C := K₀ + (d.length + 1) * E K d.length
  let p := J + 1 + C
  refine ⟨J + p + 1, fun k s' hrun v hv => ?_⟩
  have h := out_le_tower S hacc hsg hl hc (hinit _) (h0 _) hrun v hv
  have hp : J + p + 1 + C ≤ tw p 1 :=
    Nat.le_trans (by have := two_mul_le_two_pow p; omega) (pow_le_tw p)
  have h3 : tw J (J + p + 1 + C) ≤ tw (J + p) 1 := by
    rw [← tw_comp]; exact tw_mono J _ _ hp
  rw [tet_eq_tw]
  show S.sz v < 2 ^ tw (J + p) 1
  have : S.sz v ≤ tw (J + p) 1 := by
    refine Nat.le_trans h (Nat.le_trans ?_ h3)
    exact tw_mono J _ _ (by omega)
  exact Nat.lt_of_le_of_lt this Nat.lt_two_pow_self

/-! ## Whole numbers satisfy the size condition -/

def intSized : Sized intArith where
  sz := Int.natAbs
  op_le := by
    intro o x y r h
    generalize hM : max (max x.natAbs y.natAbs) 2 = M
    have hxM : x.natAbs ≤ M := by omega
    have hyM : y.natAbs ≤ M := by omega
    have h2 : 2 ≤ M := by omega
    have hMM : 2 * M ≤ M * M := Nat.mul_le_mul_right M h2
    have hM3 : M * M ≤ M ^ 3 := by
      rw [show M ^ 3 = M * M * M by simp [Nat.pow_succ]]
      exact Nat.le_mul_of_pos_right _ (by omega)
    have hM1 : M ≤ M * M := Nat.le_mul_of_pos_right _ (by omega)
    cases o with
    | add =>
      simp [intOp] at h; subst h
      have := Int.natAbs_add_le x y; omega
    | sub =>
      simp [intOp] at h; subst h
      have := Int.natAbs_sub_le x y; omega
    | mul =>
      simp [intOp] at h; subst h
      rw [Int.natAbs_mul]
      exact Nat.le_trans (Nat.mul_le_mul hxM hyM) hM3
    | div =>
      simp only [intArith_op, intOp] at h
      split at h
      · rename_i hd
        cases h
        rw [Int.natAbs_ediv_of_dvd hd.2]
        have := Nat.div_le_self x.natAbs y.natAbs
        omega
      · cases h
  count_le := by
    intro v n h
    simp only [intArith_count, intCount] at h
    split at h
    · cases h; omega
    · cases h

/-- The deck of `tower_halts` is outside `no_tetration` for one reason only: its
repetition count is read from the store. -/
theorem towerDeck_not_constReps : ¬ ConstReps towerDeck := by
  intro h
  obtain ⟨v, hv⟩ := h 2 .mul 3 (.num 2) (.col 1) rfl
  cases hv

end Babbage
