# Doc 03 — Limites, hallucinations & validation humaine

Référence de talon consolidée : ce que les features IA de la formation **ne savent pas faire**, pourquoi elles produisent des erreurs, et comment la **validation humaine** doit se brancher. Les fiches des modules 01-06 renvoient ici pour le cadre ; les fiches détiennent les pièges spécifiques à chaque outil — cette doc ne les répète pas, elle les classe et les articule. La cible : une équipe qui traite **systématiquement** la sortie IA comme une proposition à vérifier, pas comme un résultat.

> Principe directeur : **la confiance d'une réponse ne mesure pas son exactitude.** Une réponse fluide, précise et bien formatée peut être fausse dans le détail (montant, périmètre, date). La vérification n'est pas une option de confort product : c'est le prix d'entrée de toute l'IA générative dans la BI.

## 1. Typologie des erreurs

Une erreur constatée sur une sortie IA relève en général d'une de **quatre classes** — et donc d'un **levier de correction différent** :

| Classe | Exemples | Cause racine | Où agir |
|---|---|---|---|
| **Données** | Données sales, doublons, hiérarchies incohérentes, champs ambigus | Qualité des données en amont | Ingestion / préparation des données (hors scopes des modules IA) |
| **Modèle** | Réponse juste en apparence mais sur le mauvais champ / périmètre / mesure ; agent qui rate le schéma | Schéma IA, descriptions, instructions IA absents ou faibles | [Module 01](../../modules/01-preparation-copilot-ready/) et son [atelier d'audit](../../modules/01-preparation-copilot-ready/phase2-ateliers/atelier-1-audit-modele.md) |
| **LLM** | Hallucination, calcul faux, DAX plausible mais incorrect, non-déterminisme | Comportement intrinsèque du modèle (probabiliste) | Validation humaine + prompt (pas une « correction de code » possible) |
| **Produit** | Troncature 25×25, langue non supportée, format incompatible (PBIR), Public Preview | Limites matérielles connues du produit | Connaître la limite, adapter l'usage (fiches « Limites et pièges » de chaque module) |

> **Litmus test** : « corriger par une instruction IA » n'est la bonne réponse que si la classe est **LLM** ou (parfois) **modèle**. Corriger une erreur de classe *données* ou *produit* par un prompt, c'est traiter le symptôme — la formation insiste sur l'arbitrage des écarts vers la bonne cause (voir la méthodologie du [module 03](../../modules/03-fabric-data-agents/phase1-formation/03-qualite-et-verification.md)).

## 2. Hallucinations — ce que ça donne par levier

| Levier | Forme typique d'hallucination | Symptôme observable |
|---|---|---|
| **Copilot Power BI** ([fiche 03](../../modules/02-copilot-powerbi/phase1-formation/03-questions-de-donnees.md), [fiche 05 dev](../../modules/02-copilot-powerbi/phase1-formation/05-copilot-developpeur.md)) | DAX ou réponse plausible mais faux (mauvaise mesure, mauvais champ, oubli de filtre) | La réponse « a l'air exacte » ; seul le croisement avec le modèle la dément |
| **Data Agent** ([fiche 03](../../modules/03-fabric-data-agents/phase1-formation/03-qualite-et-verification.md)) | Réponse fluide et confiante mais fausse en détail (montant, périmètre) | La requête générée (SQL/DAX/KQL) est lisible — c'est là qu'elle se vérifie |
| **MCP** ([fiche 02](../../modules/04-mcp-data-modelling/phase1-formation/02-audit-existant.md)) | DAX/modèle modifié de façon **inattendue** (logique, formatage) | Diff Git sur le dossier PBIP — le diff est la preuve de ce qui a changé |
| **Skills** ([fiche 01](../../modules/05-fabric-skills-authoring/phase1-formation/01-skills-et-agentes.md), [fiche 03](../../modules/05-fabric-skills-authoring/phase1-formation/03-refactoring-et-traduction.md)) | **JSON PBIR inventé de tête** (rôles, formatage, énumérations) | Validation CLI + rendu Desktop : écarts visibles immédiatement |

**Point commun** : dans **aucun** cas la sortie ne se vérifie « à l'œil » — chaque levier a son **mécanisme de preuve** (raisonnement/champs dans Copilot, requête générée pour l'agent, diff Git pour MCP/Skills, rendu Desktop pour Skills). C'est le socle de la section 4.

