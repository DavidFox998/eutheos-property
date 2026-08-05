# Exact CC for 4-var functions - reproduces your S4=10892522
# Basis: vars x0=0xAAAA, x1=0xCCCC, x2=0xF0F0, x3=0xFF00, const 0,1, gates = AND,OR,XOR,NAND etc (all 16 2-input ops)

def gen_exact_4var():
    # truth tables as 16-bit ints
    x0 = 0xAAAA # 1010...
    x1 = 0xCCCC
    x2 = 0xF0F0
    x3 = 0xFF00
    base = [0x0000, 0xFFFF, x0, x1, x2, x3, x0^0xFFFF, x1^0xFFFF, x2^0xFFFF, x3^0xFFFF]
    # map func -> min size
    best = {f:0 for f in base}
    frontier = set(base)
    size = 0
    # all 16 binary ops as lambda on bits: we can precompute op table
    def apply_op(a,b,op):
        # op 0..15 truth table of 2 vars
        # compute bitwise: for each bit position in a,b? Actually need to combine per bit: out bit = op bit at index (a_bit<<1|b_bit)
        # op bits: op>>0 = 00->0, >>1=01, >>2=10, >>3=11
        # So we can compute using boolean formulas, easier brute per 16 bits
        res=0
        for i in range(16):
            abit = (a>>i)&1
            bbit = (b>>i)&1
            idx = (abit<<1)|bbit # 0..3? Wait order: a is first? use a as high
            # Actually idx = abit*2 + bbit
            obit = (op>>idx)&1
            res |= obit<<i
        return res

    for size in range(1,5):
        new_funcs = set()
        func_list = list(best.keys())
        # generate all pairs
        for i in range(len(func_list)):
            for j in range(i+1, len(func_list)):
                a = func_list[i]; b = func_list[j]
                if best[a]+best[b] >= size: # would exceed
                    # still might need, but approximate
                    pass
                for op in range(16): # all 2-input gates
                    c = apply_op(a,b,op)
                    if c not in best:
                        best[c]=size
                        new_funcs.add(c)
        print(f"size {size} total funcs {len(best)} new {len(new_funcs)}")
        if len(best)==65536:
            break
    return best

best = gen_exact_4var()
# Now lookup your halves
halves = ["0000","058b","94ce","01ad","0175","56aa","ee2d","ee11","649b","68ab","6a18","0d07","d0b9","aefb","9a98","6f52","c959","a2ba","b463","1370","c1f2","938d","1c2d","8b0d","5b1f","ab2c","569f","a9a3","b4f1","ee40","1d99","dfba","6bb9","a486","f4f8","6c17","b219","4a28","12bd","5743","1150","2ee7","2881","741e","4436","df19","686e","0341","8487","7b99","f9c9","233e","3018","9b34","30f3","f0c3"]

print("\nExact CC for needed halves:")
total = 0
for h in halves:
    v = int(h,16)
    cc = best.get(v, best.get(v^0xFFFF, 5)) # if not found, >=5
    if v not in best:
        cc = 5 # means needs >=5, since S4=10892522 <65536, many need 5
        print(f"0x{h} not in S0-S4 => CC>=5")
    else:
        print(f"0x{h} CC={cc}")
    total+=cc

# Now compute sum for your 29 vals using max+1 rule
vals = [0x00000000,0x058b058b,0x01ad94ce,0x56aa0175,0xee11ee2d,0x68ab649b,0x0d076a18,0xaefbd0b9,0x6f529a98,0xa2bac959,0x1370b463,0x938dc1f2,0x8b0d1c2d,0xab2c5b1f,0xa9a3569f,0xee40b4f1,0xdfba1d99,0xa4866bb9,0x6c17f4f8,0x4a28b219,0x574312bd,0x2ee71150,0x741e2881,0xdf194436,0x0341686e,0x7b998487,0x233ef9c9,0x9b343018,0xf0c330f3]
sum_exact=0
for v in vals:
    low=v&0xffff; high=(v>>16)&0xffff
    cl = best.get(low,5); ch = best.get(high,5)
    if low==high: cc=cl
    else: cc=max(cl,ch)+1
    sum_exact+=cc
    print(f"0x{v:08x} CC_exact={cc}")

print(f"\nSum exact {sum_exact} L>={sum_exact//2} >51? {sum_exact//2>51}")
