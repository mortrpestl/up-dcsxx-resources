#let title_ = "CS 32 - Problem Set 7"

#import "@preview/ctheorems:1.1.3": *
#show: thmrules

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)
#show heading: it => {
  it.body
}

#set heading(numbering: "1.1.")
#set page(
  header: context(
    if counter(page).get().first() >= 1 [
      #set text(style: "italic")
      #title_ 
      #h(1fr)
      Diogn Lei Mortera 

      #block(line(length: 100%, stroke: 0.5pt), above: 0.6em)
    ]
  )
)

#let bigOm = $cal(Omega)$
#let bigTh = $cal(Theta)$
#let bigO = $cal(O)$
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"), radius: 0em)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em), radius: 0em)
#let print_friendly = false

#let (example, proof, solution, claim, question, problem) = if print_friendly {
  (
    thmplain("example", "Example").with(numbering: none),
    thmbox("proof", "Proof", stroke: 1pt + black, fill: none, radius: 0em).with(numbering: none),
    thmbox("solution", "Solution", stroke: 1pt + black, fill: none, radius: 0em).with(numbering: none),
    thmbox("claim", "Claim", stroke: 1pt + black, fill: none, radius: 0em, base_level: 0),
    thmbox("question", "Question", stroke: 1pt + black, fill: none, radius: 0em, base_level: 0),
    thmbox("problem", "Problem", stroke: 1pt + black, fill: none, radius: 0em, base_level: 1),
  )
} else {
  (
    thmplain("example", "Example").with(numbering: none),
    thmbox("proof", "Proof", fill: rgb("#f2f7e8"), radius: 0em).with(numbering: none),
    thmbox("solution", "Solution", fill: rgb("#f2f7e8"), radius: 0em).with(numbering: none),
    thmbox("claim", "Claim", fill: rgb("#e8e5f2"), radius: 0em, base_level: 0),
    thmbox("question", "Question", fill: rgb("#e8e5f2"), radius: 0em, base_level: 0),
    thmbox("problem", "Problem", fill: rgb("#e8e5f2"), radius: 0em, base_level: 1)

  )
}

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(languages: codly-languages)

#codly(
    smart-indent: false,
    number-format: none,
    display-icon: false,
    zebra-fill: rgb("f0f0f0"),
    fill: rgb("f0f0f0")
    )

#let highlight(body) = align(center)[#box(stroke: 0.5pt, inset: 6pt)[#body]]

#let pd(f,x) = $(partial #f) / (partial #x)$
#align(center)[
  #title(title_)
  Diogn Lei R. Mortera
]

#set align(horizon)

1. Visitations problem

#claim[ Only 1.2 and 1.7 work. ]

#proof[
Recall that a subproblem $(i,l)$ in the visitations problem depends on $(j, l-1)$ where $j>i$. So, we must iterate over increasing $l$ and decreasing $i$.

]

2. 

#claim[ One can use a $2 times n$ array. ]

#proof[
  Note that each subproblem $(i,l)$ only depends on the most recent layer, $l-1$. Hence, we can just have two $1 times n$ arrays $sans("curr")$ and $sans("prev")$, initially storing the values for the current and previous layer, to store these dependencies. For every layer, the old $sans("curr")$ becomes the new $sans("prev")$ and vice versa.
  
  Hence, the algorithm requires $n + n = 2n = Theta(n)$ space. 
]

#proof[
  Note that each subproblem $(i,l)$ only depends on the most recent layer, $l-1$. Hence, we can just have two $1 times n$ arrays $sans("curr")$ and $sans("prev")$, initially storing the values for the current and previous layer, to store these dependencies. For every layer, the old $sans("curr")$ becomes the new $sans("prev")$ and vice versa. This swap can be done using a pointer in $Theta(1)$ time. 
  
  Hence, the algorithm requires $n + n + Theta(1)= Theta(n) + Theta(1) = Theta(n)$ space. 
]

#proof("Old")[
  Note that a subproblem denoted by $(i,l)$ only depends on $l-1$. Hence, we can perform a bottom up DP that overwrites the results of the      
  stale subproblems. Since subproblems $(i',l')$ become stale if $l' < l-1$ or $l' = l-2$, we only need to keep the most recent 2 l values
]

3. 
- appropriate bounds for arguments 
- recurrence 
- base case 
- iniital calls

3.1 

