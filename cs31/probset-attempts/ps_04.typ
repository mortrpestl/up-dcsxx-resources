#let title_ = "CS 31 - Problem Set 4"

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

Let $(cal(S), Pr)$ be a probability space, and $E_1$ and $E_2$ be events.

_Prove or Disprove:_ $Pr[E_1 union E_2] = Pr[E_1] + Pr[E_2]$ iff $E_1$ and $E_2$ are disjoint.
#proof[
False. We show a case where $E_1$ and $E_2$ are not disjoint but $Pr[E_1 union E_2] = Pr[E_1] + Pr[E_2]$.

Let $cal(S) = {a,b,c}$, with $Pr[a]=1/2, Pr[b]=1/2,$ and $Pr[c]= 0$.

So $E_1={a,c}$, $E_2={b,c}$, and $E_1 union E_2={a,b,c}=UU$.

Then,

$
Pr[E_1] &= Pr[a] + Pr[c] = 1/2+0= 1/2  
$ 

and
$
Pr[E_2] &= Pr[b] + Pr[c] = 1/2+0 = 1/2.
$


Hence

$ Pr[E_1]+Pr[E_2] = 1/2 + 1/2 = 1. $

On the other hand,
$ Pr[E_1 union E_2] &= Pr[UU]= 1 $

Thus,

$ Pr[E_1]+Pr[E_2] = Pr[E_1 union E_2] = 1 $

showing $Pr[E_1]+Pr[E_2] = Pr[E_1 union E_2]$ 

$qed$.
]

#pagebreak()
= Question 2

Let $n in N$. A fair die is thrown $n$ times. 

2.1 Find the probability that the resulting sequence is increasing

#proof[ 
We claim that the probability for $n$ rolls is 

$ cases(
  binom(6,n)/6^n & "if" n <= 6 
, 0 & "otherwise" )
$

$n <= 6:$ Each strictly increasing sequence of length $n$ from $[6]$ is equivalent to choosing $n$ distinct elements from the same set because once the elements are picked, there is only $1$ way to order them. Hence the number of favorable outcomes is equal to the number of $n$-subsets in the set ${1,2,3,4,5,6}$, or

$ binom(6,n). $

Since each of the rolls have $6$ possible outcomes independently, the sample space has size $6^n$ by rule of product.

Therefore, the probability of a strictly increasing sequence of length $n$ is

$ binom(6,n) / 6^n. $


$n>6:$ Since one side is guaranteed to repeat after 6 rolls (by the pigeonhole principle), there exists no such subsequence. Hence, the probability is

$ 0/6^n = 0. $

$qed$

]


#pagebreak()
2.2 Find the probability that the resulting sequence is decreasing.

#proof[
  We claim that this probability is 

  $ cases(
  1-binom(6,n)/6^n & "if" n <= 6 
  , 0 & "otherwise" )
  $

  $n <= 6:$

  Let $A$ and $B$ be the set of increasing and decreasing sequences of length $n$. Then we define $f: A->B$ as

  $ f(x) = "reversal of" x $

  (Note $f$ is well-defined: reversing a strictly increasing sequence gives a strictly decreasing one.)

  We claim $f$ is bijective. It suffices to show $f$ is an involution, i.e. $f(f(x)) = x$ for all $x$: reversing a sequence twice returns the original sequence.


  Because we have a bijection, the probability that a set of $n$ decreasing rolls and a set of $n$ increasing rolls are equal. Since they share the same sample space, the probability that a sequence of rolls are decreasing is:

  $ binom(6,n) / 6^n $

  By indirect counting, the probability that a sequence of rolls are nondecreasing is:

  $ 1- binom(6,n) / 6^n  $

  $n>6:$ Since one side is guaranteed to repeat after 6 rolls (by the pigeonhole principle), there exists no such subsequence. Hence, the probability is

$ 0/6^n = 0. $

$qed$

  

]

#pagebreak()
2.2 Find the probability that the resulting sequence is nondecreasing.

