# Antisèche — Prompting Copilot Power BI

> 1 page à imprimer. Condensé du [module 02](../../modules/02-copilot-powerbi/) — les fiches restent la référence.

## Règles d'or

1. **Prompts en anglais** (multilingue non supporté officiellement)
2. **Nommer les champs comme dans le modèle** — pas d'abréviations, pas de fautes
3. **Préciser le contexte que le volet n'hérite pas** : fenêtre temporelle, filtres, exclusions (`in 2025`, `excluding cancelled orders`…)
4. **Vérifier chaque réponse** avant de l'utiliser (voir ci-dessous)
5. Nouveau sujet → **effacer la conversation** (clear chat)

## Patterns de questions de données

| Besoin | Prompt (EN) | FR |
|---|---|---|
| Mesure × dimension | `Show me sales amount by region` | Ventes par région |
| Top N | `What were the top 5 selling products in North America last month?` | Top 5 produits le mois dernier |
| Filtre temporel relatif | `Tell me the average price over the last 30 days` | Prix moyen sur 30 jours |
| Multi-instances | `Which customers bought both skis and ski boots?` | Clients ayant acheté les deux |
| Relance de session | `Now only for 2025` | Maintenant pour 2025 seulement |
| DAX ad hoc | `What was the year-over-year growth for sales?` | Croissance des ventes N vs N-1 |

**Non supporté** : causalité (`Why do sales drop?`), prévisions, anomalies → visuels dédiés de Power BI.

## Les 3 réflexes de vérification

1. Déployer **« How Copilot arrived at this »** → champs, mesures, filtres retenus (c'est là qu'on voit l'erreur)
2. Cliquer **Data used** pour le détail ; **Expand** pour agrandir
3. Mode auteur : **Add to page** → inspecter les filtres du visuel dans le volet Filtres

## Pièges connus → antidotes

| Symptôme | Antidote |
|---|---|
| `profit %` renvoie le profit | Écrire `profit as a percentage of revenue` |
| Mauvaise colonne filtrée (`Country` ambigu) | Renommer/masquer la colonne (module 01) ou nommer la table dans le prompt |
| « No data » alors que les données existent | Colonne de dates parasite → s'appuyer sur la table de dates marquée |
| Réponses qui dérivent en session | Historique = ancre → clear chat avant un nouveau sujet |
| Réponse hors données (générale) | Question hors modèle → reformuler en question de données |

## À retenir

- Même prompt ≠ même réponse garantie (non déterministe, cache 24 h)
- Toute interaction consomme des CUs ([docs/04](../../docs/04-consommation-cus-ia/))
- Copilot ne connaît pas votre contexte métier : c'est vous l'expert, lui l'accélérateur
