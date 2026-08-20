# Fiche 04 — Tester, valider et marquer *Approved for Copilot*

## Objectifs

- Tester ce que verront réellement les utilisateurs finaux (skill picker)
- Auditer le raisonnement de Copilot (HCAAT) et collecter des diagnostics
- Officialiser un modèle prêt pour la consommation à grande échelle

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** publié et configuré (fiches 02-03) | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Support des tests : skill picker, HCAAT, diagnostics, marquage *Approved* |

**Déroulé de la démo (v2 configuré)** — vérifier que les préparations des fiches 02-03 tiennent pour un utilisateur final, puis officialiser :

1. **Se mettre en peau d'utilisateur** : menu déroulant de la zone de saisie Copilot > **Select skills** > ne garder que *Answer questions about the data* — simulation du Copilot autonome, le plus restreint des trois environnements (voir tableau ci-dessous).
2. **Rejouer** les questions de référence : `sales by sector` → réponse vérifiée (coche, phrase *matched*) ; question « closers » saison blanche 2025-2026 → `DimVendeur` sans filtre, bonne période. Attendu : mêmes réponses que fiches 02-03, sans le rapport.
3. **Auditer** : sur une réponse, déployer *How Copilot arrived at this* — le schéma IA (plus de `Total Marge`) et la réponse vérifiée y sont visibles.
4. **Documenter** : menu **...** > *Download diagnostics* — le fichier confirme les fonctionnalités *Prep data for AI* appliquées (pièce jointe officielle d'un ticket support).
5. **Officialiser** : marquage *Approved for Copilot* du modèle v2 dans le service (procédure ci-dessous). Le marquage ne teste rien — il consacre la recette qui vient d'être faite.

## Tester comme un utilisateur final : le skill picker

Le skill picker permet d'activer/simuler des combinaisons de capacités Copilot :

| Capacité | Description |
|---|---|
| **Answer questions about the data** | Répondre aux questions basées sur le modèle sémantique |
| **Analyze report visuals** | Interpréter et répondre sur les visuels du rapport |
| **Create new report pages** | Générer de nouvelles pages de rapport |

Scénarios de test recommandés :

| Environnement simulé | Capacités à activer |
|---|---|
| Copilot autonome (Home) | Answer questions about the data |
| Volet Copilot d'un rapport — mode Lecture | Answer + Analyze report visuals |
| Volet Copilot d'un rapport — mode Édition | les trois |

Desktop active les trois par défaut ; le sélecteur se trouve dans le menu déroulant de la zone de saisie Copilot. Après chaque modification *Prep data for AI*, fermer et rouvrir le volet pour que les changements soient pris en compte.

## Auditer une réponse : HCAAT et diagnostics

- **How Copilot arrived at this (HCAAT)** : inclus dans les réponses issues du modèle ; montre les champs, mesures et filtres utilisés par Copilot pour aboutir à la réponse. Premier réflexe pour comprendre une réponse inattendue.
- **Download diagnostics** : menu **...** du volet Copilot dans Desktop. Le fichier de diagnostic permet de vérifier que les fonctionnalités *Prep data for AI* sont bien appliquées et sert de pièce jointe aux demandes de support.

## Marquer le modèle *Approved for Copilot*

1. Dans le service Power BI, ouvrir le modèle sémantique > **Paramètres**.
2. Déplier la section **Approved for Copilot**.
3. Cocher la case, **Apply**.

Effets :

- Le Copilot autonome n'applique plus le *friction treatment* aux réponses issues de ce modèle.
- Les rapports utilisant ce modèle sont considérés comme approuvés.
- Propagation : généralement moins d'une heure, jusqu'à 24 h si beaucoup de rapports sont rattachés ; forcer en enregistrant une petite modification dans un rapport.

À savoir :

- Aucun moyen actuel de marquer un rapport, un tableau de bord ou une application individuellement.
- L'administrateur du tenant peut restreindre le Copilot autonome aux seuls éléments approuvés (paramètre *Only show approved items*).

## Encart diagnostic — Indexation Copilot

Symptômes fréquents et explications :

| Symptôme | Cause | Que faire |
|---|---|---|
| Message « Copilot is currently syncing with the data model » | Indexation en cours (normale après publication/actualisation) | Attendre : se résout seul |
| Une valeur récente n'apparaît pas dans une réponse | Index non encore rafraîchi | Attendre la réindexation (voir ci-dessous) |
| Certaines valeurs texte jamais reconnues | Texte de 100+ caractères non indexé | Raccourcir les valeurs |
| Réponses dégradées sur un très gros modèle | Schéma réduit par Copilot (warning `AgentSchemaReduced` dans les diagnostics) | Resserre le schéma IA |

Règles de réindexation :

- Indexation des colonnes **texte** des modèles avec Q&A activé ; les colonnes masquées via le schéma IA ne sont pas indexées.
- Import : à chaque publication/republication, et aux actualisations (si Copilot/Q&A utilisés dans les 14 derniers jours).
- DirectQuery / Direct Lake : à chaque publication, puis toutes les 24 h maximum.
- Limites : 5 millions de valeurs d'instance, 1 000 entités (tables/colonnes) ; DirectQuery exige une source supportant `APPROXIMATEDISTINCTCOUNT`.
- Première génération d'index : prévoir ~15 minutes supplémentaires.

## Limites et pièges

- Le marquage *Approved* ne teste rien : la recette doit être faite en amont (voir [atelier 2](../phase2-ateliers/atelier-2-mise-en-oeuvre-recette.md)).
- Les tests en Desktop surestiment les capacités : toujours valider avec le skill picker configuré selon l'environnement visé.

## Sources

- [Prepare your data for AI (vue d'ensemble) — test et approbation](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai)
- [Prepare your data for AI — Settings (indexation)](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-settings)
- [FAQ — méthodologie d'indexation](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
