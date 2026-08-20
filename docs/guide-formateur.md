# Guide formateur

Votre rôle : **garant de la méthode et du rythme**. Le contenu vit dans les modules — ce guide dit par quoi commencer, où trouver quoi, et les réflexes qui sauvent une session.

## Chronologie d'une mission

### 1 · À la signature

| # | Action | Où | Blocant pour |
|---|---|---|---|
| 1 | Créer la copie client du dépôt : `gh repo create client-xyz --template agileohdain/genai-powerbi-fabric --private` | [README racine](../README.md) | tout |
| 2 | Transmettre la checklist d'activation à l'admin tenant (licences, capacité, Copilot) et convenir d'une date de vérification | [docs/01](01-prerequis-admin/) | toutes les démos Copilot (modules 01-03, 05) |
| 3 | Choisir le format — intensif (7 j) ou alterné (1 j/semaine) — et poser les dates | [docs/06](06-agenda-suggere/) | agenda |
| 4 | Faire identifier par le client : **les modèles sémantiques pilotes** (terrain des ateliers) et **la liste des participants** par profil | README de chaque module (section Public) | ateliers M01+ |

> L'étape 2 est la seule vraiment critique : sans Copilot activé sur le tenant et la capacité, aucune démo ne fonctionne. La vérifier soi-même, pas seulement sur parole.

### 2 · J-7 — préparer l'environnement

**Les postes des participants** — faire suivre les 4 guides par les équipes IT (ou les préparer vous-même pour une salle) :

| Guide | Pour |
|---|---|
| [setup/00](../setup/00-recuperer-depot.md) | Clonage de la copie client du dépôt — tout le monde |
| [setup/01](../setup/01-powerbi-desktop.md) | Power BI Desktop + aperçu *Prep data for AI* — tout le monde |
| [setup/02](../setup/02-vscode-mcp.md) | VS Code + serveur MCP — module 04 (profils dev) |
| [setup/03](../setup/03-skills-copilot-cli.md) | Copilot CLI + plugin Skills — module 05 (profils dev) |
| [setup/04](../setup/04-capacite-gouvernance.md) | Capacité & gouvernance — module 06, admin |

**Votre environnement de démo** :

1. Ouvrir `assets/modeles/altisport-v2` dans Power BI Desktop ; vérifier le paramètre Power Query `DossierData` (chemin des CSV — voir [assets/README](../assets/README.md)) si le dépôt n'est pas dans `C:\dev`.
2. Rejouer **2-3 démos** du [mapping démos ↔ assets](../assets/README.md) — au minimum une du module que vous maîtrisez le moins.
3. Vérifier que Copilot répond sur le tenant (question simple sur v2).
4. Imprimer les [antisèches](../assets/antiseches/) et prévoir les passeports ([docs/passeport](passeport/)) — un par participant.

### 3 · Jour J — animer

- **Distribuer le passeport dès le début de J1** — il rythme le parcours.
- **Rythme type** : formation du module (fiches + démos AltiSport) → quiz d'ancrage (~10 min, corrigé plié dans chaque `quiz.md`) → [rétro express](retro-module.md) (5 min, fin de module ou fin de journée).
- **Badges sur preuve uniquement** : quiz ≥ 4/5 **et** ateliers validés ([feuille de route](../README.md)).
- **Ateliers = modèles réels du client**, jamais des exercices : les participants appliquent sur leurs propres modèles, vous circulez. AltiSport reste le terrain de repli si un modèle client n'est pas prêt.
- Les durées détaillées vivent dans chaque module et chaque atelier — l'[agenda](06-agenda-suggere/) reste indicatif, à ajuster.

### 4 · Après la formation

- Clôture : rétro globale + badges finaux (le passeport fait foi).
- Vérifier que les **livrables d'ateliers** sont remis au client — plan d'action M01, fiches de recette, catalogue de prompts, charte de gouvernance M06. C'est le retour sur investissement de la mission, à ne pas laisser dans les postes de travail.
- Archiver la copie client du dépôt (elle contient la trace des ateliers).

## Où trouver quoi

| Besoin | Où |
|---|---|
| Contenu d'un module (fiches, ateliers, durées) | `modules/<module>/README.md` puis `phase1-formation/` et `phase2-ateliers/` |
| Démos : quoi montrer, sur quel modèle | [Mapping démos ↔ assets](../assets/README.md) + README de phase 1 du module |
| Jeu de données, pièges pédagogiques, modèles v1/v2 | [assets/README](../assets/README.md) + [guide des modèles](../assets/modeles/guide-modeles.md) |
| Activation tenant, licences (admin) | [docs/01](01-prerequis-admin/) |
| Sécurité, RLS et features IA | [docs/02](02-securite/) |
| Limites, hallucinations, cache 24 h | [docs/03](03-limites-hallucinations-validation/) |
| Coûts, CUs, throttling | [docs/04](04-consommation-cus-ia/) |
| Choisir entre Copilot / Data Agent / MCP / Skills | [docs/05](05-matrice-arbitrage-globale/) |
| Agenda, formats, conseils de rythme | [docs/06](06-agenda-suggere/) |
| Supports participants (passeport, antisèches, glossaire) | [README racine — Supports participants](../README.md) |

## Réflexes d'animation

- **L'IA est non déterministe** : une démo peut répondre autrement qu'à la répétition. Prévenez-le avant qu'un participant ne le découvre ; c'est un point pédagogique, pas un échec.
- **Cache 24 h de Copilot** : un même prompt sur un modèle inchangé peut être servi depuis un cache — effacer la conversation ou reformuler ([docs/03](03-limites-hallucinations-validation/)).
- **Démos avec un compte Viewer** : les rôles Admin/Member/Contributor voient les données non filtrées, y compris via Copilot — utilisez *Test as role* pour refléter l'expérience des participants ([docs/02](02-securite/)).
- **Les défauts des CSV AltiSport sont volontaires** (casse, dates en texte, « Divers »…) : ne pas les corriger avant la démo, ils font la matière des fiches ([table des pièges](../assets/README.md)).
- **Un atelier dérape ?** Chaque fiche d'atelier contient ses **antidotes aux dérives** — y renvoyer plutôt qu'improviser.
- **Question hors périmètre** (tarif, roadmap Microsoft, sécurité avancée) : renvoyer aux docs 01-05 plutôt qu'improviser une réponse.
