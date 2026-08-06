import Family.Brothers1419

namespace Eutheos

def twin_pairs : List (Nat × Nat) := [(11,13), (17,19), (191,193), (2,3)]

def brothers_mod (p : Nat) : List Nat := brothers_35.map (· % p)

-- Divisibility counts for each twin prime
theorem brothers_avoid_twin_11_13 :
    (brothers_35.filter (fun b => b % 11 = 0)).length = 2 ∧
    (brothers_35.filter (fun b => b % 13 = 0)).length = 3 := by native_decide

theorem brothers_avoid_twin_17_19 :
    (brothers_35.filter (fun b => b % 17 = 0)).length = 2 ∧
    (brothers_35.filter (fun b => b % 19 = 0)).length = 2 := by native_decide

-- Clean in desert: no brother divisible by 191 or 193
theorem brothers_avoid_twin_191_193 :
    (brothers_35.filter (fun b => b % 191 = 0)).length = 0 ∧
    (brothers_35.filter (fun b => b % 193 = 0)).length = 0 := by native_decide

-- Residue counts mod lower twins
theorem mod_13_distinct : (brothers_mod 13).eraseDups.length = 11 := by native_decide
theorem mod_19_distinct : (brothers_mod 19).eraseDups.length = 13 := by native_decide

-- 35 distinct residues mod both upper twins → injectivity at the desert boundary
theorem mod_191_Nodup : (brothers_mod 191).Nodup := by native_decide
theorem mod_193_Nodup : (brothers_mod 193).Nodup := by native_decide

-- Twin-product injectivity
theorem mod_11_13_product_Nodup  : (brothers_35.map (· % (11*13))).Nodup   := by native_decide
theorem mod_17_19_product_Nodup  : (brothers_35.map (· % (17*19))).Nodup   := by native_decide
theorem mod_191_193_product_Nodup: (brothers_35.map (· % (191*193))).Nodup := by native_decide

-- Certified chain
theorem brothers_twin_clean :
    twin_pairs = [(11,13),(17,19),(191,193),(2,3)] ∧
    (brothers_mod 191).Nodup ∧
    (brothers_mod 193).Nodup := by
  exact ⟨by rfl, by native_decide, by native_decide⟩

end Eutheos
