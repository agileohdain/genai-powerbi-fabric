# Doc 02 — Sécurité des features IA (périmètre technique)

Ce que la sécurité technique implique pour les 4 leviers de la formation (Copilot, Data Agents, MCP, Skills) : ce que chaque outil **voit**, ce qu'il **respecte** (RLS, OLS/CLS, permissions), et ce qu'il **fait transiter** hors de l'environnement. Référence factuelle — les modules 01, 04, 05 y renvoient ; le volet d'activation est dans [doc 01](../01-prerequis-admin/).

> Périmètre : **technique uniquement** (permissions, RLS/OLS, transit des données, garde-fous). Les implications RGPD / conformité de l'activation Copilot (données traitées hors région) sont signalées à la [doc 01](../01-prerequis-admin/#2-paramètres-tenant-portail-dadministration-fabric) : décision à documenter, hors champ de cette doc.

## Vue d'ensemble — les 3 frontières

| Frontière | Ce qu'elle retient / laisse passer | Leviers concernés |
|---|---|---|
| **Modèle sémantique** | RLS (lignes), OLS/CLS (colonnes/objets) du modèle Power BI | Copilot (Q&A/narratifs/CAX), Data Agents sur modèle sémant. |
| **Sources** (warehouse, lakehouse, KQL…) | Permissions de base données (SELECT…), RLS Fabric, Purview/DLP | Data Agents multi-sources |
| **Le LLM** (Azure OpenAI / GitHub Copilot) | Métadonnées, prompts, résultats **transités** pour génération | Tous (nature de l'IA) |

**Règle générale** : aucune feature ne contourne les permissions de l'utilisateur courant (RLS/OLS/CLS inclus) — la sécurité reste celle **du compte qui interroge**, pas une sécurité propre à l'outil. Ce qui change d'un levier à l'autre : les permissions **minimales** requises pour interroger, et **ce qui part au LLM**.

## 1. RLS / OLS et Copilot in Power BI

- Copilot opère sur les **données du modèle sémantique accessibles à l'utilisateur courant** : le **RLS s'applique** — un viewer sous RLS ne peut pas faire renvoyer à Copilot des lignes hors de son périmètre par reformulation de prompt.
- **OLS / CLS** : limites d'objets/colonnes respectées pareillement, sans contournement possible côté prompt.
- **Point de vigilance important** : le RLS ne s'applique qu'aux membres **Viewer** du workspace. Les rôles **Admin / Member / Contributor voient les données non filtrées** — y compris via Copilot. Travailler les démos avec un compte Viewer (ou *Test as role*) pour refléter l'expérience utilisateur.
- **Limite de vérification** : la fonctionnalité **Test as role** ne couvre **pas** Copilot, ni Q&A visuals, ni Quick insights. Pour vérifier ce qu'un viewer verrait via Copilot : se connecter avec un compte de ce viewer, ou tester le RLS séparément (rapport seul) puis transposer à l'usage Copilot.

## 2. Data Agents — permissions et sécurité des sources

Sources officielles : [Fabric data agent creation](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent) et [sharing & permissions](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing).

- **RLS et CLS honorés** : le data agent répond sous **l'identité de l'utilisateur qui interroge** — ses filtres RLS/CLS s'appliquent aux réponses. Un utilisateur sans droit sur une ligne/colonne voit une réponse vide, partielle **ou dégradée** (jamais les données hors périmètre).
- **Permissions minimales par source** (moindre privilège, officiel) :
  | Source | Minimum pour interroger via un agent | Notes |
  |---|---|---|
  | Modèle sémantique Power BI | **Read** sur le modèle | Workspace pas requis ; Build/Write seulement si modification (ex. Prep for AI) |
  | Lakehouse | Read (espace + tables si enforceé) | Write pas requis |
  | Warehouse | Read (SELECT sur les tables) | Niveaux supérieurs pour DML/DDL |
  | KQL database | Rôle Reader | — |
  | Ontology | Read ontology + Read données liées | — |
  | Microsoft Graph in Fabric | Read sur l'item et les données | — |
- **Conséquence de partage** : partager un agent ne donne **pas** accès aux sources — il faut aussi partager l'accès aux données (« *you must also share access to the underlying data* »). Un utilisateur qui a l'agent mais pas le Read source échoue ou a des réponses vides.
- **Permissions sur l'agent lui-même** (configuration) : *Aucune* (interroge la version publiée seulement) / *View details* (consulte les configs, ne modifie pas) / *Edit and view details* (modifie la config + interroge). La **description publiée** de l'agent est visible des consommateurs — ne pas y mettre d'information sensible.
- **Purview / DLP** : les politiques de protection (data loss prevention, access restriction) s'appliquent aux réponses (blocage ou troncature) — voir la [fiche qualité du module 03](../../modules/03-fabric-data-agents/phase1-formation/03-qualite-et-verification.md).

## 3. MCP & Skills — le poste local et le fournisseur LLM

Les modules 04 (MCP) et 05 (Skills) génèrent **en local** (VS Code / Copilot CLI) : ils n'élargissent **pas** les droits de l'utilisateur, mais ils font **transiter vers le fournisseur LLM** (GitHub Copilot / Azure OpenAI) les données qu'ils consultent — c'est le point de sécurité distinctif de ces leviers.

- **MCP (module 04)** : le serveur lit les **métadonnées du modèle** (schéma, DAX) et des **résultats de requêtes** pour répondre — ces métadonnées partent au fournisseur LLM. Garde-fous : ne jamais ouvrir dans le chat `.pbi/`, `cache.abf`, `localSettings.json`, `.env`, credentials ; purger les fichiers sensibles avant manipulation ; préférer les permissions d'un compte de service limité.
- **Skills (module 05)** : le skill manipule les **fichiers PBIR du rapport** (JSON) — la sécurité tient au dossier PBIP (qui peut le lire) et à ce qui est envoyé par prompt/actions de l'agent. Le modèle et les données **source ne sont pas lus** par le skill (le `definition.pbir` pointe vers le modèle par référence, non copié). Pas de changement des droits : seul ce que l'utilisateur peut déjà voir/faire est manipulé.
- **Bonnes pratiques communes** : comptes avec moindre privilège (pas l'admin du data), revue du diff Git avant publication, ne pas coller de données confidentielles dans les prompts, vérifier les politiques d'entreprise GitHub Copilot (ex. données autorisées dans l'outil).

## 4. Ce qui ne dépend pas de l'outil

- **Tenant / capacité** : activation Copilot (tenant + capacité, groupe de sécurité recommandé) et éventuelle **Fabric Copilot capacity (FCC)** pour regrouper la facturation d'un groupe d'utilisateurs — voir [docs/01](../01-prerequis-admin/) et [docs/04](../04-consommation-cus-ia/).
- **Région & résidence** : selon la région de la capacité, l'activation du *second paramètre tenant* (traitement possible hors région) peut être nécessaire — implication documentée côté admin (docs/01).
- **Copilot n'entraîne pas sur vos données** : les prompts/réponses ne sont pas stockés après la session et ne servent pas à l'entraînement des modèles de fondation (frontière du tenant respectée) — page officielle ci-dessous.

## 5. Checklist sécurité pour une mission

- [ ] RLS/OLS définis dans le modèle (rôles Desktop → membres au service) ; vérifier l'usage avec un compte **Viewer**
- [ ] Savoir que Test as role ne couvre **pas** Copilot/Q&A/Quick insights — tester avec un vrai compte viewer
- [ ] Data Agents : permissions source minimales (Read à la source suffit), partage agent ≠ accès données
- [ ] MCP/Skills : dossier PBIP propre (aucun secret), moindre privilège, diff Git avant publication
- [ ] Copilot ciblé sur un groupe de sécurité si l'usage est large ; FCC envisagée pour piloter le coût (docs/04)
- [ ] Conformité/transit : paramètre tenant documenté (docs/01), politiques GitHub Copilot d'entreprise vérifiées

## Sources

- [Privacy, security, and responsible use for Copilot in Power BI](https://learn.microsoft.com/en-us/fabric/fundamentals/copilot-power-bi-privacy-security) — données accédées, non-entraînement, frontière tenant (maj. 05/2026)
- [Row-level security (RLS) with Power BI](https://learn.microsoft.com/en-us/fabric/security/service-admin-row-level-security) — rôles Viewer vs Admin/Member/Contributor, limites Test as role (Q&A, Quick insights, Copilot exclus)
- [Fabric data agent sharing and permission management](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-sharing) — RLS/CLS honorés, permissions minimales par source, Read suffisant (maj. 05/2026)
- [Fabric data agent creation](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent) — sources, lecture seule, limites produit
- Modules [04-mcp-data-modelling](../../modules/04-mcp-data-modelling/) et [05-fabric-skills-authoring](../../modules/05-fabric-skills-authoring/) — garde-fous de sécurité spécifiques (fiches « Limites et pièges »)
