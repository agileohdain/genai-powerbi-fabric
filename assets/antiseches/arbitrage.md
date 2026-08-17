# Antisèche — Quel levier IA pour quel besoin ?

> 1 page à imprimer. Condensé de la [doc 05 — matrice d'arbitrage globale](../../docs/05-matrice-arbitrage-globale/), qui reste la référence complète.

## Les 4 leviers en un coup d'œil

| | Copilot Power BI | Data Agent | MCP | Skills |
|---|---|---|---|---|
| **Nature** | Chat intégré à Power BI | Agent no-code construit et partagé | Code agentique (VS Code) sur le **modèle** | Code agentique (CLI/VS Code) sur le **rapport** |
| **Cible** | Créateurs + consommateurs | Utilisateurs métier | Développeurs BI | Développeurs BI |
| **CUs (génération)** | ✅ tokens | ✅ tokens + requêtes | **0** | **0** |
| **Langue** | Anglais recommandé | Anglais **uniquement** | Anglais recommandé | Anglais recommandé |

## Arbre de décision express

1. **Interroger les données en conversationnel ?**
   - Contexte = un rapport Power BI → **Copilot** (Q&A)
   - Multi-sources, public large, hors Power BI → **Data Agent**
2. **Créer un rapport / narratif / résumé** → **Copilot** (auteur BI, dans Power BI)
3. **Auditer, corriger, documenter le modèle sémantique** → **MCP**
4. **Charte stricte, refactoring, traduction de masse du rapport** → **Skills**

> Règle pratique : conversationnel **individuel** → Copilot ; conversationnel **partagé/multi-sources** → Data Agent ; écriture structurée **sur le modèle** → MCP ; écriture structurée **sur le rapport** → Skills. À départage égal : privilégier **zéro CU** là où l'équipe a la compétence dev.

## Complémentarités

- **MCP + Skills** : le modèle d'abord (04), le rapport ensuite (05) — le duo dev/BI
- **Copilot / Data Agent** : l'usage quotidien ; **MCP / Skills** : la fabrication et la maintenance

## Limites à garder en tête

| Levier | Limite clé |
|---|---|
| Copilot | Non déterministe (cache 24 h) ; ne connaît pas le contexte métier |
| Data Agent | Read-only ; réponses 25×25 ; anglais uniquement |
| MCP | Ne touche que le modèle ; métadonnées transitées au LLM |
| Skills | PBIR uniquement ; ne touche pas au modèle |

**Toujours** : hallucination possible sur tous les leviers → validation humaine avant publication ([doc 03](../../docs/03-limites-hallucinations-validation/)).
