import Babbage.Minsky
import Babbage.Separation
import Babbage.GrowthStore

/-!
# Model D: a stop at an operation the mill cannot do, read as the end

In `Machine.lean` an operation that fails (division by zero, or here a
division that is not exact) is an error, and a run ends by passing its last
card (`docs/semantics.md`, rule 14a). The 1843 Sketch speaks of the engine
stopping at "the passage through zero or infinity", and Rojas made Zuse's Z3
general by ending a loop with an operation that cannot be done. Model D reads
such a stop as the end of the run: whatever stands in the store, and whatever
has been given off, are its results (`TrapStops`).

Nothing else changes: the cards, the configurations and `step` are those of
`Machine.lean`.

* `reach_le_tower`, `reach_le_ptw`, `no_tetration_reach`, `no_pentation_reach`:
  **with every backing card counted, a trap adds nothing.** The bounds of
  Models A and B hold for every state a run reaches, and so for a trap stop.
* `trapDeck_accepted`, `trap_halts`, `machine_halts_of_trap`: **with the
  unconditional backing card (Vol 3 p 162), a trap is enough.** A counter
  machine translates into a deck that the configuration of 30 May 1838
  accepts, which stops at a trap exactly when the machine halts, with the
  machine's counters in the store. No combinatorial card stands in a group it
  counts, and the repetition counts are not used.
* `trapDeck37_accepted`, `trap37_halts`, `machine_halts_of_trap37`: the same
  for December 1837, which backs only to card 0, if a repetition count can be
  read from the store (rule 3a as `src/sketch.rs` reads it). That deck has no
  combinatorial card and no counted backing at all.
* `trapDeck_refused_1837`: the 1838 deck needs backing to a card other than 0.
-/

namespace Babbage

variable {V : Type}

/-- The card the run stands at is an operation the mill cannot do. -/
def Trapped (A : Arith V) (d : Deck) (s : State V) : Prop :=
  ∃ o a b dst, d[s.pc]? = some (Card.op o a b dst) ∧ A.op o (fetch A s a) (fetch A s b) = none

/-- **Model D.** The run from `s₀` stops at a trap, in state `s`: what stands in
its store and what it has given off are the results. -/
def TrapStops (A : Arith V) (d : Deck) (s₀ s : State V) : Prop :=
  ∃ n, run A d n s₀ = .run s ∧ Trapped A d s

theorem step_trapped {A : Arith V} {d : Deck} {s : State V} (h : Trapped A d s) :
    step A d s = .err := by
  obtain ⟨o, a, b, dst, hc, hn⟩ := h
  simp [step, hc, hn]

theorem run_prefix {A : Arith V} {d : Deck} {s s'' : State V} {a b : Nat}
    (h : run A d (a + b) s = .run s'') : ∃ s', run A d a s = .run s' := by
  rw [run_add] at h
  cases h2 : run A d a s with
  | run s' => exact ⟨s', rfl⟩
  | halt s' => rw [h2] at h; simp at h
  | err => rw [h2] at h; simp at h

/-! ## With every backing card counted, a trap adds nothing -/

