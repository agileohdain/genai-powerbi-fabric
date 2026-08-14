# Assets — Jeu de données générique « AltiSport »

Sources partagées par tous les modules de la formation. Utilisé pour les **démonstrations Phase 1** ; la Phase 2 travaille sur les modèles réels du client (AltiSport reste disponible comme terrain d'entraînement).

## L'entreprise fictive

**AltiSport** — distributeur français d'articles de sport outdoor (ski, snowboard, randonnée, cyclisme, accessoires). 25 magasins dans 5 secteurs géographiques, 60 vendeurs avec cibles mensuelles, canaux magasin et web, clients particuliers / clubs / entreprises / collectivités. Historique de ventes : janvier 2024 → juillet 2026 (saisonnalité marquée hiver + été).

## Contenu du dossier

```
assets/
├── README.md               # Ce fichier : spécification, dictionnaire, guides d'assemblage
├── data/
│   ├── generer-donnees.ps1 # Script de génération déterministe (graine 20260814)
│   └── brut/               # Sources CSV « telles que sorties de l'ERP » (avec défauts volontaires)
├── vocabulaire-metier.md   # Jargon AltiSport : source des instructions IA (fiche 04)
├── theme-charte.json       # Thème Power BI AltiSport (v1 — enrichi au module 05)
└── modeles/                # Guide d'assemblage + projets PBIP altisport-v1 / altisport-v2
```

## Dictionnaire des données

Tous les fichiers : UTF-8 BOM, séparateur `;`. Montants et taux en **texte avec virgule décimale**, dates en **texte jj-mm-aaaa** (défaut volontaire, voir section suivante).

### `ventes.csv` — 8 000 lignes (2024-01 → 2026-07)

| Colonne | Signification | Défaut volontaire |
|---|---|---|
| VteID | Identifiant de ligne de vente (séquentiel) | — |
| DtVte | Date de vente | texte, pas date |
| Canal | Magasin / Web | **casse incohérente** (Magasin, MAGASIN, magasin, Web, WEB, web) |
| StatutCde | Livree / EnCours / Annulee | **casse incohérente** ; ⚠️ le CA doit exclure les Annulées |
| ProdID | Clé produit → produits.csv | nom de code |
| Qt | Quantité | nom de code |
| TxRem | Taux de remise (0 / 5 / 10 %) | texte |
| MttBrutTTC | Montant brut TTC (Qt × PU) | texte |
| MttTTcNet | Montant net TTC (après remise) | texte |
| CstLigne | Coût d'achat de la ligne (pour la marge) | texte |
| MagID / VndID / CustNo | Clés magasin / vendeur / client | noms de code |

### `produits.csv` — 64 produits

| Colonne | Signification |
|---|---|
| ProdID / PrdLbl | Identifiant / libellé (Marque SousCat Modèle) |
| CatCd / CatLbl | Code et libellé catégorie (SKI, SNB, RAN, VEL, ACC) — ⚠️ CatLbl « Divers » pour les accessoires |
| SbCat / Marque | Sous-catégorie / marque |
| PU_TTC / CstA | Prix unitaire TTC / coût d'achat (**texte**) — l'écart entre les deux porte la marge |

### `magasins.csv` — 25 magasins

MagID, MagLbl, Ville, DeptCd, **Secteur** (Nord-Est, Nord-Ouest, Île-de-France, Sud-Est, Sud-Ouest), SurfM2, DtOuvert. ⚠️ « Secteur » = zone géographique — source de l'ambiguïté avec la catégorie produit.

### `vendeurs.csv` — 60 vendeurs

VndID, VndLbl, MagID (rattachement), **CibleMens** (cible mensuelle en € — sert à la définition « Champion », fiche 04).

### `clients.csv` — 220 clients

CustNo, CliLbl, TypCli (Particulier ~70 %, Club, Entreprise, Collectivité), Ville, Secteur, Dt1erAchat.

### `calendrier.csv` — 1 096 jours (2024-2026)

DateKey (AAAAMMJJ), Date, Annee, Trimestre, MoisNum, MoisLbl, JourNum, JourSemLbl, NumSem.

## Défauts volontaires (pièges pédagogiques)

| # | Piège | Où | Mis en évidence par |
|---|---|---|---|
| 1 | Montants et taux en texte (virgule) | ventes, produits | Fiche 01 (types), module 04 (audit) |
| 2 | Dates en texte | ventes, magasins, clients | Fiche 01 |
| 3 | Casse incohérente sur Canal / StatutCde | ventes | Fiche 01 — nettoyage Power Query |
| 4 | Commandes Annulées à exclure du CA | ventes.StatutCde | Fiche 01 — sinon le CA est faux |
| 5 | Noms de colonnes obscurs (ProdID, Qt, MttTTcNet…) | partout | Fiche 01 — renommage |
| 6 | CatLbl « Divers » (catégorie fourre-tout) | produits | Fiche 01 — nommage ambigu |
| 7 | « Secteur » géographique vs catégorie produit | magasins / produits | Fiches 02-03 — ambiguïté « ventes par secteur » |
| 8 | Deux indicateurs proches : ventes (MttTTcNet) vs marge (MttTTcNet − CstLigne) | ventes | Fiche 02 — schéma IA (Total Ventes vs Total Marge) |
| 9 | Saisonnalité double pic (hiver + été) | ventes | Fiche 04 — « Saison blanche » / « Saison verte » |
| 10 | Cibles mensuelles vendeurs | vendeurs | Fiche 04 — définition « Champion » |

## Assemblage des modèles

- Prérequis outils : [setup/01-powerbi-desktop.md](../setup/01-powerbi-desktop.md)
- Pas-à-pas opérationnel (v1 « mal préparé » et v2 « bien préparé ») : [modeles/guide-assemblage.md](modeles/guide-assemblage.md)

Les sections ci-dessous constituent la **spécification cible** de v2 (schéma, mesures, hiérarchies), référencée par le guide d'assemblage.

### Schéma cible (star schema)

| Table | Colonnes clés |
|---|---|
| **FactVentes** | VenteID, DateVente→DateKey, IdProduit, IdMagasin, IdVendeur, IdClient, Quantite, TauxRemise, MontantBrutTTC, MontantNetTTC, CoutLigne, Canal, StatutCommande |
| **DimDate** (marquée comme table de dates) | DateKey, Date, Année, Trimestre, Mois, Jour, Semaine |
| **DimProduit** | IdProduit, Produit, Catégorie, SousCatégorie, Marque, PrixUnitaireTTC, CoutAchat |
| **DimMagasin** | IdMagasin, Magasin, Ville, Département, Secteur, SurfaceM2, DateOuverture |
| **DimVendeur** | IdVendeur, Vendeur, IdMagasin, CibleMensuelle |
| **DimClient** | IdClient, Client, TypeClient, Ville, Secteur, DatePremierAchat |

Relations 1→* de chaque dimension vers FactVentes (clés DateKey / IdProduit / IdMagasin / IdVendeur / IdClient).

### Mesures à créer (avec descriptions < 200 caractères)

| Mesure | DAX | Description |
|---|---|---|
| Total Ventes | `CALCULATE(SUM(FactVentes[MontantNetTTC]), FactVentes[StatutCommande] <> "Annulée")` | CA net TTC, commandes annulées exclues. À utiliser pour toute question sur les ventes. |
| Total Marge | `CALCULATE(SUMX(FactVentes, [MontantNetTTC] - [CoutLigne]), FactVentes[StatutCommande] <> "Annulée")` | Marge commerciale (CA net − coût). Ne pas confondre avec les ventes. |
| Taux de Marge | `DIVIDE([Total Marge], [Total Ventes])` | Marge en % du CA net |
| Quantité Vendue | `CALCULATE(SUM(FactVentes[Quantite]), FactVentes[StatutCommande] <> "Annulée")` | Unités vendues, annulations exclues |
| Panier Moyen | `DIVIDE([Total Ventes], DISTINCTCOUNT(FactVentes[IdClient]))` | CA net moyen par client actif |
| Ventes YTD | `TOTALYTD([Total Ventes], DimDate[Date])` | Cumul annuel des ventes |
| Ventes N-1 | `CALCULATE([Total Ventes], SAMEPERIODLASTYEAR(DimDate[Date]))` | Ventes de la même période l'an dernier |
| Croissance Ventes % | `DIVIDE([Total Ventes] - [Ventes N-1], [Ventes N-1])` | Évolution vs même période N-1 |
| Atteinte Cible | `DIVIDE([Total Ventes], SELECTEDVALUE(DimVendeur[CibleMensuelle]))` | Ventes du vendeur vs sa cible mensuelle. « Champion » si ≥ 100 %. |

### Hiérarchies

- DimDate : Année > Trimestre > Mois
- DimMagasin : Secteur > Ville
- DimProduit : Catégorie > Sous-catégorie

### Calculation group (via Tabular Editor)

« Intelligence temporelle » : Current, YTD, PY, YOY, YOY % — documenter chaque item dans la description de la colonne du groupe (fiche 01).

## Mapping démos ↔ assets

| Démo | Assets mobilisés |
|---|---|
| Fiche 01 — avant/après | modèles v1 + v2 côte à côte |
| Fiche 02 — schéma IA | v2 : retirer Total Marge du schéma, demander « les ventes » |
| Fiche 03 — réponse vérifiée | v2 : « ventes par secteur » → visuel CA par DimMagasin[Secteur] |
| Fiche 04 — instructions IA | vocabulaire-metier.md (saisons, Champion, closers, comptoir) |
| Fiche 05 — HCAAT / diagnostics | v2 configuré |
| Module 02 (futur) — prompting, visuel narratif | v2 |
| Module 04 (futur) — audit MCP | v1 (audit) → corrections → v2 (cible) ; grille atelier-1 |
| Module 05 (futur) — charte, refactoring | theme-charte.json, rapport v2 à construire |

## Conventions PBIP & Git

- Enregistrer les modèles au format **PBIP** (Power BI Project) dans `assets/modeles/`
- Les fichiers `.pbi/localSettings.json` et caches sont ignorés via le `.gitignore` racine
- Ne jamais commiter de `.pbix` binaire
- Après assemblage : commiter le dossier du projet PBIP (TMDL lisible en diff)

## Régénération des données

Les CSV sont la source de vérité versionnée. Pour régénérer à l'identique (déterministe, graine 20260814) :

```powershell
pwsh -File assets/data/generer-donnees.ps1
```

Toute modification des données passe par le script (jamais d'édition manuelle des CSV).
