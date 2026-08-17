# Module 01 — Préparation Copilot-ready

## Pourquoi ce module

La qualité des réponses de l'IA dépend avant tout du modèle sémantique sur lequel elle s'appuie. Un modèle mal structuré, mal nommé ou ambigu produit des réponses génériques, inexactes ou trompeuses. Ce module est le socle de toute la formation : ce qui s'y apprend profite à Copilot Power BI, aux Fabric Data Agents (module 03), à l'audit MCP (module 04) et aux Fabric Skills (module 05).

> Ce module est la **référence unique de la formation pour les bonnes pratiques de modélisation sémantique**. Les autres modules y renvoient et n'en reprennent pas le contenu.

## Objectifs

- Évaluer et auditer un modèle sémantique au regard des exigences de l'IA
- Mettre en œuvre les fonctionnalités **Prep data for AI** : schéma de données IA, réponses vérifiées, instructions IA
- Tester rigoureusement (skill picker, HCAAT) puis valider un modèle avec *Approved for Copilot*
- Appliquer la démarche officielle dans le bon ordre et savoir arbitrer entre fonctionnalités

## Public

Modélisateurs de données, développeurs BI, analystes responsables de modèles sémantiques.

## Prérequis

- Copilot activé sur le tenant et la capacité (voir [docs/01-prerequis-activation](../../docs/01-prerequis-activation/))
- Power BI Q&A activé sur le modèle (nécessaire pour les onglets de *Prep data for AI*)
- Power BI Desktop avec la fonctionnalité d'aperçu *Prep data for AI* activée, ou un espace de travail Copilot-enabled dans le service

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 4 fiches : évaluation du modèle, schéma IA et réponses vérifiées, instructions IA, test et validation (démarche globale en anti-sèche dans le README de phase) | ~3 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur un modèle pilote du client : audit, mise en œuvre et recette | ≈ 0,75 jour |
| [Quiz d'ancrage](phase1-formation/quiz.md) | 5 questions d'auto-évaluation (corrigé plié inclus) | ~10 min |

## Points d'attention transversaux

- L'IA est **non déterministe** : la préparation améliore la qualité et la pertinence, elle ne garantit pas une réponse identique à chaque fois.
- Toute la configuration *Prep data for AI* est stockée **au niveau du modèle sémantique** (pas du rapport) : elle s'applique à tous les rapports qui utilisent le modèle.
- Les instructions IA et schémas IA sont enregistrés dans la LSDL ; après un déploiement via Git ou pipelines, une actualisation du modèle est nécessaire pour la synchronisation.

## Sources principales

- [Prepare your data for AI](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai)
- [Optimize your semantic model for Copilot](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-evaluate-data)
- [FAQ Prepare data for AI](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
