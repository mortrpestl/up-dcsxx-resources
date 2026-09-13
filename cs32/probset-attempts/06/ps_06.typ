#let title_ = "CS 32 - Problem Set 6"

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

= Question 1

You are given an $r times c$ grid. Each cell of the grid is either empty or contains an obstacle.

It is possible to move from an empty cell to an adjacent empty cell. However, it is not allowed to move to a cell containing an obstacle, or exit the grid.

How many "rooms" are there in the grid? 

A room is a _maximal_ set of cells that you can go from any cell to any other cell using only the movement rules above.

You may assume that single-source DFS is correct, i.e.., DFS from a cell $(i,j)$ correctly visits precisely the cells reachable from $(i,j)$.

#pagebreak()
#problem[
  Find an $O(r c)$ algorithm that solves this problem by calling DFS multiple times.
]

```
func number_of_rooms(grid):
  rows, cols := number of rows and columns in the grid 
  done = [rows x cols array, initially false]
  ans = 0

  func neighbors(loc):
    r, c = loc
    for (dr, dc) in [(1,0),(0,1),(-1,0),(0,-1)]:
      nr, nc = r+dr, c+dc

      if 0 < nr <= rows and 
          0 < nc <= cols and 
          grid[nr][nc] != '#' and
          and !done[nr][nc]:
        yield (r+nr, c+nc)

  func dfs(loc):
    for (_i, _j) in neighbors(loc):
      done[_i][_j] = true
      dfs(_i, _j)

  for i from 0 to n-1:
    for j from 0 to n-1:
      if done[i][j] or grid[i][j] = '#': continue 
      else:
        done[i][j] = true
        k := k + 1
        dfs(i,j)

  return k
```
#solution("Variant 2")[ 
  Let the following algorithm above be $sans("number_of_rooms")$. 
  

  $sans("number_of_rooms")$ initializes a $sans("in_room")$ array to keep track of which cells already belong in a room. Then, for each cell $(i,j)$ in the grid:

  - If this cell belongs in the room or is blocked, it is skipped.

  - If the cell does not belong to a room, then $sans("dfs")(i,j)$ is called to visit all of the rooms reachable from this cell to create a new room. Because $"dfs"(i,j)$ visits all cells reachable from $(i,j)$, so all cells marked done from this call belongs in the same room. To account for the new room, $sans("ans")$ is incremented.


 Let $r$ and $c$ be the number of rows and columns in the grid, respectively. Allocating the $sans("in_room")$ array of $r times c$ cells already takes exactly $r dot c$ operations in the array, implying $sans("number_of_rooms") = Theta(r c)$. 

 Also, because $sans("done")$ ensures a cell is not processed by $sans("dfs")$ more than once, the total work across all $sans("dfs")$ calls is at most $r c$ (some cells can be blocked with `#`). This implies $sans("number_of_rooms")= bigO(r c).$ The other operations in $sans("number_of_rooms")$ run in $Theta(1)$ time.
  
  Hence, $sans("number_of_rooms") = c dot Theta(1) + Theta(r c) + bigO(r c) = bigO(r c)$ (although $Theta(r c) + bigO(r c) = Theta(r c)$ also, which is a stronger result).

  $qed$
]


#solution("Old Variant 1")[ 
  Let the following algorithm above be $sans("number_of_rooms")$. 

  The algorithm above initializes a $sans("in_room")$ array to keep track of which cells have been visited. Then, for each cell $(i,j)$ in the grid, it checks if it has been visited or not.

  - If it has not been visited, then the cell belongs to a new room. $k$ is incremented and $sans("dfs")(i,j)$ is called to visit all of the rooms reachable from this cell, also marking them in_room so they will not be revisited.

  - If a cell has been visited, then the cell already belongs to a room that has been accounted for and is therefore skipped.

 Let $r$ and $c$ be the number of rows and columns in the grid, respectively. Allocating the $sans("in_room")$ array of $r times c$ cells already takes exactly $r dot c$ operations in the array, implying $sans("number_of_operations") = Theta(r c)$. 
 
 Also, because $sans("in_room")$ ensures a cell is not processed by $sans("dfs")$ more than once, the total work across all $sans("dfs")$ calls is at most $r c$ (some cells can be blocked with `#`). This implies $sans("number_of_operations")= bigO(r c).$ The other operations in $sans("number_of_operations")$ run in $Theta(1)$ time.
  
  Hence, $sans("number_of_operations") = Theta(r c) + bigO(r c) = Theta(r c)$.

  $qed$
]