#proof[
  We claim that the probability the resulting sequence is nondecreasing is

  $ binom(n+5, 5)/6^n $
 
  The number of ways to select a nondecreasing sequence of length $n$ is equivalent to the number of $n$-multisets in ${1,2,3,4,5,6}$. 
  
  Let $f$ be the function mapping the former to the latter. Then $f$ is surjective because each $n$-multiset can be listed in nondecreasing order, and injective because two different nondecreasing sequences must have different multisets of entries (since each multiset has only one nondecreasing arrangement).
  
  
  Hence the number of favorable outcomes is 

  $ binom(n+(6-1), (6-1)) = binom(n+5, 5) $

  On the other hand, since there are 6 possible outcomes for each roll, the size of the sample space is 

  $ 6^n $

  by rule of product. 

  Hence, the probability the resulting sequence is nondecreasing is 

  $ binom(n+5, 5)/6^n $

  $qed$
]


2.3 Find the probability that $3$ appears at least once.

#pagebreak()
2.4 Find the probability that the pattern $(3,1)$ appears.

#proof[ 


    Let $a_n$ and $b_n$ be the number of sequences ending and not ending in $3$, respectively. We also build the sequence over $a_n$ and $b_n$ such that no pattern $(3,1)$ occurs.
  
  Hence, we can define $s_n = a_n + b_n$ as the number of sequences avoiding $(3,1)$. The probability of this occurring would be $ s_n / 6^n $.
  By complementary counting, we get our desired answer,

  $ 1- s_n / 6^n $

  Then $a_n$ can be built from either $a_(n-1)$ or $b_(n-1)$ by appending a roll of $3$.

  Meanwhile, $b_n$ (sequences ending in a value other than $3$) can be built:
  - from $a_(n-1)$, by appending any value other than $3$ or $1$ (since $3$ would give $a_n$, and $1$ would create the forbidden pattern) with $4$ choices;
  - from $b_(n-1)$, by appending any value other than $3$ (no restriction on $1$, since the previous roll was not $3$) with $5$ choices.

  Hence:
  $
    a_n &= a_(n-1) + b_(n-1) \
    b_n &= 4a_(n-1) + 5b_(n-1)
  $



  Note from this recurrence that


  $ s_(n-1) &= a_(n-1)+b_(n-1)=a_n \
  s_n &= a_(n+1) $

  So it suffices to solve the recurrence purely based on $a_n$. In fact, we can simplify this recurrence in terms of $a_n$ by unrolling the mutual recurrences:

  $
  b_n &= 4a_(n-1)+5b_(n-1) \
  &=4a_(n-1)+5(a_n - a_(n-1)) \
  &= 4a_(n-1)+5a_n-5a_(n-1) \
  &= 5a_n -a_(n-1)
  $

  So,

  $
  a_n &= a_(n-1) + b_(n-1) \
  &= a_(n-1) + (5a_(n-1) -a_(n-2)) \
  &= 6a_(n-1)-a_(n-2)
  $
]

#proof[
  We can solve for this recurrence using the characteristic equation method with $a_n = r^n$:

  $ r^n &= 6r^(n-1)-r^(n-2) \
  r^2 - 6r + 1 &= 0 \
  r &= 3 plus.minus 2 sqrt(2) $

  A candidate solution is $a_n = A(3+2sqrt(2))^n + B(3-2sqrt(2))^n$.

  Note our base cases: $a_0 = 0$, $a_1 = 1$. Solving for $A$ and $B$ under these lets $A=sqrt(2)/8$ and $B=-sqrt(2)/8$. Hence,

  $ a_n = sqrt(2)/8(3+2sqrt(2))^n -  sqrt(2)/8(3-2sqrt(2))^n $.

  And 

  $ s_n = a_(n+1) = sqrt(2)/8(3+2sqrt(2))^(n+1) -  sqrt(2)/8(3-2sqrt(2))^(n+1) $

  Plugging this back to our first equation, the probability $(3,1)$ occurs is:

  $ 1- (sqrt(2)/8(3+2sqrt(2))^(n+1) -  sqrt(2)/8(3-2sqrt(2))^(n+1))/6^n $

  $qed$.
]

