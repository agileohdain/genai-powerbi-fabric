# Module 02 — Copilot dans Power BI

## Pourquoi ce module

Copilot dans Power BI couvre bien plus que la génération de pages de rapport : c'est un ensemble d'expériences de chat (volet Copilot d'un rapport, expérience autonome plein écran, Copilot dans les apps) et de fonctionnalités intégrées (création de pages, questions en langage naturel, narratifs, résumés par e-mail, génération de DAX, descriptions de mesures). Bien utilisé, il fait gagner des heures aux auteurs de rapports et ouvre aux utilisateurs métier de nouvelles façons de consommer les données — à condition de savoir quand l'utiliser, comment formuler ses prompts et surtout **comment vérifier les réponses**.

> Ce module applique les acquis du [module 01](../01-preparation-copilot-ready/) : la qualité des réponses de Copilot dépend directement de la préparation du modèle. La préparation n'est pas reprise ici.

## Objectifs

- Cartographier les expériences Copilot disponibles et savoir laquelle utiliser selon le profil (créateur / consommateur)
- Créer et modifier des pages de rapport avec des prompts efficaces
- Poser des questions de données, **lire et vérifier** les réponses (raisonnement, champs et filtres utilisés)
- Produire des narratifs et des résumés, y compris dans les abonnements e-mail
- Utiliser Copilot comme assistant de développement : DAX Query View, descriptions de mesures, modélisation web

## Public

Auteurs de rapports, analystes, développeurs BI ; les fiches 01, 03 et 04 concernent aussi les utilisateurs métier consommateurs de rapports.

## Prérequis

- Copilot activé sur le tenant et une capacité **F2+/P1+** (ou Fabric Copilot capacity), workspace assigné (voir [docs/01-prerequis-admin](../../docs/01-prerequis-admin/))
- Un modèle sémantique préparé selon la démarche du [module 01](../01-preparation-copilot-ready/) — pour les démos, le modèle AltiSport v2 (voir [assets/modeles](../../assets/modeles/guide-modeles.md))
- Q&A activé sur le modèle (Copilot s'appuie sur le même moteur pour construire ses requêtes)

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 5 fiches : panorama des expériences, création de rapport, questions de données, narratifs et résumés, Copilot développeur | ~3 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur les modèles réels du client : découverte et recette, prompts et adoption | ≈ 0,75 jour |
| [Quiz d'ancrage](phase1-formation/quiz.md) | 5 questions d'auto-évaluation (corrigé plié inclus) | ~10 min |

## Points d'attention transversaux

- Copilot **augmente** les créateurs, il ne les remplace pas : il ne connaît ni le contexte métier ni les subtilités du domaine.
- Les sorties sont **non déterministes** : le même prompt peut donner une réponse différente ; le même prompt sur un modèle inchangé peut être servi depuis un **cache pendant 24 h**. Utiliser *Effacer la conversation* (clear chat) ou reformuler.
- **Prompts en anglais recommandés** : le multilingue n'est pas officiellement supporté. Chaque exemple de cette formation est donné en anglais avec sa traduction.
- Impossible d'activer Copilot expérience par expérience : le réglage couvre **tous les workloads** d'un coup.
- Toute interaction consomme des CUs de la capacité (opérations en arrière-plan) : voir [docs/04-consommation-cus-ia](../../docs/04-consommation-cus-ia/).

## Sources principales

- [Copilot for Power BI overview](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-introduction)
- [Copilot in Power BI integration](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-integration)
- [Use Copilot with Power BI reports](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-reports-overview)
- [Use Copilot with semantic models](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-semantic-models)
- Tutoriel de bout en bout : [Introduction](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-introduction) · [Préparer le modèle](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-prepare-model) · [Découvrir les données](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-discover-data) · [Explorer les données](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-explore-data)
