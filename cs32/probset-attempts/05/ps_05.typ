
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
  = CS 32 Probset 5
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

== Basti Sum 

#gb()[ 
  Your best case must not occur for a single constant, but for infinitely many inputs.
]

== _P or D:_ If the time complexity of an algorithm is $bigO(n^5)$, then its time complexity is $bigOm(n)$.

#gb[ 
  *Proof.*

  False. Let $f(n) = 1$. Then $1 = bigO(n^5)$ but $1 != bigOm(n)$. $qed$
]

== Perms 

#gb[
  *Proof.*

  Since there are $n!$ such permutations of $[1,2,...,n]$, any algorithm enumerating the list of permutations must have at least $n^2$ steps. Hence, the algorithm runs in $bigOm(n!)$ time.

  $qed$
]

== Linear search 

#gb[
  *Proof.*

  Note that comparison and return takes $Theta(1)$. 

  Note that in linear search, there are two scenarios:
  
  - Element is on the list. Then it compares a value to most $n$ numbers in the list. Hence, this branch takes $bigO(n)$ time.

  - Element is _not_ on the list. Here, it iterates through the $n$ elements and returns $-1$. It runs in at least $n$ times. Here this branch runs at least $n$ times, implying it runs at $bigOm(n)$ time.

  Since linear search runs in both $Omega(n)$ and $bigO(n)$, it then runs in $Theta(n)$ time.

  The strongest result is at $Theta(n)$, because it implies both $bigOm(n)$ and $bigO(n)$. Meanwhile, $Theta(n)$ alone or $bigOm(n)$ alone does not imply $Theta(n)$.

  $qed$
]

== Find the time complexity of the memoized $sans("path_count")$ algorithm.


#gb()[ 
  *Proof.* 

  Note that $sans("path_count")$ involves initializing a grid of $n^2$ elements. This takes $n^2$ operations.

  Then, $sans("path_count")$ calls $sans("count_from")(0,0)$ which runs in $bigO(n^2)$ by Lemma 2.

  Since the time complexity of $sans("path_count") = n^2 + "time complexity of" sans("count_from(0,0)") = n^2 + bigTh(n^2)$, we can conclude that $sans("path_count") = Theta(n^2)$.

  $qed$.
]

#gb[
  #boxed[
    *Lemma 1.* $sans("count_from")(i,j)$ runs in $Theta(1)$ time.
  ]

  #boxed(centered: false)[ 
    *Proof.*

    We want to prove that $sans("count_from")(i,j)$ runs in $Theta(1)$ time.
    
    We do this by induction on $i+j$ by noting that the sum of parameters strictly increases after every step.

    _Base case:_ If $(i,j)$ is out of bounds, then the function  returns $0$ in $Theta(1)$. If $(i,j) = (n-1,n-1)$, then it has reached the end destination and thus returns $1$ in $Theta(1)$ time.

    _Inductive case:_ Recall that our unmemoized function is
    
    $ sans("count_from")(i,j) = sans("count_from")(i+1,j) + sans("count_from")(i,j+1) + Theta(1) $

    But from our inductive hypothesis, function calls with parameter sum greater than $i+j$ have been already been memoized. In other words, $sans("memo")[i][j+1]$ and $sans("memo")[i+1][j]$ have already been computed and only have to be looked up in $Theta(1)$. More formally:

    $ sans("count_from")(i,j) = Theta(1) + Theta(1) +Theta(1) = 3 dot Theta(1) =Theta(1) $

    This proves the inductive case. 

    $qed$
  ]
]

#gb[
  #boxed[*Lemma 2.* 
  $sans("count_from")(0,0)$ runs in $bigTh(n^2)$ time.
  ]

  #boxed(centered: false)[
    Calling $sans("count_from(0,0)")$ explores all pairs $(i,j)$ in the grid. Since are $n dot n =n^2$ pairs for $(i,j)$, we have at most $n^2 dot Theta(1) = Theta(n^2)$ operations from $sans("count_from")(0,0)$.

  ]
]
== $z(s)$
== $sans("lorem_absum")(s)$

#gb[ 
  *Proof.* 

  The total number of operations is:

  $ sum_(i=0)^n sum_(j=0 \ 2(i+j) < n)^n (|i+j| - |i-j|) $ 
]
== $sans("foo")(n)$

#gb[ 
  *Proof.* We claim that $sans("foo")(n)$ runs in $Theta(n^3)$ time. 

  Note that the outer loop runs at most $n$ times. Either it does or it does not.
  
  For the cases $i$ it does, it runs an inner loop $i^2$ times.

  We can get the total number of operations using indirect counting. We remove the instances when the loop did not run:

  $ sum_(i=1)^n i^2 - sum_(i=1)^floor(n/d) (d i)^2 = (n(n+1)(2n+1))/6 -  (d^2(floor(n/d))(floor(n/d) + 1)(2 floor(n/d) + 1))/6 $

  Note that $floor(n/d)$ is bounded by a constant $32$:

  $ 
  floor(n/ (floor(n/32)+1) ) &<= floor( n / (n/32 + 1)) \
  &<= floor(n / (n/32))= floor(32) = 32
  $

  Hence we can let $p = (floor(n/d))(floor(n/d) + 1)(2 floor(n/d) + 1)$ as a constant.

  Meanwhile, for $n > 64$:

  $ n/64 <= floor(n/32) + 1 = d&<= n/32 +1 <= 3n \
   2n+1 &<= 3n $

  Then we have:

  $ 1/64^3 n^3 <= (n(n+1)(2n+1)-d^2 p)/6 <=  1/2 n^3 $
  
  By definition, $sans("foo")(n) = Theta(n^3)$ (with constants $1/64$, $4/3$, and $65$).


]

