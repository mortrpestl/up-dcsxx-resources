#let title_ = "CS 32 - Problem Set 8"

#import "@preview/ctheorems:1.1.3": *
#show: thmrules

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

1.

length

#solution[

  For $0<=i,j,k<=n$, let $sans("dp")(i,j,k) :=$ the length of the longest increasing subsequence in $s_1[i:], s_2[j:],$ and $s_3[k:]$.

  Then

  $
    sans("dp")(i,j,k) = cases(
      1 + sans("dp")(i+1,j+1,k+1) "if" s_1[i] == s_2[j] == s_3[k],
      max(sans("dp")(i+1,j,k), sans("dp")(i,j+1,k), sans("dp")(i,j,k+1)) "otherwise"
    )
  $

  with out-of-bounds calls returning $-oo$.

  The logic of the recurrence is as follows: for every $(i,j,k)$, either the elements in those indices are equal. If so, we can add this to the subsequence. Otherwise, at least one of these characters are not part of the LCS, so we check each branch where that character is not part of the recurrence. 
  
  Our initial call will be $sans("dp")(0,0,0)$. Since the subproblems depend on higher $i,j,$ or $k$, the bottom-up DP solution must run in decreasing $i$, $j$, and $k$, and require $n dot n dot n = Theta(n^3)$ time complexity.

  The following function is a sample implementation. The function $sans("solve")$ gets 3 arrays $s_1, s_2, s_3$ and gets a longest common subsequence between the 3.
  
  ```
  func solve(s_1, s_2, s_3):

    n_1, n_2, n_3 = lengths of s_1, s_2, s_3
    dp = [ (n_1 + 1) x (n_2 + 1) x (n_3 + 1) array initialized with 0 ]

    for i from n_1-1 down to 0:
      for j from n_2-1 down to 0:
        for k from n_3-1 down to 0:

          if s_1[i] == s_2[j] == s_3[k]:
            dp[i][j][k] = 1 + dp[i+1][j+1][k+1]
          else:
            dp[i][j][k] = max(
              dp[i+1][j][k],
              dp[i][j+1][k],
              dp[i][j][k+1]
            )

    return dp[0][0][0]

  ```

  


  The space used can be reduced to three $n times 1$ arrays using a rolling array method like in Problem Set 7. Hence, the space complexity is $Theta(n)$.

]
Note that we only need to move forward an index in 1 word by the time, because multiple index skips are covered by a sequence of these individual index skips already.

1.1 Path 
#solution[
  We can traverse the $sans("dp")$ array from $(0,0,0)$ with the following algorithm:

  ```

  n1,n2,n3 := length of s1,s2,s3

  res = []

  while i < n1 and j < n2 and k < n3:

    if s1[i] == s2[j] == s3[k]:
      res.append( s1[i] )
      i+=1, j+=1, k+=1

    else: 
      take (i',j',k') in (dp[i+1][j][k],dp[i][j+1][k],dp[i][j][k+1]) that is maximum (break ties arbitrarily): 
        i,j,k = i',j',k'
  ```

]
2.
#proof[

]

3.
#proof[

]

4.
#proof[

]

5.
#proof[

]