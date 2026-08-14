# Guide d'assemblage des modèles AltiSport v1 & v2

Pas-à-pas opérationnel pour construire les deux modèles de démonstration à partir des CSV bruts.

| Document | Rôle |
|---|---|
| [setup/01-powerbi-desktop.md](../../setup/01-powerbi-desktop.md) | **Prérequis** : configurer Desktop avant de commencer |
| [assets/README.md](../README.md) | **Spécification** : dictionnaire des données, schéma cible, mesures DAX, pièges pédagogiques |
| Ce guide | **Pas-à-pas** : cliquer dans le bon ordre |

---

## Phase A — Modèle v1 « mal préparé » (~15 min)

Objectif : montrer le pire. On importe brut et on ne corrige **rien**.

### A.1 — Import

1. `Fichier > Nouveau`
2. `Accueil > Obtenir des données > Fichier texte/CSV`
3. Aller dans `assets/data/brut/`, **multi-sélectionner les 6 CSV**, `Ouvrir`
4. Liste déroulante du bouton **Combiner** > **Combiner et charger**
5. Si demandé : origine **Français (France)**, délimiteur `;` (auto-détecté normalement) > `OK`

### A.2 — Vérifier que tout est sale (voulu)

Vue Table, contrôler :

- [ ] `ventes` : `DtVte` et montants en **texte** (alignés à gauche), `Canal` / `StatutCde` en casse incohérente
- [ ] Noms de tables d'origine (ventes, produits…) — pas de Dim/Fact
- [ ] Aucune mesure créée

Si une colonne s'est typée automatiquement (rare), laisser tel quel — ne rien réparer.

### A.3 — Vérifier l'absence de relations

Vue Modèle : 6 tables **sans aucun trait**. Si des traits existent, la détection auto est encore active (voir setup 01 §3) : supprimer les traits et rectifier le paramétrage.

### A.4 — Enregistrer en .pbip

1. `Fichier > Enregistrer sous` > `assets/modeles/altisport-v1/` > nom `altisport-v1` > type **Projet Power BI (*.pbip)**
2. Résultat attendu : `altisport-v1.pbip` + dossiers `altisport-v1.Report\` et `altisport-v1.SemanticModel\`
3. `Fichier > Fermer`

Usage : démo « avant/après » (fiche 01), terrain d'audit MCP (module 04).

---

## Phase B — Modèle v2 « bien préparé » (~75 min)

### B.1 — Import et nettoyage Power Query (20 min)

1. Nouveau fichier > importer les 6 CSV comme en A.1
2. `Transformer les données` > renommer les requêtes (Propriétés de la requête) : `FactVentes`, `DimProduit`, `DimMagasin`, `DimVendeur`, `DimClient`, `DimDate`
3. **FactVentes** :
   - Renommer les colonnes selon le dictionnaire ([README, schéma cible](../README.md#schéma-cible-star-schema)) : VenteID, DateVente, StatutCommande, IdProduit, Quantite, TauxRemise, MontantBrutTTC, MontantNetTTC, CoutLigne, IdMagasin, IdVendeur, IdClient
   - Montants et taux : clic droit sur les colonnes > **Type modifié > Avec paramètres régionaux** > Français (France) > Décimal
   - `DateVente` : type modifié avec paramètres régionaux FR > Date ; puis `Ajouter une colonne > Colonne à partir d'exemples` ou colonne personnalisée pour `DateKey` (AAAAMMJJ, nombre entier) — ex. `Number.FromText(Date.ToText([DateVente], "yyyyMMdd"))`
   - `Canal` et `StatutCommande` : `Transformer > Format > Mettre en majuscule la première lettre` (+ `Nettoyer > Supprimer les espaces`)
   - **Ne pas filtrer** les Annulées : la mesure *Total Ventes* s'en charge (pédagogie fiche 01)
4. **Dimensions** : renommages métier + typage (décimal FR pour PrixUnitaireTTC/CoutAchat, dates FR pour DateOuverture/DatePremierAchat, entier pour CibleMensuelle/DateKey) — table par table dans le dictionnaire du README
5. `Accueil > Fermer et appliquer`

### B.2 — Star schema (10 min)

Vue Modèle, créer les relations (glisser la clé de la dimension vers la fact, cardinalité 1 → *) :

| Dimension (1) | FactVentes (*) |
|---|---|
| DimDate[DateKey] | DateKey |
| DimProduit[IdProduit] | IdProduit |
| DimMagasin[IdMagasin] | IdMagasin |
| DimVendeur[IdVendeur] | IdVendeur |
| DimClient[IdClient] | IdClient |

Puis : masquer toutes les clés côté FactVentes ; `DimDate > Marquer comme table de dates`.

### B.3 — Mesures (20 min)

1. `Accueil > Entrer des données` : table vide nommée `Mesures`
2. Créer les **9 mesures** définies dans le README (section « Mesures à créer ») : copier DAX **et descriptions** (< 200 caractères, c'est la spec)
3. Organiser : masquer les colonnes de la table Mesures si besoin

### B.4 — Hiérarchies et calculation group (10 min)

- Hiérarchies (clic droit sur colonne > Créer une hiérarchie) :
  - DimDate : Année > Trimestre > Mois
  - DimMagasin : Secteur > Ville
  - DimProduit : Categorie > SousCategorie
- Calculation group « Intelligence temporelle » via **Outils externes > Tabular Editor** : groupe + colonne `Calcul`, items Current / YTD / PY / YOY / YOY % avec `SELECTEDMEASURE()` ; **documenter les items dans la description de la colonne** (fiche 01) ; Enregistrer les modifications dans le modèle

### B.5 — Configuration Copilot-ready (10 min)

1. Bouton **Prep data for AI** (activer Q&A si proposé)
2. *Simplify data schema* : tout sélectionner **sauf** Total Marge, Taux de Marge, CoutLigne/PrixUnitaireTTC/CoutAchat et colonnes techniques
3. *Add AI instructions* : coller le bloc FR de [vocabulaire-metier.md](../vocabulaire-metier.md)
4. Volet Copilot > skill picker > *Answer data question* : tests rapides — « ventes par secteur » (→ Secteur magasin), « ventes saison blanche 2025 », « champions du mois »
5. `Fichier > Enregistrer sous` > `assets/modeles/altisport-v2/` > `altisport-v2` > type **.pbip**

---

## Phase C — Vérification & intégration (10 min)

Checklist avant commit :

- [ ] v1 s'ouvre sans relation et sans mesure
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
