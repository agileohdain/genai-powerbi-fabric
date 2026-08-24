# Phase 1 — Formation & démonstrations

Session théorique avec démonstrations sur le jeu de données générique (voir `assets/`). Les fiches sont présentées dans l'ordre de la démarche officielle Microsoft.

## Agenda indicatif (matinée)

| Horaire | Séquence | Fiche | Format |
|---|---|---|---|
| 09h00 | Accueil, objectifs, pourquoi la préparation est le facteur n°1 | — | Présentation |
| 09h10 | Évaluer son modèle sémantique | [01](01-evaluation-modele-semantique.md) | Théorie + contre-exemples |
| 09h40 | Schéma de données IA & réponses vérifiées | [02](02-schema-de-donnees-ia.md) | Démo |
| 10h30 | Pause | — | — |
| 10h45 | Instructions IA | [03](03-instructions-ia.md) | Démo + template |
| 11h15 | Tester et valider — Approved for Copilot | [04](04-approved-for-copilot.md) | Démo (HCAAT) |
| 11h45 | Démarche globale et arbitrage (anti-sèche ci-dessous) | — | Synthèse |
| 12h10 | Q&R et cadrage des ateliers Phase 2 | — | — |

## Matériel de démo requis

- Jeu de données générique (dossier `assets/`) avec :
  - les modèles AltiSport `altisport-v1` (mal préparé) et `altisport-v2` (bien préparé) dans `assets/modeles/`, présentés côte à côte en fiche 01
  - un visuel candidat pour une réponse vérifiée (fiche 02)
  - un vocabulaire métier fictif pour les instructions IA (fiche 03)
- Power BI Desktop avec *Prep data for AI* activé (Fichier > Options et paramètres > Options > Fonctionnalités d'aperçu)
- Un espace de travail Copilot-enabled dans le service Power BI

## Démarche globale et arbitrage (anti-sèche)

> À garder sous la main après la formation : ordre de mise en œuvre, matrice des effets et arbres de décision.

### Ordre de mise en œuvre officiel

| Étape | Fonctionnalité | Rôle | Pourquoi cet ordre |
|---|---|---|---|
| 1 | **Schéma de données IA** | Délimiter ce que Copilot peut utiliser | Du plus structurel : on élimine l'ambiguïté à la source |
| 2 | **Réponses vérifiées** | Fiabiliser les questions fréquentes | On fixe les réponses critiques sur un périmètre nettoyé |
| 3 | **Instructions IA** | Ajouter le contexte métier | Le réglage fin vient après la structure |
| 4 | **Descriptions** | Enrichir les métadonnées | Fondation durable ; rôle croissant dans les capacités futures |

> Le tableau couvre les fonctionnalités de configuration ; la démarche se conclut par le test et le marquage **Approved for Copilot** (fiche 04).

### Matrice capacité × fonctionnalité

| Capacité Copilot | Schéma IA | Réponses vérifiées | Instructions IA | Descriptions |
|---|---|---|---|---|
| Résumé du rapport | Non | Non | Oui | Non |
| Question sur les visuels du rapport | Non | Oui | Oui | Non |
| Question sur le modèle sémantique | Oui | Oui | Oui | Non |
| Création de page de rapport | Non | Non | Oui | Non |
| Recherche | Non | Oui | Non | Oui |
| Requête DAX | Non | Non | Oui | Oui |

### Arbres de décision

- **Copilot choisit le mauvais champ / indicateur** : 1. schéma IA (retirer les champs sources de confusion) → 2. réponse vérifiée (fixer le visuel correct) → 3. instructions IA (mapping fin).
- **Copilot ne comprend pas un terme métier** : mapping 1:1 ou définition conditionnelle → instructions IA ; définitions multiples selon les équipes → **non supporté** (un terme = une définition par modèle).
- **Question très fréquente** → réponse vérifiée. **Contexte nécessaire pour résumer / créer des pages** → instructions IA (seule fonctionnalité agissant sur ces capacités).

### Règles communes

- Tout est stocké **au niveau du modèle** : pas de configuration par rapport.
- Instructions et schémas IA sont dans la LSDL : après un déploiement **Git ou pipeline**, actualiser le modèle dans le service pour synchroniser (DirectQuery / Direct Lake : une fois par jour max).
- L'IA est non déterministe : viser la fiabilité, pas l'exactitude absolue.
- Où est la limite Copilot vs Data Agent vs MCP vs Skills ? → [docs/05-matrice-arbitrage-globale](../../../docs/05-matrice-arbitrage-globale/)

## Rappel des conventions

- Chaque fiche : objectifs > concepts > matériel de démo > pas-à-pas > limites et pièges > sources — la section *Matériel de démo* pointe les assets AltiSport à ouvrir (chemins, usage, déroulé). Exception fiche 02 : pas-à-pas, matching et tests sont fusionnés dans la section unique *Déroulé de la démo* (sous-sections numérotées)
- Les démonstrations utilisent le jeu générique ; l'application sur les modèles réels du client se fait en [Phase 2](../phase2-ateliers/)
