// =============================================================================
// EPITA TD TEMPLATE - Main library
// =============================================================================
//
// A modern template for French educational documents (TD, TP, exams).
//
// USAGE:
//   #import "src/lib.typ": *
//   #show: td.with(title: "Mon TD", course: "Algo")
//
// WHAT'S EXPORTED:
//   - td()          : Main document template
//   - colors        : Color definitions (see colors.typ)
//   - question()    : Auto-numbered question box
//   - response()    : Answer box
//   - cmd()         : Command box
//   - important()   : Warning box
//   - tip()         : Tip box
//   - info()        : Info box
//   - requirement() : Prerequisites box
//   - result()      : Result box
//   - scope()       : Scope box
//   - example()     : Example box
//   - ... and more (see components/boxes.typ)
//
// =============================================================================

// Re-export colors
#import "colors.typ": colors, catppuccin, box-colors

// Re-export all boxes
#import "components/boxes.typ": *

// Import titlepage
#import "components/titlepage.typ": make-titlepage

// =============================================================================
// MAIN TEMPLATE
// =============================================================================

/// Main document template
///
/// Parameters:
/// - title        : Document title (required)
/// - subtitle     : Optional subtitle
/// - course       : Course name (default: "EPITA")
/// - term         : Academic term (e.g., "S7")
/// - authors      : List of author names
/// - group        : Group identifier (e.g., "C1")
/// - date         : Document date (default: today)
/// - logo         : Logo content (use `image("path")`) or path string
/// - confidentiality : e.g., "TLP:AMBER"
/// - header-left  : Left header (default: course)
/// - header-right : Right header (default: date)
/// - lang         : Document language (default: "fr")
#let td(
  title: "Document",
  subtitle: none,
  course: "EPITA",
  term: none,
  authors: (),
  group: none,
  date: datetime.today(),
  logo: none,
  confidentiality: none,
  header-left: auto,
  header-right: auto,
  lang: "fr",
  body,
) = {
  // ---------------------------------------------------------------------------
  // HEADER DEFAULTS
  // ---------------------------------------------------------------------------
  let header-l = if header-left == auto { course } else { header-left }
  let header-r = if header-right == auto {
    if type(date) == datetime {
      date.display("[day]/[month]/[year]")
    } else { date }
  } else { header-right }

  // ---------------------------------------------------------------------------
  // DOCUMENT METADATA
  // ---------------------------------------------------------------------------
  set document(title: title, author: authors, date: date)

  // ---------------------------------------------------------------------------
  // PAGE SETUP
  // ---------------------------------------------------------------------------
  set page(
    paper: "a4",
    margin: 2.5cm,
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          text(size: 0.9em, fill: luma(100))[#header-l],
          text(size: 0.9em, fill: luma(100))[#header-r],
        )
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + luma(200))
      }
    },
  )

  // ---------------------------------------------------------------------------
  // TYPOGRAPHY
  // ---------------------------------------------------------------------------
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: lang,
    fill: colors.text,
  )

  set par(justify: true, leading: 0.65em)

  // ---------------------------------------------------------------------------
  // HEADINGS
  // ---------------------------------------------------------------------------
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => block(breakable: false)[
    #v(0.8em)
    #text(size: 1.3em, weight: "bold", fill: colors.text)[#it]
    #v(0.4em)
  ]

  show heading.where(level: 2): it => block(breakable: false)[
    #v(0.6em)
    #text(size: 1.1em, weight: "bold", fill: colors.text)[#it]
    #v(0.3em)
  ]

  // ---------------------------------------------------------------------------
  // LINKS
  // ---------------------------------------------------------------------------
  show link: it => {
    set text(fill: colors.question)
    underline(it)
  }

  // ---------------------------------------------------------------------------
  // CODE BLOCKS
  // ---------------------------------------------------------------------------
  show raw: set text(font: "DejaVu Sans Mono", size: 0.85em)

  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(248),
    stroke: 0.5pt + luma(200),
    radius: 3pt,
    inset: 10pt,
    it
  )

  show raw.where(block: false): box.with(
    fill: luma(245),
    inset: (x: 4pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // ---------------------------------------------------------------------------
  // TITLE PAGE
  // ---------------------------------------------------------------------------
  // Logo can be content (image) or a path string
  let logo-content = if logo != none {
    if type(logo) == content { logo }
    else { image(logo, width: 6cm) }
  } else { none }

  make-titlepage(
    title: title,
    subtitle: subtitle,
    course: course,
    term: term,
    authors: authors,
    group: group,
    date: date,
    logo: logo-content,
    confidentiality: confidentiality,
  )

  counter(page).update(1)

  // ---------------------------------------------------------------------------
  // BODY
  // ---------------------------------------------------------------------------
  body
}
