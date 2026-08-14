# Atelier 2 — Mise en œuvre sur le modèle réel

## Objectif

Appliquer la démarche officielle (fiche 06) sur le modèle pilote du client : schéma IA, réponses vérifiées, instructions IA. L'équipe repart avec un **modèle configuré avec son propre vocabulaire**, pas un exemple générique.

## Prérequis

- Atelier 1 réalisé ; points Haute priorité de la grille traités
- Liste des questions métier les plus fréquentes (fournie par le client)
- Q&A activé sur le modèle ; droits d'auteur ; espace Copilot-enabled

## Déroulé

### Étape 1 — Schéma de données IA (45 min)

1. À partir de la grille d'audit : identifier les champs réellement utiles aux questions des utilisateurs.
2. **Prep data for AI** > *Simplify data schema* : conserver ces champs, exclure le reste (technique, redondant, ambigu).
3. Test négatif/positif (fiche 02) sur 2-3 questions.

### Étape 2 — Réponses vérifiées (1 h)

1. Choisir 2-3 questions fréquentes ou sensibles de la liste client (ex. : la question d'ambiguïté connue du modèle).
2. Créer le visuel correct pour chacune dans un rapport.
3. **...** > *Set up a verified answer* : 5-7 phrases déclencheuses (puiser dans les formulations réelles des utilisateurs), filtres utilisateur si utile.
4. Tester : reformulations sémantiques des phrases déclencheuses.

### Étape 3 — Instructions IA (1 h)

1. Remplir le [template à trous](../phase1-formation/04-instructions-ia.md) en binôme modélisateur + métier :
   - terminologie interne (mapping 1:1)
   - définitions conditionnelles
   - périodes métier
   - règles d'analyse (table source principale, granularité par défaut)
2. Copier dans **Prep data for AI** > *Add AI instructions*, appliquer.
3. Fermer/rouvrir le volet Copilot, tester chaque terme défini, itérer.

### Étape 4 — Descriptions (30 min)

Compléter les descriptions des objets les plus utilisés (essentiel dans les 200 premiers caractères), en priorité sur les mesures et calculation groups.

## Livrables de l'atelier

- Modèle pilote configuré (schéma IA + réponses vérifiées + instructions)
- Template d'instructions rempli avec le vocabulaire du client (réutilisable sur d'autres modèles)
- Journal des tests effectués (question > résultat > correction)

## Points d'attention

- Itérer par petites touches : modifier, tester, mesurer — pas de grande rédaction d'instructions d'un coup
- Si le modèle est partagé par plusieurs populations : un terme = une seule définition (limite actuelle), arbitrer avec le métier
- Ne pas mettre en production : la recette se fait en atelier 3
