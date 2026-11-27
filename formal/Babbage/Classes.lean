import Babbage.Separation
import Babbage.GrowthStore

/-!
# One loop in December 1837 (FORMAL-5)

In the configuration of December 1837 a backing goes only to the first card,
and (rule 8) no combinatorial card stands among the cards a counted backing
sends back over. So every combinatorial card comes after every backing card,
and the only count a backing can use is the one on the wheels before the
first card. Once the wheels have run up they stand at 0, and a counted
backing passed with 0 on the wheels is an error.

So a halting run from the first card passes its cards in at most one loop:
it backs only at the first backing card of the deck, and the number of cards
it passes is bounded by the count on the wheels at the start
(`halt_within_1837`). With repetition counts from number cards (model A),
every number it gives off is then within a tower of 2s of height 2 on the
input (`out_le_dexp_1837`), so no deck of December 1837 gives 2^2^2^n for
every n (`no_triple_exp_1837`). A deck of May 1838, with two loops one after
the other, does (`triple_halts_1838`). So in model A the configuration of
December 1837 is strictly weaker than that of May 1838.

With repetition counts from the store (model B), the bound is a tetration of
height linear in the input (`out_le_tet_1837`).
-/

namespace Babbage

variable {V : Type}

def isBack : Card → Bool
  | .back _ _ => true
  | _ => false

/-- The position of the first backing card, or the length of the deck. -/
def firstBack : List Card → Nat
  | [] => 0
  | c :: cs => if isBack c then 0 else firstBack cs + 1

theorem firstBack_le : ∀ d : Deck, firstBack d ≤ d.length
  | [] => by simp [firstBack]
  | c :: cs => by
    have := firstBack_le cs
    simp only [firstBack, List.length_cons]; split <;> omega

theorem not_back_lt : ∀ (d : Deck) (j t : Nat) (b : Bool), j < firstBack d →
    d[j]? ≠ some (.back t b)
  | [], j, t, b, h => by simp [firstBack] at h
  | c :: cs, j, t, b, h => by
    simp only [firstBack] at h
    split at h
    · omega
    · rename_i hc
      cases j with
      | zero =>
        simp only [List.getElem?_cons_zero, ne_eq, Option.some.injEq]
        rintro rfl; simp [isBack] at hc
      | succ j =>
        simp only [List.getElem?_cons_succ]
        exact not_back_lt cs j t b (by omega)

theorem back_at_firstBack : ∀ d : Deck, firstBack d < d.length →
    ∃ t b, d[firstBack d]? = some (Card.back t b)
  | [], h => by simp at h
  | x :: xs, h => by
    simp only [firstBack] at h ⊢
    split
    · rename_i hx
      cases x with
      | back t b => exact ⟨t, b, rfl⟩
      | _ => simp [isBack] at hx
    · rename_i hx
      simp only [hx, List.length_cons] at h
      simp only [Bool.false_eq_true, if_false] at h
      simp only [List.getElem?_cons_succ]
      exact back_at_firstBack xs (by omega)

