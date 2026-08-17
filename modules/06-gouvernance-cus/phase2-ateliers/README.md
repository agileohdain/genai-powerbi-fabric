# Phase 2 — Ateliers d'application

2 ateliers sur la **capacité Fabric réelle du client** (~0,5 jour). Pensés pour être animés en binôme formateur / équipe, en veillant à ce qu'ils soient encadrés par un `[rôle admin]` pour les étapes de configuration (alertes, FCC).

| Atelier | Objectif | Livrable | Durée indicative |
|---|---|---|---|
| [Atelier 1 — Mesure de la capacité](atelier-1-mesure-capacite-client.md) | Installer/ouvrir la Metrics App sur la capacité réelle, isoler Copilot in Fabric et AI Query, mesurer le coût réel par feature, diagnostiquer le throttling | Relevé de consommation + chiffrage par scénario | ~2 h |
| [Atelier 2 — Seuils & plan de gouvernance](atelier-2-plan-gouvernance.md) | Poser alertes/tenants settings, (option) mettre en place une FCC, rédiger la charte de gouvernance IA du client | Charte de gouvernance IA + alertes actives | ~2 h |

Points clés communs : travailler sur la **vraie consommation** du client (pas de chiffres théoriques), distinguer **mesure** (atelier 1, tout le monde) et **décision admin** (atelier 2), et ancrer la démarche **pilote → mesurer → scaler**.

## Prérequis ateliers

- [setup/04](../../../setup/04-capacite-gouvernance.md) suivi (au moins : accès Metrics App sur la capacité client, rôles, comptes admin identifiés)
- La référence [docs/04](../../../docs/04-consommation-cus-ia/) et les fiches phase 1 lues
- Stockage des relevés dans le dépôt client (dossier dédié gouvernance) pour la comparaison dans le temps