## 3. Non-déterminisme et cache

- **Même prompt + même modèle ≠ même résultat garanti** : la génération est probabiliste — c'est une caractéristique *intentionnelle*, pas un bug (voir [fiche questions de données](../../modules/02-copilot-powerbi/phase1-formation/03-questions-de-donnees.md)).
- **Cache 24 h** : dans Copilot, un même prompt sur un modèle inchangé peut être servi depuis un cache pendant 24 h — utile pour le coût ([doc 04](../04-consommation-cus-ia/)), piège pour la reproductibilité des démos. *Effacer la conversation* (clear chat) ou reformuler.
- **Conséquence opérationnelle** : les recettes d'ateliers (prompt → résultat) sont des **références**, pas des garanties de sortie identique — les ateliers des modules 02/03 l'intègrent.

## 4. Validation humaine — les patterns par levier

La validation repose sur **ce que l'outil expose**, jamais sur la seule apparence de la réponse :

| Levier | Que vérifier | Mécanisme de preuve |
|---|---|---|
| **Copilot Q&A** | Le **raisonnement** affiché : champs, mesures, filtres utilisés | Lire l'explication, rejouer la question avec d'autres formulations |
| **Copilot génération/DAX** | La logique produite contre le modèle (noms de mesures, contexte) | Croiser avec le schéma IA du modèle préparé (module 01) |
| **Data Agent** | La **requête générée** avant de croire la réponse : tables, colonnes, jointures, filtres | Lire le SQL/DAX/KQL ; itérer instructions/exemples si écart (fiche 03) |
| **MCP** | Ce que l'agent va modifier **avant** application ; ce qu'il a modifié **après** | Diff Git sur le dossier PBIP ; sauvegarde/commit préalable obligatoire |
| **Skills** | La conformité du travail produit (JSON, charte, libellés) | CLI de validation (`powerbi-report-author`), rendu Desktop (Bridge) |

**Règles communes à garder sous le coude :**

1. **Préparer avant de promettre** : un outil bien configuré sur un modèle non préparé reste fragile — le meilleur levier anti-hallucination est à la source : schéma IA, descriptions et instructions IA du [module 01](../../modules/01-preparation-copilot-ready/) (+ sa [fiche approved-for-copilot](../../modules/01-preparation-copilot-ready/phase1-formation/04-approved-for-copilot.md)).
2. **Sauvegarder avant d'écrire** : MCP et Skills écrivent des fichiers — le **commit Git avant session** est la sauvegarde (diff lisible en TMDL/JSON).
3. **Ne jamais laisser « deviner » la structure** : pour le JSON PBIR, l'agent consulte le CLI et les références, pas sa mémoire. S'il « devine », le rejeter.
4. **En cas d'écart, corriger la cause racine** : si un agent/une réponse échoue à cause du modèle, corriger le modèle (module 01), pas les instructions de contournement.
5. **Traçer la vérification dans le livrable** : les ateliers production (ex. [module 04](../../modules/04-mcp-data-modelling/phase2-ateliers/), [module 05](../../modules/05-fabric-skills-authoring/phase2-ateliers/)) intègrent une étape de revue humaine obligatoire avant publication — ne pas la sauter.

## 5. Alimenter l'amélioration

La validation n'est pas un contrôle ponctuel, c'est une **boucle** : chaque erreur constatée va alimenter la cause (section 1) → correction (données, modèle, prompt) → re-test. Les ateliers des modules traduisent cette boucle en recettes réutilisables (ex. [administration du modèle d'agent](../../modules/03-fabric-data-agents/phase2-ateliers/atelier-1-construction-recette.md)).

## Sources

- Fiches « Limites et pièges » et « Limites produit » des modules 01-06 (liens ci-dessus — elles détiennent le détail par outil)
- [Copilot for Power BI — ask questions about your data](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-ask-data-question)
- [Fabric data agent — quality & verification](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent) (limites produit, RLS, Purview)
- [Power BI Modeling MCP Server](https://github.com/microsoft/powerbi-modeling-mcp) et [Skills for Fabric](https://github.com/microsoft/skills-for-fabric) (garde-fous écriture, baselines Git)
