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
| Modèle **altisport-v2** publié | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Terrain de la démo : schéma IA puis réponse vérifiée |
| Pièges #7-8 (« Secteur » géo vs catégorie ; ventes vs marge) | [assets/README — table des pièges](../../../assets/README.md) | La matière des cas d'usage AltiSport |

## Déroulé de la démo (v2 publié, volet Copilot ouvert)

### 1. Avant toute préparation — le problème

Demander `Show me sales by sector`. Copilot ne choisit pas — il demande de lever l'ambiguïté (réponse réelle) :
> *« Your model has two different "Sector" fields: Client sector: DimClient[Secteur], Store sector: DimMagasin[Secteur]. Do you want to see sales by client sector or by store sector? »*

Sans préparation, chaque question « secteur » mobilise l'utilisateur : friction permanente (piège #7). Même famille de problème : une question sur « les ventes » peut renvoyer la marge (piège #8).

### 2. Schéma de données IA

1. Ruban Accueil > **Prep data for AI** (onglets grisés : activer Q&A) > **Simplify data schema**.
2. Sélectionner les champs que Copilot doit utiliser ; exclure technique, redondant, ambigu. Décocher `DimClient[Secteur]` (ambigu), puis `Total Marge` (redondant avec `Total Ventes`).
3. **Apply**, fermer et rouvrir le volet Copilot (même démarche dans le service, page du modèle sémantique).
4. Rejouer `Show me sales by sector` → réponse directe par `DimMagasin[Secteur]`, plus de demande de clarification. Rejouer une question sur « les ventes » → seule `Total Ventes` reste candidate (piège #8).

### 3. Réponses vérifiées

#### À quoi ça sert

Les phrases déclencheuses sont le **seul mécanisme d'activation** d'une réponse vérifiée : à chaque prompt, Copilot compare aux phrases enregistrées (match exact ou sémantique). Pas de match → la réponse vérifiée n'existe pas pour lui.

| | Avec phrases déclencheuses | Sans |
|---|---|---|
| `sales by sector` | Visuel **approuvé**, coche vérifié, résumé, lien *How Copilot arrived at this* | Réponse **générée** à la volée (correcte grâce au schéma IA, mais jamais garantie) |
| Reformulation (`revenue by region`) | Match sémantique → même visuel vérifié | Nouvelle génération, format et interprétation variables |
| Répétabilité | Toujours le même visuel, figé | Non déterministe : la réponse peut varier d'une session à l'autre |

D'où **5 à 7 phrases** représentatives par réponse (plafonds : 15 phrases, 500 caractères) : le match sémantique couvre synonymes et réordonnements, pas les changements de champ ou de mesure — puiser dans les formulations réelles des utilisateurs.

#### Préparer le visuel et ses filtres (avant la configuration)

- Créer le visuel : CA (`Total Ventes`) par `DimMagasin[Secteur]`.
- Les filtres ne se créent **pas** dans la boîte de dialogue : ils doivent déjà exister dans le rapport. Volet **Filtres** du visuel (les slicers ne sont pas supportés) : glisser `DimVendeur[Vendeur]`, `DimMagasin[Magasin]`, `DimMagasin[Ville]` — chacun laissé sur **Tous** (un filtre avec une valeur appliquée devient inéligible, il bascule dans *Applied to this visual*).

#### Configurer

1. Sélectionner le visuel (Desktop, ou service en mode édition) > **...** > **Set up a verified answer**.
2. Ajouter 5 à 7 phrases déclencheuses (manuellement ou via les suggestions Copilot) : `sales by sector`, `sales by region`, …
3. Dans **Available to users**, cocher uniquement **Vendeur** — jusqu'à 3 filtres ajustables par l'utilisateur en langage naturel.
4. **Apply** ; gestion via **Prep data for AI** > onglet **Verified answers** (éditer, supprimer).

#### Matching des phrases déclencheuses (déclencheur : *Snowboard sales by month*)

| Type | Comportement | Exemple |
|---|---|---|
| Exact | Caractère par caractère | « Snowboard sales by month » |
| Sémantique — supporté | Synonymes, réordonnancement, filtre inclus dans le prompt | « Snowboard sales for November » |
| Sémantique — non supporté | Ajout/retrait/changement de champ ou mesure | « Ski bib sales by month » |

### 4. Tester (négatif/positif)

Ouvrir le volet Copilot, skill picker > **Answer data question**. Après chaque modification : fermer et rouvrir le volet.

| Question | Résultat attendu |
|---|---|
| `sales by sector` | Réponse vérifiée : coche, résumé, lien *How Copilot arrived at this* |
| `sales by sector for vendor BERNARD` | Réponse vérifiée + filtre Vendeur appliqué (le prouver via *How Copilot arrived at this* — la phrase « matched on » ne montre jamais le filtre) |
| `sales by sector for store Chamonix` | Refus de la vue prédéfinie : le filtre Magasin n'est pas coché dans *Available to users* (réponse réelle ci-dessous) |
| Question sur un champ **hors** schéma IA | Copilot ne doit pas répondre |

> *« Je ne peux pas afficher les ventes par secteur filtrées sur un magasin précis comme Chamonix, car la vue prédéfinie pour "sales by sector" ne me permet de filtrer que par vendeur, pas par magasin. Je ne peux donc pas l'ajuster sans risque pour répondre exactement à ta question. Je peux toutefois t'aider à explorer les ventes par secteur ou par magasin autrement ; voici plusieurs options concrètes : »*

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
