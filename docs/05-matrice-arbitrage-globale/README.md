# Doc 05 — Matrice d'arbitrage globale : Copilot vs Data Agent vs MCP vs Skills

Référence de décision : les **4 leviers IA** couverts par la formation (modules 02-05), comparés sur les critères qui comptent avant choix — public, prérequis, coût en CUs, cas d'usage, limites. Les modules développent la pratique ; ce document est là pour répondre à la question « **quel outil pour quel besoin ?** » et pour arbitrer quand plusieurs réponses sont plausibles.

> La matrice s'appuie sur les faits de [doc 04](../04-consommation-cus-ia/) (tarifs CUs, FCC) et sur les périmètres produits de chaque module. Les caractéristiques « Public Preview » (MCP, Skills) restent sujettes à évolution — vérifier au moment de chaque mission.

## Vue d'ensemble — les 4 leviers

| | **Copilot Power BI** (module 02) | **Fabric Data Agents** (module 03) | **MCP Data Modelling** (module 04) | **Skills for Fabric** (module 05) |
|---|---|---|---|---|
| **Nature** | Expériences de chat et fonctions intégrées à Power BI (Desktop/Service) | Agent conversationnel **no-code**, artefact autonome construit et publié | Serveur MCP piloté par un agent dans **VS Code** (code agentique) | Paquets d'instructions chargées par **Copilot CLI/VS Code** pour travailler le **PBIR** |
| **Style d'usage** | Conversationnel, dans l'expérience Power BI | Conversationnel, hors Power BI (agent partagé) | Opérations de modélisation via GitHub Copilot | Opérations de couche rapport via GitHub Copilot CLI/VS Code |
| **Cible** | Créateurs (génération, DAX) et consommateurs (Q&A) | Utilisateurs métier non techniques, grand public | Développeurs BI / data engineers | Développeurs BI / data engineers |
| **Génération locale ?** | Non | Non | **Oui** | **Oui** |
| **CUs** | Tokens (background) | Tokens + requêtes générées facturées au moteur | **0 CU** (génération) | **0 CU** (génération) |

> **Point clé** : seuls **Copilot et les Data Agents consomment des CUs** pour leur génération. MCP et Skills génèrent **en local** — leur coût est un coût d'infrastructure dev (GitHub Copilot, poste), pas de la capacité Fabric. Les opérations de service *standard* (publish, refresh, requêtes de modèles) consomment des CUs dans tous les cas.

## Critères de choix

### Public et frictions

| | Copilot | Data Agent | MCP | Skills |
|---|---|---|---|---|
| **Utilisateur final ?** | ✅ — Q&A sur rapports publiés, expériences plein écran | ✅ — agent partagé dans l'outil de leur choix | ❌ réservé dev | ❌ réservé dev |
| **Niveau requis** | Aucun pour le consommateur ; prompteur pour le créateur | Aucun pour le consommateur ; configurateur pour l'auteur | VS Code, Git, modélisation | VS Code / Copilot CLI, PBIR, Git |
| **Langue** | Anglais recommandé (multilingue non supporté) | **Anglais uniquement** (prompts, instructions, exemples) | Prompts en langage naturel (anglais recommandé) | Prompts en langage naturel (anglais recommandé) |

### Prérequis

