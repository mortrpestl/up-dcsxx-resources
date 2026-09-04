seq = [0,1,2,3,4]

def subsets(seq):
    n = len(seq)
    
    res = []
    
    def backtrack(start):
        yield res
        
        if len(res) == n: 
            return 
        
        for i in range(start+1,n):
            res.append(seq[i])
            yield from backtrack(i)
            res.pop()
    
    return [*backtrack(-1)]
    
    
    
print(len(subsets(seq)))
