# Fiche 04 — Tester, valider et marquer *Approved for Copilot*

## Objectifs

- Tester ce que verront réellement les utilisateurs finaux (skill picker)
- Auditer le raisonnement de Copilot (HCAAT) et collecter des diagnostics
- Officialiser un modèle prêt pour la consommation à grande échelle

## Matériel de démo

Modèle **altisport-v2** publié et configuré (fiches 02-03) — [guide des modèles](../../../assets/modeles/guide-modeles.md). Support unique des tests : skill picker, HCAAT, diagnostics, marquage *Approved*.

**Déroulé de la démo (v2 configuré)** — montrer les gestes de la recette une fois, vite :

1. **Simuler l'environnement final, vérifier en une question** : skill picker > *Answer questions about the data* seul > `sales by sector` → la réponse vérifiée se déclenche (coche). Les fiches 02-03 ont testé en mode auteur (3 capacités) : c'est la preuve que ça tient côté consommateur.
2. **Auditer et documenter** : HCAAT sur la réponse (schéma IA et réponse vérifiée visibles) ; menu **...** > *Download diagnostics* — confirme les fonctionnalités *Prep data for AI* appliquées, pièce jointe officielle d'un ticket support.
3. **Officialiser** : marquage *Approved for Copilot* du modèle v2 dans le service (procédure ci-dessous) — ne teste rien, consacre la recette.

## Tester comme un utilisateur final : le skill picker

Le skill picker permet d'activer/simuler des combinaisons de capacités Copilot :

| Capacité | Description |
|---|---|
| **Answer questions about the data** | Répondre aux questions basées sur le modèle sémantique |
| **Analyze report visuals** | Interpréter et répondre sur les visuels du rapport |
| **Create new report pages** | Générer de nouvelles pages de rapport |

Scénarios de test recommandés — les capacités suivent l'**environnement**, pas la personne :

| Environnement simulé | Où / Qui | Capacités à activer |
|---|---|---|
| Copilot autonome (Home) | Icône Copilot de la **navigation gauche** du service, sans rapport ouvert — tout utilisateur activé ; seul environnement influencé par le marquage *Approved* | Answer questions about the data |
| Volet Copilot d'un rapport — mode Lecture | Rapport ouvert en **consultation** — consommateurs ; un créateur qui ouvre en lecture obtient la même expérience | Answer + Analyze report visuals |
| Volet Copilot d'un rapport — mode Édition | Rapport ouvert en **modification** — créateurs / contributeurs | les trois |

Pourquoi ne pas tout cocher :

- **Create new report pages** brouille le test des réponses vérifiées : Copilot peut router la question vers la création d'une page (visuel généré, sans coche) au lieu de la réponse vérifiée — le troubleshooting Microsoft demande de la désactiver pour cela.
- **Analyze report visuals** est neutre pour les questions de données (elle ne s'active que sur un visuel de la page).
- Règle : cocher la combinaison de **l'audience visée** — les trois cochées testent l'expérience d'un auteur. Priorité au scénario autonome : le plus restreint et le seul que le marquage *Approved* influence — si les réponses tiennent là, elles tiennent partout.

Variante sans skill picker pour le scénario « lecture » : ouvrir le rapport en mode Lecture — l'expérience consommateur s'applique d'elle-même.

Desktop active les trois par défaut ; le sélecteur se trouve dans le menu déroulant de la zone de saisie Copilot. Après chaque modification *Prep data for AI*, fermer et rouvrir le volet pour que les changements soient pris en compte.

## Auditer une réponse : HCAAT et diagnostics

- **How Copilot arrived at this (HCAAT)** : inclus dans les réponses issues du modèle ; montre les champs, mesures et filtres utilisés par Copilot pour aboutir à la réponse. Premier réflexe pour comprendre une réponse inattendue.
- **Download diagnostics** : menu **...** du volet Copilot dans Desktop. Le fichier de diagnostic permet de vérifier que les fonctionnalités *Prep data for AI* sont bien appliquées et sert de pièce jointe aux demandes de support.

## Marquer le modèle *Approved for Copilot*

1. Dans le service Power BI, ouvrir le modèle sémantique > **Paramètres**.
2. Déplier la section **Approved for Copilot**.
3. Cocher la case, **Apply**.

Effets :

- Le Copilot autonome n'applique plus le *friction treatment* aux réponses issues de ce modèle : sans marquage, il affiche un avertissement « réponse potentiellement de faible qualité » et exige un clic *View answer* ; avec marquage, les réponses s'affichent directement dans le chat.
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
