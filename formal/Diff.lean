import Babbage

/-!
# The Lean model, run: one side of the differential test

`lake exe diff FILE…` reads each deck written by `babbage control lean-cases`
(`src/difftest.rs`), runs it with `Babbage.step43` on exact fractions, which is
`Babbage.step` on every card of `Machine.lean` (`step43_lift`) and adds the
backing of Note G
(`ratArith`, `RatSize.lean`), and writes FILE.lean in the form the Rust side
writes FILE.rust. `scripts/lean-diff.sh` compares the two.

Nothing here is a theorem. The run is `step` itself, so what is compared is
the model the theorems are about; the loop around it only counts the cards.
-/

open Babbage

def parseRat (s : String) : Option Rat :=
  match s.splitOn "/" with
  | [n] => n.toInt?.map (fun v => (v : Rat))
  | [n, d] => do
    let n ← n.toInt?
    let d ← d.toNat?
    if d = 0 then none else some (mkRat n d)
  | _ => none

def parseSrc (s : String) : Option Src :=
  match s.toList with
  | 'c' :: r => (String.ofList r).toNat?.map Src.col
  | 'n' :: r => (String.ofList r).toInt?.map Src.num
  | _ => none

def parseOp : String → Option Op
  | "add" => some .add
  | "sub" => some .sub
  | "mul" => some .mul
  | "div" => some .div
  | _ => none

structure Case where
  cards : Array Card43 := #[]
  store : List (Nat × Rat) := []
  wheels : Option Nat := none
  fuel : Nat := 0
  trap : Bool := false

def parseLine (c : Case) (l : String) : Option Case :=
  match (l.splitOn " ").filter (· ≠ "") with
  | [] => some c
  | ["fuel", n] => n.toNat?.map fun n => { c with fuel := n }
  | ["trap"] => some { c with trap := true }
  | ["wheels", n] => n.toNat?.map fun n => { c with wheels := some n }
  | ["store", i, v] => do
    let i ← i.toNat?
    let v ← parseRat v
    some { c with store := c.store ++ [(i, v)] }
  | ["op", o, a, b, d] => do
    let card := Card.op (← parseOp o) (← parseSrc a) (← parseSrc b) (← d.toNat?)
    some { c with cards := c.cards.push (Card43.c card) }
  | ["rep", o, col, b, n] => do
    let card := Card.rep (← parseOp o) (← col.toNat?) (← parseSrc b) (← parseSrc n)
    some { c with cards := c.cards.push (Card43.c card) }
  | ["set", s] => do some { c with cards := c.cards.push (Card43.c (Card.set (← parseSrc s))) }
  | ["back", t, b] => do
    let t ← t.toNat?
    some { c with cards := c.cards.push (Card43.c (Card.back t (b == "1"))) }
  | ["backif", t, col] => do
    some { c with cards := c.cards.push (Card43.backIf (← t.toNat?) (← col.toNat?)) }
  | ["result", i] => do some { c with cards := c.cards.push (Card43.c (Card.result (← i.toNat?))) }
  | _ => none

/-- The card at `s` is an operation the mill cannot do (`Trapped`, decided). -/
def trapAt (d : Deck43) (s : State Rat) : Bool :=
  match d[s.pc]? with
  | some (.c (.op o a b _)) => (ratArith.op o (fetch ratArith s a) (fetch ratArith s b)).isNone
  | _ => false

/-- Note G: the backing is effective while the number is greater than zero. -/
def posRat (q : Rat) : Bool := decide (0 < q)

/-- `run43`, card by card, saying how it ended. -/
def exec (d : Deck43) (trap : Bool) : Nat → State Rat → String × Option (State Rat)
  | 0, s => (if d.length ≤ s.pc then "halt" else "running", some s)
  | n + 1, s =>
    match step43 ratArith posRat d s with
    | .run s' => exec d trap n s'
    | .halt s' => ("halt", some s')
    | .err => if trap && trapAt d s then ("trap", some s) else ("err", none)

def showRat (q : Rat) : String :=
  if q.den = 1 then toString q.num else s!"{q.num}/{q.den}"

def srcCols : Src → List Nat
  | .col i => [i]
  | .num _ => []

def cols : Card43 → List Nat
  | .c (.op _ a b d) => d :: srcCols a ++ srcCols b
  | .c (.rep _ c b n) => c :: srcCols b ++ srcCols n
  | .c (.set s) => srcCols s
  | .c (.result c) => [c]
  | .c (.back _ _) => []
  | .backIf _ c => [c]

def report (c : Case) : String :=
  let d := c.cards.toList
  let st0 : Nat → Rat := fun j => (c.store.reverse.find? (·.1 = j)).map (·.2) |>.getD 0
  let (status, s) := exec d c.trap c.fuel ⟨0, st0, c.wheels, []⟩
  match s with
  | none => status ++ "\n"
  | some s =>
    let all := (d.flatMap cols ++ c.store.map (·.1)).foldl max 0
    let store := (List.range (all + 1)).filter (fun j => s.store j ≠ 0)
      |>.map (fun j => s!"{j}={showRat (s.store j)}")
    s!"{status}\nout {" ".intercalate (s.out.map showRat)}\nstore {" ".intercalate store}\n"

def main (args : List String) : IO UInt32 := do
  let mut bad := 0
  for f in args do
    let text ← IO.FS.readFile f
    match (text.splitOn "\n").foldlM parseLine {} with
    | none => IO.eprintln s!"{f}: not read"; bad := bad + 1
    | some c => IO.FS.writeFile (f ++ ".lean") (report c)
  return if bad = 0 then 0 else 1
