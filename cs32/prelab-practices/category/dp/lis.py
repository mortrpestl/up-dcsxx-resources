from functools import cache

a = "awsdafszd"
b = "abcdefghi"

n1, n2 = map(len, (a, b))



#lcs(i,j) - longest subsequence of a[i:] and b[j:]
# define your recurrences properly!

@cache
def lcs1(i, j):
    if i >= n1 or j >= n2:
        return 0
    if a[i] == b[j]:
        return 1 + lcs1(i+1, j+1)
    else:
        return max(lcs1(i+1, j), lcs1(i, j+1))

def lcs2(i,j):
    dp = [ [0 for _ in range(n2+1)] for _ in range(n1+1)]
    
    for i in range(n1-1, -1, -1):
        for j in range(n2-1, -1, -1):
            if a[i] == b[j]: dp[i][j] = 1+dp[i+1][j+1]
            else:
                dp[i][j] = max( dp[i+1][j], dp[i][j+1] )
    
    #we want to get the answer 
    
    res = []
    
    #need to walk this array forward
    i, j = 0, 0
    while i < n1 and j < n2:
        if a[i] == b[j]:
            res.append(a[i])
            i += 1; j += 1
        elif dp[i+1][j] >= dp[i][j+1]:
            i += 1
        else:
            j += 1

    return res
        
        
    # return dp[0][0]
    
        
    
    
    
    
print(lcs1(0, 0))
print(lcs2(0, 0))
