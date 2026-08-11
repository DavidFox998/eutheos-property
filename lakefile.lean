import Lake
open Lake DSL
package eutheos_property where
  leanOptions := #[⟨`autoImplicit, false⟩]
require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"
@[default_target]
lean_lib EutheosProperty where
  srcDir := "."
