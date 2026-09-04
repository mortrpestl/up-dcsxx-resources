#import "@preview/itemize:0.1.2" as el
#set enum(numbering: "1.a.")
#set par(justify: true)
#set text(font: "New Computer Modern")
#let pmod-spacing = state("pmod-spacing", 2em/9)
#show math.equation.where(block: true): it => {
  pmod-spacing.update(2em/9)
  it
}
#show math.equation.where(block: false): it => {
  pmod-spacing.update(2em/9)
  it
}
#show math.equation.where(block: false): box
#let pmod(m) = context h(pmod-spacing.get()) + $(mod med #m)$
#show math.frac: math.display
#set page(paper: "a4", numbering: "1")

#align(center)[
  #text(size: 20pt, weight: "bold")[CS 31 Samplex]

  #text(size: 10pt, weight: "bold")[Long Exam 2]
  
  #v(0.3em)
  #text(size: 12pt)[Diogn Lei R. Mortera]

  #line(length: 100%, stroke: 0.5pt)
]
= New Questions 

+ 


= Old Questions 

+ What is the expected value of the maximum of 2 6-sided die?

+ Prove that the variance of $m$ $n$-sided die is
  $ m(n^2 - 1) / 12 $

+ What is the expected number of bins that remain empty when m balls are distributed into n bins uniformly at random?

+ Show that if X and Y are independent random variables, then 

  $ V(X Y) = E(X)^2 V(Y) + E(Y)^2 V(X) + V(X)V(Y) $