#proof[
  #text(fill: red)[NOT FULLY CORRECT YET, esp the "call" part]


  For $0<=i<n$ and $0<=l<k$,

  $
    M(i,l) = min_(0<=j<i) (|x_i-x_j| + |y_i-y_j| + M(j,l-1))
  $

  with base cases $M(-1,l)=0$.

  The visitation problem is solved with this recurrence by calling $ M(n-1,k)-M(n-1,k-1) $.

  For a fixed $l$, there are $n$ choices of $i$, each requiring $Theta(i)$ time. Hence, there is a total work of  $ sum_(i=0)^(n-1) Theta(i) = n^2 / 2 - Theta(n) = Theta(n^2) $ work for the $j$-loop. Multiplying over $k$ layers gives
$Theta(n^2 k)$ total.

  The whole recurrence has an loop for $j$ that runs in $Theta(n)$ per $i$. Thus, every subproblem runs in $O(n) dot Theta(n) = Theta(n^2)$. The loop for $k$ runs in $Theta(k)$ time. Thus, the algorithm runs in $O(n^2)Theta(k) = Theta(n^2k)$ time.
  
  For a bottom-up DP solution, this problem has $Theta(n k)$ space.
]

3.2 

#proof[

For $0<=i<n$, $0<=j<n$, and $0<=l<k$,

$ M(i,j,l) = min_(k in {j,j+1, dots, n-1}) (|x_1 - x_2| + |y_1 - y_2| + M(k,k+1, l-1)) $

with base case $M(i,j,0) = 0$ ($l=0$ implies no more locations to visit).

The visitation problem is solved with recurrence by calling 

$ M(0,1,k) $

The whole recurrence $n dot n dot k = Theta(n^2 k)$ time.

For the bottom-up DP solution, this problem takes $Theta(n^2 k)$ space.
]

4.1 

#claim[This recurrence never terminates.]

#pagebreak()
4.2 

$ M(i,r)$ := maximum total value among collections of items from item types ${i, i+1, dots, n-1}$ whose total weight is at most $w$.

#claim[The recurrence

$ M(i,r) = max_(k \ 0<=k<= floor(r/w_i)) (v_i dot k + M(i+1, r-w_i dot k)) $

is correct.
]

Proof writing
- Any... gives...

#proof[
  For subproblem $(i,r)$, we consider each possible number of times denomination $i$ is used. This amount is bounded below by $0$. Meanwhile, it is bounded above by the first $k$ satisfying $ r - w_i dot k >= 0 $
  or $k <= r/w_i$. Since $k$ is an integer, we write $k <= floor(r/w_i)$.

  Note that any valid collection uses $k >= 0$, so any valid type of collection is captured in this $max$. Any $k$  satisfying $k>floor(r/w_i)$ gives $r - w_i dot k < 0$), so $M(i+1, r-w_i dot k) = -oo$.Hence, restricting $k <= floor(r/w_i)$ loses nothing.

  We iterate through all of these possibilities. If there are $k$ copies of this item, then it adds a total value of $v_i dot k$ to our total value. Meanwhile, there is $w_i dot k$ less capacity in the back ($r -w_i dot k$).
  
  Hence, for each $k$, the total value possible is $v_i dot k + M(i+1, r-w_i dot k)$. We take the maximum value over all $0<=k<=floor(r/w_i)$, getting us

  $ M(i,r) = max_(k \ 0<=k<= floor(r/w_i)) (v_i dot k + M(i+1, r-w_i dot k)) $
  
  as desired.

]

4.3
#claim[The recurrence 

$M(i,r) = max(M(i+1,r), v_i + M(i, r-w_i))$
is correct.]

#proof[ 
  For subproblem $(i,r)$, we can either not add a copy of item $i$ and move on to the subproblem for ${i+1, dots, n-1}$, represented by
  
  $ M(i+1, r) $

  or add a copy of item $i$, adding $v_i$ to the total value and decrementing the knapsack's capacity by $w_i$. In other words,
  
  $ v_i + M(i, r-w_i) $
   We take the maximum of these choices. 

   $ M(i,r) = max(M(i+1,r), v_i + M(i, r-w_i)) $

Every valid collection either contains zero copies of item $i$ — captured by
$M(i+1,r)$ — or at least one copy, in which case removing one copy gives a valid
collection for subproblem $(i, r-w_i)$, captured by $v_i + M(i,r-w_i)$. These two
cases are exhaustive and disjoint, so the maximum of the two recovers the optimum.

  This recurrence exhausts all types of collections involving item $i$. This is because the recurrence allows for the item $i$ to be added repeatedly $(i, r-w_i)$ until $r-w_i < 0$. It terminates because the $(i+1, r)$ and $(i, r-w_i)$ are closer to the base case than $(i,r)$ (because $w_i > 0$).
]

