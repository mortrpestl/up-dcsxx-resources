#let title_ = "CS 31 - Problem Set 5"

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
#let st2(n, k) = $vec(#n, #k, delim: "{")$
#let st1(n, k) = $vec(#n, #k, delim: "[")$
#let kmul(n, k) = $(vec(#n, #k, delim: "("))$


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

1. _Prove or Disprove_:  Every graph has an even number of vertices with odd degree.

#proof[
Suppose, for contradiction, that there exists a graph with an odd number of odd-degree vertices.

Then the sum of the degrees of the odd-degree vertices is the sum of an odd number of odd integers, and is therefore odd. On the other hand, the sum of the degrees of the even-degree vertices is the sum of even integers, and is therefore even.

Hence, the sum of the degrees among odd- and even-numbered vertices, an odd and an even number, is odd. But by the handshaking lemma, 

$ sum deg(V) = 2|E| $

this sum should be even. Therefore, we have reached a contradiction.

Hence, every graph has an even  number of vertices with odd degree.

$qed$
]

#pagebreak()

Let $G$ be a graph, and let $x$ and $y$ be two nodes of $G$.

2. _Prove or Disprove._ There is a walk from $x$ to $y$ iff there is a path from $x$ to $y$.

#claim[This statement is true.]
#proof[

  $(==>)$

  Let $u$ be a walk with $n$ edges from $x$ to $y$. Then we can represent $u$ as a sequence of vertices
  
  $ (v_0, v_1, dots, v_n) $


  We have two cases.

  - _The walk $u$ has no repeated vertices._ 
  Then by definition, our walk is a path.

  - _The walk $u$ has at least one repeated vertex._ 

  Then there exists $0<=i<j<=n$ where $v_i = v_j$. We modify the _walk_ (be careful, use walk instead of path for now!)
  
  $ (v_0, v_1, dots, v_i, v_(i+1), dots, v_(j-1), v_j, dots, v_(n-1), v_n) $ 
  
  by removing some intermediate nodes and $v_j$, resulting in 

  $ (v_0, v_1, dots, v_i, v_(j+1), dots, v_(n-1), v_n) $ 

  This is still a walk from $x$ to $y$ (because $v_i = v_j$), but it has fewer vertices.

  We perform this operation described above repeatedly until there are no more repeated vertices. Note that this will halt because the number of vertices in the walk is always decreasing, and there are only a finite number of such. 

  Hence, the resulting walk $u'$ has no repeating vertices. By definition, $u'$ is a path. We have shown that a path exists between $x$ and $y$.

  $(<==)$

  The existence of a path from $x$ to $y$ implies, by definition, that there exists a walk from $x$ to $y$.

  $qed$
]

#pagebreak()

3. _Prove or Disprove._ In a connected graph with at least two nodes, every node has positive degree.

#proof[
  We prove the contrapositive. That is, we want to prove that if some node has zero degree, then either the graph is disconnected or the graph has less than two nodes.

  We have two cases:

  - _There is one node in the graph._ 
  
  Then the second conclusion is satisfied.

  - _There is at least two nodes in the graph_. 
  
Suppose, for contradiction, that the graph is connected. Then there must be an $cancel("edge")$ path from every vertex to every other vertex. Particularly, if $v$ is the vertex with zero degree, there must be a path from it to some other vertex $u$. However, since every path from $v$ to $u$ must begin with an edge incident to $v$, this implies $v$ has nonzero degree, a contradiction.

  We have proven either case. $qed$
]

- note to self
  - use definitions well 
  - dont jump to conclusions. pay attention particularly to how the vertex, path shi was proven here
  - *sometimes, the direct proof is simpler.* run through both solutions in your head

#proof()[

Let $G$ be a graph with at least two nodes. Let $u$ be an arbitrary node of $G$.

Since $G$ has at least least two nodes, there must be a node $v != u$. Since $G$ is connected, there must be a path between $u$ and $v$, which implies there is a starting edge incident to $u$. This implies 

