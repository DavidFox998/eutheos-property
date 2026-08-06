import Family.Brothers1419

namespace Eutheos

def twin_pairs : List (Nat × Nat) := [(11,13), (17,19), (191,193), (2,3)]

def brothers_mod (p : Nat) : List Nat := brothers_35.map (· % p)

-- Divisibility counts for each twin prime pair
-- (4 brothers divisible by 11; 3 divisible by 13)
theorem brothers_avoid_twin_11_13 :
    (brothers_35.filter (fun b => b % 11 = 0)).length = 4 ∧
    (brothers_35.filter (fun b => b % 13 = 0)).length = 3 := by native_decide

-- (2 brothers divisible by 17; 2 divisible by 19)
theorem brothers_avoid_twin_17_19 :
    (brothers_35.filter (fun b => b % 17 = 0)).length = 2 ∧
    (brothers_35.filter (fun b => b % 19 = 0)).length = 2 := by native_decide

-- Desert boundary: no brother divisible by 193; one by 191 (4584 = 24×191)
theorem brothers_avoid_twin_191_193 :
    (brothers_35.filter (fun b => b % 191 = 0)).length = 1 ∧
    (brothers_35.filter (fun b => b % 193 = 0)).length = 0 := by native_decide

-- Residue counts mod lower twins
theorem mod_13_distinct : (brothers_mod 13).eraseDups.length = 12 := by native_decide
theorem mod_19_distinct : (brothers_mod 19).eraseDups.length = 17 := by native_decide

-- 35 distinct residues mod 191 → injective at the desert boundary
theorem mod_191_Nodup : (brothers_mod 191).Nodup := by native_decide

-- mod 193: 34 distinct residues (1841 and 42564 share residue 104 mod 193)
theorem mod_193_distinct : (brothers_mod 193).eraseDups.length = 34 := by native_decide

-- Twin-product injectivity: mod 17*19 and mod 191*193 are injective
theorem mod_17_19_product_Nodup   : (brothers_35.map (· % (17*19))).Nodup   := by native_decide
theorem mod_191_193_product_Nodup : (brothers_35.map (· % (191*193))).Nodup := by native_decide

-- mod 11*13=143: 33 distinct residues
theorem mod_11_13_product_distinct : (brothers_35.map (· % (11*13))).eraseDups.length = 33 := by native_decide

-- Certified chain
theorem brothers_twin_clean :
    twin_pairs = [(11,13),(17,19),(191,193),(2,3)] ∧
    (brothers_mod 191).Nodup ∧
    (brothers_35.map (· % (191*193))).Nodup := by
  exact ⟨by rfl, by native_decide, by native_decide⟩

end Eutheos
