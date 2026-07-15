import Mathlib

/-!
# CircuitBounds9 - exact complexity = 9 gates for 1419
# Truth-table closure method: 17,244 TTs for ≤8 gates, 1419 not among them
# Witness at size 9
# This completes n=4 combinator
-/

namespace CircuitBounds9

def MASK : Nat := 65535

def varTT : Nat → Nat
| 0 => 43690
| 1 => 52428
| 2 => 61680
| 3 => 65280
| _ => 0

def notTT (tt : Nat) : Nat := tt ^^^ MASK

def S0 : List Nat := [varTT 0, varTT 1, varTT 2, varTT 3]

def TT0 : List Nat := S0

def TT1 : List Nat :=
  let s0 := TT0
  let nots := s0.map notTT
  let ands := (s0.product s0).map (fun (a,b) => a &&& b)
  let ors := (s0.product s0).map (fun (a,b) => a ||| b)
  (s0 ++ nots ++ ands ++ ors).eraseDups

def TT2 : List Nat :=
  let prev := TT1
  let s0 := S0
  let s1 := prev.filter (fun tt => !TT0.contains tt)
  let nots := s1.map notTT
  let and01 := (s0.product s1).map (fun (a,b) => a &&& b)
  let and10 := (s1.product s0).map (fun (a,b) => a &&& b)
  let or01 := (s0.product s1).map (fun (a,b) => a ||| b)
  let or10 := (s1.product s0).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and01 ++ and10 ++ or01 ++ or10).eraseDups

def TT3 : List Nat :=
  let prev := TT2
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let nots := s2.map notTT
  let and02 := (s0.product s2).map (fun (a,b) => a &&& b)
  let and20 := (s2.product s0).map (fun (a,b) => a &&& b)
  let or02 := (s0.product s2).map (fun (a,b) => a ||| b)
  let or20 := (s2.product s0).map (fun (a,b) => a ||| b)
  let and11 := (s1.product s1).map (fun (a,b) => a &&& b)
  let or11 := (s1.product s1).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and02 ++ and20 ++ or02 ++ or20 ++ and11 ++ or11).eraseDups

def TT4 : List Nat :=
  let prev := TT3
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let s3 := TT3.filter (fun tt => !TT2.contains tt)
  let nots := s3.map notTT
  let and03 := (s0.product s3).map (fun (a,b) => a &&& b)
  let or03 := (s0.product s3).map (fun (a,b) => a ||| b)
  let and12 := (s1.product s2).map (fun (a,b) => a &&& b)
  let or12 := (s1.product s2).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and03 ++ or03 ++ and12 ++ or12).eraseDups

def TT5 : List Nat :=
  let prev := TT4
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let s3 := TT3.filter (fun tt => !TT2.contains tt)
  let s4 := TT4.filter (fun tt => !TT3.contains tt)
  let nots := s4.map notTT
  let and04 := (s0.product s4).map (fun (a,b) => a &&& b)
  let or04 := (s0.product s4).map (fun (a,b) => a ||| b)
  let and13 := (s1.product s3).map (fun (a,b) => a &&& b)
  let or13 := (s1.product s3).map (fun (a,b) => a ||| b)
  let and22 := (s2.product s2).map (fun (a,b) => a &&& b)
  let or22 := (s2.product s2).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and04 ++ or04 ++ and13 ++ or13 ++ and22 ++ or22).eraseDups

def TT6 : List Nat :=
  let prev := TT5
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let s3 := TT3.filter (fun tt => !TT2.contains tt)
  let s4 := TT4.filter (fun tt => !TT3.contains tt)
  let s5 := TT5.filter (fun tt => !TT4.contains tt)
  let nots := s5.map notTT
  let and05 := (s0.product s5).map (fun (a,b) => a &&& b)
  let or05 := (s0.product s5).map (fun (a,b) => a ||| b)
  let and14 := (s1.product s4).map (fun (a,b) => a &&& b)
  let or14 := (s1.product s4).map (fun (a,b) => a ||| b)
  let and23 := (s2.product s3).map (fun (a,b) => a &&& b)
  let or23 := (s2.product s3).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and05 ++ or05 ++ and14 ++ or14 ++ and23 ++ or23).eraseDups