#pagebreak()

#problem[ 
  Formally prove your solution is correct.
]

#proof[ 
  Let $r$ and $c$ be the number of rows and columns in the grid, respectively.  Suppose the cells were visited in increasing $i$, then increasing $j$. If $t := i dot c + j$, we use the following invariant applying to $sans("number_of_rooms")$ for $0<=i<r$ and $0<=j< c$:
    
    Right before iteration $t$ of the loop, if there are $k$ rooms that intersect with the first $t$ cells, then $sans("ans")$ contains $k$.

  _Initialization._ 
  
  At $t=0$, no cells have been visited yet. Hence, $sans = 0$.

  _Maintenance._

  Suppose before iteration $t$, the invariant holds. That is, $sans("ans")$ contains $k$ if $k$ rooms that intersect the first $t$ cells. 

  During iteration $t$, some cell $(i,j)$ distinct from the other cells is called in the inner loop. There are three cases:

  - $sans("grid")[i][j] = '\#'$. Then this cell is blocked and cannot be in a room. Hence, $k$ stays the same and $sans("ans")$ stays the same.


  - $sans("in_room")[i][j] = sans("true")$. Because $sans("in_room")[i][j] := "true"$  before iteration $t$, it is not the origin $sans("dfs")$ call that set is to true. So some other cell $(i',j')$ processed at some $t' < t$ found $sans("in_room")[i'][j'] := "false"$, triggering $sans("dfs")(i',j')$ which marked all cells reachable from $(i', j')$ (e.g. $sans("in_room")[i][j] = sans("true")$), including $(i,j)$. Hence, by definition, $(i,j)$ and $(i',j')$ belong in the same room. Thus, by the inductive hypothesis, this room is already one of the rooms counted in the inductive hypothesis. Therefore, this iteration leaves $sans("ans")$ unchanged, hence the invariant is maintained.

  - $sans("in_room")[i][j] = sans("false")$. Then this cell must not intersect with any of the $k$ rooms. Hence, it does not belong in a room. A new room is marked by calling $sans("dfs")(i,j)$, correctly marking all cells reachable from $(i,j)$ as done in the $sans("in_room")$ array (to mark them as belonging already in a room) and incrementing $sans("ans")$ correspondingly to $k+1$ rooms. 
  
  In either case, the invariant holds right after the iteration.


  _Termination._

  After all cells have been visited, the first $r c$ cells (or the whole grid) are covered. Hence, $sans("ans")$ contains the right answer for the number of rooms in the grid.

  $qed$
]

#pagebreak()
= Question 2

You are given an $n times n$, where each cell is either empty or contains an obstacle, and a cell $(i,j)$, $0<=i,j<n$.

Suppose that the following are performed:

- First, DFS is performed once starting from $(i,j)$, computing the $sans("parent")$ information along the way.

- Next, for each reachable cell $(i',j')$, a path from $(i,j)$ to $(i', j')$ is reconstructed as a list of pairs.

- Finally, the list of all these paths is returned.

For which $k in {1,2,3,4,5}$ is the following statement true? (And prove it!)

(can we assume neighbors is edgely-adjacent?)

