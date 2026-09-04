
#let boxed(body, width: 100%, inset: 12pt, fill: none, stroke: 0.5pt) = {
  rect(width: width, inset: inset, fill: fill, stroke: stroke)[
    #align(center)[#body]

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
  = Problem Set 4
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


== Prove or Disprove: $n^2 = cal(Omega) (3n^2 + 2n+5)$.

#gb[
*Proof.*

This statement is true. 

Let $c:= 1/10$ and $n _0 := 1$. Then:

$ 0 <= 1/10 (3n^2 + 2n + 5) <= 1/10 (3n^2 + 2n^2 + 5n^2) <= 1/10(10 n^2) = n^2 $

then by definition, $n^2 = cal(Omega) (3n^2 + 2n+5)$.

$qed$
]

#pagebreak()

== Prove that $floor(n/7) = Theta(n)$

#gb()[
    *Proof.*


    Let $c_1 := 1, c_2 := 1/2$ and $n_0 := 14$. Then by definition, $floor(n/7) = Theta(n)$.

    Recall the definition of $floor(n/7)$:

    $ floor(n/7) <= n/7 < floor(n/7) + 1 $

    $c_1 := 1$ works from the following inequality: $ floor(n/7) <= 1 dot n/7 $

    $c_2 := 1/2$ works because $n/14 >= 1$ at $n >= 14$. Hence, 
    
    $ 1/2 dot n/7 =n/7 - 1/2 dot n/7<= n/7 - 1 <=floor(n/7) $

    Then, by definition, $floor(n/7) = bigTh(n)$ (with constants $c_1$, $c_2$, and $n_0$).
    
    $qed$
]

#pagebreak()
== Find the smallest nonnegative real $r$ such that $n^(32 + sin (pi n) / 32) = cal(O) (n^r)$ (and prove it)!

#gb()[
  Recall that for all varying $m$, 
  
  $ -1 &<= sin (pi n) / 32 <= 1 \
  31 &<= 32 + sin (pi n) / 32 <= 33
  $

  Hence, setting $m = (pi n) / 32 $ results in 
  
  $ 32 + sin (pi n) / 32 <= 33 $

  $ n^(32 + sin (pi n) / 32) <= n^33 = 1 dot n^33 $

  Since we want our functions to be increasing, we require $n_0 > 1$. One such $n_0$ is $2$.


  By definition of $cal(O)$, $n^(32 + sin (pi n)/32 ) = cal(O)(n^33)$ 
  (with constants $1$, $2$). Any $r >= 33$ can satisfy this by definition of $cal(O)$, but $r = 33$ is the smallest. $qed$
]

#gb()[
  *Claim.* $r = 33$.

  *Proof.* Let $c = 1$ and $n_0 = 2$. For all $n >= n_0$, note that

  $ sin (pi n) / 32 &<= 1 \
  32 + sin (pi n) / 32 &<= 33 $

  Since $n >= 1$, the function $x |-> n^x$ is non-decreasing in $x$, so

  $ n^(32 + sin (pi n) / 32) <= n^33 = 1 dot n^33. $

  Thus, by definition, $n^(32 + sin (pi n) / 32) = cal(O)(n^33)$.

  To see that $r = 33$ is smallest: since $sin (pi n) / 32 = 1$ infinitely often (e.g. whenever $n/32$ hits an odd multiple of $1/2$), the exponent $32 + sin (pi n) / 32$ equals $33$ for infinitely many $n$, so no $r < 33$ can satisfy $n^(32+sin (pi n) / 32) <= c dot n^r$ for all sufficiently large $n$. Hence $r = 33$ is the smallest such value. $qed$
]



== _Prove or Disprove_: $2^(n-2) = Omega(2^n)$

== _Prove or Disprove_: $2^(2n) = Omega(2^n)$

== _Prove or Disprove_: $2^(2^(n+1)) = Omega(2^2^n)$

== Prove that $2^n n^32 = cal(O)(3^n / n^32 )$

#pagebreak()

== Prove that $n log (n log (n log n)) = Theta(n log n)$

