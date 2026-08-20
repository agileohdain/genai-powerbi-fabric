# Fiche 04 — Publier, partager, gouverner

## Objectifs

- Maîtriser le modèle **brouillon / publié** et la bascule de comparaison
- Rédiger la **description** de l'agent au moment de publier (elle sert aussi aux systèmes externes)
- Choisir le bon **modèle de permission** de partage et connaître les permissions minimales sur les sources
- Situer les responsabilités de **gouvernance** : Purview, régions, ALM

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Agent **Agent Ventes AltiSport** (brouillon de la fiche 02) | Workspace Fabric de démo | Publication, description, partage, bascule brouillon/publié |
| Modèle **altisport-v2** partagé en **Read** | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Source de l'agent : permission minimale à accorder aux consommateurs |

## Publier : brouillon vs publié

1. Bouton **Publish** → saisir la **description** : explique aux consommateurs ce que l'agent sait faire ; c'est aussi cette description que les orchestrateurs (Foundry, Copilot Studio, endpoint MCP) lisent pour décider de l'appeler → *« Agent répondant aux questions sur les ventes, la marge et l'atteinte des cibles AltiSport, à partir du modèle sémantique v2. »*
2. Une fois publié : une version **read-only** est figée et partageable. Le brouillon continue d'évoluer **sans affecter** la version publiée
3. **Bascule brouillon/publié** dans l'interface : tester la même question sur les deux versions pour mesurer l'effet des changements avant de republier

> Un agent **non publié** partagé avec le modèle de permission par défaut n'est **pas interrogable** (la permission par défaut ne donne accès qu'à la version publiée). Publier avant de partager, sauf aux collaborateurs avec droits d'édition.

## Partager : trois modèles de permission

Sur **Share** : sélectionner le modèle de permission, puis l'audience (individus, groupes, *Everyone in the org* selon la politique).

| Modèle | Ce que le consommateur peut faire |
|---|---|
| *No other permissions* (défaut) | Interroger la **version publiée** uniquement — ni config, ni brouillon |
| **View details** | Voir les détails et configurations (publié + brouillon), interroger, ne peut rien modifier |
| **Edit and view details** | Voir, modifier, interroger — pour le travail collaboratif de création |

La permission de partage de l'agent ne suffit pas : il faut aussi **partager l'accès aux sources** (voir tableau ci-dessous).

## Permissions minimales sur les sources

L'interrogation via un agent se fait **avec les credentials du consommateur** : s'il n'a pas le droit suffisant sur la source, la requête échoue ou renvoie vide. RLS et CLS restent appliqués.

| Source | Permission minimale pour interroger via l'agent |
|---|---|
| Modèle sémantique Power BI | **Read** — ni Build, ni accès workspace (*changement notable : cas d'usage « lecteurs » sans droit Build*) |
| Lakehouse | Read sur l'item |
| Warehouse | Read (SELECT sur les tables concernées) |
| KQL Database | Rôle Reader |
| Ontology | Read sur l'ontology + Read sur la source liée |

> Moindre privilège : accorder **Read** sur le modèle sémantique aux consommateurs d'agents, et réserver Build/workspace à ceux qui modifient le modèle — la règle change uniquement pour l'accès via agent.

## Gouvernance et ALM

- **Purview** : les politiques existantes (DLP, access restriction, sensitivity labels) s'appliquent aux sources interrogées par l'agent ; les interactions peuvent être **auditées et consignées** (Audit, eDiscovery) — à annoncer aux consommateurs
- **Régions** : la capacité du workspace de la source doit être dans la même région que celle du workspace de l'agent ; les canaux non-Fabric peuvent sortir les réponses du périmètre de conformité (fiche 01)
- **ALM** : intégration **Git** (instructions, exemples, sélection de sources versionnés) et **deployment pipelines** (dev → test → prod) ; diagnostics intégrés pour tracer les requêtes
- **Revue périodique** : instructions, exemples et sources doivent être revus quand les données ou les règles changent (la recette de la fiche 03 sert de test de non-régression)

## Limites et pièges

- Partager l'agent sans partager la source → questions sans réponse ; partager la source sans l'agent → accès inutilisable : les deux partages sont indissociables
- La **description publiée** est un texte consommé par des humains *et* des orchestrateurs : la négliger dégrade la découverte et l'appel automatique
- Les droits « Edit » donnent accès au **brouillon** : ne l'accorder qu'aux créateurs de confiance
- Une politique Purview peut bloquer une réponse sans message explicite : investiguer côté politiques avant de modifier l'agent

## Sources

- [Fabric data agent sharing and permission management](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing)
- [Fabric data agent creation (concept, GA)](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
- [Fabric data agent tenant settings](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-tenant-settings)