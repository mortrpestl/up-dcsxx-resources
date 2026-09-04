
#let gb(content) = rect(
  fill: luma(230),
  inset: 8pt,
  radius: 3pt,
  width: 100%
)[#content]

1. If anyone in the dorm has a friend who has the measles, then everyone in the dorm will have to be quarantined.

#gb[
    *Solution:*

    Let:
    - $F(x,y)$ - $x$ is a friend of $y$ 
    - $M(x)$ - $x$ has the measles
    - $D(x)$ - $x$ is in the dorm 
    - $Q(x)$ - $x$ is quarantined 

    $exists x(D(x) and F(x,y) and M(y) ) => forall x(D(x) and Q(x))$ (attempt 1)

    $exists x(D(x) and exists y (F(x,y) and M(y) ) ) => forall z(D(z) and Q(z))$ (actual answer) 
]

2. Negate $ forall x exists y (R(x,y) and not L(x,y)) $
#gb[
    *Solution:*

$not forall x exists y (R(x,y) and not L(x,y))$

$exists x not exists y (R(x,y) and not L(x,y))$


$exists x exists y (not R(x,y) or L(x,y))$

$exists x forall y (R(x,y) -> L(x,y))$
]

3. Every positive number has exactly two square roots.


#gb()[
    *Solution: *

    Let the universe of discourse be the reals.

    $forall x (x > 0 => exists y exists z(y^2=x and z^2 = x and x!= z and not exists w(w^2 = x and w!=y and w!=z)))$  
  ]

4. Simplify:

$ (S or G) and (not S or not G) $

#gb()[

*Solution: *

$
&(S or G) and (not S or not G) \
&(S and not S) or (S and not G) or (G or not S) or (G or not G) \
&(S and not G) or (G or not S) 
$

This is a XOR.
]

#pagebreak()

Suppose $a$ and $b$ are real numbers:

5.  Prove that if $a < b < 0$ then $a^2 > b^2$.

#gb()[
  *Solution:*

  Since $a < b < 0$, then $a < b => a-b < 0$ 

  Multiply both sides by $a+b$, which is a negative number ($a + b < 0$) because $a < 0$ and $b < 0$. This makes $(a-b)(a+b)$ positive.

  Then $(a-b)(a+b) > 0 => a^2 - b^2 > 0 => a^2 > b^2$
  $qed$
]

6. Prove that if $a<b<0$, then $1/b < 1/a$.

#gb()[ 
  *Solution:*

  $a<b<0 => a-b < 0 => a < b => a/b > 1 => 1/b < 1/a$
] 

7. Suppose $A inter C subset.eq B$ and $a in C$. Prove that $a in.not A \\ B$.

#gb()[ 
  *Solution:*

  $a in.not A \\ B --> not (a in A \\ B) --> not (a in A and a in.not B) --> a in.not A or a in B -->  a in A => a in B$

  Suppose $a in A$. Then $a in A inter C --> a in B$ (by $A inter C subset.eq B$). Hence $a in B$. 

  $qed$

]

8. Prove that
$ A subset.eq B and A subset.eq C => A subset.eq B inter C $

#gb()[
  *Solution:*

  Let $x$ be arbitrary.

  Since $x in B$ and $x in C$, then $x in B and x in C => x in B inter x in C$
]

9. Prove that for any sets $A$ and $B$, $P(A inter B) = P(A) inter P(B)$.

#gb()[ 
  $(=>) P(A inter B) subset.eq P(A) inter P(B)$

  Let $x$ be arbitrary.

  Since $x in P(A inter B)$, $x subset.eq A inter B =>x subset.eq A and x subset.eq B => x in P(A) and x in P(B)=> x in P(A) inter P(B) $. 

  $(arrow.l.double) P(A) inter P(B) subset.eq P(A inter B)$

  Let $x$ be arbitrary.

  Since $x in P(A) inter x in P(B) => x subset.eq A and x subset.eq B =>x subset.eq A inter B => x in P(A inter B)$

  Since $x$ was arbitrary, $P(A inter B) = P(A) inter P(B)$. $qed$

]

