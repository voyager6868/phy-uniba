#import "@preview/physica:0.9.8": *
#import "@preview/shadowed:0.4.0":*
#import "@preview/theorion:0.6.0": *
// #import cosmos.simple: *
//#import cosmos.fancy: *
// #import cosmos.rainbow: *
 #import cosmos.clouds: *

//++++++Definizioni Globali+++++++++++++++++//
//++++Colori UNIBA++++
#let uniba-blue = cmyk(100%, 60%, 0%, 45%)
//#let uniba-red = rgb("#d5102c")
#let uniba-red = cmyk(0%, 100%, 100%, 0%)
// blue alternativo
#let color-main = rgb("#12346c")

//++++default-fonts++++
#let uniba-font = "Trajan Pro"

//++++default font's size++++
#let cdim = (
  T: 2.4em,
  t1: 1.4em,
  t2: 1.3em,
  t3: 1.2em,
  t4: 1.1em,
)

//++++++rende trasparente un'immagine++++++
#let img-trsp(img) = box(
  clip: true,{
    img
    place(
      top+left,
      rect(
        width: 100%,
        height: 100%,
        fill: white.transparentize(15%)
      )
    )
  }
)
//++++++++++++++++++++++++++++++++++++++++++++//
//++++++Helper Functions+++++++++++++++++++++//

//++++setup footer++++
#let fgrid(flag) = context {
  set text(12pt)
  grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1em,
    inset: 0.5em,
    align: center + horizon,
    grid.hline(stroke: 0.8pt + uniba-blue),
    grid.cell(align: left, link("https://www.uniba.it/it", image("/src/assets/uniba.svg",width:55%))),
    "- "+counter(page).display(both: flag)+" -",
    grid.cell(align: right)[_Tesi di Laurea Triennale_],
  )
}
  //++++helper per setup header++++
#let head = context {
  let current_page = here().page()
  // Trova tutti i titoli di livello 1 nel documento
  let all_headings = query(heading.where(level: 1))
  // Filtra quelli che si trovano nella pagina corrente
  let titles_on_page = all_headings.filter(h => h.location().page() == current_page)
  let display_title = if titles_on_page.len() > 0 {
    // Se c'è un titolo nella pagina, usalo (il primo che appare)
    titles_on_page.first().body
    } else {
      // Altrimenti cerca l'ultimo titolo prima della pagina corrente
      let before = query(selector(heading.where(level: 1)).before(here()))
      if before.len() > 0 {
        before.last().body
      } else {
        []
      }
    }
  display_title
}
  //++++setup header++++
#let hgrid = context (
  {
    //set text(12pt)
    grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1em,
      inset: 0.5em,
      align: center + horizon,
      grid.cell(align: left, text(10pt, context document.title)),
      link("https://www.uniba.it/it/corsi/triennale-fisica/fisica", image("/src/assets/DIF1.png", width: 25%)),
      grid.cell(align: right, head),
      grid.hline(stroke: 0.8pt + uniba-blue),
    )
  }
)
//++++++++++++++++++++++++++++++++++++++++++//
//++++++modello++++++++++++++++++++++++++++//

