# Guide d'assemblage des modèles AltiSport v1 & v2

Pas-à-pas opérationnel pour préparer les modèles de démonstration.

| Document | Rôle |
|---|---|
| [setup/01-powerbi-desktop.md](../../setup/01-powerbi-desktop.md) | **Prérequis** : configurer Desktop avant de commencer |
| [assets/README.md](../README.md) | **Spécification** : dictionnaire des données, schéma cible, mesures DAX, pièges pédagogiques |
| Ce guide | **Pas-à-pas** : cliquer dans le bon ordre |

> **Principe** : la formation n'est pas un cours de modélisation ni de Power Query. Les réglages par défaut de Power BI Desktop sont conservés (détection automatique des types et des relations active). Le modèle v1 est **fourni prêt à l'emploi** dans ce dépôt : on démarre toujours depuis `altisport-v1.pbip`, jamais depuis un fichier vierge.

---

## Modèle v1 « mal préparé » — fourni

### Ouvrir

1. Double-clic sur `assets/modeles/altisport-v1/altisport-v1.pbip` (ou Power BI Desktop > `Fichier > Ouvrir`)
2. C'est le point de départ de toutes les démos « avant/après » (fiche 01) et du terrain d'audit (module 04)

### État réel de v1 (ce que voient les participants)

Power BI Desktop ayant corrigé certains défauts à l'import (types, relations), l'état de v1 est :

| Élément | État dans v1 |
|---|---|
| Types | Auto-détectés : dates en date, montants en décimal (`MttBrutTTC` peut apparaître en entier — valeurs entières par nature) |
| Relations | Détectées automatiquement : ventes → produits / clients / magasins (actives), ventes → vendeurs (**inactive**), vendeurs → magasins ; `calendrier` reste **orphelin** |
| Noms | Bruts d'origine : `ProdID`, `Qt`, `MttTTcNet`, `CatLbl`, `CustNo`… |
| Casse | `Canal` et `StatutCde` incohérente (Magasin/MAGASIN/magasin, Livree/livree/LIVREE…) |
| Mesures | Aucune (mesures implicites seulement) |
| Métadonnées | Aucune description, aucune hiérarchie, table de dates non marquée |

### Annexe formateur — reproduire v1 si besoin

Uniquement si le `.pbip` fourni est perdu :

1. `Fichier > Nouveau` > `Accueil > Obtenir des données > Fichier texte/CSV`
2. Les CSV s'importent **un par un** (pas de multi-sélection) : ouvrir `ventes.csv` > `Charger`, puis répéter pour les 5 autres (calendrier, clients, magasins, produits, vendeurs)
3. Origine **Français (France)**, délimiteur `;` (auto-détecté) ; ne rien corriger
4. `Fichier > Enregistrer sous` > `assets/modeles/altisport-v1/` > `altisport-v1` > type **Projet Power BI (*.pbip)**

---

## À éviter — anti-patterns illustrés par v1

Matière de démo : ce que v1 montre et qu'il ne faut pas reproduire sur un modèle réel.

| # | Anti-pattern | Conséquence pour Copilot / l'analyse | Corrigé dans v2 par |
|---|---|---|---|
| 1 | S'appuyer sur les mesures implicites (« Somme de MttTTcNet ») | « Ventes » ne correspond à aucune mesure identifiée ; agrégations ambiguës | Mesures nommées et décrites (Total Ventes, Total Marge…) |
| 2 | Colonnes aux noms de codes (ProdID, Qt, MttTTcNet) | Le langage naturel ne fait le lien entre la question et le champ | Renommage métier complet |
| 3 | Casse incohérente (Magasin/MAGASIN/magasin) | 3 « canaux » distincts dans les regroupements et filtres | Normalisation Power Query |
| 4 | Commandes annulées non exclues | CA surévalué — Copilot répond faux sans le savoir | Mesures filtrant `StatutCommande <> "Annulée"` |
| 5 | Catégorie « Divers » (fourre-tout) | Réponses vagues, regroupements peu parlants | Nommage explicite des catégories |
| 6 | Table de dates non marquée + calendrier orphelin | Time intelligence impossible (YTD, N-1) ou résultats incohérents | DimDate marquée + relation DateKey |
| 7 | Relations non vérifiées (vendeurs inactive, dimension-dimension) | Analyse par vendeur fausse ; chemins de filtre douteux | Relations repensées en 1 → * vers la table de faits |
| 8 | Aucune description (tables, colonnes, mesures) | Copilot (requêtes DAX, recherche) perd le contexte métier | Descriptions < 200 caractères |

---

## Phase B — Modèle v2 « bien préparé » (~75 min)

Point de départ : `altisport-v1.pbip` ouvert.

### B.0 — Créer v2 depuis v1

1. `Fichier > Enregistrer sous` > `assets/modeles/altisport-v2/` > nom `altisport-v2` > type **Projet Power BI (*.pbip)**
2. Tout le reste de la phase B se fait dans `altisport-v2.pbip`

