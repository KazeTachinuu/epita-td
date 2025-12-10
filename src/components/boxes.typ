// =============================================================================
// BOXES - Semantic content boxes
// =============================================================================
//
// Provides styled boxes for different content types:
// - question / question-num  : Numbered question boxes
// - response / response-inline : Answer boxes
// - cmd                      : Terminal/command boxes
// - important, tip, info     : Callout boxes
// - requirement, result      : Status boxes
// - scope, example           : Context boxes
//
// CUSTOMIZATION:
// - Edit `icons` to change box icons
// - Edit individual box functions to change titles
// - See colors.typ to change box colors
// =============================================================================

#import "../colors.typ": colors, box-colors

// -----------------------------------------------------------------------------
// ICONS
// -----------------------------------------------------------------------------
// Change these to customize the icon shown in each box title.

#let icons = (
  question:    sym.quest,
  response:    sym.checkmark,
  command:     sym.triangle.r.small,
  important:   sym.excl,
  tip:         sym.star,
  requirement: sym.arrow.r,
  result:      sym.checkmark,
  scope:       sym.circle.stroked.small,
  info:        "i",
  example:     sym.diamond.stroked.small,
)

// -----------------------------------------------------------------------------
// QUESTION COUNTER
// -----------------------------------------------------------------------------

#let question-counter = counter("question")

// -----------------------------------------------------------------------------
// CORE BOX BUILDER
// -----------------------------------------------------------------------------
// All boxes use this function. Edit here to change global box appearance.

#let styled-box(
  color: colors.question,
  title: none,
  icon: none,
  breakable: false,
  body,
) = {
  let scheme = box-colors(color)

  block(
    width: 100%,
    above: 0.6em,
    below: 0.6em,
    breakable: breakable,
    stroke: (paint: scheme.border, thickness: 0.8pt),
    radius: 3pt,
    clip: true,
    grid(
      columns: (100%,),
      rows: auto,
      gutter: 0pt,
      // Title bar
      if title != none {
        block(
          width: 100%,
          fill: scheme.title-bg,
          inset: (x: 10pt, y: 6pt),
          below: 0pt,
          {
            set text(weight: "bold", size: 0.95em)
            if icon != none { [#icon ] }
            title
          }
        )
      },
      // Content
      block(
        width: 100%,
        fill: scheme.bg,
        inset: 10pt,
        above: 0pt,
        body
      )
    )
  )
}

// -----------------------------------------------------------------------------
// QUESTION BOXES
// -----------------------------------------------------------------------------

/// Auto-numbered question box
/// Usage: #question[Your question here]
#let question(body) = {
  question-counter.step()
  context {
    let num = question-counter.get().first()
    styled-box(
      color: colors.question,
      title: [Question #num],
      icon: icons.question,
      body
    )
  }
}

/// Question with custom number
/// Usage: #question-num(5)[Question text]
#let question-num(num, body) = {
  styled-box(
    color: colors.question,
    title: [Question #num],
    icon: icons.question,
    body
  )
}

// -----------------------------------------------------------------------------
// RESPONSE BOXES
// -----------------------------------------------------------------------------

/// Response box with title
/// Usage: #response[Your answer]
#let response(body) = {
  styled-box(
    color: colors.response,
    title: [Réponse],
    icon: icons.response,
    body
  )
}

/// Response box without title
/// Usage: #response-inline[Brief answer]
#let response-inline(body) = {
  styled-box(color: colors.response, body)
}

// -----------------------------------------------------------------------------
// COMMAND BOX
// -----------------------------------------------------------------------------

/// Terminal/command box
/// Usage: #cmd[```bash\nyour command\n```]
#let cmd(body) = {
  styled-box(
    color: colors.command,
    title: [Commande],
    icon: icons.command,
    body
  )
}

// -----------------------------------------------------------------------------
// CALLOUT BOXES
// -----------------------------------------------------------------------------

/// Warning/important notice
#let important(body) = {
  styled-box(
    color: colors.warning,
    title: [Important],
    icon: icons.important,
    body
  )
}

/// Helpful tip
#let tip(body) = {
  styled-box(
    color: colors.response,
    title: [Astuce],
    icon: icons.tip,
    body
  )
}

/// Neutral information
#let info(body) = {
  styled-box(
    color: colors.metadata,
    title: [Information],
    icon: icons.info,
    body
  )
}

// -----------------------------------------------------------------------------
// STATUS BOXES
// -----------------------------------------------------------------------------

/// Prerequisites/requirements
#let requirement(body) = {
  styled-box(
    color: colors.requirement,
    title: [Prérequis],
    icon: icons.requirement,
    body
  )
}

/// Result/output display
#let result(body) = {
  styled-box(
    color: colors.response,
    title: [Résultat],
    icon: icons.result,
    body
  )
}

// -----------------------------------------------------------------------------
// CONTEXT BOXES
// -----------------------------------------------------------------------------

/// Scope/boundaries definition
#let scope(body) = {
  styled-box(
    color: colors.scope,
    title: [Périmètre],
    icon: icons.scope,
    body
  )
}

/// Example demonstration
#let example(body) = {
  styled-box(
    color: colors.timeline,
    title: [Exemple],
    icon: icons.example,
    body
  )
}

// -----------------------------------------------------------------------------
// UTILITIES
// -----------------------------------------------------------------------------

/// Simple colored box without header
#let colorbox(color: colors.question, body) = {
  styled-box(color: color, body)
}

// French shortcuts
#let que = question
#let res = response
