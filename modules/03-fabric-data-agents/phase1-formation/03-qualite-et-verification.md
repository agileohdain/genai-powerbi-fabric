# Fiche 03 — Qualité des réponses : vérifier, itérer, connaître les limites

## Objectifs

- Comprendre **d'où vient la qualité** d'un agent sur un modèle sémantique (la préparation du module 01, pas les exemples)
- **Vérifier chaque réponse** : requête générée, résultats, croisement avec une référence
- Itérer par un **processus de test structuré** (brouillon vs publié)
- Connaître les limites produit qui expliquent une réponse « fausse » avant de corriger l'agent

## D'où vient la qualité ?

Pour une source **modèle sémantique**, l'agent génère du DAX à partir des métadonnées. Sans exemples possibles (fiche 02), la qualité dépend directement de :

1. **Le schéma IA** (module 01, fiche 02) : tables et colonnes visibles nommées clairement, colonnes techniques masquées
2. **Les descriptions** : de chaque mesure, chaque colonne métier — elles guident le choix du DAX
3. **Les instructions IA du modèle** (Prep data for AI, module 01 fiche 03) : définitions métier, conventions (« exporter les annulées »…)
4. **Les instructions de l'agent** (fiche 02) : routage et vocabulaire complémentaires

> Un modèle v1 « mal préparé » (noms obscurs, mesures sans description, colonnes de dates parasites) donnera un agent faible ; un modèle v2 bien préparé donne une base saine. La démo compare les deux sur la même question.

## Vérifier une réponse

Routine en trois temps, dans l'expérience directe :

1. **Lire la requête générée** : la réponse affiche la requête (DAX, SQL, KQL) produite pour la question. Vérifier : la mesure utilisée, les filtres, la table de dates
2. **Croiser avec une référence** : comparer le montant à un visuel du rapport AltiSport existant, à Q&A, ou à la recette du module 02 (question déjà validée)
3. **Re-questionner si douteux** : reformuler en précisant la mesure attendue (`using the Total Sales measure`), indiquer la période

Réflexes : si la réponse cite un montant mais que la requête filtre mal (ex. annulées incluses), c'est un problème **d'instruction ou de modèle** à corriger — pas un prompt à tordre.

## Itérer : le processus de test

| Étape | Action |
|---|---|
| 1. Jeu de questions de référence | 10-15 questions réelles (EN), avec valeurs attendues validées par le métier ou un visuel |
| 2. Test brouillon | Exécuter le jeu sur le brouillon, noter conformité par question |
| 3. Correction | Ajuster les instructions de l'agent (routage, définitions) ou, si la cause est le modèle, remonter au [module 01](../../01-preparation-copilot-ready/) |
| 4. Re-test | Rejouer les questions non conformes ; comparer brouillon vs publié (bascule publiable) pour valider l'amélioration |
| 5. Publier | Figer la version (fiche 04) — et garder le jeu de questions comme **recette** rejouable |

## Limites produit à connaître (sources d'« erreurs » légitimes)

| Limite | Effet observable | Réaction attendue |
|---|---|---|
| **25 lignes × 25 colonnes** max par réponse | « Donne toutes les ventes » → tableau tronqué | Ne pas demander des extractions complètes ; affiner la question |
| **Anglais uniquement** | Question en français → réponse dégradée ou refusée | Reformuler en anglais |
| Historique non garanti | Relance qui semble « oublier » le contexte | Nouvelle session, resituer le contexte dans la question |
| Région de capacité différente source/agent | Requête en échec | Héberger agent et source dans la même région |
| LLM fixe | Impossible de tester un autre modèle | — |
| Données non structurées / fichiers lakehouse | Question sur un PDF/csv brut → sans réponse | Exposer via une table (ingestion) ou un autre canal |
| RLS/CLS applicables | Réponse vide ou partielle pour un utilisateur non autorisé | Vérifier les permissions de l'utilisateur, pas l'agent |
| Purview (DLP, access restriction) | Réponses bloquées ou tronquées | Vérifier les politiques, voir [docs/02-securite](../../../docs/02-securite/) |

## Limites et pièges

- Une réponse **fluide et confiante** peut être fausse en détail (montant, périmètre) : la vérification n'est pas optionnelle — même principe que [docs/03-limites-hallucinations-validation](../../../docs/03-limites-hallucinations-validation/)
- Un agent bien configuré sur un modèle non préparé reste fragile ; préparer **avant** de promettre des réponses fiables
- Ne pas « bricoler » l'agent pour compenser un défaut de modèle (ex. instructions contournées) : corriger la cause racine — l'arbitrage de chaque écart se fait côté modèle ou côté agent

## Sources

- [Fabric data agent creation (concept, GA)](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
- [Fabric data agent scenario — bout en bout](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-end-to-end-tutorial)
- [Module 01 — préparation Copilot-ready](../../01-preparation-copilot-ready/) (schéma IA, descriptions, instructions IA)