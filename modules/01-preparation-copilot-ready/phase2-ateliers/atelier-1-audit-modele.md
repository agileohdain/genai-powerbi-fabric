# Atelier 1 — Audit du modèle

## Objectif

Évaluer le(s) modèle(s) réel(s) du client au regard des exigences Copilot-ready et produire un **plan d'action priorisé** avant toute configuration IA.

> La grille ci-dessous est **générique et réutilisable** : elle sert d'audit manuel ici, et de référentiel pour l'audit automatisé via MCP (module 04). Vous pouvez la réappliquer sur tous vos modèles.

## Mode d'emploi

1. Ouvrir le modèle dans Power BI Desktop (vue Modèle + vue Rapport) et/ou dans le service.
2. Parcourir chaque section de la grille ; pour chaque critère : statut (Conforme / À corriger / Non applicable), correctif proposé, priorité (Haute / Moyenne / Basse).
3. Conclure par un plan d'action : les points Haute priorité sont à traiter **avant** l'atelier 2.

## Grille d'audit Copilot-ready

### 1. Structure du modèle

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 1.1 | Schéma en étoile (faits + dimensions) respecté | Vue Modèle | Refactorer vers un schéma en étoile | Haute |
| 1.2 | Tables de faits clairement identifiables (nommage) | Vue Modèle | Renommer (`FactSales`…) | Moyenne |
| 1.3 | Tables de dimensions portant les attributs descriptifs | Vue Modèle | Extraire les dimensions | Haute |
| 1.4 | Relations explicites, logiques, cardinalité correcte | Gérer les relations | Corriger cardinalités / relations inactives documentées | Haute |
| 1.5 | Hiérarchies utiles définies (dates, géographie…) | Vue Modèle | Créer les hiérarchies | Basse |

### 2. Nommage

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 2.1 | Noms de colonnes sans ambiguïté, sans codes bruts | Vue Modèle / Power Query | Renommer (`Product Name` vs `ProdID`) | Haute |
| 2.2 | Mesures nommées de façon descriptive | Liste de champs | Renommer (`Average Customer Rating` vs `AvgRating`) | Haute |
| 2.3 | Homogénéité de nommage entre tables | Vue Modèle | Harmoniser les conventions | Moyenne |

### 3. Mesures et KPI

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 3.1 | Mesures pré-définies pour les besoins récurrents (YTD, croissance…) | Liste de champs | Créer les mesures courantes | Moyenne |
| 3.2 | Logique de calcul standardisée et expliquée | Définitions des mesures | Simplifier / documenter | Moyenne |
| 3.3 | KPI métier attendus par les utilisateurs présents | Entretien métier | Créer les KPI manquants | Haute |

### 4. Qualité des données

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 4.1 | Types de données corrects et cohérents | Propriétés de colonnes | Corriger les types | Haute |
| 4.2 | Valeurs standardisées (casse, libellés) | Aperçu des données | Nettoyer dans Power Query | Moyenne |
| 4.3 | Planification d'actualisation documentée | Paramètres du modèle / documentation | Communiquer la fraîcheur des données | Basse |

### 5. Métadonnées

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 5.1 | Descriptions sur tables, colonnes, mesures | Volet Propriétés | Rédiger (essentiel dans les **200 premiers caractères**) | Haute |
| 5.2 | Calculation groups documentés (items non exposés) | Propriétés de la colonne du groupe | Documenter les items dans la description | Moyenne |
| 5.3 | Schéma exploitable : champs pertinents visibles, champs techniques masqués | Vue Modèle | Masquer le technique, exposer le métier | Moyenne |

### 6. Sécurité

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 6.1 | RLS défini si données sensibles | Gérer les rôles | Créer les rôles | Haute |
| 6.2 | Prise en compte des limites RLS/OLS des réponses vérifiées | [Fiche 03](../phase1-formation/03-reponses-verifiees.md) | Ne pas exposer de réponse vérifiée sur données sensibles | Haute |

### 7. Volumes et indexation

| # | Critère | Où vérifier | Correctif type | Priorité par défaut |
|---|---|---|---|---|
| 7.1 | Entités (tables + colonnes) raisonnablement < 1 000 | Statistiques du modèle | Resserre le modèle | Moyenne |
| 7.2 | Valeurs texte < 100 caractères (au-delà : non indexées) | Aperçu des données | Raccourcir les libellés longs | Basse |
| 7.3 | Cardinalité globale sous controle (limite 5 M de valeurs) | Vue Modèle / stats | Limiter les colonnes à forte cardinalité exposées | Moyenne |

## Livrable de l'atelier

- Grille complétée (statuts + correctifs + priorités)
- Plan d'action priorisé : points Haute priorité traités avant l'atelier 2
- Décision sur le modèle pilote pour l'atelier 2

## Réutilisation

Cette grille sert de référentiel pour l'**audit automatisé via MCP** (module 04) : chaque critère peut être vérifié par un agent (audit & correction DAX, documentation générée). La version MCP générera un rapport d'audit au même format.
