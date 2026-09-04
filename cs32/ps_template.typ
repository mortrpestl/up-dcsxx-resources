
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


== Question
#gb()[
  *Proof.*

  ...
]