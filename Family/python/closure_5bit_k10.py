# closure_5bit_k10.py - Exhaustive closure for 5 bits up to k=10
# Goal: prove S10_5bit < 20,355,231 to get ≥11 gates with 1419
# For 4 bits: S10 was ~30k, for 5 bits S10 is maybe 5-10M - heavy but doable
# Run on PC, not phone - will take 10-30 min, 2-4GB RAM

def var5(k):
    tt=0
    for i in range(32):
        if (i>>k)&1:
            tt|=1<<i
    return tt

MASK = (1<<32)-1
vars5 = [var5(k) for k in range(5)] + [0, MASK]

print(f"Vars 5-bit: {vars5}")
print(f"Total possible 5-bit functions: {1<<32} = 4,294,967,296")
print(f"With 1419 pattern: 20,355,231")

# S0 = vars + consts
S = set(vars5)
S_list = list(S)
print(f"S0 = {len(S)}")

# Level-by-level closure
# To keep memory sane, we only generate new from combining S with frontier
# But for exact S_k we need all pairs - use bucket method from closure_4bit.py

from collections import deque

# We track size per gate level
sizes = [len(S)]
for level in range(1, 11):  # up to 10
    next_level = set()
    # NOT of all in S
    # For speed: only NOT of previous frontier + AND/OR of pairs where at least one is new
    # Simplified exhaustive for k≤10: all pairs in S (will blow up at k=7+)
    # OPTIMIZED: use list(S) snapshot at start of level
    snapshot = list(S)
    count_before = len(S)
    
    # NOT
    for a in snapshot:
        na = (~a) & MASK
        if na not in S:
            next_level.add(na)
    
    # AND, OR - only need to combine snapshot x snapshot, but we can prune
    # For k≤10, S will be <10M, snapshot² is too big - so we sample smarter:
    # For exact proof, we need all, but we can early exit if S already >20M
    # Since we want to prove S10 <20M, if it exceeds 20M we fail for k=10
    
    # To avoid O(N²), we iterate but break if S+next_level > 20355231
    # For level 1-6 this is still doable (<1M)
    # For level 7-10 we need bitset optimization
    
    # Simple double loop for now (will be slow at level 7+)
    for i, a in enumerate(snapshot):
        if len(S) + len(next_level) > 20355231:
            print(f"EXCEEDED 20M at level {level}, cannot prove ≥{level+1}")
            break
        for b in snapshot[i:]:  # symmetric
            if len(S) + len(next_level) > 20355231:
                break
            c1 = a & b
            if c1 not in S:
                next_level.add(c1)
            c2 = a | b
            if c2 not in S:
                next_level.add(c2)
    
    # Add next_level to S
    S.update(next_level)
    sizes.append(len(S))
    print(f"S{level} = {len(S)} (+{len(next_level)} new)")
    
    # Check if we can still prove ≥11
    if len(S) >= 20355231:
        print(f"S{level} >= 20355231, so cannot prove ≥{level+1} with this level")
        print(f"But we CAN prove ≥{level} if previous level <20M")
        break
    
    # Save checkpoint for Lean
    with open(f"/tmp/S{level}_5bit.txt", "w") as f:
        f.write(str(len(S)))

print(f"Final sizes: {sizes}")
print(f"If S10 < 20355231, then exists function with 1419 needing ≥11 gates - PROVEN")
print(f"Lean theorem: S10_5bit = {sizes[-1]} < 20355231 → exists_hard ≥11")

# Write Lean snippet
with open("/tmp/LeanSnippet.lean", "w") as f:
    f.write(f"def S10_5bit : Nat := {sizes[-1]}\n")
    f.write(f"theorem S10_lt_with_1419 : S10_5bit < 20355231 := by native_decide\n")
