#set text(size: 9pt)

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

    - Thus, `max_subgrid` runs in $Theta(c^2) dot Theta(r^2) dot Theta(r c) = Theta(r^3 c^3)$ time.

    *COMPARE TO SIR KEVIN'S ANSWERS*
    - Sir K's is much cleaner because he uses yield and tuple decomposition.
]

#pagebreak()

2. Given $n$ and $k$, enuemrate all the ways to partition ${1,2, dots, n}$ into at most $k$ disjoint nonempty sets.

*Failed attempt 1 - Misread the question*
#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[

    Observe that given all the partitions of the first $k-1$ elements, the $k$-th element of the list either creates a new partition or appends to the last partition. 
    ```
    def partition(arr)
    
        def par(suf, subset = [])
            if len(suf) == 0
                return [subset]
            
            subset_extended = subset+[[suf[0]]]
            
            if len(subset) == 0
                return par(suf[1:], subset_extended)
            
            subset_appended = subset
            subset_appended[-1].append(suf[0])
            
            return par(suf[1:], subset_extended) + par(suf[1:], subset_appended)
        
    return par(arr)
    ```
]

*Attempt 2*

#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
    Since we are bounded to $k$ partitions, here is a possible way.

    Let $p_n$ be the current number of groups for a given list of $n$ arbitrary elements. For example, the $p_n$ of ${{1,2},{3,4,5},{6,7}}$ is $3$.

    If $p_n<k$, we have $p_n+1$ choices for the current element to go to: one of the $p_n$ groupings or $1$ empty group.
    
    Otherwise, if $p_n = k$, then we have $k$ possible choices for the current element to go to.

    We can create a recursive algorithm that uses this insight:

    ```py
    def enumerate(i, groups):
        if i > n:
            print(groups)
            return

        for j from 0 to len(groups)-1:
            new_groups = groups with i added to groups[j]
            enumerate(i+1, new_groups)

        # start a new group
        if len(groups) < k:
            enumerate(i+1, groups + [{i}])

        enumerate(1, [])
    ```

    Pure function version:
    ```py
    def enumerate(i, groups):
        if i > n:
            return [groups]

        result = []

        for j from 0 to len(groups)-1:
            new_groups = groups with i added to groups[j]
            result += enumerate(i+1, new_groups)

        if len(groups) < k:
            result += enumerate(i+1, groups + [{i}])

        return result

    print(enumerate(1, []))
    ```

    Feedback:
    - Sir Kevin uses tuple destructuring and a lot of helper functions. He used some `two_splits` approach, and the idea of "locking the first element". But I think my idea for this problem also works!

]

#pagebreak()


3. Consider a modified version of the assignment problem where there are 2$n$ workers and $n$ tasks, and that one must assign exactly two workers per task instead of just one. Describe an algorithm that solves this problem. Explicitly provide the pseudocode in sufficient low-level detail using the “allowed operations” we’ve enumerated.

*Attempt 1 : MISREAD THE QUESTION* 

#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
        ```py
        def assignment2(lis):
        
            def assign(lis, groups):
                n := len(lis)

                if n == 0: return [groups]

                result = []

                # the plan is to form the pairs {lis[0], lis[i] for 1<=i<=n-1}. Then we can group this pair up with the possible pairings for the rest of the list.

                for i from 1 to n-1:
                    rest = lis with entry at index i removed
                    result.append( assign(rest, groups + [{lis[0], lis[i]}]) )

                return result

            return assign(lis, [])

        ```

        *Correctness of the algorithm (attempt 1): *

        We claim that `assign(lis, groups)` correctly to group the even-length list `lis` into pairs (and stored in `groups` for eventual returning).

        We do this by induction on $k$, where `k := len(lis)`.

        _Base Case:_

        $k = 0$, then there are no more workers to pair. By our claim, `assign(lis, groups)` should return a possible group of pairings, in the form of `[groups]`.

        _Inductive Hypothesis: _

        Assume that `assign(lis, groups)` is correct for all lists of length $k-2$. That is, it correctly returns a possible partitions of a $(k-2)$-length list.

        _Inductive Step:_

        We now take a look at how `assign(lis, groups)` returns a result. It takes the first element and iterates through the list's elements at index $1 <= i <= k - 1$.

        For each $i$ chosen, the function then calls `assign(rest)`, where `rest := lis with elements at index 0, i removed`. Thus, rest is a list of $k-2$ elements. Using our inductive hypothesis, this inner `assign` call will build up `groups` further with the correct answer for the partitioning of the remaining $k-2$ elements.

        Therefore, the algorithm is correct. $qed$

        *Correctness of the algorithm (attempt 2): * 


        We claim that `assign(lis, groups)` returns all ways to partition `lis` into pairs, with each partition prepended by `groups`.

        We do this by induction on $k$, where `k := len(lis)`.

        _Base Case:_

        $k = 0$. There are no more workers to pair, so the only valid completion is `groups` itself. The algorithm returns `[groups]`, which is correct.

        _Inductive Hypothesis:_

        Assume that `assign(lis, groups)` correctly returns all pairings of any list of length $k - 2$, prepended by `groups`.

        _Inductive Step:_

        Consider any valid pairing of `lis`. It must pair `lis[0]` with some element `lis[i]` for $1 <= i <= k-1$. The loop iterates over all such $i$, so every possible partner for `lis[0]` is considered.

        For each $i$, the function calls `assign(rest, groups + [{lis[0], lis[i]}])`, where `rest` is `lis` with elements at indices $0$ and $i$ removed — a list of $k-2$ elements. By the inductive hypothesis, this call correctly returns all pairings of `rest` prepended by `groups + [{lis[0], lis[i]}]`.

        Since the loop exhausts all choices of partner for `lis[0]`, and each choice yields all pairings of the remainder, the union over all $i$ gives all pairings of `lis`. $qed$

        *Some observations on how to prove*:
        - have a good definition! make sure all of your variables are "defined" in the definition.
        - your inductive step should almost feel like youre just describing what happens, where the induction is just to "save you work" for something thats a smaller step of your current "yap".

    ]

*Attempt 2*

#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
- Sir K utilizes a "create new task" duplicated strategy, and once again, LOTs of helper functions 
- can use "words"
- cheapest_assignment_pairwork
- cheapest_assignment 
- permutations (keywords: insert between permutations(n-1) )
- insert

]


#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
TEST
]
#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
TEST
]
#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
TEST
]
#block(
    fill : rgb("#e4edf3"),
    inset : 8pt,
    width: 100%
    )[
TEST
]





