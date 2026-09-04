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

Then our problem reduces to finding $p(n,n)$. We want to express $n$ into a sum of nondecreasing sequence of positive integers where all numbers in the partition are $<= n$. 

- Using an $m<=n-1$ will lose the sole $n$ case $(m = n-1)$ and more cases $(m < n-1)$
- Using $m > n$ will not apply to the problem because you cannot split a number $n$ into more than $n$ positive parts.

We use structural induction over $n$ and $m$. Note that in every step, $n+m$ always decreases and is nonnegative until the base cases.

*Base case(s).*

$n = 0$. There are no ways to partition 0 into some nondecreasing sequence of positive integers, hence the answer is $0$.

$n < 0$. There are no ways to partition a negative number into some nondecreasing sequence of positive integers, hence the answer is $0$.

$m = 0$. There are no ways to partition an positive integer $n$ into parts if all numbers in the partition are $<=0$, hence the answer is $0$.

*Inductive case.*
Otherwise, we can break down $p(n,m)$ into two cases:

$p(n, m-1)$: none of the numbers in the partition is $m$. Then they are $<m quad (<= m-1)$. Hence, we can recurse with $m-1$. For $n$, it stays the same because we are still trying to partition the same number.

$p(n-m, m)$: at least one of the numbers in the partition is $m$. Then, we can remove this $m$ (resulting to $n-m$) and recurse. For $m$, it stays the same because the bound for maximum number in the sequence did not change.

Since these two cases are disjoint, by rule of sum: $ p(n,m) = p(n,m-1) + p(n-m,m) $ 

But this is exactly what the function returns. 

Hence, $p(n,m)$ correctly returns the ways $n$ can be expressed as the sum of a nondecreasing sequence of positive integers where all numbers in the partition are $<= m $.

By extension, $p(n,n)$ as we explained initially, returns the correct answer. $qed$
] 

1.2
- smallest number in the partition (=m or >=m?)

1.3
- include 1 or not in the partition or not?
    - although im not sure how the sum(p(n,l)) is integrated here

#gb()[
Let $p(n,l)$ be the ways $n$ can be expressed as the number of ways to split a nonnegative integer into $l$ positive integers.

$sum(p(n,l))$ returns the number of ways $n$ can be expressed as a sum of $S ={0,1,2,..,n}$ positive integers. Therefore, it solves the original problem of getting the number of ways to $n$ of an arbitrary length sequence of positive integers.

We cannot include $<0$ because it is impractical to split a number into a negative number of parts, and we cannot include >=(n+1) because there is no way to split $n$ into $>=n+1$ parts (every part is $>0$, so a partition into $n+1$ positive integers has sum at least $n+1>n$.)

We use induction on $n+l$. We note that for each recursion, $n+l$ is always decreasing.

*Base cases:*

- $n=0$ and $l=0$. There is exactly 1 way to express $0$ without any positive integers, which is an empty sequence.

- $n<=0$: A nonpositive integer cannot be split into a sequence of positive integers. Hence, this returns 0.

- $l=0$: Note that $n=0$ has already been taken care of above, implying $n!=0$. A nonzero integer cannot be represented with no parts. Hence, this returns 0.
 
*Inductive case:*

We split by two cases: $1$ is in the sequence or not.

#text(fill:blue)[These cases are mutually exhaustive (these are the only possibilities for a sequence) and disjoint (a sequence either has a 1 or not).]

If it is, then we just have to split the remainder $n-1$ into $l-1$ parts. Hence, $p(n-1,l-1)$.

Otherwise, this implies each part is $>=2$. We can then remove $1$ from each $l$ integers. Now we just have to partition $n-l*1 = n-l$ into still $l$ parts. Hence $p(n-l,l)$

By rule of sum (since the cases are disjoint by existence of 1 or not in the sequence), we get $p(n,l) = p(n-1, l-1)+p(n-l,l)$

But this is exactly what the function returns.

Hence, $p(n,l)$ is correct. And by extension, `sum(p(n,l) for l from 0 to n)` returns the correct answer for `partitions(n)` as we reasoned about.

$qed$
]

2.

Solution ideas:
- Prove invariant for `subarray_sums()`

"Right before iteration $i$, `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1,k+1), dots, "seq"[i, k+i)$.

- Must first prove inner invariant for `prefix_sums` as lemma

#gb()[

Before proving the outer invariant, we prove a Lemma related to the `prefix_sum`.

Note that `prefix_sum(seq)` returns the sum of subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0:i)$.

*Lemma 1. `prefix_sum` is correct*

    We prove the invariant for `prefix_sums` at $ 0 <= i <n = "len(seq)"$:

#quote[Right before iteration $i$, $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0:i)$.]

*Initialization:*


At $i=0$, there is only one prefix sum processed, $"seq"[0:0)$. This subarray is empty, hence $s=[0].$

*Maintenance:*

Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

