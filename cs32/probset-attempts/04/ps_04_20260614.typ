= CS 31 Problem Set 4 Attempts
*Diogn Lei R. Mortera*
06/12/2026

8. Prove that 

$ n log (n log (n log n)) = Theta (n log n ) $

*Wrong proof:*

Start from:


So:
$ 
log (n log n) &= log (n) + log log n = Theta(log n) \
log (n log (n log n)) &= log (n) + log Theta(log n) = Theta(log n) \ 
n log (n log (n log n)) &= n Theta(log n) = Theta(n log n)
$

*Correct Proof:*

Note that for some $n_0$, all $n >= n_0$ satisfies $1 <= log n <= n$. We can do some manipulation of $n log (n log (n log n))$:

$ n log (n log (n log n)) &<= n log (n log (n dot 1)) \ 
    &= n log (n log n) \
    &<= n log (n dot 1) \
    &= n log n
$

And:
$ n log (n log (n log n)) &>= n log (n log (n dot n)) \ 
    &= n log (n dot log n^2 ) \
    &>= n log (n dot n^2) \
    &= 3 n log n
$

Combining our results above provide:

$ c_1 log n <= n log (n log (n log n) ) <= c_2 n log n $ 

where $c_1 = 1$ and $c_2 = 3$. 

$ therefore n log (n log (n log n)) = Theta (n log n ) $

9. Prove that 
$ log n! = Theta(n log n) $

*Proof:*

Need to find positive, real $c_1$ and $c_2$ s.t. for sufficiently large $n>=n_0$:

$ c_1 n log n <= log n! <= c_2 n log n $

For our purposes, let $n >= max(2, n_0)$.

Some useful facts given sufficiently large $n >= n_0$:

- $log sqrt(n) <= log n <= n$
- If $0 < i < n$, then $log i <= log n$
- If $i < n/2$, then $log i <= log n/2$

$ log n! = log (product_(i=1)^n i ) = sum_(i=1)^n log i &<= sum_(i=1)^n log n = n log n \
&>= sum_(i=floor(n/2))^n log i >= sum_(i=floor(n/2))^n log (n/2) = n/2 log (n/2) = n/2(log(n)-log(2))>= 1/4 n log (n)
$

Therefore, possible candidates for $c_1$ and $c_4$ are $c_1=1/2$ and $c_2 = 1$. Since we have found suitable $n_0, c_1$, and $c_2$, our conclusion follows.

10.1 

$f(n) = Omega(g(n))$

For all $n >= n_0$, there exists some c_1 s.t. $f(n) >= c_1 g(n) > 0$


$g(n) = Omega(h(n))$

For all $n >= n_0$, there exists some c_2 s.t. $g(n) >= c_2 h(n) > 0$

Chain: 

$f(n) >= c_1 dot c_2 h(n) $

Let $c = c_1 c_2 $. Then $ f(n) >= c h(n) > 0 $

$c dot h(n) > 0$ because c is positive.

Proven.

*NOTE TO SELF: DONT FORGET THE $0 <$ PART*
#line(length: 100%)

10.2 If $f(n) = Omega(g(n))$, then $f(n)+g(n) = Theta(g(n))$

from $f(n) = Omega (g(n))$:
$f(n) <= c dot g(n)$

Upper bound:

$f(n) + g(n) <= (c+1) g(n)$

Let $ c_2 = c+1$. Then

$ f(n) + g(n) <= c_2 g(n)$ 

Lower bound: 

$ 0 &<= f(n) \
 g(n) &<= f(n) + g(n) \
$

So $c_1 = 1.$

#line(length: 100%)

10.3 

$f(n) = o(g(n))$ iff $O (f(n)) subset O (g(n))$

Disproven:

Take reverse direction. Let $f(n)=g(n)=n^2$. Then Omega(f(n)) subset Omega(g(n)) but $n^2 != o(n^2)$

*NOTE TO SELF: The proof of this is weird and involves piecewise function*

*Part of it involves using element instantiation which is something you can consider if future proving proofs*

#line(length: 100%)

10.6 

$f(n)+g(n) = Theta(max(f(n),g(n)))$

Disproven.

Counterexample: $f(n) = n, g(n) = n^2$

Then $n + n^2 = O(n) + n^2 = O(n^2)$

But $ n + n^2 = Omega(n) + n^2 = Omega(n)$

#line(length: 100%)

10.11

If:
- $lim_(n -> infinity) f(n)=lim_(n -> infinity) g(n) = infinity$
- $ f(n)^a = Theta(g(n)^b)$
Then:
- $log f(n) = Theta(log g(n))$

*Wrong Proof*

For every $n >= n_0$, there exists a $c_1$ and $c_2$ s.t.

$ c_1 g(n)^b <= f(n)^a <= c_2 g(n)^b $

Given $n >= max(2, n_0)$:

Take log both sides

