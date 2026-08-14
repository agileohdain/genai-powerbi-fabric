# Fiche 03 — Réponses vérifiées

## Objectifs

- Garantir une réponse visuelle **validée par un humain** sur les questions fréquentes ou sensibles
- Assurer la cohérence : la même question posée dans n'importe quel rapport utilisant le modèle renvoie le même visuel approuvé
- Maîtriser les phrases déclencheuses et les filtres exposés aux utilisateurs

## Concepts clés

Une **réponse vérifiée** (verified answer) associe : un visuel, une ou plusieurs **phrases déclencheuses**, et des filtres optionnels. Quand un utilisateur saisit un prompt correspondant (exactement ou sémantiquement) à une phrase déclencheuse, Copilot retourne la réponse vérifiée au lieu de générer une nouvelle réponse.

Les réponses vérifiées sont stockées **dans le modèle sémantique** : elles fonctionnent dans tous les rapports qui utilisent le modèle. Dans l'interface de consommation, l'utilisateur voit un coche « vérifié », la phrase déclencheuse matched, un résumé textuel et le lien *How Copilot arrived at this*.

## Cas d'usage typiques

- **Ambiguïté de vocabulaire** : l'utilisateur demande « les ventes par secteur » ; Copilot comprend *secteur produit* alors que l'attendu est *région*. Une réponse vérifiée sur le visuel régional corrige durablement cette question.
- **KPI stratégique récurrent** : « Quel produit a eu les meilleures ventes la semaine dernière ? » — question posée chaque semaine, réponse normalisée et approuvée.
- **Diffusion large** : garantir que tous les rapports basés sur le modèle répondent de la même façon aux questions clés.

## Pas-à-pas

1. Sélectionner un visuel (Desktop, ou service en mode édition dans un espace Copilot-enabled avec droits d'auteur sur le modèle).
2. Menu **...** de l'en-tête du visuel > **Set up a verified answer**.
3. Ajouter des **phrases déclencheuses** : manuellement (+/Add) ou via les suggestions Copilot. Recommandé : **5 à 7 phrases** représentatives.
4. Ajouter si besoin des filtres (icône filtre) : jusqu'à **3 filtres** rendus ajustables par l'utilisateur en langage naturel (section *Available to users*). Les filtres hérités avec valeur figée (ex. Région = Nord) ne sont pas surchargés.
5. **Apply** : la réponse vérifiée est enregistrée sur le modèle.
6. Gérer les réponses vérifiées : **Prep data for AI** > onglet **Verified answers** (éditer, supprimer).

### Matching des phrases déclencheuses

| Type | Comportement | Exemple (déclencheur : *Snowboard sales by month*) |
|---|---|---|
| Exact | Correspondance caractère par caractère | « Snowboard sales by month » |
| Sémantique — supporté | Synonymes, réordonnancement, critère de filtre inclus dans le prompt | « Snowboard sales for November », « ventes snowboard pour Maui » |
| Sémantique — non supporté | Ajout/retrait/changement de champ ou de mesure | « Winter sports rates », « Ski bib sales by month » |

## Limites et pièges

- Chiffres clés : **250** réponses vérifiées par modèle ; **15** phrases déclencheuses par réponse (500 caractères max) ; **10** permutations de filtres.
- Visuels non supportés : zone de texte, Data Q&A, visuels IA (influenceurs clés, arbre de décomposition, Narratif avec Copilot, Smart narratives, prévisions R/Python), visuels personnalisés.
- Ne fonctionnent pas si des champs utilisés sont **masqués** dans le modèle, ni avec des **mesures de rapport**.
- Les segments (slicers) ne sont pas reportés ; les thèmes de rapport ne sont pas appliqués.
- **RLS/OLS non garantis** pendant l'aperçu : ne pas considérer les réponses vérifiées comme une fonction de sécurité (voir [docs/02-securite](../../../docs/02-securite/)).
- Le visuel du rapport et la réponse vérifiée ne sont pas synchronisés : modifier/supprimer le visuel n'affecte pas la réponse vérifiée ; pour la changer, passer par la boîte de dialogue de gestion.
- Après publication, compter ~15 minutes de délai ; en cas de blocage, faire une petite modification dans la boîte de dialogue du service et enregistrer.
- Intégration Git non supportée pour les réponses vérifiées.

## Sources

- [Prepare your data for AI — Verified answers](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-verified-answers)
- [FAQ — quand utiliser les réponses vérifiées](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-prepare-data-ai-faq)