#proof("Old")[ 


  Let $a_n$ and $b_n$ be the number of sequences ending and not ending in $3$, respectively. We also build the sequence over $a_n$ and $b_n$ such that no pattern $(3,1)$ occurs.
  
  Hence, we can define $s_n = a_n + b_n$ as the number of sequences avoiding $(3,1)$. The probability of this occurring would be $ s_n / 6^n $.
  By complementary counting, we get our desired answer,

  $ 1- s^n / 6^n $

  Then, $a_n$ could build up from either $a_(n-1)$ and $b_(n-1)$ with a roll of side $3$. Meanwhile $b_n$ can build up from $a_(n-1)$ with $4$ possible outcomes, because $1$ cannot come after $3$ and also $3$ is disallowed by definition of recurrence, and with $5$ possible outcomes from $b_(n-1)$, because only $3$ is disallowed.

  Hence we have: 

  $
    a_n &= a_(n-1) + b_(n-1) \
    b_n &= 4a_(n-1) + 5b_(n-1)
  $


]

2.6 Find the probability that the sum of the throw values is divisible by 6.

#proof[
  Define $a_n,b_n,c_n,d_n,e_n,f_n$ as the number of rolls of length $n$ whose sum is $equiv 0,1,2,3,4,5 mod  6$ respectively.

To build a length-$n$ sequence with sum $equiv 0 mod  6$, we take a length-$(n-1)$ sequence with sum $equiv r mod  6$ for some residue $r$, and append a roll $i in {1,...,6}$ with $i equiv -r mod  6$. Since $i mod 6$ ranges over ${1,2,3,4,5,0}$ as $i$ ranges over ${1,...,6}$, there is exactly one valid choice of $i$ for each residue class $r$. Hence each of $a_(n-1),b_(n-1),...,f_(n-1)$ contributes exactly once:

$ a_n = a_(n-1)+b_(n-1)+c_(n-1)+d_(n-1)+e_(n-1)+f_(n-1). $

But the right-hand side is simply the total number of length-$(n-1)$ sequences (summed over all residue classes), which by the rule of product is $6^(n-1)$. Hence

$ a_n = 6^(n-1). $

(The same argument applies to any target residue, so in fact $a_n=b_n=c_n=d_n=e_n=f_n=6^(n-1)$, confirming the sum is uniform mod $6$.)

Hence, the probability is

$ a_n/6^n = 6^(n-1)/6^n = 1/6. $

$qed$

]
#proof("Old")[
  Define $a_n,b_n,c_n,d_n,e_n,f_n$ as the number of rolls of length $n$ whose sum is  $(0 mod 6), (1 mod 6), (2 mod 6), (3 mod 6), (4 mod 6)$  and $(5 mod 6)$ respectively.

  Without loss of generality, note that $a_n$ can be built up from each residue class by adding some number $0<=i<=6$ to make it meet the requirements of the class. Hence,

  $a_n = a_(n-1)+b_(n-1)+c_(n-1)+d_(n-1)+e_(n-1)+f_(n-1)$

  But we know that the number of $a_n+b_n+c_n+d_n+e_n+f_n$ denotes the number of rolls of length $n$ whose sum belongs to any residue class of $6$. This essentially takes away the constraint, making 
  
  $ a_n = a_(n-1)+b_(n-1)+c_(n-1)+d_(n-1)+e_(n-1)+f_(n-1) = 6^(n-1) $

  Hence, the probability is 

  $ 6^(n-1)/6^n = 1/6 $

  $qed$.
]

#pagebreak()
= Question 4

Let $(cal(S), Pr)$ be a probability space and $(E_1, E_2, E_3, ...)$ be a countably infinite sequence of events.

Prove the union bound, i.e., 

$ Pr[union.big_(k=1)^(oo) E_k ] <= sum_(k=1)^(oo) Pr[E_k] $

#proof[

Note that from Claim 2, we can get 

$ Pr[union.big_(k=1)^(oo) E_k] &<= Pr[union.big_(k=1)^(oo) B_k] quad ("cardinality of subsets") \ 
&=sum_(k=1)^oo Pr[B_k] quad ("countable additivity by Claim 1") \
&<= sum_(k=1)^oo Pr[E_k] quad (B_k subset.eq E_k "for all k" in NN) $

