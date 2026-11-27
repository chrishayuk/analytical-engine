import Babbage.Machine

/-!
# Termination (arguments A and B of `docs/expressiveness.md`)

For a deck accepted by a configuration of the pages (no combinatorial card
among the cards a counted backing repeats):

* `never_halts_of_always`: if the deck has an unconditional backing card, no
  run that starts at or before it halts.
* `ends_of_counted`: if every backing card is counted, every run ends: it
  halts, or an operation of the mill fails.

The numbers are any `Arith`: the argument does not look at them.
-/

namespace Babbage

variable {V : Type}

/-- The combinatorial cards at or after card `p`. -/
def setsIn : List Card → Nat
  | [] => 0
  | c :: cs => (if isSet c then 1 else 0) + setsIn cs

def setsFrom (d : Deck) (p : Nat) : Nat := setsIn (d.drop p)

theorem drop_eq_cons {α : Type} :
    ∀ (d : List α) (p : Nat) (c : α), d[p]? = some c → d.drop p = c :: d.drop (p + 1)
  | [], p, c, h => by simp at h
  | x :: xs, 0, c, h => by simp at h; simp [h]
  | _ :: xs, p + 1, c, h => by
    simp only [List.getElem?_cons_succ] at h
    simpa using drop_eq_cons xs p c h

theorem setsFrom_of_get {d : Deck} {p : Nat} {c : Card} (h : d[p]? = some c) :
    setsFrom d p = (if isSet c then 1 else 0) + setsFrom d (p + 1) := by
  simp [setsFrom, drop_eq_cons d p c h, setsIn]

theorem setsFrom_succ {d : Deck} {p : Nat} {c : Card} (h : d[p]? = some c)
    (hc : isSet c = false) : setsFrom d (p + 1) = setsFrom d p := by
  rw [setsFrom_of_get h, hc]; simp

theorem setsFrom_span {d : Deck} {t : Nat} :
    ∀ (k i : Nat), i = t + k → i < d.length →
    (∀ j card, t ≤ j → j < i → d[j]? = some card → isSet card = false) →
    setsFrom d t = setsFrom d i
  | 0, i, he, _, _ => by subst he; rfl
  | k + 1, i, he, hi, h => by
    have hi' : t + k < d.length := by omega
    have hget : d[t + k]? = some d[t + k] := List.getElem?_eq_getElem hi'
    rw [setsFrom_span k (t + k) rfl hi' (fun j card h1 h2 h3 => h j card h1 (by omega) h3), he,
      ← Nat.add_assoc, setsFrom_succ hget (h (t + k) d[t + k] (by omega) (by omega) hget)]

