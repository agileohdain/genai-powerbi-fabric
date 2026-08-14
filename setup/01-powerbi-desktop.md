# Setup 01 — Power BI Desktop

Configuration de Power BI Desktop pour la formation : format PBIP, *Prep data for AI*, et outils externes. À faire une fois par poste (~5 minutes).

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

## 3. Désactiver la détection automatique des relations

1. `Fichier > Options et paramètres > Options`
2. Section **Global** (ou **Fichier actif** selon la version) > **Chargement des données** (*Data Load*)
3. Décocher :
   - ☐ **Détecter automatiquement les relations entre les tables**
   - ☐ *Importer les relations depuis les sources de données* (si présent)
4. `OK`

> Pourquoi : le modèle de démo v1 doit rester **sans aucune relation** (démo « modèle sale », module 01 / terrain d'audit, module 04). La détection automatique les recréerait à l'import. Pour v2, les relations sont créées manuellement et volontairement.

## 4. Installer Tabular Editor 2

1. Télécharger **Tabular Editor 2.x** (gratuit) : `https://tabulareditor.com/downloads` ou Microsoft Store (« Tabular Editor ») — pas la version 3 (payante)
2. Installer et lancer une fois, puis fermer
3. Vérification : dans Power BI Desktop, ruban **Outils externes** > « Tabular Editor » présent (le ruban s'active quand un modèle est ouvert)

> Utilisé pour le **calculation group** du modèle v2 (non créable dans l'interface native) et en complément du module 04 (Best Practice Analyzer).

## 5. Sources de données de démo

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
- [ ] Détection automatique des relations désactivée
- [ ] Tabular Editor visible dans Outils externes
- [ ] Les 6 CSV sont accessibles

En cas de blocage (option introuvable, intitulé différent selon la version), vérifier la version de Desktop d'abord : les aperçus apparaissent et disparaissent au fil des mises à jour mensuelles.
