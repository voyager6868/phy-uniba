#import "@preview/phy-uniba:0.1.0": abstrat

= Capitolo

#abstrat(lorem(30))


== Equazione

$ lim_(z->z_0) (f(z)-f(z_0))/(z-z_0)= f'(z_0) $<ref2>

Riferimento: @ref2

== immagine

#figure(
  caption: [test],
  image("../assets/atomo.png",width: 50%),
)<img2>

#figure(
  caption: [test],
  image("../assets/mexican.png",width: 50%)
)<img3>


#grid(
columns: 2,
gutter: 1em,
align: center+horizon,
  figure(
  caption: [test],
  image("../assets/atomo.jpg",width: 70%),
),
  figure(
  caption: [test],
  image("../assets/mexican.png",width: 80%)
)
)

Riferimento: @img2


== tabella

#figure(
  caption: [tabella],
  table(
    columns: 4,
    align: center+horizon,
    [col1],[col2],[col3],[col4],
    [1],[2],[3],[4],
    [1],[2],[3],[4],
  )
)<tbl2>

Riferimento: @tbl2


#figure(
  caption: [tabella],
  table(
    columns: 4,
    align: center+horizon,
    [col1],[col2],[col3],[col4],
    [1],[2],[3],[4],
    [1],[2],[3],[4],
  )
)<tbl3>