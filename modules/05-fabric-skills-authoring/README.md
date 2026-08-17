# Module 05 — Fabric Skills Authoring

## Pourquoi ce module

Le module 04 a automatisé le **modèle sémantique** avec MCP ; il reste l'autre moitié du travail BI : la **couche rapport** (pages, visuels, formatage, thème), traditionnellement du « clic-clic » long à la main — créer un rapport, appliquer une charte, migrer des visuels hérités, traduire des libellés. Les **Skills for Fabric** (dépôt Microsoft, Public Preview) sont des paquets d'instructions que l'agent Copilot charge pour faire ce travail **en fichiers PBIR** (Power BI Project) : via GitHub Copilot CLI ou VS Code, avec deux CLIs officiels — `powerbi-report-author` (valider, cataloguer, connaître le formatage) et `powerbi-desktop` (recharger Desktop, capturer des écrans).

> Ce module est le **complément rapport** du module 04 : celui-ci pilotait le modèle avec le Power BI Modeling MCP, celui-là pilote la couche rapport avec les skills. Les deux se combinent : le skill `semantic-model-authoring` (modèle) recoupe le module 04 et reste hors périmètre ici — ce module travaille exclusivement le rapport.

## Objectifs

- Comprendre ce qu'est un **skill** (instructions chargées à la demande) vs **MCP** (outil), et le plugin `powerbi-authoring`
- Installer l'environnement : Copilot CLI/VS Code, plugin Skills for Fabric, CLIs Node, Desktop Bridge ([setup/03](../../setup/03-skills-copilot-cli.md))
- **Créer un rapport** depuis un modèle existant : design brief (`powerbi-report-design`) → implémentation (`powerbi-report-authoring`), avec charte visuelle (thème AltiSport, PPT/maquettes)
- **Refactorer** : migrer les visuels legacy vers les types modernes, re-thémériser avec sweep des couleurs inline
- **Traduire en masse** les libellés d'un rapport (pages, titres, textboxes)
- Appliquer la **boucle de vérification** Edit → Validate → Reload → Screenshot et les garde-fous (baseline Git, revue)

## Public

Développeurs BI, data engineers, analystes avancés à l'aise avec VS Code/Copilot CLI (même profil que le module 04). Les fiches présupposent les concepts du module 01 (modèle préparé) et du module 04 (MCP, patterns), sans être un cours de création de rapports.

## Prérequis

- [setup/03-skills-copilot-cli.md](../../setup/03-skills-copilot-cli.md) suivi : Copilot CLI ou VS Code, plugin `powerbi-authoring` installé (`/skills`), Node.js 18+, CLIs `powerbi-report-author` et `powerbi-desktop`, Desktop Bridge activé
- Un projet **PBIP** (format obligatoire, pas PBIR-Legacy) avec son modèle sémantique
- Les assets AltiSport : rapport **vide v2** (`assets/modeles/altisport-v2/`) pour la création, **rapport legacy** (`assets/modeles/altisport-rapport-legacy/`) pour le refactoring/traduction, charte (`assets/theme-charte.json`)
- Desktop avec le PBIP ouvert pour les démos de rendu ; `git status` propre (baseline)

## Contenu

| Phase | Contenu | Durée indicative |
|---|---|---|
| [Phase 1 — Formation](phase1-formation/) | 3 fiches : skills & agents, charte & création, refactoring & traduction | ~2,5 h |
| [Phase 2 — Ateliers](phase2-ateliers/) | 2 ateliers sur les rapports réels du client : charte + refactor, traduction + adoption | ≈ 0,75 jour |

## Points d'attention transversaux

- **Public Preview** : le dépôt Skills for Fabric évolue rapidement ; vérifier la version du plugin et les références avant chaque mission ([CHANGELOG](https://github.com/microsoft/skills-for-fabric/blob/main/CHANGELOG.md))
- **PBIR uniquement** : rapports en PBIR (pas Legacy) ; le `getDefinition` depuis Fabric doit demander `format=PBIR`
- **Baseline avant écriture** : committer le dossier PBIP avant une session — le skill écrit du JSON ; le diff Git est la sauvegarde
- **Ne jamais laisser deviner le JSON PBIR** : rôles de visuels, formatage, énumérations sortent du CLI (`powerbi-report-author catalog/formatting`) et des références du skill, jamais de mémoire
- **Sécurité** : le skill ne touche pas le **modèle** (renvoi module 04) et n'élargit pas les droits ; le rendu se vérifie en Desktop local avant toute publication (voir [docs/02-securite](../../docs/02-securite/))
- Qualité des réponses : privilégier un **modèle à raisonnement profond** comme au module 04

## Sources principales

- [Power BI Agentic — vue d'ensemble (Microsoft Learn)](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-agentic-overview)
- [Skills for Fabric (dépôt Microsoft)](https://github.com/microsoft/skills-for-fabric)
- [Report Authoring skill](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-report-authoring-skill-overview) / [Report Design skill](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-report-design-skill-overview) / [Report Planner & Management](https://learn.microsoft.com/en-us/power-bi/developer/agentic/power-bi-planner-fabric-skill-overview)
- [CLI `@microsoft/powerbi-report-authoring-cli`](https://www.npmjs.com/package/@microsoft/powerbi-report-authoring-cli)
