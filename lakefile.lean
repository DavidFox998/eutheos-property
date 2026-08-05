import Lake
open Lake DSL

package «eutheos-property» where
  version := v!"0.1.0"

-- Mathlib v4.15.0
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

/-
Single library covering all source directories.
Files in Archive/ are NOT listed as build targets -- they contain
sorry/axiom and are kept for historical reference only.

Slices:
  Brothers1419    -- 16-bit, popcount=6, 35 brothers (minimal, fastest)
  Brothers61      -- 16-bit, popcount=8, 61 brothers (342 nines)
  Brothers188     -- 20-bit, popcount=6, 188 brothers (1026 nines, ~100%)
  FibonacciChain  -- pure Weyl N=14..90, Three-Gap chain, brothers gap sums
-/
lean_lib EutheosProperty where
  srcDir := "."
  globs := #[
    .one `Bounds.CircuitBounds9,
    .one `Bounds.ClayBridge5_10,
    .one `Witness.ClayClaim_fixed,
    .one `Family.ClayFamilyAlpha0,
    .one `Family.EutheosAsymptotic,
    .one `Andreev.ClayAndreevLift,
    .one `Andreev.ClayAndreevAlpha0,
    .one `Andreev.ClayN20Measured,
    .one `Andreev.ClayN25MpmathMeasured,
    .one `Andreev.ClayN26MpmathMeasured,
    .one `Andreev.ClayN27MpmathMeasured,
    .one `Ppoly.ClayPSubPpolyClean,
    .one `CookLevin.ClayCookLevinClean,
    .one `MMW.ClayMMWClean,
    .one `Final.ClayFinalClean,
    .one `Final.ClayFinalUnifiedClean,
    .one `Family.Brothers1419,
    .one `Family.WeylGolden,
    .one `Family.DirichletGolden,
    .one `Family.EutheosAsymptotic,
    .one `Family.Brothers61,
    .one `Family.Brothers188,
    .one `Family.FibonacciChain
  ]
