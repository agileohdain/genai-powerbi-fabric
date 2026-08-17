# Setup 03 — Copilot CLI + plugin Skills for Fabric + CLIs Power BI

Configuration de l'environnement du module 05 : **GitHub Copilot CLI (ou VS Code) + plugin `powerbi-authoring` (Skills for Fabric) + CLIs Power BI** (`powerbi-report-author`, `powerbi-desktop`). À faire une fois par poste (~20 minutes).

> Ce guide remplace l'ancienne mention « fab CLI » : l'installation officielle des skills Power BI passe par le plugin Copilot, pas par la fab CLI.

## 1. Prérequis

| Élément | Exigence |
|---|---|
| GitHub Copilot | Abonnement **Pro** ou **Business** ; compte GitHub connecté |
| Node.js | **18 ou plus** (20+ recommandé pour les CLIs) — `node --version` |
| Power BI Desktop | À jour (setup 01) ; **fonctionnalité Desktop Bridge en aperçu activée** (étape 4) |
| Dépôt formation | Cloné localement ; PBIP v2 + rapport legacy dans `assets/modeles/` |

## 2. Installer le plugin Skills for Fabric (GitHub Copilot CLI)

```bash
copilot plugin marketplace add microsoft/skills-for-fabric
copilot plugin install powerbi-authoring@fabric-collection
```

> **VS Code** : le plugin s'installe aussi via l'éditeur de personnalisations d'agents VS Code (`Code > Settings > Customize AI`) en recherchant `powerbi-authoring`. Le module 05 utilise indifféremment Copilot CLI ou VS Code.

Vérifier que les skills sont chargés (dans Copilot) :

```text
/skills
```

`semantic-model-authoring`, `powerbi-report-design`, `powerbi-report-authoring`, `powerbi-report-planning`, `powerbi-report-management` doivent apparaître. Le plugin enregistre aussi le **Power BI Modeling MCP server** (module 04).

## 3. Installer les CLIs Power BI (Node)

```bash
npm install -g @microsoft/powerbi-report-authoring-cli@latest @microsoft/powerbi-desktop-bridge-cli@latest
powerbi-report-author --version   # validation PBIR, catalogue des visuels, métadonnées de formatage
powerbi-desktop --version         # pilotage Desktop : open, status, reload, screenshot
```

> Ces CLIs sont les « mains » du skill `powerbi-report-authoring` : tout ce que l'agent écrit dans les fichiers PBIR est validé par `powerbi-report-author`, tout rendu est vérifié par `powerbi-desktop`.

## 4. Activer la fonctionnalité Desktop Bridge dans Power BI Desktop

1. Desktop > `Fichier > Options et paramètres > Options > Fonctionnalités en aperçu`
2. Activer **Power BI Desktop Bridge** (nom exact selon la version ; chercher « Desktop Bridge »)
3. Redémarrer Desktop

Sans ce pont, le skill ne peut ni recharger le rapport ni faire de capture d'écran (boucle de vérification du module 05).

## 5. Vérification

1. Ouvrir un terminal dans `assets/modeles/altisport-rapport-legacy/`
2. Lancer Copilot CLI (`copilot`) et demander :
   `List the visuals in the legacy report and identify which ones use deprecated visual types.`
   → l'agent doit lister les visuels (card, table, matrix…) et signaler les types dépréciés
3. Tester la validation hors agent :
   `powerbi-report-author validate altisport-rapport-legacy.Report` → `succeeded`
4. Ouvrir le rapport legacy dans Desktop (double-clic sur le `.pbip`) : les 2 pages s'affichent avec des données

## 6. Sources de démo

- **Rapport vide v2** (`assets/modeles/altisport-v2/`) : création et charte visuelle (fiche 02)
- **Rapport legacy** (`assets/modeles/altisport-rapport-legacy/`) : refactoring et traduction (fiche 03)
- **Thème AltiSport** (`assets/theme-charte.json`) : charte à appliquer
- ⚠️ Le rapport legacy partage le modèle v2 (copie) : **commiter le dépôt avant les sessions d'écriture**

## Checklist finale

- [ ] Copilot CLI installé et connecté ; plugin `powerbi-authoring` installé (`/skills` liste les 5 skills)
- [ ] Node.js 18+ ; CLIs `powerbi-report-author` et `powerbi-desktop` répondent
- [ ] Desktop Bridge activé dans les aperçus de Desktop
- [ ] `powerbi-report-author validate` passe sur `altisport-rapport-legacy.Report`
- [ ] Prompt de test : liste des visuels + types dépréciés dans le rapport legacy

En cas de blocage : [Troubleshooting de Skills for Fabric](https://github.com/microsoft/skills-for-fabric/issues) et [docs Power BI Agentic](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-agentic-overview).