$ deg(u)>=1 $

or in other words, $u$ has nonzero degree. Since $u$ was chosen arbitarily, all nodes in $G$ have nonzero degree.
$qed$
]

#pagebreak()

4. Here we investigate graphs where the degree of each node is at most $2$.

4.1 Prove that a graph with $ n >= 1 $ nodes such that each node has degree $2$ has $n$ edges.

#proof[
  Let $G$ be a graph of $n>=1$ nodes. If every node in the graph has degree $2$, then 
  
  $ sum_(v in V(G)) deg(v) = n dot 2 = 2n $

  By Handshake Lemma:

  $
  2|E(G)| 
  &= sum_(v in V(G)) deg(v) \
  &= 2n  \
  $

  Hence:

  $ 
  2|E(G)| &= 2n \
  |E(G)| &= n
  $

  Then the number of edges in $G$ is $n$.

  Since $G$ was arbitrary, every graph with $n>=1$ nodes where each node has degree $2$ has $n$ edges.
]

4.2 Prove that a connected graph with $n>=1$ nodes such that each node has degree at most $2$ has eithet $n-1$ or $n$ edges.

#proof[
  Let $G$ be a connected graph with $n>=1$ nodes. Then we know by

    $ 
    2 |E(G)| =2 sum_(v in V(G)) deg(v) <= 2n \
    $

    that the number of edges is bounded above by $n$ (or $|E(G)| <= n$).

    On the other hand, since $G$ is connected, $|E(G)| >= n-1$.

    Combining the inequalities, we get

    $ n-1 <= |E(G)| <= n, $

    implying $G$ has either $n-1$ or $n$ edges.

    $qed$.
]

#pagebreak()

4.3 Let $n in NN$ with $n>= 2$. Prove that a graph with $n$ nodes is a path graph iff it is connected, has exactly two nodes has degree 1, and the remaining nodes have degree 2.

#proof[

  $(==>)$

  Let $G$ be a path graph.

  By definition, a $G$ is a sequence of vertices

  $ {v_1, dots , v_(n)} $

  where the edges are between consecutive vertices.
  
  The endpoints $v_1$ and $v_(n)$ only have one edge incident to them hence $deg(v_1)=deg(v_n)=1$. Hence, $2$ nodes in $G$ have degree $1$.
  
  The intermediate vertices $v_i$ for $1<i<n$ have 2 neighbors $v_(i-1)$ and $v_(i+1)$, hence $deg(v_i) = 2$. Hence, the other nodes in $G$ have degree $2$.
 
  For every node $v_a, v_b$ where $a<b$, there is a path ${v_a,v_(a+1), dots, v_(b-1), v_b}$ by taking a subpath from the main path. Hence, $G$ is connected.


  $(<==)$

  *Let $G$ be a connected graph with exactly two vertices of degree $1$, and all remaining vertices of degree $2$.*


  Let $v_1$ be one of the two nodes with degree 1, and $v_n$ be the other. We start from $v_1$ and traverse to its neighbor. 
  
  For every intermediate vertex $v_i$ in the traversal, denote the previous vertex by $v_(i-1)$. For every $v_i!=v_n$, $deg(v_i)=2$. Since we arrived from $v_(i-1)$, there is exactly one remaining neighbor, *which we denote by $v_(i+1)$. Thus, the traversal continues uniquely* until $v_i = v_n$, where the traversal terminates because $deg(v_n)=1$.

  Note that the traversal cannot contain a cycle. Otherwise, every vertex in the cycle would have degree at least $2$. Since every vertex in $G$ has degree at most $2$, every vertex in the cycle would have degree exactly $2$. Hence no edge could leave the cycle, making it a separate connected component, contradicting that $G$ is connected.

  Since $G$ is connected, every vertex is reachable from $v_1$. Because the traversal has a *unique continuation* at each intermediate vertex and cannot contain a cycle, it visits every vertex exactly once. Thus it produces the sequence

  $
  {v_1, dots, v_n}
  $


  where consecutive vertices are adjacent. Hence, $G$ is a path graph.
]