#let tesi(
  // Cover page info
  titolo: [Title of the Thesis],
  autore: none,
  matricola: none,
  relatore: none,
  correlatore: none,
  colore-pri: uniba-blue,
  colore-sec: uniba-red,
  anno: [2028 --- 2029],
  font-body: "Libertinus Serif",
  size-body: 12pt,
  font-heading: "Libertinus Sans",
  font-math: "Fira Math",
  ththeme: "simple", //simple o fancy
  body,
) = {
  // metadati pdf
  set document(
    title: titolo,
    author: autore,
    description: titolo,
    keywords: ("tesi", "laurea", "magistrale", "triennale","Fisica"),
  )
  
  //++++page setup++++
  //set page("a4")
  set page(
  paper: "a4",
  //numbering: "1/1",
  //header: hgrid,
  //footer: fgrid(both: true),
  )
  //++++setup paragrafo
  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.2em, all: true),
  )
  //++++setup testo++++
  set text(
    lang: "it",
    font: font-body,
    style: "normal",
    weight: "light",
    size: size-body,
  )

    //setup titoli
  set heading(numbering: "1.1.", supplement: "Indice")
  //*******Funzione stili Titoli************************//
  let unshift-prefix(prefix, content) = context {
    let title = grid(
      columns: (auto, 1fr),
      align: horizon + left,
      column-gutter: 4pt,
      inset: 4pt,
      grid.cell(
        x: 0,
        y: 0,
        //fill: colore.primario,
        text(colore-pri, prefix)
      ),
      par(leading: 0.4em, justify: true, first-line-indent: 0pt, text(colore-pri, content)),
      grid.vline(
        x: 0,
        position: end,
        stroke: colore-sec.darken(30%) + 1.0pt,
      ),
    )
  pad(left: -measure(prefix).width, title)
}
//++++++++++++++++++++++++++++
  show heading: it => {
    set block(above: 1em, below: 1em)
    if it.numbering != none {
      let num = numbering(it.numbering, ..counter(heading).at(it.location()))
      let prefix = num + h(4pt)
      unshift-prefix(prefix, it.body)
    } else {
      text(colore-pri, it)
    }
  }

    //font e dimensioni titoli
  show heading: it => text(font: font-heading, it)
  show heading.where(level: 1): it => text(size: cdim.t1, it)
  show heading.where(level: 2): it => text(size: cdim.t2, it)
  show heading.where(level: 3): it => text(size: cdim.t3, it)
  show heading.where(level: 4): it => text(size: cdim.t4, it)
  
  //nuovo capitolo inizia su nuova pagina
  show heading.where(level: 1): it => {
  if it.numbering != none {
    pagebreak(weak: true)
  }
  it
  //minitoc()
}
  // show links in dark blue
  show link: set text(fill: blue.darken(40%))

    // math numbering
  set math.equation(
    numbering: (..nums) => {
      let section = counter(heading).get().at(0)
      numbering("(1.1)", section, ..nums)
    },
  )

  // Resetta il contatore delle equazioni. figure e tabelle a ogni nuovo titolo di livello 1
  show heading.where(level: 1): it => {
    //pagebreak(weak: true)
    it
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
   // theofig-reset-counters(theofig-kinds)
  }
  //show math.equation: set text(14pt, font: "IBM Plex Math")
  show math.equation: set text(14pt)

  //figure numbering
  show figure: set figure(numbering: n => numbering("1.1", counter(heading).get().at(0), n))

 // Titoli tabella in grassetto
  show table.cell.where(y: 0): set text(weight: "bold")

  set table(
    fill: none,
    stroke: (x, y) => (
      bottom: if y > -1 {
        1.3pt + colore-pri
      },
      left: if x > 0 { (thickness: 0.5pt, dash: "dashed", paint: colore-pri) },
      top: if y == 0 { 1.3pt + colore-pri } else if y == 1 { 0.5pt + colore-pri } else {
        (thickness: 0.5pt, dash: "dashed")
      },
    ),
  )