### B.1 — Nettoyage Power Query (20 min)

1. `Accueil > Transformer les données`
2. Renommer les requêtes (Propriétés de la requête) : `ventes`→**FactVentes**, `produits`→**DimProduit**, `magasins`→**DimMagasin**, `vendeurs`→**DimVendeur**, `clients`→**DimClient**, `calendrier`→**DimDate**
3. **FactVentes** — renommage des colonnes (dictionnaire : [README, schéma cible](../README.md#schéma-cible-star-schema)) : VenteID, DateVente, StatutCommande, IdProduit, Quantite, TauxRemise, MontantBrutTTC, MontantNetTTC, CoutLigne, IdMagasin, IdVendeur, IdClient
4. **FactVentes** — vérification des types (Desktop les a déjà détectés, on standardise) :
   - Montants et taux en **décimal** (`MttBrutTTC` peut être en entier : retyper en décimal pour l'homogénéité), `Quantite` en entier, `DateVente` en date
   - Ajouter la colonne **DateKey** (nombre entier) : `Ajouter une colonne > Colonne personnalisée` > `Number.FromText(Date.ToText([DateVente], "yyyyMMdd"))` > typer en entier
5. **FactVentes** — casse : `Canal` et `StatutCommande` > `Transformer > Format > Mettre en majuscule la première lettre` (+ `Nettoyer > Supprimer les espaces`)
6. **FactVentes** — **ne pas filtrer** les Annulées : la mesure *Total Ventes* s'en charge (pédagogie fiche 01)
7. **Dimensions** — renommages métier + vérification des types (décimal pour PrixUnitaireTTC/CoutAchat, dates, entier pour CibleMensuelle/DateKey), table par table selon le dictionnaire du README
8. `Accueil > Fermer et appliquer`

### B.2 — Relations (10 min)

Les relations auto-détectées existent mais need reprise. Vue Modèle :

1. **Activer** la relation ventes → vendeurs (inactive dans v1) : sélectionner le trait > cocher *Activer*
2. **Supprimer** la relation vendeurs ↔ magasins (dimension-dimension : chemin de filtre redondant avec ceux passant par la table de faits)
3. **Créer** la relation manquante : `DimDate[DateKey]` → `FactVentes[DateKey]` (calendrier orphelin dans v1)
4. Vérifier toutes les cardinalités **1 → \*** (dimension côté 1, fait côté *) et le sens de filtre
5. Masquer toutes les clés côté FactVentes ; `DimDate > Marquer comme table de dates`

Schéma cible complet : [README, schéma cible](../README.md#schéma-cible-star-schema).

### B.3 — Mesures (20 min)

1. `Accueil > Entrer des données` : table vide nommée `Mesures`
2. Créer les **9 mesures** définies dans le README (section « Mesures à créer ») : copier DAX **et descriptions** (< 200 caractères, c'est la spec)

### B.4 — Hiérarchies et calculation group (10 min)

- Hiérarchies (clic droit sur colonne > Créer une hiérarchie) :
  - DimDate : Année > Trimestre > Mois
  - DimMagasin : Secteur > Ville
  - DimProduit : Categorie > SousCategorie
- Calculation group « Intelligence temporelle » via **Outils externes > Tabular Editor** : groupe + colonne `Calcul`, items Current / YTD / PY / YOY / YOY % avec `SELECTEDMEASURE()` ; **documenter les items dans la description de la colonne** (fiche 01) ; enregistrer les modifications dans le modèle

### B.5 — Configuration Copilot-ready (10 min)

1. Bouton **Prep data for AI** (activer Q&A si proposé)
2. *Simplify data schema* : tout sélectionner **sauf** Total Marge, Taux de Marge, CoutLigne/PrixUnitaireTTC/CoutAchat et colonnes techniques
3. *Add AI instructions* : coller le bloc FR de [vocabulaire-metier.md](../vocabulaire-metier.md)
4. Volet Copilot > skill picker > *Answer data question* : tests rapides — « ventes par secteur » (→ Secteur magasin), « ventes saison blanche 2025 », « champions du mois »
5. `Ctrl+S` pour enregistrer le projet

---

## Phase C — Vérification & intégration (10 min)

Checklist avant commit :

- [ ] v1 s'ouvre : 6 tables en noms bruts, relations auto présentes, aucune mesure
- [ ] v2 : *Total Ventes* exclut les Annulées (comparer avec/sans filtre StatutCommande)
- [ ] v2 : « ventes par secteur » passe par DimMagasin[Secteur]
- [ ] v2 : instructions IA actives (test « saison blanche »)
- [ ] Les deux `.pbip` sont dans `assets/modeles/altisport-v{1,2}/`

Intégration Git (les `localSettings.json` et caches sont ignorés par le `.gitignore`) :

```powershell
git add assets/modeles
git commit -m "assets : modèles AltiSport v1 (brut) et v2 (Copilot-ready) au format PBIP"
git push
```
