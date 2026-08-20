# GenAI Power BI & Fabric

Formation à l'IA générative pour Power BI & Microsoft Fabric : Copilot Power BI, Fabric Data Agents, MCP Data Modelling, Fabric Skills et gouvernance des CUs.

> Dépôt privé — contenu de formation. Chaque mission client s'appuie sur une copie de ce dépôt (template repository).

## Organisation de la formation

| Phase | Contenu | Support |
|---|---|---|
| **Phase 1 — Formation & démonstrations** | Concepts et démonstrations sur le jeu de données générique AltiSport (`assets/`) | `modules/*/phase1-formation/` |
| **Phase 2 — Ateliers d'application** | Prise en main directe par l'équipe sur des cas d'usage et modèles sémantiques réels du client | `modules/*/phase2-ateliers/` |

## Feuille de route — 6 badges

| Étape | Badge | Module | Capacité validée |
|---|---|---|---|
| 1 | 🛠️ Copilot-ready | [01](modules/01-preparation-copilot-ready/) | Préparer et valider un modèle sémantique pour l'IA |
| 2 | 💬 Copilot | [02](modules/02-copilot-powerbi/) | Générer et vérifier avec Copilot Power BI |
| 3 | 🤖 Fabric Agent | [03](modules/03-fabric-data-agents/) | Construire, recetter et partager un data agent |
| 4 | 🔧 MCP | [04](modules/04-mcp-data-modelling/) | Auditer et documenter un modèle via MCP |
| 5 | 🎨 Fabric Skills | [05](modules/05-fabric-skills-authoring/) | Créer, re-thématiser et traduire des rapports |
| 6 | 🛡️ Gouvernance CUs | [06](modules/06-gouvernance-cus/) | Mesurer et gouverner la consommation IA |

> Chaque badge s'obtient sur preuve : quiz d'ancrage ≥ 4/5 **et** ateliers validés. Suivez votre progression dans le **[passeport IA](docs/passeport/)** ; planning dans l'[agenda suggéré](docs/06-agenda-suggere/).

## Modules

| # | Module | Contenu | Statut | Durée |
|---|---|---|---|---|
| 01 | [Préparation Copilot-ready](modules/01-preparation-copilot-ready/) | Bonnes pratiques de préparation des données et modèles sémantiques pour Copilot, Data Agents | ✅ | ~3 h + ≈ 0,75 j |
| 02 | [Copilot Power BI](modules/02-copilot-powerbi/) | Desktop & Service : génération de rapports, requêtes en langage naturel, prompting | ✅ | ~3 h + ≈ 0,75 j |
| 03 | [Fabric Data Agents](modules/03-fabric-data-agents/) | Création, configuration, interrogation d'un Data Agent (no-code), matrice d'arbitrage | ✅ | ~3 h + ≈ 0,75 j |
| 04 | [MCP Data Modelling](modules/04-mcp-data-modelling/) | Code agentique via VS Code : audit & corrections DAX, documentation de masse | ✅ | ~2,5 h + ≈ 0,75 j |
| 05 | [Fabric Skills Authoring](modules/05-fabric-skills-authoring/) | Charte visuelle, PPT → rapport, refactoring de visuels, traduction de masse | ✅ | ~2,5 h + ≈ 0,75 j |
| 06 | [Gouvernance & CUs](modules/06-gouvernance-cus/) | Consommation des Capacity Units, seuils d'alerte, prévention du throttling | ✅ | ~2 h + ≈ 0,5 j |

> Durée totale du parcours (modules 01-06, phases 1 + 2) : **≈ 6,25 jours**, + documentation transversale (docs 01-06) et installation des postes ([setup](setup/)).

## Documentation transversale

| # | Sujet | Statut |
|---|---|---|
| 01 | [Pour admin](docs/01-prerequis-admin/) — licences, régions, paramètres tenant | ✅ |
| 02 | [Sécurité](docs/02-securite/) — RLS/OLS et features IA (périmètre technique) | ✅ |
| 03 | [Limites, hallucinations & validation humaine](docs/03-limites-hallucinations-validation/) | ✅ |
| 04 | [Consommation des CUs par les features IA](docs/04-consommation-cus-ia/) — tarifs tokens, throttling, Fabric Copilot capacity | ✅ |
| 05 | [Matrice d'arbitrage globale](docs/05-matrice-arbitrage-globale/) — Copilot vs Data Agent vs MCP vs Skills | ✅ |
| 06 | [Agenda suggéré](docs/06-agenda-suggere/) — formats intensif et alterné | ✅ |

## Supports participants

| Support | Usage |
|---|---|
| [Passeport IA](docs/passeport/) | Suivi de progression et 6 badges, à conserver tout au long du parcours |
| [Antisèches](assets/antiseches/) | Prompting Copilot · MCP · arbitrage — 1 page chacune, à imprimer |
| [Glossaire](docs/glossaire.md) | Vocabulaire IA & BI de la formation |
| [Rétro express](docs/retro-module.md) | Modèle de rétro 5 min en fin de module |

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

> Formateurs : suivez le **[guide formateur](docs/guide-formateur.md)** — chronologie de préparation d'une mission, de la signature à la clôture.

Présentation commerciale du parcours (projection + leave-behind) : [prevente/index.html](prevente/index.html).

Puis suivre les guides [setup](setup/) (postes des participants) et la checklist d'activation de [docs/01-prerequis-admin](docs/01-prerequis-admin/) (admin tenant).
