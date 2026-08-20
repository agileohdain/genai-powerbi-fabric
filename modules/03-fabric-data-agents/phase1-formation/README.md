# Phase 1 — Formation & démonstrations

Session théorique avec démonstrations sur le modèle AltiSport v2 (voir `assets/modeles/`), publié dans un espace de travail Copilot-enabled, en tant que **source d'un data agent**. Aucun nouvel asset n'est requis : le data agent se construit au-dessus des éléments existants.

## Agenda indicatif (demi-journée)

| Horaire | Séquence | Fiche | Format |
|---|---|---|---|
| 09h00 | Accueil, objectifs, panorama et cas d'usage (arbitrage Copilot / data agent) | [01](01-panorama-et-cas-usage.md) | Théorie + démo |
| 09h45 | Créer et configurer l'agent sur AltiSport v2 | [02](02-creer-et-configurer.md) | Démo (charnière du module) |
| 10h30 | Pause | — | — |
| 10h45 | Qualité des réponses : vérifier, itérer, limites | [03](03-qualite-et-verification.md) | Démo |
| 11h30 | Publier, partager, gouverner | [04](04-publier-partager-gouverner.md) | Démo |
| 11h55 | Synthèse et cadrage des ateliers Phase 2 | — | — |

## Matériel de démo requis

- Modèle AltiSport **v2** publié dans un espace de travail sur capacité F2+ (voir [guide-modeles](../../../assets/modeles/guide-modeles.md))
- Un data agent de démo créé à l'avance sur ce modèle (fiche 02) — la démo « création » recrée un second agent pas à pas ou repart du brouillon
- Permission **Read** sur le modèle pour le compte de démo (suffisant pour interroger via l'agent)
- Accès admin tenant si la capacité est hors de l'EU data boundary / des États-Unis (paramètres cross-geo, voir README du module)

## Rappel des conventions

- Chaque fiche : objectifs > concepts > matériel de démo > pas-à-pas / cas d'usage > limites et pièges > sources — la section *Matériel de démo* pointe les assets AltiSport à ouvrir (chemins, usage, déroulé)
- Instructions et exemples d'agent **en anglais** (l'agent ne supporte que l'anglais) avec traduction française
- Les démonstrations utilisent le modèle générique AltiSport ; l'application sur les modèles réels du client se fait en [Phase 2](../phase2-ateliers/)