import Babbage.Termination

/-!
# Growth (the corrected argument C of `docs/expressiveness.md`)

Take a deck accepted by a configuration of the pages, with no unconditional
backing card (a deck that halts from its first card has none:
`never_halts_from_start`), and in which every repetition count is a number
card. Then every number it gives off is bounded by a tower of exponentials
whose height depends only on the deck (`out_le_tower`), and so the deck does
not give 2↑↑n for every n (`no_tetration`).

The numbers are any `Arith` with a size such that one operation of the mill
makes nothing larger than the cube of the larger operand (or of 2), and a
count is no larger than the size of the number it is read from. Whole numbers
are such (`intSized` in `Separation.lean`), and so, with size the larger of
numerator and denominator, are exact fractions (`ratSized` in `RatSize.lean`).

"Repetition counts are number cards" (`ConstReps`) restricts only `rep`
cards: a combinatorial card may still put a computed number on the wheels.
-/

namespace Babbage

variable {V : Type}

structure Sized (A : Arith V) where
  sz : V → Nat
  op_le : ∀ o x y r, A.op o x y = some r → sz r ≤ (max (max (sz x) (sz y)) 2) ^ 3
  count_le : ∀ v n, A.count v = some n → n ≤ sz v

def srcs : Card → List Src
  | .op _ a b _ => [a, b]
  | .rep _ _ b n => [b, n]
  | .set s => [s]
  | _ => []

/-- Every number card in the deck has size at most `K`. -/
def LitsLe (A : Arith V) (S : Sized A) (K : Nat) (d : Deck) : Prop :=
  ∀ (i : Nat) card, d[i]? = some card → ∀ v, Src.num v ∈ srcs card → S.sz (A.lit v) ≤ K

/-- Every repetition count is a number card, not a store column. -/
def ConstReps (d : Deck) : Prop :=
  ∀ (i : Nat) o c b n, d[i]? = some (Card.rep o c b n) → ∃ v, n = .num v

/-- Every number in the state, the wheels and the number cards within `X`. -/
structure Inv (A : Arith V) (S : Sized A) (K X : Nat) (s : State V) : Prop where
  two : 2 ≤ X
  lits : K ≤ X
  store : ∀ j, S.sz (s.store j) ≤ X
  wheels : s.wheels.getD 0 ≤ X
  out : ∀ v ∈ s.out, S.sz v ≤ X

/-- What one card can make of numbers within `X`. -/
def grow (K X : Nat) : Nat := X ^ (3 ^ (K + 1))

theorem le_grow (K X : Nat) : X ≤ grow K X := by
  unfold grow
  rcases Nat.eq_zero_or_pos X with h | h
  · subst h; simp
  · calc X = X ^ 1 := (Nat.pow_one X).symm
      _ ≤ X ^ (3 ^ (K + 1)) := Nat.pow_le_pow_right h (Nat.one_le_pow _ _ (by omega))

theorem grow_mono (K : Nat) {X Y : Nat} (h : X ≤ Y) : grow K X ≤ grow K Y :=
  Nat.pow_le_pow_left h _

theorem iter_le {A : Arith V} (S : Sized A) {o : Op} {b : V} :
    ∀ (k : Nat) (x r : V) (Y : Nat), 2 ≤ Y → S.sz x ≤ Y → S.sz b ≤ Y →
      iter A o b k x = some r → S.sz r ≤ Y ^ (3 ^ k)
  | 0, x, r, Y, _, hx, _, h => by simp [iter] at h; subst h; simpa using hx
  | k + 1, x, r, Y, h2, hx, hb, h => by
    simp only [iter] at h
    cases hop : A.op o x b with
    | none => simp [hop] at h
    | some y =>
      simp only [hop, Option.bind_some] at h
      have hy : S.sz y ≤ Y ^ 3 := by
        refine Nat.le_trans (S.op_le _ _ _ _ hop) (Nat.pow_le_pow_left ?_ 3)
        exact Nat.max_le.mpr ⟨Nat.max_le.mpr ⟨hx, hb⟩, h2⟩
      have hY3 : Y ≤ Y ^ 3 := by
        calc Y = Y ^ 1 := (Nat.pow_one Y).symm
          _ ≤ Y ^ 3 := Nat.pow_le_pow_right (by omega) (by omega)
      have := iter_le S k y r (Y ^ 3) (Nat.le_trans h2 hY3) hy (Nat.le_trans hb hY3) h
      rwa [← Nat.pow_mul, Nat.mul_comm, ← Nat.pow_succ] at this

