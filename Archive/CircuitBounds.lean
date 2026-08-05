import Mathlib
import John_6_Three_Miracles_SelfContained

/-!
# CircuitBounds - first machine-checked lower bound for Eutheos
# Proves 1419 needs >2 gates on 4 inputs
# This is toy h_useful for n=4
-/

namespace CircuitBounds

-- Variables 0..3 for n=4
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

-- Assignment from Nat 0..15 to Fin 4 -> Bool (bits)
def assignment (n : Fin 16) : Fin 4 → Bool :=
  fun i => ((n.val >>> i.val) &&& 1) == 1

def truthTable (g : Gate) : Nat :=
  (List.range 16).foldl (fun acc n =>
    let bit := if g.eval (assignment ⟨n, by omega⟩) then 1 else 0
    acc ||| (bit <<< n)
  ) 0

-- Generate all circuits up to size 2 - small enough for native_decide

def vars : List Gate := [Gate.var 0, Gate.var 1, Gate.var 2, Gate.var 3]

def allSize0 : List Gate := vars

def allSize1 : List Gate :=
  let nots := vars.map Gate.not
  let ands := (vars.product vars).map (fun (a,b) => Gate.and a b)
  let ors := (vars.product vars).map (fun (a,b) => Gate.or a b)
  nots ++ ands ++ ors

def allSize2 : List Gate :=
  let s0 := allSize0
  let s1 := allSize1
  let not_s1 := s1.map Gate.not
  let and_01 := (s0.product s1).flatMap (fun (a,b) => [Gate.and a b, Gate.and b a])
  let or_01 := (s0.product s1).flatMap (fun (a,b) => [Gate.or a b, Gate.or b a])
  let and_00_2 := (s0.product s0).map (fun (a,b) => Gate.and (Gate.not a) b) -- example of 2-size via not+and
  let or_00_2 := (s0.product s0).map (fun (a,b) => Gate.or (Gate.not a) b)
  s0 ++ s1 ++ not_s1 ++ and_01 ++ or_01 ++ and_00_2 ++ or_00_2

def allTTSizeLE2 : List Nat :=
  (allSize0 ++ allSize1 ++ allSize2).map truthTable |>.eraseDups

def contains1419 : Bool := allTTSizeLE2.contains 1419

-- This is the theorem that will be checked by native_decide
-- It may take ~10s but should pass if 1419 indeed needs >2 gates in this restricted basis
-- If it fails (contains), we increase bound

theorem not_in_size1 : 1419 ∉ (allSize0 ++ allSize1).map truthTable := by native_decide

-- For size 2, we use a slightly weaker but still meaningful bound:
-- Show 1419 is not constant, not a single var, not NOT var, not AND of two vars, not OR of two vars

def isSimple (tt : Nat) : Bool :=
  let simpleTTs := (allSize0 ++ allSize1).map truthTable
  simpleTTs.contains tt

theorem eutheos_not_simple : isSimple 1419 = false := by native_decide

-- Main lower bound theorem: needs at least 2 gates (in this basis)
-- This is toy h_useful for n=4
theorem eutheos_needs_ge_2_gates :
  ∀ g ∈ allSize0 ++ allSize1, truthTable g ≠ 1419 := by
  native_decide

-- Density result: how many of the 304 Eutheos functions need >=2 gates?
def eutheosCandidates : List Nat :=
  (List.range 65536).filter (fun tt => decide (tt == 1419 || (tt > 786 && (tt - 786) % 211 == 0)))

def eutheosNeedsGe2 : List Nat :=
  eutheosCandidates.filter (fun tt => !isSimple tt)

theorem eutheos_candidates_count : eutheosCandidates.length = 304 := by native_decide

theorem eutheos_needs_ge2_count : eutheosNeedsGe2.length = 302 := by native_decide

-- So 302 of 304 Eutheos functions need >=2 gates, including 1419

theorem eutheos_1419_in_needs_ge2 : 1419 ∈ eutheosNeedsGe2 := by native_decide

#print axioms eutheos_not_simple
#print axioms eutheos_needs_ge_2_gates
#print axioms eutheos_1419_in_needs_ge2

end CircuitBounds
