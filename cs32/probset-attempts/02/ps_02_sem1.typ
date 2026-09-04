
= Attempt 1
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
- make new group (if so far there are $<k$ disjoint)
- add the next one to one of the existing groups

#graybox[

    *Solution:*

    Let $"partition"(i,k)$ be a function the ways to partition ${1,2,dots,i}$. into at most $k$ disjoint nonempty subsets. Then, we can extend the result from $"partition"(i,k) -> "partition"(i+1,k)$ as follows. 
    
    For each possible way to partition ${1,2,dots,i}$ to some number $(<=k)$ of disjoint nonempty subsets:

    - add $i+1$ to each of the nonempty sets
    - create a new group ${i+1}$ (only if number of sets inside that group is $<k$).

    ```
    def partition(i, k):

        if k = 0: return {}
        if i = 1: return { {1} }

        S' = {} //set of all answers

        for each set S of disjoint nonempty sets in partition(i+1, k):
            k' := number of sets inside S
            
            for each set s in S:
                add { S | s := s U {i+1} } in  S'

            if k' < k: 
                add S U { {i+1} } in S'

        return S'

    ```

    Call $"partition"(n,k)$ to solve the problem.
]

*Comments*
- must explain why each set will be covered exactly once
- recursion goes in the wrong direction

#pagebreak()
= Attempt 2

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

== Attempt 1
Possible ideas:
- complete search ulit --- do something here that gets all possible pairings of workers. Then use the original assignment problem

#graybox[
    *Solution:*

    Consider the original assignment problem with $2n$ workers and $n$ tasks. We can consider finding all possible pairings of workers. This reduces the problem to the original assignment problem:

    ```
    def pairup_workers(workers):
        S := {} \\ possible pairings
        take 2 random workers w1 and w2:
            append ( {w1, w2} U { pairup_workers( workers \ {w1, w2} ) } ) to S
        return S

    def assign(workers, tasks):
        all_pairings = pairup_workers(workers)
    
        best_set := {}
        best_cost := +INF

        for each set of pairings U in all_pairings:

            total_cost = 0
            
            for (wi, wj) in each pair in the pairing
                for each task i in tasks
                    total_cost += (w1 cost with task i) + (w2 cost with task i)

            if total_cost < best_cost:
                best_set = U
                best_cost = total_cost 

        return best_set, best_cost
    ```
]

== Comments

1. "take 2 random workers" isn't an exhaustive search. Take 2 random workers only follows one branch. For example {1, 2, ... n}, saying take 2 random workers say 2, 5, will lead to append {{2, 5} to the rest}, there will be no pairs of {2, 3} or {5, 6}
2. No base case in pairup_workers. When workers become empty, taking 2 random workers will lead to RTE.
3. Minor typo but in for loop discussed earlier, we used `(wi, wj)` but used `w1 and w2` inside
4. The problem asks for an ordering of pairs to be assigned to each task. We should not return a set as it has no concept  of ordering.

#pagebreak()

== Attempt 2
 
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

    We can show that an algorithm exists first. Then we can show a complete search showing that we can test all $n$^(2n) possibilities.
]
