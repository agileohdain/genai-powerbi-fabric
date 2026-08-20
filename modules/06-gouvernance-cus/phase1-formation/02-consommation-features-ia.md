# Fiche 02 — Consommation des features IA : chiffrer ce que coûtent Copilot et les Data Agents

> Fiche de chiffrage : les tarifs (tokens : 100/10/400), l'ordre de grandeur par capacité, et surtout **qui coûte et qui ne coûte pas** — les modules 04 et 05 (MCP, Skills) tournant en local, leur génération est **0 CU**. Objectif : savoir mettre un **coût d'ordre de grandeur** sur un scénario d'adoption avant de massifier.

## Objectifs

- Connaître les **tarifs** Copilot in Fabric et AI Query (input/cache/output), et le **prompt caching** automatique
- **Chiffrer** une requête et un scénario (utilisateurs × requêtes/jour), comparer à la capacité disponible
- Identifier dans la Metrics App les opérations **Copilot in Fabric** et **AI Query** et comprendre ce que fait le Data Agent en plus (requêtes générées facturées au moteur)
- Retenir que **MCP et Skills = 0 CU** à la génération — argument d'arbitrage (fiche 03, docs/05)
- Appliquer la démarche **pilote → mesurer → extrapoler → scaler** (recommandation Microsoft)

## Concepts

### Les tarifs (août 2026 — vérifier dans [docs/04](../../../docs/04-consommation-cus-ia/))

| Opération (Metrics App) | Entrée | Entrée en cache | Sortie |
|---|---|---|---|
| **Copilot in Fabric** | 100 CU·s / 1 k tokens | 10 CU·s / 1 k tokens | 400 CU·s / 1 k tokens |
| **AI Query** (Data Agents) | 100 CU·s / 1 k tokens | 10 CU·s / 1 k tokens | 400 CU·s / 1 k tokens |

- ≈ 1 000 tokens ≈ 750 mots.
- Le **prompt caching** (10 CU·s) est **automatique** : la portion de prompt partagée avec une requête récente (instructions système, schéma, historique) est servie du cache à taux réduit.
- **Exemple officiel** : 2 000 in + 500 out → (2 000×100 + 500×400) / 1 000 = **400 CU·s = 6,67 CU·min**.

### Le vrai coût d'une requête Data Agent

Pour Copilot comme pour les Agents, les tokens d'entrée ne sont pas seulement la question de l'utilisateur : le context (instructions du Data Agent, instructions de sources, exemples de requêtes, historique de conversation) **grossit l'entrée**. Un Data Agent verbose/riche en instructions coûte plus par requête.

En plus des tokens, un Data Agent peut **exécuter des requêtes générées** : leur exécution est **facturée au moteur** (ex. requête générée exécutée dans un Data Warehouse → opération **SQL Query**). Le chiffrage d'un scénario Data Agent doit inclure les deux lignes.

### Ordre de grandeur — combien tient une capacité

- **CU·h/jour** = SKU × 24 (F64 → 1 536).
- Requête type (exemple officiel) = 6,67 CU·min = **0,11 CU·h**.
- **F64 → > 13 824 requêtes IA/jour** avant épuisement (ordre de grandeur ; la capacité sert aussi à tout le reste du contenu).

**Back-of-the-envelope d'un scénario** (fiche 03 et atelier 1 le mettent en forme) :

```
Coût par jour ≈ (nb_users × nb_req/jour) × CU·h par requête
Part de capacité ≈ coût par jour ÷ (SKU × 24)
```

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| **Metrics App** sur la capacité de démo | [setup/04](../../../setup/04-capacite-gouvernance.md) | Isoler Copilot in Fabric / AI Query (pas-à-pas) |
| Tarifs à jour | [docs/04](../../../docs/04-consommation-cus-ia/) | Recouper avant chiffrage (taux variables) |

## Pas-à-pas — isoler et chiffrer la consommation IA

1. Dans la Metrics App (capacité de démo), filtrer/repérer les opérations **Copilot in Fabric** et **AI Query**.
2. Regarder leur **CU·s total** sur 24 h et leur poids dans la courbe d'Utilization.
3. Calculer le **coût moyen par requête** à partir d'une période type : CU·s IA ÷ nombre de requêtes (la Metrics App donne l'usage agrégé ; croiser avec le volume réellement déclenché ensuite).
4. Si un Data Agent est en jeu : ajouter l'**exécution des requêtes générées** (facturées au moteur, ex. SQL Query) au total IA.
5. Comparer au stock : ce total représente quelle part des CU·h/jour du SKU ? Peut-on insérer X utilisateurs × Y requêtes sans risque (fiche 03, bornes de throttle de la fiche 01) ?

## Limites et pièges

- **Taux variables** : les tarifs par tokens changent (rappel Microsoft) — toujours recouper [docs/04](../../../docs/04-consommation-cus-ia/) avant une mission/estimation client
- La Metrics App agrège par capacité, **pas par user** par défaut : pour un coût par profil, croiser avec les postes d'utilisation ou échantillonner
- **Un Data Agent « renseigné » coûte plus en entrée** : instructions longues, beaucoup d'exemples, historique lourd → chaque requête embarque le contexte (à éprouver avant le déploiement)
- La **classification background** lisse sur 24 h : le coût d'un scénario massif ne transparaît que sur la journée, pas en temps réel — d'où la mesure sur plusieurs jours
- **Ne pas dire « OpenAI facturé à part »** : pas de facture OpenAI, tout passe en CU Fabric (aucune licence Copilot, aucun surcoût par prompt autre que les CU)

## Sources

- [Copilot consumption, usage, and billing in Fabric](https://learn.microsoft.com/en-us/fabric/fundamentals/copilot-fabric-consumption)
- [Data agent consumption](https://learn.microsoft.com/en-us/fabric/fundamentals/data-agent-consumption)
- [Doc 04 — Consommation des CUs par les features IA](../../../docs/04-consommation-cus-ia/)
