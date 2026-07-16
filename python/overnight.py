x0=0xAAAA; x1=0xCCCC; x2=0xF0F0; x3=0xFF00
base=[0x0000,0xFFFF,x0,x1,x2,x3,x0^0xFFFF,x1^0xFFFF,x2^0xFFFF,x3^0xFFFF]
best={f:0 for f in base}
def apply_fast(a,b,op):
    na=(~a)&0xFFFF; nb=(~b)&0xFFFF
    r=0
    if op&1: r|=na&nb
    if op&2: r|=na&b
    if op&4: r|=a&nb
    if op&8: r|=a&b
    return r
OPS=[8,14,6,7,1,9]
vals=[0x00000000,0x058b058b,0x01ad94ce,0x56aa0175,0xee11ee2d,0x68ab649b,0x0d076a18,0xaefbd0b9,0x6f529a98,0xa2bac959,0x1370b463,0x938dc1f2,0x8b0d1c2d,0xab2c5b1f,0xa9a3569f,0xee40b4f1,0xdfba1d99,0xa4866bb9,0x6c17f4f8,0x4a28b219,0x574312bd,0x2ee71150,0x741e2881,0xdf194436,0x0341686e,0x7b998487,0x233ef9c9,0x9b343018,0xf0c330f3]
for sz in range(1,5):
    cur=list(best.keys()); add=0
    for i,a in enumerate(cur):
        if best[a]>=sz: continue
        for b in cur[i:]:
            if best[a]+best[b]+1>sz: continue
            for op in OPS:
                c=apply_fast(a,b,op)
                if c not in best:
                    best[c]=sz; add+=1
    print(f"size {sz} total {len(best)}")
sum_exact=0
for v in vals:
    low=v&0xFFFF; high=(v>>16)&0xFFFF
    cl=best.get(low,5); ch=best.get(high,5)
    cc=cl if low==high else (max(cl,ch)+1 if cl<5 and ch<5 else 5)
    sum_exact+=cc
    print(f"0x{v:08x} CC={cc}")
print(f"Sum {sum_exact} L>={sum_exact//2} >51? {sum_exact//2>51}")
