import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
    import Mathlib.Data.Real.Irrational
    import Mathlib.Data.Real.Pi.Irrational
    import Family.Brothers1419

    namespace Eutheos

    noncomputable def alpha0 : ℝ := Real.pi / 10

    /-! ## 1. π/10 is irrational -/

    -- Mathlib 4.15.0: the theorem is irrational_pi, not Real.pi_irrational
    theorem pi_irrational : Irrational Real.pi := irrational_pi

    -- Direct: if π/10 = q ∈ ℚ then π = 10q ∈ ℚ, contradicting irrational_pi
    theorem alpha0_irrational : Irrational alpha0 := by
    unfold alpha0 Irrational
    intro ⟨q, hq⟩
    apply irrational_pi
    exact ⟨q * 10, by push_cast at hq ⊢; linarith⟩

    theorem alpha0_not_rational : ¬ ∃ a b : ℤ, b ≠ 0 ∧ alpha0 = a / b := by
    intro ⟨a, b, hb, heq⟩
    apply alpha0_irrational
    exact ⟨a / b, by push_cast; exact heq.symm⟩

    /-! ## 2. Fractional-distance tools -/

    -- Standard fractional part: frac x = x - ⌊x⌋ ∈ [0, 1).
    -- Must use floor (⌊⌋), not ceiling (⌈⌉) — Int.floor_le and Int.lt_floor_add_one
    -- give the [0,1) bounds needed below.
    noncomputable def frac_real (x : ℝ) : ℝ := x - ↑⌊x⌋

    noncomputable def dist_real (x : ℝ) : ℝ :=
    min (frac_real x) (1 - frac_real x)

    -- dist(n·α₀) > 0 for every n ≠ 0  (irrationality prevents integer multiples)
    theorem alpha0_dist_pos (n : ℕ) (hn : n ≠ 0) : dist_real (n * alpha0) > 0 := by
    have hirr : Irrational alpha0 := alpha0_irrational
    have hn'  : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
    -- frac ∈ [0, 1) because ⌊n·α₀⌋ ≤ n·α₀ < ⌊n·α₀⌋ + 1
    have hnn : 0 ≤ frac_real (↑n * alpha0) := by
      unfold frac_real; linarith [Int.floor_le (↑n * alpha0)]
    have hlt : frac_real (↑n * alpha0) < 1 := by
      unfold frac_real; linarith [Int.lt_floor_add_one (↑n * alpha0)]
    -- frac ≠ 0: n·α₀ ∈ ℤ would make α₀ rational, contradicting irrationality
    have hne0 : frac_real (↑n * alpha0) ≠ 0 := by
      unfold frac_real
      intro h
      have heq : (↑n : ℝ) * alpha0 = ↑⌊(↑n : ℝ) * alpha0⌋ := by linarith
      apply hirr
      refine ⟨(⌊(↑n : ℝ) * alpha0⌋ : ℚ) / (n : ℕ), ?_⟩
      push_cast [hn']
      field_simp [hn']
      linarith
    unfold dist_real
    exact lt_min (lt_of_le_of_ne hnn (Ne.symm hne0)) (by linarith)

    /-! ## 3. Exceptional set via rational scaffold -/

    -- Rational scaffold: alpha0_rat ≈ π/10, error < 6×10⁻¹¹
    def alpha0_num : Nat := 3141592653
    def alpha0_den : Nat := 10000000000

    def dist_rat_nat (p : Nat) : Nat :=
    let f := p * alpha0_num % alpha0_den
    Nat.min f (alpha0_den - f)

    def is_exceptional (p : Nat) : Bool :=
    p ≥ 2 && dist_rat_nat p * p < alpha0_den

    def S4 : List Nat := [2, 3, 19, 191]

    -- Desert property: no *prime* in [192, 999] is exceptional.
    -- Some composites in this range satisfy is_exceptional (the rational approximation
    -- criterion has no primality filter), so we guard with Nat.Prime.
    theorem desert_192_1000_empty :
      ((List.range (1000 - 192)).map (· + 192)).all
        (fun p => !is_exceptional p || !decide (Nat.Prime p)) = true := by
    native_decide

    theorem brothers_in_desert :
      brothers_35.all (fun p => !is_exceptional p) = true := by native_decide

    /-! ## 4. Certified chain -/

    theorem brothers_witness_irrational :
      brothers_35.Nodup ∧
      brothers_35.length = 35 ∧
      brothers_35.all (· ≥ 193) = true ∧
      brothers_35.all (fun p => !is_exceptional p) = true :=
    ⟨by native_decide, by native_decide, by native_decide, by native_decide⟩

    theorem rational_vs_irrational_clean :
      Irrational alpha0 ∧
      (∀ n : ℕ, n ≠ 0 → dist_real (↑n * alpha0) > 0) ∧
      brothers_35.Nodup :=
    ⟨alpha0_irrational, fun n hn => alpha0_dist_pos n hn, by native_decide⟩

    end Eutheos
    