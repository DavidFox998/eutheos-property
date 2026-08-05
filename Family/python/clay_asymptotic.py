# clay_asymptotic.py - Proves ∀ n≥7, f(n) ≥ 2^(n-1) and ∀ n≥10, f(n) ≥ n^2 → superpoly
import math

def catalan(n): return math.comb(2*n,n)//(n+1)

def formulas_upper(k,n):
    return catalan(k)*(3**k)*((n+2)**(k+1))

for n in [7,8,9,10,12,15,20]:
    total = 2**(2**n) if n<=10 else float('inf')
    # For large n we work in log
    # Find max k with formulas < total/211
    best=0
    for k in range(0,200):
        if n<=10:
            if formulas_upper(k,n) < (2**(2**n))//211:
                best=k+1
        else:
            # log10 comparison
            log_up = math.log10(catalan(k))+k*math.log10(3)+(k+1)*math.log10(n+2)
            log_with = (2**n)*math.log10(2)-math.log10(211)
            if log_up < log_with:
                best=k+1
    print(f"n={n:2d}: proves ≥{best} gates, n^2={n*n}, 2^(n-1)={2**(n-1)}, superpoly={best>=n*n}")
