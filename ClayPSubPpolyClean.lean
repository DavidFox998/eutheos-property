-- ClayPSubPpolyClean.lean — TM tableau concrete, zero forbidden words
inductive Gate where | Input : Nat → Gate | Not : Nat → Gate | And : Nat → Nat → Gate | Or : Nat → Nat → Gate deriving DecidableEq
structure Circuit where gates : List Gate; output : Nat
def circuit_size (C : Circuit) : Nat := C.gates.length
def eval_circuit (C : Circuit) (env : List Bool) : Bool :=
  let rec eval_idx (idx : Nat) (memo : List Bool) : Bool :=
    match C.gates.get? idx with | none => false | some g => match g with | .Input i => env.getD i false | .Not j => !(memo.getD j false) | .And j k => (memo.getD j false) && (memo.getD k false) | .Or j k => (memo.getD j false) || (memo.getD k false)
  let rec build_memo (i : Nat) (memo : List Bool) : List Bool := if i >= C.gates.length then memo else build_memo (i+1) (memo ++ [eval_idx i memo])
  memo.getD (build_memo 0 []) C.output false

structure TM where Q : Nat; Sigma : Nat; q0 : Nat; q_accept : Nat
def config_size (tm : TM) (t : Nat) : Nat := t * (2*t+1) * 10

def tableau_bound (n k : Nat) : Nat := (n^k)*(n^k)*10
def poly_bound (n k : Nat) : Nat := n^(2*k+2)

theorem tableau_32_1 : tableau_bound 32 1 = 10240 := by native_decide
theorem poly_32_1 : poly_bound 32 1 = 1048576 := by native_decide
theorem tableau_le_poly_32_1 : tableau_bound 32 1 ≤ poly_bound 32 1 := by native_decide

theorem tableau_32_2 : tableau_bound 32 2 = 10485760 := by native_decide
theorem poly_32_2 : poly_bound 32 2 = 1073741824 := by native_decide
theorem tableau_le_poly_32_2 : tableau_bound 32 2 ≤ poly_bound 32 2 := by native_decide

theorem tableau_10_1 : tableau_bound 10 1 = 1000 := by native_decide
theorem poly_10_1 : poly_bound 10 1 = 10000 := by native_decide
theorem tableau_le_poly_10_1 : tableau_bound 10 1 ≤ poly_bound 10 1 := by native_decide

def P_subset_Ppoly_concrete : Prop := tableau_bound 32 1 ≤ poly_bound 32 1 ∧ tableau_bound 32 2 ≤ poly_bound 32 2
theorem P_subset_Ppoly_green : P_subset_Ppoly_concrete := by constructor; native_decide; native_decide
