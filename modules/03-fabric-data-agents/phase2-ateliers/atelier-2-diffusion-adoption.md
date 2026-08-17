# Atelier 2 — Diffusion & adoption

## Objectif

Publier l'agent pilote, le partager à un **groupe pilote** avec les bonnes permissions, choisir le canal de consommation adapté à l'organisation et verrouiller les règles de gouvernance avant élargissement.

## Déroulé

### 1. Publication et partage (45 min)

1. Finaliser la **description** de l'agent (fiche 04) : à destination des consommateurs *et* des orchestrateurs
2. **Publier** l'agent pilote ; vérifier la bascule brouillon/publié
3. Partager à un **groupe pilote** (5-10 utilisateurs métier) avec le modèle de permission adapté :
   - consommateurs → *No other permissions* (version publiée, interrogation seule)
   - superviseurs métier → *View details* (voir la config sans la modifier)
4. Partager l'**accès aux sources** : pour un modèle sémantique, accorder **Read** au groupe (ni Build, ni accès workspace) avec un compte de test pour vérifier que le scénario consommateur fonctionne

### 2. Choix du canal de consommation (30 min)

Selon l'outillage du client (fiche 01) :

| Canal | Critère de choix |
|---|---|
| **Expérience directe** (défaut) | Universel, zéro licence supplémentaire, test/retour direct |
| **Microsoft 365 Copilot** | Si licences M365 Copilot existantes — l'agent devient une source de connaissances dans les apps |
| **Copilot Studio / Foundry / MCP** | Si le client construit des copilotes ou du code agentique — renvoi [module 04](../../04-mcp-data-modelling/) |

Décision : canal de lancement du pilote, avec plan de test dédié (la recette de l'atelier 1 se rejoue sur le canal choisi).

### 3. Règles de gouvernance (45 min)

1. **Permissions à vie** : qui peut créer des agents ? Qui peut publier ? (rôles workspace, politique tenant Copilot/Azure OpenAI)
2. **Politiques de données** : sensibilité des sources exposées, règles Purview applicables, cas « données sensibles hors périmètre »
3. **Revue périodique** : fréquence de rejeu de la recette, propriétaire de l'agent, processus de mise à jour instructions + republication
4. **Coût** : suivi CUs des interactions agent (voir [docs/04-consommation-cus-ia](../../../docs/04-consommation-cus-ia/)) ; mesures de sécurité des données : [docs/02-securite](../../../docs/02-securite/)

### 4. Plan d'adoption (30 min)

- Annonce au groupe élargi : avec **le canal choisi** (et mention du retrait du chemin Copilot Power BI pour ceux qui l'ont connu)
- Anti-sèche d'une page : 5-10 questions types + rappel des règles (anglais, 25 lignes max, vérifier avant de diffuser)
- Critères d'entrée en production : taux de conformité recette ≥ seuil convenu, questions interdites levées, gouvernance validée

## Livrable

Agent **publié et partagé** au groupe pilote + note de gouvernance (permissions, politique, propriétaire, fréquence de revue) + plan d'adoption.

## Points d'attention

- Publier **avant** de partager : un agent non publié n'est pas interrogable avec la permission par défaut (fiche 04)
- Donner Read seul au groupe pilote : c'est le test grandeur nature du modèle de permission allégé — documenter les retours (c'est souvent le premier contact d'utilisateurs sans droit Build)
- Ne pas élargir le périmètre (nouvelles sources, nouveaux publics) avant le verdict du pilote : la recette et les CUs diront si l'agent est prêt