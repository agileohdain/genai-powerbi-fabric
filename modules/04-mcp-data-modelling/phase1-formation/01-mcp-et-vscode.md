# Fiche 01 — MCP & VS Code : concepts, connexion, premier prompt

> Fiche de fondations : c'est ici que se joue la confiance dans l'outil — ce que MCP peut toucher, ce qu'il ne peut pas toucher, et comment il demande l'accord avant d'écrire.

## Objectifs

- Comprendre le modèle client / serveur de MCP et ce qu'il change par rapport à Copilot dans Power BI
- Installer l'environnement (renvoi [setup/02](../../../setup/02-vscode-mcp.md)) et **connecter le serveur à un modèle**
- Connaître les trois cibles de connexion : Power BI Desktop, workspace Fabric, dossier PBIP
- Faire le premier prompt en **mode agent** et lire sa réponse critique
- Maîtriser les garde-fous : mode lecture seule, confirmation d'écriture, sauvegarde

## Concepts MCP

MCP (Model Context Protocol) est un standard ouvert qui relie une application IA (le **client** : VS Code + Copilot Chat) à des capacités externes (le **serveur**). Le serveur expose des **outils** (tool = une opération) et des **prompts** (commandes `/…` intégrées) que le client peut appeler pendant la conversation.

Le **Power BI Modeling MCP Server** (Microsoft, Public Preview) expose ~20 groupes d'outils qui couvrent la modélisation : connexions, transactions, tables, colonnes, mesures, relations, hiérarchies, DAX (exécution/validation), sécurité (RLS), cultures/traductions, calculation groups… Toutes les opérations respectent les droits de l'utilisateur connecté — le serveur n'élargit rien.

**Trois cibles de connexion** (prompt intégré ou instruction en langage naturel) :

| Cible | Prompt | Usage type |
|---|---|---|
| Power BI Desktop (fichier ouvert) | `Connect to '[File Name]' in Power BI Desktop` | Modèle en cours d'édition |
| Workspace Fabric | `Connect to semantic model '[Name]' in Fabric Workspace '[Workspace]'` | Modèle publié, le partagé avec les data agents (module 03) |
| Dossier PBIP | `/ConnectToPBIP` (ouvrir le dossier TMDL) | **Chemin de la formation** : diff Git, versionné, sans Desktop ouvert |

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Dossier PBIP **altisport-v1** | `assets/modeles/altisport-v1/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Cible de connexion du premier prompt (vue d'ensemble du modèle) |
| VS Code + extension **Power BI Modeling MCP** | [setup/02](../../../setup/02-vscode-mcp.md) | Environnement installé avant la session |

## Pas-à-pas — connexion et premier prompt

### 1. Vérifier l'environnement

1. VS Code avec Copilot Chat connecté ; extension **Power BI Modeling MCP** installée ([setup/02](../../../setup/02-vscode-mcp.md))
2. Ouvrir le dossier du dépôt : `File > Open Folder` sur `C:\dev\genai-powerbi-fabric`
3. Dans Copilot Chat, vérifier que **powerbi-modeling-mcp** est listé et sélectionné parmi les outils

### 2. Se connecter au modèle v1 (PBIP)

Prompt (mode agent) :

```
Open semantic model from PBIP folder 'assets/modeles/altisport-v1/altisport-v1.SemanticModel/definition' and give me an overview of the model.
```

Traduction : *Ouvre le modèle sémantique depuis le dossier PBIP '…/definition' et donne-moi une vue d'ensemble du modèle.*

La réponse doit lister les tables et mesures du modèle v1 — c'est la preuve que la connexion fonctionne. Réponse du serveur visible dans le chat (l'agent « voit » le modèle).

### 3. La confirmation d'écriture (elicitation)

Avant **la première modification** et avant **la première requête DAX exécutée**, le serveur demande l'accord à l'utilisateur (elicitation MCP). C'est un feu rouge volontaire : tant que vous ne confirmez pas, rien ne change dans le modèle.

> Options du serveur (configuration setup/02) : `--readonly` (aucune écriture possible — recommandé pour découvrir), `--skipconfirmation` (déconseillé : valide tout sans demander), défaut = `--readwrite` avec confirmation par session.

### 4. Lire une réponse critique

Toute proposition de l'agent doit être **lue avant d'être acceptée** : noms proposés, DAX généré, tables touchées. Réflexes :
- Vérifier le **diff TMDL** dans l'explorateur Git avant de valider un changement
- Demander le détail d'une mesure : `Show me the DAX of the measure 'Total Ventes' and explain the logic.` (*Montre-moi le DAX de la mesure 'Total Ventes' et explique la logique.*)
- Ne jamais accepter une opération dont on ne comprend pas l'effet

## Prompts intégrés utiles (slash commands)

| Prompt | Rôle |
|---|---|
| `/ConnectToPBIP` | Charge la définition TMDL d'un projet PBIP (avec contexte projet Power BI) |
| `/ConnectToPowerBIDesktop` | Recherche et connecte une instance Desktop ouverte |
| `/ConnectToFabric` | Connecte un modèle d'un workspace Fabric |
| `/CreateDAXQuery` | Crée une requête DAX depuis une question en langage naturel |
| `/AnalyzeDAXQuery` | Exécute une requête DAX cache vidé et analyse les métriques de performance |
| `/RunDAXQueryWithMetrics` | Exécute avec métriques d'exécution |

## Limites et pièges

- MCP **ne modifie pas les rapports** : ni pages, ni visuels, ni layout — uniquement le modèle sémantique
- Les métadonnées consultées (schéma, DAX, résultats de requêtes) **partent au fournisseur LLM** : ne pas ouvrir de fichiers sensibles (`.pbi/`, `cache.abf`, `localSettings.json`, `.env`) et vérifier les politiques de l'organisation (voir [docs/02-securite](../../../docs/02-securite/))
- **Public Preview** : les outils évoluent ; `Tell me what tools are available and show examples` si un nom diffère
- Le modèle sélectionné dans Copilot influence fortement la qualité : préférer un modèle à raisonnement profond (GPT-5, Claude Sonnet 4.5)
- Sauvegarder avant d'écrire : le LLM peut produire des changements inattendus — le **commit Git du dossier PBIP est la sauvegarde** (TMDL = texte, diff lisible)

## Sources

- [Power BI Modeling MCP Server (README)](https://github.com/microsoft/powerbi-modeling-mcp)
- [Troubleshooting](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md)
- [Model Context Protocol](https://modelcontextprotocol.io)
- [Setup 02 — VS Code + Copilot + MCP](../../../setup/02-vscode-mcp.md)