#pagebreak()

4.4 Let $n in NN$ with $n>= 3$. Prove that a graph with $n$ nodes is a cycle graph iff it is connected and each node has degree $2$.

#proof[

  $(==>)$

  Let $G$ by a cycle graph of length $n$. 

  Let $v_1$ be an arbitrary vertex in the graph. Then by definition of $G$, there exists a cycle $c$ we can define by the circular array

  $ c:={v_1, v_2, ..., v_(n-1), v_1} $

  where $2$ consecutive vertices are adjacent.

  By definition of a cycle, $G$ is connected. 
  
  Moreover, since each vertex in $c$ has two neighbors, each vertex has degree $2$.

  $(<==)$
  
  Let $G$ be a connected graph with every node having degree 2.

  Let $v_1$ be an arbitrary vertex in $G$. We start a walk from $v_1$ to one of its neighbors.

  For every intermediate vertex $v_i$ in the traversal, $deg(v_i)=2$. Since we arrived from some vertex, say $v_(i-1)$, there exists only one unvisited neighbor to traverse to, which we will denote as $v_(i+1)$. 
  
  Since $G$ has a finite number of vertices, the walk must eventually repeat a vertex. Suppose the first repeated vertex is $v_i$. Then the subpath between the two occurrences of $v_i$ forms a cycle. Note that in this cycle, every vertex must have degree at least $2$. *Since every vertex in $G$ has degree $2$, every vertex has exhausted all its edges to the cycle.* Hence, no edge can leave this component. Since $G$ is connected, the cycle must contain all elements in $G$.

  Since the cycle contains all vertices of $G$, it can be written as

  $ w := {v_1, v_2, dots, v_(n-1), v_1}. $

  Therefore, $G$ is a cycle graph.
]

(Old idea) Note that this traversal terminates, that is the traversal continues uniquely until $v_i = v_1$. Note that $v_1$ is the vertex that must repeat because otherwise, the repeating node would connect to some $v_i$ with degree 2, creating a node with degree 3, a contradiction. Likewise, the vertex connected to $v_i$, which we denote as $v_(n-1)$ must only have one neighbor prior to the connection to satisfy $deg(v_i)=1+1=2$.

- "deep implication" trick
- *any cycle you create must absorb the entire graph.*

#pagebreak()

4.5 For $n in NN^+$ with $n>=3$, find the number of cycle graphs with node set ${0,1,dots,n-1}$.

#claim[
  For $n in NN^+$ with $n>=3$, find the number of cycle graphs with node set ${0,1,dots,n-1}$ is
  $ (n-1)! / 2 $

]
#proof("Claude")[

  Let $V = {0, 1, dots, n-1}$ be the node set.

  A cycle graph is determined by the *circular ordering of its vertices*. Fix
  the vertex $0$ as the starting vertex. The remaining $n-1$ vertices can be
  arranged in any order, giving

  $ (n-1)! $

  possible orderings.

  However, each cycle graph is counted twice. This is because traversing the
  same cycle in the opposite direction gives the same graph. For example,

  $ (0, v_1, v_2, dots, v_(n-1), 0) $

  and

  $ (0, v_(n-1), v_(n-2), dots, v_1, 0) $

  represent the same cycle graph.

  Since every cycle has exactly two possible directions, we divide by $2$.
  Therefore, the number of distinct cycle graphs is

  $ (n-1)! / 2 . $

  Hence, the number of cycle graphs with node set ${0, 1, dots, n-1}$ is

  $ (n-1)! / 2 $
  

]

- circular ordering

#pagebreak()

5. Let $G$ be a connected graph. Let $cal(e)$ be an edge in $G$. Let $G_(-cal(e))$ be the graph obtained by removing $cal(e)$ from $G$. 

