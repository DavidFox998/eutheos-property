# We know S4=10892522 exhaustive up to size 4 for 4-var
# For 5-var we need to prove 0x058b058b needs exactly 5, not ~5
# Use reduction: if low==high, CC(5-var) = CC(4-var low)
# So we just need to prove CC(4-var) =5 exact for each low half

# Your 29 distinct 5-var patterns from previous run, list their low16
distinct_vals = [
0x00000000,0x058b058b,0x01ad94ce,0x56aa0175,0xee11ee2d,0x68ab649b,
0x0d076a18,0xaefbd0b9,0x6f529a98,0xa2bac959,0x1370b463,0x938dc1f2,
0x8b0d1c2d,0xab2c5b1f,0xa9a3569f,0xee40b4f1,0xdfba1d99,0xa4866bb9,
0x6c17f4f8,0x4a28b219,0x574312bd,0x2ee71150,0x741e2881,0xdf194436,
0x0341686e,0x7b998487,0x233ef9c9,0x9b343018,0xf0c330f3
]

# For each, low = val & 0xffff
# From your S4 exhaustive, you have exact CC for 4-var:
# 0x0000=0, 0x058b=5 exact (first at size 5, W=0x9257058b), 0x01ad=?? etc
# Let's load your S4 table if you saved S4_list.txt

# For now, prove 058b case exact:
# 0x058b = 1419, ones=6? Actually bin(1419)=6 ones
# To prove CC=5 exact, need to show not in S0..S4
# S4 size =10892522, you enumerated
# So if 0x058b not in S0-S4, CC>=5, and you have witness W with 5 gates, CC=5

# Check sharing can't reduce 142:
# Each distinct 5-var with different low/high cannot share top gate
# So need at least 1 distinct gate per distinct pattern beyond shared core
# Therefore sum 142 is lower bound even with sharing, Nechiporuk gives /2 factor

print("To make 71>51 exact, we need:")
for v in distinct_vals:
    low = v & 0xffff
    high = (v>>16) & 0xffff
    if low==high:
        print(f"0x{v:08x} = repeat 0x{low:04x} -> CC = CC(0x{low:04x}) exact from S4")
    else:
        print(f"0x{v:08x} low=0x{low:04x} high=0x{high:04x} -> CC >= max(CC(low),CC(high))+1")

# So you need to publish S4 table lookup for each low/high:
# For 0x058b -> CC=5 exact (your 9257058b witness)
# For 0x01ad -> need its exact CC from S4 enumeration (likely 4)
# etc. Sum of exact CCs will be >=142, maybe higher

print("\nNext action: run your S4 enumerator to output CC for each of these 16-bit halves:")
for v in distinct_vals:
    low = v & 0xffff
    high = (v>>16) & 0xffff
    print(f" {low:04x} {high:04x}")
