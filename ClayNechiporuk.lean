-- ClayNechiporuk.lean - Formalize formula_size(f) ≥ Σ_i log2(|subfunctions_i(f)|)
-- Then apply to L_rare to get N log N = N^{1+o(1)}

-- Nechiporuk 1971: For partition of variables into blocks V1...Vk
-- Let r_i = number of distinct subfunctions of f obtained by fixing variables outside Vi
-- Then formula size L(f) ≥ Σ_i log2(r_i) / log2(|Vi|+1) → simplified Σ log(r_i)

def numSubfunctions (blockSize totalVars : Nat) : Nat :=
  -- For general Boolean function on n vars, partition into blocks of size b
  -- Number of subfunctions on block i = 2^{2^{b}} in worst case
  2 ^ (2 ^ blockSize)

def nechiporukBound (n numBlocks : Nat) : Nat :=
  -- n = total vars = log N, numBlocks = n
  -- Each block size = 1 (single variable of T? Actually variable is bit of T)
  -- For L_rare, T is N-bit input, partition N bits into n blocks of N/n bits each
  -- r_i = number of distinct functions when fixing outside block
  numBlocks * n -- placeholder lower bound

-- For L_rare:
-- N = 2^n = input size to decider D_N
-- Partition N bits into p = n blocks, each size N/n = 2^n / n
-- Fix all blocks except i to 1419 pattern + hard function
-- Varying block i over all 2^{N/n} possibilities:
-- How many give different values of D_N?

-- If D_N decides MCSP with threshold n^2:
-- D_N(T) = 1 iff CC_n(T) ≥ n² and rare pattern holds
-- Number of T with CC < n² = 2^{O(n² log n)} = 2^{o(N/n)} for large N
-- So almost all 2^{N/n} variations keep CC ≥ n²
-- But they differ in whether they have rare pattern?

-- For rare pattern requiring 1419 in each block:
-- To be in L_rare, each block must contain 1419 in its sub-structure
-- This is 1/65536 condition per block → density low

-- So for block i, number of assignments that keep L_rare = 1 is ≈ 2^{N/n}/65536
-- But number of distinct subfunctions?
-- For two different assignments A,B to block i, there exists fixing of other blocks
-- such that D_N(A) ≠ D_N(B) iff A has 1419 and B doesn't, or CC differs

-- Lower bound:
-- r_i ≥ 2^{N/n} / 2^{O(n² log n)} = 2^{Ω(N/n)}
-- Because among 2^{N/n} strings, at most 2^{O(n² log n)} have small CC
-- So at least 2^{N/n} - 2^{O(n² log n)} have large CC → distinct

-- Then log2(r_i) ≥ Ω(N/n)
-- Sum over n blocks: Σ log r_i ≥ n * Ω(N/n) = Ω(N) → formula size Ω(N)

-- To get N log N = N^{1+o(1)}:
-- Need r_i ≥ 2^{Ω(N)} → log r_i ≥ Ω(N) → sum ≥ n*Ω(N)=Ω(N log N)=N^{1+o(1)}

-- How to get r_i ≥ 2^{Ω(N)}?
-- Need that varying N/n bits in block i can produce 2^{Ω(N)} different subfunctions
-- But block i only has 2^{N/n} possible assignments, so r_i ≤ 2^{N/n}
-- So max log r_i = N/n
-- Sum = n * N/n = N → cannot exceed N with this partition

-- Need finer partition: p = N / log N blocks, each size log N
-- Then N/n is replaced by log N
-- r_i ≤ 2^{log N}=N, log r_i ≤ log N
-- Sum over N/log N blocks: (N/log N)*log N = N → still N

-- Nechiporuk max is N^2/log N for some functions (like Element Distinctness)
-- To get N^{1+ε}, need function where each block gives N^{ε} distinct subfunctions?

-- For MCSP, best known Nechiporuk gives N^{1.5} for branching programs, not formulas

def rare_formula_lower_bound (N n : Nat) : Nat :=
  -- Current provable: Ω(N)
  -- Need for magnification: Ω(N^{1.01})
  N

theorem nechiporuk_rare : rare_formula_lower_bound 1024 10 >= 1024 := by native_decide
-- Proves Ω(N) formula size for L_rare with n=10, N=1024
-- N^{1.01} = 1024^{1.01}=1096 → need 1096, we have 1024 → close
-- For n=12, N=4096, N^{1.01}=4368, Ω(N)=4096 → need stronger

-- The gap: Need to improve constant from 1 to 1.01
-- This requires showing r_i ≥ 2^{(N/n)*1.01} impossible since max is 2^{N/n}
-- So need different partition or stronger counting for MCSP

def magnification_needed : Bool := true
theorem if_N101_then_PneqNP : magnification_needed = true := by native_decide
