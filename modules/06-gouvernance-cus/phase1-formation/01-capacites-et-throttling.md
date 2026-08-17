# Fiche 01 — Capacités & throttling : le modèle de compte des CUs

> Fiche de fondations : comprendre comment **l'argent du compute est compté** (temps × CUs), ce que le bursting/smoothing change à la lecture, puis décoder les **4 paliers de throttling** — la capacité se règle toute seule, à nous de savoir la lire et la soulager.

## Objectifs

- Situer le **modèle de capacité** : CUs, F/P SKUs, timepoints, régions
- Comprendre **bursting** (on peut dépasser le SKU) et **smoothing** (lissé dans le temps, 24 h pour le background) et ce que ça implique à la lecture des chiffres
- Connaître les **4 paliers de throttling** et les erreurs associées
- Savoir **confirmer qu'il y a throttle** dans la Metrics App (et non de la lenteur de conception)
- Connaître les **remèdes** au throttling, du gratuit au coûteux ([rôle admin])

## Concepts

### Capacité : CUs, SKU, timepoints

- Une **CU** (Capacity Unit) est l'unité de compute ; un SKU annonce le nombre de CUs, temps réel par unité de temps. **F2** = 2 CUs, **F64** = 64 CUs, etc. (F = Fabric capacity ; P1+ = Premium, mêmes règles de throttle, remèdes un peu différents).
- Stock de référence : **CU·h par jour** = SKU × 24 (F64 → 1 536 CU·h).
- Le comptage se fait par **timepoints de 30 s** (2 880 par jour). Le throttle se décide sur la **capacité future** consommée (10 min / 60 min / 24 h).
- Une capacité se règle **au niveau capacité** : deux capacités ne se throttlent pas l'une l'autre.

### Bursting & smoothing — pourquoi « un pic n'est pas un problème »

- **Bursting** : une opération utilise **plus de compute que le SKU** pour aller vite.
- **Smoothing** : la consommation est **étalée** sur des timepoints futurs : **≥ 5 min** pour l'interactif (jusqu'à 64 min selon la charge), **24 h** pour le background — cas de Copilot et des Data Agents.
- **Overage / carryforward / burndown** : ce qui dépasse un timepoint devient du *carryforward* appliqué aux timepoints suivants, réduit par les timepoints non pleins (*burndown*). La capacité est **auto-réparante** : quand le carryforward est éteint, c'est fini.

> Conséquence pour le module : **une rafale de Copilot le matin se lisse sur 24 h** et ne suffit pas, à elle seule, à throttler. Ne jamais conclure sur un pic : toujours regarder la courbe de throttling (bornes 10 min/60 min/24 h).

### Les 4 paliers de throttling

| Usage de la capacité future | Politique | Effet |
|---|---|---|
| ≤ 10 min | Overage protection | Rien (on peut consommer les 10 prochaines minutes) |
| 10 min — 60 min | Délai interactif | Jobs interactifs <u>retardés de 20 s</u> à la soumission |
| 60 min — 24 h | Rejet interactif | Jobs interactifs **rejetés** ; le background continue |
| > 24 h | Rejet background | **Tout** est rejeté (interactif + background) |

Points de vigilance :

- Seules les **requêtes nouvelles** sont throttlées — les opérations **en vol finissent**.
- Erreurs visibles : code `CapacityLimitExceeded`, messages *« …exceeded its limits. Try again later »* et *« Cannot load model due to reaching capacity limits »*.
- Performance lente ≠ throttling (souvent la conception de l'item) — **vérifier dans la Metrics App** avant d'agir.
- Exceptions : Real-Time Intelligence (pas de palier 20 s), Warehouse (presque tout en background), eventstreams (baisse des ressources allouées au lieu de throttle).

## Pas-à-pas — lire la capacité dans la Metrics App

1. Ouvrir la **Microsoft Fabric Capacity Metrics app** (installée au [setup/04](../../../setup/04-capacite-gouvernance.md)) pour la capacité de démo.
2. Page **Compute** → courbe **Utilization** : regarder les pics au-dessus de 100 % — ce sont des **overages**, pas un throttling.
3. Courbe **Throttling** : c'est **elle** qui dit s'il y a throttling. Comparer aux bornes 10 min / 60 min / 24 h.
4. Onglet **Overages** : régler l'échelle à 10 min / 60 min / 24 h ; le *minutes to burndown* indique combien de temps durerait le retour à la normale sans nouvelle opération.
5. Onglet **System events** : l'historique des événements de throttling (et les opérations rejetées : produit, utilisateur, operation ID).
6. Drill-through sur un timepoint : identifier quelles opérations (interactives/background) ont causé l'overage.

`[rôle admin]` — erreurs périmées : `CapacityLimitExceeded` côté utilisateur → demander un screenshot exact avant diagnostic.

## Limites et pièges

- La Metrics App ne couvre **qu'une capacité à la fois** (sélecteur de capacité) : faire la lecture par capacité, et penser à la Capa du contenu vs une FCC si elle existe (fiche 03)
- Le throttle se voit **dans les événements**, pas seulement dans la courbe d'utilisation ; et l'absence de pic ne prouve pas l'absence de throttle (vérifier les bornes temporelles)
- Des opérations **non-billable** (preview) existent : elles n'entrent pas dans le throttling mais préparent la charge future — les repérer pour dimensionner
- Le **pause/resume** rend le contenu indisponible et **facture la capacité future accumulée** — dernier recours, jamais pendant les heures de travail
- Les remèdes (upscale, overage billing, pause) sont des décisions `[rôle admin]` à coût réel ; l'équipe BI signale, l'admin décide

## Sources

- [Understand capacity throttling and smoothing (Microsoft Learn)](https://learn.microsoft.com/en-us/fabric/enterprise/throttling)
- [Microsoft Fabric Capacity Metrics app — page Compute](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-compute-page)
- [Doc 04 — Consommation des CUs par les features IA](../../../docs/04-consommation-cus-ia/)
