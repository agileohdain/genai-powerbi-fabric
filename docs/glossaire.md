# Glossaire de la formation

Vocabulaire IA & BI utilisé dans les modules et les docs — classé alphabétiquement. Les renvois pointent vers la référence la plus complète du dépôt.

| Terme | Définition |
|---|---|
| **AI instructions (instructions IA)** | Instructions stockées dans le modèle sémantique pour guider les réponses de l'IA (vocabulaire, règles métier). → [module 01](../modules/01-preparation-copilot-ready/) |
| **AI schema (schéma de données IA)** | Sélection, dans *Prep data for AI*, des champs que l'IA doit privilégier. → [module 01](../modules/01-preparation-copilot-ready/) |
| **Approved for Copilot** | Validation finale d'un modèle testé, signalant qu'il est prêt pour l'IA. → [module 01](../modules/01-preparation-copilot-ready/) |
| **Bursting** | Capacité d'une capacité Fabric à absorber temporairement plus que ses CUs nominales. → [module 06](../modules/06-gouvernance-cus/) |
| **CLS** | Column-Level Security : sécurité au niveau des colonnes d'une table. → [docs/02](02-securite/) |
| **CU (Capacity Unit)** | Unité de consommation des capacités Fabric ; toutes les opérations s'y facturent. → [docs/04](04-consommation-cus-ia/) |
| **Data agent** | Agent conversationnel no-code de Fabric, construit puis publié, qui répond en langage naturel sur OneLake et modèles sémantiques. → [module 03](../modules/03-fabric-data-agents/) |
| **F SKU / P SKU** | Références de capacité Fabric (F2+… / P1+…) : taille et CUs alloués. → [docs/01](01-prerequis-admin/) |
| **Fabric Copilot capacity (FCC)** | Groupement de facturation centralisant la consommation Copilot (dont Pro/PPU/Desktop). → [module 06](../modules/06-gouvernance-cus/) |
| **Hallucination** | Réponse plausible mais fausse produite par un modèle d'IA ; se combat par la vérification humaine. → [docs/03](03-limites-hallucinations-validation/) |
| **LLM** | Large Language Model : modèle de langage derrière les réponses génératives. → [docs/03](03-limites-hallucinations-validation/) |
| **MCP (Model Context Protocol)** | Protocole qui connecte un agent IA à des outils ; ici, le Power BI Modeling MCP Server pilote le modèle sémantique depuis VS Code. → [module 04](../modules/04-mcp-data-modelling/) |
| **Metrics App** | Application Microsoft Fabric Capacity Metrics : suivi de la consommation et du throttling. → [module 06](../modules/06-gouvernance-cus/) |
| **Non-déterminisme** | Un même prompt peut produire des réponses différentes ; le cache (24 h) peut aussi figer une réponse. → [module 02](../modules/02-copilot-powerbi/) |
| **OLS** | Object-Level Security : sécurité au niveau des objets (tables) du modèle. → [docs/02](02-securite/) |
| **PBIP** | Power BI Project : format de projet fichier (rapport + modèle), requis pour MCP et Skills. → [module 04](../modules/04-mcp-data-modelling/) |
| **PBIR** | Format de définition JSON des rapports (évolué), seul supporté par les Skills — pas PBIR-Legacy. → [module 05](../modules/05-fabric-skills-authoring/) |
| **Prep data for AI** | Fonctionnalité Power BI regroupant schéma IA, réponses vérifiées et instructions IA. → [module 01](../modules/01-preparation-copilot-ready/) |
| **Prompt caching** | Réutilisation des tokens d'entrée déjà traités, réduisant le coût des requêtes répétées. → [docs/04](04-consommation-cus-ia/) |
| **Q&A** | Moteur de questions en langage naturel sur lequel Copilot s'appuie pour construire ses requêtes. → [module 02](../modules/02-copilot-powerbi/) |
| **Read-only (agent)** | Un data agent ne génère que des requêtes de lecture — jamais d'écriture. → [module 03](../modules/03-fabric-data-agents/) |
| **RLS** | Row-Level Security : sécurité au niveau des lignes ; s'applique aux réponses IA de l'appelant ( Viewer pour l'évaluation). → [docs/02](02-securite/) |
| **Skill (for Fabric)** | Paquet d'instructions chargé à la demande par Copilot CLI/VS Code pour travailler la couche rapport. → [module 05](../modules/05-fabric-skills-authoring/) |
| **Smoothing** | Lissage de la consommation sur 24 h : un pic momentané n'est pas immédiatement un problème. → [module 06](../modules/06-gouvernance-cus/) |
| **Throttling** | Limitation progressive d'une capacité saturée : 4 paliers (protection 10 min → délai 20 s → rejet interactif → rejet total). → [module 06](../modules/06-gouvernance-cus/) |
| **Timepoint** | Instantané de consommation à un instant T, unité de mesure des CUs. → [module 06](../modules/06-gouvernance-cus/) |
| **TMDL** | Tabular Model Definition Language : format texte du modèle sémantique dans un PBIP — celui que le diff Git montre. → [module 04](../modules/04-mcp-data-modelling/) |
| **Token** | Unité de texte (entrée/sortie) facturée pour la génération IA. → [docs/04](04-consommation-cus-ia/) |
| **Verified answer (réponse vérifiée)** | Réponse approuvée par l'auteur, servie telle quelle par l'IA ; ne pas exposer sur données sensibles (RLS/OLS). → [module 01](../modules/01-preparation-copilot-ready/) · [docs/02](02-securite/) |
