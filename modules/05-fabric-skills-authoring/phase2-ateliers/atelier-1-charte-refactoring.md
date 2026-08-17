# Atelier 1 — Charte & refactoring sur un rapport réel du client

## Objectif

Prendre un **rapport réel du client** (PBIP) avec sa **charte/matériel PowerPoint**, et le faire passer de l'existant à un rapport **thématisé + modernisé**, piloté par les skills — la même recette que les fiches 02 et 03, sur la vraie matière.

## Durée

~3 h (en binôme formateur / équipe, 4-6 personnes par rapport choisi).

## Étape 0 — Cadrage et baseline (20 min)

1. Choisir **un** rapport réel représentatif (2-4 pages, quelques types de visuels, trafic réel)
2. Le mettre au format **PBIP** dans le dépôt client (ou le créer si absent)
3. **`git commit` de l'état initial** (baseline obligatoire)
4. Inventorier avec `powerbi-report-author preview-visuals` (types présents, dont legacy)

## Étape 1 — Extraire la charte client (40 min)

1. Récupérer le **PowerPoint/maquettes** du client (slides de charte : couleurs, logo, typo)
2. Coller des captures dans le chat : l'agent en déduit tone, palette, style → proposer un **brief de design** pour ce rapport
3. Si la charte existe déjà en theme JSON, la fournir ; sinon faire produire (et faire valider) le fichier theme JSON par le skill à partir de la charte
4. **Revue humaine du brief** : valider les choix de couleurs et d'archetypes AVANT toute écriture

## Étape 2 — Re-thémérisation (50 min)

1. Appliquer le thème au rapport réel (`customTheme` + `StaticResources/RegisteredResources/`)
2. Sweep des couleurs inline pour coller à la charte (attention aux hex codés en dur)
3. **Validate → Reload → Screenshot** par lot ; vérifier contraste et cohérence sur les captures
4. Faire valider le rendu par l'équipe (les couleurs d'une charte sont un sujet métier, pas technique)

## Étape 3 — Refactoring des visuels legacy (40 min)

1. Identifier les types legacy du rapport (table officielle : `card`, `multiRowCard`, `table`, `matrix`, `map`)
2. Migrer vers les types modernes (`cardVisual`, `tableEx`, `pivotTable`, `azureMap`) en préservant liaisons et layout
3. Vérifier les points de vigilance (mesures dans `Values` des tableaux, grow-to-fit, rôles via `catalog describe`)
4. **Validate → Reload → Screenshot** ; contrôle des données visibles sur chaque visuel migré

## Étape 4 — Bilan et suite (30 min)

- Comparer avant/après (captures + diff Git)
- Après mitigation : peut-on faire tourner ce flux en pilotage par l'équipe ?
- Consigner ce qui n'est pas automatisable (validation métier, choix de charte non décidés)

## Livrables

- Rapport re-thématisé **et** modernisé (PBIP committé, captures avant/après)
- Fichier theme JSON du client (si pas déjà fourni) conservé dans le dépôt
- Liste des visuels legacy restants et des prochaines migrations

## Critères de succès

- Toutes les pages rendues avec la charte, **aucun** visuel legacy restant sur le rapport traité
- Validation `powerbi-report-author validate` propre avant chaque screenshot
- Baseline + commits intermédiaires visibles dans le dépôt

## Antidotes aux dérives d'atelier

| Dérive | Antidote |
|---|---|
| L'agent « en fait trop » (refactor global non demandé) | Compter les étapes : thème d'abord, migration ensuite, toujours par lot validé |
| L'équipe attend que l'agent décide à sa place | Chaque choix de charte/archetype passe par une question métier humaine |
| Script du formateur ressassé | Choisir des rapports différents de la démo phase 1 (jamais AltiSport en atelier) |
