seq = [*range(4)]

def enumerate_subsets(seq):
    n = len(seq)

    res = []
    for i in range(1 << n):
        temp = []
        for j in range(n):
            if i & (1 << j):
                temp.append(seq[j])
        res.append(temp)

    return res

print( enumerate_subsets(seq) )

"""
Count how many length-\(n\) strings do not contain any of these forbidden properties:

\(P_1\): contains at least one A
\(P_2\): contains at least one B
\(P_3\): contains at least one C
...
\(P_k\): contains at least one specified character
"""

alph = "abcdefghijklmnopqrstuvwxyz"
forbidden = set("acefqjoeituz")

def none_forbidden(n):
    
    cnt = 0
    res = []
    def backtrack(k):
        nonlocal cnt
        if k == n: 
            print(''.join(res))
            cnt += 1
            return
        
        for a in alph:
            if a in forbidden: continue 
            res.append(a)
            backtrack(k+1)
            res.pop()
    
    backtrack(0)
    
    return cnt

# print( none_forbidden(4) )
            
# count versions only
def cnt_none_forbidden(n):
    
    cnt = 0
    def backtrack(k):
        nonlocal cnt
        if k == n: 
            cnt += 1
            return
        
        for a in alph:
            if a in forbidden: continue 
            backtrack(k+1)
    
    backtrack(0)
    
    return cnt

print( cnt_none_forbidden(4) )
            
            
            
            
            
    

