# Atelier 1 — Découverte & recette

## Objectif

Parcourir toutes les expériences Copilot sur un **rapport réel du client** et produire la **fiche de recette** qui servira à encadrer l'usage après la formation : questions types, réponses attendues, points de vérification.

## Durée

≈ 3 h (parcours guidé sur une demi-journée, recette en continu).

## Déroulé

### 1. Parcours guidé (matinée)

1. **Volet Copilot** sur le rapport du client : résumé de page (`What is this report page about?`), question sur le contenu, résumé exécutif ciblé
2. **Questions de données** : 5 à 10 questions réelles fournies par les utilisateurs métier présents (les leurs, pas celles de l'équipe BI)
3. **Création de page** : un prompt de haut niveau sur un besoin existant, puis évaluation honnête du retravail nécessaire
4. **Narratif** : résumé de la page d'accueil du rapport, affinage par prompts, vérification des notes de référence
5. **Copilot autonome** (si activé) : recherche du rapport par ses métadonnées, question rattachée au rapport trouvé

### 2. Recette de chaque réponse (en continu)

Pour chaque question, remplir une ligne de recette :

| Champ | Contenu |
|---|---|
| Question (EN + FR) | Prompt exact utilisé |
| Réponse attendue | Valeur(s) de référence validée(s) par le métier (mesure certifiée, visuel existant) |
| Champs/filtres utilisés | Ce que montre *How Copilot arrived at this* |
| Verdict | Conforme / Conforme avec réserve / Non conforme |
| Cause (si écart) | Prompt à préciser / défaut modèle (nommage, champ ambigu, colonne de date parasite…) / limite produit |

Réflexes de vérification systématiques (fiche 03) : déployer *How Copilot arrived at this*, cliquer les éléments *Data used*, **Add to page** pour inspecter les filtres du visuel généré, vérifier la **table de dates** utilisée, comparer aux visuels de référence.

### 3. Synthèse (fin de journée)

- Taux de conformité par type de question ; écarts récurrents et leurs causes modèle
- Alimentation du plan d'action [module 01](../../01-preparation-copilot-ready/phase2-ateliers/) : chaque cause « modèle » devient un ticket de correction
- Questions à interdire provisoirement (réponses non fiables) : liste explicite dans la fiche de recette

## Livrables

Fiche de recette Copilot du rapport (tableau ci-dessus complété), détenue par le propriétaire du rapport, à rejouer après chaque évolution du modèle.

## Critères de succès

- Chaque question testée a sa ligne de recette complète (prompt, attendu, champs/filtres utilisés, verdict)
- Le taux de conformité est calculé et les écarts ont une cause classée (modèle / prompt / limite produit)
- Le plan d'action du [module 01](../../01-preparation-copilot-ready/phase2-ateliers/) est alimenté par les causes « modèle »
- Les questions non fiables sont listées explicitement comme interdites provisoirement

## Antidotes aux dérives d'atelier

- Ne recetter que des **questions plausibles** : la recette doit refléter l'usage réel, pas un catalogue exhaustif
- Si un modèle non préparé donne de mauvaises réponses : c'est le résultat attendu — le documenter comme argument pour la préparation (module 01) plutôt que comme échec de Copilot
- Garder la traçabilité des prompts : ils amorcent l'atelier 2

## Sources

- [Ask Copilot questions about your data](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-ask-data-question)
- [Evaluate Copilot responses](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-evaluate-data)
