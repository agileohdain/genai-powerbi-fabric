# Fiche 03 — Documentation : descriptions en masse et document du modèle

## Objectifs

- Ajouter des **descriptions** à toutes les tables, colonnes et mesures d'un modèle en une passe
- Générer un **document markdown** du modèle (structure, relations, mesures, pièges)
- Comprendre pourquoi la documentation alimente **tout** l'écosystème IA (module 01 fiche 02-03, module 02, module 03)
- Appliquer la **revue humaine** : la documentation générée se corrige, ne se publie pas telle quelle

## Concepts — deux niveaux de documentation

| Niveau | Objet | Consommé par | Outil |
|---|---|---|---|
| Descriptions du modèle | Métadonnées TMDL (tables, colonnes, mesures) | Copilot, data agents, utilisateurs du rapport | MCP server (bulk) |
| Document markdown | Fichier `.md` à côté du projet | Équipe, revues, onboarding | MCP server + gabarit |

Les descriptions du modèle sont la **condition n°1 de la qualité des réponses IA** (module 01) : une mesure sans description est une boîte noire pour Copilot et les data agents. La fiche 03 du module 01 (instructions IA) définit le contenu attendu ; ici on passe à l'échelle.

## Pas-à-pas — décrire AltiSport v1 en masse

### 1. Descriptions des mesures

```
Add descriptions to all measures in the 'altisport-v1' model. For each measure: explain in one or two sentences what it computes, the business logic, and when to use it. Use business-friendly language. Example for 'Total Ventes': 'Net revenue, excluding cancelled orders. Use for all sales questions.'
```

Traduction : *Ajoute des descriptions à toutes les mesures du modèle 'altisport-v1'. Pour chaque mesure : explique en une ou deux phrases ce qu'elle calcule, la logique métier et quand l'utiliser. Langage métier. Exemple pour 'Total Ventes' : « CA net, commandes annulées exclues. À utiliser pour toute question sur les ventes. »*

> Contrainte de qualité : les descriptions restent **sous 200 caractères** (limite de visibilité de Copilot) et **alignées sur le vocabulaire métier** ([vocabulaire-metier.md](../../../assets/vocabulaire-metier.md)).

### 2. Descriptions des tables et colonnes

```
Add descriptions to all tables and columns of the 'altisport-v1' model. One sentence per object: what a row represents, the business meaning of the column, any caveat (for example: 'Secteur' is a geographical area, not a product category).
```

Traduction : *Ajoute des descriptions à toutes les tables et colonnes du modèle 'altisport-v1'. Une phrase par objet : ce que représente une ligne, le sens métier de la colonne, les réserves éventuelles.*

### 3. Relire la passe de descriptions

- Ouvrir le **diff TMDL** : vérifier que chaque description a été ajoutée, qu'aucune n'est vide ou triviale
- Corriger les formulations avec des prompts ciblés : `Rewrite the description of the column 'MttTTcNet' in clearer business language.` (*Récris la description de la colonne 'MttTTcNet' dans un langage métier plus clair.*)
- Faire valider par le métier les définitions sensibles (ex. marge, cible, saisons)

## Pas-à-pas — document markdown du modèle

```
Generate a Markdown document for the semantic model 'altisport-v1' using this template: 1) Overview (purpose, star schema, granularity, time coverage) 2) Tables (facts and dimensions, key columns only) 3) Key DAX measures by business category (name, description, usage) 4) Relationships (one ASCII diagram, active relationships table, warnings) 5) Quick usage patterns (3-5) 6) Business glossary (10-15 terms) 7) Known pitfalls. Keep it factual: only what is observable in the model. Max 350 lines.
```

Traduction : *Génère un document markdown pour le modèle sémantique 'altisport-v1' selon ce gabarit : 1) Vue d'ensemble (objectif, schéma en étoile, granularité, couverture temporelle) 2) Tables (faits et dimensions, colonnes clés uniquement) 3) Mesures DAX clés par catégorie métier (nom, description, usage) 4) Relations (un diagramme ASCII, tableau des relations actives, avertissements) 5) Patterns d'usage rapide (3-5) 6) Glossaire métier (10-15 termes) 7) Pièges connus. Reste factuel : uniquement l'observable dans le modèle. 350 lignes max.*

> Le gabarit ci-dessus est le **standard d'équipe** de la formation (inspiré d'un template éprouvé) : sections fixes, granularité systématique, un seul diagramme, « uniquement l'observable », pas de section contacts. Le réutiliser tel quel en phase 2 assure l'homogénéité des documentations client.

### Revue humaine obligatoire

Le document généré est un **brouillon** : trois contrôles avant publication
1. **Exactitude** : les affirmations sont vérifiables dans le modèle (aucune déduction non sourcée)
2. **Pertinence** : les mesures documentées sont celles réellement utilisées (20/80), pas un catalogue exhaustif
3. **Longueur** : cible 270-350 lignes — la documentation qui dépasse n'est pas lue

## Limites et pièges

- Les descriptions trop longues sont tronquées par les expériences IA : viser < 200 caractères, l'essentiel d'abord
- La documentation générée reflète le modèle **tel qu'il est** — sur v1, elle documentera aussi les défauts (c'est un artefact utile à l'audit, pas un défaut)
- Ne pas documenter ce qui n'existe pas : l'agent ne doit pas « deviner » une granularité ou un usage
- Descriptions en **français** pour un modèle consommé par Copilot/data agents anglais : la langue de travail du modèle reste l'anglais (module 01) — adapter selon le public cible du modèle

## Sources

- [Power BI Modeling MCP Server (README)](https://github.com/microsoft/powerbi-modeling-mcp) — scénarios « Add descriptions », « Document your semantic model », « Generate a French translation »
- [Module 01 — schéma de données IA et instructions IA](../../01-preparation-copilot-ready/phase1-formation/) (descriptions < 200 caractères, contenu attendu)