#proof("CLAUDE CLAUDE CLAUDE")[
  
  #proof[
  We show both directions of the inequality.

  *($>=$) The RHS is achievable, so $M(i,r) >= $ RHS.*

  $M(i+1,r)$ is, by definition, the value of some valid collection using only types
  $i+1, dots, n-1$ with weight $<= r$. That same collection is also valid for $(i,r)$
  (since types $i+1,dots,n-1 subset.eq {i,dots,n-1}$), so $M(i,r) >= M(i+1,r)$.

  Take an optimal collection for $(i, r-w_i)$, achieving value $M(i,r-w_i)$, using
  only types $i,dots,n-1$ with weight $<= r-w_i$. Adding one copy of item $i$ gives
  a new weight $<= r$ and new value $v_i + M(i,r-w_i)$, still using only types
  $i,dots,n-1$. So this is a valid collection for $(i,r)$, giving
  $M(i,r) >= v_i + M(i,r-w_i)$.

  Combining: $M(i,r) >= max(M(i+1,r), v_i+M(i,r-w_i))$.

  *($<=$) No valid collection for $(i,r)$ beats the RHS.*

  Let $C$ be any optimal collection for $(i,r)$, with value $M(i,r)$.

  - *Case 1:* $C$ has zero copies of item $i$. Then $C$ only uses types
    $i+1,dots,n-1$, so $C$ is also a valid collection for $(i+1,r)$, meaning its
    value is $<= M(i+1,r)$ (since $M(i+1,r)$ is the max over such collections).
  - *Case 2:* $C$ has at least one copy of item $i$. Removing one copy decreases
    the weight by $w_i$ (now $<= r-w_i$) and the value by $v_i$, while still only
    using types $i,dots,n-1$ — so it is valid for $(i,r-w_i)$, meaning its value
    is $<= M(i,r-w_i)$. Hence $C$'s original value is $<= v_i + M(i,r-w_i)$.

  Either way, $M(i,r) <= max(M(i+1,r), v_i+M(i,r-w_i))$.

  *Combining both directions:*
  $ M(i,r) = max(M(i+1,r), v_i+M(i,r-w_i)). $
]

]

#pagebreak()
5.1 $O(r c)$


#proof[


For $0 <= i < r, 0 <= j < c$, Let dp(i,j) be number of ways to go from (i,j) to (n-1,n-1).

Then we can represent, 

dp(i,j) := grid[i][j] + min(dp(i+1, j+2), dp(i+2, j+1))

Our base cases are:
- out of bounds: +oo 
- (r-1, c-1): v_i


Meanwhile, the count can also be solved 
recursively:

```
count(i,j)

if dp(i+1, j+2) < dp(i+2, j+1): cnt(i+1, j+2)
if dp(i+1, j+2) > dp(i+2, j+1): cnt(i+2, j+1)
else
  cnt(i+1, j+2) + cnt(i+2, j+1)
```

The pseudocode for the bottom-up solution for this problem can be seen below:

```
def solve(grid):
  dp = [ (r+2) x (c+2) list all initialized to +oo]
  cnt = [ (r+2) x (c+2) list all initialized to +oo]

  dp[r-1][c-1] = grid[r-1][c-1]
  cnt[r-1][c-1] = 1

  for i from r-1 down to 0:
      for j from c-1 down to 0:
          if dp[i+1][j+2] < dp[i+2][j+1]:
            dp[i][j] = grid[i][j] + dp[i+1][j+2]
            cnt[i][j] = cnt[i+1][j+2]

          if dp[i+1][j+2] > dp[i+2][j+1]:    
            dp[i][j] = grid[i][j] + dp[i+2][j+1]
            cnt[i][j] = cnt[i+2][j+1]

          if dp[i+1][j+2] == dp[i+2][j+1]:
            dp[i][j] = grid[i][j] + dp[i+2][j+1]
            cnt[i][j] = cnt[i+2][j+1] + cnt[i+1][j+2]

  return dp[0][0]
```

The operations inside the loops run in $Theta(1)$ time. Since the inner and outer loop runs $c$ and $r$ times respectively, the dp runs in $r dot c dot Theta(1) = Theta(r c)$ time.
]

6.1 

7. 

#proof[
```

Let dp[i][m] = if the prefix [0:i] satisfies the first m Blocks of B (includes position i)

then:
  dp[i][m] =
    (dp[i-1][m] AND s[i] != '#') 
      OR
    ( 
      i-B[m] >= 0 AND
      m-1 >= 0 AND
      dp[i-B[m]][m-1] = true AND 
      noDotsInRange(i-B[m]+1, i-1)
      (i == n-1 OR
      s[i+1] != '#')
    )
```

We can convert `noDotsInRange()` into $Theta(1)$ using prefix sums.


We iterate over increasing $i$ and $m$. Since $0<=m<=n$ and $0<=i<=n$. We have $Theta(n) dot Theta(n) = Theta(n^2)$ calls.


]