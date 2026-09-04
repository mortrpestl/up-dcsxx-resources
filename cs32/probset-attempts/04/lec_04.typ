#let boxed(body, width: 100%, inset: 12pt, fill: none, stroke: 0.5pt) = {
  rect(width: width, inset: inset, fill: fill, stroke: stroke)[
    #align(center)[#body]
  ]
}


#let gb(content) = rect(
  fill: rgb("#f0f0f0"),
  inset: 12pt,
  width: 100%
)[#content]

1. Prove that "$f(n) in cal(O)(g(n))$" satisfies:

#boxed(width: 100%, )[
  If $f(n) in cal(O)(g(n))$ and $g(n) in cal(O)(f(n))$, then $f(n) in cal(Theta)(g(n))$
  ]

#gb()[
  *Proof.*


  Suppose $f(n) in cal(O)(g(n))$ and $g(n) in cal(O)(f(n))$. Then there exist positive real numbers $c_1, c_2, n_1, n_2$ such that for all $n >= n_1$ and $n >= n_2$:

  $ f(n) <= c_1 g(n) $
  $ g(n) <= c_2 f(n) $

  From the second equation:

  $ (1/c_2) g(n) <= f(n) $


  Combining:

  $ (1/c_2) g(n) <= f(n) <= c_1 g(n) $  

  Then $ f(n) = cal(O) (g(n))$ by definition (using constants $1/c_2, c_1,$ and $max(n_1, n_2))$.
$qed$

]

2. Prove that:
#boxed[
   If $f(n) = cal(O)(g(n))$, then $f(n)+g(n) = cal(Theta)(g(n))$.
]

#gb()[
  *Proof*.

  Suppose  $f(n) = cal(O)(g(n))$. 
  
  Then there exists positive real numbers $c, n_0$ such that for all $n >= n_0$, $f(n) <= c g(n)$:

  Note that for all $n >= n_0$:
  $ f(n) &<= c g(n) \ 
  f(n) + g(n) &<= c g(n) + g(n) \ 
  f(n) + g(n) &<= (c+1) g(n) \ 
  $
  Also, since $g(n)> 0$:

  $ 0 <= 1 dot g(n) <= f(n) + g(n) $

  Combining:

  $ 1 dot g(n) <= f(n) + g(n) <= (c+1) g(n) $

  Let $c := c+1$. Then by definition, $f(n)+g(n) = Theta (g(n))$ (with constants $1, c+1, n_0 $). $qed$

]

3. Prove that:

#boxed()[
  For any nonnegative reals $ a < b$, prove that $n^a = o (n^b)$.
]

#gb()[
  *Proof.*

  We use the fact that if: 
  
  $ lim_(n->oo) f(n)/g(n) = 0 => f(n) = o(g(n)) $

  Then: 

  $ lim_(n->oo) f(n)/g(n) = lim_(n->oo) n^a / n^b = lim_(n->oo) 1/n^(b-a) = 0 $
  
  Because $b-a > 0$ from $a < b$. 
  
  Hence $n^a = o(n^b)$
  $qed$

]

4. Prove that:

#boxed()[
  For any $r>=0$ and $b>1$, prove that $n^r = o (b^n)$.
]

#gb()[
  *Proof.*

  Let $k = ceil(r)$. Then $n^r <=n^(ceil(r)) = n^k$.


  We use the fact that if: 
  
  $ lim_(n->oo) f(n)/g(n) = 0 => f(n) = o(g(n)) $

  Then: 

  $ lim_(n->oo) n^k / b^n = lim_(n->oo) k! / (ln^k b dot b^n) = ( k! / (ln^k b ) )lim_(n->oo) 1/b^n= 0

  $
  
  by repeated applications of L'Hopital's rule and because $ b > 1$.
  
  We know that $n^r <= n^k$. From the result above:

  $ 0 <= lim_(n->oo) n^r / b^n <=lim_(n->oo) n^k / b^n=0 $
  
  Hence, by Squeeze Theorem:

  $ lim_(n->oo) = lim_(n->oo) n^r / b^n = 0 $

  And by definition, $n^r = o(b^n)$.
  $qed$

]

Editor's Note:

- Must not frame functions as discoveries.
- "Hence $n^k = o(b^n)$. Also, $n^r = o(n^k).$ By transitivity, $n^r =o(b^n)$." is *not necessarily true*.