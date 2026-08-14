# Atelier 3 — Adoption & diffusion

## Objectif

Faire vivre Copilot au-delà de l'équipe projet : résumés par e-mail, contenu **découvrable** par le Copilot autonome, et lignes de conduite claires sur « quand utiliser Copilot plutôt que lire le rapport ».

## 1. Abonnements avec résumés Copilot

Sur le rapport recetté (atelier 1) :

1. `S'abonner au rapport > Créer un abonnement` > **Standard**
2. Destinataires, fréquence, page ou **rapport complet** en pièce jointe
3. Activer **Summary by Copilot (aperçu)** > **Preview summary** pour vérifier le résumé avant diffusion
4. `Enregistrer`, puis `Envoyer maintenant` pour un test réel

À valider : les destinataires comprennent qu'il s'agit d'un résumé généré ; le résumé est généré **au nom du propriétaire** (ses filtres enregistrés s'appliquent si *Include my changes*).

## 2. Découvrabilité du contenu par le Copilot autonome

Le Copilot autonome (et les apps) retrouvent le contenu par ses **métadonnées**. Inventaire rapide par item :

| Levier | Action | Effet |
|---|---|---|
| Description de l'item | Rédiger en langage naturel, mots-clés distincts (rapport **et** modèle sémantique) | Recherche et résumés pertinents ; Copilot génère des descriptions de rapports (rafraîchies au plus 1×/jour) s'il n'y en a pas |
| Métadonnées internes | Noms de pages, titres de visuels, zones de texte soignés ; noms/descriptions de tables, colonnes, mesures | Exploitées par la recherche (contenu dans les items) |
| Signaux de tri | **Favoris**, ouvert récemment, label **Promu**, popularité, appartenance à une app | Remonte l'item dans les résultats |
| Verified answers | Configurées au module 01 | Reprises dans la recherche du modèle |

**Approved for Copilot** (module 01) joue aussi ici : un modèle approuvé (et ses rapports) est signalé comme préparé pour l'IA ; les administrateurs de workspace peuvent **limiter la recherche aux items approuvés** (`Paramètres du workspace > Paramètres délégués > Copilot and Azure OpenAI service`) — décision de gouvernance à prendre ici (propagation jusqu'à 24 h ; les data agents comptent toujours comme approuvés).

> Prérequis côté tenant pour la recherche : **Global search** activé ; le réglage cross-geo peut être nécessaire pour la recherche sémantique selon la région (voir [docs/01](../../../docs/01-prerequis-activation/)).

## 3. Lignes de conduite « Copilot vs rapport »

Rédiger une page de consignes courtes pour les utilisateurs :

- Copilot sert à **trouver et interpréter** (rapport dense, question sans visuel, résumé rapide) — pas à remplacer la lecture des rapports conçus pour ça
- Toujours **vérifier** la source d'une réponse (*How Copilot arrived at this*) avant décision
- Repartir du **catalogue de prompts** (atelier 2) plutôt que d'improviser
- Effacer la conversation en changeant de sujet ; le non-déterminisme est normal
- Ne pas mettre en Copilot des données dont le traitement par l'IA poserait problème (rappel : métadonnées et points de données alimentent les requêtes — voir [docs/02-securite](../../../docs/02-securite/))

## 4. Plan de déploiement

1. Public pilote = les participants aux ateliers + les utilisateurs métier ayant co-construit les prompts
2. Élargissement par vagues, en s'appuyant sur le groupe de sécurité activé lors du paramétrage ([docs/01](../../../docs/01-prerequis-activation/))
3. Suivi de la consommation CUs dans l'app Fabric Capacity Metrics (opération *Copilot in Fabric*) → ajuster le périmètre si besoin ([docs/04](../../../docs/04-consommation-cus-ia/))

## Livrable

Plan d'adoption : abonnement(s) configuré(s), descriptions/métadonnées complétées, décision « recherche limitée aux items approuvés », lignes de conduite publiées, vagues de déploiement datées.

## Sources

- [Find content using Power BI Copilot search](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-search-new-content)
- [Copilot for Power BI apps](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-apps-overview)
- [Add Copilot summaries to email subscriptions](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-summaries-in-subscriptions)
