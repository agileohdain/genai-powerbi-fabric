# Atelier 2 — Prompts & adoption

## Objectif

Capitaliser l'atelier 1 et préparer la vie de Copilot après la formation : un **catalogue de prompts éprouvés**, un contenu **découvrable** par le Copilot autonome, et des **lignes de conduite** claires sur « quand utiliser Copilot plutôt que lire le rapport ».

## Durée

≈ 4 h (sections minutées ci-dessous).

## 1. Catalogue de prompts (2 h)

Les prompts efficaces dépendent du **vocabulaire réel du modèle** (noms de mesures, de catégories) : les cataloguer fige les formulations qui ont passé la recette (atelier 1) et constitue un actif d'équipe — support idéal de la formation des utilisateurs.

Une entrée par prompt :

| Champ | Exemple |
|---|---|
| Domaine | Ventes · Magasins · Clients · Produits |
| Profil cible | Auteur / Lecteur |
| Usage | Création de page · Question de données · Narratif |
| Prompt (EN) | `What were the top 5 selling products in each region last quarter?` |
| Traduction / intention | Top 5 produits par région au dernier trimestre |
| Conditions de succès | Champs attendus (mesure, dimensions), filtre de dates, exclusion des commandes annulées |
| Référence de recette | Lien vers la ligne correspondante de la fiche de recette (atelier 1) |

Déroulé : reprendre les questions de l'atelier 1 et les reformuler en **prompts canoniques** (anglais, verbe d'action + sujets + dimensions + temporalité, vocabulaire du modèle) ; balayer les usages par domaine ; tester chaque entrée une dernière fois — **seuls les prompts recettés entrent au catalogue** ; dédupliquer ; valider le vocabulaire avec les utilisateurs métier. Le catalogue documente aussi **ce qu'il ne faut pas demander** (insights causaux, prévisions).

## 2. Découvrabilité par le Copilot autonome (45 min)

Le Copilot autonome (et les apps) retrouvent le contenu par ses **métadonnées**. Inventaire par item :

| Levier | Action | Effet |
|---|---|---|
| Description de l'item | Rédiger en langage naturel, mots-clés distincts (rapport **et** modèle sémantique) | Recherche et résumés pertinents ; Copilot génère des descriptions de rapports s'il n'y en a pas |
| Métadonnées internes | Noms de pages, titres de visuels, zones de texte soignés ; noms/descriptions de tables, colonnes, mesures | Exploitées par la recherche (contenu dans les items) |
| Signaux de tri | **Favoris**, ouvert récemment, label **Promu**, popularité, appartenance à une app | Remonte l'item dans les résultats |
| Verified answers | Configurées au module 01 | Reprises dans la recherche du modèle |

**Approved for Copilot** (module 01) joue aussi ici : un modèle approuvé (et ses rapports) est signalé comme préparé pour l'IA ; les administrateurs de workspace peuvent **limiter la recherche aux items approuvés** (`Paramètres du workspace > Paramètres délégués > Copilot and Azure OpenAI service`) — décision de gouvernance à prendre ici (propagation jusqu'à 24 h ; les data agents comptent toujours comme approuvés).

> Prérequis côté tenant pour la recherche : **Global search** activé ; le réglage cross-geo peut être nécessaire pour la recherche sémantique selon la région (voir [docs/01](../../../docs/01-prerequis-activation/)).

## 3. Abonnements avec résumés Copilot — démo optionnelle (15 min)

Sur le rapport recetté : `S'abonner au rapport > Créer un abonnement` > **Standard** > activer **Summary by Copilot (aperçu)** > **Preview summary** > enregistrer, `Envoyer maintenant` pour un test réel. À savoir : abonnements Standard uniquement, résumé généré **au nom du propriétaire**, pas de prompt personnalisé, filtres enregistrés appliqués si *Include my changes*.

## 4. Lignes de conduite « Copilot vs rapport » (30 min)

Rédiger une page de consignes courtes pour les utilisateurs :

- Copilot sert à **trouver et interpréter** (rapport dense, question sans visuel, résumé rapide) — pas à remplacer la lecture des rapports conçus pour ça
- Toujours **vérifier** la source d'une réponse (*How Copilot arrived at this*) avant décision
- Repartir du **catalogue de prompts** plutôt que d'improviser
- Effacer la conversation en changeant de sujet ; le non-déterminisme est normal
- Ne pas mettre en Copilot des données dont le traitement par l'IA poserait problème (rappel : métadonnées et points de données alimentent les requêtes — voir [docs/02-securite](../../../docs/02-securite/))

## 5. Plan de déploiement (30 min)

1. Public pilote = les participants aux ateliers + les utilisateurs métier ayant co-construit les prompts
2. Élargissement par vagues, en s'appuyant sur le groupe de sécurité activé lors du paramétrage ([docs/01](../../../docs/01-prerequis-activation/))
3. Suivi de la consommation CUs dans l'app Fabric Capacity Metrics (opération *Copilot in Fabric*) → ajuster le périmètre si besoin ([docs/04](../../../docs/04-consommation-cus-ia/))

## Livrables

Catalogue de prompts versionné (à côté du rapport, ex. même espace de travail), descriptions/métadonnées complétées, décision « recherche limitée aux items approuvés », lignes de conduite publiées, vagues de déploiement datées.

## Critères de succès

- Le catalogue ne contient que des prompts **recettés**, chaque entrée référençant sa ligne de recette (atelier 1)
- Les décisions de gouvernance sont actées : recherche limitée (ou non) aux items approuvés, vagues de déploiement datées
- Les lignes de conduite « Copilot vs rapport » sont publiées à destination des utilisateurs

## Antidotes aux dérives d'atelier

- Catalogue qui gonfle : **seuls les prompts recettés entrent** — pas de saisie « de mémoire » sans rejeu
- Ne pas activer les résumés Copilot sur tous les abonnements d'un coup : chaque résumé consomme des CUs ([docs/04](../../../docs/04-consommation-cus-ia/)) — piloter d'abord
- La décision « recherche limitée aux items approuvés » ne se prend pas par défaut : la relier explicitement à la stratégie de gouvernance du module 01

## Sources

- [Find content using Power BI Copilot search](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-search-new-content)
- [Copilot for Power BI apps](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-apps-overview)
- [Add Copilot summaries to email subscriptions](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-summaries-in-subscriptions)