#gb()[
  *Proof*:

  We want to prove that there exists some $c_1, c_2,$ and $n_0$ such that for all $n >= n_0$:

  $ c_1 n log n <= n log (n log (n log n )) <= c_2 n log n $

  We use two facts:
  - $log log n <= log n$ for $n >= n_1$.
  - $2 log n <= n$ for $n >= n_2$ (since $log n = o(n)$)

  Let $c_1 = 1$, $c_2 = 2$, and $n_0 = max(n_1,n_2,2)$. For all $n >= n_0$, note that

  $ 0 < 1 dot n log n <= n log (n log (n log n))) <= 2 dot n log n $

  The choice of $c_1$ comes from:

  $ 1 dot n log n = n log n <= n log (n log (n log n))) $

  Because $n <= n log(n log n))$.

  Meanwhile, the choice of $c_2$ comes from:

  $ n log (n log (n log n)) &= n [log (n) + log (log (n log n))] \
  &= n [log (n) + [log (log (n) + log (log n)))]] \
  &<= n [log (n) + [log (log (n) + log n))]] \
  &= n [log (n) + log (n)] \
  &= 2 dot n log (n) 
  $
  Hence, by definition, $n log (n log (n log n)) = Theta(n log n)$. $qed$

  
]

#pagebreak()

== Prove that $log n! = Theta(n log n)$

#gb()[
  *Proof*:

  Let $c_1 = 1/8$, $c_2 = 1$, and $n_0 = 4$. For all $n >= n_0$, note that

  $ 0 < 1/8 dot n log n <= log n! <= 1 dot n log n $

  The choice of $c_1$ comes from:

  $ (n/2-1) log n/2<=floor(n/2) log ceil(n/2) <= log (product _(i = ceil(n/2))^n ceil(n/2) ) <= log (product _(i = ceil(n/2))^n i ) <= log n! $

  Note that for $n >= 4$:

  $ n/4 &<= n/2-1 \ 
  1/2 log n &<= log n/2 $

  Hence: 

  $ 1/8 n log n <= (n/2 - 1) log n/2 $

  Meanwhile $c_2 = 1$ comes from:

  $ log n! = sum_(i=1)^n log i <= sum_(i=1)^n log n = n log n = 1 dot n log n $

  Thus, by definition, $log n! = Theta(n log n)$ $qed$
]

#pagebreak()

In the following, $f$, $g$, and $h$ are positive functions taking in positive integer arguments and $a, b$ and $c$ are positive constants.

Formally _prove or disprove_ each of the following:


== Prove that $log n! = Theta(n log n)$

#gb()[
  *Proof*.


]
=== If $f(n) = cal(Omega)(g(n))$ and $g(n) = cal(Omega)(h(n))$, then $f(n) = cal(Omega)(h(n))$.

#gb()[
  *Proof.*

  By definition of $Omega$, we know there exist constants $c_1$ and $n_1$ such that for all $n >= n_1$:
  $ 0 <= c_1 g(n) <= f(n) $

  Similarly, we know there exist constants $c_2$ and $n_2$ such that for all $n >= n_2$:
  $ 0 <= c_2 h(n) <= g(n) $

  Define $n_0 := max(n_1, n_2)$. Then for all $n$, $n >= n_0$, after multiplying the inequalities:

  $ 0 < c_1 (c_2 h(n)) = (c_1 c_2) h(n) <= f(n) $

  Therefore, by definition, $f(n) = bigOm(h(n))$  (with constants $ c_1c_2, n_0)$.
  
  $qed$
]

=== If $f(n) = cal(O)(g(n))$, then $f(n) + g(n) = cal(Theta)(g(n))$.

#gb()[
  *Proof:*

  We want to show that there exists $c_1$, $c_2$ and $n_0$ such that for all $n >= n_0$:

  $ 0 < c_1 g(n) <= f(n)<= c_2 g(n) $



  
  By definition of $bigOm$, since $f(n) = bigO(g(n))$, there exists $c_3$ and $n_1$ such that for all $n >= n_1$:

  $ 0 < f(n) <= c_3 g(n) $

  Let $c_1 := 1$, $c_2 := c_3 + 1$, and $n_0 := n_1$.
  
  By adding $g(n)$ to all parts of the inequality, we get:

  $ 1 dot g(n) < f(n) + g(n) <= c_3 g(n) + g(n) = (c_3 +1 ) g(n) $

  as desired.

  $qed$
]


=== $f(n) = o(g(n))$ if and only if $cal(O)(f(n)) subset.neq cal(O)(g(n))$.

