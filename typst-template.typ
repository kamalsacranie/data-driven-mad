#import "@preview/fontawesome:0.4.0": *

#let article(
  title: none,
  title-font: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "linux libertine",
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: none, // if we want precise numbering, we can make this into a footer and parametarise it
    footer: move(dx: -45pt, dy: 4pt)[#rect(fill: aqua)[#text(size: 9pt)[Made with Typst and love using my data driven CV library.]]],
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  if title != none {
    align(center)[#block(inset: 2em)[
      // = #title
      #if title-font != none {
        text(weight: "bold", size: 1.5em, font: title-font)[#title]
      } else {
        text(weight: "bold", size: 1.5em)[#title]
      }
    ]]
  }

  if authors.len() == 1 {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #heading[#author.name]
            // #author.affiliation \
            // we should make this conditional
            #fa-at(size: 0.7em) #author.email
            #fa-github(size: 0.8em) #link("http://github.com/" + author.github.text)[#author.github.text]
          ]
      )
    )
  } else {
    panic("Only one author is supported for the CV template")
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)