- _Prove or Disprove_: If $G_(-cal(e))$ is connected, then $G$ has a cycle

#proof("Claude")[
  We prove the contrapositive: if $G$ has no cycle, then $G_(-e)$ is
  disconnected, for every edge $e$ in $G$.

  Suppose $G$ has no cycle. Since $G$ is connected (implicitly assumed, as
  $G_(-e)$ being connected only makes sense as a meaningful claim about a
  graph that starts out connected) and acyclic, $G$ is a tree.

  Let $e = (u,v)$ be any edge of $G$. In a tree, $e$ is the *unique* path
  between $u$ and $v$: if there were another path from $u$ to $v$ not using
  $e$, then together with $e$ it would form a cycle, contradicting the
  acyclicity of $G$.

  Therefore, removing $e$ destroys the only path between $u$ and $v$, so $u$
  and $v$ lie in different connected components of $G_(-e)$. Hence $G_(-e)$
  is disconnected.
]

- _Prove or Disprove_: If $G_(-cal(e))$ is disconnected, then $G$ does not have a cycle

#claim[
  The statement above is false.
]
#proof[

False. Let $ G := #image("image.png", width: 20%) $

Let $cal(e) ={2,3}$. Then $G_(-e)$ is disconnected, but $G$ has a cycle. 

$qed$


]

#pagebreak()

Prove that for every $K_n$, there exists a subgraph $K_(n-1)$. Using this fact, prove $K_i subset.eq K_n$ for all $0 <=i<=n$

#proof[

Let $G$ be $K_n$. Let some $G'$ be the induced subgraph of $G$ such that $V(G') = V(G) \\{v}$.

Deleting $v$ removes $v$ and all edges adjacent to $v$, but the edges connecting the rest of the $n-1$ vertices are still intact. By definition of graph completeness, the subgraph is $K_(n-1)$.

Hence, $K_(n-1) subset.eq K_n$.

]

#proof[
  We will now induct downward, by claiming $K_i subset.eq K_n$ for some $i$ such that $0<=i<=n$.

_Base case:_ $i=n$. Then $K_n subset.eq K_n$ by definition of subset.

_Inductive step:_

Suppose $K_i subset.eq K_n$ for some fixed $i$ with $1<=i<=n$. We want to show $K_(i-1) subset.eq K_n$. By the fact above (applied to $K_i$), $K_i$ has an induced subgraph isomorphic to $K_(i-1)$; that is, $K_(i-1) subset.eq K_i$. By transitivity, combined with $K_i subset.eq K_n$, we get $K_(i-1) subset.eq K_n$.

This proves our inductive case.
$qed$
]

Claim: For every subset of vertices $S$ in $K_n$, the induced subgraph of $K_n$ on $S$, $K_n [S]$ is complete.

#proof[

  Define $S subset.eq V(K_n)$  be an arbitrary subset of vertices, and $H = K_n [S]$ be the the *induced subgraph of $K_n$ on $S$*.

  Let $x,y in H$. Since $V(H)=S subset.eq K_n$, we have $x, y in K_n$. Since all pairs of vertices in a complete graph are adjacent, $x$ and $y$ are adjacent.

  By definition of induced subgraph, an edge $(x,y)$ is *included* in $H$ iff it is an edge of $K_n$. Since $(x,y) in K_n$, we can conclude $(x,y)$ is present in $H$.

  Since $u$ and $v$ were an arbitrary pair of vertices in $H$, it follows that all pairs of vertices in $H$ are adjacent. Hence, $H$ is complete by definition.

  Since $S$ was an arbitrary subset of vertices in $V(K_n)$, every induced subgraph of $K_n$ is complete.

  - let u,v in H 
  - show 

]


#pagebreak()

_Prove or Disprove._ A nonempty graph is complete iff it is connected and for each of its nodes, every pair of its neighbors are adjacent.
#proof[ 

$(==>)$

Let $G$ be a nonempty, complete graph. 

Then by definition, $G$ is connected.

