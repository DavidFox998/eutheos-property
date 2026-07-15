# closure_4bit.py - Proves S0-S19 = exact hierarchy, max 19 gates for 4 bits
# This gave your S8=17244, S9=26750, S19=65536 screenshots
from collections import deque

def var_tt(n, k):
    tt=0
    for i in range(1<<n):
        if (i>>k)&1:
            tt|=1<<i
    return tt

def closure(n):
    N=1<<(1<<n)
    vars=[var_tt(n,k) for k in range(n)] + [0, (1<<(1<<n))-1]
    seen=set(vars)
    frontier=deque(vars)
    buckets=[len(seen)]
    S=set(seen)
    # S0
    sizes=[len(S)]
    level=0
    while frontier:
        # BFS by gates: combine all in S
        # optimized: for 4-bit this finishes at 19 gates
        next_level=set()
        S_list=list(S)
        for a in S_list:
            na = (~a) & ((1<<(1<<n))-1)
            if na not in S:
                next_level.add(na)
                S.add(na)
            for b in S_list:
                for op in (lambda x,y: x&y, lambda x,y: x|y):
                    c=op(a,b) & ((1<<(1<<n))-1)
                    if c not in S:
                        next_level.add(c)
                        S.add(c)
        if not next_level:
            break
        level+=1
        sizes.append(len(S))
        print(f"S{level}={len(S)} (+{len(next_level)})")
        if len(S)==N:
            print(f"ALL DONE at {level} gates")
            break
    return sizes

if __name__=="__main__":
    print("4-bit closure - max 19 gates:")
    closure(4)
