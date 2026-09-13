#let title_ = "CS 20 Probset 2 Code Snippets"

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

#let print_friendly = true  

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

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(languages: codly-languages)

#codly(
    smart-indent: false,
    number-format: none,
    display-icon: false,
    )

#set align(horizon)

#set text(size:7pt)

#outline()
#pagebreak()

= Question 3

== Code 
```py
import sympy as sp
from sympy import Matrix

raw = \
"""1	0	0	0	0	-1	0	-1	0	0	0	0	0
0	1	0	1	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	1	-1	0	0	1	0
0	0	0	0	0	0	0	0	0	-1	1	-1	0
0	0	0	0	-1	0	1	0	0	0	-1	0	0
-1	-1	1	0	0	0	0	0	0	0	0	0	0
0	0	-1	-1	0	1	-1	0	1	1	0	0	0
-20	0	-50	0	0	-50	0	0	0	0	0	0	0
0	10	50	0	0	0	0	0	0	0	0	0	-1
0	0	0	0	-10	0	-30	0	0	0	0	0	1
0	0	0	0	0	50	0	-10	0	0	0	0	-5
0	0	0	0	0	0	30	0	0	30	20	0	0
0	0	0	0	0	0	0	0	0	30	0	-10	-5
"""

def convert_string_to_matrix(raw):
    return [
        list(map(int, line.split()))
        for line in raw.strip().splitlines()
    ]

M = Matrix(convert_string_to_matrix(raw))

rref_matrix, pivot_cols = M.rref()
sp.pprint(rref_matrix)

A = M[:, :-1]
b = M[:, -1]

print("A shape:", A.shape)
print("rank(A):", A.rank())
print("nullity:", A.cols - A.rank())

print("rank([A|b]):", M.rank())

currents = []
for idx, val in enumerate(rref_matrix[:, -1],1):
    currents.append(val)
    print(f"I_{str(idx).zfill(2)} = {'%.4f'%float(val*1000)} mA")

print(currents)

resistor_values = {
    'A': 10,
    'B': 10,
    'C': 10,
    'D': 50,
    'E': 10,
    'F': 50,
    'G': 30,
    'H': 10,
    'I': 30,
    'J': 10,
    'K': 10,
    'L': 10,
}

resistor_map = {
    'A': 1,
    'B': 2,
    'C': 1,
    'D': 3,
    'E': 5,
    'F': 6,
    'G': 7,
    'H': 8,
    'I': 10,
    'J': 11,
    'K': 12,
    'L': 11,
}

for r, curr_idx in resistor_map.items():
    print(r, '%.4f'%float(abs(currents[curr_idx-1]*resistor_values[r])))
```

== Output

```
⎡1  0  0  0  0  0  0  0  0  0  0  0  3/22 ⎤
⎢                                         ⎥
⎢                                    -43  ⎥
⎢0  1  0  0  0  0  0  0  0  0  0  0  ──── ⎥
⎢                                    330  ⎥
⎢                                         ⎥
⎢0  0  1  0  0  0  0  0  0  0  0  0  1/165⎥
⎢                                         ⎥
⎢                                    1163 ⎥
⎢0  0  0  1  0  0  0  0  0  0  0  0  ──── ⎥
⎢                                    4620 ⎥
⎢                                         ⎥
⎢                                    -17  ⎥
⎢0  0  0  0  1  0  0  0  0  0  0  0  ──── ⎥
⎢                                    140  ⎥
⎢                                         ⎥
⎢0  0  0  0  0  1  0  0  0  0  0  0  -2/33⎥
⎢                                         ⎥
⎢0  0  0  0  0  0  1  0  0  0  0  0  1/140⎥
⎢                                         ⎥
⎢                                     13  ⎥
⎢0  0  0  0  0  0  0  1  0  0  0  0   ──  ⎥
⎢                                     66  ⎥
⎢                                         ⎥
⎢                                    1933 ⎥
⎢0  0  0  0  0  0  0  0  1  0  0  0  ──── ⎥
⎢                                    4620 ⎥
⎢                                         ⎥
⎢                                    -13  ⎥
⎢0  0  0  0  0  0  0  0  0  1  0  0  ──── ⎥
⎢                                    140  ⎥
⎢                                         ⎥
⎢0  0  0  0  0  0  0  0  0  0  1  0  9/70 ⎥
⎢                                         ⎥
⎢                                     31  ⎥
⎢0  0  0  0  0  0  0  0  0  0  0  1   ─── ⎥
⎢                                     140 ⎥
⎢                                         ⎥
⎣0  0  0  0  0  0  0  0  0  0  0  0    0  ⎦
A shape: (13, 12)
rank(A): 12
nullity: 0
rank([A|b]): 12
I_01 = 136.3636 mA
I_02 = -130.3030 mA
I_03 = 6.0606 mA
I_04 = 251.7316 mA
I_05 = -121.4286 mA
I_06 = -60.6061 mA
I_07 = 7.1429 mA
I_08 = 196.9697 mA
I_09 = 418.3983 mA
I_10 = -92.8571 mA
I_11 = 128.5714 mA
I_12 = 221.4286 mA
I_13 = 0.0000 mA
[3/22, -43/330, 1/165, 1163/4620, -17/140, -2/33, 1/140, 13/66, 1933/4620, -13/140, 9/70, 31/140, 0]
A 1.3636
B 1.3030
C 1.3636
D 0.3030
E 1.2143
F 3.0303
G 0.2143
H 1.9697
I 2.7857
J 1.2857
K 2.2143
L 1.2857
```


