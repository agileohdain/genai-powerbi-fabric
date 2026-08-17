# Fiche 02 — Charte visuelle & création de rapport : du brief au rendu

> C'est ici que le module 05 « paie » : un designer ou un PPT de charte devient un rapport construit, thématisé et vérifié — le tout piloté en langage naturel depuis VS Code / Copilot CLI.

## Objectifs

- Comprendre le **design brief** produit par `powerbi-report-design` (quoi et pourquoi)
- Créer un rapport sur le modèle v2 depuis une demande « design » (page d'accueil + détail)
- Appliquer la **charte AltiSport** (`assets/theme-charte.json`) : couleurs, typographie
- Transformer une **maquette/client PPT** en inputs de design (images de référence, tone)
- Vérifier avec la boucle Validate → Reload → Screenshot

## Concepts

### `powerbi-report-design` : le « brief » avant le code

Ce skill **ne touche pas aux fichiers** : il réfléchit et produit un contrat (design brief) avec des choix concrets :

- **tone** (ambiance : exécutif, minimaliste, éditorial…) et **signature** (le geste visuel récurrent)
- **archétype par page** (pas par rapport) : Executive Summary, Analytical Canvas, Operational Monitor, Comparative Benchmark, Narrative Story + variante de layout (A/B/C)
- **choix de graphiques** guidés par la question analytique (hiérarchie d'encodage)
- **couleurs, typographie, thème** — alignés sur la charte
- **accessibilité** (contraste, alt text) et **anti-patterns** (appels redondants, champs bruts)

Le brief est le **contrat** transmis à `powerbi-report-authoring` qui, lui, écrit la mécanique (JSON PBIR, positions, formatage). Le skill autorise ensuite l'implémentation : on ne passe à l'écriture qu'une fois le brief approuvé.

> Le design skill **pose des options nommées** quand la demande est vague (« 2-3 propositions ») et ne devine pas. C'est une bonne pratique à conserver même sans ce skill.

### Cas « charte / PPT client → rapport »

La charte du client arrive souvent comme un **PowerPoint ou des maquettes** (pas un fichier theme JSON). Deux approches complémentaires :

1. **Donner les images** à l'agent (coller des captures de pages PPT/charte dans le chat) : il en extrait tone, couleurs, style pour bâtir le brief
2. **Fournir un theme JSON** quand on l'a (cas AltiSport : `assets/theme-charte.json` déjà fourni)

## Pas-à-pas — créer un rapport thématisé sur v2

Prérequis : [setup/03](../../../setup/03-skills-copilot-cli.md) suivi ; rapport **vide** `altisport-v2` ouvert en PBIP dans VS Code ; Desktop avec le PBIP ouvert.

### 1. Inspirer le design avec la charte

Prompt (mode agent) :

```
Here is the AltiSport brand chart (assets/theme-charte.json). Inspect the AltiSport semantic model,
then write a design brief for a 2-page sales report: Exec landing page + store detail page.
```

*Voici la charte de marque AltiSport (assets/theme-charte.json). Inspecte le modèle sémantique AltiSport puis écris un brief de design pour un rapport de ventes de 2 pages : page exécutif (landing) + page détail magasin.*

L'agent charge `powerbi-report-design`, inspecte le modèle (via le MCP module 04 ou les TMDL), et répond avec un **design brief** structuré (archetypage par page, choix de graphiques, mapping couleurs mesures).

### 2. Faire approuver le brief

Relire le brief en cherchant : archetype pertinent pour chaque page, mapping de couleurs explicite (Total Ventes = couleur cible), pas de fausse donnée prévue, positions non chevauchantes. Demander des ajustements si besoin, puis **approuver**.

### 3. Implémenter avec `powerbi-report-authoring`

Prompt (mode agent) :

```
Approve the brief. Implement the final design into altisport-v2 using powerbi-report-authoring.
Bind visuals to the semantic model measures (Total Ventes, Total Marge, Quantité Vendue).
Apply the AltiSport theme. Validate, reload and screenshot after each batch.
```

*J'approuve le brief. Implémente le design final dans altisport-v2 avec powerbi-report-authoring. Lie les visuels aux mesures du modèle (Total Ventes, Total Marge, Quantité Vendue). Applique le thème AltiSport. Valide, recharge et capture après chaque lot.*

L'agent écrit les fichiers PBIR, applique le thème (CustomTheme enregistré dans `report.json` + `StaticResources/RegisteredResources/`), puis enchaîne la boucle jusqu'à validation + captures propres.

### 4. Vérifier le rendu

```bash
powerbi-report-author validate altisport-v2.Report
powerbi-desktop status        # choisir le bon PID
powerbi-desktop reload
powerbi-desktop screenshot-all
```

Examiner les captures : données visibles, couleurs charte appliquées, titres pertinents (pas de noms bruts type `FactVentes`, `MontantNetTTC`), aucun visuel vide.

## Limites et pièges

| Symptôme | Cause courante | Correction |
|---|---|---|
| Thème non appliqué après reload | Thème **mis en cache par nom de fichier** dans Desktop | Renommer le theme avec un suffixe aléatoire, mettre à jour `report.json`, recharger ; ou fermer/rouvrir Desktop |
| Barres toutes de la même couleur | `defaultColor` sans sélecteur, ou palette par série non utilisée | Suivre le mapping couleurs du brief (theme `dataColors` ou `dataPoint.fill` par visuel) |

## Pour aller plus loin

- **`powerbi-report-planning`** orchestre Design → Authoring → Management : idéal pour une demande « crée tout un rapport » de bout en bout avec points d'approbation (le module reste volontairement manuel au contenu — le planneur est une option, pas une obligation)
- **PPT maquette → thème** : pour un client sans theme JSON, produire (avec l'agent) le fichier theme JSON à partir des couleurs extraites du PPT, puis l'appliquer comme ci-dessus — cohérent avec le thème fourni ici

## Sources

- [Report Design skill — vue d'ensemble](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-report-design-skill-overview)
- [Report Planner et Management — vue d'ensemble](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-planner-fabric-skill-overview)
- [Thème AltiSport](../../../assets/theme-charte.json) — charte fournie pour les démos