#claim[ 
  The values that work are
  $ k = {3,4,5} $ 
]
#proof[

  Let our the running time of the algorithm above be $f(n)$:

  DFS takes at most $O(n^2)$ time. Meanwhile, by Claim 1, enumerating the lists themself take $Theta(n^3)$ time. Therefore, the algorithm above runs in:

  $ O(n^2) + Theta(n^3) = Theta(n^3) $ 

  which implies $f(n) =Omega(n^3)$ and $f(n) = O(n^3)$. 

  Hence, $f(n) = O(n^3) =O(n^k)$ for $k =3,4,5$ work.

  Next, we also want to show that $f(n) != O(n^k)$ with $k < 3$. We will prove this using contradiction, assuming $f(n) = O(n^k)$.

  By definition of $Omega(n^3)$, there must exist a $c_1$ and $n_1$ such that for all $n >= n_1$:

  $ c_1 n^3 <= f(n) $

   Suppose $f(n) = O(n^k)$ with $k < 3$ for this algorithm. Then there must exist a $c_2$ and $n_2$ such that for all $n>= n_2$:

  $ f(n) <= c_2 n^k $

  We can chain the inequalities:

  $ c_1 n^3 &<= c_2 n^k \
  n^3 &<= c_2 / c_1 n^k $

  This implies $n^3 = O(n^k)$ (with constants $c_2 / c_1, max(n_1,n_2)$), but $k<3$, a contradiction. Hence, $f(n) != O(n^k)$.

  Hence, the only valid $k$ are thoes $>= 3$ ${3,4,5}$.
  $qed$

]
#pagebreak()
#claim[
  The enumeration of the paths themself run in $Theta(n^3)$ time.
]
#proof[
  Because DFS returns the shortest path to any cell, a cell that is $d$ Manhattan distances away has a path length of $d$.

  Note that there are $c$ cells that has a distance of $c$  (if $c <= floor(n/2)$), and $n-c$ cells otherwise.

  Therefore, the sum of cells within the list of all paths can be expressed as:

  $ sum_(i=0)^(floor(n/2)) i dot i + sum_(i=ceil(n/2))^n i (n-i) $

  The LHS can be bounded by $1/48$:

    $
    sum_(i=0)^(floor(n/2)) i dot i + sum_(i=ceil(n/2))^n i (n-i) &>= sum_(i=0)^(floor(n/2)) i dot i \
    &= (floor(n/2) (floor(n/2)+1)( 2 dot floor(n/2) + 1))/6 \
    &>= n/24 dot n/24 dot n/24 quad (n/24 <= (n/2 -1)/6 <= floor(n/2)/6 "for" n>=4)\
    &= n^3 / 24^3 quad
    $

  The RHS can be bounded by $1/8$:

  $
    sum_(i=0)^(floor(n/2)) i dot i + sum_(i=ceil(n/2))^n i (n-i) &<= sum_(i=0)^(n) i dot i \
    &= (n(n+1)(2n+1))/6 \
    &<= n/2 dot n/2 dot n/2 quad ((2n+1)/6 <= n/2 "for" n>=1)\
    &= n^3 / 8 quad
    $

  Hence, by definition, the enumeration of the paths already run in $Theta(n^3)$ time (with constants $1/48, 1/8$, and $max(1,4)=4$). 

  $qed.$
]

#pagebreak()

= Problem 3

Here, we'd like to show that there are _many_ paths in a grid, by providing an asymptotic lower bound. Prove that there are $omega(b^(n^2))$ paths in an $n times n$ grid from $(0,0)$ to $(n-1,n-1)$ for some $b>1$.

- idea:
  - Fix $(0,0)$ and $(n-1,n-1)$ as starting and ending points, respectively. Then for every cell, it is either contained or not contained in a candidate path. By rule of product, we get $2^(n^2)$ [WRONG!]

- idea 2:
  - Note that it is possible to divide the grid into $2 times 2$ and $2 times 1$ boxes. 
  - Take all the $2 times 2$ boxes. Since. Note that the topleft corner has $2$ choices (left or down). 
  - Note that there are at most $n^2 / 4$ such boxes. Hence, 

  $ 2^(n^2/4) = (2^(1/4 dot n^2) ) $

- idea 3:
  - make a snake like path 


  


#proof[ 

]