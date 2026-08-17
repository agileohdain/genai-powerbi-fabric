# Fiche 01 — Skills for Fabric : concepts, les 5 skills Power BI, boucle de vérification

> Fiche de fondations : un skill n'est pas un outil, c'est un **mode d'emploi chargé à la demande** que l'agent suit pour produire un travail exact et conforme — miroir du module 04, mais pour la **couche rapport** (pages, visuels, thème, layout) au lieu du modèle sémantique.

## Objectifs

- Distinguer **skill** (instructions) et **MCP** (outil) et situer le plugin `powerbi-authoring`
- Connaître les 5 skills Power BI et savoir **routage** une demande vers le bon
- Installer l'environnement (renvoi [setup/03](../../../setup/03-skills-copilot-cli.md)) et vérifier les CLIs
- Maîtriser la **boucle de vérification** Edit → Validate → Reload → Screenshot
- Comprendre les contraintes : PBIR uniquement, rapport ≠ modèle sémantique

## Concepts

### Skill vs MCP

| | Skill | MCP (module 04) |
|---|---|---|
| Nature | Dossier d'**instructions** (`SKILL.md` + références) que l'agent charge à la demande | Serveur d'**outils** que l'agent appelle pendant la conversation |
| Réponse | Le skill dit *quoi et pourquoi* (workflow, règles, pièges) | Le MCP *fait* (lit, écrit, exécute) |
| Couche Power BI | **Rapport** (pages, visuels, formatage, thème) — et modèle sémantique pour `semantic-model-authoring` | **Modèle sémantique** (tables, colonnes, mesures, DAX) |

`Skills : l'agent sait faire. MCP : l'agent sait toucher.` Le module 04 montait le MCP ; le module 05 simule le rapport.

### Le plugin `powerbi-authoring` (Skills for Fabric)

Le plugin est le paquet officiel Microsoft qui regroupe les skills Power BI + enregistre automatiquement le **Power BI Modeling MCP server** (module 04). Une seule installation (voir [setup/03](../../../setup/03-skills-copilot-cli.md)) donne les 5 skills suivants :

### Les 5 skills Power BI

| Skill | Rôle | Quand l'utiliser |
|---|---|---|
| **`powerbi-report-design`** | **Design** : produit un *design brief* (tone, signature, archétype par page, choix de graphiques, couleurs, typographie, thème) — n'écrit **rien** | « Fais un rapport pro », charte visuelle, critique d'un visuel existant (fiche 02) |
| **`powerbi-report-authoring`** | **Mécanique PBIR** : crée/modifie pages, visuels, filtres, formatage, thèmes ; valide avec `powerbi-report-author` et vérifie le rendu Desktop | Toute édition concrète de fichiers PBIR (fiches 02 et 03) |
| **`powerbi-report-planning`** | **Workflow guidé** : Define → Inspect → Brief → Approve → Build ; demande l'approbation avant d'écrire | « Crée un rapport complet à partir de ce modèle » avec étapes + validation humaine |
| **`powerbi-report-management`** | **Transport Fabric** : CRUD des rapports dans un workspace Fabric via l'API REST (`az rest`) | Publier/télécharger un rapport PBIR dans un workspace |
| **`semantic-model-authoring`** | **Modèle sémantique** : créer/modifier/déployer des modèles (Import, DirectQuery, Direct Lake), préparation IA | Renvoi vers le **module 04** ① |

① `semantic-model-authoring` recoupe largement le module 04 (audit, descriptions), qui reste la référence de la formation pour le modèle sémantique. Ce module 05 se concentre sur la **couche rapport**.

### Routage d'une demande

```
Demande « design » (à quoi ça ressemble ?)      → powerbi-report-design
Demande « mécanique » (ajoute ce visuel)        → powerbi-report-authoring
Demande « de bout en bout » (crée/plante)       → powerbi-report-planning  → (design puis authoring)
Publication dans Fabric                         → powerbi-report-management
Modèle sémantique                               → module 04 (MCP / semantic-model-authoring)
```

## Pas-à-pas — vérifier l'environnement et lire un rapport

### 1. Vérifier l'installation

1. Terminal dans `assets/modeles/altisport-rapport-legacy/`
2. `powerbi-report-author --version` et `powerbi-desktop --version` répondent (node disponible)
3. Dans Copilot, `/skills` liste au moins `powerbi-report-authoring` et `powerbi-report-design`
4. Desktop : fonctionnalité **Desktop Bridge** activée dans les aperçus (setup 03)

### 2. Inventorier un rapport avec la CLI (indépendant de l'agent)

```bash
powerbi-report-author preview-visuals altisport-rapport-legacy.Report
powerbi-report-author preview-pages altisport-rapport-legacy.Report
```

Ces commandes listent les pages et les visuels avec leur type — c'est le « diagnostic » avant toute intervention, le même que l'agent utilisera.

### 3. Premier prompt : l'audit de l'existant

Prompt (mode agent) :

```
List the visuals in the legacy report and identify deprecated visual types. Propose a migration plan.
```

*Liste les visuels du rapport legacy et identifie les types de visuels dépréciés. Propose un plan de migration.*

L'agent charge `powerbi-report-authoring`, lit les fichiers PBIR, et doit répondre avec la table `card`/`table`/`matrix` (dépréciés) et leur alternative moderne (`cardVisual`, `tableEx`, `pivotTable`).

### 4. La boucle de vérification (le réflexe du module)

```
1. Edit     — l'agent modifie les fichiers PBIR (JSON)
2. Validate — powerbi-report-author validate <dossier .Report>   → erreurs ? retour en 1
3. Reload   — powerbi-desktop reload (recharge Desktop sur les fichiers)
4. Screenshot — powerbi-desktop screenshot → examen visuel (layout, données, couleurs)
5. Clean    — validation + rendu propres → on conclut
```

> Règle d'or : **on ne conclut jamais sans validation ET screenshot**. Les deux contrôles se complètent : le validateur détecte la structure, la capture détecte le rendu (visuel vide, barres invisibles, texte tronqué).

## Limites et pièges

- **PBIR uniquement** : le skill ne lit pas le format PBIR-Legacy (anciens `report.json` monoblocs récupérés de Fabric) — vérifier `format=PBIR` lors d'un `getDefinition`
- **Le skill refuse de créer les visuels legacy** (`card`, `table`, `matrix`, `map`) : un terrain de démo « avant » doit être **pré-fabriqué** — c'est le rôle de `altisport-rapport-legacy` dans ce dépôt
- **Pas de mode opératoire à l'aveugle** : l'agent ne doit jamais inventer de JSON PBIR de tête — il consulte le CLI (`catalog`, `formatting`) et les références du skill ; s'il « devine », le rejeter
- `definition.pbir` pointe vers le modèle (`byPath`) : le skill ne touche pas au modèle sémantique — les changements de modèle = module 04
- Le rendu vérifie **Desktop** : le rapport doit être ouvert à jour ; les modifications non enregistrées dans Desktop écrasent/ignorent les fichiers (toujours sauvegarder avant de laisser l'agent itérer)
- **Sauvegarde avant écriture** : committer le dossier PBIP avant une session (le diff Git est la sauvegarde, comme au module 04)

## Sources

- [Power BI Agentic — vue d'ensemble (Microsoft Learn)](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-agentic-overview)
- [Skills for Fabric (dépôt Microsoft)](https://github.com/microsoft/skills-for-fabric)
- [Report Authoring skill — vue d'ensemble](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-report-authoring-skill-overview)
- [Setup 03 — Copilot CLI + plugin + CLIs](../../../setup/03-skills-copilot-cli.md)
