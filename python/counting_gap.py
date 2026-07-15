# counting_gap.py - Honest upper bound attempt, shows why random 5556 is lower bound not upper bound
import random, math

def var5(k):
    tt=0
    for i in range(32):
        if (i>>k)&1:
            tt|=1<<i
    return tt

vars5=[var5(k) for k in range(5)]
MASK=(1<<32)-1

def rand_formula_correct(gates):
    # Correct: always uses exactly 'gates' internal nodes, no early return bias
    if gates==0:
        return random.choice(vars5 + [0, MASK])
    # split
    left=random.randint(0, gates-1)
    right=gates-1-left
    a=rand_formula_correct(left)
    b=rand_formula_correct(right)
    op=random.randint(0,2)
    if op==0:
        return (~a) & MASK
    elif op==1:
        return a & b
    else:
        return a | b

print("Correct random - 200k formulas with 15 gates:")
seen=set()
for _ in range(200000):
    seen.add(rand_formula_correct(15))
print(f"Distinct TTs: {len(seen)} (was 5556 with buggy early-return version)")
print(f"Still << 4294967296 and << 20355231, but this is LOWER bound only")
print(f"Upper bound via Shannon: Catalan(15)=9694845 * 3^15=14M * 7^16=3e13 => ~4e27 >> 4B")
print(f"So Shannon alone not enough for k=15, need k=5 or 6 to get bound <20M")
print(f"For k=6: Catalan=132 * 3^6=729 * 7^7=823543 => 79M >20M")
print(f"For k=5: Catalan=42 * 243 * 117k => 1.1B? Wait compute")
for k in range(1,10):
    cat=math.comb(2*k,k)//(k+1)
    ub=cat * (3**k) * (7**(k+1))
    print(f"k={k} upper bound formulas ~ {ub:.2e} vs 20M with 1419")