== $sans("min_seq(seq)")$

=== Prove that this is correct.
#gb[
*Proof.* We will prove the correctness of $sans("_min")$ by induction. We assume that for all inputs $0<i<n$ to $sans("_min")$ less than $n$, it returns the minimum element in the first $i$ elements of the list.

_Base case:_ 

- At $n = 1$, there is only one element $v$ in the sequence, so this is guaranteed to be the minimum.
- At $n = 0$, the algorithm raises an error. This case should not be reached if the initial function call is $n>=1$ or as long as $sans("seq")$ is not empty.

_Inductive case:_ 

The $sans("if")$ body compares $v=sans("seq")[n-1]$ to $sans("_min")(n-1)$, the minimum element in the first $n-1$ elements by the inductive hypothesis. There are two cases:

- $v < sans("_min")(n-1)$: Since $v$ is smaller than the sequence prefix, it is returned as the minimum for this function call. By definition of $min$, this correctly returns the minimum of the first $n$ elements.

- $v = sans("_min")(n-1)$: Since they are equal, either can be returned. The algorithm returns $v$.

- $v > sans("_min")(n-1)$: Then $sans("_min")(n-1)$ is appropriately called. By definition of $min$, this correctly returns the minimum of the first $n$ elements.

In all cases, the function returns the minimum of the first $n$ elements. This proves the inductive case.

From Lemma 1, $sans("_min")$ is correct. By calling $sans("_min(len(seq))")$, we get the minimum of the first $sans("len(seq)")$ elements of the array, or essentially all of the elements in the array. 

Therefore, $sans("min_seq(seq)")$ is correct.


$qed$.

]
=== Prove that it runs in $Theta(2^n)$

#gb[
  *Proof.* 
  We analyze $sans("_min")(n)$:
  - The first $sans("if")$ statement, along some comparisons in the $sans("if")$ statements below run in $Theta(1)$ time.
  - The second $sans("if")$ statement and the $sans("else")$ body has a comparison that involves calling $sans("_min")(n-1).$

  We can therefore set up a recurrence:

  $ 
  sans("_min")(n) &= sans("_min")(n-1) + sans("_min")(n-1) + c dot Theta(1) \
  &= 2 dot sans("_min")(n-1) + Theta(1)
  $
  
  From Lecture 05, it was shown that this recurrence pattern where $f(n) = sans("_min")(n)$ has a solution $sans("_min")(n) = Theta(2^n)$.

  $sans("min_seq")$ calls $sans("_min")(n)$ once. Thus, it has a time complexity of $1 dot Theta(2^n) = Theta(2^n)$.

  $qed$
]

#pagebreak()
=== Optimization

#gb[
  *Proof.*

  We can compute $sans("_min")(n-1)$ once, set it to a variable $sans("min_pref")$ and replace instances of it in the original algorithm.

  


  This turns the recurrence into:

  $ sans("_min")(n) = sans("_min")(n-1) + Theta(1) $

  Let $f(n)=sans("_min")(n)$ for brevity. From Lemma 1, we have proved that $f(n) = Theta(n)$. Therefore, $sans("min_seq")$ now runs in $1 dot Theta(n) = Theta(n)$ time.

  $qed$
]

#gb[
  #boxed[
    *Lemma 1.* 

    The recursive function $ f(n) = f(n-1) + Theta(1)$

    has a solution $f(n) = Theta(n)$.
  ]

    *Proof.* 

    We remove the abuse notation of $Theta(1)$. From this, we know that there is some $g(n) = Theta(1)$ wherein there exists a $c, n_0$ such that for all $n >= n_0$, $g(n) <= c$. Hence:

    $ f(n) <= f(n-1) + c $

    For $n <= n_0$, since these are finite $n$, they are bounded by some constants. Let's denote the maximum of these constants by $c'$.

    

  
  By Lemma 2, $f(n) <= C dot n + c <= C dot n$, hence$f(n) = bigO(n)$ (with constants $C$, $n_0$).

  We can also remove the abuse notation of $Theta(1)$ in another way, since we also know that there is some $g(n) = Theta(1)$ wherein there exists a $c, n_0$ such that for all $n >= n_0$, $c <= g(n)$. Hence:

    $ f(n-1) - c <= f(n) $

    For $n <= n_0$, since these are finite $n$, they are bounded by some constants. Let's denote the _sum_ of these constants by $c'$.

    By Lemma 3, $C dot n<=C dot n + c <= f(n)$, hence $f(n)=bigOm(n)$ (with constants $C, n_0$).

    Because $f(n) = bigOm(n)$ and $f(n) = bigO(n)$, it follows that $f(n) = bigTh(n)$ $qed$
]