#pagebreak()

10. There is a unique set $A$ s.t. for every set $B$, $A inter B = B$

#gb()[
  *Solution:*

  Clearly, $B inter B = B$, so $B$ has the desired property.

  Suppose $forall B (C inter B = B)$ and $forall B (D inter B = B)$. 

  Applying $D$ to the first assumption, $C inter D= D$.

  Applying $C$ to the second assumption, $D inter C= C$.

  But $D = C inter D = D inter C = C$. Hence, $D = C$. Which means $C=D$. $qed$
]

11. Prove that there is a unique $A in P(U)$ such that for every $B in P(U)$, $A union B = B$.

#gb()[
  *Solution:* 

  Clearly, $emptyset in P(U)$, and $emptyset union B = B$.

  Suppose $forall B (C union B = B)$ and $forall B (D union B = B)$. 

  Applying $D$ to the first assumption, $C union  D= D$.

  Applying $C$ to the second assumption, $D union C= C$.

  But $D = C union D = D union C = C$. Hence, $D = C$. Which means $C=D$.
  
  Therefore, for a set B of $P(U)$, there is some other set B in $P(U)$ where $P union B = B$ $qed$
]

== Symmetric Difference Series
 
Recall that you showed in exercise 12 of Section 1.4 that symmetric difference is associative; in other words, for all sets $A$, $B$, and $C$,

$ A triangle (B triangle C) = (A triangle B) triangle C. $

You may also find it useful in this problem to note that symmetric difference is clearly commutative; in other words, for all sets $A$ and $B$,

$ A triangle B = B triangle A. $

(a) Prove that there is a unique identity element for symmetric difference. In other words, there is a unique set $X$ such that for every set $A$,

$ A triangle X = A. $

#gb()[
  *Solution:* 

  Clearly, $A triangle emptyset = A$. 

  Suppose $forall B(C triangle B = B)$ and $forall B(D triangle B = B)$. 

  Apply D to the first assumption and C to the second assumption. We then have $C triangle D = D$ and $D triangle C = C$. But we know by the fact above that symmetric difference is commutative. 

  Hence $C triangle D = D triangle C$, implying $D=C$. $qed$
]

#pagebreak()
12. Suppose $a in R$ and $a < 0$. Prove $forall n in N$:

$ "even" n -> a^n > 0 $ 
$ "odd" n -> a^n < 0 $ 

#gb()[
  *Solution:* 

  Base Case ($n=1$):

  Because $n=1$ is odd:

  $ a^1 = a < 0 $ 
  
  Inductive Hypothesis:

  $ "even" n -> a^n > 0 $ 
  $ "odd" n -> a^n < 0 $ 
  
  Inductive Step:

  Case 1: $n+1$ is odd

  Then $n$ is even, so by IH, $a^n > 0$. We are given $a < 0$. Since the product of a positive number and a negative number is negative,

  $ a^(n+1) = a^n dot a < 0. $

  Case 2: $n+1$ is even

  Then $n$ is odd, so by IH, $a^n < 0$. We are given $a < 0$. Since the product of two negative numbers is positive,

  $ a^(n+1) = a^n dot a > 0. $
    
    The inductive step is proven.

    $qed$
  ]

Suppose $a$ and $b$ are real numbers are $0<a<b$

13. Prove $forall n>=1$, $0<a^n<b^n$.

#gb()[
  *Solution:*

  Base Case 
  $0 < a < b$ (given)

  Inductive Hypothesis

  Let $n$ be an arbitrary natural number and suppose
  $0<a^n<b^n$.

  Inductive Step

  Then $0<a^(n+1) < b^(n+1) =>  0<a^(n+1)$ and $a^(n+1) < b^(n+1)$/



  
]
14. Prove $forall n>=2$, $0 < root(n,a) <root(n,b)$
15. Prove $forall n>=1$, $a b^n + b a^n < a^(n+1) + b^(n+1)$
16. Prove $forall n>=2$, $ ((a+b)/2)^n < (a^n + b^n)/2 $