theorem fetch_le {A : Arith V} {S : Sized A} {K X : Nat} {d : Deck} {s : State V}
    (hl : LitsLe A S K d) (hi : Inv A S K X s) {card : Card} (hget : d[s.pc]? = some card)
    {src : Src} (hs : src ∈ srcs card) : S.sz (fetch A s src) ≤ X := by
  cases src with
  | col j => exact hi.store j
  | num v => exact Nat.le_trans (hl _ _ hget v hs) hi.lits

theorem upd_le {f : Nat → V} {g : V → Nat} {X : Nat} (hf : ∀ j, g (f j) ≤ X) {i : Nat} {v : V}
    (hv : g v ≤ X) : ∀ j, g (upd f i v j) ≤ X := by
  intro j; unfold upd; split
  · exact hv
  · exact hf j

/-- One card: every number stays within `grow K X`. -/
theorem step_inv {A : Arith V} (S : Sized A) {K X : Nat} {d : Deck} (hl : LitsLe A S K d)
    (hc : ConstReps d) {s s' : State V} (hi : Inv A S K X s) (hstep : step A d s = .run s') :
    Inv A S K (grow K X) s' := by
  have hX := le_grow K X
  obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card := by
    cases h : d[s.pc]? with
    | none => simp [step, h] at hstep
    | some card => exact ⟨card, rfl⟩
  have base : ∀ j, S.sz (s.store j) ≤ grow K X := fun j => Nat.le_trans (hi.store j) hX
  have hX2 : 2 ≤ X := hi.two
  have cube : ∀ y : Nat, y ≤ X ^ 3 → y ≤ grow K X := by
    intro y hy
    refine Nat.le_trans hy (Nat.pow_le_pow_right (by omega) ?_)
    calc 3 = 3 ^ 1 := rfl
      _ ≤ 3 ^ (K + 1) := Nat.pow_le_pow_right (by omega) (by omega)
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
        obtain ⟨v, rfl⟩ := hc _ _ _ _ _ hget
        have hkK : k ≤ K := Nat.le_trans (S.count_le _ _ hk)
          (hl _ _ hget v (by simp [srcs]))
        have hb := fetch_le hl hi hget (src := b) (by simp [srcs])
        have hr' := iter_le S k _ r X hX2 (hi.store col) hb hr
        have : X ^ (3 ^ k) ≤ grow K X :=
          Nat.pow_le_pow_right (by omega) (Nat.pow_le_pow_right (by omega) (by omega))
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

/-! ## Cards passed within a phase -/

/-- At most this many cards pass before the next combinatorial card. -/
def phi (d : Deck) (s : State V) : Nat :=
  s.wheels.getD 0 * (d.length + 1) + (d.length - s.pc)

