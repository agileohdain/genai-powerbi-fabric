# Vocabulaire métier AltiSport

Source des **instructions IA** (fiche 03 du module 01) et des démos. À distribuer aux participants pour l'atelier 2, qui consiste à produire l'équivalent pour le vocabulaire de leur propre entreprise.

## Glossaire officiel AltiSport

| Terme | Définition officielle | Pattern (fiche 03) | Démo |
|---|---|---|---|
| **Ventes / CA** | Toujours la mesure *Total Ventes* : CA net TTC, commandes annulées exclues. **Jamais** la marge. | Mapping critique | Fiche 02 |
| **GPM** | Marge commerciale — mesure *Total Marge* | Mapping | Fiche 02 |
| **Secteur** | Zone géographique du magasin (Nord-Est, Nord-Ouest, Île-de-France, Sud-Est, Sud-Ouest). **Jamais** la catégorie de produit. | Mapping critique | Fiche 02 |
| **Saison blanche** | Décembre à février (pic hiver) | Période métier | Fiche 03 |
| **Saison verte** | Juin à août (pic été) | Période métier | Fiche 03 |
| **Hors-saison** | Mars à mai et septembre à novembre | Période métier | Fiche 03 |
| **Closers** | Les vendeurs AltiSport | Mapping 1:1 | Fiche 03 |
| **Champion** | Vendeur atteignant 100 % ou plus de sa cible mensuelle (*Atteinte Cible* ≥ 100 %) | Définition conditionnelle | Fiche 03 |
| **Comptoir** | Le canal Magasin (par opposition au Web) | Mapping 1:1 | Fiche 03 |
| **Panier** | Montant net TTC moyen par client (*Panier Moyen*) | Mapping | Fiche 03 |

## Instructions IA prêtes à coller (modèle v2)

Extrait aligné sur le template de la [fiche 03](../modules/01-preparation-copilot-ready/phase1-formation/03-instructions-ia.md) — à coller dans *Prep data for AI* > *Add AI instructions* :

```markdown
## Terminologie métier
- « Ventes » ou « CA » désigne toujours la mesure Total Ventes (net TTC, commandes annulées exclues). Ne jamais utiliser Total Marge pour une question sur les ventes.
- « GPM » désigne la marge : utiliser la mesure Total Marge.
- « Secteur » désigne la zone géographique du magasin (table DimMagasin, colonne Secteur). Ce n'est jamais la catégorie de produit.
- « Closers » désigne les vendeurs (table DimVendeur).
- « Comptoir » désigne le canal Magasin.

## Définitions conditionnelles
- « Champion » = vendeur dont l'Atteinte Cible est de 100 % ou plus sur le mois.

## Périodes métier
- « Saison blanche » = décembre à février.
- « Saison verte » = juin à août.
- « Hors-saison » = mars à mai et septembre à novembre.

## Règles d'analyse
- Analyser les ventes par mois par défaut.
- Quand une question mentionne une zone ou un secteur, découper par DimMagasin[Secteur].
- Pour le chiffre d'affaires, toujours exclure les commandes annulées (mesure Total Ventes le fait déjà).
```

## Version anglaise (tests bilingues / traduction)

```markdown
## Terminology
- "Sales" or "Revenue" always means the Total Ventes measure (net VAT-incl., cancelled orders excluded). Never use Total Marge.
- "Sector" means the store's geographic area (DimMagasin[Secteur]), never the product category.
- "Closers" refers to salespeople (DimVendeur).

## Definitions
- "Champion" = salesperson reaching 100% or more of their monthly target.

## Business periods
- "White season" = December to February. "Green season" = June to August. "Off-season" = March-May and September-November.
```
