# Setup — Installation des ressources

Guides d'installation et de configuration des outils utilisés dans la formation. À suivre avant les ateliers Phase 2 côté client (les prérequis d'entreprise — licences, tenant — sont dans [docs/01-prerequis-activation](../docs/01-prerequis-activation/)).

| # | Guide | Outil | Utilisé par | Statut |
|---|---|---|---|---|
| 00 | [Récupérer le dépôt](00-recuperer-depot.md) | Clonage de la copie client dans `C:\dev` (ou ZIP GitHub) — chemin attendu par les modèles | Tous les modules | ✅ |
| 01 | [Power BI Desktop](01-powerbi-desktop.md) | Desktop : aperçus PBIP + Prep data for AI (aucun outil externe) | Modules 01, 02, 04, 05 | ✅ |
| 02 | [VS Code + Copilot + Power BI MCP Server](02-vscode-mcp.md) | VS Code, extension Power BI Modeling MCP, option MCP sur GitHub.com | Module 04 (MCP Data Modelling) | ✅ |
| 03 | [Copilot CLI + plugin Skills for Fabric](03-skills-copilot-cli.md) | Copilot CLI/VS Code, plugin `powerbi-authoring`, CLIs Node (`powerbi-report-author`, `powerbi-desktop`), Desktop Bridge | Module 05 (Fabric Skills Authoring) | ✅ |
| 04 | [Capacité Fabric & gouvernance](04-capacite-gouvernance.md) | Portail admin, Fabric Capacity Metrics App | Module 06 (Gouvernance & CUs) | ✅ |

## Vérification rapide (tous modules)

- [ ] Dépôt cloné dans `C:\dev\genai-powerbi-fabric` ([guide 00](00-recuperer-depot.md))
- [ ] Power BI Desktop à jour avec les aperçus activés (guide 01)
- [ ] Compte connecté avec accès à une capacité Fabric (F2+ ou P1+) dans une région supportée
- [ ] Espace de travail Copilot-enabled disponible pour les tests
