# Fiche 03 — Instructions IA (version courte)

## Objectifs

- Transmettre à Copilot le **contexte métier** qu'il ne peut pas deviner : vocabulaire interne, périodes métier, règles d'analyse
- Repartir avec un template prêt à remplir avec le vocabulaire du client

> Les instructions IA se configurent **au niveau du modèle** (l'auteur guide le comportement de Copilot). Pour l'art de poser les questions en tant qu'utilisateur final, voir le module 02 (Copilot Power BI).

## Concepts clés

Les **instructions IA** sont du texte libre (max 10 000 caractères) enregistré sur le modèle sémantique. Copilot les interprète pour mieux comprendre les questions des utilisateurs. Elles sont invisibles et non désactivables par les consommateurs. C'est la seule fonctionnalité qui traduit le **jargon métier** propre à chaque entreprise.

## Les 3 patterns à fort impact

### Pattern 1 — Mapping 1:1 (terme = champ)

Quand un terme interne désigne toujours le même élément du modèle.

```
« closers » désigne les vendeurs : utiliser la table DimVendeur.
« comptoir » désigne le canal Magasin (colonne Canal de la table FactVentes).
```

### Pattern 2 — Définition conditionnelle (terme = règle)

Quand un terme implique une condition ou un regroupement absent du modèle.

```
« Champion » = vendeur atteignant 100 % ou plus de sa cible mensuelle.
```

### Pattern 3 — Périodes métier (terme = plage de dates)

```
« Saison blanche » = décembre à février, à cheval sur deux années.
« Hors-saison » = mars à mai et septembre à novembre.
```

Bonus — règles d'orientation d'analyse :

```
Pour toute question sur les ventes, utiliser la mesure Total Ventes (commandes annulées exclues).
Toujours analyser le chiffre d'affaires par mois.
```

## Bonnes pratiques express

- Être explicite : supposer que Copilot ne connaît rien au métier
- Grouper les instructions par thème (terminologie / périodes / règles) avec des titres
- Privilégier peu d'instructions ciblées plutôt que beaucoup d'instructions larges
- Tester, itérer : l'ordre et la formulation influencent les résultats

## Template à trous (rempli en atelier, phase 2)

```markdown
## Terminologie métier (mapping 1:1)
- « ______________ » désigne la mesure/colonne « ______________ » (table ______________)
- « ______________ » désigne la mesure/colonne « ______________ » (table ______________)

## Définitions conditionnelles
- « ______________ » signifie : ______________ (seuil, catégorie, statut…)
- Exemple : « Grand compte » = client dont le CA annuel dépasse ______________

## Périodes métier
- « ______________ » = de ______________ à ______________

## Règles d'analyse
- Pour toute question sur ______________ , utiliser la table ______________ comme source principale
- Toujours analyser ______________ sur une base ______________ (jour / semaine / mois / trimestre)
```

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** publié | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Support de la démo : saisir puis tester les instructions IA |
| **vocabulaire-metier.md** | [assets/vocabulaire-metier.md](../../../assets/vocabulaire-metier.md) | Source des définitions : saisons, « Champion », « closers », « comptoir » (pièges #9-10) — contient un bloc d'instructions **prêt à coller** pour v2 |

**Déroulé de la démo (v2 publié)** :

1. Ouvrir une **nouvelle conversation** (l'historique fait partie de l'ancrage et peut conserver les filtres d'une question précédente), puis demander `Show me the sales of the closers for the white season 2025-2026` **avant** instructions : Copilot ne connaît ni « closers » ni « white season » — réponse approximative ou refus.
2. *Prep data for AI* > *Add AI instructions* : coller le bloc AltiSport (section « Instructions IA prêtes à coller » du vocabulaire-metier.md), Apply, fermer/rouvrir le volet.
3. Rejouer la même question : `DimVendeur` est ciblée sans filtre, la période décembre 2025-février 2026 est appliquée. La variante française `Montre-moi les ventes des closers pour la saison blanche 2025-2026` donne le même résultat : instructions IA, questions et réponses fonctionnent en français comme en anglais (testé avec le bloc d'instructions dans la même langue que la question). Montrer aussi « Champion » (définition conditionnelle sur *Atteinte Cible*).
4. Enchaîner sur le template à trous ci-dessous — celui que les participants rempliront avec le vocabulaire de leur entreprise en atelier.

## Pas-à-pas

1. **Prep data for AI** > onglet **Add AI instructions**.
2. Rédiger les instructions (utiliser le template ci-dessus).
3. **Apply**, puis fermer et rouvrir le volet Copilot pour tester.
4. Skill picker > **Answer questions about the data**, poser une question utilisant un terme défini, vérifier la réponse, itérer.

## Limites et pièges

- Limite : **10 000 caractères** ; interprétation par le LLM sans garantie de suivi exact
- Enregistrées au niveau du modèle (pas de variantes par rapport ni par persona : un terme = une seule définition)
- Configurées par les auteurs (écriture sur le modèle) ; bénéficient à **tous** ceux qui peuvent interroger le modèle, Viewers inclus — pas de restriction d'usage par modèle ni par workspace ([docs/02-securite](../../../docs/02-securite/))
- Pas d'import de fichier dans Desktop : copier/coller le texte
- Après chaque édition : fermer et rouvrir le volet Copilot
- Avant chaque test : ouvrir une **nouvelle conversation** (clear chat) — l'historique fait partie de l'ancrage et peut conserver les filtres d'une question précédente (symptôme typique : un filtre « Champion » qui s'invite sur une question « closers »)
- Peuvent ne pas être respectées lors de la création de pages : tester avec le skill picker sur **Create new report pages** seul

## Sources

- [Prepare your data for AI — AI instructions](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-instructions)
- [FAQ — quelle fonctionnalité pour quel terme](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