/-- `out_le_Q_gen`, for every state a run reaches rather than only a halt. -/
theorem reach_le_Q_gen {A : Arith V} (S : Sized A) {c : Config} {K : Nat} {d : Deck}
    (g : Nat → Nat) (hg : ∀ x, x ≤ g x)
    (hstepI : ∀ X (s s' : State V), Inv A S K X s → step A d s = .run s' → Inv A S K (g X) s')
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) :
    ∀ n a m X (s s' : State V), Inv A S K X s → setsFrom d s.pc ≤ a → phi d s ≤ m →
      run A d n s = .run s' →
        (∀ j, S.sz (s'.store j) ≤ Q g d.length a m X) ∧
          ∀ v ∈ s'.out, S.sz v ≤ Q g d.length a m X := by
  intro n
  induction n with
  | zero =>
    intro a m X s s' hi _ _ h
    simp only [run, Res.run.injEq] at h
    subst h
    exact ⟨fun j => Nat.le_trans (hi.store j) (Q_ge _ hg _ m a X),
      fun v hv => Nat.le_trans (hi.out v hv) (Q_ge _ hg _ m a X)⟩
  | succ n ih =>
    intro a m X s s' hi ha hm h
    simp only [run] at h
    cases hstep : step A d s with
    | err => rw [hstep] at h; cases h
    | halt s'' => rw [hstep] at h; cases h
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
        have := ih a' _ _ s'' s' hi' (by rw [hm']; omega) (phi_set S hi') h
        rw [Q]
        exact ⟨fun j => Nat.le_trans (this.1 j) (Nat.le_max_right _ _),
          fun v hv => Nat.le_trans (this.2 v hv) (Nat.le_max_right _ _)⟩
      · obtain ⟨m', rfl⟩ : ∃ m', m = m' + 1 := ⟨m - 1, by omega⟩
        have := ih a m' _ s'' s' hi'
          (Nat.le_trans (setsFrom_le_of_step hacc hsg hno hstep) ha) (by omega) h
        cases a with
        | zero => rw [Q]; exact this
        | succ a =>
          rw [Q]
          exact ⟨fun j => Nat.le_trans (this.1 j) (Nat.le_max_left _ _),
            fun v hv => Nat.le_trans (this.2 v hv) (Nat.le_max_left _ _)⟩

theorem setsFrom_zero_le (d : Deck) : setsFrom d 0 ≤ d.length := by
  unfold setsFrom
  suffices ∀ l : List Card, setsIn l ≤ l.length by simpa using this d
  intro l; induction l with
  | nil => simp [setsIn]
  | cons x xs ih => simp only [setsIn, List.length_cons]; split <;> omega

theorem Q_tower (K L X : Nat) :
    Q (grow K) L L (X * (L + 1) + L) X ≤ tw (3 * (L + 1)) (X + (L + 1) * E K L) := by
  have hm : ∀ x y, x ≤ y → grow K x ≤ grow K y := fun _ _ => grow_mono K
  have hi := le_grow K
  refine Nat.le_trans (Q_le hm hi _ _ _ _) ?_
  have h2 : it (grow K) (X * (L + 1) + L) X = H (grow K) L X := rfl
  rw [h2, ← it_succ']
  refine Nat.le_trans (it_le_it (H_infl hi _) X (Nat.succ_le_succ (Nat.le_refl _))) ?_
  exact itH_le K L _ X

theorem Q_ptw (L X : Nat) :
    Q growS L L (X * (L + 1) + L) X ≤ ptw (2 * (L + 1)) (X + (L + 1) * (5 * L + 6)) := by
  have hm : ∀ x y, x ≤ y → growS x ≤ growS y := fun _ _ => growS_mono
  have hi := le_growS
  refine Nat.le_trans (Q_le hm hi _ _ _ _) ?_
  have h2 : it growS (X * (L + 1) + L) X = H growS L X := rfl
  rw [h2, ← it_succ']
  refine Nat.le_trans (it_le_it (H_infl hi _) X (Nat.succ_le_succ (Nat.le_refl _))) ?_
  refine Nat.le_trans (it_le_of_le (H_growS_le L) (fun _ _ h => T_mono _ h) _ X) ?_
  exact it_T_le L _ X

/-- **Model A, any state reached.** With every backing card counted and the
repetition counts number cards, everything in the store and everything given
off, at any point of a run (a trap stop included), is within the tower of
`out_le_tower`. -/
theorem reach_le_tower {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) (hl : LitsLe A S K d)
    (hc : ConstReps d) {s : State V} (hs : Inv A S K X s) (h0 : s.pc = 0)
    {n : Nat} {s' : State V} (hrun : run A d n s = .run s') :
    (∀ j, S.sz (s'.store j) ≤ tw (3 * (d.length + 1)) (X + (d.length + 1) * E K d.length)) ∧
      ∀ v ∈ s'.out, S.sz v ≤ tw (3 * (d.length + 1)) (X + (d.length + 1) * E K d.length) := by
  have h1 := reach_le_Q_gen S (grow K) (le_grow K) (fun X s s' hi h => step_inv S hl hc hi h)
    hacc hsg hno n _ _ X s s' hs (by rw [h0]; exact setsFrom_zero_le d) (phi_set S hs) hrun
  exact ⟨fun j => Nat.le_trans (h1.1 j) (Q_tower K _ X),
    fun v hv => Nat.le_trans (h1.2 v hv) (Q_tower K _ X)⟩

/-- **Model B, any state reached.** With every backing card counted, the counts
from number cards or the store, the bound of `out_le_ptw` holds at any point of
a run. -/
theorem reach_le_ptw {A : Arith V} (S : Sized A) {c : Config} {K X : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) (hl : LitsLe A S K d)
    {s : State V} (hs : Inv A S K X s) (h0 : s.pc = 0)
    {n : Nat} {s' : State V} (hrun : run A d n s = .run s') :
    (∀ j, S.sz (s'.store j) ≤ ptw (2 * (d.length + 1)) (X + (d.length + 1) * (5 * d.length + 6))) ∧
      ∀ v ∈ s'.out,
        S.sz v ≤ ptw (2 * (d.length + 1)) (X + (d.length + 1) * (5 * d.length + 6)) := by
  have h1 := reach_le_Q_gen S growS le_growS (fun X s s' hi h => step_invS S hl hi h)
    hacc hsg hno n _ _ X s s' hs (by rw [h0]; exact setsFrom_zero_le d) (phi_set S hs) hrun
  exact ⟨fun j => Nat.le_trans (h1.1 j) (Q_ptw _ X),
    fun v hv => Nat.le_trans (h1.2 v hv) (Q_ptw _ X)⟩

/-- **Model D without the unconditional backing, counts from number cards.**
For some n, no state reached from input n, and so no trap stop, holds or has
given off 2↑↑n or more. -/
theorem no_tetration_reach {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) (hl : LitsLe A S K d)
    (hc : ConstReps d) (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State V), run A d k (init n) = .run s' →
      (∀ j, S.sz (s'.store j) < tet n) ∧ ∀ v ∈ s'.out, S.sz v < tet n := by
  let J := 3 * (d.length + 1)
  let C := K₀ + (d.length + 1) * E K d.length
  let p := J + 1 + C
  refine ⟨J + p + 1, fun k s' hrun => ?_⟩
  have h := reach_le_tower S hacc hsg hno hl hc (hinit _) (h0 _) hrun
  have hp : J + p + 1 + C ≤ tw p 1 :=
    Nat.le_trans (by have := two_mul_le_two_pow p; omega) (pow_le_tw p)
  have h3 : tw J (J + p + 1 + C) ≤ tw (J + p) 1 := by
    rw [← tw_comp]; exact tw_mono J _ _ hp
  have key : ∀ x, x ≤ tw J (J + p + 1 + K₀ + (d.length + 1) * E K d.length) →
      x < tet (J + p + 1) := by
    intro x hx
    rw [tet_eq_tw]
    show x < 2 ^ tw (J + p) 1
    have : x ≤ tw (J + p) 1 := Nat.le_trans hx (Nat.le_trans (tw_mono J _ _ (by omega)) h3)
    exact Nat.lt_of_le_of_lt this Nat.lt_two_pow_self
  exact ⟨fun j => key _ (h.1 j), fun v hv => key _ (h.2 v hv)⟩

/-- **Model D without the unconditional backing, counts from the store.** For
some n, no state reached from input n holds or has given off 2↑↑↑n or more. -/
theorem no_pentation_reach {A : Arith V} (S : Sized A) {c : Config} {K K₀ : Nat} {d : Deck}
    (hacc : Accepts c d) (hsg : c.setInGroup = false)
    (hno : ∀ (i t : Nat), d[i]? ≠ some (Card.back t false)) (hl : LitsLe A S K d)
    (init : Nat → State V) (h0 : ∀ n, (init n).pc = 0)
    (hinit : ∀ n, Inv A S K (n + K₀) (init n)) :
    ∃ n, ∀ k (s' : State V), run A d k (init n) = .run s' →
      (∀ j, S.sz (s'.store j) < pent n) ∧ ∀ v ∈ s'.out, S.sz v < pent n := by
  let J := 2 * (d.length + 1)
  let C := K₀ + (d.length + 1) * (5 * d.length + 6)
  let p := J + 1 + C
  refine ⟨J + p + 1, fun k s' hrun => ?_⟩
  have h := reach_le_ptw S hacc hsg hno hl (hinit _) (h0 _) hrun
  have hp : J + p + 1 + C ≤ pent p :=
    Nat.le_trans (by have := two_mul_le_two_pow p; omega)
      (Nat.le_trans (pow_le_tw p) (by rw [← tet_eq_tw]; exact tet_le_pent p))
  have h3 : ptw J (J + p + 1 + C) ≤ pent (J + p) := by
    rw [pent_eq_ptw, ← ptw_comp, ← pent_eq_ptw]; exact ptw_mono J _ _ hp
  have key : ∀ x, x ≤ ptw J (J + p + 1 + K₀ + (d.length + 1) * (5 * d.length + 6)) →
      x < pent (J + p + 1) := by
    intro x hx
    show x < tet (pent (J + p))
    have : x ≤ pent (J + p) := Nat.le_trans hx (Nat.le_trans (ptw_mono J _ _ (by omega)) h3)
    exact Nat.lt_of_le_of_lt this (lt_tet _)
  exact ⟨fun j => key _ (h.1 j), fun v hv => key _ (h.2 v hv)⟩

end Babbage

/-! ## With the unconditional backing, a trap is enough -/

namespace Babbage.Minsky

open Babbage

/-- The end of each pass: W := W − 1, which is 0 exactly when the machine has
halted; 1 ÷ W, which the mill cannot do when W = 0; and back to card 0, always
(an unconditional backing card, Vol 3 p 162). -/
def trapTail : List Card :=
  [.op .sub (.col W) (.num 1) W, .op .div (.num 1) (.col W) T, .back 0 false]

/-- **The 1838 deck**: the flag groups and straight cards of `compile`, then
`trapTail`. -/
def trapDeck (P : Prog) (k : Nat) : Deck := upTo (flagBlock k) k ++ straight P k ++ trapTail

/-- [c_r > 0] into F_r by one operation repeated c_r times, its count read from
the store: F := 1; F := F × 0, c_r times; F := 1 − F. -/
def repFlag (k r : Nat) : List Card :=
  [.op .add (.num 0) (.num 1) (F k r),
   .rep .mul (F k r) (.num 0) (.col (C r)),
   .op .sub (.num 1) (.col (F k r)) (F k r)]

/-- **The December 1837 deck**: no combinatorial card and no counted backing. -/
def trapDeck37 (P : Prog) (k : Nat) : Deck := upTo (repFlag k) k ++ straight P k ++ trapTail

/-- What the cards before the straight cards must do: from card 0, reach card
`p` with [c_r > 0] in each F_r, everything else from column 5 on unchanged. -/
def FlagsRun (d : Deck) (k p : Nat) : Prop :=
  ∀ (c : Nat → Nat) (wh : Option Nat) (st : Nat → Int) (out : List Int),
    (∀ r, r < k → st (C r) = c r) →
    ∃ n st' wh', run intArith d n ⟨0, st, wh, out⟩ = .run ⟨p, st', wh', out⟩ ∧
      (∀ r, r < k → st' (F k r) = if 0 < c r then 1 else 0) ∧
      ∀ x, 5 ≤ x → (x < F k 0 ∨ F k k ≤ x) → st' x = st x

section
variable {P : Prog} {k : Nat} {d : Deck} {p : Nat}

/-- **One pass is one step**: back at card 0 with the next step encoded, or,
when that step halts the machine, standing at the trap. -/
theorem trap_pass (hwf : WF P k) (hfl : FlagsRun d k p)
    (hseg : Seg d p (straight P k ++ trapTail))
    (m : MConf) (st : Nat → Int) (henc : Enc k P.length m st) (wh : Option Nat) (out : List Int) :
    ∃ np st' wh', 0 < np ∧ Enc k P.length (mstep P m) st' ∧
      if Halted P (mstep P m) then
        run intArith d np ⟨0, st, wh, out⟩ = .run ⟨p + (straight P k).length + 1, st', wh', out⟩ ∧
          Trapped intArith d ⟨p + (straight P k).length + 1, st', wh', out⟩
      else run intArith d np ⟨0, st, wh, out⟩ = .run ⟨0, st', wh', out⟩ := by
  have ⟨hst, htl⟩ := seg_append hseg
  obtain ⟨n1, st1, wh1, h1, hF1, hx1⟩ := hfl m.c wh st out (fun r hr => henc.c r hr)
  have henc1 : Enc k P.length m st1 := by
    refine ⟨henc.q_lt, fun j hj => ?_, fun r hr => ?_⟩
    · rw [hx1 _ (by simp only [S]; omega) (Or.inr (by simp only [S, F]; omega))]; exact henc.s j hj
    · rw [hx1 _ (by simp only [C]; omega) (Or.inl (by simp only [C, F]; omega))]; exact henc.c r hr
  have h2 := run_straight (d := d) (straight P k) p st1 wh1 out hst (straight_ops P k)
  obtain ⟨henc2, hW⟩ := straight_effect hwf m st1 henc1 hF1
  generalize hs2 : exec (straight P k) st1 = st2 at henc2 hW h2
  have gsub : d[p + (straight P k).length]? = some (.op .sub (.col W) (.num 1) W) := by
    simpa [trapTail] using seg_get htl (i := 0) (by simp [trapTail])
  have gdiv : d[p + (straight P k).length + 1]? = some (.op .div (.num 1) (.col W) T) := by
    simpa [trapTail, Nat.add_assoc] using seg_get htl (i := 1) (by simp [trapTail])
  have gback : d[p + (straight P k).length + 2]? = some (.back 0 false) := by
    simpa [trapTail, Nat.add_assoc] using seg_get htl (i := 2) (by simp [trapTail])
  have hWS : ∀ j, S k j ≠ W := fun j => by simp only [S, W]; omega
  have hWC : ∀ r, C r ≠ W := fun r => by simp only [C, W]; omega
  have hTS : ∀ j, S k j ≠ T := fun j => by simp only [S, T]; omega
  have hTC : ∀ r, C r ≠ T := fun r => by simp only [C, T]; omega
  let st3 := upd st2 W (st2 W - 1)
  have henc3 : Enc k P.length (mstep P m) st3 :=
    ⟨henc2.q_lt, fun j hj => by simp only [st3]; rw [upd_ne' _ _ (hWS j)]; exact henc2.s j hj,
      fun r hr => by simp only [st3]; rw [upd_ne' _ _ (hWC r)]; exact henc2.c r hr⟩
  have hpre : run intArith d (n1 + ((straight P k).length + 1)) ⟨0, st, wh, out⟩ =
      .run ⟨p + (straight P k).length + 1, st3, wh1, out⟩ := by
    rw [run_add, h1]; simp only; rw [run_add, h2]; simp only
    simp [run, step, gsub, fetch, intOp, st3]
  by_cases hh : Halted P (mstep P m)
  · refine ⟨n1 + ((straight P k).length + 1), st3, wh1, by omega, henc3, ?_⟩
    rw [if_pos hh]
    refine ⟨hpre, .div, .num 1, .col W, T, gdiv, ?_⟩
    rw [if_pos hh] at hW
    simp [fetch, intOp, st3, upd, hW]
  · rw [if_neg hh] at hW
    have hW3 : st3 W = 1 := by simp [st3, upd, hW]
    refine ⟨n1 + ((straight P k).length + 1) + 2, upd st3 T 1, wh1, by omega,
      ⟨henc3.q_lt, fun j hj => by rw [upd_ne' _ _ (hTS j)]; exact henc3.s j hj,
        fun r hr => by rw [upd_ne' _ _ (hTC r)]; exact henc3.c r hr⟩, ?_⟩
    have gdiv' : d[p + ((straight P k).length + 1)]? = some (.op .div (.num 1) (.col W) T) := by
      rw [← Nat.add_assoc]; exact gdiv
    have gback' : d[p + ((straight P k).length + 2)]? = some (.back 0 false) := by
      rw [← Nat.add_assoc]; exact gback
    rw [if_neg hh, run_add, hpre]
    simp only
    simp [run, step, gdiv', gback', fetch, intOp, hW3, Nat.add_assoc]

theorem trap_loop (hwf : WF P k) (hfl : FlagsRun d k p)
    (hseg : Seg d p (straight P k ++ trapTail)) :
    ∀ t (m : MConf) (st : Nat → Int) (wh : Option Nat) (out : List Int), Enc k P.length m st →
      Halted P (mrun P t (mstep P m)) →
      ∃ n s', run intArith d n ⟨0, st, wh, out⟩ = .run s' ∧ Trapped intArith d s' ∧
        ∀ r, r < k → s'.store (C r) = (mrun P t (mstep P m)).c r := by
  intro t
  induction t with
  | zero =>
    intro m st wh out henc hh
    simp only [mrun] at hh ⊢
    obtain ⟨np, st', wh', _, henc', hp⟩ := trap_pass hwf hfl hseg m st henc wh out
    rw [if_pos hh] at hp
    exact ⟨np, _, hp.1, hp.2, fun r hr => henc'.c r hr⟩
  | succ t ih =>
    intro m st wh out henc hh
    obtain ⟨np, st', wh', _, henc', hp⟩ := trap_pass hwf hfl hseg m st henc wh out
    by_cases h0 : Halted P (mstep P m)
    · rw [if_pos h0] at hp
      refine ⟨np, _, hp.1, hp.2, fun r hr => ?_⟩
      rw [mrun_halted h0]; exact henc'.c r hr
    · rw [if_neg h0] at hp
      obtain ⟨n2, s', h2, htr, hc⟩ := ih (mstep P m) st' wh' out henc' hh
      exact ⟨np + n2, s', by rw [run_add, hp]; exact h2, htr, hc⟩

theorem trap_halts_gen (hwf : WF P k) (hfl : FlagsRun d k p)
    (hseg : Seg d p (straight P k ++ trapTail)) (st0 : Nat → Int) (m0 : MConf)
    (henc : Enc k P.length m0 st0) (t : Nat) (h : Halted P (mrun P t m0)) :
    ∃ s', TrapStops intArith d ⟨0, st0, none, []⟩ s' ∧
      ∀ r, r < k → s'.store (C r) = (mrun P t m0).c r := by
  have e : mrun P t (mstep P m0) = mrun P t m0 := by
    rw [← mrun, mrun_succ', mstep_halted h]
  rw [← e] at h ⊢
  obtain ⟨n, s', hr, htr, hc⟩ := trap_loop hwf hfl hseg t m0 st0 none [] henc h
  exact ⟨s', ⟨n, hr, htr⟩, hc⟩

/-- While the machine has not halted, the deck is still running. -/
theorem runs_on (hwf : WF P k) (hfl : FlagsRun d k p)
    (hseg : Seg d p (straight P k ++ trapTail)) :
    ∀ n (m : MConf) (st : Nat → Int) wh out, Enc k P.length m st →
      (∀ t, ¬ Halted P (mrun P t m)) → ∃ s, run intArith d n ⟨0, st, wh, out⟩ = .run s := by
  intro n
  induction n using Nat.strongRecOn with
  | _ n ih =>
    intro m st wh out henc hno
    obtain ⟨np, st', wh', hnp, henc', hp⟩ := trap_pass hwf hfl hseg m st henc wh out
    have h0 : ¬ Halted P (mstep P m) := hno 1
    rw [if_neg h0] at hp
    by_cases hle : n ≤ np
    · obtain ⟨b, rfl⟩ : ∃ b, np = n + b := ⟨np - n, by omega⟩
      exact run_prefix hp
    · obtain ⟨b, rfl⟩ : ∃ b, n = np + b := ⟨n - np, by omega⟩
      obtain ⟨s, hs⟩ := ih b (by omega) (mstep P m) st' wh' out henc' (fun t => hno (t + 1))
      exact ⟨s, by rw [run_add, hp]; exact hs⟩

theorem machine_halts_gen (hwf : WF P k) (hfl : FlagsRun d k p)
    (hseg : Seg d p (straight P k ++ trapTail)) (st0 : Nat → Int) (m0 : MConf)
    (henc : Enc k P.length m0 st0) (s' : State Int)
    (h : TrapStops intArith d ⟨0, st0, none, []⟩ s') : ∃ t, Halted P (mrun P t m0) := by
  obtain ⟨n, hr, htr⟩ := h
  refine Classical.byContradiction fun hne => ?_
  obtain ⟨s, hs⟩ := runs_on hwf hfl hseg (n + 1) m0 st0 none [] henc (fun t ht => hne ⟨t, ht⟩)
  rw [run_add, hr] at hs
  simp [run, step_trapped htr] at hs

end

/-! ### May 1838: the flag groups of `compile` -/

theorem trapDeck_seg (P : Prog) (k : Nat) :
    Seg (trapDeck P k) 0 (upTo (flagBlock k) k) ∧
      Seg (trapDeck P k) (6 * k) (straight P k ++ trapTail) := by
  have hseg : Seg (trapDeck P k) 0 (upTo (flagBlock k) k ++ (straight P k ++ trapTail)) := by
    rw [← List.append_assoc]; exact seg_self _
  obtain ⟨h1, h2⟩ := seg_append hseg
  rw [length_flags] at h2
  exact ⟨h1, by simpa using h2⟩

theorem flagsRun_1838 (P : Prog) (k : Nat) : FlagsRun (trapDeck P k) k (6 * k) :=
  fun c wh st out hc => flags_run (trapDeck_seg P k).1 out c k (Nat.le_refl _) wh st hc

/-- **If the machine halts, the 1838 deck stops at a trap**, with the counters
of the halted machine in the store. -/
theorem trap_halts {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length) (c : Nat → Nat)
    (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ s', TrapStops intArith (trapDeck P k) ⟨0, initStore k c, none, []⟩ s' ∧
      ∀ r, r < k → s'.store (C r) = (mrun P t ⟨0, c⟩).c r :=
  trap_halts_gen hwf (flagsRun_1838 P k) (trapDeck_seg P k).2 _ _ (enc_init P k hn c) t h

/-- **If the 1838 deck stops at a trap, the machine halts.** -/
theorem machine_halts_of_trap {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length)
    (c : Nat → Nat) (s' : State Int)
    (h : TrapStops intArith (trapDeck P k) ⟨0, initStore k c, none, []⟩ s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) :=
  machine_halts_gen hwf (flagsRun_1838 P k) (trapDeck_seg P k).2 _ _ (enc_init P k hn c) s' h

/-! ### December 1837: flags by a repeated operation -/

theorem iter_mul_zero : ∀ (c : Nat) (x : Int),
    iter intArith .mul 0 c x = some (if c = 0 then x else 0)
  | 0, x => by simp [iter]
  | c + 1, x => by
    simp only [iter, intArith_op, intOp, Option.bind_some, Int.mul_zero]
    rw [iter_mul_zero c 0]; simp

theorem repflag_block {d : Deck} {k r : Nat} (hseg : Seg d (3 * r) (repFlag k r))
    (hr : r < k) (st : Nat → Int) (wh : Option Nat) (out : List Int) (c : Nat) (hc : st (C r) = c) :
    ∃ st', run intArith d 3 ⟨3 * r, st, wh, out⟩ = .run ⟨3 * r + 3, st', wh, out⟩ ∧
      st' (F k r) = (if 0 < c then 1 else 0) ∧ ∀ x, x ≠ F k r → st' x = st x := by
  have g0 : d[3 * r]? = some (.op .add (.num 0) (.num 1) (F k r)) := by
    simpa [repFlag] using seg_get hseg (i := 0) (by simp [repFlag])
  have g1 : d[3 * r + 1]? = some (.rep .mul (F k r) (.num 0) (.col (C r))) := by
    simpa [repFlag] using seg_get hseg (i := 1) (by simp [repFlag])
  have g2 : d[3 * r + 2]? = some (.op .sub (.num 1) (.col (F k r)) (F k r)) := by
    simpa [repFlag] using seg_get hseg (i := 2) (by simp [repFlag])
  have hCF : C r ≠ F k r := by unfold C F; omega
  let st1 := upd st (F k r) 1
  let st2 := upd st1 (F k r) (if c = 0 then 1 else 0)
  let st3 := upd st2 (F k r) (1 - (if c = 0 then 1 else 0))
  have e1 : st1 (C r) = c := by simp only [st1]; rw [upd_ne' _ _ hCF, hc]
  have e2 : st2 (F k r) = if c = 0 then 1 else 0 := by simp only [st2]; rw [upd_same']
  refine ⟨st3, ?_, ?_, ?_⟩
  · have s0 : step intArith d ⟨3 * r, st, wh, out⟩ = .run ⟨3 * r + 1, st1, wh, out⟩ := by
      simp [step, g0, fetch, intOp, st1]
    have s1 : step intArith d ⟨3 * r + 1, st1, wh, out⟩ = .run ⟨3 * r + 2, st2, wh, out⟩ := by
      simp [step, g1, fetch, e1, iter_mul_zero, st2, st1, upd_same']
    have s2 : step intArith d ⟨3 * r + 2, st2, wh, out⟩ = .run ⟨3 * r + 3, st3, wh, out⟩ := by
      simp [step, g2, fetch, intOp, e2, st3]
    simp [run, s0, s1, s2]
  · simp only [st3]; rw [upd_same']; cases c <;> simp
  · intro x hx; simp only [st3, st2, st1]; rw [upd_ne' _ _ hx, upd_ne' _ _ hx, upd_ne' _ _ hx]

theorem length_repflags (k : Nat) : ∀ m, (upTo (repFlag k) m).length = 3 * m :=
  length_upTo _ 3 (fun _ => by simp [repFlag])

theorem repflags_run {d : Deck} {k : Nat} (hseg : Seg d 0 (upTo (repFlag k) k)) (out : List Int)
    (c : Nat → Nat) : ∀ m, m ≤ k → ∀ (wh : Option Nat) (st : Nat → Int),
      (∀ r, r < k → st (C r) = c r) →
      ∃ n st' wh', run intArith d n ⟨0, st, wh, out⟩ = .run ⟨3 * m, st', wh', out⟩ ∧
        (∀ r, r < m → st' (F k r) = (if 0 < c r then 1 else 0)) ∧
        ∀ x, 5 ≤ x → (x < F k 0 ∨ F k m ≤ x) → st' x = st x := by
  intro m
  induction m with
  | zero => intro _ wh st _; exact ⟨0, st, wh, by simp [run], by simp, by simp⟩
  | succ m ih =>
    intro hm wh st hc
    obtain ⟨n, st1, wh1, h1, hF1, hx1⟩ := ih (by omega) wh st hc
    have hs : Seg d (3 * m) (repFlag k m) := by
      have := seg_upTo hseg m (by omega)
      simpa [length_repflags] using this
    have hcm : st1 (C m) = c m := by
      rw [hx1 _ (by unfold C; omega) (Or.inl (by unfold C F; omega))]; exact hc m (by omega)
    obtain ⟨st2, h2, hF2, hx2⟩ := repflag_block hs (by omega) st1 wh1 out (c m) hcm
    refine ⟨n + 3, st2, wh1, ?_, ?_, ?_⟩
    · rw [run_add, h1]; simpa [Nat.mul_succ] using h2
    · intro r hr
      rcases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ hr) with hr | rfl
      · rw [hx2 _ (by unfold F; omega)]; exact hF1 r hr
      · exact hF2
    · intro x h5 hx
      rw [hx2 _ (by unfold F at *; omega)]
      exact hx1 x h5 (by unfold F at *; omega)

theorem trapDeck37_seg (P : Prog) (k : Nat) :
    Seg (trapDeck37 P k) 0 (upTo (repFlag k) k) ∧
      Seg (trapDeck37 P k) (3 * k) (straight P k ++ trapTail) := by
  have hseg : Seg (trapDeck37 P k) 0 (upTo (repFlag k) k ++ (straight P k ++ trapTail)) := by
    rw [← List.append_assoc]; exact seg_self _
  obtain ⟨h1, h2⟩ := seg_append hseg
  rw [length_repflags] at h2
  exact ⟨h1, by simpa using h2⟩

theorem flagsRun_1837 (P : Prog) (k : Nat) : FlagsRun (trapDeck37 P k) k (3 * k) :=
  fun c wh st out hc => repflags_run (trapDeck37_seg P k).1 out c k (Nat.le_refl _) wh st hc

/-- **If the machine halts, the December 1837 deck stops at a trap**, with the
counters of the halted machine in the store. -/
theorem trap37_halts {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length) (c : Nat → Nat)
    (t : Nat) (h : Halted P (mrun P t ⟨0, c⟩)) :
    ∃ s', TrapStops intArith (trapDeck37 P k) ⟨0, initStore k c, none, []⟩ s' ∧
      ∀ r, r < k → s'.store (C r) = (mrun P t ⟨0, c⟩).c r :=
  trap_halts_gen hwf (flagsRun_1837 P k) (trapDeck37_seg P k).2 _ _ (enc_init P k hn c) t h

/-- **If the December 1837 deck stops at a trap, the machine halts.** -/
theorem machine_halts_of_trap37 {P : Prog} {k : Nat} (hwf : WF P k) (hn : 0 < P.length)
    (c : Nat → Nat) (s' : State Int)
    (h : TrapStops intArith (trapDeck37 P k) ⟨0, initStore k c, none, []⟩ s') :
    ∃ t, Halted P (mrun P t ⟨0, c⟩) :=
  machine_halts_gen hwf (flagsRun_1837 P k) (trapDeck37_seg P k).2 _ _ (enc_init P k hn c) s' h

/-! ### Which configurations accept the decks -/

/-- Where combinatorial and backing cards stand: a combinatorial card only at
6r + 2; every backing card goes back, and a counted one stands at 6r + 5 and
goes to 6r + 3. -/
def GroupOK (l : List Card) (off : Nat) : Prop :=
  ∀ (i : Nat) card, l[i]? = some card →
    (isSet card = true → ∃ r, off + i = 6 * r + 2) ∧
    ∀ t b, card = Card.back t b → t ≤ off + i ∧
      (b = true → ∃ r, off + i = 6 * r + 5 ∧ t = 6 * r + 3)

theorem groupOK_append {a b : List Card} {off : Nat} (ha : GroupOK a off)
    (hb : GroupOK b (off + a.length)) : GroupOK (a ++ b) off := by
  intro i card h
  by_cases hi : i < a.length
  · rw [List.getElem?_append_left hi] at h; exact ha i card h
  · rw [List.getElem?_append_right (by omega)] at h
    have := hb _ card h
    rw [show off + a.length + (i - a.length) = off + i by omega] at this
    exact this

theorem groupOK_ops {l : List Card} {off : Nat} (h : ∀ c ∈ l, IsOp c) : GroupOK l off := by
  intro i card hi
  have := h _ (List.mem_of_getElem? hi)
  cases card <;> simp_all [IsOp, isSet]

theorem groupOK_flags (k : Nat) : ∀ m, GroupOK (upTo (flagBlock k) m) 0 := by
  intro m
  induction m with
  | zero => intro i card h; simp [upTo] at h
  | succ m ih =>
    apply groupOK_append ih
    rw [length_flags]
    intro i card h
    simp only [flagBlock] at h
    match i, h with
    | 0, h | 1, h | 3, h | 4, h => simp at h; subst h; simp [isSet]
    | 2, h => simp at h; subst h; exact ⟨fun _ => ⟨m, by omega⟩, by simp⟩
    | 5, h =>
      simp at h; subst h
      refine ⟨by simp [isSet], fun t b hb => ?_⟩
      simp at hb; obtain ⟨rfl, rfl⟩ := hb
      exact ⟨by omega, fun _ => ⟨m, by omega, rfl⟩⟩
    | i + 6, h => simp at h

theorem groupOK_tail (off : Nat) : GroupOK trapTail off := by
  intro i card h
  match i, h with
  | 0, h | 1, h => simp [trapTail] at h; subst h; simp [isSet]
  | 2, h =>
    simp [trapTail] at h; subst h
    refine ⟨by simp [isSet], fun t b hb => ?_⟩
    simp at hb; obtain ⟨rfl, rfl⟩ := hb
    exact ⟨by omega, by simp⟩
  | i + 3, h => simp [trapTail] at h

theorem accepts_of_groupOK {c : Config} {d : Deck} (hb : c.backing = true)
    (ha : c.anyTarget = true) (h : GroupOK d 0) : Accepts c d := by
  intro i card hc
  have hg := h i card hc
  simp only [Nat.zero_add] at hg
  cases card with
  | set s => exact hb
  | back t counted =>
    obtain ⟨ht, hct⟩ := hg.2 t counted rfl
    refine ⟨hb, ht, Or.inl ha, fun hcnt _ j card' hj hji hj' => ?_⟩
    obtain ⟨r, hi, rfl⟩ := hct hcnt
    cases hs : isSet card' with
    | false => rfl
    | true =>
      obtain ⟨r', hr'⟩ := (h j card' hj').1 hs
      omega
  | _ => trivial

/-- **The configuration of 30 May 1838 accepts the 1838 deck**: no
combinatorial card stands in a group it counts. -/
theorem trapDeck_accepted (P : Prog) (k : Nat) : Accepts c1838 (trapDeck P k) := by
  apply accepts_of_groupOK rfl rfl
  unfold trapDeck
  refine groupOK_append (groupOK_append (groupOK_flags k k) (groupOK_ops (straight_ops P k))) ?_
  exact groupOK_tail _

/-- December 1837, which backs only to card 0, refuses the 1838 deck (with a
counter): its flag groups back to card 3. -/
theorem trapDeck_refused_1837 (P : Prog) {k : Nat} (hk : 0 < k) :
    ¬ Accepts c1837 (trapDeck P k) := by
  intro hacc
  have hs := seg_upTo (trapDeck_seg P k).1 0 hk
  simp only [upTo, List.length_nil, Nat.add_zero] at hs
  have g : (trapDeck P k)[5]? = some (.back 3 true) := by
    simpa [flagBlock] using seg_get hs (i := 5) (by simp [flagBlock])
  have := hacc 5 _ g
  simp [c1837] at this

/-- No combinatorial card, and every backing card is to card 0 and not counted. -/
def Plain (l : List Card) : Prop :=
  ∀ (i : Nat) card, l[i]? = some card →
    isSet card = false ∧ ∀ t b, card = Card.back t b → t = 0 ∧ b = false

theorem plain_append {a b : List Card} (ha : Plain a) (hb : Plain b) : Plain (a ++ b) := by
  intro i card h
  by_cases hi : i < a.length
  · rw [List.getElem?_append_left hi] at h; exact ha i card h
  · rw [List.getElem?_append_right (by omega)] at h; exact hb _ card h

theorem plain_repflags (k : Nat) : ∀ m, Plain (upTo (repFlag k) m) := by
  intro m
  induction m with
  | zero => intro i card h; simp [upTo] at h
  | succ m ih =>
    apply plain_append ih
    intro i card h
    match i, h with
    | 0, h | 1, h | 2, h => simp [repFlag] at h; subst h; simp [isSet]
    | i + 3, h => simp [repFlag] at h

theorem plain_ops {l : List Card} (h : ∀ c ∈ l, IsOp c) : Plain l := by
  intro i card hi
  have := h _ (List.mem_of_getElem? hi)
  cases card <;> simp_all [IsOp, isSet]

theorem plain_tail : Plain trapTail := by
  intro i card h
  match i, h with
  | 0, h | 1, h => simp [trapTail] at h; subst h; simp [isSet]
  | 2, h => simp [trapTail] at h; subst h; simp [isSet]
  | i + 3, h => simp [trapTail] at h

/-- **Every configuration with backing cards accepts the December 1837 deck**,
December 1837 included. -/
theorem trapDeck37_accepted (P : Prog) (k : Nat) (c : Config) (hb : c.backing = true) :
    Accepts c (trapDeck37 P k) := by
  have h : Plain (trapDeck37 P k) :=
    plain_append (plain_append (plain_repflags k k) (plain_ops (straight_ops P k))) plain_tail
  intro i card hc
  obtain ⟨hs, hbk⟩ := h i card hc
  cases card with
  | set s => simp [isSet] at hs
  | back t counted =>
    obtain ⟨rfl, rfl⟩ := hbk t counted rfl
    exact ⟨hb, Nat.zero_le _, Or.inr rfl, fun h => absurd h (by decide)⟩
  | _ => trivial

/-- The December 1837 deck needs a repetition count read from the store: it is
not a deck of Model A. -/
theorem trapDeck37_not_constReps (P : Prog) {k : Nat} (hk : 0 < k) :
    ¬ ConstReps (trapDeck37 P k) := by
  intro hc
  have hs := seg_upTo (trapDeck37_seg P k).1 0 hk
  simp only [upTo, List.length_nil, Nat.add_zero] at hs
  have g : (trapDeck37 P k)[1]? = some (.rep .mul (F k 0) (.num 0) (.col (C 0))) := by
    simpa [repFlag] using seg_get hs (i := 1) (by simp [repFlag])
  obtain ⟨v, hv⟩ := hc 1 _ _ _ _ g
  cases hv

end Babbage.Minsky