#gb()[
  *Proof.*
  
  ($==>$)

  We know that for all $c$, there exists an $n_0$ such that for all $n>= n_0$:

  $ f(n) < c g(n) $

  We will prove $bigO (f(n)) subset.eq bigO(g(n))$ and $bigO (f(n)) != bigO(g(n))$.

  Let $f_1 in bigO (f(n))$. From the fact above, it follows that $f_2 in bigO (f(n)) $. Hence, $bigO (f(n)) subset.eq bigO(g(n))$.

  Now, let $g_1 = 1/c g(n)$ be some function in $bigO(g(n))$. Then:

  $ g_1(n) =1/c dot c dot g(n) = 1 dot g(n) lt.not g(n) $

  Hence, we have found an element in $bigO (g(n))$ not in $bigO (f(n))$.

  ($<==$)

  We know that $bigO (f(n)) subset.neq bigO(g(n)) $. We want to show $f(n) = o(g(n))$ by contradiction.

  Suppose that $f_2(n) >= c g(n)$. 
  
  Rearranging:$ 1/c g(n) <= f_2(n) $ implying $f_2(n) in bigO(g(n))$. 
  
  Since $f_2(n)$ was arbitrary, we have $bigO (f(n)) subset.eq bigO(g(n)) $. 
  
  This is a contradiction, which means $c dot g(n) < f(n)$ or $g(n) = o(f(n))$ as desired.

  $qed$
]

=== If $f(n) = cal(Theta)(g(n))$, then the set $cal(Omega)(f(n))$ is equal to the set $cal(Omega)(g(n))$.
=== At least one of the following is true: $f(n) = cal(O)(g(n))$ or $f(n) = cal(Omega)(g(n))$.
=== $f(n) + g(n) = cal(Theta)(max(f(n), g(n)))$.

#gb()[
  *Proof.* 
  
  We want to show that there exists a $c_1, c_2,$ and $n_0$ such that for all $n >= n_0$:
  
  $ c_1 max(f(n),g(n) ) <= f(n) + g(n) <= c_2 max(f(n),g(n) ) $
  

 
  Setting $c_1 =1$ and $c_2=2$, we have:
  
  $ 1 dot max(f(n),g(n) ) <= f(n) + g(n) <= 2 dot max(f(n),g(n) ) $

 
  The value of $c_1$ is trivial.
  
  
  The value of $c_2$ is derived from definition of:
  
  $ 
  f(n) &<= max(f(n), g(n)) \
  g(n) &<= max(f(n), g(n)) \
  f(n) + g(n) &<= 2 dot max(f(n), g(n)) 
  $

  $qed$.
]

=== $2^(f(n)+g(n)) = cal(Theta)(2^(max(f(n),g(n))))$.

#gb()[
  *Proof.* 

  False. Let $f(n)=n$ and $g(n)=2n$.

  Then 
  $ 2^(f(n)+g(n)) = 2^(3n) = 8^n $
  $ 2^(max(f(n),g(n))) = 2^(2n) = 4^n $

  Clearly, $8^n != Theta (4^n)$. 

  $qed$.

]
=== $cal(O)(f(n)) subset.neq cal(O)(n f(n))$. 

#gb()[
*Proof.*  

We want to prove that for some $g$, if $g(n) = bigO (f(n))$,  then it is also in $bigO (n f(n))$.

By definition, there exists some $c$ and $n_0$ such that

$ g(n) <= c f(n) <= c n f(n) $.

Thus, $g(n) = bigO (n f(n))$.

Now, take an example $h(n) = n f(n)$. Then clearly $n f(n) = bigO (n f(n))$ but $n f(n) in.not bigO (f(n))$.

Therefore, $bigO (f(n)) != bigO (n f(n))$.

$qed$
]

=== $cal(O)(f(n)) subset.eq cal(O)(f(n) g(n))$.

#gb()[
*Proof.*  

Let $f(n) = n$ and $g(n) = 1$.

Then $bigO (n) = bigO( n )$, which is a contradiction. 

$qed$
]

=== If $f(n) <= g(n) + c$ for all positive integers $n$, then $f(n) = cal(O)(g(n))$.

#gb()[

  *Proof.*
  
  We want to show that there exists a $c_1, c_2,$ and $n_0$ such that for all $n >= n_0$:
  
  $ c_1 g(n) <= g(n) <= c_2 g(n) $
  
  Let $c_1=1$, and $c_2$ be a positive integer. We choose an $n_0$ such that it satisfies $g(n_0) >=c_2 $. Thus:
  
  $ 
  1 dot g(n) <= g(n)+c <= g(n) + g(n) <=2 dot g(n)
  $


  as desired. 
  
  $qed$
]

