# Fiche 01 — Panorama et cas d'usage

## Objectifs

- Comprendre ce qu'est un data agent et comment il fonctionne (choix de la source, génération de requête, exécution)
- **Arbitrer** entre Copilot Power BI, data agent et les autres leviers (module 04, 05)
- Cartographier les **canaux de consommation** d'un agent après son édition post-26/08/2026 (expérience directe, Microsoft 365 Copilot, Copilot Studio, Foundry, MCP)
- Connaître le cycle de vie d'un agent : créer → configurer → tester → publier → partager → itérer

## Qu'est-ce qu'un data agent ?

Un **Fabric data agent** (GA) est un agent conversationnel no-code qui répond en langage naturel à partir de données hébergées dans Fabric : lakehouse, warehouse, **modèle sémantique Power BI**, KQL Database, mirrored database, ontology, et Microsoft Graph.

> On le compare souvent à « un Copilot qu'on peut configurer » : au lieu d'une expérience figée, c'est un **artefact autonome** que l'on construit (sources, tables, instructions, exemples) et que l'on publie pour des consommateurs.

### Fonctionnement interne

1. **Analyse de la question** : l'agent (Azure OpenAI) détermine la source la plus pertinente parmi celles configurées
2. **Génération** : requête de lecture — SQL pour lakehouse/warehouse, **DAX pour un modèle sémantique**, KQL pour une KQL Database (+ requêtes Microsoft Graph)
3. **Validation** : la requête est validée (syntaxe, périmètre), puis **exécutée avec les credentials de l'utilisateur** qui interroge
4. **Réponse** : résultats formatés (tableau, résumé) — **read-only** en toutes circonstances

La sécurité suit la source : RLS/CLS appliqués, moindre privilège, politiques Purview (DLP, access restriction) respectées.

## Arbitrage : Copilot Power BI vs Data Agent

| Critère | Copilot Power BI (module 02) | Data agent |
|---|---|---|
| Nature | Expérience préconfigurée, intégrée au rapport | Artefact autonome **configurable** |
| Périmètre | Modèle sémantique (ou visuels du rapport) | Jusqu'à **5 sources** de types variés |
| Par qui | Tout le monde, tel quel | Construit et maintenu par un créateur |
| Personnalisation | Instructions IA du modèle (module 01) | Instructions + exemples + sélection des tables |
| Sortie | Visuels ajoutables au rapport, narratifs | Réponse conversationnelle (25 lignes × 25 colonnes max) |
| Usage type | Analyser un rapport, construire des visuels | Q&A multi-sources, self-service pour métiers non BI |

**Règle de base** : tant que la question porte sur un modèle sémantique et un rapport existant → Copilot ; dès qu'il faut **croiser plusieurs sources** (modèle + lakehouse + KQL), exposer la donnée à un **public non BI**, ou donner une **définition métier spécifique** → data agent. Vue globale (y compris MCP et Skills) : [docs/05-matrice-arbitrage-globale](../../../docs/05-matrice-arbitrage-globale/).

> Piège récurrent : le data agent convient à l'**analyse conversationnelle**, pas au « donne-moi toutes les lignes » : les réponses sont plafonnées (25×25) et l'historique peut être remis à zéro.

## Le cycle de vie d'un agent

1. **Créer** l'item (no-code, dans le workspace)
2. **Configurer** : ajouter jusqu'à 5 sources, sélectionner les tables, rédiger instructions et exemples
3. **Tester** dans l'expérience directe (chat), itérer brouillon
4. **Publier** : une version publique read-only est figée, partageable
5. **Partager** avec les consommateurs (permissions) — le brouillon continue d'évoluer sans affecter la version publiée
6. **Itérer** : comparaison brouillon vs publié, ALM (Git, deployment pipelines)

## Consommation : où les utilisateurs interrogent l'agent ?

> **Changement récent** : l'accès aux data agents **depuis Copilot in Power BI est retiré depuis le 26 août 2026** (l'intégration reposait sur l'OpenAI Assistants API, retirée à la même date). Ne plus former ni communiquer ce chemin ; pour les utilisateurs qui l'ont connu, annoncer la bascule dans les fiches d'adoption.

| Canal | Public | Notes |
|---|---|---|
| **Expérience directe** (chat de l'item dans Fabric) | Tous, dès le partage de l'agent | Chemin principal et de référence pour tester |
| **Microsoft 365 Copilot** | Organisation (licence M365 Copilot requise) | L'agent remonte comme source de connaissances ; Purview s'applique |
| **Microsoft Copilot Studio** | Builders de copilotes | Agent exposé comme une action/connexion |
| **Microsoft Foundry** (Azure AI Foundry) | Développeurs | Agent utilisé comme outil d'un agent applicatif |
| **Endpoint MCP** (preview) | Développeurs, tout client MCP | VS Code, scripts Python… — voir [module 04](../../04-mcp-data-modelling/) pour l'écosystème MCP |

> Attention conformité : consommer l'agent via un canal *non-Fabric* (MCP, M365 Copilot…) peut envoyer les réponses **hors du périmètre de conformité ou de la région** de la capacité — à arbitrer avec la sécurité (voir fiche 04 et [docs/02-securite](../../../docs/02-securite/)).

## Limites et pièges

- **Anglais uniquement** : questions, instructions et exemples en anglais
- Réponses plafonnées à 25 lignes × 25 colonnes ; le chat courant influence les relances → nouvelle session après une grosse réponse
- **LLM non modifiable** ; pas de données non structurées (PDF, Word…) ; fichiers lakehouse non exposés tant qu'ils ne sont pas des tables
- La capacité du workspace de la source doit être dans la **même région** que celle du workspace de l'agent
- Chaque interaction consomme des CUs (voir [docs/04-consommation-cus-ia](../../../docs/04-consommation-cus-ia/))

## Sources

- [Fabric data agent creation (concept, GA)](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
- [Fabric data agent scenario — bout en bout](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-end-to-end-tutorial)
- [Data agent as Model Context Protocol server (preview)](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-mcp-server)
- [Retirement of Fabric data agent integration in Copilot in Power BI](https://community.fabric.microsoft.com/t5/Fabric-Updates-Blog/Retirement-of-Fabric-data-agent-integration-in-Copilot-in-Power/ba-p/5328344)