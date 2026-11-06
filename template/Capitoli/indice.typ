 //// Indice //////////////////////////////////////////////

//riduce l'indendazione dell'indice
#set outline(indent: n=> n*1em)

#outline(
  target: heading.where(supplement: [Indice]),
  title: [Indice],
  //indent: n => n*1em
)
#outline(
 target: heading.where(supplement: [Conclusioni]),
 title: [Conclusioni]
)
#outline(
  target: heading.where(supplement: [Appendice]),
  title: [Appendice]
)
#outline(
 target: figure.where(kind: image),
 title: [Elenco Immagini],
)
#outline(
  target: figure.where(kind: table),
  title: [Elenco Tabelle],
)


  
