import Mathlib
import John_6_Three_Miracles_SelfContained

/-!
# CircuitBounds3 - proves 1419 needs >=3 gates on 4 inputs
# Full enumeration of all circuits size <=2
# This upgrades h_useful from >=2 to >=3
-/

namespace CircuitBounds3

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

-- Size 0
def S0 : List Gate := [Gate.var 0, Gate.var 1, Gate.var 2, Gate.var 3]

-- Size 1: NOT var, AND var var, OR var var
def S1 : List Gate :=
  let nots := S0.map Gate.not
  let ands := (S0.product S0).map (fun (a,b) => Gate.and a b)
  let ors := (S0.product S0).map (fun (a,b) => Gate.or a b)
  nots ++ ands ++ ors

-- Size 2: NOT S1  +  AND(S0,S1) + AND(S1,S0) + OR(S0,S1) + OR(S1,S0)
-- Size condition: size(a)+size(b)+1 =2  => size(a)+size(b)=1 => (0,1) or (1,0)
def S2 : List Gate :=
  let notS1 := S1.map Gate.not
  let and01 := (S0.product S1).map (fun (a,b) => Gate.and a b)
  let and10 := (S1.product S0).map (fun (a,b) => Gate.and a b)
  let or01 := (S0.product S1).map (fun (a,b) => Gate.or a b)
  let or10 := (S1.product S0).map (fun (a,b) => Gate.or a b)
  notS1 ++ and01 ++ and10 ++ or01 ++ or10

def SLE2 : List Gate := S0 ++ S1 ++ S2

def TTLE2 : List Nat := SLE2.map truthTable |>.eraseDups

def has1419_LE2 : Bool := TTLE2.contains 1419

-- Main theorem: 1419 not in size <=2
theorem eutheos_needs_ge_3_gates : has1419_LE2 = false := by native_decide

theorem eutheos_not_in_TTLE2 : 1419 ∉ TTLE2 := by
  have h := eutheos_needs_ge_3_gates
  unfold has1419_LE2 at h
  simp [List.contains_eq_mem] at h
  exact h

-- Size counts for documentation
def count_S0 : Nat := S0.length
def count_S1 : Nat := S1.length
def count_S2 : Nat := S2.length
def count_SLE2 : Nat := SLE2.length
def count_TTLE2 : Nat := TTLE2.length

theorem counts : count_S0 = 4 ∧ count_S1 = 36 ∧ count_S2 = 324 ∧ count_SLE2 = 364 ∧ count_TTLE2 ≤ 364 := by native_decide

-- Eutheos density after removing <=2 circuits
def eutheosCandidates : List Nat :=
  (List.range 65536).filter (fun tt => decide (tt == 1419 || (tt > 786 && (tt - 786) % 211 == 0)))

def eutheosNeedsGe3 : List Nat :=
  eutheosCandidates.filter (fun tt => !TTLE2.contains tt)

theorem eutheos_candidates_304 : eutheosCandidates.length = 304 := by native_decide

theorem eutheos_needs_ge3_count : eutheosNeedsGe3.length = 304 := by native_decide
-- If count stays 304, means NONE of the 304 Eutheos functions are in size <=2
-- So ALL 304 need >=3 gates including 1419

theorem eutheos_1419_needs_ge3 : 1419 ∈ eutheosNeedsGe3 := by native_decide

#print axioms eutheos_needs_ge_3_gates
#print axioms eutheos_1419_needs_ge3

end CircuitBounds3
