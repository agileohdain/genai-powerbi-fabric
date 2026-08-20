# Guide des modèles AltiSport — v1 vs v2

Les deux modèles sont **fournis finis** dans ce dépôt : rien à construire pendant la formation. Ce guide explique les **écarts entre v1 et v2** et **pourquoi** chaque changement améliore les réponses de Copilot.

| Document | Rôle |
|---|---|
| [setup/01-powerbi-desktop.md](../../setup/01-powerbi-desktop.md) | **Prérequis** : configurer Desktop (aperçus PBIP + Prep data for AI) |
| [assets/README.md](../README.md) | **Spécification** : dictionnaire des données, schéma cible, mesures, pièges pédagogiques |
| Ce guide | **Comparaison v1 → v2** et justification de chaque écart |

---

## Les deux modèles

| Modèle | Rôle | Usage |
|---|---|---|
| `altisport-v1.pbip` | Import brut des CSV ERP, défauts laissés tels quels (ce que Desktop ne corrige pas seul) | Démos « avant/après » (fiche 01), terrain d'audit (module 04) |
| `altisport-v2.pbip` | Mêmes données, modèle corrigé et préparé pour l'IA | Toutes les démos Copilot (fiches 02-04, modules 02 et 05) |
| `altisport-rapport-legacy.pbip` | **Couche rapport volontairement datée** sur le modèle v2 : visuels legacy (`card`, `table`, `matrix`), libellés EN, thème par défaut | Module 05 : refactoring de visuels, re-thémérisation, traduction (fiche 03), ateliers |

Ce que Power BI Desktop corrige **automatiquement** à l'import (types des montants et dates, relations) est identique dans v1 et v2 : ce ne sont pas des sujets de formation. Les écarts ci-dessous portent uniquement sur ce qui **subsiste** sans action humaine.

## Écarts v1 → v2 et justifications

### 1. Nommage métier

| v1 | v2 |
|---|---|
| Tables `ventes`, `produits`, `magasins`… | `FactVentes`, `DimProduit`, `DimMagasin`… |
| Colonnes `ProdID`, `Qt`, `MttTTcNet`, `CatLbl`, `CustNo`… | `IdProduit`, `Quantite`, `MontantNetTTC`, `Categorie`, `IdClient`… |

**Pourquoi** : Copilot établit le lien entre une question en langage naturel et les champs du modèle. « Montant net TTC » est reconnaissable ; `MttTTcNet` ne l'est pas. Chaque nom de code est une question ratée.

### 2. Casse normalisée

| v1 | v2 |
|---|---|
| Canal : Magasin / MAGASIN / magasin ; Statut : Livree / livree / LIVREE | Canal : Magasin / Web ; Statut : Livree / Encours / Annulee (Text.Proper + Trim) |

**Pourquoi** : sans normalisation, « magasin » et « MAGASIN » sont 3 valeurs distinctes → regroupements faux, filtres inopérants, et Copilot agrège incorrectement.

### 3. Mesures nommées et décrites (vs mesures implicites)

| v1 | v2 |
|---|---|
| Aucune mesure ; « Somme de MttTTcNet » implicite | Table `Mesures` : Total Ventes, Total Marge, Taux de Marge, Quantité Vendue, Panier Moyen, Ventes YTD, Ventes N-1, Croissance Ventes %, Atteinte Cible — chacune **décrite** (< 200 caractères) |

**Pourquoi** : quand un utilisateur demande « les ventes », Copilot doit trouver UNE mesure qui correspond. Une mesure nommée `Total Ventes` avec sa description est sélectionnée correctement ; une agrégation implicite ne l'est jamais. Les descriptions sont lues par Copilot (requêtes DAX, recherche) — les 200 premiers caractères seulement.

### 4. Commandes annulées exclues du CA

| v1 | v2 |
|---|---|
| Toutes les lignes additionnées → CA surévalué | Les mesures filtrent `StatutCommande <> "Annulee"` |

