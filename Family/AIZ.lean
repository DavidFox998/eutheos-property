import Mathlib.Data.Complex.Basic
-- (Complex.exp / norm_exp available via transitive import of Family.Brothers1419 → Mathlib)
import Family.Brothers1419

namespace Eutheos.AIZ

open Complex

/-! ## 0. 35 slots = brothers -/
def SLOTS    : Nat      := 35
def SLOT_IDS : List Nat := brothers_35
def FREQ_MOD : Nat      := 211
def FREQ_OFF : Nat      := 153   -- all brothers ≡ 153 mod 211

def alpha0_num : Nat := 3141592653
def alpha0_den : Nat := 10000000000

/-! ## 1. Jitter from π/10 rational scaffold (computable) -/
def jitter_scaled (p t : Nat) : Nat :=
  (p + t) * alpha0_num % alpha0_den

-- Real version for the Hilbert gate (noncomputable because of π)
noncomputable def jitter_rad (p t : Nat) : ℝ :=
  (jitter_scaled p t : ℝ) / alpha0_den * (2 * Real.pi / 180)

noncomputable def gate (p t : Nat) : ℂ :=
  Complex.exp (Complex.I * jitter_rad p t)

theorem gate_norm (p t : Nat) : ‖gate p t‖ = 1 := by
  unfold gate jitter_rad
  have h : (Complex.I * ((jitter_scaled p t : ℝ) / alpha0_den * (2 * Real.pi / 180) : ℝ)).re = 0 := by
    simp [Complex.mul_re, Complex.I_re, Complex.I_im]
  rw [Complex.norm_eq_abs, Complex.abs_exp, h, Real.exp_zero]

/-! ## 2. Hop sequence — Nodup certified by finite check -/
def hop_at (t : Nat) : List Nat :=
  SLOT_IDS.map (fun p => jitter_scaled p t)

-- Finite decidable check over all t ≤ 1419
theorem hop_all_Nodup :
    (List.range 1420).all (fun t => (hop_at t).Nodup) = true := by native_decide

theorem hop_Nodup (t : Nat) (ht : t ≤ 1419) : (hop_at t).Nodup := by
  have h := hop_all_Nodup
  simp only [List.all_eq_true, List.mem_range] at h
  exact of_decide_eq_true (h t (by omega))

/-! ## 3. Leader — 1419 self-symmetry -/
def leader : Nat := 1419
def W1 : Nat := 11 * 13    -- 143
def W2 : Nat := 17 * 19    -- 323
def W3 : Nat := 191 * 193  -- 36863

theorem leader_is_first    : SLOT_IDS.head? = some leader    := by native_decide
theorem leader_eq_morningstar : 3 * 11 * 43 = leader          := by native_decide
theorem wormhole_product   : W1 * W2 = 46189                 := by native_decide
theorem desert_twin        : W3 = 36863                      := by native_decide

/-! ## 4. Packet + validation -/
def popcount6 (n : Nat) : Bool := n.bits.count true == 6

structure Packet where
  src     : Nat
  dst     : Nat
  payload : Nat
  t       : Nat
deriving DecidableEq

def valid_slot (p : Nat) : Bool := p ∈ SLOT_IDS

def valid_packet (pkt : Packet) : Bool :=
  valid_slot pkt.src &&
  valid_slot pkt.dst &&
  (pkt.src != pkt.dst) &&
  popcount6 pkt.payload &&
  (pkt.t ≤ 1419) &&
  (pkt.payload % 211 == 153)

theorem valid_packet_in_desert (pkt : Packet) (hv : valid_packet pkt = true) :
    pkt.src ≥ 193 ∧ pkt.dst ≥ 193 := by
  simp only [valid_packet, Bool.and_eq_true] at hv
  obtain ⟨⟨⟨⟨⟨hs, hd⟩, _⟩, _⟩, _⟩, _⟩ := hv
  have hge : brothers_35.all (· ≥ 193) = true := by native_decide
  rw [List.all_eq_true] at hge
  simp only [valid_slot] at hs hd
  exact ⟨of_decide_eq_true (hge pkt.src (by simpa using hs)),
         of_decide_eq_true (hge pkt.dst (by simpa using hd))⟩

/-! ## 5. Hilbert route (local, wired to local gate) -/
noncomputable def route (z : ℂ) (path : List Nat) (t : Nat) : ℂ :=
  path.foldl (fun acc p => acc * gate p t) z

theorem route_unitary (z : ℂ) (path : List Nat) (t : Nat) :
    ‖route z path t‖ = ‖z‖ := by
  induction path generalizing z with
  | nil => simp [route]
  | cons p ps ih =>
    simp only [route, List.foldl]
    have hfold : ps.foldl (fun acc q => acc * gate q t) (z * gate p t) =
                 route (z * gate p t) ps t := rfl
    rw [hfold, ih, norm_mul, gate_norm, mul_one]

/-! ## 6. Certified chain -/
def prime_beacons : List Nat := [5639, 9859, 44041]

theorem aiz_chain_clean :
    SLOT_IDS.length = 35 ∧
    SLOT_IDS.Nodup ∧
    prime_beacons.length = 3 ∧
    W1 * W2 = 46189 ∧
    W3 = 36863 :=
  ⟨by native_decide, by native_decide, by native_decide,
   by native_decide, by native_decide⟩

end Eutheos.AIZ
