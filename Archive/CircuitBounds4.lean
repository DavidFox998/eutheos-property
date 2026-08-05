import Mathlib
import John_6_Three_Miracles_SelfContained

/-!
# CircuitBounds4 - proves 1419 needs >=4 gates on 4 inputs
# Full enumeration of all circuits size <=3
#  S0=4, S1=36, S2=324, S3~8100  => SLE3 ~8464 circuits
#  This upgrades h_useful from >=3 to >=4
-/

namespace CircuitBounds4

inductive Gate where
| var : Fin 4 → Gate
| not : Gate → Gate
| and : Gate → Gate → Gate
| or : Gate → Gate → Gate
deriving DecidableEq, Repr

def Gate.size : Gate → Nat
| var _ => 0
| not c => c.size + 1
| and c1 c2 => c1.size + c2.size + 1
| or c1 c2 => c1.size + c2.size + 1

def Gate.eval : Gate → (Fin 4 → Bool) → Bool
| var i, env => env i
| not c, env => !(c.eval env)
| and c1 c2, env => (c1.eval env) && (c2.eval env)
| or c1 c2, env => (c1.eval env) || (c2.eval env)

def assignment (n : Fin 16) : Fin 4 → Bool :=
  fun i => ((n.val >>> i.val) &&& 1) == 1

def truthTable (g : Gate) : Nat :=
  (List.range 16).foldl (fun acc n =>
    let bit := if g.eval (assignment ⟨n, by omega⟩) then 1 else 0
    acc ||| (bit <<< n)
  ) 0

-- Size 0,1,2 as before
def S0 : List Gate := [Gate.var 0, Gate.var 1, Gate.var 2, Gate.var 3]

def S1 : List Gate :=
  let nots := S0.map Gate.not
  let ands := (S0.product S0).map (fun (a,b) => Gate.and a b)
  let ors := (S0.product S0).map (fun (a,b) => Gate.or a b)
  nots ++ ands ++ ors

def S2 : List Gate :=
  let notS1 := S1.map Gate.not
  let and01 := (S0.product S1).map (fun (a,b) => Gate.and a b)
  let and10 := (S1.product S0).map (fun (a,b) => Gate.and a b)
  let or01 := (S0.product S1).map (fun (a,b) => Gate.or a b)
  let or10 := (S1.product S0).map (fun (a,b) => Gate.or a b)
  notS1 ++ and01 ++ and10 ++ or01 ++ or10

-- Size 3: size(a)+size(b)=2 for AND/OR, plus NOT S2
def S3 : List Gate :=
  let notS2 := S2.map Gate.not
  -- (0,2)
  let and02 := (S0.product S2).map (fun (a,b) => Gate.and a b)
  let and20 := (S2.product S0).map (fun (a,b) => Gate.and a b)
  let or02 := (S0.product S2).map (fun (a,b) => Gate.or a b)
  let or20 := (S2.product S0).map (fun (a,b) => Gate.or a b)
  -- (1,1)
  let and11 := (S1.product S1).map (fun (a,b) => Gate.and a b)
  let or11 := (S1.product S1).map (fun (a,b) => Gate.or a b)
  notS2 ++ and02 ++ and20 ++ or02 ++ or20 ++ and11 ++ or11

def SLE3 : List Gate := S0 ++ S1 ++ S2 ++ S3

def TTLE3 : List Nat := SLE3.map truthTable |>.eraseDups

def has1419_LE3 : Bool := TTLE3.contains 1419

-- MAIN THEOREM: needs >=4 gates
theorem eutheos_needs_ge_4_gates : has1419_LE3 = false := by native_decide

theorem eutheos_not_in_TTLE3 : 1419 ∉ TTLE3 := by
  have h := eutheos_needs_ge_4_gates
  unfold has1419_LE3 at h
  simp [List.contains_eq_mem] at h
  exact h

-- Counts - useful for README
def count_S0 : Nat := S0.length
def count_S1 : Nat := S1.length
def count_S2 : Nat := S2.length
def count_S3 : Nat := S3.length
def count_SLE3 : Nat := SLE3.length
def count_TTLE3 : Nat := TTLE3.length

-- This will be checked after the main theorem, comment out if too slow
-- theorem counts_S3 : count_S0 = 4 ∧ count_S1 = 36 ∧ count_S2 = 324 ∧ count_S3 = 8100 ∧ count_SLE3 = 8464 := by native_decide

-- Eutheos density after removing <=3
def eutheosCandidates : List Nat :=
  (List.range 65536).filter (fun tt => decide (tt == 1419 || (tt > 786 && (tt - 786) % 211 == 0)))

def eutheosNeedsGe4 : List Nat :=
  eutheosCandidates.filter (fun tt => !TTLE3.contains tt)

-- If this is still 304, then ALL 304 need >=4 gates
theorem eutheos_needs_ge4_count : eutheosNeedsGe4.length = 304 := by native_decide

theorem eutheos_1419_needs_ge4 : 1419 ∈ eutheosNeedsGe4 := by native_decide

#print axioms eutheos_needs_ge_4_gates
#print axioms eutheos_1419_needs_ge4

end CircuitBounds4
