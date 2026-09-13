#let title_ = "CS 31 Midyear Proofs"

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

#let print_friendly = false  

#let (example, proof, solution, claim, question) = if print_friendly {
  (
    thmplain("example", "Example").with(numbering: none),
    thmbox("proof", "Proof", stroke: 1pt + black, fill: none, radius: 0em).with(numbering: none),
    thmbox("solution", "Solution", stroke: 1pt + black, fill: none, radius: 0em).with(numbering: none),
    thmbox("claim", "Claim", stroke: 1pt + black, fill: none, radius: 0em, base_level: 0),
    thmbox("question", "Question", stroke: 1pt + black, fill: none, radius: 0em, base_level: 0),
  )
} else {
  (
    thmplain("example", "Example").with(numbering: none),
    thmbox("proof", "Proof", fill: rgb("#f2f7e8"), radius: 0em).with(numbering: none),
    thmbox("solution", "Solution", fill: rgb("#f2f7e8"), radius: 0em).with(numbering: none),
    thmbox("claim", "Claim", fill: rgb("#e8e5f2"), radius: 0em, base_level: 0),
    thmbox("question", "Question", fill: rgb("#e8e5f2"), radius: 0em, base_level: 0),
  )
}


#let highlight(body) = align(center)[#box(stroke: 0.5pt, inset: 6pt)[#body]]

#let pd(f,x) = $(partial #f) / (partial #x)$
#align(center)[
  #title(title_)
  Diogn Lei R. Mortera
]

#set align(horizon)

#question[
  Prove that for any sets $S_0$ and $S_1$ such that $S_0 approx S_1$ (even infinite!), $!S_0 approx !S_1$.
]
#proof[
  Let $f : S_0 -> S_1$ be a bijection. For any permutation $phi : S_0 -> S_0$, we can define its set of non-fixed points as:
  
  $ theta(phi) = {a in S_0 | phi(a) != a} $
  
  We can define $g : !S_0 -> !S_1$ wherein 

  $ g(phi) = f compose phi compose f^(-1) $ 

  Note that $g$ is bijective because $f$ and $phi$ are bijective. We just need to verify $g$ is a derangement.




  Take any $b in S_1$. Since $f$ is sa bijection, $ b = f(a)$ for some unique $a in S_0$. Then

  $ g(phi)(b) = f(phi(f^(-1)(b))) = f(phi(a)) $

  Since $phi$ is a derangement of $a$, $phi(a)!= a$. Since f is injective, $f(phi(a))!=f(a)=b$. So $g(phi)(b)!=b$. As $b$ was arbitrary, $g(phi)$ is a derangement of $S_1$, hence $g(phi) in !S_1$.

  $qed$.

]

#question[
  Prove that for any sets $S_0$ and $S_1$ such that $S_0 approx S_1$ (even infinite!), $!S_0 approx !S_1$.
]
#proof("AI")[
  Let $f : S_0 -> S_1$ be a bijection. Define $g : !S_0 -> !S_1$ by
  $ g(phi) = f compose phi compose f^(-1). $

  *$g$ is well-defined.* For $phi in !S_0$, $g(phi) = f compose phi compose f^(-1)$ is a composition of bijections $S_1 -> S_0 -> S_0 -> S_1$, hence itself a bijection (permutation) of $S_1$. We check it has no fixed points: take any $b in S_1$. Since $f$ is a bijection, $b = f(a)$ for some unique $a in S_0$. Then
  $ g(phi)(b) = f(phi(f^(-1)(b))) = f(phi(a)). $
  Since $phi in !S_0$ is a derangement of $S_0$, $phi(a) != a$. Since $f$ is injective, $f(phi(a)) != f(a) = b$. So $g(phi)(b) != b$. As $b$ was arbitrary, $g(phi)$ has no fixed points, i.e. $g(phi) in !S_1$.

  *$g$ is injective.* Suppose $g(phi_1) = g(phi_2)$, i.e. $f compose phi_1 compose f^(-1) = f compose phi_2 compose f^(-1)$. Composing on the left by $f^(-1)$ and on the right by $f$ gives $phi_1 = phi_2$.

  *$g$ is surjective.* Let $psi in !S_1$, and set $phi := f^(-1) compose psi compose f$. By the same well-definedness argument as above (with $f^(-1)$ in place of $f$), $phi in !S_0$. Then
  $ g(phi) = f compose (f^(-1) compose psi compose f) compose f^(-1) = psi, $
  using $f compose f^(-1) = "id"_(S_1)$ and $f^(-1) compose f = "id"_(S_0)$. So $psi$ has a preimage under $g$.

  Hence $g$ is a bijection, so $!S_0 approx !S_1$.
  $qed$
]

#pagebreak()

#question[ 
  
]
#proof[

]