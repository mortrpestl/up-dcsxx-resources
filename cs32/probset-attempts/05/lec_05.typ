
#let boxed(body, centered: true, width: 100%, inset: 12pt, fill: none, stroke: 0.5pt) = {
  rect(width: width, inset: inset, fill: fill, stroke: stroke)[
    #if centered [
      #align(center)[#body]
    ] else [
      #body
    ]
  ]
}

#let bigOm = $cal(Omega)$
#let bigTh = $cal(Theta)$
#let bigO = $cal(O)$

#let gb(content) = rect(
  fill: rgb("#f0f0f0"),
  inset: 12pt,
  width: 100%
)[#content]

#set align(horizon)
#align(center)[
  = Template
  *Diogn Lei R. Mortera*
]

#outline()


#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 2 {
    numbering("1.", n.last())
  } else if n.len() == 3 {
    numbering("1.1", n.at(1), n.at(2))
  }
})

#show heading: set text(weight: "regular")

#pagebreak()


== *Exercise 8.* We only showed that $T(n) = bigO (2^n)$. Prove that $T(n) = bigOm(2^n)$ as well, so we can conclude that $T(n) = bigTh(2^n)$.
#gb()[
  *Proof.*

  Recall that we have the recurrence:

  $ T(n) = 2 T(n-1) + f(n) $

  where $f(n) = Theta(n)$. By definition of $Theta$ and removing abuse of notation, there exists some $c$ and $n_0$ such that for all $ n>=n_0$:

  $ 2 T(n-1) + c <= T(n) $

  We will prove this using induction.

  For $n >= n_0$, We will prove this using induction:

  #boxed[
    *Claim 1.* For all $n >= n_0$:

    $ C dot 2^n + c <= T(n)$
  ]

  #boxed(centered: false)[
  *Proof (Claim 1).* 

   Note that for $n < n_0$, each $T(n)$ is bounded by some positive constant. We take $c'$ as the minimum of these constants.

   We can then let $C := max(c', c) - c$.

   _Base case: _ Suppose $ 0 <= n < n_0$. Then:

  $ 
  c' &<= T(n) \
  C + c &<= T(n) \
  C dot 2^n + c &<= T(n)
  $

  _Inductive case: _ Suppose $ n >= n_0$. Then by the inductive hypothesis, $C dot 2^(n-1) + c <= T(n-1)$.

  $ 2T(n-1)+c &<= T(n) \
  2(C dot 2^(n-1) + c)+c &<= T(n) \
  C dot 2^n + c <= C dot 2^(n) + 3c &<= T(n) $

  This proves the inductive case.
  ] 

  $qed$

  From this, we can get 
  $ C dot 2^n <= C dot 2^n +c <= T(n)$

  which by definition, concludes that $T(n) = bigOm(2^n)$ (with constants $C, n_0$).

  And since $T(n) = bigOm(2^n)$ and $T(n) = bigO(2^n)$, by definition, $T(n) = Theta(n)$.

  $qed$.
]

== Exercise 16. Prove that $ 4^n / (2n+1) <= binom(2n, n) <= 4^n$

#gb()[
  *Proof.* 

  Note that $4^n = 2^(2n) = sum_(i=0)^(2n) binom(2n, i) $.

  For the RHS inequality, note that:
  $ binom(2n, n) <= sum_(i=0)^(n-1) binom(2n, i)  + binom(2n, n) + sum_(i=n+1)^n binom(2n,i )= 4^n $

  For the LHS inequality, note that:

  $ 
  4^n / (2n+1) &<= (sum_(i=0)^(2n) binom(2n, i)) / (2n+1) \
  &= (sum_(i=0)^(n-1) binom(2n, i)  + binom(2n, n) + sum_(i=n+1)^n binom(2n,i ))  / (2n+1) 
  $ 
  
  Note that $binom(2n, i) <= binom(2n, n)$ for all $0 <= i <= 2n$. So:

  $ sum_(i=0)^(n-1) binom(2n, i) + sum_(i=n+1)^n binom(2n,i) <= (n + (n-1)) binom(2n,n) = 2n-1 binom(2n,n) $

  Hence: 

  $ 
(sum_(i=0)^(n-1) binom(2n, i)  + binom(2n, n) + sum_(i=n+1)^n binom(2n,i )) / (2n+1) &= ((2n-1)binom(2n,n) + binom(2n,n)) / (2n+1) \
  &<= (2n+1)binom(2n, n) \
  &= binom(2n,n) 
  $

  $qed$.
]

#pagebreak()

== Exercise 17 (modified). Prove that for any $0 < b < a$, $b^n = o(a^n / n)$

#gb()[
  *Proof.* 

  Take $f(n) = b^n$ and $g(n) = a^n / n$.

  Then:

  $
    lim_(n->oo) b^n / (a^n/n) = &lim_(n->oo) n / (a/b)^n \
    =^("LHR") &lim_(n->oo) 1 / (log a/b dot (a/b)^n) \
    = &lim_(n->oo) (b/a)^n / (log (a/b)) \
    = 0
  $

  Because $a > b$.

  Hence, by definition, $b^n = o(a^n/n)$.

  $qed$
]

== Prove that $ 1/ (2n+1) = Theta(1/n)$.

#gb()[
  *Proof.*

  We want to prove this by definition of $bigTh$.

  Let $c_1 := 1/3$, $c_2 := 1$, and $n_0 := 1$. Note that for all $n >= 1$, $2n + 1 <= 3n$ and $n <= 2n+1$. Hence, the inequality below is true.

  $ 1/(3n) <= 1/(2n+1) <= 1/n $

  Thus, by definition, $1/(2n+1) = bigTh(1/n)$ (with constants $1/3$, $1$, and $1$).
  
  $qed$
]