which is what we desired. $qed$
]

#claim[
  $ union.big_(k=1)^(oo) E_k subset.eq union.big_(k=1)^(oo) B_k $
]

#proof[
Assume $x in union.big_(k=1)^(oo) E_k$. We can define $J = { j in NN | x in E_j }$. Because $J!=emptyset$ , it has a minimal element by well-ordering principle. We let $j = min(J)$.

By definition of $J$, $x in E_j$. By minimality, $x in E_j$ but is not in $E_i$ for all $i<j$. Hence, $x in B_i$, and consequently, $x in union.big_(k=1)^(oo) B_k$

Since $x$ was chosen arbitrarily, $union.big_(k=1)^(oo) E_k subset.eq union.big_(k=1)^(oo) B_k$. $qed$

]

#pagebreak()
#claim[
  For all $k in NN$,
$ B_k = E_k \\union.big_(i=1)^(k-1) E_i $
is pairwise disjoint.

]

#proof[
Define 

$ B_k = E_k \\union.big_(i=1)^(k-1) E_i $

We will define that all $B_k$ are pairwise disjoint. 

Let $B_i$ and $B_j$ for $i,j$ where $i<j$. Suppose for the sake of contradiction that $B_i inter B_j != emptyset $.

Then there exists a $x in B_i inter B_j$. Hence, $x in B_j$ which implies it cannot be in $E_i$ (because $i<j$). But $x in B_i$, implying $x in E_i$, a contradiction.

Since $x$ was chosen arbitrarily, we can conclude $B_i$ and $B_j$ are pairwise disjoint. $qed$
]

#pagebreak()

= Question 5

Consider choosing a function $f: [n]->[k]$ _uniformly randomly_.

Prove the probability that $f(i)!=i$ for every $i in [n]$ is at least $1-n/k$.

#proof[

For $i in [n]$, Let $E_i$ be the event that $f(i)=i$. 

We want the probability that $f(i)!=i$  for every $i in [n]$. That is: 

$ 
Pr[inter.big_(i=0)^(n-1) E_i^C ] &= 1 - Pr[(inter.big_(i=0)^(n-1) E_i^C)^C ] quad &("complementary counting") \
&= 1-Pr[union.big_(i=0)^(n-1) E_i] quad &("De Morgan's laws") \
&>= 1-sum_(i=0)^(n-1) Pr[E_i] quad &("union bound")
$

Note that the probability of $E_i$ occurring for all $i in [n]$ is $1/k$ because among all $k$ choices in the codomain, there can only be $1$ that matches with $i$.

Summing up the probabilities for all $0<=i<n$, we have

$ sum_(i=0)^(n-1) Pr[E_i] &= sum_(i=0)^(n-1) 1/k \
&= n/k.
$

Substituting to our equation, we get

$ Pr[inter.big_(i=0)^(n-1) E_i^C ] >= 1-n/k $

as desired.

$qed$

]

Does it still hold if $n>k$?

#proof[
  sure, trivially. but it doesn't make too much sense, am not gonna lie.
]

#pagebreak()

= Question 6 

For $n in NN$, consider picking a permutation of ${0,1,..., n-1}$ uniformly randomly. Let $p_n$ probability of picking a derangement, i.e. a permutation such that $a_i != i$ for every $i in [n]$.

Find a formula for $p_n$ using only known combinatoric expressions.

