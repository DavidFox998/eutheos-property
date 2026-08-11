import Lake
open Lake DSL

package eutheos_property where
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

@[default_target]
lean_lib Common where
  srcDir := "Common"

lean_lib Bounds where
  srcDir := "Bounds"

lean_lib Witness where
  srcDir := "Witness"

lean_lib Family where
  srcDir := "Family"

lean_lib Andreev where
  srcDir := "Andreev"

lean_lib Ppoly where
  srcDir := "Ppoly"

lean_lib CookLevin where
  srcDir := "CookLevin"

lean_lib MMW where
  srcDir := "MMW"

lean_lib Final where
  srcDir := "Final"

lean_lib Protocol where
  srcDir := "Protocol"

lean_lib Eutheos where
  srcDir := "."