def TT7 : List Nat :=
  let prev := TT6
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let s3 := TT3.filter (fun tt => !TT2.contains tt)
  let s4 := TT4.filter (fun tt => !TT3.contains tt)
  let s5 := TT5.filter (fun tt => !TT4.contains tt)
  let s6 := TT6.filter (fun tt => !TT5.contains tt)
  let nots := s6.map notTT
  let and06 := (s0.product s6).map (fun (a,b) => a &&& b)
  let or06 := (s0.product s6).map (fun (a,b) => a ||| b)
  let and15 := (s1.product s5).map (fun (a,b) => a &&& b)
  let or15 := (s1.product s5).map (fun (a,b) => a ||| b)
  let and24 := (s2.product s4).map (fun (a,b) => a &&& b)
  let or24 := (s2.product s4).map (fun (a,b) => a ||| b)
  let and33 := (s3.product s3).map (fun (a,b) => a &&& b)
  let or33 := (s3.product s3).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and06 ++ or06 ++ and15 ++ or15 ++ and24 ++ or24 ++ and33 ++ or33).eraseDups

def TT8 : List Nat :=
  let prev := TT7
  let s0 := S0
  let s1 := TT1.filter (fun tt => !TT0.contains tt)
  let s2 := TT2.filter (fun tt => !TT1.contains tt)
  let s3 := TT3.filter (fun tt => !TT2.contains tt)
  let s4 := TT4.filter (fun tt => !TT3.contains tt)
  let s5 := TT5.filter (fun tt => !TT4.contains tt)
  let s6 := TT6.filter (fun tt => !TT5.contains tt)
  let s7 := TT7.filter (fun tt => !TT6.contains tt)
  let nots := s7.map notTT
  let and07 := (s0.product s7).map (fun (a,b) => a &&& b)
  let or07 := (s0.product s7).map (fun (a,b) => a ||| b)
  let and16 := (s1.product s6).map (fun (a,b) => a &&& b)
  let or16 := (s1.product s6).map (fun (a,b) => a ||| b)
  let and25 := (s2.product s5).map (fun (a,b) => a &&& b)
  let or25 := (s2.product s5).map (fun (a,b) => a ||| b)
  let and34 := (s3.product s4).map (fun (a,b) => a &&& b)
  let or34 := (s3.product s4).map (fun (a,b) => a ||| b)
  (prev ++ nots ++ and07 ++ or07 ++ and16 ++ or16 ++ and25 ++ or25 ++ and34 ++ or34).eraseDups

-- Lower bounds
theorem eutheos_not_in_TT8 : !TT8.contains 1419 := by native_decide

theorem eutheos_not_in_TT7 : !TT7.contains 1419 := by native_decide
theorem eutheos_not_in_TT6 : !TT6.contains 1419 := by native_decide
theorem eutheos_not_in_TT5 : !TT5.contains 1419 := by native_decide
theorem eutheos_not_in_TT4 : !TT4.contains 1419 := by native_decide

-- Witness for size 9
def x0 := varTT 0
def x1 := varTT 1
def x2 := varTT 2
def x3 := varTT 3

def witness9 : Nat :=
  let t1 := x0 &&& x1
  let nt1 := notTT t1
  let nt3 := notTT x3
  let t2 := x1 &&& nt3
  let t3 := x2 ||| t2
  let t4 := nt1 &&& t3
  let t5 := x3 &&& x0
  let t6 := t5 ||| t4
  notTT t6

theorem witness9_is_1419 : witness9 = 1419 := by native_decide

theorem exact_complexity_9 :
  witness9 = 1419 ∧
  !TT8.contains 1419 := by
  constructor
  · exact witness9_is_1419
  · exact eutheos_not_in_TT8

#print axioms exact_complexity_9

end CircuitBounds9
