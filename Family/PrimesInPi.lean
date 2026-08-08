import Mathlib.Analysis.SpecialFunctions.Log.Basic
    import Mathlib.Data.Nat.Prime.Basic
    import Family.Brothers1419

    namespace Eutheos

    /-! ## 0. π/10 rational scaffold -/
    def alpha0_num : Nat := 3141592653
    def alpha0_den : Nat := 10000000000
    -- alpha0_rat ≈ π/10 with error < 6×10⁻¹¹
    def alpha0_rat : Rat := alpha0_num / alpha0_den

    def frac_rat_nat (n : Nat) : Nat := (n * alpha0_num) % alpha0_den
    def dist_rat_nat (n : Nat) : Nat :=
    let f := frac_rat_nat n
    Nat.min f (alpha0_den - f)

    def is_exceptional_rat (p : Nat) : Bool :=
    p ≥ 2 && dist_rat_nat p * p < alpha0_den

    /-! ## 1. Exceptional set S = {2,3,19,191,p5} -/
    def S4 : List Nat := [2, 3, 19, 191]
    -- p5 is imported from Family.Brothers1419 (def p5 : Nat := 3993746143633)
    def S5 : List Nat := [2, 3, 19, 191, 3993746143633]

    -- Only S4 are exceptional among primes up to 1000
    def exceptional_upto_1000 : List Nat :=
    (List.range 1000).filter (fun p => is_exceptional_rat p && Nat.Prime p)

    theorem exceptional_upto_1000_eq : exceptional_upto_1000 = S4 := by native_decide

    theorem S4_prime       : S4.all Nat.Prime        = true := by native_decide
    theorem S4_exceptional : S4.all is_exceptional_rat = true := by native_decide

    -- Desert 192..1000: no exceptional primes
    -- Note: filter must include Nat.Prime to exclude composites that happen to
    -- satisfy the rational approximation criterion but are not prime.
    def desert_192_1000 : List Nat :=
    ((List.range (1000 - 192)).map (· + 192)).filter
      (fun p => is_exceptional_rat p && Nat.Prime p)

    theorem desert_192_1000_empty : desert_192_1000 = [] := by native_decide

    -- p5 is prime (uses p5 from Family.Brothers1419)
    theorem p5_prime : Nat.Prime p5 := by native_decide

    /-! ## 2. Real version with π (definitional, no sorry) -/
    noncomputable def alpha0_real : ℝ := Real.pi / 10
    noncomputable def frac_real (x : ℝ) : ℝ := x - ⌈x⌉
    noncomputable def dist_real (x : ℝ) : ℝ :=
    min (frac_real x) (1 - frac_real x)

    noncomputable def V_real (p : Nat) : ℝ :=
    dist_real (p * alpha0_real) - 1 / p

    def is_exceptional_real (p : Nat) : Prop := V_real p < 0

    /-! ## 3. Brothers live in the desert (rational scaffold) -/
    -- brothers_35 imported from Family.Brothers1419

    theorem brothers_in_desert_rat  : brothers_35.all (· ≥ 193)              = true := by native_decide
    theorem brothers_not_exceptional : brothers_35.all (fun p => !is_exceptional_rat p) = true := by native_decide

    /-! ## 4. Certified chain -/
    theorem primes_in_pi_clean :
      exceptional_upto_1000 = [2, 3, 19, 191] ∧
      desert_192_1000 = [] ∧
      S4.all Nat.Prime = true :=
    ⟨by native_decide, by native_decide, by native_decide⟩

    end Eutheos
    