section
variable {c : Config} {d : Deck} (hacc : Accepts c d) (ht : c.anyTarget = false)
  (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
include hacc ht

theorem target_zero {i t : Nat} {b : Bool} (h : d[i]? = some (.back t b)) : t = 0 := by
  have := (hacc i _ h).2.2.1
  rw [ht] at this
  simpa using this

include hsg hno

/-- Every combinatorial card comes after every backing card. -/
theorem back_lt_set {i p t : Nat} {b : Bool} {src : Src} (hi : d[i]? = some (.back t b))
    (hp : d[p]? = some (.set src)) : i < p := by
  cases b with
  | false => exact absurd hi (hno i t)
  | true =>
    have ht0 := target_zero hacc ht hi
    have h := (hacc i _ hi).2.2.2 rfl hsg
    rcases Nat.lt_trichotomy i p with h1 | h1 | h1
    · exact h1
    · subst h1; rw [hi] at hp; cases hp
    · have := h p _ (by omega) h1 hp
      simp [isBack, isSet] at this

/-- Where a run of the deck can be: before or at the first backing card; or
past it with the wheels run up; or past every backing card. -/
def J1837 (d : Deck) (s : State V) : Prop :=
  s.pc ≤ firstBack d ∨ s.wheels = some 0 ∨
    ∀ j t b, s.pc ≤ j → d[j]? ≠ some (Card.back t b)

/-- A measure that every card decreases. -/
def Phi1837 (d : Deck) (s : State V) : Nat :=
  if s.pc ≤ firstBack d ∧ firstBack d < d.length then
    s.wheels.getD 0 * (d.length + 1) + (d.length + 1 - s.pc)
  else d.length + 1 - s.pc

/-- A card that is not a backing card, passed forward. -/
theorem forward_1837 {s s' : State V} (hpc : s.pc < d.length) (hJ : J1837 d s)
    (hnb : ∀ t b, d[s.pc]? ≠ some (Card.back t b))
    (hp : s'.pc = s.pc + 1) (hw : s'.wheels = s.wheels ∨ firstBack d < s.pc ∨ firstBack d = d.length)
    (hJ' : s.wheels = some 0 → J1837 d s') :
    J1837 d s' ∧ Phi1837 d s' < Phi1837 d s := by
  have hfb := firstBack_le d
  have hne : firstBack d < d.length → s.pc ≠ firstBack d := by
    intro h heq
    obtain ⟨t, b, hb⟩ := back_at_firstBack d h
    rw [← heq] at hb; exact hnb t b hb
  unfold Phi1837
  refine ⟨?_, ?_⟩
  · unfold J1837 at hJ ⊢
    rcases hJ with h | h | h
    · rcases Nat.lt_or_ge (firstBack d) d.length with h2 | h2
      · exact Or.inl (by have := hne h2; omega)
      · exact Or.inl (by omega)
    · exact hJ' h
    · exact Or.inr (Or.inr fun j t b hj => h j t b (by omega))
  · rw [hp]
    rcases Nat.lt_or_ge (firstBack d) d.length with h2 | h2
    · rcases Nat.lt_or_ge (firstBack d) s.pc with h3 | h3
      · rw [if_neg (fun h => absurd h.1 (by omega)), if_neg (fun h => absurd h.1 (by omega))]
        omega
      · have := hne h2
        rw [if_pos ⟨by omega, h2⟩, if_pos ⟨h3, h2⟩]
        rcases hw with hw | hw | hw
        · rw [hw]; omega
        · omega
        · omega
    · rw [if_neg (fun h => absurd h.2 (by omega)), if_neg (fun h => absurd h.2 (by omega))]
      omega

theorem step_1837 {A : Arith V} {s s' : State V} (hJ : J1837 d s)
    (hstep : step A d s = .run s') : J1837 d s' ∧ Phi1837 d s' < Phi1837 d s := by
  have hpc : s.pc < d.length := by
    rcases Nat.lt_or_ge s.pc d.length with h | h
    · exact h
    · have : d[s.pc]? = none := List.getElem?_eq_none_iff.mpr h
      simp [step, this] at hstep
  obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card :=
    ⟨d[s.pc], List.getElem?_eq_getElem hpc⟩
  have hm := step_moves hget hstep
  have hfb := firstBack_le d
  have hnb : ∀ t b, card ≠ Card.back t b → d[s.pc]? ≠ some (Card.back t b) := by
    intro t b h h'; rw [hget] at h'; exact h (Option.some.inj h')
  cases card with
  | back t b =>
    cases b with
    | false => exact absurd hget (hno _ t)
    | true =>
      have ht0 := target_zero hacc ht hget
      simp only [Moves] at hm
      have hge : firstBack d ≤ s.pc := by
        rcases Nat.lt_or_ge s.pc (firstBack d) with h | h
        · exact absurd hget (not_back_lt d s.pc t true h)
        · exact h
      unfold J1837 Phi1837 at *
      rcases hm with ⟨hp', w, hw, hw'⟩ | ⟨hp', hw, hw'⟩
      · rcases hJ with h | h | h
        · have heq : s.pc = firstBack d := by omega
          refine ⟨Or.inl (by omega), ?_⟩
          rw [if_pos ⟨by omega, by omega⟩, if_pos ⟨by omega, by omega⟩, hw, hw', hp', ht0]
          simp only [Option.getD_some]
          rw [Nat.add_mul (w + 1) 1 (d.length + 1)]
          omega
        · rw [hw] at h; cases h
        · exact absurd hget (h s.pc t true (Nat.le_refl _))
      · refine ⟨Or.inr (Or.inl hw'), ?_⟩
        rw [if_neg (by omega), hp']
        split
        · rename_i hc; rw [hw]; simp only [Option.getD_some]; omega
        · omega
  | set src =>
    simp only [Moves] at hm
    have hpos : firstBack d < s.pc ∨ firstBack d = d.length := by
      rcases Nat.lt_or_ge (firstBack d) d.length with h2 | h2
      · obtain ⟨t, b, hb⟩ := back_at_firstBack d h2
        exact Or.inl (back_lt_set hacc ht hsg hno hb hget)
      · exact Or.inr (by omega)
    exact forward_1837 hacc ht hsg hno hpc hJ (hnb · · (by simp)) hm (Or.inr hpos)
      (fun _ => Or.inr (Or.inr fun j t b hj hj' => by
        have := back_lt_set hacc ht hsg hno hj' hget; omega))
  | op | rep | result =>
    simp only [Moves] at hm
    exact forward_1837 hacc ht hsg hno hpc hJ (hnb · · (by simp)) hm.1 (Or.inl hm.2)
      (fun h => Or.inr (Or.inl (by rw [hm.2]; exact h)))

theorem J1837_start {s : State V} (h0 : s.pc = 0) : J1837 d s := Or.inl (by omega)

theorem Phi1837_start {s : State V} (h0 : s.pc = 0) :
    Phi1837 d s ≤ (s.wheels.getD 0 + 1) * (d.length + 1) := by
  unfold Phi1837; rw [h0, Nat.add_mul, Nat.one_mul]
  split <;> omega

/-- **A halting run passes its cards in one loop.** The number of cards a
halting run from `s` passes is at most `Phi1837 d s`: with `w` on the wheels at
the first card, at most (w + 1)(L + 1). -/
theorem halt_within_1837 {A : Arith V} :
    ∀ (n : Nat) (s s' : State V), J1837 d s → run A d n s = .halt s' →
      run A d (Phi1837 d s + 1) s = .halt s' := by
  intro n
  induction n with
  | zero => intro s s' _ h; simp [run] at h
  | succ n ih =>
    intro s s' hJ h
    simp only [run] at h ⊢
    cases hst : step A d s with
    | run s1 =>
      rw [hst] at h; simp only at h
      obtain ⟨hJ1, hlt⟩ := step_1837 hacc ht hsg hno hJ hst
      have h1 := ih s1 s' hJ1 h
      obtain ⟨e, he⟩ : ∃ e, Phi1837 d s = (Phi1837 d s1 + 1) + e :=
        ⟨_, (Nat.add_sub_of_le hlt).symm⟩
      simp only
      rw [he, run_add, h1]
    | halt s1 => rw [hst] at h; exact h
    | err => rw [hst] at h; cases h

/-- Every number given off is within `it g (Phi1837 d s) X`, for any measure of
the state that one card takes from `X` to within `g X`. -/
theorem out_le_it_1837 {A : Arith V} (sz : V → Nat) (g : Nat → Nat) (hg : ∀ x, x ≤ g x)
    (P : Nat → State V → Prop)
    (hP : ∀ X (s s' : State V), P X s → step A d s = .run s' → P (g X) s')
    (hout : ∀ X (s : State V), P X s → ∀ v ∈ s.out, sz v ≤ X) :
    ∀ (n : Nat) (s s' : State V) (X : Nat), J1837 d s → P X s → run A d n s = .halt s' →
      ∀ v ∈ s'.out, sz v ≤ it g (Phi1837 d s) X := by
  intro n
  induction n with
  | zero => intro s s' X _ _ h; simp [run] at h
  | succ n ih =>
    intro s s' X hJ hPs h
    simp only [run] at h
    cases hst : step A d s with
    | run s1 =>
      rw [hst] at h; simp only at h
      obtain ⟨hJ1, hlt⟩ := step_1837 hacc ht hsg hno hJ hst
      intro v hv
      have := ih s1 s' (g X) hJ1 (hP X s s1 hPs hst) h v hv
      rw [← it_succ'] at this
      exact Nat.le_trans this (it_le_it hg X hlt)
    | halt s1 =>
      rw [hst] at h; cases h
      obtain ⟨rfl, _⟩ := step_halt_eq hst
      intro v hv
      exact Nat.le_trans (hout X _ hPs v hv) (it_infl hg _ X)
    | err => rw [hst] at h; cases h

end

/-! ## Models A and B in December 1837 -/

theorem no_always_of_halt {A : Arith V} {d : Deck} {c : Config} (hacc : Accepts c d)
    {s s' : State V} (h0 : s.pc = 0) {n : Nat} (hrun : run A d n s = .halt s') :
    ∀ (i t : Nat), d[i]? ≠ some (Card.back t false) := fun i t hi =>
  never_halts_from_start (backward_of_accepts hacc) hi s h0 ⟨n, s', hrun⟩

/-- **The growth bound of December 1837, model A.** With repetition counts from
number cards, a deck of a configuration whose backing goes only to the first
card, started from numbers within X ≥ 2 (the wheels and the number cards
included), gives off nothing larger than 2^2^(X + 3^(K+1)(X + 1)(L + 1)). -/
theorem out_le_dexp_1837 {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (ht : c.anyTarget = false) (hsg : c.setInGroup = false)
    (hl : LitsLe A S K d) (hc : ConstReps d) {s : State V} (hs : Inv A S K X s)
    (h0 : s.pc = 0) {n : Nat} {s' : State V} (hrun : run A d n s = .halt s') :
    ∀ v ∈ s'.out, S.sz v ≤ tw 2 (X + 3 ^ (K + 1) * ((X + 1) * (d.length + 1))) := by
  have hno := no_always_of_halt hacc h0 hrun
  intro v hv
  have h1 := out_le_it_1837 hacc ht hsg hno S.sz (grow K) (le_grow K) (Inv A S K)
    (fun X s s' hi hst => step_inv S hl hc hi hst) (fun X s hi => hi.out)
    n s s' X (J1837_start hacc ht hsg hno h0) hs hrun v hv
  have hphi : Phi1837 d s ≤ (X + 1) * (d.length + 1) :=
    Nat.le_trans (Phi1837_start hacc ht hsg hno h0) (Nat.mul_le_mul_right _ (by have := hs.wheels; omega))
  exact Nat.le_trans h1 (Nat.le_trans (it_le_it (le_grow K) X hphi) (it_grow_le K _ X))

/-- **The growth bound of December 1837, model B.** With repetition counts from
the store, nothing larger than a tetration of height X + 5(X + 1)(L + 1). -/
theorem out_le_tet_1837 {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (ht : c.anyTarget = false) (hsg : c.setInGroup = false)
    (hl : LitsLe A S K d) {s : State V} (hs : Inv A S K X s)
    (h0 : s.pc = 0) {n : Nat} {s' : State V} (hrun : run A d n s = .halt s') :
    ∀ v ∈ s'.out, S.sz v ≤ tet (X + 5 * ((X + 1) * (d.length + 1))) := by
  have hno := no_always_of_halt hacc h0 hrun
  intro v hv
  have h1 := out_le_it_1837 hacc ht hsg hno S.sz growS le_growS (Inv A S K)
    (fun X s s' hi hst => step_invS S hl hi hst) (fun X s hi => hi.out)
    n s s' X (J1837_start hacc ht hsg hno h0) hs hrun v hv
  have hphi : Phi1837 d s ≤ (X + 1) * (d.length + 1) :=
    Nat.le_trans (Phi1837_start hacc ht hsg hno h0) (Nat.mul_le_mul_right _ (by have := hs.wheels; omega))
  refine Nat.le_trans h1 (Nat.le_trans (it_le_it le_growS X hphi) ?_)
  refine Nat.le_trans (it_growS_le _ X) (Nat.le_trans (tw_le_tet _ _) (tet_mono ?_))
  omega

/-- a·n < 2ⁿ once n ≥ 2a. -/
theorem lin_lt_two_pow (a n : Nat) (h : 2 * a ≤ n) : a * n < 2 ^ n := by
  obtain ⟨m, rfl⟩ : ∃ m, n = a + m := ⟨n - a, by omega⟩
  have hm : a + m ≤ 2 ^ m := Nat.le_trans (by omega) (two_mul_le_two_pow m)
  calc a * (a + m) ≤ a * 2 ^ m := Nat.mul_le_mul_left _ hm
    _ < 2 ^ a * 2 ^ m := Nat.mul_lt_mul_of_pos_right Nat.lt_two_pow_self (Nat.two_pow_pos m)
    _ = 2 ^ (a + m) := (Nat.pow_add 2 a m).symm

theorem pow2_lt {x y : Nat} (h : x < y) : 2 ^ x < 2 ^ y := by
  have h1 : 2 ^ (x + 1) ≤ 2 ^ y := Nat.pow_le_pow_right (by omega) h
  have h2 := Nat.two_pow_pos x
  rw [Nat.pow_succ] at h1
  omega

theorem tw2_lt {x y : Nat} (h : x < y) : tw 2 x < tw 2 y := by
  show 2 ^ 2 ^ x < 2 ^ 2 ^ y
  exact pow2_lt (pow2_lt h)

/-- (n + K₀ + 1)·b + n + K₀ ≤ ((b + 1)(K₀ + 2))·n, for n ≥ 1. -/
theorem lin_bound (n K₀ b : Nat) (hn : 1 ≤ n) :
    n + K₀ + b * (n + K₀ + 1) ≤ (b + 1) * (K₀ + 2) * n := by
  have e2 : n + K₀ + 1 ≤ n * (K₀ + 2) := by
    rw [Nat.mul_add, Nat.mul_two]
    have : K₀ ≤ n * K₀ := Nat.le_mul_of_pos_left K₀ (by omega)
    omega
  have h1 : b * (n + K₀ + 1) ≤ b * (n * (K₀ + 2)) := Nat.mul_le_mul_left _ e2
  rw [Nat.mul_assoc, Nat.mul_comm (K₀ + 2) n, Nat.add_mul, Nat.one_mul]
  omega

/-- **No 2^2^2^n in December 1837, model A.** With input n, and every number
of the state within n + K₀ at the first card: from some N on, every halting
run gives off only numbers smaller than 2^2^2^n. -/
theorem no_triple_exp_1837 {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (ht : c.anyTarget = false) (hsg : c.setInGroup = false)
    (hl : LitsLe A S K d) (hc : ConstReps d) (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ N, ∀ n, N ≤ n → ∀ k (s' : State V), run A d k (init n) = .halt s' →
      ∀ v ∈ s'.out, S.sz v < tw 3 n := by
  obtain ⟨b, hb⟩ : ∃ b, b = 3 ^ (K + 1) * (d.length + 1) := ⟨_, rfl⟩
  obtain ⟨a, ha⟩ : ∃ a, a = (b + 1) * (K₀ + 2) := ⟨_, rfl⟩
  refine ⟨2 * a + 1, fun n hn k s' hrun v hv => ?_⟩
  have h := out_le_dexp_1837 S hacc ht hsg hl hc (hinit n) (h0 n) hrun v hv
  have e1 : 3 ^ (K + 1) * ((n + K₀ + 1) * (d.length + 1)) = b * (n + K₀ + 1) := by
    rw [hb, Nat.mul_assoc, Nat.mul_comm (n + K₀ + 1)]
  rw [e1] at h
  have hin := lin_bound n K₀ b (by omega)
  rw [← ha] at hin
  have hlt : a * n < 2 ^ n := lin_lt_two_pow a n (by omega)
  show S.sz v < tw 2 (2 ^ n)
  exact Nat.lt_of_le_of_lt h (tw2_lt (by omega))

/-! ## Model A in May 1838: two loops, one after the other -/

/-- `f` applied `k` times. -/
def itI (f : Int → Int) : Nat → Int → Int
  | 0, x => x
  | k + 1, x => itI f k (f x)

theorem itI_dbl : ∀ (k : Nat) (x : Int), itI (fun x => x + x) k x = x * 2 ^ k := by
  intro k
  induction k with
  | zero => intro x; simp [itI]
  | succ k ih =>
    intro x
    simp only [itI, ih, Int.pow_succ, ← Int.two_mul x]
    rw [Int.mul_comm (2 ^ k) 2, Int.mul_left_comm, Int.mul_assoc]

theorem itI_sq : ∀ (k : Nat) (z : Int), itI (fun z => z * z) k z = z ^ (2 ^ k) := by
  intro k
  induction k with
  | zero => intro z; simp [itI, Int.pow_one]
  | succ k ih =>
    intro z
    simp only [itI, ih, Int.mul_pow, Nat.pow_succ, Nat.mul_two, Int.pow_add]

/-- Two cards `dst := f dst; back to the first counted`, with w + 1 on the wheels. -/
theorem loop2 {d : Deck} {p j : Nat} {o : Op} {f : Int → Int}
    (h1 : d[p]? = some (.op o (.col j) (.col j) j)) (h2 : d[p + 1]? = some (.back p true))
    (hf : ∀ x, intOp o x x = some (f x)) :
    ∀ (w : Nat) (st : Nat → Int) (out : List Int), ∃ st' : Nat → Int,
      st' j = itI f (w + 1) (st j) ∧ (∀ i, i ≠ j → st' i = st i) ∧
      run intArith d (2 * (w + 1)) ⟨p, st, some (w + 1), out⟩ = .run ⟨p + 2, st', some 0, out⟩ := by
  intro w
  induction w with
  | zero =>
    intro st out
    refine ⟨upd st j (f (st j)), by simp [upd, itI], fun i hi => by simp [upd, hi], ?_⟩
    simp [run, step, h1, h2, fetch, hf]
  | succ w ih =>
    intro st out
    obtain ⟨st', hj, hi, hr⟩ := ih (upd st j (f (st j))) out
    refine ⟨st', by rw [hj]; simp [upd, itI], fun i hne => by rw [hi i hne]; simp [upd, hne], ?_⟩
    rw [show 2 * (w + 1 + 1) = 2 + 2 * (w + 1) by omega, run_add]
    simp [run, step, h1, h2, fetch, hf]
    exact hr

/-- `pass: + v1 v1 > v1; back pass counted; set v1; sq: × v2 v2 > v2;
back sq counted; result v2`: with n on the wheels, 1 in v1 and 2 in v2, the
first loop makes 2ⁿ and the second squares 2 that many times. -/
def tripleDeck : Deck :=
  [.op .add (.col 1) (.col 1) 1, .back 0 true, .set (.col 1),
   .op .mul (.col 2) (.col 2) 2, .back 3 true, .result 2]

theorem tripleDeck_accepted : Accepts c1838 tripleDeck := by
  intro i card h
  match i, h with
  | 0, h | 2, h | 3, h | 5, h => simp [tripleDeck] at h; subst h; trivial
  | 1, h =>
    simp [tripleDeck] at h; subst h
    refine ⟨rfl, by omega, Or.inl rfl, fun _ _ j card' _ hj hj' => ?_⟩
    match j, hj with
    | 0, _ => simp [tripleDeck] at hj'; subst hj'; rfl
  | 4, h =>
    simp [tripleDeck] at h; subst h
    refine ⟨rfl, by omega, Or.inl rfl, fun _ _ j card' hj1 hj hj' => ?_⟩
    match j, hj1, hj with
    | 3, _, _ => simp [tripleDeck] at hj'; subst hj'; rfl
  | i + 6, h => simp [tripleDeck] at h

/-- Its second backing goes to card 3, so December 1837 refuses it. -/
theorem tripleDeck_refused_1837 : ¬ Accepts c1837 tripleDeck := by
  intro h
  have := (h 4 (.back 3 true) (by simp [tripleDeck])).2.2.1
  simp [c1837] at this

theorem tripleDeck_constReps : ConstReps tripleDeck := by
  intro i o c b n h
  match i, h with
  | 0, h | 1, h | 2, h | 3, h | 4, h | 5, h => simp [tripleDeck] at h
  | i + 6, h => simp [tripleDeck] at h

theorem tw3_eq (n : Nat) : tw 3 n = 2 ^ 2 ^ 2 ^ n := rfl

/-- **2^2^2^n in May 1838, model A.** For every n ≥ 1 on the wheels, the deck
halts with the single result 2^2^2^n. -/
theorem triple_halts_1838 (n : Nat) (hn : 1 ≤ n) :
    ∃ k st', run intArith tripleDeck k ⟨0, fun j => if j = 1 then 1 else if j = 2 then 2 else 0,
      some n, []⟩ = .halt ⟨6, st', some 0, [((tw 3 n : Nat) : Int)]⟩ := by
  obtain ⟨w, rfl⟩ : ∃ w, n = w + 1 := ⟨n - 1, by omega⟩
  obtain ⟨st1, h11, h1o, hr1⟩ := loop2 (d := tripleDeck) (p := 0) (j := 1) (o := .add)
    (f := fun x => x + x) (by simp [tripleDeck]) (by simp [tripleDeck]) (fun x => rfl) w
    (fun j => if j = 1 then 1 else if j = 2 then 2 else 0) []
  rw [itI_dbl] at h11
  simp only [ite_true, Int.one_mul] at h11
  have h12 : st1 2 = 2 := by rw [h1o 2 (by omega)]; simp
  obtain ⟨m, hm⟩ : ∃ m, 2 ^ (w + 1) = m + 1 := ⟨2 ^ (w + 1) - 1, by have := Nat.two_pow_pos (w + 1); omega⟩
  obtain ⟨st2, h22, _, hr2⟩ := loop2 (d := tripleDeck) (p := 3) (j := 2) (o := .mul)
    (f := fun z => z * z) (by simp [tripleDeck]) (by simp [tripleDeck]) (fun x => rfl) m st1 []
  rw [itI_sq, h12, ← hm] at h22
  refine ⟨2 * (w + 1) + (1 + (2 * (m + 1) + 2)), st2, ?_⟩
  rw [run_add, hr1]
  simp only
  rw [run_add]
  have hset : run intArith tripleDeck 1 ⟨2, st1, some 0, []⟩ = .run ⟨3, st1, some (m + 1), []⟩ := by
    have : intCount (st1 1) = some (m + 1) := by
      rw [h11, ← hm]; exact intCount_nat _
    simp [run, step, tripleDeck, fetch, this]
  rw [hset]
  simp only
  rw [run_add, hr2]
  simp only
  have : ((2 : Int) ^ 2 ^ 2 ^ (w + 1)) = ((tw 3 (w + 1) : Nat) : Int) := by
    rw [tw3_eq]; simp [Int.natCast_pow]
  simp [run, step, tripleDeck, h22, this]

/-! ## Model B: December 1837 against May 1838 -/

theorem tet_lt {x y : Nat} (h : x < y) : tet x < tet y :=
  Nat.lt_of_lt_of_le (tet_le_succ x) (tet_mono h)

/-- **No 2↑↑2ⁿ in December 1837, model B.** With repetition counts from the
store, from some N on, every halting run gives off only numbers smaller than
2↑↑2ⁿ. -/
theorem no_tet_exp_1837 {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (ht : c.anyTarget = false) (hsg : c.setInGroup = false)
    (hl : LitsLe A S K d) (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ N, ∀ n, N ≤ n → ∀ k (s' : State V), run A d k (init n) = .halt s' →
      ∀ v ∈ s'.out, S.sz v < tet (2 ^ n) := by
  obtain ⟨b, hb⟩ : ∃ b, b = 5 * (d.length + 1) := ⟨_, rfl⟩
  obtain ⟨a, ha⟩ : ∃ a, a = (b + 1) * (K₀ + 2) := ⟨_, rfl⟩
  refine ⟨2 * a + 1, fun n hn k s' hrun v hv => ?_⟩
  have h := out_le_tet_1837 S hacc ht hsg hl (hinit n) (h0 n) hrun v hv
  have e1 : 5 * ((n + K₀ + 1) * (d.length + 1)) = b * (n + K₀ + 1) := by
    rw [hb, Nat.mul_assoc, Nat.mul_comm (n + K₀ + 1)]
  rw [e1] at h
  have hin := lin_bound n K₀ b (by omega)
  rw [← ha] at hin
  have hlt : a * n < 2 ^ n := lin_lt_two_pow a n (by omega)
  exact Nat.lt_of_le_of_lt h (tet_lt (by omega))

/-- `pass: + v1 v1 > v1; back pass counted; set v1; tower: × v3 0 > v3;
+ v3 1 > v3; repeat × v3 2 times v4; + v3 0 > v4; back tower counted;
result v4`: the first loop makes 2ⁿ, and the second is the pass of
`tower-halting`, made 2ⁿ times. -/
def tetDeck : Deck :=
  [.op .add (.col 1) (.col 1) 1, .back 0 true, .set (.col 1),
   .op .mul (.col 3) (.num 0) 3, .op .add (.col 3) (.num 1) 3,
   .rep .mul 3 (.num 2) (.col 4), .op .add (.col 3) (.num 0) 4,
   .back 3 true, .result 4]

theorem tetDeck_accepted : Accepts c1838 tetDeck := by
  intro i card h
  match i, h with
  | 0, h | 2, h | 3, h | 4, h | 5, h | 6, h | 8, h =>
    simp [tetDeck] at h; subst h; trivial
  | 1, h =>
    simp [tetDeck] at h; subst h
    refine ⟨rfl, by omega, Or.inl rfl, fun _ _ j card' _ hj hj' => ?_⟩
    match j, hj with
    | 0, _ => simp [tetDeck] at hj'; subst hj'; rfl
  | 7, h =>
    simp [tetDeck] at h; subst h
    refine ⟨rfl, by omega, Or.inl rfl, fun _ _ j card' hj1 hj hj' => ?_⟩
    match j, hj1, hj with
    | 3, _, _ | 4, _, _ | 5, _, _ | 6, _, _ => simp [tetDeck] at hj'; subst hj'; rfl
  | i + 9, h => simp [tetDeck] at h

theorem tetPass (x : Nat) (st : Nat → Int) (h4 : st 4 = x) (w : Nat) (out : List Int) :
    ∃ st', st' 4 = ((2 ^ x : Nat) : Int) ∧
      run intArith tetDeck 4 ⟨3, st, some (w + 1), out⟩ = .run ⟨7, st', some (w + 1), out⟩ := by
  refine ⟨upd (upd (upd (upd st 3 0) 3 1) 3 (2 ^ x)) 4 (2 ^ x), by simp [upd], ?_⟩
  simp [run, step, tetDeck, fetch, intOp, upd, h4, iter_mul_two]

theorem tetLoop (w : Nat) : ∀ (x : Nat) (st : Nat → Int) (out : List Int), st 4 = x →
    ∃ n st' wh, run intArith tetDeck n ⟨3, st, some (w + 1), out⟩ =
      .halt ⟨9, st', wh, out ++ [((exp2 (w + 1) x : Nat) : Int)]⟩ := by
  induction w with
  | zero =>
    intro x st out h4
    obtain ⟨st', h4', hr⟩ := tetPass x st h4 0 out
    refine ⟨4 + 3, st', some 0, ?_⟩
    rw [run_add, hr]
    simp [run, step, tetDeck, h4', exp2]
  | succ w ih =>
    intro x st out h4
    obtain ⟨st', h4', hr⟩ := tetPass x st h4 (w + 1) out
    obtain ⟨n, st'', wh, hn⟩ := ih (2 ^ x) st' out h4'
    refine ⟨4 + (1 + n), st'', wh, ?_⟩
    rw [run_add, hr]
    simp only
    rw [run_add]
    simp only [run, step]
    simp only [tetDeck] at hn ⊢
    simpa [exp2] using hn

/-- **2↑↑2ⁿ in May 1838, model B.** For every n ≥ 1 on the wheels, the deck
halts with the single result 2↑↑2ⁿ. -/
theorem tet_exp_halts_1838 (n : Nat) (hn : 1 ≤ n) :
    ∃ k st' wh, run intArith tetDeck k ⟨0, fun j => if j = 1 then 1 else if j = 4 then 1 else 0, some n, []⟩ =
      .halt ⟨9, st', wh, [((tet (2 ^ n) : Nat) : Int)]⟩ := by
  obtain ⟨w, rfl⟩ : ∃ w, n = w + 1 := ⟨n - 1, by omega⟩
  obtain ⟨st1, h11, h1o, hr1⟩ := loop2 (d := tetDeck) (p := 0) (j := 1) (o := .add)
    (f := fun x => x + x) (by simp [tetDeck]) (by simp [tetDeck]) (fun x => rfl) w
    (fun j => if j = 1 then 1 else if j = 4 then 1 else 0) []
  rw [itI_dbl] at h11
  simp only [ite_true, Int.one_mul] at h11
  have h14 : st1 4 = ((1 : Nat) : Int) := by rw [h1o 4 (by omega)]; simp
  obtain ⟨m, hm⟩ : ∃ m, 2 ^ (w + 1) = m + 1 :=
    ⟨2 ^ (w + 1) - 1, by have := Nat.two_pow_pos (w + 1); omega⟩
  obtain ⟨k, st2, wh, hr2⟩ := tetLoop m 1 st1 [] h14
  refine ⟨2 * (w + 1) + (1 + k), st2, wh, ?_⟩
  rw [run_add, hr1]
  simp only
  rw [run_add]
  have hset : run intArith tetDeck 1 ⟨2, st1, some 0, []⟩ = .run ⟨3, st1, some (m + 1), []⟩ := by
    have : intCount (st1 1) = some (m + 1) := by
      rw [h11, ← hm]; exact intCount_nat _
    simp [run, step, tetDeck, fetch, this]
  rw [hset]
  simp only
  rw [hr2, ← hm, tet_eq_exp2]
  rfl

end Babbage
