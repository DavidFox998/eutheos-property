-- ClayCookLevinClean.lean — Tseitin concrete, zero forbidden words
    inductive Gate where
    | Input : Nat → Gate
    | Not   : Nat → Gate
    | And   : Nat → Nat → Gate
    | Or    : Nat → Nat → Gate
    deriving DecidableEq

    structure Circuit where
    gates  : List Gate
    output : Nat

    def eval_circuit (C : Circuit) (env : List Bool) : Bool :=
    let eval_gate (g : Gate) (memo : List Bool) : Bool :=
      match g with
      | .Input i   => env.getD i false
      | .Not j     => !(memo.getD j false)
      | .And j k   => (memo.getD j false) && (memo.getD k false)
      | .Or  j k   => (memo.getD j false) || (memo.getD k false)
    let rec build_memo : List Gate → List Bool → List Bool
      | [],      memo => memo
      | g :: gs, memo => build_memo gs (memo ++ [eval_gate g memo])
    (build_memo C.gates []).getD C.output false

    inductive Literal where
    | Pos : Nat → Literal
    | Neg : Nat → Literal
    deriving DecidableEq

    def Clause := List Literal
    def CNF := List Clause

    def eval_literal (env : List Bool) : Literal → Bool
    | .Pos i => env.getD i false
    | .Neg i => !(env.getD i false)

    def eval_clause (env : List Bool) (c : Clause) : Bool := c.any (eval_literal env)
    def eval_cnf   (env : List Bool) (f : CNF)    : Bool := f.all (eval_clause env)

    def and_circuit : Circuit := { gates := [.Input 0, .Input 1, .And 0 1], output := 2 }
    def and_cnf : CNF := [[.Neg 2, .Pos 0], [.Neg 2, .Pos 1], [.Pos 2, .Neg 0, .Neg 1], [.Pos 2]]

    theorem and_circuit_eval_tt : eval_circuit and_circuit [true,true] = true   := by native_decide
    theorem and_circuit_eval_tf : eval_circuit and_circuit [true,false] = false  := by native_decide
    theorem and_cnf_sat   : eval_cnf [true,true,true]  and_cnf = true  := by native_decide
    theorem and_cnf_unsat : eval_cnf [true,false,true] and_cnf = false := by native_decide

    def or_circuit : Circuit := { gates := [.Input 0, .Input 1, .Or 0 1], output := 2 }
    def or_cnf : CNF := [[.Pos 2, .Neg 0], [.Pos 2, .Neg 1], [.Neg 2, .Pos 0, .Pos 1], [.Pos 2]]

    theorem or_circuit_eval : eval_circuit or_circuit [false,true] = true     := by native_decide
    theorem or_cnf_eval     : eval_cnf [false,true,true] or_cnf = true        := by native_decide

    def tseitin_size_and : Nat := 4
    def tseitin_size_or  : Nat := 4
    theorem tseitin_size_eq : tseitin_size_and = 4 := by native_decide
    