=== If $lim_(n->oo) f(n) = lim_(n->oo) g(n) = oo$ and $f(n)^a = cal(Theta)(g(n)^b)$, then $log f(n) = cal(Theta)(log g(n))$.

#gb()[
  *Proof.* 

  NOT DONE

  NOT DONE

  NOT DONE

]

=== If $f(n) = cal(Theta)(n^3)$, then $f(n) log f(n) = cal(Theta)(n^3 log n)$.

#gb()[
  *Proof.* 

  We want to prove that there exists some $c_3, c_4$ and $n_0$ such that for all $n >= n_0$:

  $ c_3 n^3 log n &<= f(n) log f(n) <= c_4 n^3 log n $

  Let $f$ be some function in $bigTh (n&^3)$. Then there exists $c_1, c_2, n_0$ such that for all $n >= n_0$:

  $ c_1 n^3 &<= f(n)<= c_2 n^3 $
  
  We can let $c_3 := 3 c_1, c_4 := 12 c_2,$ and $n_0 := (c_2)^(1/3) $ and by definition, $ f(n) log f(n) = bigTh (n^3 log n)$.

  These constants are obtained through the following:

  $ log (c_1 n^3) &<= log f(n)<= log( c_2 n^3) \
  log c_1 + log n^3 &<= log f(n)<= log c_2 + log n^3 \
  log n^3 <= log c_1 + log n^3 &<= log f(n)<= log c_2 + log n^3 <= 2 log n^3 $

  For clarity:

  $ log n^3 &<= log f(n)<= 2 log n^3 \ 
  3 log n &<= log f(n)<= 6 log n \
  3 f(n) log n &<= f(n) log f(n)<= 6 f(n)log n \
  (3 c_1 n^3) log n &<= f(n) log f(n)<= 6 dot (2 c_2 n^3) log n = 12 c_2 n^3 log n $

  $qed$





  


  
]

=== $f(n) g(n) = cal(O)(f(n)^2 + g(n)^2)$.
#gb()[
  *Proof.* 

  We want to prove that there exists some $c, n_0$ such that for all $n >= n_0$:

  $ f(n)g(n) <= c (f(n)^2 + g(n)^2) $

  Let $c := 1/2$ and $n_0 := 1$. Then $f(n) g(n) = cal(O)(f(n)^2 + g(n)^2)$.

  This constant was obtained using the trivial inequality:

  $ (f(n)-g(n))^2 &>= 0 \
  f(n)^2 + g(n)^2 - 2 f(n)g(n) &>= 0 \ 
  f(n)^2 + g(n)^2 &>= 2 f(n)g(n) \
  1/2 (f(n)^2 + g(n)^2) &>= f(n)g(n) \
  f(n)g(n) &<=   1/2 (f(n)^2 + g(n)^2) \


  $

$qed$

  
]

=== $f(n) g(n) = cal(Omega)(f(n)^2 + g(n)^2)$.
#gb()[
  *Proof.* 

  False. Let $f(n) = n$ and $g(n) = 1/n$. Then $f(n)g(n) = 1$ and $f(n)^2 + g(n)^2 = n^2 + 1/n^2 $

  We want to show this is not in $bigOm (f(n)^2 + g(n)^2)$. Which is true because no constant $c$ will satisfy:

  $ 
  c (n^2 + 1/n^2) &<= 1 \
  $

  because $n^2 + 1/n^2 -> oo$ as $n -> oo$.


  $qed$


  
]

== _Prove or Disprove_: $sum_(k=n)^(2n) 1/k = Theta(1)$
#gb()[
  *Proof.* 

  We want to show there exists $c_1, c_2,$ and $n_0$ such that for all $n >= n_0$:

  $ c_1 <= sum_(k=n)^(2n) 1/k <= c_2 $

  Choose $c_1:=1/2, c_2 := 2,$ and $n_0 := 1$. Then by definition, $sum_(k=n)^(2n) 1/k = Theta(1)$.

  We obtained these constants from the following inequalities:

  $ 
  1/(2n+2) &<= 1/(2n) \
  1/n &<= 2/(n+1) quad (n+1 <= 2n "at" n := n_0 >= 1)\
  $

  Hence:

  $ 1/2 = (n+1)/(2n+2)= sum_(k=n)^(2n) 1/(2n+2) <= &sum_(k=n)^(2n) 1/k \

  &sum_(k=n)^(2n) 1/k <= sum_(k=n)^(2n) 2/(n+1) <= (2(n+1))/(n+1) = 2 $  

  $qed$.
  
]