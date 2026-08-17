# Doc 04 — Consommation des CUs par les features IA

Référence factuelle consolidée : comment les features IA de l'écosystème (Copilot Power BI, Fabric Copilot, Data Agents, Skills/MCP) consomment des **Capacity Units (CUs)** d'une capacité Fabric, et comment la mesurer. Les modules de formation renvoient ici pour les chiffres ; en particulier le [module 06](../../modules/06-gouvernance-cus/) qui en est l'application pédagogique (fiches + ateliers).

> Les tarifs et règles ci-dessous sont ceux de la **documentation officielle Microsoft en vigueur à la date de rédaction (août 2026)**. Les taux de consommation sont **susceptibles de changer** : Microsoft s'engage à prévenir par email / notes de release, mais vérifier les pages sources citées avant chaque mission.

## Vue d'ensemble — qui consomme quoi

| Feature IA | Opération dans la Metrics App | Consomme des CUs ? | Classification | Où l'exécution a lieu |
|---|---|---|---|---|
| Copilot Power BI / Fabric | **Copilot in Fabric** | ✅ par tokens | Background (lissage 24 h) | Capacité du contenu, ou [Fabric Copilot capacity](#5-fabric-copilot-capacity-fcc) si désignée |
| Fabric Data Agents | **AI Query** | ✅ par tokens + requêtes générées facturées au moteur | Background (lissage 24 h) | Pareil que Copilot |
| Skills for Fabric (module 05) | — | ❌ génération **locale** (Copilot CLI / GitHub Copilot) | — | Poste local ; seules les opérations de service standard (publish, refresh…) consomment |
| MCP Data Modelling (module 04) | — | ❌ génération **locale** (VS Code + serveur MCP) | — | Poste local ; mêmes opérations de service standard |

> **Point clé pour la matrice d'arbitrage** : les modules 04 (MCP) et 05 (Skills) tournent en **local** — leur génération ne coûte **aucune CU Fabric**. Le « franc » des CUs ne concerne que Copilot et les Data Agents (tokens), plus les opérations de service classiques (requêtes, refreshes) déclenchées par n'importe quelle feature.

## 1. Tarifs par tokens (Copilot et Data Agents)

Copilot in Fabric et AI Query (Data Agents) partagent les **mêmes taux**. La consommation est mesurée en tokens : ≈ 1 000 tokens ≈ 750 mots.

| Opération | Description | Unité | Taux (CU·s) |
|---|---|---|---|
| Copilot in Fabric | Prompt d'entrée | 1 000 tokens | **100** |
| Copilot in Fabric | Prompt d'entrée **en cache** | 1 000 tokens | **10** |
| Copilot in Fabric | Completion de sortie | 1 000 tokens | **400** |

Le **prompt caching** est automatique (aucune configuration) : quand une portion du prompt (instructions système, schéma du contexte, historique de conversation) est partagée avec une requête récente proche, elle est servie depuis le cache au taux réduit de 10 CU·s / 1 000 tokens.

**Exemple officiel** : une requête de 2 000 tokens d'entrée + 500 tokens de sortie coûte (2 000 × 100 + 500 × 400) / 1 000 = **400 CU·s = 6,67 CU·min**.

Le **coût réel d'une requête** dépasse le strict défini par le token de l'utilisateur pour un Data Agent : les *instructions du Data Agent*, les *instructions de source de données*, les *exemples de requêtes* et l'*historique de conversation* alimentent aussi les tokens d'entrée.

## 2. Capacité disponible — ordre de grandeur

Deux nombres utiles par capacité :

- **CU·h par jour** = SKU × 24 (ex. F64 → 64 × 24 = **1 536 CU·h/jour**)
- **Capacité en requêtes IA par jour** = CU·h/jour ÷ CU·h par requête

Exemple F64 : chaque requête de l'exemple ci-dessus = 0,11 CU·h (6,67 CU·min ÷ 60) → **> 13 824 requêtes Copilot/Data Agent par jour** avant épuisement de la capacité. Rappel : c'est un ordre de grandeur — la requête réelle dépend des tokens (contexte, instructions), et la capacité sert aussi à toutes les autres opérations du contenu.

Une fois la capacité épuisée, **toutes les opérations s'arrêtent** (voir §4).

## 3. Journalisation & comptage : bursting et smoothing

Ce qui compte n'est pas la vitesse instantanée, mais le **lissage** :

- **Timepoints** : unité de comptage = 30 s ; 24 h = 2 880 timepoints.
- **Bursting** : une opération peut utiliser **plus de CU que le SKU** pour aller vite (on paie le pic *après coup*, lissé).
- **Smoothing** : la consommation est étalée dans le temps —
  - opérations **interactives** : lissées sur **5 min minimum** (jusqu'à 64 min selon la consommation) ;
  - opérations **background** : lissées sur **24 h** (cas de Copilot et des Data Agents).
- **Overage / carryforward / burndown** : si une opération dépasse ce que le SKU permet dans un timepoint, l'*overage* devient du *carryforward* qui s'ajoute aux timepoints suivants ; les timepoints non pleins le réduisent (*burndown*). La capacité s'auto-répare : elle continuera à throttler tant que le carryforward n'est pas éteint.

**Conséquence pratique** : une rafale de Copilot un matin ne se paye pas instantanément — elle est étalée sur 24 h pour les opérations IA. Ne pas paniquer sur un pic : utiliser la Metrics App pour vérifier que ce pic déclenche (ou non) un throttling réel (§4-§6).

## 4. Throttling — les 4 paliers

Le throttling s'applique au **niveau de la capacité** (une capacité en difficulté ne bloque pas les autres). Il est **progressif** :

| Usage de la capacité | Politique | Effet sur l'expérience |
|---|---|---|
| ≤ 10 min de capacité future | **Overage protection** | Aucun : les jobs peuvent consommer 10 min de capacité future sans throttling |
| 10 min < usage ≤ 60 min | **Délai interactif** | Les jobs interactifs demandés par l'utilisateur sont **retardés de 20 s** à la soumission |
| 60 min < usage ≤ 24 h | **Rejet interactif** | Les jobs interactifs sont **rejetés** ; les opérations background peuvent démarrer et tourner |
| usage > 24 h | **Rejet background** | **Toutes** les requêtes (interactives et background) sont rejetées |

Caractéristiques importantes :

- **Les opérations déjà en vol ne sont jamais coupées** : le throttling ne touche que les requêtes *nouvelles*.
- **Erreurs visibles** : code `CapacityLimitExceeded` ; messages *« Your organization's Fabric compute capacity has exceeded its limits. Try again later »* et *« Cannot load model due to reaching capacity limits »*.
- La performance lente n'est **pas toujours** du throttling — souvent la conception de l'item. Vérifier dans la Metrics App avant de conclure.
- **Exceptions par workload** : Real-Time Intelligence n'applique pas le palier 20 s (priorité au temps réel) ; le Warehouse est presque tout classé *background* (lissage 24 h) ; les eventstreams réduisent les ressources allouées au lieu de throttler.
- **Compound throttling** : une requête en chaîne (ex. un visuel → une requête de modèle) n'est throttlée qu'une fois par capacité grâce à la *compound throttling protection*.

## 5. Fabric Copilot capacity (FCC)

La **[Fabric Copilot capacity](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)** (dispo depuis juin 2026, F2/P1 minimum) désigne une capacité qui **regroupe et facture la consommation Copilot + Data Agents d'un groupe d'utilisateurs**, au lieu de la répartir sur les capacités qui portent les contenus. Intérêt de gouvernance : **un seul endroit pour voir et piloter le coût IA**, y compris l'usage fait depuis **Power BI Desktop** et depuis des espaces **Pro / PPU**.

Règles :

- Mise en place : l'**admin Fabric** active Copilot et **autorise** les admins de capacité à désigner une FCC ; l'**admin de capacité** assigne ensuite les utilisateurs (paramètres de capacité).
- Une FCC couvre les scénarios : Copilot Desktop, Copilot Power BI (espaces Pro/PPU/Fabric/Premium), Copilot Fabric sur espaces < F64, Data Agents sur espaces < F64.
- **Limites** : région home du tenant uniquement ; F2 ou P1 minimum ; un utilisateur n'adhère qu'à **une seule** FCC (la plus récente) ; pas de licence mode *Embedded* ; ne couvre pas les **AI functions** Fabric.
- Les métadonnées des items/workspaces concernés sont visibles par l'admin de la FCC dans ses relevés d'usage.

## 6. Surveiller la consommation

### Fabric Capacity Metrics App

L'outil de référence des admins capacité. S'applique par capacité (voir [setup/04](../../setup/04-capacite-gouvernance.md)). Points utiles pour l'IA :

- Opérations listées séparément : **Copilot in Fabric** et **AI Query** (Data Agents).
- **Compute page** : courbe d'**Utilization**, courbe de **Throttling**, onglet **Overages** (échelle 10 min / 60 min / 24 h), table **System events** (historique des événements de throttling), drill-through vers le timepoint, **minutes to burndown** (temps estimé pour éteindre le carryforward sans nouvelle opération).
- Les timepoints de throttling montrent les opérations **rejetées** (produit, utilisateur, operation ID, heure — pas d'info sur ce qui n'a jamais démarré).
- Distinction **billable / non-billable** : le throttling ne compte que les opérations *billable* ; les opérations *non-billable* (preview) servent à **anticiper** la charge future.

L'utilisateur final peut voir, lui, un **résumé de facturation** sous l'item *LlmPlugin* (Copilot/Data Agents).

### Alertes

Deux mécanismes complémentaires :

1. **Alertes email sur seuils de capacité** (officiel) : les *Capacity Overview Events* via **Real-Time Hub** — suivre le [tutoriel consacré](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold) (détaillé dans la fiche 03 et le setup/04).
2. **Analyse manuelle** avec la Metrics App : courbes Utilization/Throttling, rapport aux paliers 10 min / 60 min / 24 h.

> Il n'existe **pas** d'alerte préconçue « % CU atteint » dans la Metrics App elle-même : les seuils se construisent via les événements (Real-Time Hub) ou des requêtes sur le sémantique de la Metrics App.

## 7. Réagir au throttling

Remèdes, par ordre du moins coûteux :

1. **Attendre** : la capacité est auto-réparante ; une fois le carryforward éteint, tout revient à la normale.
2. **Réguler l'usage** : étaler les opérations IA (éviter les pics), désactiver temporairement Copilot pour un groupe (tenant settings), revoir les promptings trop verbeux (chaque token d'entrée coûte).
3. **Montée de SKU temporaire** (F) : upscale → le carryforward se burne plus vite (plus de capacité libre par timepoint).
4. **Pause/resume** (F) : repart « à zéro capacité future » immédiatement — mais rend le contenu indisponible pendant la pause et facture la capacité future accumulée ; à réserver.
5. **Overage billing** (F) : facturation supplémentaire autorisée au-delà du SKU pour arrêter le throttling — coût **3× le tarif normal** ; à activer consciemment.
6. **Autoscale** (P) : l'équivalent Premium (montée automatique de vCores).

**Prévention, recommandée par Microsoft** : adoption **incrémentale** des features IA — lancer sur un **petit groupe pilote**, **mesurer** (Metrics App) chaque scénario, **extrapoler** avant de scaler ; ne jamais déployer massivement (ex. résumés par abonnement à des centaines d'utilisateurs, narratifs IA embarqués sur des dashboards à fort trafic) sans validation de consommation.

## Sources

- [Copilot consumption, usage, and billing in Fabric](https://learn.microsoft.com/en-us/fabric/fundamentals/copilot-fabric-consumption) — taux 100/10/400, background, exemple F64
- [Data agent consumption](https://learn.microsoft.com/en-us/fabric/fundamentals/data-agent-consumption) — taux AI Query, requêtes générées, LlmPlugin
- [Understand capacity throttling and smoothing](https://learn.microsoft.com/en-us/fabric/enterprise/throttling) — timepoints, bursting/smoothing, paliers, remèdes (maj. 08/2026)
- [Fabric Copilot capacity for usage billing](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity) (maj. 06/2026)
- [Microsoft Fabric Capacity Metrics app](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app) et [page Compute](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-compute-page)
- [Monitor capacity threshold (Real-Time Hub)](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold)
