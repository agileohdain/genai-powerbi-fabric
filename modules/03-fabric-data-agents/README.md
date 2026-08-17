# Module 03 — Fabric Data Agents

## Pourquoi ce module

Un data agent Fabric est un agent conversationnel **no-code** et **configurable** qui répond en langage naturel à des questions sur des données de OneLake et des modèles sémantiques : lakehouse, warehouse, modèle sémantique Power BI, KQL Database, mirrored database, ontology, Microsoft Graph. Là où Copilot est préconfiguré et collé à l'expérience Power BI (module 02), le data agent est un artefact autonome que l'on **construit** — sources, tables, instructions, exemples — puis que l'on publie et partage. Bien utilisé, il ouvre la donnée à un public non technique dans l'outil qu'il fréquente déjà ; mal configuré, c'est une porte d'entrée vers des réponses fausses et incontrôlées.

> Ce module applique directement les acquis du [module 01](../01-preparation-copilot-ready/) : pour un modèle sémantique, **les exemples question/requête ne sont pas supportés** par les data agents — la qualité des réponses repose alors entièrement sur la préparation du modèle (schéma IA, descriptions, instructions IA). La préparation n'est pas reprise ici.

## Objectifs

- Situer le data agent parmi les expériences IA de Fabric : quand l'utiliser au lieu de Copilot Power BI, et au lieu des autres leviers (matrice d'arbitrage)
- Créer et configurer un data agent : sources, sélection des tables, instructions, exemples
- **Évaluer et vérifier les réponses** : lire les requêtes générées, itérer instructions et exemples, connaître les limites produit
- Publier, partager et gouverner : versions brouillon/publié, permissions, sécurité des sources, ALM

## Public

Auteurs de rapports, analystes, développeurs BI qui construisent et partagent des agents ; la fiche 01 (panorama et cas d'usage) concerne aussi les utilisateurs métier consommateurs.

## Prérequis

- Capacité **F2 ou supérieure** (ou P1+ avec Fabric activé) et workspace assigné (voir [docs/01-prerequis-activation](../../docs/01-prerequis-activation/))
- Copilot et Azure OpenAI activés sur le tenant (mêmes paramètres que le module 02)
- **Paramètres tenant spécifiques** : *Data sent to Azure OpenAI can be processed/stored outside your capacity's geographic region* — requis uniquement si la région de la capacité est **hors de l'EU data boundary et des États-Unis** (non requis pour une capacité en France). La prise d'effet peut prendre jusqu'à une heure.
- Un modèle sémantique préparé selon la démarche du [module 01](../01-preparation-copilot-ready/) — pour les démos, le modèle AltiSport v2 (voir [assets/modeles](../../assets/modeles/guide-modeles.md)), avec permission **Read** sur le modèle

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 4 fiches : panorama et cas d'usage, création et configuration, qualité et vérification, publication et gouvernance | ~3 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur les modèles réels du client : construction & recette, diffusion & adoption | ≈ 0,75 jour |

## Points d'attention transversaux

- **Changement récent** : l'accès aux data agents depuis Copilot in Power BI est **retiré depuis le 26 août 2026** (l'intégration reposait sur l'OpenAI Assistants API, elle-même retirée). Le data agent lui-même est inchangé ; il se consomme via l'expérience directe, Microsoft 365 Copilot, Copilot Studio, Microsoft Foundry ou un **endpoint MCP** (voir fiche 01).
- Un data agent est **read-only** : il ne génère que des requêtes de lecture (SQL, DAX, KQL) et ne déclenche aucun workflow d'écriture.
- Toute interaction consomme des CUs de la capacité : voir [docs/04-consommation-cus-ia](../../docs/04-consommation-cus-ia/).
- Les réponses sont **limitées à 25 lignes × 25 colonnes** : l'agent convient à l'analyse conversationnelle, pas au téléchargement de données.
- **Anglais uniquement** : poser les questions et rédiger instructions et exemples en anglais, y compris pour une équipe francophone.
- L'utilisateur qui interroge via un agent n'a besoin que de **Read** sur la source ; les droits d'écriture (Build, workspace) ne sont pas requis — à intégrer dans les habitudes de partage.

## Sources principales

- [Fabric data agent creation (concept, GA)](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
- [Fabric data agent scenario — bout en bout (tutoriel)](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-end-to-end-tutorial)
- [Fabric data agent sharing and permission management](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing)
- [Configure Fabric data agent tenant settings](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-tenant-settings)
- [Data agent as Model Context Protocol server (preview)](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-mcp-server)
- [Retirement of Fabric data agent integration in Copilot in Power BI](https://community.fabric.microsoft.com/t5/Fabric-Updates-Blog/Retirement-of-Fabric-data-agent-integration-in-Copilot-in-Power/ba-p/5328344) (annonce 30/07/2026)