Right before iteration $i$, $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0:i)$.

During iteration $i$, a value $"seq"[i]$ representing the prefix sum for $"seq"[0:i]$, is added to $"seq"[i]$.

We know from the definition of prefix sums that:

$ (sum "seq"[0:i)) + "seq"[i] = sum "seq"[0:i+1) $

Hence, this proves the invariant (right after iteration $i$ implies right before iteration $i+1$, which implies $s$ contains the prefix sums for $"seq"[0:0), "seq"[0:1), dots, "seq"[0:i+1)$)

*Termination:*

The loop terminates at $i=n$. Since the invariant is maintained, we can say $s$ contains the prefix sums for subarrays $"seq"[0:0), "seq"[0:1), dots, "seq"[0:n)$.

$qed$
] 
#pagebreak()

#gb()[

We can now prove the invariant for `subarray_sums` for $0<=i<=n-k$:

#quote[Right before iteration $i$, `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1:k+1), dots, "seq"[i-1: k+i-1)$. ]

#text(fill : blue)[Note to Self: remember be careful with the invariant bounds ($i$ vs. $i+1$)]

It is equivalent to saying that `subarray_sums(seq,k)` returns all the subarray sums of length $k$ in `seq`.

*Initialization:*

At $i=0$, there is no subarray processed yet. Therefore, `res` is empty.

*Maintenance:*

Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

Right before iteration $i$, contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1:k+1), dots, "seq"[i-1: k+i-1)$.

Then $s[k+1]-s[i]$ is appended to  `res`. What does this term signify?

We have proven from the Lemma above that `prefix_sum` is correct. Therefore:

$ s[i+k]-s[i] &= sum "seq"[0:i+k) - sum "seq"[0:i) \
& = sum_(j=0)^(i+k-1) "seq"[j] -  sum_(j=0)^(i-1) "seq"[j] \
& = sum_(j=i)^(i+k-1) "seq"[j] = sum_(j=i)^((k+i)-1) "seq"[j] \
& = "subarray sum for" "seq"[i:k+i)
$

Hence, the subarray sum for $"seq"[i: k+i)$ is being appended to `res`. This proves our invariant.

*Termination:*

The loop terminates at $i=n-k$. Since the invariant is maintained, we can say `res` contains the subarray sums for the first $i$ subarrays $"seq"[0:k), "seq"[1:k+1), dots, "seq"[n-k: n)$. 

Therefore, we have proven the correctness of `subarray_sums`. This implies that `subarray_sums(seq,k)` returns the subarray sums of length $k$ in `seq`.

$qed$

]

#pagebreak()

3.

- Outer invariant

    - Right before iteration $i$, ans contains the number of inversions in ${ (x,y) | x < i }$.

- Inner invariant 

    - Right before iteration $j$, ans contains the number of inversions in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$

#gb()[

    We want to prove the inner loop invariant first. That is, to prove the invariant for the inner loop at $i+1 <= j <= n-1$:

    #quote[Right before iteration $j$, ans contains the number of inversions in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$
    ]
    *Initialization:*

    Before $j = i+1$, there are no inversions considered yet. Hence, ans contains the answer for ${x,y) | x < i} union {} = {(x,y) | x < i}$.

    #text(fill : blue)[Note to self: make sure your individual steps are filled with answers! ]

    *Maintenance:*

    Suppose the invariant holds before iteration $j$. We want to show it still holds right after iteration $j$.

    Right before iteration $i$, ans contains the number of inversions in ${(x,y) | x < i} union {(i,y) | i+1 <= y < j}$.

    During iteration $i$:

    - If $"seq"[i] > "seq"[j]$: an inversion is found, and $"ans"$ is incremented.

    - Else: No changes.

    Either way, the inversrion in $(i,j)$ is checked. Hence:

    Right after iteration $j$ (and right before j+1), ans contains the number of inversions in ${(x,y) | x < i} union {(i,y) | i+1 <= y <= j}$.

    The invariant is maintained.

    *Termination:*

    The loop terminates at $n-1$. Because the invariant is maintained, ans contains the number of inversions in ${(x,y) | x < i} union {(i,y) | i+1 <= y <= n-1}$ or ${(x,y) | x <= i}.$

    We can now use this for the outer loop.
]

#gb()[
    Proving the outer loop invariant:

    *Initialization:*

    We prove the invariant for the inner loop at $0<=i<=n-1$:
    #quote[Right before iteration $i$, ans contains the number of inversions in ${ (x,y) | x < i }$.]

    *Maintenance:*

    Suppose the invariant holds before iteration $i$. We want to show it still holds right after iteration $i$.

    Right before iteration $i$, ans contains the number of inversions in ${ (x,y) | x < i }$.

    During iteration $i$, the inner loop as proven extends `ans` to cover ${ (x,y) | x <= i <i+1}$

    As iteration $i$ finishes, the invariant is maintained.


    *Termination:*

    The loop terminates at $n-1$. Hence, `ans` takes into account the inversions from ${(x,y) | x <= n-1}$ or in other words, all of the pairs in the loop.

    Hence, `inversions` calculates the number of inversions correctly.

    
    
]

