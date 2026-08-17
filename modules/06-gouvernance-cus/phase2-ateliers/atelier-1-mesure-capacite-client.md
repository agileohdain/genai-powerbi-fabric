# Atelier 1 — Mesure de la capacité : où partent les CUs

## Objectif

Sur la **capacité réelle du client**, produire un **relevé de consommation des features IA** : identifier les opérations **Copilot in Fabric** et **AI Query**, chiffrer leur coût réel (tokens + requêtes générées), détecter tout **throttling** passé, et produire un **back-of-the-envelope** par scénario d'adoption. C'est l'atelier « tout le monde mesure » — les décisions d'admin viennent à l'atelier 2.

## Durée

~2 h (en binôme formateur / équipe).

## Étape 0 — Cadrage (15 min)

1. Identifier la (les) capacité(s) du client portant les espaces utilisés dans la formation
2. Installer / ouvrir la **Metrics App** pour la capacité concernée ([setup/04](../../../setup/04-capacite-gouvernance.md))
3. Définir la période d'observation : **30 derniers jours** si possible (saisonnalité mensuelle des refreshes et de l'usage Copilot)
4. Vérifier qui peut ouvrir les paramètres capacité (le cas échéant, faire venir l'admin en pré-début d'atelier)

## Étape 1 — Inventaire de la consommation IA (40 min)

1. Page **Compute** : repérer les opérations **Copilot in Fabric** et **AI Query** sur la période
2. Noter leur **CU·s total** et leur poids dans l'**Utilization** (part de la capacité consommée par l'IA)
3. S'il y a des Data Agents : identifier en plus les **requêtes générées** facturées au moteur (ex. SQL Query) — c'est le second poste d'un agent
4. Consigner le tout dans un relevé (voir livrables)

## Étape 2 — Détection du throttling (30 min)

1. Courbe **Throttling** + **System events** : y a-t-il eu des événements de throttling sur la période ? lesquels, quand, par qui (operation ID / user) ?
2. Si oui : drill-through sur les timepoints concernés pour identifier les opérations qui ont saturé ; sinon noter l'absence et la marge restante
3. Vérifier la distinction **billable / non-billable** : des opérations preview consomment-elles déjà ?

## Étape 3 — Chiffrage et back-of-the-envelope (30 min)

1. Calculer le **coût moyen par requête** IA sur la période (CU·s IA ÷ volume approximatif de requêtes)
2. Remplir le back-of-the-envelope du scénario visé (fiche 03) : utilisateurs cibles × requêtes/jour → part de la capacité
3. Mettre en regard **marge disponible** (SKU × 24 − consommation actuelle) et cette projection

## Étape 4 — Restitution (15 min)

- Tableau des postes IA (Copilot, AI Query, requêtes générées) + part de la capacité
- Eventuelles alertes de throttling passé
- Projection : le scénario d'adoption passe-t-il ? quelle marge avant le premier palier de throttle (10 min) ?

## Livrables

- **Relevé** `gouvernance/releve-capacite.md` dans le dépôt client (ou sur la capacité en ligne) : période, capacité, opérations IA (CU·s, part), événements throttling, marge estimée
- **Back-of-the-envelope** du scénario cible, versionné
- Première ligne du futur plan de gouvernance (atelier 2) : ce qui consomme, ce qui pourrait être régulé

## Critères de succès

- Chaque opération IA (Copilot in Fabric, AI Query, requêtes générées) est **identifiée et chiffrée** sur la période
- Le throttling passé éventuel est **documenté** (date, opération, impact) ou l'absence de throttle est **prouvée** (bornes de la courbe)
- Le scénario cible est **quantifié** avec une marge explicite (part de la capacité et fenêtre de sécurité avant les paliers)

## Antidotes aux dérives d'atelier

| Dérive | Antidote |
|---|---|
| On s'enlise dans l'analyse des données « tous les postes » | Cadrer la période + ne relever que les postes IA listés à l'étape 1 ; le détail vient après |
| Personne n'a le droit d'ouvrir les réglages de capacité | Faire venir l'admin au début ou préparer des captures en amont ; l'atelier 1 est en lecture |
| On conclut « tout va bien » sans repli sur les pics | Regarder aussi les **heures de pointe** (fin de mois, matins) : le 100 % en pointe peut encore throttler |
| Le chiffrage reste théorique (pas de volume réel) | Exiger des bornes : « X requêtes/jour sur notre pilote pendant 15 j » plutôt qu'une hypothèse vague |

## Sources

- [Microsoft Fabric Capacity Metrics app — page Compute](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-compute-page)
- [Doc 04 — Consommation des CUs par les features IA](../../../docs/04-consommation-cus-ia/)
- [Setup 04 — Capacité & gouvernance](../../../setup/04-capacite-gouvernance.md)
