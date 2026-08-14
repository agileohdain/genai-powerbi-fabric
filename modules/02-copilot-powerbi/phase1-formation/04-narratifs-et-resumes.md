# Fiche 04 — Narratifs et résumés

## Objectifs

- Produire un résumé à trois endroits : volet Copilot (lecture), visuel Narratif (dans le rapport), abonnement e-mail
- Affiner un narratif par prompts itératifs et s'appuyer sur les notes de référence (*footnotes*)
- Connaître les limites : ce que le narratif lit, et ce qu'il ne lit pas

## Concepts clés

Le **visuel Narratif avec Copilot** (Desktop + service) résume le rapport, des pages ou des visuels sélectionnés. Contrairement aux questions de données, il lit **ce qui est affiché sur le canvas** — pas le modèle : des visuels et axes clairement nommés sont donc essentiels. Le prompt est stocké avec les métadonnées du rapport pour régénérer le résumé à chaque chargement.

Le visuel remplace progressivement l'ancien *smart narrative* : au premier ajout, un choix est proposé ; on peut basculer entre les deux sans perdre le contenu (seul le narratif Copilot n'est pas éditable directement — copier/coller vers le smart narrative pour éditer le texte à la main).

## Pas-à-pas (visuel narratif)

1. (Service) Ouvrir un rapport en mode Édition, ou depuis le hub de données : `... > Créer un rapport`
2. Volet Visualisations > icône **Narratif** > choisir le type **Copilot**
3. Choisir la portée : rapport entier, pages ou visuels (inclure/exclure individuellement)
4. **Lire et vérifier** le résumé ; survoler les **notes de référence** : Power BI met en surbrillance le visuel source de chaque affirmation
5. Affiner dans *Adjust your summary with Copilot* : prompts libres ou suggestions

## Prompts de référence (anglais + traduction)

| Objectif | Prompt (EN) | Traduction |
|---|---|---|
| Cibler un sujet | `Generate a summary focused on winter equipment sales.` | Génère un résumé centré sur les ventes d'équipements d'hiver. |
| Condenser | `Shorten this summary and make the key information bold.` | Raccourcis ce résumé et mets en gras les informations clés. |
| Réordonner | `Make the first bullet point about store performance.` | Mets en premier le point concernant la performance des magasins. |
| Expliquer une relation | `Generate a summary explaining the relationship between revenue, region, and product category.` | Génère un résumé expliquant la relation entre le chiffre d'affaires, la région et la catégorie de produits. |

Dans le **volet Copilot** (lecteurs) : prompts prêts à l'emploi comme `What is this report page about?`, ou `Write an executive summary for the senior management team, focusing on the distribution of operational results across regions` (Rédige un résumé exécutif pour la direction, centré sur la répartition des résultats opérationnels par région). Le survol des notes de référence **spotlighte** les visuels sources, et le bouton copier permet de partager le texte.

> Les résumés dans les **abonnements e-mail** sont démontrés en [atelier 2](../phase2-ateliers/atelier-2-prompts-adoption.md) (démo optionnelle).

## Limites et pièges

- Le résumé ne prend en compte que les **visuels sélectionnés** : exclure un visuel l'exclut du résumé
- Le narratif **ne se met pas à jour automatiquement** avec les filtres/segments : bouton **Actualiser** nécessaire
- Le corps du narratif Copilot n'est **pas éditable** : passer par des prompts, ou copier vers un smart narrative
- Tous les types de visuels ne sont pas supportés (ex. influenceurs clés non résumés)
- Nécessite des droits d'écriture pour créer le visuel ; sans eux, le volet Copilot suffit pour obtenir un résumé

## Sources

- [Create a narrative visual with Copilot](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-create-narrative?tabs=powerbi-service)
- [Write Copilot prompts for narrative visuals](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prompts-narratives)
- [Tutorial: Explore data and gain insights](https://learn.microsoft.com/en-us/power-bi/create-reports/tutorial-copilot-power-bi-explore-data)