$ log(c_1) + b log g(n) <= a log f(n) <= log(c_2) + b log g(n) $

Let $c_1=2$ and $c_2= 1/2$. Then

$ b log g(n) <= log(c_1) + b log g(n) <= a log f(n) <= b log g(n) <= log(c_2) + b log g(n) $

Where $c_1' = c_2' = b$.

Therefore by definition, $log f(n) = Theta(log g(n))$.

*Correct (?) Proof*

For every $n >= n_0$, there exists a $c_1$ and $c_2$ s.t.

$ c_1 g(n)^b <= f(n)^a <= c_2 g(n)^b $

Given $n >= max(2, n_0)$:

Take log both sides

$ log(c_1) + b log g(n) <= a log f(n) <= log(c_2) + b log g(n) $

$ log(c_1)/a + (b log g(n))/a <= log f(n) <= log(c_2)/a + (b log g(n))/a $

Replace the additive constants with the claim:

Claim: for any constant $C$, there exists $n_1$ such that for $n>=n_1$,

$ |C| <= 1/2 b/a log g(n) $

Proof: 

Rearrange: $log g(n) >= 2|C| / k$ . This is true, because $log g(n)$ grows without bound while the RHS is a constant.

$  (b log g(n))/a - 1/2 b/a log g(n) <= log f(n) <= log(c_2)/a + 1/2 b/a log g(n) $

Where $c_1 = 1/2 b/a$ and $c_2 = 3/2 b/a$.

Therefore by definition, $log f(n) = Theta(log g(n))$.

*INSIGHT: The bounds don't have to be strict! Can loosen them for the sake of convenience*

#line(length: 100%)

10.12

If $f(n) = Theta(n^3)$, then $f(n) log f(n) = Theta(n^3 log n)$

*Wrong proof*


From the definition, $f(n) = Theta(n^3)$ implies that for all $n >= n_0$, there exists a $c_1$ and $c_2$ such that:
$ c_1 n^3 &<=f(n)<= c_2 n^3 \
  c_1 n^3 log (c_1 n^3) &<=f(n) log f(n)<= c_2 n^3 log (c_2 n^3) \
  c_1 n^3 (log (c_1) + 3 log(n)) &<=f(n) log f(n)<= c_2 n^3 (log (c_2) + 3 log(n)) \
   3 c_1 n^3 log(n)  &<=f(n) log f(n)<= c_2 n^3 log (c_2) + 3 c_2 n^3 log(n)
$

Note that $log(c_2) <= log(n)$ for sufficiently large $n>=n_0 = c_2$

$ f(n) log f(n) &<=  c_2 n^3 log (c_2) + 3 c_2 n^3 log(n) \
 &<= c_2 n^3 log (n) + 3 c_2 n^3 log(n) \
 &<= (4 c_2) n^3 log(n) $

Our final inequality corresponds to the definition of $f(n) log f(n) = Theta(n^3 log n)$, with $c'_1 = 3c_1$ and $c'_2 = 4 c_2$:

$ (3 c_1) n^3 log(n) <=f(n) log f(n) <= (4 c_2) n^3 log (n) $

$ therefore f(n) log f(n) = Theta (n^3 log n).$

*Correct proof* 

From the definition, $f(n) = Theta(n^3)$ implies that for all $n >= n_0$, there exists a $c_1$ and $c_2$ such that:

$ c_1 n^3 &<=f(n)<= c_2 n^3 $

$ log c_1 + 3 log n &<=log f(n)<= log c_2 + 3 log n $

Handle lower and upper bounds separately:

Lower bound:

$ log c_1 + 3 log n &<=log f(n) \ 
  c_1 n^3 (log c_1 + 3 log n) <= log f(n) 
$

#line(length: 100%)
10.13

$f(n)g(n) = O(f(n)^2 + g(n)^2)$

Elegant proof based on Square of Binomial!

Corollary: $f(n)+g(n) = O(max(f(n),g(n)))$

#line(length: 100%)
10.14


Counterexample: $f(n)=n$ and $g(n)=n^2$


#line(length: 100%)

11

$sum_(k=n)^(2n) 1/k = Theta(1) $

Prove:

$ c_1 <= sum_(k=n)^(2n) 1/k <= c_2 $

Note that for all $k$:

$ 1/(2n) <= 1/k <= 1/(n) $

So 

$ (n+1)/(2n) <= sum_(k=n)^(2n) 1/k <= (n+1)/n $

Important Idea:

$ (n+1)/(2n) = 1/2 + 1/(2n) >= 1/2 $

$ n+1 / n = 1 + 1/n <= 2 $

So $c_1 = 1/2$ and $c_2 = 2$.


$therefore$ This inequality meets the definition of $sum_(k=n)^(2n) 1/k = Theta(1)$, with $n_0 = 1, c_1 = 1/2, c_2 = 2$.
