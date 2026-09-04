# 1. subsets

def subsets(seq):

    if len(seq) == 0:
        yield ()
        return

    first, rest = seq[0], seq[1:]
    rest_subsets = [*subsets(rest)]
    yield from [(first, *rem) for rem in rest_subsets]
    yield from rest_subsets

# print( *subsets([0,1,2,3]), sep = '\n' )

# 2. subsets of length k / k-combinations

def subsets_k(seq, k):

    if k == 0: yield (); return
    if len(seq) == 0: return

    first, rest = seq[0], seq[1:]
    yield from [(first, *rem) for rem in subsets_k(rest, k-1)]
    yield from subsets_k(rest, k)

# print( *subsets_k([0,1,2,3,4,5], 3), sep = '\n' )

# 3. permutations of length k

def perms_k(seq, k):

    if k == 0: yield (); return
    if len(seq) == 0: return

    first, rest = seq[0], seq[1:]

    for arr in perms_k(rest, k-1):
        n = len(arr)
        for i in range(n+1):
            yield arr[:i] + (first,) + arr[i:]

    yield from perms_k(rest, k)

# print( *perms_k([0,1,2,3,4,5], 3), sep = '\n' )

# 6. Integer partitions (variant 1)

def partitions_1(n):
    # p(n,m) = p(n,m-1) + p(n-m,m)

    def p(n,m):
        if n<0 or m==0:
            return
        if n==0:
            yield ()
            return

        yield from p(n,m-1) #p(n,m-1)
        yield from [(*arr, m) for arr in p(n-m,m)] #p(n-m,m)

    yield from p(n,n)

# print( len([*partitions_1(50)]), sep = '\n' )

# 7. Integer partitions (variant 2)

def partitions_2(n):
    # p(n,m) = p(n,m-1) + p(n-m,m)

    def p(n,m):
        if n==0:
            yield ()
            return
        if m>n:
            return

        yield from p(n,m+1) #p(n,m+1)
        yield from [(*arr, m) for arr in p(n-m,m)] #p(n-m,m)

    yield from p(n,1)

# print( [*partitions_2(5)], sep = '\n' )

# 8. Integer partitions (variant 3)

def partitions_3(n):
    # p(n,l) = #ways to represent n in l parts

    def p(n,l):
        if n==0 and l==0:
            yield ()
            return
        elif n<=0 or l==0:
            return

        yield from [(1, *arr) for arr in p(n-1, l-1)]
        yield from [tuple(a+1 for a in arr) for arr in p(n-l,l)]

    for l in range(0,n+1):
        yield from p(n,l)

# print( [*partitions_3(5)], sep = '\n' )

# 9. multiset combination k
def subsets_k_rep(seq, k):

    if k == 0: yield (); return
    if len(seq) == 0: return

    first, rest = seq[0], seq[1:]
    yield from [(first, *rem) for rem in subsets_k_rep(seq, k-1)]
    yield from subsets_k_rep(rest, k)

# print( *subsets_k_rep([0,1,2,3,4,5], 3), sep = '\n' )

# 10. multiset permutation
def permutations_multiset(seq):
    seq = sorted(seq)
    n = len(seq)
    used = [False] * n
    res = []

    def backtrack():
        if len(res) == n:
            yield tuple(res)
            return

        for i in range(n):
            if used[i]:
                continue
            if i > 0 and seq[i] == seq[i-1] and not used[i-1]:
                continue

            used[i] = True
            res.append(seq[i])
            yield from backtrack()
            res.pop()
            used[i] = False

    yield from backtrack()

# print( *permutations_multiset([1,1,1,2,3,4]), sep = '\n' )

# paths from (0,0) to (r,c) in Up and Right
def all_paths_limited(rows, cols):

    def count_from(r,c):
        if r > rows-1 or c > cols-1:
            return

        if r == rows-1 and c == cols-1:
            yield ((r,c),)
            return

        yield from [((r,c), *arr) for arr in count_from(r+1, c)]
        yield from [((r,c), *arr) for arr in count_from(r, c+1)]

    return count_from(0,0)

# print( *all_paths_limited(5,6), sep='\n' )

# paths from (0,0) to (r,c) in all directions
def all_paths(rows, cols):

    visited = [[False for i in range(cols)] for j in range(rows)]
    res = [(0,0)]

    def backtrack(r,c):
        drc = [(1,0),(0,1),(-1,0),(0,-1)]

        if (r,c) == (rows-1, cols-1): 
            yield res[:]
            return
            
        for dr,dc in drc:
            nr,nc = r+dr, c+dc
            
            if not (0 <= nr < rows and 0 <= nc < cols and not visited[nr][nc]): continue
                
            if visited[nr][nc]:
                return

            visited[nr][nc] = True
            res.append((nr,nc))
            yield from backtrack(nr,nc)
            res.pop()
            visited[nr][nc] = False
            
    visited[0][0] = True 
    yield from backtrack(0,0)
        
print( [*all_paths(6,6)], sep='\n' )

            
            
            




