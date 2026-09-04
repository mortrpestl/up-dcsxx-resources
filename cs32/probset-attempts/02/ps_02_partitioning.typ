

1. You are given an 𝑟 × 𝑐 grid of integers. We number the rows 0 to 𝑟 − 1 from top
to bottom, and 0 to 𝑐 − 1 from left to right, and label the cell at row 𝑖 and column 𝑗 by (𝑖, 𝑗).
A subgrid with top-left corner (𝑖1
, 𝑗1
) and bottom-right corner (𝑖2
, 𝑗2
) consists of all cells (𝑖, 𝑗)
such that 𝑖1 ≤ 𝑖 ≤ 𝑖2
 and 𝑗1 ≤ 𝑗 ≤ 𝑗2
. A subgrid is nonempty if it has at least one cell.
Find the maximum sum of any subgrid


#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[

    We propose an algorithm that enumerates through all possible subgrids:
    ```

    def max_subgrid(grid)

        def sum_subgrid(i1, i2, j1, j2)
            sum = 0

            for i from i1 to i2
                for j from j1 to j2
                    sum += grid[i][j]

            return sum
            
        _max = -infinity

        for i1 from 0 to r-1
            for i2 from i1 to r-1
                for j1 from 0 to c-1
                    for j2 from j1 to c-1
                        sum = sum_subgrid(i1, i2, j1, j2)
                        _max = max(_max, sum)

        return _max
    ```
        
    Bonus -- algorithmic analysis:

    - The two outermost loops run for $0<=i_1<=r-1$ and $0<=i_2<=r-1$, contributing $Theta(r) dot Theta(r) = Theta(r^2)$ iterations.

    - Within this loop runs two inner loops $0<=j_1<=c-1$ and $0<=j_2<=c-1$, contributing $Theta(c) dot Theta(c) = Theta(c^2)$ iterations.

    - For each combination of (i_1, i_2, j_1, j_2), `sum_subgrid` runs in $Theta((i_2-i_1)(j_2-j_1)) = Theta(r c)$ time in the worst case
    ]

#pagebreak()

Given $n$ and $k$, enumerate all the ways to partition ${1,2,dots,n}$ into at most $k$ disjoint nonempty sets.

#let graybox(content) = rect(
  fill: luma(230),
  inset: 8pt,
  radius: 3pt,
  width: 100%
)[#content]

*Possible ideas:*

start at 1.
choices for the next ones:
- go backwards

#graybox[
    Let $"partition"(n,k)$ be a function that partitions ${1,dots,n}$ into at most $k$ disjoint nonempty subsets.

    Let's call the set of answers for $"partition"(n,k)$ the set $U_(n,k)$.

    Notice that $"partition"(n,k)$ depends on:
    - $"partition"(n,k) <--"partition"(n-1, k)$: the resulting answer is just $U_(n-1,k)$ with $n$ placed one of the subsets inside each set $s in U_(n-1,k)$
    - $"partition"(n,k) <--"partition"(n-1, k-1)$: the resulting answer is just $U_(n-1,k-1) union {{n}}$ 

    What about the case $"partition"(n,k) <--"partition"(n, k-1)$? We notice, that the cases in $"partition"(n,k-1)$ are already included in $"partition"(n,k)$ so we can disregard this.

    This suggests an approach. Solve for $"partition"(n,k)$ recursively using $(n-1,k)$ and $(n-1,k-1)$.

    Our base cases are:
    
    - $n=1$: return ${1}$
    - $k=1$: return ${1, ..., n}$

    Also note that for this algorithm, cases where $n<k$ yields no answer (e.g. ${}$).

    ```
    func partition(n, k):
        if n<k: return {}
        if n = 1: return {1}
        if k = 1: return {1, dots, k}

        for each set s in partition(n-1, k-1):
            yield (s U {{n}})

        for each set s in partition(n-1, k):
            for each set s' in s: 
                yield (s' U {n} )
    ```

    Note that each possible set in $U$ is covered exactly once. This disjointness is introduced by the specificity of where the $n$ is placed in each case.
]


#pagebreak()
3. Consider a modified version of the assignment problem where there are $2n$ workers and $n$ tasks, and that one must assign exactly 2 workers per task instead of just 1. 

    Describe an algorithm that solves this problem. Explicitly provide the pseudocode in sufficient low-level detail using the "allowed operations" we've enumerated.


 
Comments from previous attempt

1. "take 2 random workers" isn't an exhaustive search. Take 2 random workers only follows one branch. For example {1, 2, ... n}, saying take 2 random workers say 2, 5, will lead to append {{2, 5} to the rest}, there will be no pairs of {2, 3} or {5, 6}
2. No base case in pairup_workers. When workers become empty, taking 2 random workers will lead to RTE.
3. Minor typo but in for loop discussed earlier, we used `(wi, wj)` but used `w1 and w2` inside
4. The problem asks for an ordering of pairs to be assigned to each task. We should not return a set as it has no concept  of ordering.


