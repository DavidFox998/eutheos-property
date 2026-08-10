import Lake
open Lake DSL

package «eutheos-property» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]
  -- no external deps — zero axiom build

-- Root umbrella
@[default_target]
lean_lib «EutheosProperty» where
  srcDir := "."

-- Your 10 libs from screenshot + NEW Common
lean_lib Common where
  srcDir := "Common"

lean_lib Witness where
  srcDir := "Witness"

lean_lib Family where
  srcDir := "Family"

lean_lib Bounds where
  srcDir := "Bounds"

lean_lib Andreev where
  srcDir := "Andreev"

lean_lib CookLevin where
  srcDir := "CookLevin"

lean_lib Ppoly where
  srcDir := "Ppoly"

lean_lib MMW where
  srcDir := "MMW"

lean_lib Final where
  srcDir := "Final"

lean_lib Protocol where
  srcDir := "Protocol"

lean_lib Archive where
  srcDir := "Archive"
