import Babbage.Termination

/-!
# A deck that halts with 2↑↑n (refuting the first argument C)

`control/tower-halting.txt`, with n on the combinatorial wheels. Each pass of
the counted group computes 2^x by one multiplication repeated x times, the
count read from the store. The deck is accepted by the configuration of
December 1837, and for every n ≥ 1 it halts with the single result 2↑↑n.
So argument C, as first written in `docs/expressiveness.md`, is false for a
machine whose repetition count may come from the store.
-/

namespace Babbage

def intOp : Op → Int → Int → Option Int
  | .add, a, b => some (a + b)
  | .sub, a, b => some (a - b)
  | .mul, a, b => some (a * b)
  | .div, a, b => if b ≠ 0 ∧ b ∣ a then some (a / b) else none

def intCount (v : Int) : Option Nat := if 0 ≤ v then some v.toNat else none

/-- Whole numbers: + − × exactly, ÷ when exact; a count is a number ≥ 0. -/
def intArith : Arith Int := ⟨0, id, intOp, intCount⟩

@[simp] theorem intArith_op (o : Op) (a b : Int) : intArith.op o a b = intOp o a b := rfl
@[simp] theorem intArith_lit (v : Int) : intArith.lit v = v := rfl
@[simp] theorem intArith_count (v : Int) : intArith.count v = intCount v := rfl
@[simp] theorem intCount_nat (n : Nat) : intCount (n : Int) = some n := by
  simp [intCount]

/-- 2↑↑n: 2 raised to itself n times; 2↑↑0 = 1. -/
def tet : Nat → Nat
  | 0 => 1
  | n + 1 => 2 ^ tet n

/-- `pass: × v3 0 > v3; + v3 1 > v3; repeat × v3 2 times v1; + v3 0 > v1;
back pass counted; result v1`. -/
def towerDeck : Deck :=
  [.op .mul (.col 3) (.num 0) 3,
   .op .add (.col 3) (.num 1) 3,
   .rep .mul 3 (.num 2) (.col 1),
   .op .add (.col 3) (.num 0) 1,
   .back 0 true,
   .result 1]

theorem towerDeck_accepted : Accepts c1837 towerDeck := by
  intro i card h
  match i, h with
  | 0, h | 1, h | 2, h | 3, h | 5, h => simp [towerDeck] at h; subst h; trivial
  | 4, h =>
    simp [towerDeck] at h; subst h
    refine ⟨rfl, by omega, Or.inr rfl, fun _ _ j card' _ hj hj' => ?_⟩
    match j, hj with
    | 0, _ | 1, _ | 2, _ | 3, _ => simp [towerDeck] at hj'; subst hj'; rfl
  | i + 6, h => simp [towerDeck] at h

theorem iter_mul_two (k : Nat) (x : Int) :
    iter intArith .mul 2 k x = some (x * 2 ^ k) := by
  induction k generalizing x with
  | zero => simp [iter]
  | succ k ih =>
    simp only [iter, intArith_op, intOp, Option.bind_some, ih]
    rw [Int.pow_succ, Int.mul_assoc, Int.mul_comm 2 (2 ^ k)]

theorem pass (x : Nat) (st : Nat → Int) (h1 : st 1 = x) (w : Nat) (out : List Int) :
    ∃ st', st' 1 = ((2 ^ x : Nat) : Int) ∧
      run intArith towerDeck 4 ⟨0, st, some (w + 1), out⟩ = .run ⟨4, st', some (w + 1), out⟩ := by
  refine ⟨upd (upd (upd (upd st 3 0) 3 1) 3 (2 ^ x)) 1 (2 ^ x), by simp [upd], ?_⟩
  simp [run, step, towerDeck, fetch, intOp, upd, h1, iter_mul_two]

/-- x, 2^x, 2^2^x, …: `k` times. -/
def exp2 : Nat → Nat → Nat
  | 0, x => x
  | k + 1, x => exp2 k (2 ^ x)

theorem exp2_pow (k x : Nat) : exp2 k (2 ^ x) = 2 ^ exp2 k x := by
  induction k generalizing x with
  | zero => rfl
  | succ k ih => simp only [exp2]; exact ih _

theorem tet_eq_exp2 (n : Nat) : tet n = exp2 n 1 := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [tet, exp2, ih]; exact (exp2_pow n 1).symm

/-- With x in v1 and w + 1 on the wheels at card 0, the deck halts with the
single result 2^2^…^x (w + 1 times). -/
theorem loop (w : Nat) : ∀ (x : Nat) (st : Nat → Int) (out : List Int), st 1 = x →
    ∃ n st' wh, run intArith towerDeck n ⟨0, st, some (w + 1), out⟩ =
      .halt ⟨6, st', wh, out ++ [((exp2 (w + 1) x : Nat) : Int)]⟩ := by
  induction w with
  | zero =>
    intro x st out h1
    obtain ⟨st', h1', h4⟩ := pass x st h1 0 out
    refine ⟨4 + 3, st', some 0, ?_⟩
    rw [run_add, h4]
    simp [run, step, towerDeck, h1', exp2]
  | succ w ih =>
    intro x st out h1
    obtain ⟨st', h1', h4⟩ := pass x st h1 (w + 1) out
    obtain ⟨n, st'', wh, hn⟩ := ih (2 ^ x) st' out h1'
    refine ⟨4 + (1 + n), st'', wh, ?_⟩
    rw [run_add, h4]
    simp only
    rw [run_add]
    simp only [run, step]
    simp only [towerDeck] at hn ⊢
    simpa [exp2] using hn

/-- The deck is accepted by the configuration of December 1837 and, for every
n ≥ 1 put on the wheels, halts with the single result 2↑↑n. -/
theorem tower_halts (n : Nat) (hn : 1 ≤ n) :
    Accepts c1837 towerDeck ∧
    ∃ k st' wh, run intArith towerDeck k
        ⟨0, fun j => if j = 1 then 1 else 0, some n, []⟩ =
      .halt ⟨6, st', wh, [((tet n : Nat) : Int)]⟩ := by
  refine ⟨towerDeck_accepted, ?_⟩
  obtain ⟨w, rfl⟩ : ∃ w, n = w + 1 := ⟨n - 1, by omega⟩
  obtain ⟨k, st', wh, h⟩ := loop w 1 (fun j => if j = 1 then 1 else 0) [] (by simp)
  exact ⟨k, st', wh, by rw [tet_eq_exp2]; simpa using h⟩

end Babbage