#graybox[
    *Solution:*

    Consider the original assignment problem with $2n$ workers and $n$ tasks. We can consider finding all possible pairings of workers. This reduces the problem to the original assignment problem:

    ```
    def pairup_workers(workers):
        S := {} \\ possible pairings

        if workers == {}: return {}

        for each unordered pair (w1, w2) from the elements of workers:
            append ( { {w1, w2} } U pairup_workers( workers \ {w1, w2} ) ) to S
        return S

    def assign(workers, tasks):
        all_pairings = pairup_workers(workers)
    
        best_list := []
        best_cost := +INF

        for each list of pairings U in all_pairings:

            total_cost = 0
            
            for worker pair W_i in U:
                (w1, w2) = W_i
                total_cost += (w1 cost for task i) + (w2 cost for task i)

            if total_cost < best_cost:
                best_list = U
                best_cost = total_cost 

        return best_list, best_cost
    ```
]

#pagebreak()
4. *(Pancake sorting)*

You are given $n$ pancakes $p_0, p_1, dots, p_(n-1)$.

Must sort the pancakes in nondecreasing order. 

What is the minimum number of flips in order to sort the $n$ pancakes?

#graybox()[
    *Solution:* 

    We want to show that there is an upper bound for the number of steps to sort $n$ pancakes.

    We can do it using the following algorithms:

    ```
    def sort_pancake(seq):
        find first i such that p_i is the maximum
        flip top i pancakes
        flip the entire list of pancakes

        if len(seq) > 1: 
            recursively sort the topmost n-1 pancakes
    ```

    This algorithm, depending on $n = "len"("seq")$, runs $2$ times for each pancake to sort, in total $2 dot n = 2n$ flips.

    Hence, there is a solution using at most $2n$ flips.

    The idea is to generate all sequences of flips less than or equal to length $2n$. A flip can be defined by its _index_: flip $i$ flips the first $i$ pancakes. 

    Since one can flip in any index (among $n$) indices, we have $n$ choices for the index for each $2n$ flips.

    By rule of product, we have a finite number of sequences of such flips, precisely $sum_(i=0)^(2n)$ $n^(i)$.

    We have the following function `best_solution` then for a list of pancakes _seq_. It searches through all possible sequences of flips `2*len(seq)` and returns the best among those flips.

    ``` 
    def best_solution(seq):
        best = INF
        
        for flip_sequence in all_flip_sequences( len(seq) ):
            if sequence_solves(flip_sequence): 
                return flip_sequence
    ```

    This function halts because we know there is  asolution in `all_flip_sequences`,
]

#pagebreak()

#graybox()[
    where `all_flip_sequences(n)` defines all the possible flip sequences less than or equal to `2*n` in increasing order of length:

    ```
    def all_flip_sequences(n):
        answer = []

        for i from 0 to 2n:
            answer.extend( all_flip_sequences_of_length_i(i) )

        return answer

    def all_flip_sequences_of_length_k(k):
        res = []

        def backtrack():
            if len(res) == n: 
                yield res
                res.pop()

            for i in 0 to n-1:
                res.append(i)
                backtrack()
                res.pop()

        backtrack()
    ```

    and `sequence_solves(flip_sequence)` is a boolean returning if a sequence of flips sorts the pancake.

    ```
    def sequence_solves(flip_sequence):
        for i in flip_sequence:
            pancake_sort at index i 
        
        if flip_sequence = sorted(flip_sequence): 
            return true
        return false

    ```

    Because we know `all_flip_sequences` is sorted by length, and there is a solution in one of these sequences, `best_solution(seq)` returns the minimum number of flips in order to sort the $n$ pancakes.

]


#pagebreak()

= Old Solution 

#graybox()[
    *Solution:*

    Note that there are a finite number of states in the problem, which is the number of ways to arrange the $p_n$ pancakes which is at most $n!$.

For each state, you can flip from $n-1$ positions to reach another state ($1, .., n-1$).

Hence, we can model the problem states and transitions as an undirected graph with $n!$ vertices and $n! dot (n-1)$ edges.

From this, we can do a complete search from the node representing the current state towards the "sorted" state.

We can make this graph as follows:

```func make_graph(lis): 
    nodes = generate all n! nodes 

    for each node N in nodes:
        for each node \ {node} N':
            for i in 1 to len(lis):
                if flipping N at index p_i of lis results in N' and there doesn't already exist an edge between N' and N:
                    connect N and N' with an edge 
```

This is a function with $n!(n!-1) dot "len"("lis")$  operations. While it admittedly is a lot of operations, it still covers the entire search space.


We can define a function `search(node, visited, dist)` such that:

```
func search(node, visited, dist):
    dist = INF
    if node = sorted:
       return dist

    for all states new_node connected to node not in visited:
        candidate_dist = search(new_node, dist+1)
        if candidate_dist == -1: continue 

        dist = min(dist, candidate_dist)

    return dist
```

and the problem is solved using `search({p_0, p_1, ..., p_(n-1)}, visited, INF)`..



]
