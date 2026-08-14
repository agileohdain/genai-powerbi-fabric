# Setup 01 — Power BI Desktop

Configuration de Power BI Desktop pour la formation : format PBIP et *Prep data for AI*. À faire une fois par poste (~5 minutes).

## 1. Version et compte

1. Lancer **Power BI Desktop**
2. `Fichier > Compte` : vérifier la connexion (nécessaire pour enregistrer et pour Copilot)
3. `Fichier > Options et paramètres > Options > Global > À propos` : version récente requise (les fonctionnalités *Prep data for AI* et PBIP évoluent chaque mois ; mettre à jour via Microsoft Store ou `Fichier > Compte > Mettre à jour`)

## 2. Activer les fonctionnalités d'aperçu

1. `Fichier > Options et paramètres > Options`
2. Volet gauche, section **Global** > **Fonctionnalités d'aperçu** (*Preview features*)
3. Cocher :
   - ☑ **Power BI Project (.pbip)** — selon la version : « Power BI Project (preview) » ou « PBIP : modèle sémantique (TMDL) »
   - ☑ **Prep data for AI** (« Préparer les données pour l'IA »)
4. `OK` — **redémarrer Power BI Desktop** si demandé (fréquent pour .pbip)

> **Réglages par défaut conservés** : cette formation n'étant pas un cours de modélisation ni de Power Query, on laisse actives la détection automatique des types et des relations. Les défauts que Power BI Desktop corrige seul à l'import ne sont pas traités en formation ; ceux qui subsistent dans le modèle sont listés dans le [guide des modèles](../assets/modeles/guide-modeles.md).

> **Aucun outil externe requis** : la formation n'installe rien d'autre que Power BI Desktop (pas de Tabular Editor ni d'additif). Le poste du participant reste standard.

## 3. Sources de données de démo

Vérifier la présence des 6 CSV dans `assets/data/brut/` (voir le dictionnaire complet dans [assets/README.md](../assets/README.md)) :

| Fichier | Taille approx. | Lignes |
|---|---|---|
| ventes.csv | ~865 Ko | 8 001 |
| calendrier.csv | ~76 Ko | 1 097 |
| clients.csv | ~16 Ko | 221 |
| produits.csv | ~6 Ko | 65 |
| magasins.csv | ~2 Ko | 26 |
| vendeurs.csv | ~2 Ko | 61 |

## Checklist finale

- [ ] Aperçus activés : PBIP + Prep data for AI (redémarrage fait)
- [ ] `assets/modeles/altisport-v1/altisport-v1.pbip` et `altisport-v2/altisport-v2.pbip` s'ouvrent
- [ ] Les 6 CSV sont accessibles (régénération éventuelle via `assets/data/generer-donnees.ps1`)

En cas de blocage (option introuvable, intitulé différent selon la version), vérifier la version de Desktop d'abord : les aperçus apparaissent et disparaissent au fil des mises à jour mensuelles.