//++++++++++++++++++++COVER+++++++++++++++++++++++++++++++++++++//  
  let cover = {
/// Loghi
  let unilogo = image("/src/assets/uniba.svg", width: 120%,)
  let diplogo = image("/src/assets/DIF.png", width: 70%,)
  let diplogo-grey = image("/src/assets/DIF2.png", width: 50%,)

  page(
    paper: "a4",
    margin: 0cm,
    numbering: none,
    header: none,
    footer: none, {
    // Logo grey
    place(
      center+bottom,
      dx: 25%,
      dy: -0%,
      //dipartiment-logo-grey,
      img-trsp(diplogo-grey)
    )
    // Colored bars
    place(
      left + top,
      rect(
        width: 1.2cm,
        height: 100%,
        fill: colore-pri,
      ),
    )
    // Content
    pad(
      left: 3cm,
      right: 2cm,
      top: 3cm,
      bottom: 3cm,
      {
        set text(size: 12pt,font: "Libertinus Serif",fill: colore-pri)
        grid(
          columns: 2,   
          gutter: 1em,
          align: horizon+center,
          grid.cell(
            align:left,
            unilogo
          ),
          grid.cell(
            align:right,
            diplogo
          ),
        )
        // Header info
        v(3em)
        align(center, {
          text(20pt,weight: "bold", upper[Corso di Laurea in Fisica])
          line(length: 70%, stroke: colore-pri)
          text(20pt,weight: "bold", upper[Tesi di Laurea Triennale])
          }
        )       
        // Title
        v(2cm)
        align(center,text(size: 20pt, weight: "bold",title()))
        v(2cm)
        // Author
        grid(
          columns: 1,
          gutter: 1em,
          text(16pt,[*Laureando:*]),
          text(14pt, autore),
          text(14pt,[Matricola: #matricola])
        )
        v(1em)
        text(14pt,
          grid(
            columns: (auto, auto),
            column-gutter: 0.8em,
            row-gutter: 0.7em,
            align: (left, left),
            [*Relatore:*], eval(relatore,mode:"markup"),
            [*Correlatore:*], eval(correlatore,mode:"markup"),
          )
        )
        v(1fr)
        text(14pt,upper([_Anno Accademico #eval(anno, mode: "markup")_]))
      },
    )
  }
)
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//  

  cover
  body
}

#let frontmatter(body) = {
  set page(
    numbering: "i",
    footer: fgrid(false),
    header: hgrid
  )
  set heading(
    numbering: none,
    outlined: false, 
  )

  body
}

#let mainmatter(body) = {
  set page(
    numbering: "1/1",
    footer: fgrid(true),
  )
  set heading(
    numbering: "1.",
    outlined: true
  )
  body
}

#let appendix(body) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)

  body
}

//*******MiniTOC**************************************//

#let minitoc() = context {
  let qui = here()
  let tutte-dopo = query(selector(heading).after(qui))
  let tutte-prima = query(selector(heading).before(qui))

  if tutte-prima.len() == 0 { return }
  let livello-padre = tutte-prima.last().level

  // Trova la prossima intestazione che interrompe la sezione (stesso livello o superiore)
  let next-int = tutte-dopo.find(it => it.level <= livello-padre)

  // Definiamo il selettore limitato
  let sel-lim = if next-int != none {
    // Solo tra qui e la prossima interruzione
    selector(heading)
      .after(qui)
      .and(
        selector(heading).before(inclusive: false, next-int.location()),
      )
  } else {
    // Se non c'è nulla dopo, prendi tutto ciò che resta
    selector(heading).after(qui)
  }

  // Verifichiamo se ci sono effettivamente sottosezioni
  let sottosezioni = query(sel-lim)

  if sottosezioni.len() > 0 {
    block(
      //      fill: luma(98%),
      inset: 12pt,
      radius: 4pt,
      width: 100%,
      //stroke: 0.5pt + luma(200),
      text(
        size: 0.9em,
        outline(
          title: none,
          target: sel-lim,
          indent: 1.5em,
          depth: 3,
        ),
      ),
    )
  }
}

//Riferimento di pagina della ref
#let pageref(label) = context {
  let loc = locate(label)
  let nums = counter(page).at(loc)
  [ Pagina~]+link(loc, numbering(loc.page-numbering(), ..nums))
}
//****************************************************//

//*****Pagina nuovo capitolo decorata con minitoc e introduzione******//
//logo dipartimento di fisica in basso a destra
#let logo-grey = place(
  center+bottom,
  dx: 25%,
  dy: -0%,
  img-trsp(
    image(
      "/src/assets/DIF3.png", 
      width: 50%,
    )
  )
)
//blocco testo in risalto con ombra
#let radius = (
  top-left: 0pt,
  top-right: 8pt,
  bottom-right: 0pt,
  bottom-left: 8pt,
)

#let shad1(body) = shadow(
  blur: 1pt,
  radius: radius,
  block(
    //width: 100pt,
    //height: 100pt,
    inset:12pt,
    fill: white,
    radius: radius,
    width: 80%,
    body
  )
)
//stile diverso di blocco testo con ombra
#let shad2(body) = shadow(
  blur: 8pt, 
  fill: rgb(89, 85, 101, 25%), 
  radius: 4pt,
  block(
    fill: white,
    radius: 4pt,
    inset: 12pt,
    width: 80%,
    body
  )
)
// introduzione
#let abstrat(body) = {
  minitoc()
  v(0.5fr)
  align(
    center,
    shad1(body)
  )
  v(1fr)
  logo-grey
  pagebreak(weak: true)
}