#gb[
  
  #boxed[
    *Lemma 2.*

    $f(n) <= C dot n - c$, where $C = sans("max")(c,c') + c$
  ]

  *Proof.*
  We prove by induction.

    _Base case:_

    For $n < n_0$:

    $ f(n) &<= c' \ 
    f(n) &<=C-c<=C dot n -c
    $

    _Inductive case:_

    For $n >= n_0$, we know $f(n) = C dot (n-1) + c$ by the inductive hypothesis. Then:

    $
    f(n) &<=  f(n-1) + c \
    &<= C dot (n-1) -c + c \
    &= C dot n-C \
    &= C dot n - c + c \
    &= C dot n - c
    $

    This proves our inductive case.

    $qed$
]

#gb[
  
  #boxed[
    *Lemma 3.*

    $C dot n + c <= f(n)$, where $C = (max(c,c') - c) / n_0$
  ]

  *Prove.*

  We prove by induction.

    _Base case:_

    For $n < n_0$:

    $ C dot n + c <= C dot n + n_0 + c <= C dot n_0 + n_0 dot c <= c' &<= f(n)  \ 
    $

    _Inductive case:_

    For $n >= n_0$, we know $f(n) = C dot (n-1) + c$ by the inductive hypothesis. Then:

    $
     C dot n +c&<= C dot n- C - 2c &<= C dot (n-1) - c - c <=f(n-1) - c &<= f(n) \
    $

    This proves our inductive case.

    $qed$

]


#pagebreak()

== Recursive madness or some shi

#gb[
  We claim that $r = 8$ works. That is, we will prove that $f(n)=Theta(8^n)$.

  *Proof.* 

  Note that for $n >= 33$, 

  $ ceil( 7 + 11/n)&= 8 \
  floor( 32/n )&= 0 $

  Hence the recurrence simplifies to
  $
  f(n) &= 8 f(n-1) - 1
  $

  From Lemma 1 and Lemma 2, we know that given $n_0:=33$, for all $n >= n_0$:

  $ c_1 8^n <= c_1 8^n + 1/7 <= f(n) <= c_2 8^n $

  Therefore, $f(n) = Theta(8^n)$ (with constants $c_1, c_2$ and $n_0$).

  $qed$  
] 

#gb[ 
  #boxed[
    
    *Lemma 1.* 
    
    $c_1 8^n + 1/7 <= f(n) $ for all $n >= 33$ and $c_1 := (f(33) - 1/7) / 8^33$
  ]

  *Proof.*

  _Base case._ At $n=33$:

  $ c_1 8^33 + 1/7 &<= f(33) \ 
  (f(33)- 1/7)/8^33 dot 8^33 + 1/7 &<= f(33) \
  f(33) - 1/7 + 1/7 &<= f(33) \
  f(33) &<= f(33)
  $

  which is true, proving our base case. 

  _Inductive case._ For $n>33$:

  $  c_1 8^n + 1/7 = 8 (c_1 8^(n-1) + 1/7) - 1<= 8f(n-1) - 1 = f(n) $

  This proves our inductive case.

  $qed$.
]

#gb[
#boxed[
    
    *Lemma 2.* 
    
    $f(n) <= c_2 8^n $ for all $n >= 33$ and $c_2 := f(33) / 8^33$

  ]
    *Proof.*

    _Base case._ At $n=33$:

    $ f(33) &<= c_2 8^33 \ 
    &= f(33) / 8^33 dot 8^33 \ 
    &= f(33) 
    $

    which is true, proving our base case. 

    _Inductive case._ For $n>33$:

    $  f(n) = 8 dot f(n-1)-1 <= 8 (c_2 8^(n-1) )-1 = c_2 8^n - 1<= c_2 8^n $

    This proves our inductive case.
    
    $qed$.
]


#gb[
  *Old Proof.*

  Note that for $n >= 33$, 

  $ ceil( 7 + 11/n)&= 8 \
  floor( 32/n )&= 0 $

  Hence we can simplify our recursive function to
  $
  f(n) &= 8 f(n-1) - 1
  $

  We can show that $f(n) = C dot 8^n + 1/7$ is a solution. We set $C > 0$ to maintain positivity for later:

  $ C dot 8^n + 1/7 &= 8 dot (C dot 8^(n-1)+1/7)-1 \
  &= C dot 8^n + 8/7 -1 \ 
  &= C dot 8^n + 1/7 $

  Also, note that for $n >= 33$, the following also apply:

  $ C dot 8^n <= C dot 8^n + 1/7 <= 2C dot 8^n $

  Hence, $f(n) = bigTh(8^n)$ (with constants $C, 2C,$ and $33$).

  $qed$.
]

