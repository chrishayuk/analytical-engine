import Babbage.Minsky
import Babbage.RatSize

/-!
# An operation with several destinations

`src/sketch.rs` lets an operation card write its result to several columns
(`× v2 v3 > v4 v5 v6`, Note G's Operation 1): the result goes to each in turn.
The Lean card writes one. `run_expand` shows the translation the differential
test uses (`src/difftest.rs`): the operation into the first column, then one
card per further column copying it (`+ vd₁ 0 > vdⱼ`). Run from its first card,
the expanded block leaves the store exactly as the Rust card does, for any
numbers in which adding 0 changes nothing. It passes more cards, and the mill
does more additions; nothing else differs.
-/

namespace Babbage

variable {V : Type}

/-- The cards for `o a b > d₁ ds…`. -/
def expand (o : Op) (a b : Src) (d1 : Nat) (ds : List Nat) : List Card :=
  .op o a b d1 :: ds.map (fun dj => .op .add (.col d1) (.num 0) dj)

/-- The result written to each column in turn, as the Rust card does. -/
def updAll (f : Nat → V) (ds : List Nat) (r : V) : Nat → V :=
  ds.foldl (fun g d => upd g d r) f

theorem updAll_at (f : Nat → V) (r : V) (x : Nat) (hx : f x = r) :
    ∀ ds : List Nat, updAll f ds r x = r := by
  intro ds
  induction ds generalizing f with
  | nil => exact hx
  | cons d ds ih =>
    show updAll (upd f d r) ds r x = r
    apply ih
    by_cases h : x = d
    · subst h; simp [upd]
    · simp [upd, h, hx]

open Minsky in
theorem run_copies (A : Arith V) (hcopy : ∀ x, A.op .add x (A.lit 0) = some x) {d : Deck}
    (d1 : Nat) (r : V) (wh : Option Nat) (out : List V) :
    ∀ (ds : List Nat) (p : Nat) (f : Nat → V), f d1 = r →
      Seg d p (ds.map (fun dj => Card.op .add (.col d1) (.num 0) dj)) →
      run A d ds.length ⟨p, f, wh, out⟩ = .run ⟨p + ds.length, updAll f ds r, wh, out⟩ := by
  intro ds
  induction ds with
  | nil => intro p f _ _; simp [run, updAll]
  | cons dj ds ih =>
    intro p f hf hseg
    have g : d[p]? = some (.op .add (.col d1) (.num 0) dj) := by
      simpa using hseg 0 (by simp)
    have hrest : Seg d (p + 1) (ds.map (fun dj => Card.op .add (.col d1) (.num 0) dj)) := by
      intro i hi
      have := hseg (i + 1) (by simp at hi ⊢; omega)
      rw [show p + 1 + i = p + (i + 1) by omega, this]; simp
    have hf' : (upd f dj r) d1 = r := by
      by_cases h : d1 = dj
      · subst h; simp [upd]
      · simp [upd, h, hf]
    have hs : step A d ⟨p, f, wh, out⟩ = .run ⟨p + 1, upd f dj r, wh, out⟩ := by
      simp [step, g, fetch, hf, hcopy]
    simp only [List.length_cons, run, hs]
    rw [ih (p + 1) _ hf' hrest]
    simp [updAll, Nat.add_assoc, Nat.add_comm 1]

open Minsky in
/-- **The expanded block does what the card with several destinations does.** -/
theorem run_expand (A : Arith V) (hcopy : ∀ x, A.op .add x (A.lit 0) = some x) {d : Deck}
    {p : Nat} {o : Op} {a b : Src} {d1 : Nat} {ds : List Nat} (hseg : Seg d p (expand o a b d1 ds))
    {st : Nat → V} {wh : Option Nat} {out : List V} {r : V}
    (hr : A.op o (fetch A ⟨p, st, wh, out⟩ a) (fetch A ⟨p, st, wh, out⟩ b) = some r) :
    run A d (ds.length + 1) ⟨p, st, wh, out⟩ =
      .run ⟨p + (ds.length + 1), updAll st (d1 :: ds) r, wh, out⟩ := by
  have g : d[p]? = some (.op o a b d1) := by simpa [expand] using hseg 0 (by simp [expand])
  have hrest : Seg d (p + 1) (ds.map (fun dj => Card.op .add (.col d1) (.num 0) dj)) := by
    intro i hi
    have := hseg (i + 1) (by simp [expand] at hi ⊢; omega)
    rw [show p + 1 + i = p + (i + 1) by omega, this]; simp [expand]
  have hs : step A d ⟨p, st, wh, out⟩ = .run ⟨p + 1, upd st d1 r, wh, out⟩ := by
    simp [step, g, hr]
  rw [Nat.add_comm ds.length 1, run_add]
  simp only [run, hs]
  rw [run_copies A hcopy d1 r wh out ds (p + 1) _ (by simp [upd]) hrest]
  simp [updAll, Nat.add_assoc]

/-- Whole numbers and fractions satisfy `hcopy`. -/
theorem intArith_copy : ∀ x : Int, intArith.op .add x (intArith.lit 0) = some x := by
  intro x; simp [intOp]

theorem ratArith_copy : ∀ x : Rat, ratArith.op .add x (ratArith.lit 0) = some x := by
  intro x; simp [ratArith, ratOp, Rat.add_zero]

end Babbage
