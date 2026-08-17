# Module 04 — MCP Data Modelling

## Pourquoi ce module

La modélisation est historiquement le chantier manuel de Power BI : ouvrir le modèle, renommer, écrire du DAX, documenter. Le **Power BI Modeling MCP Server** (Microsoft, Public Preview) connecte un agent IA — via VS Code + GitHub Copilot — **directement au modèle sémantique** (Power BI Desktop, workspace Fabric ou fichiers PBIP/TMDL) pour exécuter des opérations de modélisation en langage naturel : audit, corrections, documentation de masse, refactorings. Là où le module 03 construit des agents *sans code*, ce module adresse le **code agentique** : un développeur qui pilote le modèle depuis son éditeur, avec validation des opérations et diff Git.

> Ce module s'appuie sur la préparation du [module 01](../01-preparation-copilot-ready/) : l'audit et les corrections visent le « bien préparé » dont Copilot, les data agents (module 03) et les rapports ont besoin. La formation reste **100 % VS Code + GitHub Copilot** — aucun agent tiers, aucun autre outil externe.

## Objectifs

- Comprendre ce qu'est MCP (client / serveur) et ce que le Power BI Modeling MCP Server sait faire (et ne pas faire)
- Installer et connecter l'environnement : VS Code, Copilot Chat, extension MCP, connexion Desktop / Fabric / PBIP
- **Auditer un modèle existant** : analyse graduée (critique / important / recommandé), rapport d'audit, choix du niveau de correction, application avec confirmation
- **Documenter un modèle** : descriptions en masse (tables, colonnes, mesures) et document markdown du modèle, revue humaine obligatoire
- Appliquer les garde-fous : sauvegarde, mode lecture seule, diff Git, sécurité des données

## Public

Développeurs BI, data engineers, analystes avancés à l'aise avec VS Code. Les fiches présupposent la connaissance des concepts du module 01 (schéma IA, descriptions, instructions IA) sans être un cours de modélisation.

## Prérequis

- [setup/02-vscode-mcp](../../setup/02-vscode-mcp.md) suivi : VS Code, GitHub Copilot (Pro ou Business), extension Power BI Modeling MCP, option **« MCP servers in Copilot »** activée sur GitHub.com (comptes entreprise : désactivée par défaut, activation admin requise)
- Les modèles AltiSport v1 (terrain d'audit) et v2 (cible) en PBIP dans `assets/modeles/` (voir [guide-modeles.md](../../assets/modeles/guide-modeles.md))
- Un espace de travail Fabric avec un modèle sémantique pour la démo connexion service (optionnel : la démo peut rester sur Desktop/PBIP)

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 3 fiches : MCP & VS Code, audit d'un existant, documentation | ~2,5 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur les modèles réels du client : audit & plan de correction, documentation & adoption | ≈ 0,75 jour |
## Points d'attention transversaux

- **Public Preview** : le serveur MCP évolue encore (outils, prompts, options) ; tester avant chaque mission et vérifier la version dans [TROUBLESHOOTING](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md)
- **Sauvegarde avant opérations** : le LLM peut produire des changements inattendus — toujours committer/taguer le modèle PBIP avant de laisser l'agent écrire
- **Sécurité des données** : MCP n'élargit pas les droits, mais les métadonnées et résultats consultés transitent vers le fournisseur LLM — ne jamais ouvrir `.pbi/`, `cache.abf`, `localSettings.json` ou credentials dans le chat (voir [docs/02-securite](../../docs/02-securite/))
- Le MCP ne modifie que le **modèle sémantique** : ni pages de rapport, ni layout de diagramme
- Qualité des réponses : privilégier un **modèle à raisonnement profond** (GPT-5, Claude Sonnet 4.5 dans Copilot)

## Sources principales

- [Power BI Modeling MCP Server (README officiel)](https://github.com/microsoft/powerbi-modeling-mcp)
- [Troubleshooting](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md)
- [Modèle Context Protocol — site officiel](https://modelcontextprotocol.io)
- Canevas d'audit et gabarit de documentation : inspirés du dépôt [Claude_Config_Agents_PowerBi](https://github.com/Etiozor1/Claude_Config_Agents_PowerBi) (Etiozor1), transposés pour Copilot