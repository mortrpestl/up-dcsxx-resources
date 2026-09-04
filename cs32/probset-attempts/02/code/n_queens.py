def solveNQueens(n):

    res = []
    
    def backtrack(i):
        
        if len(res) == n: 
            yield res[:]
            return

        for j in range(n):
            if not valid(i, j):
                continue

            res.append((i, j))
            yield from backtrack(i+1)
            res.pop()

    def valid(i,j):
        for _i, _j in res:
            if abs(i - _i) == abs(j - _j) or i == _i or j == _j:
                return False

        return True
    
    answers = [*backtrack(0)]

    def convert(lis):
        grid = [['.' for _ in range(n)] for _ in range(n)]
        for i, j in lis: grid[i][j] = 'Q'
        
        return '\n'.join([''.join(g) for g in grid])
    # answers = [*backtrack(0)]
    return [convert(a) for a in answers]

for i in range(1,20):
    print(f"{i}: {len(solveNQueens(i))}")
    