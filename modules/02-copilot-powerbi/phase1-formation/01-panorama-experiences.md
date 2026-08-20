# Fiche 01 — Panorama des expériences Copilot

## Objectifs

- Identifier les expériences Copilot disponibles dans Power BI et leur statut (GA / préversion)
- Savoir laquelle utiliser selon le profil (créateur / consommateur) et le contexte (rapport ouvert, navigation, app, mobile)
- Comprendre comment Copilot fonctionne en interne : entrée, données d'ancrage (*grounding*), sortie — et pourquoi ça explique les erreurs

## Les expériences de chat

| Expérience | Statut | Où | Périmètre |
|---|---|---|---|
| **Volet Copilot du rapport** | GA | Desktop et service, à droite d'un rapport ouvert | Le rapport ouvert : résumés, questions sur le contenu, création de pages |
| **Copilot autonome (standalone)** | Préversion | Service, navigation gauche (plein écran) + accueil mobile | Tous les rapports, modèles et data agents accessibles : recherche, résumés, questions |
| **Copilot dans les apps** | Préversion | Navigation d'une app publiée | Le contenu organisé de l'app ; réponses vérifiées supportées |
| **Mobile** | Préversion | App mobile Power BI (accueil) | Chat avec les données, visuels auto-générés, dictée vocale (iOS), partage |

Le volet Copilot du rapport est l'expérience de référence de ce module ; le Copilot autonome et les apps sont traités comme des ouvertures (recherche et découvrabilité en [atelier 2](../phase2-ateliers/atelier-2-prompts-adoption.md)).

> Les expériences autonomes et apps ne sont pas disponibles dans toutes les régions (France Central : oui ; France South : non). Vérifier [Fabric region availability](https://learn.microsoft.com/en-us/fabric/admin/region-availability). Les clouds souverains ne sont pas supportés.

## Qui fait quoi

| Profil | Créer | Consommer |
|---|---|---|
| Auteurs de rapports | Pages générées, visuel narratif, DAX, descriptions de mesures | Questions de données, résumés |
| Utilisateurs métier | — (lecture) | Résumés dans le volet, questions de données, recherche, résumés d'abonnement e-mail |
| Modélisateurs | DAX Query View, web modeling, préparation IA (module 01) | Tests du modèle via les questions de données |

## Comment Copilot fonctionne (l'essentiel)

Prompt → **ancrage** (*grounding* : métadonnées de la page courante, historique de session, schéma du modèle, descriptions) → **post-traitement** (ex. le DAX passe dans un parser) → **sortie** (page, visuel + résumé, code, narratif). Deux conséquences pratiques :

- l'**historique de conversation** fait partie de l'ancrage : il influence les réponses suivantes (d'où le clear chat) ;
- les métadonnées de rapport peuvent contenir des **points de données**, y compris sensibles — elles alimentent les requêtes envoyées au modèle.

Le détail des variations d'ancrage par expérience est en **annexe** en fin de fiche.

> Si la question porte sur les données du modèle, Copilot interroge le modèle ; sinon il peut répondre depuis les connaissances générales du LLM. Toujours vérifier la source d'une réponse (fiche 03).

## Comportements transversaux à connaître

- **Limite : 10 000 caractères** par prompt, toutes surfaces confondues.
- **Cache 24 h** : même prompt sur modèle inchangé (schéma, données, instructions) = réponse servie depuis le cache. Si le résultat surprend, modifier le prompt ou actualiser le modèle.
- **Clear chat** : efface la conversation **et** le contexte accumulé — à utiliser en changeant de sujet, car l'historique fait partie de l'ancrage et peut polluer les réponses suivantes.
- **Non-déterminisme** : deux prompts identiques peuvent donner des réponses différentes ; prévoir une recette (fiche 03, atelier 1).
- **Filtrage de contenu** : des mots présents dans les métadonnées du modèle (noms de tables/colonnes légitimes mais « sensibles » pour les filtres IA) peuvent faire échouer **tous** les prompts. Symptôme : erreurs systématiques dès qu'on interroge le modèle.
- **Consommation** : les interactions sont facturées en CUs, traitées comme opérations d'arrière-plan (voir [docs/04](../../../docs/04-consommation-cus-ia/)).

## Matériel de démo

| Élément | Où | Usage dans la fiche |
|---|---|---|
| Modèle **altisport-v2** + rapport de départ publiés | `assets/modeles/altisport-v2/` — [guide des modèles](../../../assets/modeles/guide-modeles.md) ; rapport 2-3 pages construit en amont ([README de phase](README.md#matériel-de-démo-requis)) | Support commun : le même rapport servi par les trois expériences |
| App publiée contenant le rapport | Service Power BI (workspace Copilot-enabled) | Démo du Copilot dans les apps (préversion) |

## Cas d'usage de démonstration

Ouvrir le **rapport AltiSport** publié dans le service : montrer le volet Copilot (GA) — résumé et questions sur le contenu —, puis le **Copilot autonome** (préversion) et sa recherche d'items (retrouver le rapport et le modèle AltiSport), puis le même rapport ouvert dans une **app**. Comparer les périmètres de réponse : contenu du rapport ouvert vs tous les items accessibles.

## Limites et pièges

- Impossible d'activer/désactiver Copilot par expérience ou par workload : c'est global pour les utilisateurs activés
- Le bouton Copilot dans Desktop apparaît toujours dans le ruban ; il reste **grisé** si le paramètre tenant est désactivé (voir [docs/01](../../../docs/01-prerequis-admin/))
- Après un changement de capacité, jusqu'à **24 h** peuvent être nécessaires pour que Copilot la reconnaisse
- Les réponses du Copilot autonome/app reposent sur les **métadonnées** (descriptions, noms) : sans descriptions d'items, la recherche et les résumés déçoivent (traité en atelier 2)
- Les data agents du Copilot autonome sont abordés au [module 03](../../03-fabric-data-agents/) ; les Fabric Apps (apps de données générées par agents) au [module 05](../../05-fabric-skills-authoring/)

## Annexe — Variations d'ancrage par expérience

| Étape | Description | Exemple de variation |
|---|---|---|
| **Entrée** | Prompt écrit ou interaction (bouton *Suggest content*, prompt suggéré) | Les descriptions de mesures se déclenchent depuis le volet Propriétés |
| **Ancrage (grounding)** | Copilot récupère le contexte : métadonnées de la page courante, historique de la session, schéma du modèle, schéma linguistique, propriétés (descriptions, types, formats) | DAX Query View utilise le schéma **complet** (même caché) ; les questions de données n'utilisent que les champs visibles |
| **Post-traitement** | Validation et mise en forme de la réponse | Le DAX généré passe dans un **parser DAX** : une requête invalide est régénérée |
| **Sortie** | Page de rapport, visuel + résumé, code DAX, narratif | — |

Exclusions d'ancrage communes : pages masquées, champs masqués, tables privées. En **connexion live** (DAX Query View), les expressions DAX et objets cachés/privés sont invisibles et la requête est exécutée avant d'être renvoyée.

## Sources

- [Copilot for Power BI overview](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-introduction)
- [Copilot in Power BI integration](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-integration)
- [Copilot for Power BI apps](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-apps-overview)
