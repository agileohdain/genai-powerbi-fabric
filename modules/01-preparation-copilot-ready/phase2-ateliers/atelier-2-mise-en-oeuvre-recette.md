# Atelier 2 — Mise en œuvre & recette

## Objectif

Appliquer la démarche officielle (anti-sèche du [README de phase 1](../phase1-formation/README.md)) sur le **modèle pilote** du client — schéma IA, réponses vérifiées, instructions IA — puis recetter et marquer *Approved for Copilot*. L'équipe repart avec un **modèle configuré avec son propre vocabulaire**, pas un exemple générique.

## Durée

≈ 3 h 35 (étapes minutées ci-dessous).

## Prérequis

- Atelier 1 réalisé ; points Haute priorité de la grille traités
- Liste des questions métier les plus fréquentes (fournie par le client)
- Q&A activé sur le modèle ; droits d'auteur ; espace Copilot-enabled

## Déroulé

### Étape 1 — Schéma de données IA (30 min)

1. À partir de la grille d'audit : identifier les champs réellement utiles aux questions des utilisateurs.
2. **Prep data for AI** > *Simplify data schema* : conserver ces champs, exclure le reste (technique, redondant, ambigu).
3. Test négatif/positif (fiche 02) sur 2-3 questions.

### Étape 2 — Réponses vérifiées (45 min)

1. Choisir 2-3 questions fréquentes ou sensibles de la liste client (ex. : l'ambiguïté connue du modèle).
2. Créer le visuel correct pour chacune dans un rapport.
3. **...** > *Set up a verified answer* : 5-7 phrases déclencheuses (puiser dans les formulations réelles des utilisateurs), filtres utilisateur si utile.
4. Tester : reformulations sémantiques des phrases déclencheuses.

### Étape 3 — Instructions IA (45 min)

1. Remplir le [template à trous](../phase1-formation/03-instructions-ia.md) en binôme modélisateur + métier : terminologie, définitions conditionnelles, périodes métier, règles d'analyse.
2. Copier dans **Prep data for AI** > *Add AI instructions*, appliquer.
3. Fermer/rouvrir le volet Copilot, tester chaque terme défini, itérer.

### Étape 4 — Descriptions (20 min)

Compléter les descriptions des objets les plus utilisés (essentiel dans les **200 premiers caractères**), en priorité sur les mesures et calculation groups.

### Étape 5 — Recette (45 min)

Pour chaque réponse vérifiée, documenter :

| # | Question testée | Résultat attendu | Résultat obtenu | Verdict |
|---|---|---|---|---|
| 1 | Phrase déclencheuse exacte | Visuel vérifié | … | OK / KO |
| 2 | Reformulation sémantique | Visuel vérifié | … | OK / KO |
| 3 | Question proche mais hors périmètre | Pas de déclenchement abusif | … | OK / KO |

- Reprendre la liste des questions métier fréquentes : le schéma IA doit couvrir les besoins sans réponse manquante.
- Pour chaque réponse surprenante : ouvrir **How Copilot arrived at this**, identifier champ/mesure/filtre, corriger (schéma IA, instruction ou description) et retester.
- Si besoin, télécharger les **diagnostics** (menu ... du volet Copilot) et vérifier l'absence de warning (`AgentSchemaReduced` notamment).

### Étape 6 — Critères d'acceptation, marquage, gouvernance (30 min)

Valider avant marquage :

- [ ] Toutes les questions critiques de la liste client reçoivent une réponse correcte
- [ ] Les réponses vérifiées se déclenchent sur les formulations réelles (taux > 90 % des tests)
- [ ] Aucune réponse vérifiée n'expose de données sensibles (RLS/OLS — voir [docs/02-securite](../../../docs/02-securite/))
- [ ] Volet Copilot testé avec le skill picker en configuration « mode Lecture » (ce que voient les consommateurs)

Puis : modèle sémantique > **Paramètres** > section **Approved for Copilot** > cocher > **Apply** (propagation < 1 h en général, jusqu'à 24 h si de nombreux rapports).

Gouvernance express : nommer un référent pour les évolutions futures (instructions, réponses vérifiées) ; process léger : modification > mini-recette sur les points impactés > republication ; informer les utilisateurs (modèle approuvé, exemples de questions posables).

## Livrables

- Modèle pilote configuré, recetté et marqué *Approved for Copilot*
- Template d'instructions rempli avec le vocabulaire du client (réutilisable sur d'autres modèles)
- Plan de recette complété (tableaux de tests) + note de gouvernance (référent, process)

## Critères de succès

- Toutes les questions critiques de la liste client reçoivent une réponse correcte (checklist de l'étape 6 validée avant marquage)
- Les réponses vérifiées se déclenchent sur les formulations réelles (taux > 90 % des tests)
- Aucune réponse vérifiée n'expose de données sensibles (RLS/OLS)
- Le template d'instructions est rempli avec le vocabulaire du client, réutilisable sur d'autres modèles

## Antidotes aux dérives d'atelier

- Itérer par petites touches : modifier, tester, mesurer — pas de grande rédaction d'instructions d'un coup
- Si le modèle est partagé par plusieurs populations : un terme = une seule définition (limite actuelle), arbitrer avec le métier
- Après l'atelier : surveiller les questions sans réponse remontées par les utilisateurs — matière première pour de nouvelles réponses vérifiées / instructions ; réutiliser la grille d'audit (atelier 1) sur les autres modèles, manuellement ou via MCP (module 04)

## Sources

- [Add AI instructions to your semantic model](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-instructions)
- [Create verified answers](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-verified-answers)
