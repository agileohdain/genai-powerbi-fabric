# Fiche 03 — Questions de données : poser, lire, vérifier

> Fiche charnière du module : c'est ici que se construit la confiance. Une réponse non vérifiée est une réponse non utilisable.

## Objectifs

- Comprendre **l'ordre de résolution** d'une question : visuels du rapport → modèle sémantique → connaissances générales du LLM
- Poser des questions efficaces (existantes, filtrées, ad hoc) et reconnaître les questions non supportées
- **Vérifier chaque réponse** : raisonnement, champs et filtres utilisés
- Connaître les pièges documentés et savoir réagir

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** + rapport de départ publiés | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) ; rapport 2-3 pages ([README de phase](README.md#matériel-de-démo-requis)) | Terrain des questions et de la vérification |

**Questions à rejouer en démo** (en anglais — voir limites) : `Show me sales by sector` (ambiguïté du piège #7 : vérifier la colonne retenue dans HCAAT), `What were the top 5 selling products last month?`, relance `Now only for 2025`, puis une question utilisant un terme des instructions IA (`white season`). Chaque réponse passe par les trois réflexes de la section « Lire et vérifier ».

## Ordre de résolution — le modèle mental

1. Copilot cherche d'abord si la réponse est dans les **visuels du rapport** ouvert
2. Sinon, il **construit un visuel** en interrogeant le modèle sémantique (mêmes moteur et exigences que Q&A)
3. Si la question ne porte pas sur les données, il peut répondre depuis les **connaissances générales** du LLM — à détecter et éviter pour les usages métier

> Le volet Copilot **n'hérite pas** des filtres et segments appliqués à la page : une réponse peut donc différer du contexte visuel. Le préciser systématiquement dans le prompt si nécessaire (`in 2025`, `excluding cancelled orders`…).

## Types de questions

| Type | Exemple (EN) | Traduction |
|---|---|---|
| Mesure × dimension | `Show me sales amount by region` | Montre le montant des ventes par région |
| Top N | `What were the top 5 selling products in North America last month?` | Quels sont les 5 produits les plus vendus en Amérique du Nord le mois dernier ? |
| Filtre relatif temporel | `Tell me the average price over the last 30 days` | Prix moyen sur les 30 derniers jours |
| Multi-instances d'une entité | `Which customers bought both skis and ski boots?` | Quels clients ont acheté à la fois des skis et des chaussures ? |
| Suivi de session | `Now only for 2025` (question de relance) | Maintenant seulement pour 2025 |
| **DAX ad hoc** | `What was the year-over-year growth for sales?` | Quelle est la croissance des ventes d'une année sur l'autre ? |

Le **DAX ad hoc** génère une requête visible et vérifiable (vue développée, ou lancement dans la vue Requête DAX).

**Non supporté** (génération d'insights) : `Why do sales drop every July?` (causalité), prévisions, détection d'anomalies, influenceurs clés → pour ces besoins, utiliser les visuels dédiés de Power BI.

## Lire et vérifier une réponse

Toute réponse = **visuel + résumé textuel + champs utilisés**. Trois réflexes :

1. Déployer **« How Copilot arrived at this »** : quels champs, quelles mesures, quels filtres Copilot a retenus — c'est là qu'on voit la colonne de date ou la table erronée
2. Cliquer un élément **Data used** pour le détail ; **Expand** pour agrandir le visuel
3. En mode auteur : **Add to page** ajoute le visuel au rapport → le sélectionner pour inspecter ses filtres dans le volet Filtres

## Pièges documentés (exemples Microsoft)

| Symptôme | Cause | Correctif |
|---|---|---|
| `profit %` renvoie le profit, pas le pourcentage | Ambiguïté du prompt | Écrire `profit as a percentage of revenue` |
| `units in Australia` filtre `Customer[Country]` au lieu de `Sales region[Country]` | Colonnes homonymes entre tables | Renommer/masquer la colonne ambiguë (module 01) ou préciser la table dans le prompt |
| « No data for 2024 » alors que les données existent | Copilot a filtré sur `Customer[Birthday]` et non la table de dates marquée | Masquer les colonnes de dates parasites ; s'appuyer sur la table de dates marquée |
| Réponses qui dérivent en cours de session | L'**historique de conversation** sert d'ancrage | Effacer la conversation (clear chat) avant un nouveau sujet |
| Réponse hors données (générale) | Question hors modèle → LLM | Reformuler en question de données ; vérifier la source affichée |

## Limites et pièges

- Questions de données : **anglais uniquement** (support multilingue non officiel) ; dans Desktop, l'expérience questions de données reste en déploiement — privilégier le service pour les démos questions/réponses
- Q&A doit être activé ; DirectQuery / Direct Lake peuvent demander une activation manuelle
- Les pourcentages peuvent s'afficher différemment entre le texte et les tableaux (formats du modèle)
- Même prompt + même modèle ≠ même réponse garantie : la recette (atelier 1) intègre cette variabilité
- Les prompts vagues, les fautes sur les noms de champs, les abréviations dégradent fortement les résultats : nommer les champs comme dans le modèle

## Sources

- [Ask Copilot questions about your data](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-ask-data-question)
- [Use Copilot with semantic models](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-semantic-models)
- [Tutorial: Discover data and ask questions](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-discover-data)
