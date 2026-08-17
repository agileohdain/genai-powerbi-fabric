# GenAI Power BI & Fabric

Formation à l'IA générative pour Power BI & Microsoft Fabric : Copilot Power BI, Fabric Data Agents, MCP Data Modelling, Fabric Skills et gouvernance des CUs.

> Dépôt privé — contenu de formation. Chaque mission client s'appuie sur une copie de ce dépôt (template repository).

## Organisation de la formation

| Phase | Contenu | Support |
|---|---|---|
| **Phase 1 — Formation & démonstrations** | Concepts et démonstrations sur le jeu de données générique AltiSport (`assets/`) | `modules/*/phase1-formation/` |
| **Phase 2 — Ateliers d'application** | Prise en main directe par l'équipe sur des cas d'usage et modèles sémantiques réels du client | `modules/*/phase2-ateliers/` |

## Modules

| # | Module | Contenu | Statut | Durée |
|---|---|---|---|---|
| 01 | [Préparation Copilot-ready](modules/01-preparation-copilot-ready/) | Bonnes pratiques de préparation des données et modèles sémantiques pour Copilot, Data Agents | ✅ | ~3 h + ≈ 0,75 j |
| 02 | [Copilot Power BI](modules/02-copilot-powerbi/) | Desktop & Service : génération de rapports, requêtes en langage naturel, prompting | ✅ | ~3 h + ≈ 0,75 j |
| 03 | [Fabric Data Agents](modules/03-fabric-data-agents/) | Création, configuration, interrogation d'un Data Agent (no-code), matrice d'arbitrage | ✅ | ~3 h + ≈ 0,75 j |
| 04 | [MCP Data Modelling](modules/04-mcp-data-modelling/) | Code agentique via VS Code : audit & corrections DAX, documentation de masse | ✅ | ~2,5 h + ≈ 0,75 j |
| 05 | [Fabric Skills Authoring](modules/05-fabric-skills-authoring/) | Charte visuelle, PPT → rapport, refactoring de visuels, traduction de masse | ✅ | ~2,5 h + ≈ 0,75 j |
| 06 | [Gouvernance & CUs](modules/06-gouvernance-cus/) | Consommation des Capacity Units, seuils d'alerte, prévention du throttling | ✅ | ~2 h + ≈ 0,5 j |

> Durée totale du parcours (modules 01-06, phases 1 + 2) : **≈ 6,25 jours**, + documentation transversale (docs 01-05) et installation des postes ([setup](setup/)).

## Documentation transversale

| # | Sujet | Statut |
|---|---|---|
| 01 | [Prérequis & activation](docs/01-prerequis-activation/) — licences, régions, paramètres tenant | ✅ |
| 02 | [Sécurité](docs/02-securite/) — RLS/OLS et features IA (périmètre technique) | ✅ |
| 03 | [Limites, hallucinations & validation humaine](docs/03-limites-hallucinations-validation/) | ✅ |
| 04 | [Consommation des CUs par les features IA](docs/04-consommation-cus-ia/) — tarifs tokens, throttling, Fabric Copilot capacity | ✅ |
| 05 | [Matrice d'arbitrage globale](docs/05-matrice-arbitrage-globale/) — Copilot vs Data Agent vs MCP vs Skills | ✅ |

## Arborescence

```
genai-powerbi-fabric/
├── README.md
├── docs/                                  # Documentation transversale
├── modules/                               # Modules de formation (phase1 / phase2)
├── setup/                                 # Installation des ressources (Desktop, VS Code/MCP, Skills for Fabric, capacités…)
└── assets/                                # Jeu de données AltiSport, vocabulaire métier, thème, modèles PBIP
```

## Démarrer une mission client

Ce dépôt est un **template repository**. Pour créer une copie privée dédiée à un client :

```powershell
gh repo create client-xyz --template agileohdain/genai-powerbi-fabric --private
```

Puis suivre les guides [setup](setup/) (postes des participants) et la checklist d'activation de [docs/01-prerequis-activation](docs/01-prerequis-activation/) (admin tenant).