theorem phi_step {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    {s s' : State V} (hstep : step A d s = .run s') :
    (∃ src, d[s.pc]? = some (Card.set src)) ∨ phi d s' + 1 ≤ phi d s := by
  obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card := by
    cases h : d[s.pc]? with
    | none => simp [step, h] at hstep
    | some card => exact ⟨card, rfl⟩
  have hlen : s.pc < d.length := (List.getElem?_eq_some_iff.mp hget).1
  have hm := step_moves hget hstep
  unfold phi
  cases card with
  | set src => exact Or.inl ⟨src, hget⟩
  | op => simp [Moves] at hm; right; rw [hm.1, hm.2]; omega
  | rep => simp [Moves] at hm; right; rw [hm.1, hm.2]; omega
  | result => simp [Moves] at hm; right; rw [hm.1, hm.2]; omega
  | back t counted =>
    cases counted with
    | false => exact absurd hget (hno _ _)
    | true =>
      right
      have hti := (backward_of_accepts hacc) _ _ _ hget
      rcases hm with ⟨hpc, w, hw, hw'⟩ | ⟨hpc, hw, hw'⟩
      · rw [hpc, hw, hw']; simp only [Option.getD_some]
        rw [Nat.succ_mul (w + 1)]; omega
      · rw [hpc, hw, hw']; simp only [Option.getD_some]; omega

theorem phi_set {A : Arith V} (S : Sized A) {K X : Nat} {d : Deck} {s : State V}
    (hi : Inv A S K X s) : phi d s ≤ X * (d.length + 1) + d.length := by
  unfold phi
  have := Nat.mul_le_mul_right (d.length + 1) hi.wheels
  omega

/-! ## The bound through a run -/

/-- A bound for what a run can give off from a state within `X`, with `a`
combinatorial cards ahead and at most `m` cards before the next. -/
def Q (g : Nat → Nat) (L : Nat) : Nat → Nat → Nat → Nat
  | _, 0, X => X
  | 0, m + 1, X => Q g L 0 m (g X)
  | a + 1, m + 1, X => max (Q g L (a + 1) m (g X)) (Q g L a (g X * (L + 1) + L) (g X))
termination_by a m _ => (a, m)

theorem Q_ge (g : Nat → Nat) (hg : ∀ x, x ≤ g x) (L : Nat) :
    ∀ m a X, X ≤ Q g L a m X := by
  intro m
  induction m with
  | zero => intro a X; cases a <;> simp [Q]
  | succ m ih =>
    intro a X
    cases a with
    | zero => rw [Q]; exact Nat.le_trans (hg X) (ih 0 _)
    | succ a => rw [Q]; exact Nat.le_trans (Nat.le_trans (hg X) (ih (a + 1) _)) (Nat.le_max_left _ _)

theorem setsFrom_le_of_step {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    {s s' : State V} (hstep : step A d s = .run s') : setsFrom d s'.pc ≤ setsFrom d s.pc := by
  rcases step_measure hacc hsg hno hstep with h | ⟨h, _⟩ | ⟨h, _⟩ <;> omega

theorem step_halt_eq {A : Arith V} {d : Deck} {s s' : State V} (h : step A d s = .halt s') :
    s' = s ∧ d.length ≤ s.pc := by
  cases hg : d[s.pc]? with
  | none =>
    simp [step, hg] at h
    exact ⟨h.symm, List.getElem?_eq_none_iff.mp hg⟩
  | some card =>
    unfold step at h; rw [hg] at h
    cases card with
    | op => simp only at h; split at h <;> cases h
    | rep => simp only at h; split at h; · cases h
             · split at h <;> cases h
    | set => simp only at h; split at h <;> cases h
    | back t counted => cases counted <;> simp only at h <;> (try split at h) <;> cases h
    | result => cases h

theorem out_le_Q {A : Arith V} (S : Sized A) {c : Config} {K : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) (hl : LitsLe A S K d)
    (hc : ConstReps d) :
    ∀ n a m X (s s' : State V), Inv A S K X s → setsFrom d s.pc ≤ a → phi d s ≤ m →
      run A d n s = .halt s' → ∀ v ∈ s'.out, S.sz v ≤ Q (grow K) d.length a m X := by
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
      exact Nat.le_trans (hi.out v hv) (Q_ge _ (le_grow K) _ m a X)
    | run s'' =>
      rw [hstep] at h
      simp only at h
      have hi' := step_inv S hl hc hi hstep
      have hlt := pc_lt_of_run hstep
      rcases phi_step hacc hno (A := A) hstep with ⟨src, hset⟩ | hphi
      · -- a combinatorial card: one fewer ahead, and a new phase
        have hsf := setsFrom_of_get hset
        simp [isSet] at hsf
        have hm' := step_moves hset hstep
        simp [Moves] at hm'
        obtain ⟨a', rfl⟩ : ∃ a', a = a' + 1 := ⟨a - 1, by omega⟩
        obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by unfold phi at hm; omega⟩
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

end Babbage
