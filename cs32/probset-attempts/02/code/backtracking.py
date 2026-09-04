
def all_integer_seqs(n):
    res = []

    def backtrack():
        
        if len(res) == n: 
            print(res[:])
            return

        for i in range(n):
            res.append(i)
            backtrack()
            res.pop()
            

    backtrack()
        
# all_integer_seqs(5)

def permutations(n):
    res = []

    used = [False for _ in range(n)]
    
    def backtrack():
        
        if len(res) == n: 
            print(res[:])
            return

        for i in range(n):
            if used[i]: continue
            res.append(i+1)
            used[i] = True
            backtrack()
            used[i] = False
            res.pop()
            

    backtrack()
        
permutations(5)