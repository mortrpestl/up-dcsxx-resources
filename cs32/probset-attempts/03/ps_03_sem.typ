#set quote(block: true)

#let gb(content) = rect(
  fill: luma(230),
  inset: 8pt,
  width: 100%
)[#content]

1.1 
- max number in the partition (=m or <=m?)

#gb()[

Let $p(n,m)$ be the ways $n$ can be expressed as the sum of a nondecreasing sequence of positive integers where all numbers in the partition are $<= m$.

Then our problem reduces to finding $p(n,n)$.

We use structural induction over $n$ and $m$. Note that in every step, at least one of $n$ and $m$ decreases, and they never increase in each transition.

*Base case(s).*
$n <= 0$. There are no ways to partition a nonpositive integer, hence the answer is $0$.

$m = 0$. There are no ways to partition an integer into $0$ parts, hence the answer is $0$.

*Inductive case.*
Otherwise, we can break down $p(n,m)$ into two cases:

$p(n, m-1)$: none of the numbers in the partition is $m$. Then they are $<m$. Hence, we can recurse with $m-1$.

$p(n-m, m)$: at least one of the numbers in the partition is $m$. Then, we can remove this $m$ and recurse.

Since these two cases are disjoint, by rule of sum: $ p(n,m) = p(n,m-1) + p(n-m,m) $.

But this is exactly what the function returns. 

Hence, $p(n,m)$ correctly returns the ways $n$ can be expressed as the sum of a nondecreasing sequence of positive integers where all numbers in the partiiton are $<= m $.

By extension, $p(n,n)$ as we explained initially, returns the correct answer. $qed$
] 

1.2
- smallest number in the partition (=m or >=m?)

1.3
- include 1 or not in the partition or not?
    - although im not sure how the sum(p(n,l)) is integrated here

2.

Solution ideas:
- Prove invariant for `subarray_sums()`

"Right before iteration $i$, `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1,k+1), dots, "seq"[i, k+i)$.

- Must first prove inner invariant for `prefix_sums` as lemma

#gb()[

*Lemma 1. `prefix_sum` is correct*

    We prove the invariant for `prefix_sums` at $ 0 <= i <n = "len(seq)"$:

#quote[Right before iteration $i$, $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0,i)$.]

*Initialization:*


At $i=0$, there is only one prefix sum processed, $"seq"[0:0)$. This subarray is empty, hence $s=[0].$

*Maintenance:*

Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

Right before iteration $i$, $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0,i)$.

During iteration $i$, a value $"seq"[i]$ representing the prefix sum for $"seq"[0:i]$, is added to $"seq"[i]$.

We know from the definition of prefix sums that:

$ (sum "seq"[0:i)) + "seq"[i] = sum "seq"[0:i+1) $

Hence, this proves the invariant (right after iteration $i$ implies right before iteration $i+1$, which implies $s$ contains $"seq"[0:0), "seq"[0:1), dots, "seq"[0,i+1)$)

*Termination:*

The loop terminates at $i=n$. Since the invariant is maintained, we can say $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0,n)$.

$qed$
] 
#pagebreak()

#gb()[

We can now prove the invariant for `subarray_sums` for $0<=i<=n-k$:

#quote[Right before iteration $i$, `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1,k+1), dots, "seq"[i, k+i)$. ]

It is equivalent to saying that `subarray_sums(seq,k)` returns all the subarray sums of length $k$ in `seq`.

*Initialization:*

At $i=0$, there is no subarray processed yet. Therefore, `res` is empty.

*Maintenance:*

Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

Right before iteration $i$, contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1,k+1), dots, "seq"[i, k+i)$.

Then $s[k+1]-s[k]$ is appended to  `res`. What does this term signify?

We have proven from the Lemma above that `prefix_sum` is correct. Therefore:

$ s[i+k]-s[i] &= sum "seq"[0,i+k) - sum "seq"[0,i] \
& = sum_(j=0)^(i+k-1) "seq"[j] -  sum_(j=0)^(i+1) "seq"[j] \
& = sum_(j=i)^(i+k-1) "seq"[j] \
& = "subarray sum for" "seq"[i,k+i] 
$

