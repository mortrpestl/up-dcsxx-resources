from functools import cache 

def perms(n):
    if n==1: return [[1]]
    return [rest[:i] + [n] + rest[i:] for i in range(n) for rest in perms(n-1)]

# print( perms(5) )

def comb(n, k):
    
    def build(_n, _k):
        if k == _k: return [[]]
        if n == _n: return []
        
        res = []
        curr_el = [_n]
        
        for ans in build(_n+1, _k+1):
            res.append(curr_el + ans)
        
        for ans in build(_n+1, _k):
            res.append(ans)
            
            
        return res
    
    return build(0, 0)

# print( comb(10,3) )
        

def multiset(n, k):
    
    def build(_n, _k):
        if k == _k: return [[]]
        if n == _n: return []
        
        res = []
        curr_el = [_n]
        
        for ans in build(_n, _k+1):
            res.append(curr_el + ans)
            
        # for ans in build(_n+1, _k+1):
        #     res.append(curr_el + ans)
        
        for ans in build(_n+1, _k):
            res.append(ans)
            
            
        return res
    
    return build(0, 0)

print( multiset(10,3) ) 
print( len(multiset(10,3)) ) #must equal ((k+n-1) C (n-1)) = 12 C 9 = 220

#Stirling 2nd kind 

#s[n][k] = s[n-1][k] + k s[n-1][k-1]
#s[0][0] = 1
#s[i][0] = 0
#s[0][i] = 0
#n>k = 0

@cache
def stirling2nd(n,k):
    if n==0 and k==0: return 1
    if k==0 or n==0: return 0
    
    return stirling2nd(n-1,k-1) + k * stirling2nd(n-1,k)

S2_CONST = 10

s2 = [[0 for _ in range(S2_CONST)] for _ in range(S2_CONST)]

stirling2nd(S2_CONST,S2_CONST)
for i in range(S2_CONST):
    for j in range(S2_CONST):
        s2[i][j] = stirling2nd(i,j)
        
# print(*s2, sep='\n')

@cache
def catalan(n):
    if n <= 1: return 1
    return sum(catalan(i) * catalan(n-1-i) for i in range(n))

# for i in range(10):
#     print(catalan(i))


seq = range(6)

def bracketing(seq):
    n = len(seq)

    if n == 0: return [ "" ]
    if n == 1: return [ str(seq[0]) ]
        
    
    res = []
    
    for i in range(1,n):
        left = bracketing(seq[:i])
        right = bracketing(seq[i:])
        
        for l in left:
            for r in right:
                res.append(f'[{l}{r}]')
    
    return res
       
seq = bracketing(range(6))
for b in seq: 
    print(b)
    
print(len(seq))
    




