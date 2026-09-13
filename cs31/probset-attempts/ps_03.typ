#let title_ = "CS 31 - Combinatorial Proofs"

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

= Question 1
#question[
  Prove 
  $ st2(n,1) = 1 $
]

#proof[
  We give a combinatorial proof. Let $S$ be the set of all ways to distribute $n$ elements to $1$ nonempty box. 

  First, we note by the definition of Stirling numbers of the second kind, 

  $ |S| = st2(n,1) $

  From another perspective, there is only one way to distribute $n$ elements into $1$ box. This is by placing all of the elements into that box. 

  Hence, $ |S| = 1 $

  Equating these expressions for $|S|$ proves the theorem.
]

#pagebreak()
#question[
  Prove 
  $ st2(n,2) = 2^(n-1) - 1 $
]

#proof[
  We give a combinatorial proof. Let $S$ be the set of all ways to distribute $n$ elements to $2$ nonempty boxes. 

  First, we note by the definition of Stirling numbers of the second kind, 

  $ |S| = st2(n,2) $

  From another perspective, lock the first element to some box. Then the rest of the $n-1$ elements have two choices for the box they belong to. This gives $2^(n-1)$ possibilities. 

  However, there is a case where all elements are in the same box. We subtract 1 to remove this case.

  Hence, $ |S| = 2^(n-1) - 1 $

  Equating these expressions for $|S|$ proves the theorem. 
]

#pagebreak()
#question[
  Prove 
  $ st2(n,3) = (3^(n-1)-1)/2 - (2^(n-1)-1) $
]


#proof[ 
   We give a combinatorial proof. Let $S$ be the set of all ways to distribute $n$ elements to $3$ nonempty boxes. 

  First, we note by the definition of Stirling numbers of the second kind, 

  $ |S| = st2(n,3) $

  From another perspective, we first calculate all ways to distribute $n$ elements to $3$ boxes (not necessarily all nonempty). For the $n$ elements, it can belong to one of the $3$ elements. This gives $3^(n)$ possibilities. 

  We do not want cases wherein only 2 boxes are nonempty. There are $binom(3, 2)=3$ ways to choose 2 boxes and for these boxes, the elements can choose $2^n$. By rule of product, this gives a total of $3 dot 2^n$ ways to distribute $n$ elements to at most 2 nonempty boxes.

  By exclusion-inclusion, we add back the cases where only 1 box is nonempty. There are $binom(3,1)=3$ ways to choose a box and $1^n = 1$ way to distribute. Hence, there are $3 dot 1=3$ ways to distribute to $n$ boxes.

  Thus, the ways to distribute $n$ elements to $3$ nonempty, distinguishable boxes are:

  $ 3^(n) - 3 dot 2^n + 3 $

  Finally, since the boxes are indistinguishable, we remove the order by dividing the entire sum above by $3! = 6$.

  Hence,  $ |S| = (3^(n) - 3 dot 2^n + 3 )/ 3! &= 3^n / 2 - 2^(n-1) +1/2 \ 
  &= 3^n / 2 -2^(n-1 )-1/2+1 \
  &=   (3^n - 1)/2-(2^(n-1)-1)
  $

  Equating these expressions for $|S|$ proves the theorem. 

  $qed$

]

Note to self: *trust the process.*

#question[
  Prove that:

  $ n^((k)) = kmul(n, k) k! $
]

#proof[ 
  We give a combinatorial proof. Let $S$ be the number of distinct sequences after $k$ new balls are inserted in a sequence of $n+1$ balls.

  We can do this as follows. There are $n$ spaces in between the balls so far. We can choose to place a ball in any of these spaces. 
  
  After this, there are now $n+1$ spaces. For the $i$-th ball added, there are $n+i-1$ spaces. This goes up to $k$ balls.

  Since each event is a continuation of the previous, we can use rule of product to say the number of ways to form a sequence of $n+k$ balls using thist technique is:

  $ n(n+1)(n+2)(n+3) dots (n+k-1) $

  which is precisely the definition of $n^((k))$.

  Hence:

  $ |S| = n^((k)) $

  From another perspective, we can treat the $n$ spaces in between these elements. We will want to pick $k$ positions, then distribute our $k$ balls over these positions.
  
  Our stars will be the positions for which the balls will be placed. Since we are placing indistinguishable elements into distinguishable boxes. We can use stars and bars to compute:

  $ kmul(n, k) $

  Now, we assign balls from the leftmost to rightmost position. There are $k$ choices for position $1$, $k-1$ choices for position $2$, until we only have 1 choice for position $k$. By rule of product, we have:

  $ k dot (k-1)dots dot 1 = k! $

  Now, by another rule of product, the number of ways to choose positions and place the balls are:

  $ |S| = kmul(n, k) k! $

  Equating these expressions for $|S|$ proves the theorem. 

]

#question[
  Prove that for $n,k in NN$, the number of surjective functions from $f : [n] ->[k]$ is

  $ st2(n,k) k! $
]

#proof[
  We will prove this using combinatorial proof.

  Let $|S|$ = number of surjective functions from $[n]$ to $[k]$.

  Note that by definition, each element in $im f$ has to be mapped onto. Because there are $k$ elements in the images, what we can do is assign each element in $[n]$ to some $k$ such that $[k]$ has at least one element from the domain mapping onto it. These two steps create a mapping for each element in $[n]$ tha makes $f$ satisfy the definition of surjectivity.

  We can do this by first grouping up the elements in $[n]$ into $k$ nonempty indistinguishable subsets. This is done in 
  
  $ st2(n,k) $
  
  Then, we for each subset, we can choose some element in $k$ to make all elements in the subset to map to $k$. By rule of product, there are a total of $k dot (k-1) dot dots dot 1 = k!$ ways to do this.

  Hence, the number of surjective functions by rule of product is

  $ |S| = st2(n,k) k! $

  Equating these expressions for $|S|$ proves the theorem.

  $qed$
]