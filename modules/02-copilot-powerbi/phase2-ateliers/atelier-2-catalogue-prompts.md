# Atelier 2 — Catalogue de prompts

## Objectif

Capitaliser l'atelier 1 en un **catalogue de prompts éprouvés**, structuré par domaine métier, réutilisable par les auteurs de rapports comme par les utilisateurs métier.

## Pourquoi un catalogue

- Les prompts efficaces dépendent du **vocabulaire réel du modèle** (noms de mesures, de catégories) : ils sont spécifiques à chaque rapport et constituent un actif d'équipe
- Le catalogage fige les formulations qui ont passé la recette (atelier 1) et évite de réapprendre à chaque nouvel utilisateur
- C'est le support idéal de la formation des utilisateurs métier (atelier 3)

## Structure du catalogue

Un fichier (tableau ou wiki) avec une entrée par prompt :

| Champ | Exemple |
|---|---|
| Domaine | Ventes · Magasins · Clients · Produits |
| Profil cible | Auteur / Lecteur |
| Usage | Création de page · Question de données · Narratif · Résumé e-mail |
| Prompt (EN) | `What were the top 5 selling products in each region last quarter?` |
| Traduction / intention | Top 5 produits par région au dernier trimestre |
| Conditions de succès | Champs attendus (mesure, dimensions), filtre de dates, exclusion des commandes annulées |
| Référence de recette | Lien vers la ligne correspondante de la fiche de recette (atelier 1) |
| Notes | Pièges constatés, variante admise |

## Déroulé

1. Reprendre les questions de l'atelier 1 et les reformuler en **prompts canoniques** (anglais, verbe d'action, sujets + dimensions + temporalité, vocabulaire du modèle)
2. Compléter par domaine en balayant les usages : au moins un prompt par ligne du tableau « Usage »
3. Tester chaque entrée une dernière fois ; supprimer les prompts non conformes ou les marquer « à reprendre après correction modèle »
4. Dédupliquer et factoriser : un bon prompt générique vaut mieux que dix variantes
5. Valider avec les utilisateurs métier présents : le vocabulaire doit être le leur

## Livrable

Catalogue de prompts versionné (idéalement à côté du rapport, ex. dans le même espace de travail), propriété de l'équipe BI, mis à jour à chaque évolution significative du modèle.

## Points d'attention

- Le catalogue documente aussi **ce qu'il ne faut pas demander** : insights causaux, prévisions, comparaisons interdites par construction du modèle
- Chaque prompt du catalogue doit avoir passé la recette : un prompt « probablement bon » n'entre pas au catalogue
- Prévoir la traduction française des prompts : les utilisateurs pourront lire l'intention même s'ils saisissent la version anglaise
