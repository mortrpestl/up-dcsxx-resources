def combinationSum3(k: int, n: int):

    res = []
    total = 0
    used = {i+1: False for i in range(9)}

    def backtrack(start):
        nonlocal total 
        
        if total == n and len(res) == k:
            yield res[:]
            return

        for i in range(start+1,10):
            res.append(i)
            total += i
            yield from backtrack(i)
            total -= i
            res.pop()

    return [*backtrack(0)]

print( combinationSum3(3, 9) )