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

Build individual clean files:
  lake build Bounds.CircuitBounds9
  lake build Final.ClayFinalClean
Build everything clean (CI uses explicit targets in main.yml):
  lake build
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
    .one `Family.WeylGolden
  ]