#proof[

  We claim
  
  $ sum_(k=0)^n (-1)^k/k!. $

  We can get $p_n$ by calculating the probability $q_n$ at least _one_ element is in the right position. That is

  $ p_n = 1-q_n $

  We can solve the possible outcomes at least one element is in the right position via principle of exclusion-inclusion. If there are $k$ fixed points, we can count the number of ways to form a sequence by first

  - choosing which numbers are fixed points; this is $binom(n,k)$
  - arranging the rest of the elements in any order, this is $(n-k)$!

  By rule of product, the number of ways to form a sequence given $k$ fixed points is $ binom(n,k) (n-k)! $

  By principle of exclusion-inclusion, we get 

   Meanwhile, there are a total of $n!$ permutations. Therefore, the probability is 

  $ 
  q_n &= 1/n! sum_(k=1)^n (-1)^(k+1)  binom(n,k) (n-k)! \
  &= sum_(k=1)^n (-1)^(k+1) /k!
  $


  Plugging to our equation for $p_n$:

  $ 
  p_n &= 1 -sum_(k=1)^n (-1)^(k+1) /k! \
  &= 1+ sum_(k=1)^n (-1)^k/k! quad \
  &= sum_(k=0)^n (-1)^k/k! quad
  $

 

  $qed$
]

#pagebreak()
Show $ lim_(n->oo) p_n = 1/e $

#proof[
  
  Recall a result in calculus:

    $ sum_(k=0)^oo x^k/k! = e^x $

  Hence:

  $ sum_(k=0)^n (-1)^k/k! = e^(-1) = 1/e $

  $qed$.

]

#pagebreak()

= Question 7

Prove that there is no uniform probability space with sample space $NN$.

#proof("by Claude")[

  Suppose for contradiction that such a uniform probability space exists. That is, suppose there is a probability measure $P$ on $NN = {0,1,2,dots}$ such that

  $ P({n}) = c $

  for some constant $c$, for every $n in NN$.

  Since the singletons ${0}, {1}, {2}, dots$ are pairwise disjoint and their union is all of $NN$, countable additivity requires

  $ P(NN) = sum_(n=0)^infinity P({n}) = sum_(n=0)^infinity c $

  We consider the two possible cases for $c$.

  *Case 1: $c = 0$.* Then

  $ sum_(n=0)^infinity c = sum_(n=0)^infinity 0 = 0 eq.not 1 $

  *Case 2: $c > 0$.* Then summing a fixed positive constant infinitely many times diverges:

  $ sum_(n=0)^infinity c = infinity eq.not 1 $

  Since $c >= 0$ (probabilities are nonnegative), these are the only two cases, and in both, $P(NN) eq.not 1$. This contradicts the axiom that $P(NN) = 1$.

  Therefore, no uniform probability measure on $NN$ exists.

  $qed$
]

= Question 8

#proof("by Claude")[

  Fix any $i, j in {0,1,dots,n-1}$. We show $P(text("result")=i) = P(text("result")=j)$.

  Let $sigma$ be the permutation of ${0,1,dots,n-1}$ that swaps $i$ and $j$ and fixes every other element. For a $k$-combination $S subset.eq {0,dots,n-1}$, let $sigma(S) = {sigma(x) : x in S}$, which is also a $k$-combination.

  Since $sigma$ is a bijection on ${0,dots,n-1}$, the map $S |-> sigma(S)$ is a bijection on the set of $k$-combinations of ${0,dots,n-1}$. As $S$ is chosen uniformly at random from all $binom(n,k)$ such combinations, it follows that $sigma(S)$ is *also* uniformly distributed over all $k$-combinations — relabeling by $sigma$ does not change the distribution of the random combination.

  Likewise, if $X$ is chosen uniformly at random from $S$, then $sigma(X)$ is uniformly distributed over $sigma(S)$.

  Therefore, applying $sigma$ to every step of the process yields a process statistically identical to the original: the pair $(sigma(S), sigma(X))$ has the same joint distribution as $(S,X)$.

  In particular,

  $ P(X = i) = P(sigma(X) = sigma(i)) = P(sigma(X) = j) = P(X=j) $

  where the first equality holds because $sigma(X)$ has the same distribution as $X$, and the last equality holds because $(sigma(S),sigma(X))$ is distributed identically to $(S,X)$.

  Since $i,j$ were arbitrary, $P(X=i)$ is the same value $p$ for every $i in {0,dots,n-1}$. As the result $X$ must be some element of ${0,dots,n-1}$,

  $ sum_(i=0)^(n-1) P(X=i) = n dot p = 1 $

  so $p = 1/n$. That is, $P(X=i) = 1/n$ for every $i in {0,1,dots,n-1}$.

  $qed$
]