# Atelier 2 — Traduction de masse & adoption de la démarche

## Objectif

Traduire un **rapport réel du client** (libellés EN → FR, ou autre langue cible) en masse via les skills, puis — objectif de fond — **décider, avec l'équipe, si le flux « skills » entre dans le quotidien** de l'équipe BI : quels rapports, quel rythme, quelles garde-fous.

## Durée

~3 h.

## Étape 0 — Choix du rapport et baseline (15 min)

1. Sélectionner un rapport réel… **non encore utilisé en atelier 1** (variété des scénarios)
2. S'assurer qu'il est en **PBIP** dans le dépôt client ; commit de l'état initial
3. Inventorier les libellés à traduire : `powerbi-report-author preview-pages` + `preview-visuals` pour repérer titres et textboxes

## Étape 1 — Traduction de masse (60 min)

1. Lancer la traduction complète (prompt de la fiche 03 adapté à la langue cible)
2. **Revue du diff** avant toute validation : l'agent ne doit pas traduire les valeurs, le DAX, ni les références de champs
3. **Validate → Reload → Screenshot** ; vérifier sur les captures : titres cohérents, pas de troncation (textboxes trop petits), langue cible partout
4. Corriger par lots ciblés si certains libellés sont ratés

## Étape 2 — Recette complète de contrôle qualité (45 min)

S'exercer sur la **recette reproductible** à garder pour l'équipe :

```text
1. git baseline        — état initial committé
2. prompt de mission   — tâche précise, périmètre délimité, langue cible
3. validate par lot    — powerbi-report-author validate après chaque lot
4. reload + screenshot — contrôle du rendu visuel
5. review du diff      — validation humaine avant commit
```

Faire exécuter la recette à tour de rôle (une paire par étape) sur des lots séparés du rapport.

## Étape 3 — Adoption de la démarche (45 min)

Faciliter une décision collective sur l'emploi réel des skills :

1. **Inventaire « adoptable »** : quels rapports/refactoring/traductions se prêtent au flux skills (PBIP, peu sensibles, volumineux) ?
2. **Fréquence** : ponctuel (chantiers spécifiques) vs régulier (veille de modernisation) ?
3. **Garde-fous** : qui approuve quoi, où vit la charte, quels rapports restent hors-périmètre (sensibilité, réglementé) ?
4. Consigner la décision dans le dépôt client (ex. `docs/` module) pour les prochaines missions

## Étape 4 — Bilan (15 min)

- Ce qui fonctionne (vitesse, uniformité) vs ce qui reste manuel (validation métier, charte)
- Feedback collectif sur l'ergonomie des skills (VS Code vs CLI) pour choisir l'outillage par équipe

## Livrables

- Rapport traduit en masse (PBIP committé, captures avant/après)
- **Recette de contrôle qualité** documentée (template à réutiliser)
- Décision d'adoption consignée : périmètre, rythme, garde-fous

## Critères de succès

- 100 % des libellés visibles du rapport dans la langue cible, aucune donnée modifiée
- La recette est exécutée de façon autonome par un binôme au moins
- Une décision d'adoption **écrite** existe (adopte / adopte partiellement / rejette avec motifs)

## Antidotes aux dérives d'atelier

| Dérive | Antidote |
|---|---|
| Tradition « au fil de l'eau » qui touche les données | Refuser tout diff touchant DAX/valeurs avant revue |
| L'adoption reste un vœu | Exiger une décision consignée (même « on ne généralise pas » est une décision) |
| Chacun traduit à sa sauce | Un seul prompt de mission unique pour tout le rapport, puis revue |
