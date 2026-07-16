-- Need to get log N factor: Need r_i ≥ 2^{Ω(N log N / n)} not just Ω(N/n)
-- Idea: Use block size = n not N/n
-- Partition N bits into N/n blocks of size n each
-- Each block can be any n-bit string = 2^n = N possibilities
-- For L_rare, need each block to encode 1419 somewhere? No

-- New rare pattern for superlinear:
-- Require 1419 appears in EACH block of size n
-- Number of blocks = N / n = 2^n / n
-- For a fixed block i, varying it over 2^n = N possibilities:
-- - Only 1 possibility has 1419? Actually probability 1/2^n? No

-- Let's define: Block i is size s = log N = n
-- Property: block i == 1419 mod 2^n? That's 1 out of N possibilities
-- So density per block = 1/N
-- Overall density = (1/N)^{N/n} = N^{-N/n} = 2^{-N} → too sparse, empty

-- Need density N^{-16} as before, but need more subfunctions

-- Key: For MCSP part, number of subfunctions is huge
-- Fix all blocks except i
-- Vary block i over all N possibilities
-- For each variation, does CC(T) change?
-- If we vary N/n bits, CC can change by at most N/n gates? No, CC is global

-- Known result: For random T, CC(T) ≈ 2^n / n = N / log N with high prob
-- So threshold n² = (log N)² << N/log N
-- So almost all variations have CC ≥ n²
-- Therefore D_N(T) = 1 iff rare pattern holds (since CC condition almost always true)

-- So D_N is essentially just checking rare pattern!
-- Rare pattern checking is in AC0, has O(N) formulas
-- So D_N has O(N) formulas → cannot get N^{1.01} lower bound if this is true

-- This is why MCSP with small threshold n² is easy to approximate

-- To get hard, need threshold close to N/log N, e.g., threshold = N / (2 log N)
-- Then about half functions are hard, half easy → deciding is hard
-- Set threshold = N / (2n) = 2^n / (2n)

def new_threshold (n : Nat) : Nat := (2^n) / (2*n) -- N/(2 log N)

-- Then L_rare_new = { T | rare pattern (N^{-16}) AND CC(T) ≥ N/(2n) }
-- Density of CC ≥ N/(2n) is ≈ 1/2 (since half functions need ≥ N/log N)
-- So density of L_rare_new ≈ (1/2) * N^{-16} = N^{-16}/2 → still non-large
-- But now D_N is NOT approximable by just rare pattern, because CC condition is 50/50

-- For this threshold, number of subfunctions r_i might be 2^{Ω(N)}?
-- Need to count: For fixed outside, varying inside block i of size n=log N
-- How many distinct behaviors for CC ≥ N/(2n)?

-- This is the frontier: MCSP with threshold N/(2 log N) is hardest
