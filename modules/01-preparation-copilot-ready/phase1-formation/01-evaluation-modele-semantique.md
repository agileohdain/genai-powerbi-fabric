# Fiche 01 — Évaluer son modèle sémantique

> Fiche de référence de toute la formation pour les bonnes pratiques de modélisation. Les autres modules s'y réfèrent.

## Objectifs

- Auditer la structure, le nommage et les métadonnées d'un modèle avant toute utilisation par l'IA
- Comprendre en quoi chaque défaut du modèle dégrade directement les réponses de Copilot
- Identifier les correctifs prioritaires à appliquer

## Concepts clés

Un modèle bien conçu aide Copilot à produire des suggestions précises, y compris dans l'expérience de modélisation web où Copilot peut proposer et appliquer des changements (renommages, relations, mesures DAX). Un modèle mal nommé ou ambigu produit des interprétations erronées.

## Grille de bonnes pratiques

### Structure du modèle

| Élément | Bonne pratique | Où l'appliquer | Exemple |
|---|---|---|---|
| Relations | Définir clairement toutes les relations (un-à-plusieurs, plusieurs-à-plusieurs) et vérifier leur logique | Vue Modèle > Gérer les relations | `Date[DateID]` → `Sales[DateID]`, relation active |
| Tables de faits | Les identifier clairement par leur nom | Structure du modèle | `FactSales`, `FactTransactions` |
| Tables de dimensions | Contenir les attributs descriptifs liés aux mesures | Structure du modèle | `DimProduct` (ProductName, Category, Brand), `DimCustomer` |
| Hiérarchies | Créer des regroupements logiques pour le drill-down | Menu contextuel de table > Nouvelle hiérarchie | `Date` : Année > Trimestre > Mois > Jour |
| Types de relations | Préciser actif/inactif et cardinalité | Propriétés de relation | `Product` → `Sales` en plusieurs-à-un (actif) |

### Mesures et KPI

| Élément | Bonne pratique | Exemple |
|---|---|---|
| Nommage des mesures | Noms explicites reflétant le calcul et l'usage | `Average Customer Rating` plutôt que `AvgRating` |
| Logique de calcul | Standardisée, facile à expliquer | `Total Sales = SUM(Sales[SaleAmount])` avec description « Somme de tous les montants de vente » |
| Mesures pré-définies | Créer comme mesures nommées les calculs récurrents ; sinon Copilot improvise le DAX à chaque question (ex. YTD sur exercice fiscal décalé) | `YTD Sales`, `MoM Growth` |
| KPI métier | Créer uniquement les indicateurs réellement pilotés, avec leurs libellés internes exacts ; un KPI inutilisé est du bruit pour Copilot | `ROI`, `CAC`, `LTV` |

### Colonnes et qualité des données

| Élément | Bonne pratique | Exemple |
|---|---|---|
| Noms de colonnes | Sans ambiguïté, autoporteurs ; éviter les ID/codes bruts | `Product Name` plutôt que `ProdID` |
| Types de données | Corrects et cohérents dans toutes les tables | `Sales[SaleAmount]` en décimal (pas en texte) |
| Cohérence des valeurs | Valeurs standardisées (casse, libellés) | `Open`, `Closed`, `Pending` — pas de `open`, `CLOSED` |

### Métadonnées et documentation

| Élément | Bonne pratique | Point d'attention |
|---|---|---|
| Descriptions (tables, colonnes, mesures) | Saisie manuelle au cas par cas (volet Propriétés) ; pour une passe en masse sur tout le modèle, préférer le MCP server ([module 04, fiche 03](../../04-mcp-data-modelling/phase1-formation/03-documentation.md)) | **Copilot ne lit que les 200 premiers caractères** ; utilisées dans les requêtes DAX et la recherche |
| Calculation groups | Documenter les items de calcul dans la description de la colonne du groupe | Les items de calcul n'apparaissent pas dans les métadonnées du modèle |
| Actualisation | Communiquer les plannings de refresh | « Données actualisées chaque jour à 06h00 UTC » |
| Sécurité | Définir des rôles RLS si données sensibles | Vue Modèle > Gérer les rôles |

## Cas d'usage de démonstration

Présenter côte à côte deux versions du même modèle (mal nommé / bien nommé) et poser la même question à Copilot : la différence de qualité de réponse illustre immédiatement l'impact du nommage et des descriptions.

## Limites et pièges

- Ne pas raisonner « pour l'IA » uniquement : ces bonnes pratiques servent d'abord aux utilisateurs humains et aux outils d'audit
- Les descriptions longues sont tronquées à 200 caractères : mettre l'essentiel en premier
- Les colonnes cachées et techniques sont tolérées, mais elles ne doivent pas être celles que les utilisateurs demandent

## Sources

- [Optimize your semantic model for Copilot](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-evaluate-data)
- [Prepare your data for AI](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai)
