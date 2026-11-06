#import "@preview/phy-uniba:0.1.0": *
= Capitolo

#lorem(50)

#theorem[Euclid's Theorem][
  There are infinitely many prime numbers.
] <thm:euclid>



== Sezione

#lorem(50)

=== sottosezione

#lorem(50)

==== sottosottosezione

#lorem(50)


== Tabella

#figure(
  caption: [tabella],
  table(
    columns: 4,
    align: center+horizon,
    [col1],[col2],[col3],[col4],
    [1],[2],[3],[4],
    [1],[2],[3],[4],
  )
)<tbl1>

Riferimento: @tbl1


== immagine

#figure(
  caption: [test],
  image("../assets/atomo.jpg",width: 40%)
)<img1>

Riferimento: @img1



== Equazione

esempio di equazione colorata:

#show math.equation: set text(fill: uniba-blue)

$ a x^2 + b x + c $   

$ lim_(z->z_0) (f(z)-f(z_0))/(z-z_0)= f'(z_0) $<ref1>

