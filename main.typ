// =============================================================================
// Example TD document
// =============================================================================
// Compile with: typst compile main.typ
// Watch mode:   typst watch main.typ

#import "src/lib.typ": *

#show: td.with(
  title: "Introduction à Typst",
  subtitle: "TD 1 - Prise en main",
  course: "EPITA",
  term: "APPING2 S7",
  authors: ("Hugo Sibony",),
  group: "C1",
  logo: image("images/epita-logo.png", width: 6cm),
  confidentiality: "TLP:AMBER",
)

= Introduction

Ce document présente les fonctionnalités du template *epita-td* pour Typst.
L'objectif est de fournir une alternative moderne à LaTeX pour la rédaction
de travaux dirigés.

== Objectifs du TD

#requirement[
  - Comprendre la syntaxe de base de Typst
  - Utiliser les différentes boîtes sémantiques
  - Créer des graphiques et schémas
  - Intégrer des images et figures
]

= Exercices

== Questions de cours

#question[
  Qu'est-ce que Typst et en quoi diffère-t-il de LaTeX ?
]

#response[
  Typst est un système de composition de documents moderne qui offre :
  - Une syntaxe plus simple et intuitive
  - Une compilation quasi-instantanée
  - Un langage de programmation intégré
  - Une gestion native des erreurs lisible
]

#question[
  Comment créer une liste numérotée en Typst ?
]

#response[
  On utilise le préfixe `+` pour les listes numérotées :

  ```typst
  + Premier élément
  + Deuxième élément
  + Troisième élément
  ```

  + Premier élément
  + Deuxième élément
  + Troisième élément
]

== Exercice pratique

#question[
  Écrivez une commande Typst pour afficher "Hello, World!" en gras et en bleu.
]

#cmd[
  ```typst
  #text(fill: blue, weight: "bold")[Hello, World!]
  ```
]

#result[
  #text(fill: blue, weight: "bold")[Hello, World!]
]

= Tableaux et données

#question[
  Créez un tableau présentant les opérateurs mathématiques de base.
]

#response[
  #figure(
    table(
      columns: (auto, auto, auto),
      inset: 8pt,
      align: center,
      table.header(
        [*Opération*], [*Symbole*], [*Exemple*],
      ),
      [Addition], [$+$], [$2 + 3 = 5$],
      [Soustraction], [$-$], [$5 - 2 = 3$],
      [Multiplication], [$times$], [$4 times 3 = 12$],
      [Division], [$div$], [$12 div 4 = 3$],
      [Puissance], [$a^n$], [$2^3 = 8$],
    ),
    caption: [Opérations mathématiques de base],
  )
]

= Mathématiques

#question[
  Écrivez la formule quadratique et l'intégrale de Gauss.
]

#response[
  *Formule quadratique :*
  $ x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a) $

  *Intégrale de Gauss :*
  $ integral_(-infinity)^(+infinity) e^(-x^2) dif x = sqrt(pi) $

  *Série de Taylor :*
  $ e^x = sum_(n=0)^(infinity) x^n / n! $
]

= Figures et images

#question[
  Comment intégrer et référencer une image ?
]

#response[
  Utiliser `figure()` avec un label pour référencer :

  ```typst
  #figure(
    image("images/epita-logo.png", width: 4cm),
    caption: [Logo EPITA],
  ) <fig:logo>

  Voir @fig:logo pour le logo.
  ```
]

#figure(
  image("images/epita-logo.png", width: 4cm),
  caption: [Logo EPITA],
) <fig:logo>

Comme montré dans la @fig:logo, les images s'intègrent facilement.

= Diagrammes avec CeTZ

#info[
  CeTZ est la bibliothèque de dessin officielle de Typst.
  Import : `#import "@preview/cetz:0.3.4"`
]

#question[
  Dessinez un graphique simple avec des axes.
]

#response[
  Voici un exemple de graphique avec CeTZ :
]

#import "@preview/cetz:0.3.4": canvas, draw

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Axes
    set-style(stroke: (paint: black, thickness: 0.5pt))
    line((-0.5, 0), (6, 0), mark: (end: "stealth"))
    line((0, -0.5), (0, 4), mark: (end: "stealth"))

    // Labels
    content((6.3, 0), $x$)
    content((0, 4.3), $y$)
    content((-0.3, -0.3), $O$)

    // Points and curve
    set-style(stroke: (paint: blue, thickness: 1pt))
    let points = ((0, 0), (1, 1), (2, 1.5), (3, 2.5), (4, 3), (5, 3.2))
    for (i, p) in points.enumerate() {
      circle(p, radius: 0.08, fill: blue)
      if i > 0 {
        line(points.at(i - 1), p)
      }
    }

    // Grid
    set-style(stroke: (paint: luma(200), thickness: 0.3pt))
    for x in range(1, 6) {
      line((x, 0), (x, 3.5))
      content((x, -0.4), text(size: 8pt)[#x])
    }
    for y in range(1, 4) {
      line((0, y), (5.5, y))
      content((-0.4, y), text(size: 8pt)[#y])
    }
  }),
  caption: [Graphique de données],
)

= Schémas et diagrammes

#question[
  Créez un schéma d'architecture simple.
]

#response[
  Voici un diagramme de flux :
]

#figure(
  canvas(length: 1cm, {
    import draw: *

    // Box style
    let box(pos, label, color: blue) = {
      rect(
        (pos.at(0) - 1.2, pos.at(1) - 0.4),
        (pos.at(0) + 1.2, pos.at(1) + 0.4),
        fill: color.lighten(80%),
        stroke: color,
        radius: 4pt,
      )
      content(pos, text(size: 9pt, weight: "bold")[#label])
    }

    // Boxes
    box((0, 3), "Client", color: blue)
    box((0, 1.5), "API", color: green)
    box((-2.5, 0), "Base de\ndonnées", color: orange)
    box((2.5, 0), "Cache", color: purple)

    // Arrows
    set-style(stroke: (paint: gray, thickness: 0.8pt))
    line((0, 2.6), (0, 1.9), mark: (end: "stealth"))
    line((-0.8, 1.1), (-2, 0.4), mark: (end: "stealth"))
    line((0.8, 1.1), (2, 0.4), mark: (end: "stealth"))

    // Labels
    content((0.4, 2.2), text(size: 7pt)[HTTP])
    content((-1.8, 0.9), text(size: 7pt)[SQL])
    content((1.8, 0.9), text(size: 7pt)[Redis])
  }),
  caption: [Architecture d'une application web],
)

= Informations complémentaires

#tip[
  Utilisez `typst watch main.typ` pour recompiler automatiquement.
]

#important[
  N'oubliez pas de sauvegarder régulièrement votre travail !
]

#info[
  Documentation officielle : #link("https://typst.app/docs")[typst.app/docs]
]

#scope[
  L'évaluation portera sur :
  - La compréhension de la syntaxe Typst
  - La création de tableaux et figures
  - L'utilisation correcte des boîtes sémantiques
]

#example[
  Code Python avec coloration syntaxique :

  ```python
  def fibonacci(n: int) -> int:
      if n <= 1:
          return n
      return fibonacci(n - 1) + fibonacci(n - 2)

  # Usage
  for i in range(10):
      print(f"F({i}) = {fibonacci(i)}")
  ```
]

= Conclusion

Ce template fournit une base solide pour créer des documents TD professionnels.
Les fonctionnalités principales incluent :

- Boîtes sémantiques colorées
- Support mathématique complet
- Intégration de figures et images
- Diagrammes avec CeTZ
- Tableaux formatés

#align(center)[
  #v(1em)
  _Fin du TD 1_
]
