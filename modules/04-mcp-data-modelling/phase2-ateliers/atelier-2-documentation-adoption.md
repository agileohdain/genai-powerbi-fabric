# Atelier 2 — Documentation & adoption

## Objectif

Documenter les **modèles réels du client** (descriptions + document markdown au standard d'équipe), appliquer la revue humaine, et installer la routine d'équipe : documentation versionnée dans Git, rejouée à chaque évolution du modèle.

## Déroulé

### 1. Descriptions en masse (45 min)

1. Appliquer la passe de descriptions de la [fiche 03](../phase1-formation/03-documentation.md) sur le modèle audité (mesures, puis tables et colonnes)
2. Relecture du **diff TMDL** : descriptions < 200 caractères, alignées sur le vocabulaire métier du client, aucune triviale
3. Correction ciblée par prompts sur les formulations faibles
4. Validation métier des définitions sensibles (marge, indicateurs clés) — en s'appuyant sur les réponses du vocabulaire de la [fiche 03 du module 01](../../01-preparation-copilot-ready/phase1-formation/03-instructions-ia.md)

### 2. Document markdown (45 min)

1. Générer le document du modèle avec le **gabarit standard** (fiche 03) : sections fixes, 270-350 lignes, uniquement l'observable
2. **Revue humaine** en groupe : exactitude, pertinence des mesures documentées (20/80), pièges manquants
3. Corriger par prompts ciblés jusqu'à validation ; committer le document à côté du modèle (ex. `documentation/model-x.md`)

### 3. Standard d'équipe (30 min)

1. Adopter le gabarit comme **standard** : documentation de chaque modèle, emplacement fixe dans le dépôt, pas de section contacts (obsolescence rapide)
2. **Routine de mise à jour** : rejouer la documentation quand le modèle change — et **l'audit** (atelier 1) en amont des évolutions structurantes
3. Intégration Git : commit du doc + descriptions avec le modèle (les descriptions TMDL se diffent : la revue de code couvre la doc)

### 4. Bouclage sur l'écosystème IA (15 min)

- Les descriptions ajoutées sont-elles **consommées** ? Test rapide : rejouer une question Copilot (module 02) ou une question de data agent (module 03) sur le modèle documenté et comparer avec la réponse d'avant
- S'il y a un écart persistant : instructions IA du modèle (module 01, fiche 03), pas la documentation

## Livrable

Modèle documenté (descriptions + markdown, committés) + standard d'équipe adopté (gabarit, emplacement, routine) + constat avant/après sur une question IA rejouée.

## Points d'attention

- La documentation générée **sans revue humaine** est un livrable faible : la séance de revue en groupe est le cœur de l'atelier
- Ne pas tout documenter : le 20/80 s'applique aux mesures ; les colonnes techniques masquées (module 01) n'ont pas à être documentées
- Une documentation à jour fait gagner plus que le temps de sa génération : la routine Git est le vrai livrable de l'adoption