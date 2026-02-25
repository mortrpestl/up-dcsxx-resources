#import "@preview/itemize:0.1.2" as el
#set enum(numbering: "a. i.")
#set heading(numbering: "1.a.")
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
  #text(size: 20pt, weight: "bold")[CS 31 Question Frenzy]
  
  #v(0.3em)
  #text(size: 12pt)[Diogn Lei R. Mortera]

  #v(0.2em)
  #text(size: 8pt)[Typst template from Ieuan Vinluan; Some problems from Jay Teofilo's cheatsheet]

  #text(size: 8pt)[Problems from me, Patrick's "Intermediate Counting and Probability", Brualdi's "Introductory Combinatorics"]
  
  #line(length: 100%, stroke: 0.5pt)
]

= Grade School Math

+ How many $k$-sized subarrays are there in an $n$-element list?
+ How many proper divisors does $10^n$ have?
+ What is the smallest number with 20 factors?
+ How many 5-digit numbers are divisible by 3, 5, and 7?
+ Prove that the decimal expansion of a number is either terminating or repeating.
+ How many surjective functions are there of a function $f: A arrow B$ if $|A|=m$ and $|B|=n$?


= Crack the Codons

DNA is represented as a string over the alphabet ${A, T, C, G}$.
RNA is represented as a string over the alphabet ${A, U, C, G}$.
A codon is a sequence of three bases from ${A, U, C, G}$.
(The characters A, T, C, G, U are called bases.)

Among all possible codons, three do not encode amino acids; instead,
they serve as start or stop signals in the genetic sequence.

+ How many codons encode amino acids?

+ How many DNA strands of length 10 are there?

+ How many DNA strands of length 10 which have at least one of each base are there?

+ A point mutation changes one base in a DNA strand to a different base.
  How many distinct point mutations are possible for a DNA strand of length 10?

+ A $k$-frameshift mutation replaces a contiguous substring of length $k$
  in a DNA strand with a different substring of length $k$.
  How many distinct $4$-frameshift mutations are possible for a DNA strand of length 10?

+ Prove that the number of DNA strands of length $n$
  equals the number of RNA strands of length $n$.

In this problem we consider a variant of alien DNA called MKNA, where data is encoded by the number of occurences of the base. 

+ How many MKNA are there?
+ If at least 1 of each base was required, how many possible MKNA are there?

#pagebreak()

= Just Act Natural
We will do a bunch of things with the set below: 
    $ A ={1,2,dots.h, n} $
+ Calculate the number of subsets from $A$ where no two numbers in the subset are consecutive.
+ If a collection of subsets of $A$ has the property that each pair of subsets has at least one element in common, show that there are at most $2^(n-1)$ subsets in the collection. 
+ What is the minimal $n$ required such that there exists 2 disjoint nonempty subsets in $A$ have the same sum? How about 3?
+ Show that a pair in $A$ exists such that when you sum them together, they are divisible by $n$.

= Team Building

In a team of $n$ people:

+ How many ways can you create $n$ pairs, if $n$ is even? If $n$ is odd? Each person must belong to only one pair.
+ Prove that if each pair plays against one another, gaining a post at a win, there exists two teams with the same score. Assume no ties can occur.
+ How many ways are there to create final standings, if ties are allowed? (Hint: express as a recurrence relation)

For the following questions, let $n=10$:

+ If there are 3 cabin assignments, how many ways are there to assign a cabin assignments to the teams? 
+ The team is playing "The Boat Is Sinking", and were asked to group themselves into 3. How many possible groupings of 3 are there? Note that it only matters who is in each group; swapping the groups around doesn’t create a new arrangement.

= Geometry Dash
+ Show that a Venn Diagram made of circles for 4 categories is impossible.
+ Show that the maximal number of intersection points of $n$ lines is $ binom(n, 2)$ (hint: use recurrence relations)
+ Show that the maximal number of regions formed by $n$ lines is $binom(n,2)+n+1$ (hint: use recurrence relations)
+ Prove that in an equilateral triangle with 
  $ n^2+1 $ points, there exists two points whose distance is less than $1/n$.
+  In a unit square, 51 points are placed arbitarily. Prove that there is a circle of radius 1/7 that contains 3 of the points.
+ Find a one-to-one correspondence between the number of ways to triangulate a $n$-sided polygon (ways to dividing it into triangles) and ways to parenthesize an $n$-element list.

+ The line segments joining 10 points pairwise are arbitrarily colored red or blue. Prove that there must exist 3 points such that the 3 line segments joining them are all red, or four points such that the 6 line segments joining them are all blue.

#pagebreak()

= Rube Goldberg

+ Given the linear nonhomogeneous recurrence relation $ a_n  = 9 a_(n-1) - 29 a_(n-2) + 39 a_(n-3) - 18 a_(n-4) + F(n) $
  where $F(n)$ is some function of $n$.

  Determine the form of a particular solution if $F(n)$ is:
  + $F(n) = 1$
  + $F(n) = n 2^n$
  + $F(n) = (n-5) 2^n$
  + $F(n) = (n^2025-1) 2^n$
  + $F(n) = 3^n+2$
  + $F(n) = 4^(n-2) + 2$
  + $F(n) = n^2 2^n$

+ Say I had a string $ S = "'I love CS31, love it so much!'" $

  I then perform the following operation: Replace "love" in $S$ with $S$. For example, after 2 iterations, the string should now look like:

  #text(size : 6.5pt)['I I I I love CS31, love it so much! CS31, I love CS31, love it so much! it so much! CS31, I I love CS31, love it so much! CS31, I love CS31, love it so much! it so much! it so much! CS31, I I I love CS31, love it so much! CS31, I love CS31, love it so much! it so much! CS31, I I love CS31, love it so much! CS31, I love CS31, love it so much! it so much! it so much! it so much!']

  Can you count instead for $n$ iterations how many $I$s are in the resulting $S$?


= Generation Failure
+ Express the following sequences as generating functions:

$ {1, -1, 2, -2, 3, -3, dots.h} $
$ {1, 2, 2, 3, 3, 3, dots.h} $
$ {1, 4, binom(5, 2), binom(6, 3), binom(7, 4), dots.h} $
$ {1^k, 2^k, 3^k, dots.h} $
$ {1,1,2,3,5,8, dots.h} $

+ Express the following combinatorial problems using generating functions:
  + ways to assign $n$ candies to $m$ children where the $k$-th child wants to have a multiple of $k$ amount of candies 
  + ways to partition a number $n$ using only even numbers
  + ways to put $2, 3, 5, 7, 11$ peso coins in a vending machine (if order of putting in matters)

+ Derive a formula for the following using generating functions:
$ sum_(k=0)^n k^m binom(n, k) $ 
