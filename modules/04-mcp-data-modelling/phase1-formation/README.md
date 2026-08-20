# Phase 1 — Formation & démonstrations

Session avec démonstrations sur les modèles AltiSport **v1** (mal préparé — terrain d'audit) et **v2** (bien préparé — cible), ouverts en PBIP dans VS Code et connectés via le Power BI Modeling MCP Server. Environnement installé avant la session ([setup/02](../../../setup/02-vscode-mcp.md)).

## Agenda indicatif (demi-journée)

| Horaire | Séquence | Fiche | Format |
|---|---|---|---|
| 09h00 | Accueil, concepts MCP, connexion et premier prompt | [01](01-mcp-et-vscode.md) | Théorie + démo |
| 09h40 | Audit d'un existant : v1 sous la loupe, rapport gradué, corrections | [02](02-audit-existant.md) | Démo (charnière du module) |
| 10h50 | Pause | — | — |
| 11h05 | Documentation : descriptions en masse + document du modèle | [03](03-documentation.md) | Démo |
| 11h50 | Synthèse et cadrage des ateliers Phase 2 | — | — |

## Matériel de démo requis

- VS Code avec Copilot Chat, extension **Power BI Modeling MCP** active, option MCP activée sur GitHub.com (voir [setup/02](../../../setup/02-vscode-mcp.md))
- Dossiers PBIP `altisport-v1` et `altisport-v2` ouverts dans le workspace VS Code
- Un modèle publié en workspace Fabric (optionnel — pour la démo de connexion service)
- Sauvegarde Git propre du dépôt avant la session (les démos écrivent dans v1)

## Rappel des conventions

- Chaque fiche : objectifs > concepts > matériel de démo > pas-à-pas / cas d'usage > limites et pièges > sources — la section *Matériel de démo* pointe les assets AltiSport à ouvrir (chemins, usage, déroulé)
- Prompts d'exemple **en anglais** avec traduction française
- Les démonstrations utilisent le jeu générique AltiSport ; l'application sur les modèles réels du client se fait en [Phase 2](../phase2-ateliers/)