// =============================================================================
// TITLE PAGE - Professional cover page
// =============================================================================
//
// Creates a clean, modern title page with:
// - Logo (optional)
// - Title and subtitle
// - Course and term info
// - Author/group metadata box
// - Confidentiality notice (optional)
//
// CUSTOMIZATION:
// - Edit spacing values (v(), margins) to adjust layout
// - Edit text sizes to change typography
// - Edit metadata box styling in the "Metadata Card" section
// =============================================================================

#import "../colors.typ": colors, box-colors

/// Generate the title page
#let make-titlepage(
  title: "Document Title",
  subtitle: none,
  course: "EPITA",
  term: none,
  authors: (),
  group: none,
  date: datetime.today(),
  logo: none,
  confidentiality: none,
) = {
  // -------------------------------------------------------------------------
  // PAGE SETUP
  // -------------------------------------------------------------------------
  set page(
    margin: (x: 2.5cm, y: 2cm),
    numbering: none,
  )
  set align(center)

  // -------------------------------------------------------------------------
  // LOGO
  // -------------------------------------------------------------------------
  if logo != none {
    logo
    v(1.5cm)
  }

  v(1fr)

  // -------------------------------------------------------------------------
  // TITLE
  // -------------------------------------------------------------------------
  text(size: 28pt, weight: "bold", fill: colors.text)[#title]

  // -------------------------------------------------------------------------
  // SUBTITLE
  // -------------------------------------------------------------------------
  if subtitle != none {
    v(0.4cm)
    text(size: 16pt, weight: "semibold", fill: colors.question)[#subtitle]
  }

  v(0.8cm)

  // -------------------------------------------------------------------------
  // COURSE & TERM
  // -------------------------------------------------------------------------
  {
    set text(size: 13pt, fill: luma(80))
    if term != none {
      [#course #sym.dot.c #term]
    } else {
      course
    }
  }

  v(2cm)

  // -------------------------------------------------------------------------
  // METADATA CARD
  // -------------------------------------------------------------------------
  // Clean card with author, group, and date info
  {
    let scheme = box-colors(colors.metadata)

    block(
      width: 70%,
      stroke: 1pt + scheme.border,
      radius: 6pt,
      fill: scheme.bg,
      inset: 16pt,
      {
        set align(left)
        set text(size: 11pt)

        // Authors row
        if authors.len() > 0 {
          grid(
            columns: (80pt, 1fr),
            gutter: 8pt,
            text(weight: "semibold", fill: luma(60))[Auteur(s)],
            text(fill: colors.text)[#authors.join(", ")],
          )
        }

        // Group row
        if group != none {
          v(8pt)
          grid(
            columns: (80pt, 1fr),
            gutter: 8pt,
            text(weight: "semibold", fill: luma(60))[Groupe],
            text(fill: colors.text)[#group],
          )
        }

        // Date row
        v(8pt)
        grid(
          columns: (80pt, 1fr),
          gutter: 8pt,
          text(weight: "semibold", fill: luma(60))[Date],
          text(fill: colors.text)[
            #if type(date) == datetime {
              date.display("[day]/[month]/[year]")
            } else {
              date
            }
          ],
        )
      }
    )
  }

  v(1fr)

  // -------------------------------------------------------------------------
  // CONFIDENTIALITY NOTICE
  // -------------------------------------------------------------------------
  if confidentiality != none {
    text(
      size: 9pt,
      fill: luma(140),
      weight: "medium",
      tracking: 1pt,
    )[#upper(confidentiality)]
    v(0.5cm)
  }

  pagebreak(weak: true)
}
