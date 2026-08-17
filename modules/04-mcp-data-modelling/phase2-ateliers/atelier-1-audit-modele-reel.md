# Atelier 1 — Audit & plan de correction

## Objectif

Auditer un **modèle réel du client** avec le MCP server, produire le rapport d'audit gradué et le **plan de correction** articulé avec la grille de préparation du [module 01](../../01-preparation-copilot-ready/).

## Déroulé

### 1. Cadrage (30 min)

1. Choisir le modèle à auditer (priorité : modèle alimentant Copilot ou un data agent — module 02/03)
2. Définir le **périmètre** : modèle sémantique uniquement (la formation ne couvre pas l'audit de rapport)
3. **Commit initial** du dossier PBIP dans Git — la sauvegarde avant écriture
4. Le modèle réel est-il préparé (grille du [module 01](../../01-preparation-copilot-ready/phase2-ateliers/atelier-1-audit-modele.md)) ? C'est la référence de lecture des constats

### 2. Audit (1 h 30) — un prompt par phase

Reprendre la démarche de la [fiche 02](../phase1-formation/02-audit-existant.md), phase par phase, en relisant entre chaque phase :

1. **Structure** : schéma en étoile, table de dates, relations, types, nommage, colonnes inutiles
2. **Mesures DAX** : logique, performance, redondances, organisation, descriptions
3. **Sécurité** : rôles RLS, risques de fuite, maintenabilité
4. **Rapport final** : génération du markdown gradué (score, constats CRITIQUE/IMPORTANT/RECOMMANDÉ) committé dans le dépôt

Pour chaque constat : noter s'il est **technique** (l'agent a raison, on corrige) ou **à valider métier** (l'impact réel est jugé par le métier) — la liste de validation métier est un livrable à part entière.

### 3. Plan de correction (45 min)

1. Prioriser avec l'équipe : niveau de correction par famille (ex. critiques toutes, importantes sur les mesures les plus utilisées, recommandées en dette technique)
2. Articuler avec la grille du [module 01](../../01-preparation-copilot-ready/phase2-ateliers/) : chaque constat « modèle » correspond à une ligne de la grille — l'audit MCP est la **preuve par l'exemple** de ce que la grille demande
3. **Ne pas corriger en masse aujourd'hui** : le plan est validé, les corrections s'appliquent en atelier 2 (ou en suivi) avec le métier présent

## Livrable

Rapport d'audit markdown (committé) + plan de correction priorisé (niveau par famille, responsable, lien avec la grille module 01) + liste des constats à valider métier.

## Points d'attention

- L'audit en un seul prompt est superficiel : la **relecture entre phases** fait la qualité du rapport
- Ne pas confondre « l'agent classe critique » et « c'est critique pour le client » : la gravité métier se valide avec l'équipe
- Si le modèle est loin d'être préparé, le rapport documente l'état réel : c'est l'argument de cadrage du travail de préparation (module 01), pas un constat d'échec
- Garder les prompts d'audit : ils amorcent l'atelier 2 (documentation) et les audits suivants