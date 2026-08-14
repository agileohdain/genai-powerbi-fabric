# Fiche 04 — Instructions IA (version courte)

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
« closers » désigne les vendeurs : utiliser la table Sellers.
« ABCD » désigne le champ Total Invoice (table Revenue).
```

### Pattern 2 — Définition conditionnelle (terme = règle)

Quand un terme implique une condition ou un regroupement absent du modèle.

```
« High performer » = vendeur atteignant 100 % ou plus de sa cible mensuelle.
```

### Pattern 3 — Périodes métier (terme = plage de dates)

```
« Saison haute » = juin à août.
« Saison morte » = janvier à mai.
```

Bonus — règles d'orientation d'analyse :

```
Pour toute question sur les ventes, utiliser la table sales_fact comme source principale.
Toujours analyser le chiffre d'affaires par trimestre.
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

## Pas-à-pas

1. **Prep data for AI** > onglet **Add AI instructions**.
2. Rédiger les instructions (utiliser le template ci-dessus).
3. **Apply**, puis fermer et rouvrir le volet Copilot pour tester.
4. Skill picker > **Answer data question**, poser une question utilisant un terme défini, vérifier la réponse, itérer.

## Limites et pièges

- Limite : **10 000 caractères** ; interprétation par le LLM sans garantie de suivi exact
- Enregistrées au niveau du modèle (pas de variantes par rapport ni par persona : un terme = une seule définition)
- Pas d'import de fichier dans Desktop : copier/coller le texte
- Après chaque édition : fermer et rouvrir le volet Copilot
- Peuvent ne pas être respectées lors de la création de pages : tester avec le skill picker sur **Create new report pages** seul

## Sources

- [Prepare your data for AI — AI instructions](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-instructions)
- [FAQ — quelle fonctionnalité pour quel terme](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
