#let title_ = "Physics 72 - DQ 3"

#import "@preview/ctheorems:1.1.3": *
#show: thmrules

#import "@preview/ctheorems:1.1.3": *
#show: thmrules.with(qed-symbol: $square$)

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

#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"), radius: 0em)
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em), radius: 0em)

#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmbox("proof", "Proof", fill: rgb("#f2f7e8"), radius: 0em).with(numbering: none)
#let claim = thmbox("claim", "Claim", fill: rgb("#e8e5f2"), radius: 0em)
#let question = thmbox("question", "Question", fill: rgb("#e8e5f2"), radius: 0em)


#set align(horizon)
#align(center)[
  #title(title_)
  Diogn Lei R. Mortera
]
#outline()

#pagebreak()


