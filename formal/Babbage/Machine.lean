/-!
# The control machine of the Sketch Books

A Lean model of `src/sketch.rs`: cards act on a store and on one set of
combinatorial wheels. The model is generic in the numbers the mill holds
(`Arith`): the termination theorems hold whatever they are, and the growth
theorem needs only a bound on what one operation of the mill can make.

Idealisations, against `src/sketch.rs`: an operation card writes one column
(the Rust card may write several); a result card always retains its column;
letters and rows of letter cards are left out. None of these changes what
can be computed with whole numbers.
-/

namespace Babbage

inductive Op where
  | add | sub | mul | div
  deriving DecidableEq, Repr

/-- What a variable card brings to the mill: a store column, or a number card. -/
inductive Src where
  | col (i : Nat)
  | num (v : Int)

inductive Card where
  /-- An operation card: `dst := a o b`. -/
  | op (o : Op) (a b : Src) (dst : Nat)
  /-- One operation repeated `n` times: `c := c o b`, `n` times (7 Mar 1836). -/
  | rep (o : Op) (c : Nat) (b : Src) (n : Src)
  /-- A combinatorial card: a number put on the combinatorial wheels. -/
  | set (s : Src)
  /-- A backing card to card `t`: `counted` subtracts unity from the wheels and
  is ineffective when they come to 0; otherwise it always backs. -/
  | back (t : Nat) (counted : Bool)
  /-- A result: the number in column `c` given off. -/
  | result (c : Nat)

abbrev Deck := List Card

/-- The numbers of the mill: a zero, the number cards, the four operations
(`none` when undefined, such as division by zero) and how a number is read
as a count (`none` when it is not a whole number ≥ 0). -/
structure Arith (V : Type) where
  zero : V
  lit : Int → V
  op : Op → V → V → Option V
  count : V → Option Nat

structure State (V : Type) where
  pc : Nat
  store : Nat → V
  wheels : Option Nat
  out : List V

inductive Res (V : Type) where
  | run (s : State V)
  | halt (s : State V)
  | err

variable {V : Type}

def fetch (A : Arith V) (s : State V) : Src → V
  | .col i => s.store i
  | .num v => A.lit v

def upd (f : Nat → V) (i : Nat) (v : V) : Nat → V :=
  fun j => if j = i then v else f j

/-- `x o b o b …`, `k` times. -/
def iter (A : Arith V) (o : Op) (b : V) : Nat → V → Option V
  | 0, x => some x
  | k + 1, x => (A.op o x b).bind (iter A o b k)

def step (A : Arith V) (d : Deck) (s : State V) : Res V :=
  match d[s.pc]? with
  | none => .halt s
  | some (.op o a b dst) =>
    match A.op o (fetch A s a) (fetch A s b) with
    | some r => .run { s with pc := s.pc + 1, store := upd s.store dst r }
    | none => .err
  | some (.rep o c b n) =>
    match A.count (fetch A s n) with
    | none => .err
    | some k =>
      match iter A o (fetch A s b) k (s.store c) with
      | some r => .run { s with pc := s.pc + 1, store := upd s.store c r }
      | none => .err
  | some (.set src) =>
    match A.count (fetch A s src) with
    | some (k + 1) => .run { s with pc := s.pc + 1, wheels := some (k + 1) }
    | _ => .err
  | some (.back t false) => .run { s with pc := t }
  | some (.back t true) =>
    match s.wheels with
    | some (w + 2) => .run { s with pc := t, wheels := some (w + 1) }
    | some 1 => .run { s with pc := s.pc + 1, wheels := some 0 }
    | _ => .err
  | some (.result c) => .run { s with pc := s.pc + 1, out := s.out ++ [s.store c] }

/-- `n` cards from `s`. -/
def run (A : Arith V) (d : Deck) : Nat → State V → Res V
  | 0, s => .run s
  | n + 1, s =>
    match step A d s with
    | .run s' => run A d n s'
    | r => r

/-- The run from `s` comes to an end: it halts, or an operation fails. -/
def Ends (A : Arith V) (d : Deck) (s : State V) : Prop :=
  ∃ n, run A d n s = .err ∨ ∃ s', run A d n s = .halt s'

def Halts (A : Arith V) (d : Deck) (s : State V) : Prop :=
  ∃ n s', run A d n s = .halt s'

/-! ## The configurations -/

structure Config where
  /-- Combinatorial cards and backing cards (Dec 1837). -/
  backing : Bool
  /-- Backing to any card (30 May 1838); otherwise only to card 0. -/
  anyTarget : Bool
  /-- A combinatorial card among the cards a counted backing repeats: no page
  read gives this. -/
  setInGroup : Bool

def c1836 : Config := ⟨false, false, false⟩
def c1837 : Config := ⟨true, false, false⟩
def c1838 : Config := ⟨true, true, false⟩
def cNotFound : Config := ⟨true, true, true⟩

def isSet : Card → Bool
  | .set _ => true
  | _ => false

/-- The rule of `accepts` in `src/sketch.rs`, with the reader's rule that a
backing goes back. -/
def Accepts (c : Config) (d : Deck) : Prop :=
  ∀ i card, d[i]? = some card →
    match card with
    | Card.set _ => c.backing = true
    | Card.back t counted =>
      c.backing = true ∧ t ≤ i ∧ (c.anyTarget = true ∨ t = 0) ∧
      (counted = true → c.setInGroup = false →
        ∀ j card', t ≤ j → j < i → d[j]? = some card' → isSet card' = false)
    | _ => True

theorem run_add (A : Arith V) (d : Deck) (a b : Nat) (s : State V) :
    run A d (a + b) s =
      match run A d a s with
      | .run s' => run A d b s'
      | r => r := by
  induction a generalizing s with
  | zero => simp [run]
  | succ a ih =>
    rw [Nat.add_right_comm, run, run]
    cases step A d s with
    | run s' => exact ih s'
    | halt s' => rfl
    | err => rfl

end Babbage
