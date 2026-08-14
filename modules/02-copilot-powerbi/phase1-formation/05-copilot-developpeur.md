# Fiche 05 — Copilot développeur : DAX, descriptions, web modeling

## Objectifs

- Générer, expliquer et refactorer du DAX dans la vue Requête DAX (DAX Query View)
- Générer les descriptions de mesures, puis les traduire
- Découvrir la modélisation web assistée et connaître ses garde-fous

## Vue Requête DAX (DAX Query View)

Copilot y génère des **requêtes DAX** (pas des mesures isolées — demander une requête donne les meilleurs résultats). Une mesure définie dans une requête peut ensuite être **ajoutée au modèle** en un clic.

| Usage | Exemple de prompt (EN) | Traduction |
|---|---|---|
| Générer / explorer | `YTD sales by month in 2025` | Ventes cumulées (YTD) par mois en 2025 |
| Expliquer | `Explain this DAX query.` | Explique cette requête DAX. |
| Documenter | `Add comments to this query.` | Ajoute des commentaires à cette requête. |
| Refactorer | `Replace the variables with explicit filters and make it more readable.` | Remplace les variables par des filtres explicites et rends le tout plus lisible. |

**Pourquoi cette expérience est fiable** : développée avec les auteurs du langage DAX, elle n'utilise pas de fine-tuning mais des **métaprompts** avec exemples Microsoft, elle est intégrée (pas de copier-coller de code ou de schéma) et surtout le DAX produit passe dans un **parser** : si la requête est invalide (hallucination), elle est régénérée avant d'être affichée.

Spécificités d'ancrage : Copilot voit le **schéma complet** du modèle local (y compris champs cachés), les expressions DAX, les descriptions (tronquées à **200 caractères**), les formats, et des **statistiques** (min/max des colonnes). En **connexion live** à un modèle partagé : les expressions DAX et objets cachés/privés sont invisibles, et la requête est exécutée avant d'être renvoyée. Le bouton **Retry** vide le cache pour obtenir une nouvelle approche.

### Garde-fous (à énoncer en formation)

- **Toujours valider le DAX généré avant de l'ajouter au modèle** : Copilot ignore le contexte de filtre où la mesure sera utilisée — un code correct dans la requête peut produire des résultats faux dans un visuel
- Faiblesses connues : usage des **variables**, **calculation groups** (lister les items de calcul dans la description du groupe), **fonctions DAX récentes**
- En cas de doute : demander commentaires + explication, puis vérifier dans la documentation DAX ou la communauté

## Descriptions de mesures générées

Vue Modèle > propriétés d'une mesure > bouton de génération : Copilot rédige la description à partir de l'expression DAX, des propriétés et des synonymes. Revoir, corriger, garder l'essentiel dans les **200 premiers caractères** (seule la troncature alimente Copilot).

> Besoin d'une autre langue : générer en anglais (meilleurs résultats), puis traduire (par Copilot ou outillage type semantic link).

**Synergie** : les descriptions alimentent en retour la génération DAX, les questions de données (fiche 03) et la recherche Copilot (atelier 3) — c'est l'investissement le plus rentable du module 01.

## Modélisation web (service) — aperçu

Dans le service, ouvrir le modèle en vue Modèle > mode Édition : Copilot peut **analyser le modèle** (nommage incohérent, structure peu claire), proposer puis **appliquer** des changements (renommages, relations, mesures DAX). Les changements proposés s'appliquent comme toute modification manuelle : **tout relire avant d'accepter**. La qualité d'analyse dépend de la préparation du modèle (module 01).

## Limites et pièges

- L'expérience est conçue pour des **requêtes** : demander « crée une mesure » donne de moins bons résultats que « génère une requête qui… »
- Les commentaires dans les expressions DAX sont exclus de l'ancrage
- La modélisation web et le modèle peuvent diverger des réflexes Desktop : les différences entre les deux expériences se résorbent au fil des mises à jour mensuelles

## Sources

- [Use Copilot with semantic models](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-semantic-models) (sections DAX query view, measure descriptions, web modeling)
- [Write DAX queries with Copilot](https://learn.microsoft.com/en-us/dax/dax-copilot)
- [Use Copilot to create measure descriptions](https://learn.microsoft.com/en-us/power-bi/transform-model/desktop-measure-copilot-descriptions)
