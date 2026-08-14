# Fiche 06 — Démarche globale et arbitrage

> Anti-sèche de référence : ordre de mise en œuvre, matrice des effets et arbres de décision. Fiche à garder sous la main après la formation.

## Objectifs

- Appliquer les fonctionnalités **dans le bon ordre**
- Savoir **quelle fonctionnalité résout quel problème**
- Connaître les limites communes et les règles de gestion (Git, pipelines)

## Ordre de mise en œuvre officiel

| Étape | Fonctionnalité | Rôle | Pourquoi cet ordre |
|---|---|---|---|
| 1 | **Schéma de données IA** | Délimiter ce que Copilot peut utiliser | Du plus structurel : on élimine l'ambiguïté à la source |
| 2 | **Réponses vérifiées** | Fiabiliser les questions fréquentes | On fixe les réponses critiques sur un périmètre nettoyé |
| 3 | **Instructions IA** | Ajouter le contexte métier | Le réglage fin vient après la structure |
| 4 | **Descriptions** | Enrichir les métadonnées | Fondation durable ; rôle croissant dans les capacités futures |

## Matrice capacité × fonctionnalité

Quelle fonctionnalité affecte quelle capacité Copilot :

| Capacité Copilot | Schéma IA | Réponses vérifiées | Instructions IA | Descriptions |
|---|---|---|---|---|
| Résumé du rapport | Non | Non | Oui | Non |
| Question sur les visuels du rapport | Non | Oui | Oui | Non |
| Question sur le modèle sémantique | Oui | Oui | Oui | Non |
| Création de page de rapport | Non | Non | Oui | Non |
| Recherche | Non | Oui | Non | Oui |
| Requête DAX | Non | Non | Oui | Oui |

## Arbres de décision

**Copilot choisit le mauvais champ / mauvais indicateur**
1. Schéma IA : retirer les champs source de confusion
2. Réponse vérifiée : fixer le visuel correct pour cette question
3. Instructions IA : ajustement fin (mapping champ)

**Copilot ne comprend pas un terme métier**
- Toujours la même signification (mapping 1:1) → instructions IA (« closers » = Sellers)
- Terme avec condition ou regroupement → instructions IA (définition : « high performer » = ≥ 100 % de cible)
- Terme à définitions multiples selon les équipes → **non supporté** (un terme = une définition par modèle)

**Question posée très fréquemment par les utilisateurs**
→ Réponse vérifiée (visuel approuvé + phrases déclencheuses)

**Copilot doit connaître le contexte pour résumer / créer des pages**
→ Instructions IA (seule fonctionnalité agissant sur ces capacités)

## Limites et règles communes

- Tout est stocké **au niveau du modèle** : pas de configuration par rapport (schéma, réponses vérifiées, instructions, descriptions).
- Instructions et schémas IA sont enregistrés dans la LSDL. Après modification via **Git ou pipelines de déploiement** :
  - modèles Import : actualiser le modèle dans le service pour synchroniser ;
  - modèles DirectQuery / Direct Lake : actualisation requise également, mais une seule fois par jour.
- L'IA est non déterministe : mêmes entrées ≠ forcément même sortie ; viser la fiabilité, pas l'exactitude absolue.
- La consommation de ces fonctionnalités par les utilisateurs finaux est possible partout où Copilot dans Power BI est disponible.
- Copilot (service) : non disponible sur trial SKUs ; vérifier la région de la capacité (voir [docs/01-prerequis-activation](../../../docs/01-prerequis-activation/)).

## Lien avec les autres modules

- Où est la limite Copilot vs Data Agent vs MCP vs Skills ? → [docs/05-matrice-arbitrage-globale](../../../docs/05-matrice-arbitrage-globale/)
- Audit automatisé de ces bonnes pratiques par MCP → module 04

## Sources

- [FAQ — ordre de mise en œuvre et arbitrage](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
- [Prepare your data for AI — considérations et limites](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai)