**Pourquoi** : sans ce filtre, Copilot répond juste « mécaniquement » mais **faux métier** — et personne ne le voit. La règle métier vit dans la mesure, pas dans un filtre de rapport : elle s'applique partout, uniformément.

### 5. Relations revues

| v1 | v2 |
|---|---|
| Relation vendeurs **inactive** ; relation vendeurs ↔ magasins (dimension-dimension) ; calendrier **orphelin** | Toutes les relations 1 → * actives vers FactVentes ; `DimDate[DateKey] → FactVentes[DateKey]` créée |

**Pourquoi** : relation inactive = analyse par vendeur silencieusement fausse ; calendrier orphelin = pas de time intelligence (YTD, N-1) ou résultats incohérents. Copilot hérite du modèle : un modèle faux produit des réponses fausses avec assurance.

### 6. DimDate marquée comme table de dates

**Pourquoi** : indispensable au fonctionnement fiable des fonctions temporelles DAX (TOTALYTD, SAMEPERIODLASTYEAR) que les mesures YTD / N-1 utilisent — et que Copilot sollicite dès qu'une question mentionne une période.

### 7. Clés techniques masquées

| v1 | v2 |
|---|---|
| Toutes les colonnes visibles (IdProduit, DateKey, VenteID…) | Clés masquées côté fait et dimensions ; seuls les champs métier restent visibles |

**Pourquoi** : moins de bruit dans le schéma présenté à Copilot → moins d'ambiguïté et un schéma IA plus simple à resserrer (fiche 02). Les clés restent utilisables par les mesures (le masquage n'affecte pas le DAX).

### 8. Hiérarchies

v2 ajoute : Hiérarchie Dates (Annee > Trimestre > Mois), Hiérarchie Géographie (Secteur > Ville), Hiérarchie Produits (Categorie > SousCategorie).

**Pourquoi** : les questions métier sont naturellement hiérarchiques (« ventes par secteur puis ville ») ; les hiérarchies guident l'exploration et le drill-down proposés par Copilot.

### 9. Configuration Copilot (Prep data for AI)

> ⏳ **À appliquer après activation de Copilot par l'admin** (prérequis de licences et tenant : [docs/01-prerequis-admin](../../docs/01-prerequis-admin/)). Le modèle v2 est fonctionnel sans cette étape ; elle est requise pour les démos des fiches 02 à 04.

À appliquer dans Power BI Desktop (bouton **Prep data for AI**) :

1. **Schéma de données IA** : tout sélectionner **sauf** Total Marge, Taux de Marge, PrixUnitaireTTC, CoutAchat, CoutLigne, `DimClient[Secteur]` et colonnes techniques → « ventes » ne peut plus être confondu avec la marge, et « ventes par secteur » répond directement par `DimMagasin[Secteur]` sans demande de clarification (démo fiche 02)
2. **Instructions IA** : coller le bloc FR de [vocabulaire-metier.md](../vocabulaire-metier.md) → saisons, Champion, closers, comptoir (démo fiche 03)

---

## Emplacement des données : paramètre `DossierData`

Les 6 requêtes Power Query lisent les CSV via le paramètre **`DossierData`** (valeur par défaut : `C:\dev\genai-powerbi-fabric\assets\data\brut`).

Si le dépôt est ailleurs sur ton poste : `Transformer les données > Gérer les paramètres > DossierData` > modifier le chemin > `Fermer et appliquer`. Une seule valeur à changer pour les 6 tables de v2. (v1 pointe encore en chemin absolu : `Transformer les données > Modifier la source` sur chaque requête si nécessaire.) Le clonage standard du dépôt ([setup/00](../../setup/00-recuperer-depot.md)) pose ce chemin par défaut — cette adaptation ne concerne que les postes hors gabarit.

## Pour aller plus loin : calculation groups

