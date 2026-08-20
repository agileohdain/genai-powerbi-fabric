# Fiche 02 — Schéma de données IA & réponses vérifiées

## Objectifs

- Restreindre le périmètre de champs que Copilot utilise pour répondre aux questions de données (**schéma IA**)
- Garantir une réponse visuelle **validée par un humain** sur les questions fréquentes ou sensibles (**réponses vérifiées**)
- Tester le résultat avec la méthode négatif/positif

## Concepts clés

- **Schéma de données IA** : sous-ensemble du schéma que Copilot priorise quand il génère ses réponses. Un schéma resserré réduit l'ambiguïté : Copilot utilise les bons champs sans demander de clarification.
- **Réponses vérifiées** : association d'un visuel, de **phrases déclencheuses** et de filtres optionnels, stockée **dans le modèle sémantique** — valable dans tous les rapports qui l'utilisent. Côté consommateur : coche « vérifié », phrase déclencheuse matched, résumé et lien *How Copilot arrived at this*.

> Ces deux fonctionnalités ne couvrent que certaines capacités Copilot : voir la matrice capacité × fonctionnalité dans le [README de la phase](README.md).

## Cas d'usage typiques

| Problème | Solution |
|---|---|
| « Les ventes » peut renvoyer la marge (`Total GPM`) au lieu de `Total Sales` | Retirer le champ ambigu du schéma IA |
| « Ventes par secteur » : deux champs `Secteur` (client, magasin) → Copilot demande de clarifier à chaque question | Retirer le champ ambigu du schéma IA ; réponse vérifiée pour figer l'interprétation |
| Question stratégique posée chaque semaine, réponse à normaliser | Réponse vérifiée (visuel approuvé + phrases déclencheuses) |
| Tables techniques ou de travail inutiles aux utilisateurs | Les exclure du schéma IA |

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** publié | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Terrain des deux pas-à-pas : schéma IA puis réponse vérifiée |
| Pièges #7-8 (« Secteur » géo vs catégorie ; ventes vs marge) | [assets/README — table des pièges](../../../assets/README.md) | La matière des cas d'usage AltiSport |

**Déroulé de la démo (v2 publié, volet Copilot ouvert)** :

1. **Avant toute préparation** : demander `Show me sales by sector`. Copilot ne choisit pas — il demande de lever l'ambiguïté (réponse réelle) :
   > *« Your model has two different "Sector" fields: Client sector: DimClient[Secteur], Store sector: DimMagasin[Secteur]. Do you want to see sales by client sector or by store sector? »*

   Sans préparation, chaque question « secteur » mobilise l'utilisateur : friction permanente (piège #7).
2. **Prep data for AI** (onglets grisés : activer Q&A) > **Simplify data schema** : décocher `DimClient[Secteur]`, **Apply**, fermer/rouvrir le volet Copilot. Rejouer la même question : réponse directe par `DimMagasin[Secteur]`, plus de demande de clarification.
3. Toujours dans le schéma IA : retirer `Total Marge`, **Apply**, fermer/rouvrir. Rejouer une question sur « les ventes » : seule `Total Ventes` reste candidate (piège #8).
4. Dérouler le pas-à-pas 2 : visuel CA par `DimMagasin[Secteur]` → *Set up a verified answer*, phrases déclencheuses `sales by sector` / `sales by region` — la réponse vérifiée fige la bonne interprétation.
5. Conclure avec le test négatif/positif ci-dessous sur un champ retiré du schéma.

## Pas-à-pas 1 — Schéma de données IA

1. Ruban Accueil > **Prep data for AI** (onglets grisés : activer Q&A) > **Simplify data schema**.
2. Sélectionner les champs que Copilot doit utiliser ; exclure technique, redondant, ambigu.
3. **Apply** (même démarche dans le service, page du modèle sémantique).

## Pas-à-pas 2 — Réponses vérifiées (démo)

1. Sélectionner le visuel correct (Desktop, ou service en mode édition) > **...** > **Set up a verified answer**.
2. Ajouter **5 à 7 phrases déclencheuses** (manuellement ou via les suggestions Copilot — puiser dans les formulations réelles des utilisateurs).
3. Option : jusqu'à **3 filtres** ajustables par l'utilisateur en langage naturel.
4. **Apply** ; gestion via **Prep data for AI** > onglet **Verified answers** (éditer, supprimer).

**Matching des phrases déclencheuses** (déclencheur : *Snowboard sales by month*) :

| Type | Comportement | Exemple |
|---|---|---|
| Exact | Caractère par caractère | « Snowboard sales by month » |
| Sémantique — supporté | Synonymes, réordonnancement, filtre inclus dans le prompt | « Snowboard sales for November » |
| Sémantique — non supporté | Ajout/retrait/changement de champ ou mesure | « Ski bib sales by month » |

## Tester (méthode négatif/positif)

1. Ouvrir le volet Copilot, skill picker > **Answer data question**.
2. Question sur un champ **hors** schéma IA : Copilot ne doit pas répondre.
3. Question sur un champ **dans** le schéma IA (et reformulations des phrases déclencheuses) : Copilot doit répondre.
4. Après chaque modification : fermer et rouvrir le volet Copilot.

## Limites et pièges

- Chiffres clés : **250** réponses vérifiées par modèle ; **15** phrases par réponse (500 caractères) ; **10** permutations de filtres.
- Le schéma IA ne s'applique **qu'aux questions sur le modèle** (pas résumés, création de pages, DAX) ; les consommateurs ne le voient pas et ne peuvent pas le désactiver ; un champ lié par relation peut réapparaître dans une réponse.
- Visuels non supportés en réponse vérifiée : zone de texte, Data Q&A, visuels IA (influenceurs, Narratif avec Copilot, Smart narratives, prévisions R/Python), visuels personnalisés ; non fonctionnel si champs masqués ou **mesures de rapport**.
- Le visuel du rapport et la réponse vérifiée ne sont **pas synchronisés** : la modifier passe par la boîte de dialogue de gestion.
- Après publication : ~15 min de délai ; intégration Git non supportée pour les réponses vérifiées.
- **RLS/OLS non garantis** pendant l'aperçu : ne pas considérer les réponses vérifiées comme une fonction de sécurité (voir [docs/02-securite](../../../docs/02-securite/)).

## Sources

- [Prepare your data for AI — AI data schemas](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-data-schema)
- [Prepare your data for AI — Verified answers](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-verified-answers)
- [FAQ — exemple de désambiguïsation, quand utiliser les réponses vérifiées](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
