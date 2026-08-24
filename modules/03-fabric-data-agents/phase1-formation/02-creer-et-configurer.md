# Fiche 02 — Créer et configurer

> Fiche charnière du module : la configuration (sources, tables, instructions, exemples) détermine ce que l'agent peut faire — et ce qu'il ne doit pas faire.

## Objectifs

- Créer un data agent à partir d'un **modèle sémantique Power BI** (source de démonstration du module)
- Sélectionner les tables pertinentes et comprendre les autres types de sources
- Rédiger des **instructions d'agent** efficaces (routage, définitions métier)
- Connaître la limitation « exemples non supportés sur modèle sémantique » et ses conséquences
- Tester dans l'expérience directe

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** publié (permission **Read** suffit) | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) | Source unique de l'agent `Agent Ventes AltiSport` |
| **vocabulaire-metier.md** | [assets/vocabulaire-metier.md](../../../assets/vocabulaire-metier.md) | Base des instructions de l'agent (routage, définitions métier) |

## Pas-à-pas — créer l'agent AltiSport

### 1. Créer l'item

1. Dans le workspace : **+ New item** → chercher **Fabric data agent** → donner un nom (`Agent Ventes AltiSport` par exemple)
2. Ouvrir l'item : un écran de configuration apparaît (Explorer à gauche, zone de test à droite)

### 2. Ajouter une source et sélectionner les tables

1. Sélectionner le **modèle sémantique** AltiSport v2 dans le sélecteur de sources → **Add**
2. Depuis l'Explorer, cocher les tables exposées. Pour v2 : `FactVentes`, `DimDate`, `DimProduit`, `DimMagasin`, `DimVendeur`, `DimClient`, table `Mesures` — **retenir les tables utiles aux questions attendues** ; une table inutile est une source d'erreurs en plus
3. Sources possibles (jusqu'à 5, combinables) : modèle sémantique Power BI, lakehouse, warehouse, KQL Database (Eventhouse), mirrored database, ontology, Microsoft Graph. Pour une lakehouse : sélection de **tables** uniquement — des fichiers CSV/JSON doivent d'abord être ingérés en tables

> Sur un modèle sémantique, aucune colonne « à exclure » : ce sont les métadonnées du modèle (visibilité, descriptions — module 01) qui font le tri. Un modèle bien préparé limite d'emblée le risque.

### 3. Rédiger les instructions

Bouton **Data agent instructions** → volet à droite. Les instructions guident le **routage** (quelle source pour quel type de question) et **définissent le jargon métier**. Exemple (EN affiché, traduction pour les équipes) :

```text
Answer questions about AltiSport sales using the AltiSport v2 semantic model. Use the model measures for all revenue questions; never compute revenue yourself. "Comptoir" refers to the Magasin channel only, as opposed to Web. The winter season ("saison blanche") runs December-February, the summer season ("saison verte") June-August. Exclude cancelled orders from all revenue figures.
```

Traduction : *Réponds aux questions sur les ventes AltiSport à partir du modèle sémantique AltiSport v2. Utilise les mesures du modèle pour toute question de chiffre d'affaires ; ne calcule jamais les montants toi-même. « Comptoir » désigne le canal Magasin uniquement, par opposition au Web. La saison blanche court de décembre à février, la saison verte de juin à août. Exclure les commandes annulées de tout chiffre de vente.*

Règles : phrases courtes, pas de contradiction entre instructions, alignées sur le vocabulaire réel (dicter le routage depuis [vocabulaire-metier.md](../../../assets/vocabulaire-metier.md)).

### 4. Les exemples de requêtes

Le volet **Example queries** permet d'ajouter des paires question/requête (SQL, KQL) qui servent de modèles de comportement.

> ⚠️ **Les exemples ne sont pas supportés pour les modèles sémantiques Power BI.** Pour une source modèle sémantique, la qualité repose donc sur : le schéma IA et les descriptions du modèle (module 01), la fiche 03 du module 01 (instructions IA / Prep data for AI), et les instructions de l'agent elles-mêmes. C'est un argument de plus pour la préparation.

### 5. Tester dans l'expérience directe

Poser des questions dans le chat de l'item, vérifier la réponse (fiche 03), ajuster instructions, retester. Le travail se fait sur le **brouillon** : rien n'est visible des consommateurs tant que l'agent n'est pas publié (fiche 04).

## Concepts complémentaires

- **Jusqu'à 5 sources** combinables : ex. modèle sémantique pour les chiffres + lakehouse pour l'exploration brute + KQL Database pour les logs
- **Niveaux d'intention** : les instructions du développeur (niveau 3) sont toujours subordonnées aux politiques d'organisation (niveau 1) et aux paramètres de workspace (niveau 2) — un agent ne peut pas contourner une politique, même bien articulé
- La **description** de l'agent (saisie à la publication) aide les consommateurs et les orchestrateurs à choisir l'agent : la soigner dès la configuration

## Limites et pièges

- Les instructions en **français** dégradent fortement le routage : rédiger en anglais
- Sélectionner une table sans rapport avec les questions (ex. calendrier masqué) augmente le risque de mauvais routage
- Ne pas exposer une table contenant des données sensibles « juste au cas où » : moins de surface = moins de risques (et moins de CUs)
- La prise d'effet des paramètres tenant peut prendre **jusqu'à une heure** (voir README du module)
- Historique de conversation : conservé jusqu'à 28 jours selon le tenant, supprimable par l'utilisateur, **non garanti** (peut être réinitialisé par le service)

## Sources

- [Fabric data agent creation (concept, GA)](https://learn.microsoft.com/en-us/fabric/data-science/concept-data-agent)
- [Fabric data agent scenario — bout en bout](https://learn.microsoft.com/en-us/fabric/data-science/data-agent-end-to-end-tutorial)
- [vocabulaire-metier.md](../../../assets/vocabulaire-metier.md) (définitions AltiSport)