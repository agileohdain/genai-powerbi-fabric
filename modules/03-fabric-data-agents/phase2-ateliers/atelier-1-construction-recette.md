# Atelier 1 — Construction & recette

## Objectif

Spécifier et construire le **data agent pilote** sur un modèle réel du client, et produire la **recette de questions vérifiées** qui encadrera l'usage après la formation.

## Déroulé

### 1. Cadrage (45 min) — avec les utilisateurs métier

1. Lister les **questions réelles** que le métier veut poser au pilote (10 à 15, en anglais) — des questions *qu'ils posent déjà*, pas des questions d'équipe BI
2. Définir le **périmètre** : quelles sources, quelles tables, qu'est-ce qui est *hors* périmètre (données sensibles, analyses marginales)
3. Si le modèle n'est pas préparé : parcourir la [grille d'audit du module 01](../../01-preparation-copilot-ready/phase2-ateliers/atelier-1-audit-modele.md) et décider si l'atelier construit l'agent tel quel (pour révéler les écarts) ou après corrections rapides

### 2. Construction (1 h)

1. Créer l'item et ajouter la source (modèle réel), sélectionner les tables du périmètre
2. Rédiger les **instructions** de l'agent (EN) : routage, définitions métier du client, conventions de calcul (reprendre la structure de la fiche 02)
3. Tester les premières questions, ajuster les instructions en itérant

### 3. Recette (1 h 30) — en continu

Pour chaque question, une ligne de recette :

| Champ | Contenu |
|---|---|
| Question (EN + FR) | Prompt exact utilisé |
| Réponse attendue | Valeur(s) de référence validée(s) par le métier (mesure certifiée, visuel existant, résultat d'une question Copilot recetter du [module 02](../../02-copilot-powerbi/phase2-ateliers/)) |
| Requête générée | DAX/SQL/KQL produit — mesure, filtres, table de dates |
| Verdict | Conforme / Conforme avec réserve / Non conforme |
| Cause (si écart) | Prompt à préciser / défaut modèle (nommage, description manquante, colonne de date parasite…) / limite produit (25×25, anglais) |

Vérification systématique (fiche 03) : lire la requête générée, croiser avec le visuel de référence, rejouer la question après correction.

### 4. Synthèse (30 min)

- Taux de conformité par famille de questions ; écarts récurrents → **cause racine modèle ou agent** ?
- Alimentation du plan d'action [module 01](../../01-preparation-copilot-ready/phase2-ateliers/) : chaque cause « modèle » devient un ticket de correction
- Questions à interdire provisoirement (réponses non fiables) : liste explicite dans la recette

## Livrable

Agent pilote (brouillon, en attente de validation) + fiche de recette rejouable, détenue par le propriétaire de l'agent, à rejouer après chaque évolution du modèle ou des instructions.

## Points d'attention

- Ne recetter que des **questions plausibles** : la recette doit refléter l'usage réel
- Un modèle non préparé qui donne de mauvaises réponses est le **résultat attendu** : le documenter comme argument pour la préparation (module 01), pas comme un échec de l'agent
- Les questions non conformes pour cause « limite produit » (ex. trop de lignes) ne sont pas des défauts : les exclure du périmètre d'adoption
- Garder la traçabilité des prompts : elle amorce l'atelier 2 (canaux, formation des utilisateurs)