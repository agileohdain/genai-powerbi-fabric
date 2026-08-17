# Antisèche — MCP Data Modelling

> 1 page à imprimer. Condensé du [module 04](../../modules/04-mcp-data-modelling/) — les fiches restent la référence.

## Setup express (une fois par poste)

1. VS Code + GitHub Copilot (Pro ou Business) + extension **Power BI Modeling MCP**
2. Option **« MCP servers in Copilot »** activée sur GitHub.com (comptes entreprise : activation admin requise)
3. Connexion : Power BI Desktop ouvert **ou** workspace Fabric **ou** dossier PBIP/TMDL
4. Détail complet : [setup/02](../../setup/02-vscode-mcp.md)

## Le workflow qui garde vivant

```
1. Baseline Git      → committer / taguer le PBIP AVANT toute écriture
2. Audit             → mode lecture seule d'abord
3. Rapport gradué    → CRITIQUE / IMPORTANT / RECOMMANDÉ
4. Décision          → choisir le niveau de correction (humain)
5. Application       → par lots, avec confirmation de chaque opération
6. Revue             → diff TMDL, puis commit
```

## Prompts d'audit prêts à l'emploi

- `Analyze this semantic model and produce an audit report graded CRITIQUE / IMPORTANT / RECOMMENDED`
- `Review all DAX measures for correctness and performance, grade findings`
- `List tables, columns and measures missing descriptions, with priorities`
- `Add descriptions to all tables, columns and measures, based on the model metadata` *(écriture — baseline d'abord)*

## Garde-fous — non négociables

| Risque | Garde-fou |
|---|---|
| Écritures inattendues | Baseline Git avant de laisser l'agent écrire |
| Données sensibles dans le LLM | **Jamais** ouvrir `.pbi/`, `cache.abf`, `localSettings.json`, credentials dans le chat |
| Périmètre dépassé | Le MCP ne modifie **que le modèle** (ni pages rapport, ni layout) |
| Réponses faibles | Choisir un **modèle à raisonnement profond** (GPT-5, Claude Sonnet 4.5) |

## À retenir

- Public Preview : vérifier la version et le [TROUBLESHOOTING](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md) avant chaque mission
- La revue humaine du diff TMDL reste l'étape de validation — l'agent propose, l'équipe dispose
- 0 CU de génération : le coût est celui de l'abonnement GitHub Copilot ([docs/04](../../docs/04-consommation-cus-ia/))