Hence, the subarray sum for $"seq"[i, k+i]$ is being appended to `res`. This proves our invariant.

*Termination:*

The loop terminates at $i=n-k$. Since the invariant is maintained, we can say `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1,k+1), dots, "seq"[n-k, n)$. 

Therefore, we have proven the correctness of `subarray_sums`. This implies that `subarray_sums(seq,k)` returns the subarray sums of length $k$ in `seq`.

$qed$

]

#pagebreak()

3.

- Outer invariant

    - Right before iteration $i$, ans contains the answer for all pairs in ${ (x,y) | x < i }$.

- Inner invariant 

    - Right before iteration $j$, ans contains the answer for all pairs in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$

#gb()[

    Proving the inner loop invariant first:

    *Initialization:*

    We prove the invariant for the inner loop at $i+1 <= j <= n-1$:

    #quote[Right before iteration $j$, ans contains the answer for all pairs in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$
]
    *Maintenance:*

    Suppose the invariant holds before iteration $j$. We want to show it still holds right after iteration $j$.

    Right before iteration $i$, ans contains the answer for all pairs in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$.

    During iteration $i$:

    - If $"seq"[i] > "seq"[j]$: an inversion is found, and $"ans"$ is incremented.

    - Else: No changes.

    Either way, the inversrion in $(i,j)$ is checked. Hence:

    Right after iteration $j$ (and right before j+1), ans contains the answer for all pairs in ${(x,y) | x < i} union {(i,y) | i+1 <= y <= j < j+1}$.

    The invariant is maintained.

    *Termination:*

    The loop terminates at $n-1$. Because the invariant is maintained, ans contains the answer for all pairs in ${(x,y) | x < i} union {(i,y) | i+1 <= y <= n-1}$ or ${(x,y) | x <=i<i+1}.$

    We can now use this for the outer loop.
]

#gb()[
    Proving the outer loop invariant:

    *Initialization:*

    We prove the invariant for the inner loop at $0<=i<=n-1$:
    #quote[Right before iteration $i$, ans contains the answer for all pairs in ${ (x,y) | x < i }$.]

    *Maintenance:*

    Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

    Right before iteration $i$, ans contains the answer for all pairs in ${ (x,y) | x < i }$.

    During iteration $i$, the inner loop as proven extends `ans` to cover ${ (x,y) | x <= i <i+1}$

    As iteration $i$ finishes, the invariant is maintained.


    *Termination:*

    The loop terminates at $n-1$. Hence, `ans` takes into account the inversrions from ${(x,y) | x <= n-1}$ or in other words, all of the pairs in the loop.

    Hence, `inversions` calculates the number of inversions correctly.

    
    
]

4.

Old Invariant: 

At step k of the $"while"$ loop, the prefix of length $k$ and the suffix of length $k$ is swapped in order.

Revised Invariant (thanks Claude):

Before iteration $k$ (with $i = k$ and $j = n-1-k$), for all $x < k$:
$ "seq"[x] = "seq"_0 [n-1-x] $
$ "seq"[n-1-x] = "seq"_0 [x] $
where $"seq"_0$ denotes the original sequence, and the middle segment
$"seq"[k..n-1-k]$ still equals $"seq"_0 [k..n-1-k]$.

#gb()[

We want to prove that `reverse` works with the following invariant:


#quote[Before iteration $k$ (with $i = k$ and $j = n-1-k$), for all $x < k$:
$ "seq"[x] = "seq"_0 [n-1-x] $
$ "seq"[n-1-x] = "seq"_0 [x] $
where $"seq"_0$ denotes the original sequence, and the middle segment
$"seq"[k..n-1-k]$ still equals $"seq"_0 [k..n-1-k]$.]

*Initialization:*

Before iteration 0, there are no changes to the array.

*Maintenance:*

Suppose the invariant holds before iteration $i$. We want to show that it still holds after iteration $i$.

Before iteration $k$ (with $i = k$ and $j = n-1-k$), for all $x < k$:
$ "seq"[x] = "seq"_0 [n-1-x] $
$ "seq"[n-1-x] = "seq"_0 [x] $

After swapping $i = i$ and $j = n-1-i$, the invariant still holds for $x <= k < k+1$:

$ "seq"[x] = "seq"_0 [n-1-x] $
$ "seq"[n-1-x] = "seq"_0 [x] $

Hence, the invariant still holds right after iteration $i$.

*Termination:*

The loop ends at $i > j$. By this point, all "to-swap" elements have been swapped and therefore the entire array is reversed.

$qed$




]

#pagebreak()

5.

Invariant:

Before iteration $i$, `ans` contains the sum of subtrings of $s_0 s_1 .. s_i$.

Before iteration $i$, `suff` contains the sums of all substrings ending in $s_i$.


#gb()[
    *Lemma 1.* 
    For all $0 <= i <= n$:
    #quote[Before iteration $i$, `suff` contains the sums of all substrings ending in $s_i$.]

    *Initialization.* In $i=0$, there are clearly no substrings of length $0$. Therefore, `suff = 0`.

    *Maintenance.*

    Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.
    
    Note that there are $i+1$ such substrings that end in $s_i (i+1-0)$. 
    
    Let these digits be $ s_(i), quad s_(i-1) s_i, quad dots, quad s_(0)s_1 .. s_i $
    
    We want to essentially add $s_(i+1)$ to the ends of each of these strings.

    We can do that by multiplying each number by $10$ and adding $s_(i)$.

    Let $"suff_old"$ and $"suff"_"new"$ be the old and new `suff` value we want.
    
    Then 

    $ "suff"_"old" = s_(i) + s_(i-1)s_(i)+dots+s_(0)s_1..s_(i) $

    Let $s_(i) = d$. Then we can obtain `suff_new` from `suff_old` by:

    $"suff"_"new" &= (10 dot s_i+d) + (10 dot s_(i-1) s_i + d)+ dots + (10 dot s_(0)s_1 ..s_i + d) \
    &= 10 (s_(i-1) + s_(i-2)s_(i-1)+dots+s_(0)s_1..s_(i-1))+(i-0+1)dot d \ 
    &= 10 dot "suff"_"old" + (i+1)dot d$

    Since this is precisely what the mainteneance step does in the algorithm, the invariant is preserved right after iteration $i$.

    *Termination.*

    The loop terminates at $i=n-1$. Hence, `suff` now contains the sum of substrings ending in $s_(n-1)$.

    We will observe that this termination step matters less, because the next invariant (which proves the correctness for obtaining `ans`) relies more on the maintenance step per iteration.
    
]

#gb()[

    Now we can prove the main loop for `ans`.

    We will prove the invariant for $0<=i<=n$:

    #quote[Before iteration $i$, `ans` contains the sum of subtrings of $s_0 s_1 .. s_i$.]

    *Initialization:*

    Before $i=0$, there are no substrings to consider. Hence, `ans := 0`


    *Maintenance:*

    Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

    Note that we have proven with Lemma 1 that `suff` at iteration `i` contains the sums of all substrings ending in $s_i$. In fact, we can show that after extending $s_0 s_1 .. s_(i-1) -> s_0 s_1 .. s_(i-1)s_i$, that the only new substrings to consider are those subarrays that end in $s_i$. This is precisely $"suff"$ _right after_ iteration $i$.

    Let $"ans"_"old"$ and $"ans"_"new"$ be `ans` before and after iteration $i$ respectively. 

    Since the update for $"suff"$ is processed right before the update for $"ans"$, we can see that:

    $ "ans"_"old" + "suff" = \
     sum "(digit sum of substrings not ending in" s_i  ")" + \ 
     sum "(digit sum of substrings ending in" s_i")" \
      = sum "(all subarrays of" s_0 s_1 .. s_i ")" \
      = "ans"_"new" $

    by rule of sum.

    Hence, the invariant is kept.

    *Termination:*

    The loop terminates at $i = n-1$. Hence, the loop returns the answer for $s_0 s_1 .. s_(n-1) = s$.

    This shows that `substring_sum(s)` is correct. $qed$
]