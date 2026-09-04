= CS 31 Problem Set 3 Attempts
*Diogn Lei R. Mortera*
06/12/2026

Failed proof Idea

Given a sequence `seq` of length $n$, find its number of inversions, i.e., the number of pairs of indices $(i,j)$ such that $0<=i<j<n$ and `seq[i]>seq[j]`

*Proof:*

Outer Loop invariant - by the time step $i (0<=i<=n-1)$ finishes, `ans` contains the number of inversions among all pairs $(p_i, p_j)$ where $p_i <= i$ and $p_j$ is determined by the inner loop

Inner Loop invariant - by the time step $j$ finishes, the `ans` 

Initialization:

Maintenance:

Termination:


*Proof pattern:*

- Explain the algorithm
- For inner/outer loops -- maybe prove the inner loop first
- You can involve "updates" in your loop invariants