#let bigOm = $cal(Omega)$
#let bigTh = $cal(Theta)$
#let bigO = $cal(O)$

#let gb(content) = rect(
  fill: rgb("#f0f0f0"),
  inset: 12pt,
  width: 100%
)[#content]

= DP 

#gb[

  *LCS* 

  $ 
  sans("dp")[i][j] = 
  cases(
  max(1+sans("dp")[i-1][j-1], sans("dp")[i][j-1], sans("dp")[i-1][j]) & "if" & sans("seq1")[i] = sans("seq2")[j],
  max(sans("dp")[i][j-1], sans("dp")[i-1][j])
  )
  $
]