| | Copilot | Data Agent | MCP | Skills |
|---|---|---|---|---|
| **Licence** | Capacité Fabric F2+ / P1+ (ou FCC pour Pro/PPU/Desktop) | Capacité F2+ / P1+ (ou FCC) ; Copilot + Azure OpenAI tenant | GitHub Copilot (Pro ou Business) | GitHub Copilot (Pro ou Business) |
| **Outils** | Desktop ou Service | Service Fabric | VS Code + extension MCP | Copilot CLI/VS Code + plugin `powerbi-authoring` + CLIs Node |
| **Setup** | [docs/01](../01-prerequis-activation/) (tenant + capacité) | [docs/01](../01-prerequis-activation/) + paramètres tenant région | [setup/02](../../setup/02-vscode-mcp.md) | [setup/03](../../setup/03-skills-copilot-cli.md) |
| **Modele préparé** | Module 01 requis | Module 01 requis (pas d'exemples Q/R sur modèle sémantique) | Module 01 utile (l'objet de l'audit) | Module 01 requis, PBIR obligatoire |

### Coût CUs (génération)

| | Copilot | Data Agent | MCP | Skills |
|---|---|---|---|---|
| Tarifs tokens (input/output) | 100/10/400 CU·s pour 1 000 tokens | identiques | — | — |
| Facturation des requêtes générées | — | ✅ requêtes générées (SQL, DAX, KQL) facturées au moteur | — | — |
| CUs de génération | ✅ (background, lissage 24 h) | ✅ (background) | **0** | **0** |
| Pilotage coût centralisé | FCC ou Metrics App | FCC ou Metrics App | Budget GitHub Copilot | Budget GitHub Copilot |

## Ce que chaque levier sait faire — et ne pas faire

| | Copilot | Data Agent | MCP | Skills |
|---|---|---|---|---|
| **Fait bien** | Génération de pages/narratifs, résumés par e-mail, DAX, descriptions, Q&A sur rapports | Réponses en langage naturel sur **multi-sources** (lakehouse, warehouse, modele sémantique, KQL, mirrored, ontology, Graph) | Audit, corrections, documentation de masse du **modele sémantique** (DAX, métadonnées) | Création, refactoring, re-thémérisation, traduction de masse de la **couche rapport** (PBIR) |
| **Ne fait pas** | Sorties **non déterministes** (cache 24 h) ; ne connaît pas le contexte métier ; réglage tenant global (pas par expérience) | **Read-only** (aucune écriture) ; réponses **limitées à 25×25** ; plus accessible depuis Copilot in Power BI (retrait 26/08/2026) | Ne modifie **que le modèle** : ni pages de rapport, ni layout | PBIR uniquement ; ne touche **pas au modele** (renvoi module 04) |
| **Risque typique** | Réponse plausible mais fausse → vérifier champs/filtres | Instructions trop vagues → requêtes hors sujet ; données sensibles exposées si agent non gouverné | Écritures inattendues → sauvegarde + diff Git obligatoires ; métadonnées envoyées au fournisseur LLM | JSON PBIR deviné → valider via le CLI, jamais de mémoire ; baseline Git avant écriture |

## Arbre de décision — quel levier pour quel besoin

1. **« N'importe quel non-technicien doit pouvoir interroger des données »** → **Data Agent** (publier et partager l'artefact), ou **Copilot Q&A** si le contexte est un rapport Power BI existant.
2. **« Je crée un rapport / un narratif / des résumés, je suis auteur BI »** → **Copilot** (génération conversationnelle, rapide, dans Power BI).
3. **« Je pilote la couche rapport avec une charte stricte, refactor, traduction de masse »** → **Skills** (déterministe sur fichiers PBIR, versionnable).
4. **« J'audite / corrige / documente un modèle sémantique »** → **MCP** (le modèle n'est pas le terrain de Copilot/Skills).
5. **« Besoin multi-sources, réponse conversationnelle en grand public »** → **Data Agent** en priorité (sources multiples), Copilot restant limité à un seul modèle à la fois en contexte.
6. **Combiner** : les leviers sont complémentaires et se combinent —
   - **MCP + Skills** : modèle d'abord (04), rapports ensuite (05) — le duo dev/BI ;
   - **Copilot/Data Agent + MCP/Skills** : la génération conversationnelle (usage) et la fabrication et maintenance (dev) ne servent pas le même besoin.

> Règle pratique : si le besoin est **conversationnel et individuel** → Copilot ; **conversationnel et partagé/multi-sources** → Data Agent ; **écriture structurée sur le modèle** → MCP ; **écriture structurée sur le rapport** → Skills. Quand une réponse convient à plusieurs leviers, le **coût en CUs** (docs/04) et la **compétence interne** (VS Code vs Service) départagent : privilégier zéro CU là où l'équipe a la compétence dev.

## À ne pas oublier

- **Hallucination et validation humaine** : aucun levier n'est exempt — toujours vérifier la sortie avant publication (voir [doc 03](../03-limites-hallucinations-validation/)).
- **Sécurité** : RLS/OLS respectés par Copilot et Data Agents selon l'appelant ; MCP et Skills n'élargissent pas les droits mais font transiter données/métadonnées vers le fournisseur LLM (voir [doc 02](../02-securite/)).
- **CUs** : le choix du levier n'est qu'une partie du calcul — toute opération de service standard consomme aussi (voir [doc 04](../04-consommation-cus-ia/)).

## Sources

- Modules [02-copilot-powerbi](../../modules/02-copilot-powerbi/), [03-fabric-data-agents](../../modules/03-fabric-data-agents/), [04-mcp-data-modelling](../../modules/04-mcp-data-modelling/), [05-fabric-skills-authoring](../../modules/05-fabric-skills-authoring/) (périmètres, prérequis, points d'attention)
- [Doc 04 — Consommation des CUs par les features IA](../04-consommation-cus-ia/) (tarifs, FCC, monitoring)
- [Doc 01 — Prérequis & activation](../01-prerequis-activation/) (capacité, tenant, vérifications)
- Liens officiels détaillés dans les sources de chaque module (Copilot, Data Agents, Power BI Modeling MCP, Skills for Fabric)