/-- What one card does to the card number and the wheels. -/
def Moves (card : Card) (s s' : State V) : Prop :=
  match card with
  | .back t false => s'.pc = t ∧ s'.wheels = s.wheels
  | .back t true =>
    (s'.pc = t ∧ ∃ w, s.wheels = some (w + 2) ∧ s'.wheels = some (w + 1)) ∨
    (s'.pc = s.pc + 1 ∧ s.wheels = some 1 ∧ s'.wheels = some 0)
  | .set _ => s'.pc = s.pc + 1
  | _ => s'.pc = s.pc + 1 ∧ s'.wheels = s.wheels

theorem step_moves {A : Arith V} {d : Deck} {s s' : State V} {card : Card}
    (hget : d[s.pc]? = some card) (hstep : step A d s = .run s') : Moves card s s' := by
  unfold step at hstep
  rw [hget] at hstep
  cases card with
  | op o a b dst =>
    simp only at hstep
    split at hstep
    · cases hstep; exact ⟨rfl, rfl⟩
    · cases hstep
  | rep o col b n =>
    simp only at hstep
    split at hstep
    · cases hstep
    · split at hstep
      · cases hstep; exact ⟨rfl, rfl⟩
      · cases hstep
  | set src =>
    simp only at hstep
    split at hstep
    · cases hstep; rfl
    · cases hstep
  | back t counted =>
    cases counted with
    | false => simp only at hstep; cases hstep; exact ⟨rfl, rfl⟩
    | true =>
      simp only at hstep
      split at hstep
      · rename_i w hw; cases hstep; exact Or.inl ⟨rfl, w, hw, rfl⟩
      · rename_i hw; cases hstep; exact Or.inr ⟨rfl, hw, rfl⟩
      · cases hstep
  | result col => simp only at hstep; cases hstep; exact ⟨rfl, rfl⟩

theorem step_not_halt {A : Arith V} {d : Deck} {s s' : State V} (h : s.pc < d.length) :
    step A d s ≠ .halt s' := by
  have hget : d[s.pc]? = some d[s.pc] := List.getElem?_eq_getElem h
  unfold step
  rw [hget]
  generalize d[s.pc] = card
  cases card with
  | op => simp only; split <;> simp
  | rep => simp only; split; · simp
           · split <;> simp
  | set => simp only; split <;> simp
  | back t counted => cases counted <;> simp only <;> (try split) <;> simp
  | result => simp

/-! ## A: an unconditional backing card is never passed -/

/-- Every backing card goes back. -/
def Backward (d : Deck) : Prop := ∀ i t b, d[i]? = some (Card.back t b) → t ≤ i

theorem backward_of_accepts {c : Config} {d : Deck} (h : Accepts c d) : Backward d :=
  fun i t b hi => (h i (Card.back t b) hi).2.1

theorem never_halts_of_always {A : Arith V} {d : Deck} (hb : Backward d) {i t : Nat}
    (hi : d[i]? = some (.back t false)) :
    ∀ n (s : State V), s.pc ≤ i → ∀ s', run A d n s ≠ .halt s' := by
  have hlen : i < d.length := (List.getElem?_eq_some_iff.mp hi).1
  intro n
  induction n with
  | zero => intro s _ s'; simp [run]
  | succ n ih =>
    intro s hs s'
    have hpc : s.pc < d.length := by omega
    obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card :=
      ⟨d[s.pc], List.getElem?_eq_getElem hpc⟩
    simp only [run]
    cases hstep : step A d s with
    | halt s'' => exact absurd hstep (step_not_halt hpc)
    | err => simp
    | run s'' =>
      simp only
      apply ih s'' _ s'
      have hm := step_moves hget hstep
      rcases Nat.lt_or_eq_of_le hs with hlt | heq
      · cases card with
        | back t' counted =>
          have := hb _ _ _ hget
          cases counted <;> simp [Moves] at hm <;> omega
        | op => simp [Moves] at hm; omega
        | rep => simp [Moves] at hm; omega
        | set => simp [Moves] at hm; omega
        | result => simp [Moves] at hm; omega
      · have hc : card = .back t false := by
          rw [heq] at hget; rw [hget] at hi; exact Option.some.inj hi
        subst hc
        simp [Moves] at hm
        have := hb _ _ _ hi
        omega

/-- So a deck with an unconditional backing card never halts from its first card. -/
theorem never_halts_from_start {A : Arith V} {d : Deck} (hb : Backward d) {i t : Nat}
    (hi : d[i]? = some (.back t false)) (s : State V) (h0 : s.pc = 0) : ¬ Halts A d s := by
  rintro ⟨n, s', h⟩
  exact never_halts_of_always hb hi n s (by omega) s' h

/-! ## B: with counted backing only, every run ends -/

theorem ends_of_step {A : Arith V} {d : Deck} {s s' : State V} (h : step A d s = .run s')
    (h' : Ends A d s') : Ends A d s := by
  obtain ⟨n, hn⟩ := h'
  exact ⟨n + 1, by simp only [run, h]; exact hn⟩

theorem ends_of_not_run {A : Arith V} {d : Deck} {s : State V}
    (h : ∀ s', step A d s ≠ .run s') : Ends A d s := by
  refine ⟨1, ?_⟩
  simp only [run]
  cases hs : step A d s with
  | run s' => exact absurd hs (h s')
  | halt s' => exact Or.inr ⟨s', rfl⟩
  | err => exact Or.inl rfl

/-- One card, under the rule: the combinatorial cards ahead fall, or they stay
and the wheels fall, or both stay and the card number moves on by one. -/
theorem step_measure {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    {s s' : State V} (hstep : step A d s = .run s') :
    setsFrom d s'.pc < setsFrom d s.pc ∨
    (setsFrom d s'.pc = setsFrom d s.pc ∧ s'.wheels.getD 0 < s.wheels.getD 0) ∨
    (setsFrom d s'.pc = setsFrom d s.pc ∧ s'.wheels.getD 0 = s.wheels.getD 0 ∧
      s'.pc = s.pc + 1) := by
  obtain ⟨card, hget⟩ : ∃ card, d[s.pc]? = some card := by
    cases h : d[s.pc]? with
    | none => simp [step, h] at hstep
    | some card => exact ⟨card, rfl⟩
  have hm := step_moves hget hstep
  have hsf := setsFrom_of_get hget
  have hlen : s.pc < d.length := (List.getElem?_eq_some_iff.mp hget).1
  cases card with
  | op => simp [Moves] at hm; simp [isSet] at hsf; right; right; simp [hm, hsf]
  | rep => simp [Moves] at hm; simp [isSet] at hsf; right; right; simp [hm, hsf]
  | result => simp [Moves] at hm; simp [isSet] at hsf; right; right; simp [hm, hsf]
  | set => simp [Moves] at hm; simp [isSet] at hsf; left; rw [hm]; omega
  | back t counted =>
    cases counted with
    | false => exact absurd hget (hno _ _)
    | true =>
      have ha := hacc _ _ hget
      simp only at ha
      obtain ⟨_, hti, _, hgrp⟩ := ha
      simp [isSet] at hsf
      rcases hm with ⟨hpc, w, hw, hw'⟩ | ⟨hpc, hw, hw'⟩
      · right; left
        refine ⟨?_, by simp [hw, hw']⟩
        rw [hpc, setsFrom_span (s.pc - t) s.pc (by omega) hlen (hgrp trivial hsg)]
      · right; left
        refine ⟨by rw [hpc, hsf], by simp [hw, hw']⟩

theorem pc_lt_of_run {A : Arith V} {d : Deck} {s s' : State V}
    (h : step A d s = .run s') : s.pc < d.length := by
  cases hg : d[s.pc]? with
  | none => simp [step, hg] at h
  | some card => exact (List.getElem?_eq_some_iff.mp hg).1

theorem ends_k {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    (a w : Nat) (iha : ∀ s : State V, setsFrom d s.pc < a → Ends A d s)
    (ihw : ∀ s : State V, setsFrom d s.pc ≤ a → s.wheels.getD 0 < w → Ends A d s) :
    ∀ k (s : State V), setsFrom d s.pc ≤ a → s.wheels.getD 0 ≤ w → d.length - s.pc ≤ k →
      Ends A d s := by
  intro k
  induction k with
  | zero =>
    intro s _ _ hk
    apply ends_of_not_run
    intro s' hstep
    have := pc_lt_of_run hstep
    omega
  | succ k ihk =>
    intro s ha hw hk
    cases hstep : step A d s with
    | halt s' => exact ends_of_not_run (by intro s''; rw [hstep]; simp)
    | err => exact ends_of_not_run (by intro s''; rw [hstep]; simp)
    | run s' =>
      apply ends_of_step hstep
      have hlt := pc_lt_of_run hstep
      rcases step_measure hacc hsg hno hstep with h | ⟨h1, h2⟩ | ⟨h1, h2, h3⟩
      · exact iha s' (by omega)
      · exact ihw s' (by omega) (by omega)
      · exact ihk s' (by omega) (by omega) (by omega)

theorem ends_w {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    (a : Nat) (iha : ∀ s : State V, setsFrom d s.pc < a → Ends A d s) :
    ∀ w (s : State V), setsFrom d s.pc ≤ a → s.wheels.getD 0 ≤ w → Ends A d s := by
  intro w
  induction w with
  | zero =>
    intro s ha hw
    exact ends_k hacc hsg hno a 0 iha (fun _ _ h => absurd h (Nat.not_lt_zero _)) _ s ha hw
      (Nat.le_refl _)
  | succ w ihw =>
    intro s ha hw
    exact ends_k hacc hsg hno a (w + 1) iha (fun s' h1 h2 => ihw s' h1 (by omega)) _ s ha hw
      (Nat.le_refl _)

/-- **Theorem B.** In a configuration of the pages, a deck whose backing cards
are all counted ends from every state: it halts or an operation fails. -/
theorem ends_of_counted {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false))
    (s : State V) : Ends A d s := by
  suffices h : ∀ a (s : State V), setsFrom d s.pc ≤ a → Ends A d s from h _ s (Nat.le_refl _)
  intro a
  induction a with
  | zero =>
    intro s ha
    exact ends_w hacc hsg hno 0 (fun _ h => absurd h (Nat.not_lt_zero _)) _ s ha (Nat.le_refl _)
  | succ a iha =>
    intro s ha
    exact ends_w hacc hsg hno (a + 1) (fun s' h => iha s' (by omega)) _ s ha (Nat.le_refl _)

/-- **A and B together.** In a configuration of the pages, a run from the first
card that halts belongs to a deck with no unconditional backing card; and such
a deck ends from every state. -/
theorem halting_dichotomy {A : Arith V} {c : Config} {d : Deck} (hacc : Accepts c d)
    (hsg : c.setInGroup = false) (s : State V) (h0 : s.pc = 0) :
    (Halts A d s → ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) ∧
    ((∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) → ∀ s' : State V, Ends A d s') := by
  refine ⟨fun hh i t hi => never_halts_from_start (backward_of_accepts hacc) hi s h0 hh,
    fun hno s' => ends_of_counted hacc hsg hno s'⟩

end Babbage
