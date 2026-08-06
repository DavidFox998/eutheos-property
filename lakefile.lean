import Lake
open Lake DSL

package «eutheos-property» where
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

lean_lib EutheosProperty where
  srcDir := "."
  globs := #[
    .one `Bounds.CircuitBounds9,
    .one `Bounds.ClayBridge5_10,
    .one `Witness.ClayClaim_fixed,
    .one `Family.Brothers1419,
    .one `Family.Brothers61,
    .one `Family.Brothers188,
    .one `Family.ClayBrothersClean,
    .one `Family.ExceptionalPrimes,
    .one `Family.TwinPrimes,
    .one `Family.GapHamming,
    .one `Family.HilbertRoute,
    .one `Family.PrimesInPi,
    .one `Family.BrothersAnalysis,
    .one `Family.AlphaBridge,
    .one `Family.IrrationalVsRational,
    .one `Family.AIZ,
    .one `Family.WeylGolden,
    .one `Family.DirichletGolden,
    .one `Family.EutheosAsymptotic,
    .one `Family.ClayFamilyAlpha0,
    .one `Family.FibonacciChain,
    .one `Family.H4Throat,
    .one `Family.H4Tower,
    .one `Family.DirichletJitterTime,
    .one `Family.PiIrrational,
    .one `Protocol.SuperBric,
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
    .one `Final.ClayFinalUnifiedClean
  ]
