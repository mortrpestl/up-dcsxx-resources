
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

  Since there are $n!$ such permutations of $[1,2,...,n]$, any algorithm going through  the list of permutations must run in $Theta(1) dot Omega(n^2) = Omega(n^2)$ time. $qed$
]

== Linear search 

#gb[
  *Proof.*

  Note that in linear search, the worst case scenario scenario is when the element is not in the list. Here, it iterates through the $n$ elements and returns $-1$.
  

  Note that comparison and return takes $Theta(1)$. 

  Hence, the worst case scenario runs in  $ n dot Theta(1) + Theta(1) = Theta(n)+Theta(1)=Theta(n) $ time.

  From this, we can also state that linear search is $bigO(n)$ and $bigOm(n)$.

  The most appropriate statement is that "the worst-case complexity is $Theta(n)$". The other two only give upper and lower bounds respectively. Meanwhile, $Theta$ gives you a smaller range of functions, allowing for better analysis, especially when combined with other operations.
  
  $qed$
]

== Find the time complexity of the memoized $sans("path_count")$ algorithm.


#gb()[ 
  *Proof.* 

  Note that $sans("path_count")$ involves initializing a grid of $n^2$ elements. This places a lower bound of at least $n^2 dot Theta(1)= Omega(n^2)$ time for the algorithm.

  Then, $sans("path_count")$ calls $sans("count_from")(0,0)$ which runs in $bigO(n^2)$ by Lemma 1.

  Now, we claim that

  #boxed[
    *Lemma 1.* The function $sans("count_from")$ runs in $bigO(n^2)$ time.
  ]

  #boxed(centered: false)[ 
    *Proof.*

    We do structural induction on $i+j$, the sum of the parameters of $sans("count_from")$, by noting that the sum of parameters strictly increases after every step.

    _Base case:_ If $(i,j)$ is out of bounds, then the function  returns $0$ in $Theta(1)$. If $(i,j) = (n-1,n-1)$, then it has reached the end destination and thus returns $1$ in $Theta(1)$.

    _Inductive case:_ Recall that our unmemoized function is
    
    $ sans("count_from")(i,j) = sans("count_from")(i+1,j) + sans("count_from")(i,j+1) + Theta(1) $

    But from our inductive hypothesis, function calls with parameter sum greater than $i+j$ have been already been memoized. In other words, $sans("done")[i][j+1]$ and $sans("done")[i+1][j]$ have already been computed and only have to be looked up in $Theta(1)$. More formally:

    $ sans("count_from")(i,j) = Theta(1) + Theta(1) +Theta(1) = 3 dot Theta(1) =Theta(1) $

    Since there are $n^2$ pairs for $(i,j)$, we have at most $n^2 dot Theta(1) = bigO(n^2)$ operations from $sans("count_from")$.

  ]

  Since $sans("path_count") = bigOm(n^2) + "time complexity of" sans("count_from(0,0)") = bigOm(n^2)+bigO(n^2)$, we can conclude that $sans("path_count") = Theta(n^2)$.

  $qed$.
]

== $z(s)$
== $sans("lorem_absum")(s)$
== $sans("foo")(n)$
== $sans("min_seq(seq)")$


== Recursive madness or some shi

