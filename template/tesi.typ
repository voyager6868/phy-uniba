#import "@preview/phy-uniba:0.1.0": *

#show: show-theorion

#let meta = yaml("metadati.yaml")

#show: tesi.with(
  autore: meta.autore.nome,
  matricola: meta.autore.matricola,
  titolo: meta.titolo,
  relatore: meta.relatore,
  correlatore: meta.correlatore,
  anno: meta.anno
)

#show: frontmatter
#include "Capitoli/indice.typ"

#show heading.where(level:1): it => {
  pagebreak(weak: true) 
  it
}

#include "Capitoli/dedica.typ"
#include "Capitoli/ringraziamenti.typ"

#show: mainmatter

#include "Capitoli/cap1.typ"

#include "Capitoli/cap2.typ"

#include "Capitoli/conclusioni.typ"

#show: appendix

#include "Capitoli/app1.typ"