Non implémentés dans v2 (les mesures YTD / N-1 explicites suffisent aux démos). Principe : appliquer des variantes de calcul (YTD, N-1, YOY…) à toutes les mesures sans multiplier les mesures — un modèle plus épuré est aussi plus lisible pour Copilot. Leurs items n'apparaissant pas dans les métadonnées, on les documente dans la description de la colonne du groupe (fiche 01). La création passe par un outillage externe ou l'API : hors périmètre de la formation.

---

## Annexe formateur — comment les modèles ont été produits

Uniquement pour reproduire les modèles si les `.pbip` étaient perdus :

**v1** : importer les 6 CSV de `assets/data/brut/` **un par un** (`Obtenir des données > Fichier texte/CSV`, origine Français (France), délimiteur `;`), ne rien corriger, enregistrer en `.pbip`.

**v2** (depuis une copie de v1) :
1. Power Query : renommage des requêtes et colonnes (voir [schéma cible](../README.md#schéma-cible-star-schema)) ; `Text.Proper` + `Trim` sur Canal/StatutCommande ; colonne `DateKey` = `Number.FromText(Date.ToText([DateVente], "yyyyMMdd"))` ; `PrixUnitaireTTC` retype en décimal ; ne pas filtrer les Annulées
2. Vue Modèle : activer la relation vendeurs, supprimer vendeurs ↔ magasins, créer `DimDate[DateKey] → FactVentes[DateKey]`, masquer les clés, marquer DimDate comme table de dates
3. Table `Mesures` vide + les 9 mesures (DAX et descriptions dans le [README](../README.md#mesures-table-dédiée-descriptions--200-caractères))
4. Hiérarchies (clic droit sur colonne > Créer une hiérarchie)
5. **Prep data for AI** : schéma IA sans la marge, instructions IA (section 9 ci-dessus)

Spécification complète (dictionnaire, pièges, mapping démos) : [assets/README.md](../README.md).

---

## Le rapport legacy (module 05)

`altisport-rapport-legacy.pbip` est un projet PBIP autonome (rapport + **copie** du modèle sémantique v2) dont la **couche rapport** est volontairement « à rénover » — c'est son seul intérêt.

### Structure

| Élément | Valeur |
|---|---|
| Pages | 2 : `Sales Overview` (EN), `Stores Analysis` (EN) |
| Visuels legacy | `card` ×2, `table` ×1, `matrix` ×1 (types modernes dérivés : 2 graphiques, 1 slicer, 2 textboxes) |
| Libellés | EN (titres de pages, titres de visuels, textboxes) — cible de la démo de traduction |
| Thème | Thème de base par défaut (pas la charte AltiSport) — cible de la démo de charte |
| Données | Lecteur de données via le même paramètre `DossierData` (les requêtes sont celles du modèle v2 copié) |

### Pourquoi une copie du modèle v2

- Le rapport ne peut pas partager le dossier PBIP de v2 (un projet PBIP = 1 rapport + 1 modèle) ; la copie le rend **autonome et reproductible**
- Le **périmètre d'écriture du module 05 est le rapport uniquement** : le modèle copié n'est pas modifié pendant les démos (un changement de modèle = module 04)
- ⚠️ La copie **dérive** si v2 évolue : pour la resynchroniser, recopier `assets/modeles/altisport-v2/altisport-v2.SemanticModel/` vers `.../altisport-rapport-legacy.SemanticModel/` (tout sauf `.pbi/`) puis vérifier l'ouverture du `.pbip`

### Vérifier / reproduire

- Validation hors Desktop : `powerbi-report-author validate altisport-rapport-legacy.Report` (=> `succeeded`)
- Ouverture : double-clic sur `altisport-rapport-legacy.pbip` (Desktop à jour, voir [setup/01](../../setup/01-powerbi-desktop.md))
- Le rapport legacy s'appuie sur le [setup/03 — Copilot CLI + plugin + CLIs](../../setup/03-skills-copilot-cli.md)
