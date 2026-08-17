# Fiche 03 — Refactoring de visuels & traduction de masse

> Deux chantiers « valeur » typiques d'un SI report : moderniser des rapports hérités et passer leurs libellés dans la langue des utilisateurs. Les deux sont volumineux à la main, et exactement ce qu'un skill exécute fidèlement — à condition d'une revue systématique.

## Objectifs

- Migrer les **visuels legacy** vers les types modernes (table de correspondance)
- **Re-thémériser** un rapport : appliquer une charte et nettoyer les couleurs inline
- **Traduire en masse** les libellés (titres, en-têtes, textboxes) d'un rapport anglais vers le français AltiSport
- Appliquer les garde-fous : baseline Git, validation par lot, captures, revue humaine

## Concepts

### Refactoring : la table de correspondance des visuels

Le skill `powerbi-report-authoring` **refuse de créer** les types legacy mais **migre** ceux déjà présents. Correspondance officielle :

| Legacy (déprécié) | Moderne à utiliser |
|---|---|
| `card` | `cardVisual` (une valeur, ou plusieurs valeurs dans une seule carte) |
| `multiRowCard` | `cardVisual` multi-valeurs |
| `table` | `tableEx` (voir ci-dessous) |
| `matrix` | `pivotTable` |
| `map` / `filledMap` | `azureMap` |

Pièges de migration courants (observés avec `powerbi-report-author validate`) :

- `card` → `cardVisual` : le rôle de données change de `Values`/`Fields` à **`Data`** ; une carte = une projection par valeur
- `table` → `tableEx` : les dimensions vont en **`Rows`** et les mesures en **`Values`** ; régler `columnHeaders.columnAdjustment = growToFit` pour éviter les colonnes resserrées
- Noms de rôles à vérifier avec `powerbi-report-author catalog describe <type>` — ne jamais les deviner

### Re-thémérisation : ne pas s'arrêter au changement de thème

Appliquer un nouveau thème **ne** balaie **pas** les couleurs codées en dur dans les visuels (formats `dataPoint.fill`, fonds de page, barres, boutons de navigation…). Le skill traite :

1. **Colonnes de données** : mapping couleurs thème (`dataColors`, `textClasses`)
2. **« Sweep » des hex inline** : recherche et remplacement des anciennes valeurs de couleur dans `definition/` pour un rendu cohérent
3. **Vérification du contraste** surtout en thème sombre (texte invisible sur fond sombre)

### Traduction de masse

Sans skill, traduire un rapport = éditer des dizaines de `visual.json`, `page.json` et textboxes. Avec le skill (prompt unique) :

- **`displayName`** des projections (titres de visuels, en-têtes de colonnes)
- **textboxes** (`paragraphs[].textRuns[].value`)
- **`displayName` des pages** (`page.json`) et titres de graphiques (VCO `title.text`)

Le skill applique la langue cible partout, en préservant la structure — c'est un **refactor de contenu**, pas un simple find/replace.

## Pas-à-pas — moderniser et traduire le rapport legacy

Prérequis : [setup/03](../../../setup/03-skills-copilot-cli.md) ; rapport **legacy** `altisport-rapport-legacy` ouvert en PBIP ; Desktop avec le PBIP ouvert.

### 1. Baseline

```bash
git add assets/modeles/altisport-rapport-legacy
git commit -m "assets : rapport legacy (état initial avant refactoring fiche 03)"
```

> Le commit est la **sauvegarde** : toute écriture agent est réversible par `git revert`.

### 2. Auditer le point de départ

```bash
powerbi-report-author validate altisport-rapport-legacy.Report
powerbi-report-author preview-visuals altisport-rapport-legacy.Report
```

Noter la liste des types : 2 `card`, 1 `table`, 1 `matrix`, 2 `clusteredColumnChart`, 1 `slicer`, 2 `textbox` — dont les 4 types legacy à migrer.

### 3. Migrer les visuels legacy

Prompt (mode agent) :

```
Migrate all deprecated visual types in altisport-rapport-legacy to their modern equivalents
(card → cardVisual, table → tableEx, matrix → pivotTable). Preserve data bindings and layout.
Validate after each batch, then reload and screenshot.
```

*Migre tous les types de visuels dépréciés du rapport legacy vers leurs équivalents modernes (card → cardVisual, table → tableEx, matrix → pivotTable). Préserve les liaisons de données et le layout. Valide après chaque lot, puis recharge et capture.*

Vérifier sur les captures : les visuels migrés affichent bien les données (une migration qui « réussit » mais laisse des colonnes vides est un échec).

### 4. Re-thémériser avec la charte AltiSport

Prompt (mode agent) :

```
Apply the AltiSport theme (assets/theme-charte.json) to the migrated report,
then sweep all remaining inline colors to match the theme. Run the dark-contrast check.
Validate, reload and screenshot.
```

*Applique le thème AltiSport (assets/theme-charte.json) au rapport migré puis balaie toutes les couleurs inline restantes pour correspondre au thème. Lance la vérification de contraste. Valide, recharge et capture.*

### 5. Traduire en masse EN → FR

Prompt (mode agent) :

```
Translate all report labels to French: page titles, visual titles, column headers and textboxes.
Keep DAX and field references unchanged. Validate, reload and screenshot.
```

*Traduis tous les libellés du rapport en français : titres de pages, titres de visuels, en-têtes de colonnes et textboxes. Ne modifie pas le DAX ni les références de champs. Valide, recharge et capture.*

Exemples de rendu attendu : « Sales Overview » → « Vue d'ensemble des ventes », « Total Sales » → « Total des ventes », « Sales by Region » → « Ventes par secteur », « Items Sold » → « Quantité vendue ».

## Limites et pièges

- **Baseline obligatoire** : sans commit initial, une session d'écriture peut être irréversible — c'est la règle #1 de ce fiche
- **Valider par lot** : `validate` après chaque lot logique (structure) + screenshot (rendu) — un lot qui casse le rendu se corrige avant la suite
- **Ne pas laisser « deviner » le JSON** : toute valeur de formatage, rôle ou énumération sort du CLI (`powerbi-report-author formatting describe-object`), pas de la mémoire de l'agent
- **Tableaux** : après migration `tableEx`, vérifier que les mesures apparaissent (dimensions en Rows, mesures en Values) — l'erreur classique « en-têtes visibles, données absentes »
- **Sweep des couleurs** : ne pas le limiter au `dataColors` du thème — balayer **tous** les anciens hex inline (barres, séparateurs, fonds de page, boutons), sinon le rapport reste « bicolore »
- **Ne pas traduire le modèle** : les libellés de champs viennent du modèle sémantique (module 04) ; ici on traduit la **couche rapport** uniquement

## Sources

- [Report Authoring skill — correspondance des visuels legacy → modernes](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-report-authoring-skill-overview)
- [References du skill (formatting, theaming, re-theaming)](https://github.com/microsoft/skills-for-fabric/tree/main/skills/powerbi-report-authoring/references)
- [Rapport legacy](../../../assets/modeles/altisport-rapport-legacy/) — terrain d'application (2 pages, 4 types legacy, libellés EN)
