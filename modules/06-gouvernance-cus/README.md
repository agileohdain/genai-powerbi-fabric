# Module 06 — Gouvernance & CUs

## Pourquoi ce module

Les cinq modules précédents ont rendu l'équipe **productrice** d'IA : Copilot, Data Agents, MCP et Skills multiplient les requêtes et les contenus générés. Mais chaque requête Copilot ou Data Agent **consomme des Capacity Units (CUs)** de la capacité Fabric — et une capacité saturée se **throttle** (retards puis rejets) au détriment de tous les utilisateurs. Ce module clôture la formation par la colonne manquante : **mesurer, chiffrer, alerter et gouverner** la consommation des features IA, pour que l'adoption soit maîtrisée et durable.

> Contrairement aux modules 04-05 (outillage « poste »), celui-ci est le premier module **infrastructure** : il s'appuie sur la capacité Fabric réelle et sa [Metrics App](../../docs/04-consommation-cus-ia/), et demande quelques étapes **admin tenant/capacité**, clairement marquées « rôle admin » (voir [setup/04](../../setup/04-capacite-gouvernance.md)).

## Objectifs

- Comprendre le **modèle de capacité** : CUs, F/P SKUs, bursting/smoothing, timepoints — et pourquoi « un pic n'est pas un problème »
- Connaître **les 4 paliers de throttling** (protection 10 min → délai 20 s → rejet interactif → rejet total), savoir les détecter et les lever
- Chiffrer la **consommation IA** : tarifs par tokens (Copilot in Fabric, AI Query), prompt caching, ordre de grandeur par capacité, et **qui ne consomme rien** (MCP, Skills → locaux)
- **Gouverner** : Fabric Copilot capacity (groupement de facturation), alertes sur seuils (Capacity Overview Events), adoption incrémentale
- Appliquer la démarche sur la **capacité réelle du client** : mesurer, détecter le throttling, construire une charte de gouvernance IA

## Public

Équipe BI des modules précédents + **admins capacité/tenant** (les étapes admin sont signalées `[rôle admin]` dans les fiches et détaillées dans le setup/04). Les fiches présupposent les modules 02 (Copilot) et 03 (Data Agents) — c'est eux qui créent l'usage à mesurer.

## Prérequis

- Une **capacité Fabric (F2+/P1+) avec historique d'usage IA** : idéalement d'avoir déroulé les modules 02-03 sur la capacité de démo pour avoir des opérations **Copilot in Fabric** et **AI Query** à regarder (sinon, générer quelques requêtes Copilot avant la fiche 02)
- [setup/04-capacite-gouvernance.md](../../setup/04-capacite-gouvernance.md) suivi : capacité identifiée, rôles, Metrics App installée
- `[rôle admin]` avoir activé Copilot (voir [docs/01](../../docs/01-prerequis-admin/)) ; pour l'atelier 2 option, l'admin tenant présent pour une Fabric Copilot capacity
- La référence factuelle [docs/04 — consommation des CUs par les features IA](../../docs/04-consommation-cus-ia/) (lue et disponible)

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 3 fiches : capacités & throttling, consommation des features IA, gouvernance & alertes | ~2 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur la capacité réelle du client : mesure, puis seuils + plan de gouvernance | ~0,5 jour |
| [Quiz d'ancrage](phase1-formation/quiz.md) | 5 questions d'auto-évaluation (corrigé plié inclus) | ~10 min |

## Points d'attention transversaux

- **Les taux changent** : les tarifs par tokens (100/10/400 CU·s par 1 000 tokens) et les règles sont susceptibles d'évoluer — toujours recouper avec [docs/04](../../docs/04-consommation-cus-ia/) et les pages sources avant une mission
- **Ne pas confondre pic et throttling** : une forte consommation lissée sur 24 h (opérations IA = background) ne throttlera rien ; on ne parle throttle que si la courbe franchit les bornes des paliers (Metrics App)
- **Gouvernance ≠ blocage** : le but est de **mesurer puis réguler** (tenant settings sur un groupe, FCC, adoption incrémentale), pas de désactiver Copilot « par précaution »
- **MCP et Skills sont 0 CU** pour la génération : sous-ligné aux équipes, car c'est un argument d'arbitrage structurant (voir [docs/05 — matrice d'arbitrage globale](../../docs/05-matrice-arbitrage-globale/)) — conclut la boucle des modules 04-05
- **Sécurité/confidentialité** : la FCC expose les métadonnées items/workspaces des utilisateurs assignés — accord des utilisateurs et limite du périmètre (voir [docs/02 — sécurité](../../docs/02-securite/))

## Sources principales

- [Copilot consumption, usage, and billing in Fabric (Microsoft Learn)](https://learn.microsoft.com/en-us/fabric/fundamentals/copilot-fabric-consumption)
- [Data agent consumption (Microsoft Learn)](https://learn.microsoft.com/en-us/fabric/fundamentals/data-agent-consumption)
- [Understand capacity throttling and smoothing (Microsoft Learn)](https://learn.microsoft.com/en-us/fabric/enterprise/throttling)
- [Fabric Copilot capacity (Microsoft Learn)](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)
- [Microsoft Fabric Capacity Metrics app](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app)
- [Setup 04 — Capacité & gouvernance](../../setup/04-capacite-gouvernance.md) et [Doc 04 — Consommation des CUs](../../docs/04-consommation-cus-ia/)
