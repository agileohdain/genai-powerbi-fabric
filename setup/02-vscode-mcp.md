# Setup 02 — VS Code + Copilot + Power BI MCP Server

Configuration de l'environnement de modélisation agentique du module 04 : **VS Code + GitHub Copilot + extension Power BI Modeling MCP**. À faire une fois par poste (~15 minutes).

## 1. Prérequis

| Élément | Exigence |
|---|---|
| VS Code | Dernière version stable |
| GitHub Copilot | Abonnement **Pro** ou **Business** ; connexion au compte GitHub dans VS Code |
| Option « MCP servers in Copilot » | **Activée sur GitHub.com** — `Settings > Copilot > MCP servers in Copilot` |
| Power BI | Desktop à jour (setup 01) ou accès à un workspace Fabric |

> **Comptes entreprise** : l'option « MCP servers in Copilot » est **désactivée par défaut** pour les organisations GitHub — demande d'activation côté admin de l'organisation avant la formation.

## 2. Installation

1. Installer [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) (extension)
2. Installer l'extension **Power BI Modeling MCP** : marketplace → rechercher `Power BI Modeling MCP` (éditeur *analysis-services*, lien [aka.ms/powerbi-modeling-mcp-vscode](https://aka.ms/powerbi-modeling-mcp-vscode))
3. **Recharger VS Code** (Reload Window) si demandé

## 3. Vérification

1. Ouvrir Copilot Chat (icône en haut à droite ou `Ctrl+Alt+I`)
2. Ouvrir le sélecteur d'outils du chat (icône outils) : vérifier que **powerbi-modeling-mcp** est présent et sélectionné
3. Si absent : vérifier l'option GitHub.com (étape 1) — l'extension n'apparaît pas si elle est désactivée

## 4. Options du serveur (VS Code)

Paramètres utilisateur → rechercher `@ext:Microsoft.powerbi-modeling-mcp` :

| Option | Réglage conseillé |
|---|---|
| Mode d'écriture | **readwrite avec confirmation** (défaut) pour les démos ; **readonly** pour la découverte libre |
| `--skipconfirmation` | Déconseillé — valide toute écriture sans demander |

## 5. En secours : configuration manuelle (optionnel)

Si l'extension ne fonctionne pas (ou pour un autre client MCP), enregistrer le serveur via `npx` :

```json
{
  "servers": {
    "powerbi-modeling-mcp": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@microsoft/powerbi-modeling-mcp@latest", "--start"]
    }
  }
}
```

Créer `.vscode/mcp.json` à la racine du dépôt (ou configurer dans les paramètres VS Code).

## 6. Sources de démo

- Dossiers PBIP : `assets/modeles/altisport-v1/` (audit) et `assets/modeles/altisport-v2/` (cible) — ouvrir le dossier du dépôt dans VS Code
- Modèle v1 = terrain d'écriture des démos : **sauvegarder le dépôt (commit) avant la session**

## Checklist finale

- [ ] VS Code + Copilot Chat connectés ; extension Power BI Modeling MCP installée
- [ ] « MCP servers in Copilot » activée sur GitHub.com (comptes entreprise : admin OK)
- [ ] `powerbi-modeling-mcp` visible dans les outils de Copilot Chat
- [ ] Le dépôt s'ouvre dans VS Code ; `git status` propre (sauvegarde avant écritures)
- [ ] Prompt de test : `Open semantic model from PBIP folder 'assets/modeles/altisport-v1/altisport-v1.SemanticModel/definition' and give me an overview of the model.` → réponse avec les tables

En cas de blocage : [Troubleshooting du dépôt Microsoft](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md) — penser à vérifier la version de l'extension avant tout (Public Preview).