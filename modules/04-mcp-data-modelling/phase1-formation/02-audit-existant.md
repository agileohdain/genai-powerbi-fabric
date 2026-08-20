# Fiche 02 — Audit d'un existant : analyser, graduer, corriger

> Fiche charnière du module : l'audit est le cas d'usage qui justifie l'outil — un modèle existant qu'on ne connaît pas, audité et corrigé sans ouvrir la modélisation.

## Objectifs

- Conduire un **audit gradué** d'un modèle existant (v1 AltiSport) avec le MCP server
- Produire un **rapport d'audit markdown** classé par criticité (critique / important / recommandé)
- Choisir un **niveau de correction** et appliquer les corrections avec confirmation et diff Git
- Savoir lire un rapport d'audit : quoi corriger soi-même, quoi faire valider par le métier

## Concepts — la démarche d'audit

L'audit suit une séquence par phases (canevas inspiré de travaux d'équipe, transposé pour Copilot) :

1. **Périmètre** : modèle sémantique uniquement / rapport / les deux → en formation : modèle sémantique
2. **Structure** : schéma en étoile, table de dates, relations, types de colonnes, noms, colonnes inutiles
3. **Mesures DAX** : logique métier, performances (itérations, FILTER, DIVIDE), redondances, organisation
4. **Sécurité** : rôles RLS, cohérence, risques
5. **Rapport final** : synthèse graduée, score, niveau de correction proposé

Chaque constat est classé par **gravité** — c'est la convention de lecture commune au module et aux ateliers :

| Gravité | Impact | Exemple sur v1 |
|---|---|---|
| 🔴 Critique | Fiabilité ou performance majeure | Commandes annulées dans le CA, absence de table de dates, relations ambiguës |
| 🟠 Important | Impact significatif | Colonnes mal typées, mesures sans descriptions, noms obscurs |
| 🟡 Recommandé | Optimisation | Colonnes inutiles visibles, organisation des mesures |

Le rapport d'audit est un **document markdown** généré dans le projet (ex. `audit/altisport-v1_audit_20260817.md`) : il se committe, se partage, et sert de contrat de correction.

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Dossier PBIP **altisport-v1** | `assets/modeles/altisport-v1/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Terrain d'audit puis de correction |
| **guide-modeles.md** | [assets/modeles/guide-modeles.md](../../../assets/modeles/guide-modeles.md) | Référence de relecture : les écarts v1→v2 justifiés |
| Dépôt Git propre (`git status`) | Racine du dépôt | Sauvegarde avant les corrections (pas-à-pas, étape 4) |

## Pas-à-pas — audit d'AltiSport v1

### 1. Cadrer l'audit (prompt mode agent)

```
You are auditing the semantic model 'altisport-v1' (PBIP folder 'assets/modeles/altisport-v1'). Scope: semantic model only. Produce a structured audit with findings classified as CRITICAL / IMPORTANT / RECOMMENDED. Start with: table of contents, star schema check, date table check, relationships, column types, column naming, unused columns. Do not modify anything.
```

Traduction : *Tu audites le modèle sémantique 'altisport-v1'. Périmètre : modèle uniquement. Produis un audit structuré avec des constats classés CRITIQUE / IMPORTANT / RECOMMANDÉ. Commence par : sommaire, vérification du schéma en étoile, table de dates, relations, types de colonnes, nommage, colonnes inutiles. Ne modifie rien.*

> Dérouler l'audit **en plusieurs prompts** plutôt qu'un seul : la qualité baisse quand on demande tout d'un coup. Un prompt par phase (structure, puis DAX, puis sécurité), en demandant le rapport final à la fin.

### 2. Relire les constats, pas les prendre pour argent comptant

L'agent voit les métadonnées, pas le métier. Réflexes :
- Croiser chaque constat avec le [guide-modeles.md](../../../assets/modeles/guide-modeles.md) (les écarts v1→v2 y sont **déjà documentés et justifiés**) : l'audit doit retrouver ces écarts, pas en inventer d'autres
- Questionner un constat suspect : `Explain why the relationship between 'Ventes' and 'Calendrier' is flagged as critical.` (*Explique pourquoi la relation entre 'Ventes' et 'Calendrier' est classée critique.*)
- Les constats de type « déduction non vérifiable » sont à marquer *à vérifier* — l'agent doit s'en tenir à l'observable

### 3. Choisir le niveau de correction

Avant toute écriture, l'agent doit présenter le résumé gradué et demander le niveau :

```
Summarize the audit findings by severity. Then ask me which correction level to apply: 1 = CRITICAL only, 2 = CRITICAL + IMPORTANT, 3 = everything, 4 = nothing (audit only).
```

Traduction : *Résume les constats par gravité. Demande-moi ensuite quel niveau de correction appliquer : 1 = CRITIQUE uniquement, 2 = CRITIQUE + IMPORTANT, 3 = tout, 4 = rien (audit seul).*

En formation : partir en niveau 1 (critiques seules) — le strict nécessaire pour rendre v1 exploitable sans le réécrire. Le passage complet vers v2 reste le cap du [module 01](../../01-preparation-copilot-ready/).

### 4. Appliquer les corrections (avec garde-fous)

1. **Sauvegarde** : commit Git du dossier PBIP avant toute modification (`git add assets/modeles && git commit`)
2. Dérouler les corrections **une par une** avec confirmation : l'agent propose, vous acceptez (elicitation)
3. Vérifier chaque changement dans le **diff TMDL** (onglet Source Control) avant de passer au suivant
4. À la fin : `Summarize the changes applied and their impact on the model.` (*Résume les changements appliqués et leur impact sur le modèle.*) — et un commit par lot cohérent

### 5. Le rapport d'audit comme livrable

Demander la génération du rapport markdown complet (constats, niveau choisi, corrections appliquées, score). Le committer à côté du modèle : c'est l'entrée du plan d'action de l'[atelier 1](../phase2-ateliers/atelier-1-audit-modele-reel.md).

## Limites et pièges

- Un audit complet en un seul prompt = rapport superficiel : découper par phase, **relire entre chaque phase**
- L'audit ne remplace pas la **revue métier** : l'agent classe par gravité technique, le métier juge l'impact réel (ex. une mesure « critique » techniquement mais jamais utilisée)
- Corrections « de confort » (niveau 3) sur un modèle en production = risque inutile : en formation, s'arrêter au niveau choisi et documenter le reste comme dette
- Ne pas laisser l'agent « corriger » ce qu'il ne comprend pas : une relation inactivée sans justification peut casser un rapport
- Vérifier la **table de dates** et le filtre `StatutCommande <> "Annulee"` sur chaque mesure de ventes : c'est le piège #1 d'AltiSport (voir [guide-modeles](../../../assets/modeles/guide-modeles.md))

## Sources

- [Power BI Modeling MCP Server (README)](https://github.com/microsoft/powerbi-modeling-mcp) — scénarios « Analyze naming convention », « Benchmark DAX queries »
- [Troubleshooting](https://github.com/microsoft/powerbi-modeling-mcp/blob/master/TROUBLESHOOTING.md)
- [guide-modeles.md](../../../assets/modeles/guide-modeles.md) — écarts v1→v2 justifiés (référence de l'audit)