Also, for every vertex $v$, we can pick any two of its neighbors. Since the graph is complete, these chosen vertices would also be adjacent. 

This proves the forward direction.

$(<==)$

We will prove this by contrapositive. We want to prove if a graph is not complete, it is either not connected or there exists a node who has a pair of neighbors that are not adjacent.

Let $G$ be a graph that is not complete. 

If $G$ is disconnected, we are done. So assume $G$ is connected.

 Since $G$ is not complete, there must exist vertices $x_0$ and $x_n$ that are not adjacent. Since $G$ is connected, there must be a shortest path between them. Define this shortest path 

 $ p := (x_0, x_1, dots, x_n) $

 Note that $p$ must have length of at least $2$; otherwise, $x_0$ and $x_n$ would be adjacent. Hence, $x_2$ must exist in the path.
 
 We claim $x_0$ and $x_2$ are not adjacent. Otherwise, there would be a shorter path $(x_0, x_2, dots, x_n)$ contradicting the minimality of $p$. Since $x_1$ is adjacent of both $x_0$ and $x_2$, it is a neighbor of both vertices. Hence, we have found a node $x_1$ that has a pair of neighbors that are not adjacent.


This proves the reverse direction. 

$qed$
]

- reasoning with shortest paths
- use parenthesis for paths

#pagebreak()

Prove that for any finite set $S$, the number of graphs with node set $S$ is $g_(|S|)$.
#proof[ 
  
  Let $|S|=n$. Then there exists such a bijection between $S$ and $[n]$. Define such a  bijection $phi: S -> {0,1,2,dots,n-1}$. 

  Let $cal(G)(S')$ be the set of all graphs with $V(S') = S'$.

  We define $Phi: cal(G)(S) -> cal(G)([n])$ such that

  $ Phi(G) = ( {phi(x) | x in V(G) }, { (phi(x), phi(y)) | (x,y) in E(G) } ) $

  and prove it is bijective.
  
  Note that $Phi$ is injective. Because $phi$ is a bijection (particularly, an injection), it sends distinct elements to distinct elements, and hence sets to distinct image sets. Thus, $Phi(G)=Phi(G')$ forces $V(G)=V(G')$ and $E(G)=E(G')$, so $G=G'$.

  Note that $Phi$ is also surjective. Let $H = (V(H), E(H))$ be a arbitrary graph in the codomain. Since $phi$ is a bijection, define $G$ by  

  $ 
  V(G) &= {phi^(-1) (x) | x in V(H)} \
  E(G) &= {(phi^(-1)(x), phi^(-1)(y)) | (x,y) in E(H)} $

  Then

  $ 
  Phi(G) &= ( {phi(phi^(-1) (x)) | x in V(H)},{(phi(phi^(-1)(x)), phi(phi^(-1)(y))) | (x,y) in E(H)}) \
  &= ( {x | x in V(H) }, { (x, y) | (x,y) in E(H) } ) \
  &= ( V(H), E(H) ) \
  &= H
  $

  Then we have found a $G$ that maps to $H$ under $Phi$. Since $H$ was arbitrary, $Phi$ is surjective.

  Because $Phi$ is injective and surjective, $Phi$ is bijective. Hence, $|cal(G)(S)|= |cal(G)([n])|$. Since $|cal(G)(S)| = g_(|S|)$ and $|cal(G)([n])|=g_n$ by definition, we can conclude $g_(|S|) = g_n$.

  $qed$
]

- bad writing:   Note that $Phi$ is injective because distinct sets have induced distinct sets under an bijection $phi$ (hence, also an injection)
- thus, so pair

- injective. "it sends distinct elements to distinct elements, and hence sets to distinct image sets."
- surjective:
  - let element be smth we want to achieve. using the ivnerse applied to each because phi is a BIJECTION (which implies involution)
  - Let element in codomain. Define G by (applied inverses to each element).. Then Phi()
  - Then Phi(G) = ... = H
  - then we have found a G that maps to H