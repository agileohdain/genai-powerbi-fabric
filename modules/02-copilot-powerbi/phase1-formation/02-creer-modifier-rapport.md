# Fiche 02 — Créer et modifier un rapport avec Copilot

## Objectifs

- Démarrer un rapport avec *Suggest content* ou un prompt de haut niveau
- Itérer : ajouter, modifier, supprimer des visuels par prompt, avec annuler/rétablir
- Connaître les limites du générateur pour promettre ce qu'il tient

## Concepts clés

Copilot génère des **pages complètes** à partir d'un prompt descriptif : il choisit les tables, champs, mesures et types de visuels. Le résultat est un **point de départ** — on raffine ensuite avec les outils d'édition habituels. La qualité dépend directement de la préparation du modèle ([module 01](../../01-preparation-copilot-ready/)) : champs visibles bien nommés, mesures documentées, Q&A activé.

Dans Desktop, le bouton Copilot est toujours visible dans le ruban ; au premier usage, il faut sélectionner un **workspace Copilot-compatible** (qui sert à la facturation, pas nécessairement celui de publication). Le workspace se change via `Options > Copilot (préversion)`.

## Pas-à-pas

1. Ouvrir le modèle AltiSport v2 (Desktop : rapport + workspace actif Copilot-compatible ; service : mode Édition)
2. Ruban **Accueil > Copilot** → le volet s'ouvre à droite
3. Choisir :
   - **Suggest content for this report** : Copilot évalue les données et propose un **plan de rapport** (pages suggérées), que l'on peut créer en un clic — utile pour partir de zéro
   - Ou saisir un prompt décrivant la page voulue
4. La page est générée ; poursuivre par prompts : ajouter / changer / supprimer un visuel
5. **Annuler/Rétablir** fonctionnent sur les actions de Copilot
6. Enregistrer ; en lecture, le volet ne montre plus les outils d'auteur (repasser en Édition)

## Prompts de référence (anglais + traduction)

| Objectif | Prompt (EN) | Traduction |
|---|---|---|
| Performance produits | `Create a page to analyze the sales amount, revenue, and profit margin of different products, categories, and subcategories over time and across regions.` | Crée une page pour analyser le montant des ventes, le chiffre d'affaires et la marge des produits, catégories et sous-catégories dans le temps et par région. |
| Segmentation clients | `Create a page to identify and compare the characteristics, behaviors, and preferences of different customer segments based on demographic, geographic, and transactional data.` | Crée une page pour identifier et comparer les caractéristiques, comportements et préférences des segments de clients (données démographiques, géographiques, transactionnelles). |
| Sommaire du rapport | `Make a table of contents for this report that contains a brief description of what each page is about.` | Fais un sommaire de ce rapport avec une brève description de chaque page. |

Structure d'un bon prompt de page : **verbe d'action + sujets d'analyse + dimensions + temporalité**. Rester de haut niveau : Copilot choisit les visuels.

## Limites et pièges

- **Q&A doit être activé** sur le modèle (Copilot s'appuie sur ce moteur) — vérifier avant la démo
- Non supporté : modèles en **streaming temps réel**, **connexion live Analysis Services**, modèles avec **mesures implicites désactivées**, **visuels personnalisés**
- Copilot ne fait pas de **mise en forme/style** : thème, couleurs et alignements se règlent à la main (le rapport peut alors être harmonisé avec `assets/theme-charte.json`)
- Modifier un visuel complexe peut perdre des détails ou du formatage
- Copilot peut appliquer des **filtres propres au visuel** qu'il génère : les inspecter (sélectionner le visuel > volet Filtres) avant de valider la page — même réflexe que la fiche 03
- Une page générée n'est pas « finie » : compter du temps de retravail UX ; le gain se fait sur le démarrage et les tâches répétitives

## Sources

- [Create and edit Power BI reports with Copilot](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-create-reports)
- [Write Copilot prompts for report pages](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prompts-report-pages)
- [Use Copilot in Power BI Desktop](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-power-bi-desktop)
