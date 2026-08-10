import Lake
open Lake DSL

package «eutheos-property» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

-- single root — this is what fixes ./././Bounds/Bounds/...
@[default_target]
lean_lib EutheosProperty where
  srcDir := "."

lean_lib Common where
  srcDir := "."

lean_lib Witness where
  srcDir := "."

lean_lib Family where
  srcDir := "."

lean_lib Bounds where
  srcDir := "."

lean_lib Andreev where
  srcDir := "."

lean_lib CookLevin where
  srcDir := "."

lean_lib Ppoly where
  srcDir := "."

lean_lib MMW where
  srcDir := "."

lean_lib Final where
  srcDir := "."

lean_lib Protocol where
  srcDir := "."

lean_lib Archive where
  srcDir := "."
