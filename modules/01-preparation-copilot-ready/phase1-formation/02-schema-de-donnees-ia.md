# Fiche 02 — Schéma de données IA

## Objectifs

- Restreindre le périmètre de champs que Copilot utilise pour répondre aux questions de données
- Supprimer l'ambiguïté liée aux champs redondants ou techniques du modèle
- Tester le périmètre retenu avec la méthode négatif/positif

## Concepts clés

Le **schéma de données IA** (AI data schema) permet à l'auteur du modèle de définir un sous-ensemble du schéma que Copilot priorise quand il génère ses réponses. Un schéma resserré réduit l'ambiguïté : Copilot utilise les bons champs sans demander de clarification à l'utilisateur.

Le schéma IA s'applique uniquement aux capacités de Copilot qui s'appuient sur le schéma du modèle pour répondre aux questions de données (voir la matrice en [fiche 06](06-demarche-globale.md)).

## Cas d'usage typiques

- **Ambiguïté d'indicateur** : le modèle contient `Total GPM` (marge) et `Total Sales` (ventes). Quand l'utilisateur demande « les ventes », Copilot peut retourner la marge — une interprétation légitime mais contraire à l'usage de l'équipe. Retirer `Total GPM` du schéma IA force Copilot sur la bonne mesure.
- **Modèle de développement** : le modèle contient des tables techniques ou de travail inutiles aux utilisateurs finaux ; on les exclut du schéma IA.
- **Grands modèles** : des champs au nom proche sèment la confusion ; on ne conserve que les champs réellement demandés.

## Pas-à-pas

### Dans Power BI Desktop

1. Bouton **Prep data for AI** sur le ruban Accueil (si les onglets sont grisés : activer Q&A pour le modèle).
2. Onglet **Simplify data schema**.
3. Sélectionner les champs que Copilot doit utiliser : privilégier les colonnes nettes et sans ambiguïté, retirer les champs sources de confusion.
4. **Apply** : les changements sont enregistrés sur le modèle.

### Dans le service Power BI

Même démarche depuis le ruban de la page du modèle sémantique, puis **Apply**.

### Tester (méthode négatif/positif)

1. Ouvrir le volet Copilot du rapport dans Desktop.
2. Skill picker > **Answer data question** (Répondre à des questions sur les données).
3. Poser une question utilisant un champ **hors** schéma IA : Copilot ne doit pas répondre.
4. Poser une question utilisant un champ **dans** le schéma IA : Copilot doit répondre.
5. Publier dans le service pour la consommation.

## Limites et pièges

- Les consommateurs ne voient pas le schéma IA et **ne peuvent pas le désactiver**.
- Ne s'applique pas aux résumés de rapport, questions sur les visuels, création de pages ou requêtes DAX : ces capacités utilisent le modèle complet.
- Les relations restent respectées : un champ hors schéma mais lié peut encore apparaître dans une réponse via une relation.
- Les champs masqués dans le modèle sont exclus du schéma IA initial, mais tous les champs apparaissent dans le volet de sélection.
- Après chaque modification, fermer et rouvrir le volet Copilot pour tester.

## Sources

- [Prepare your data for AI — AI data schemas](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-data-schema)
- [FAQ — exemple de désambiguïsation par le schéma IA](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