#pagebreak()

4.

#gb()[
    We want to prove that `reverse` works with the following invariants:

    #quote()[
        - For all $k < i$, $"seq"[k]$ and $"seq"[n-k-1]$ have been swapped.
        - For all $i$, $quad j := n-i-1$
    ]

    *Initialization:*

    Before the first iteration, no elements have been swapped yet.

    Also, $(i,j) = (0, "len"("seq")-1) = (0, n-1)$ as defined. Our invariants still hold.

    *Maintenance:*

    Suppose the invariant holds before some iteration. We want to show it still holds after that iteration.

    Suppose this iteration is $i$.

    Before this iteration: 
    - For all $k < i$, $"seq"[k]$ and $"seq"[n-k-1]$ have been swapped.
    - $j = n-i-1$

    During this iteration, $i$ is incremented ($i := i+1$) and $j$ is decremented. Hence $j := j - 1 := (n-i-1) - 1 := (n-(i+1))-1$. Our second invariant still holds.

    Then a swap between this new $"seq"[i+1]$ and $"seq"[j] = "seq"[(n-(i+1))-1]$ occurs.
    
    This means that for $k<i$ and $k=i$, or in other words $k<=i<i+1$, $"seq"[k]$ and $"seq"[n-k-1]$ have been swapped.

    Hence, our first invariant also holds.



    *Termination:*

    When the loop terminates, then $i >= j$. This is eventually reached because $i<j$, $i$ and $j$ are finite, $i$ increments, and $j$ decrements. Refer to Lemma below for the proof.
    
    
    By then, the array is `reversed`, because all elements in $i<j$ would have been swapped already, covering the entire array.
    
    (For the $i=j$ case, a middle element in an odd-length array does not need swapping.)

    $qed$
]


#pagebreak()

*Lemma.* This is eventually reached because $i<j$, $i$ and $j$ are finite, $i$ increments, and $j$ decrements. Refer to Lemma 2 for the proof.

#gb()[
    Proof: 

    The distance between $i$ and $j$ is $d = j-i$, and is a positive integer.

    After 1 iteration, $d_1 = (j-1)-(i+1) = d - 2$ 

    After $k$ iterations, $d_k = (j-k)-(i+k) = d - 2k$.

    We want to show that there is some finite $k$ such that $d - 2k <= 0$.

    $d <= 2k => k >= d/2 >= ceil(d/2)$.

    We see that $k = ceil(d/2)$ is such a $k$. Since $d = j-i$ is finite (closure over the integers), then $k>= ceil(d/2)$ is also finite.

    Therefore, $i>=j$ is eventually reached after some finite $k = ceil(d/2)$ iterations.



] 

Claim:

For all $0 <= i <= n$:
- Before iteration $i$, `suff` contains the sums of all substrings ending in $s_(i-1)$.
- Before iteration $i$, `ans` contains the sum of subtrings of $s_0 s_1 .. s_(i-1)$.


#gb()[

    *Initialization.* 
    - In $i=0$:
    - there are no substrings ending in $s_(-1)$. Therefore, `suff := 0`.

    - there are no substrings of $s_(-1)$. Hence, `ans := 0`



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

    Since this is precisely what the maintenance step does in the algorithm, the first invariant is preserved right after iteration $i$.

    With this, since `suff` at iteration `i` contains the sums of all substrings ending in $s_i$, we can show that after extending $s_0 s_1 .. s_(i-1) -> s_0 s_1 .. s_(i-1)s_i$, that the only new substrings to consider are those subarrays that end in $s_i$. This is precisely $"suff"$ _right after_ iteration $i$.

    Let $"ans"_"old"$ and $"ans"_"new"$ be `ans` before and after iteration $i$ respectively. 

    Since the update for $"suff"$ is processed right before the update for $"ans"$, we can see that:

    $ "ans"_"old" + "suff" = \
     sum "(digit sum of substrings not ending in" s_i  ")" + \ 
     sum "(digit sum of substrings ending in" s_i")" \
      = sum "(all subarrays of" s_0 s_1 .. s_i ")" \
      = "ans"_"new" $

    by rule of sum.

    Hence, the invariant is kept.
]

#gb()[
    *Termination.*

    The loop terminates at $i=n-1$. Hence, `suff` now contains the sum of substrings ending in $s_(n-1)$.

    We will observe that this termination step matters less, because the next invariant (which proves the correctness for obtaining `ans`) relies more on the maintenance step per iteration.

    Since the second invariant is kept, the loop returns the answer ans for $s_0 s_1 .. s_(n-1) = s$.

    This shows that `substring_sum(s)` is correct. $qed$    
]
