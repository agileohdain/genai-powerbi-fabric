# Fiche 03 — Gouvernance & alertes : FCC, seuils, adoption incrémentale

> Fiche de pilotage : mettre la **gouvernance en place** — désigner une **Fabric Copilot capacity** (FCC) pour regrouper la facturation, poser des **alertes sur seuils** (Capacity Overview Events), cibler l'activation dans les tenant settings, et cadrer l'adoption (pilote → mesurer → scaler). C'est ici que « mesurer » devient « **décider** ».

## Objectifs

- Comprendre la **Fabric Copilot capacity (FCC)** : à quoi elle sert, quand la mettre en place, qui fait quoi ([rôle admin])
- Configurer une **alerte email sur seuil de capacité** (Real-Time Hub / Capacity Overview Events) ([rôle admin])
- Utiliser les **tenant settings** pour cibler Copilot à un groupe, en montée en charge maîtrisée ([rôle admin])
- Appliquer la démarche **pilote → mesurer → extrapoler → scaler** et construire un **back-of-the-envelope** de scénario
- Positionner l'**arbitrage des features** (MCP/Skills = 0 CU vs Copilot/Data Agents = tokens) dans la matrice globale

## Concepts

### Fabric Copilot capacity (FCC) — regrouper la facturation IA

Sans FCC, chaque usage Copilot/Data Agent est **facturé à la capacité qui porte le contenu** → coût IA dispersé sur toutes les capacités. La **FCC** (F2/P1 minimum, juin 2026) est une capacité **désignée** qui regroupe et facture l'usage IA d'**un groupe d'utilisateurs**, y compris :

- Copilot sur **Power BI Desktop**,
- Copilot Power BI sur espaces **Pro / PPU / Premium / Fabric**,
- Copilot Fabric et **Data Agents** sur espaces de capacité < F64.

Mise en place (3 acteurs) :

| Rôle | Action |
|---|---|
| Admin Fabric | Activer Copilot + **autoriser** les admins de capacité à désigner une FCC (paramètres tenant) |
| Admin capacité | Désigner la capacité comme FCC + **assigner les utilisateurs** (paramètres de capacité) |
| Utilisateurs | Aucune action : la facturation est automatique |

Limites à retenir : région **home du tenant** uniquement ; **1 FCC par utilisateur** (la plus récente l'emporte) ; pas de licence mode *Embedded* ; ne couvre **pas** les AI functions Fabric. L'admin de la FCC voit les métadonnées items/workspaces des utilisateurs assignés — accord et périmètre à documenter ([docs/02](../../../docs/02-securite/)).

### Alertes sur seuils — Capacity Overview Events

La Metrics App elle-même **n'émet pas d'alerte** « % CU atteint » : le mécanisme officiel est l'**alerte email via les événements de capacité** dans **Real-Time Hub** (suivre le [tutoriel](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold)). Démarche :

1. Activer les **Capacity Overview Events** et faire pointer la règle sur la capacité surveillée
2. Définir un **seuil** d'alerte (ex. dépassement de X % d'utilisation lissée, événement de throttling) et les destinataires (liste d'admins)
3. En cas de déclenchement : ouvrir la Metrics App → courbe Throttling + System events → décider (attente, régulation, upscale — fiche 01)

### Tenant settings — activer de façon ciblée

Copilot est activé par défaut sur tenant payant. Pour une **montée en charge maîtrisée** : cibler un **groupe de sécurité** sur le réglage *Users can use Copilot…* plutôt que tout le tenant (déjà vu en [docs/01](../../../docs/01-prerequis-activation/)), puis élargir une fois la consommation mesurée.

### Adoption incrémentale (recommandation Microsoft)

1. **Pilote** : petit groupe, scénario précis (ex. données de vente par région)
2. **Mesurer** : Metrics App sur la période du pilote (CU·s IA, opérations, coût/requête)
3. **Extrapoler** : back-of-the-envelope × le nombre cible d'utilisateurs/requêtes
4. **Scaler** (ou ajuster) : seuils + éventuelle FCC posées avant le déploiement large

## Pas-à-pas — construire l'alerte et l'estimation

### 1. Alerte sur seuil ([rôle admin])

1. Portail Fabric → **Real-Time Hub** → créer la règle sur **Capacity Overview Events** (capacité ciblée)
2. Seuil initial recommandé : alerte dès qu'un **événement de throttling** apparaît + seuil secondaire sur l'utilisation
3. Destinataires : les admins capacité (pas toute l'équipe — éviter le bruit)
4. Tester volontairement : générer une charge (ex. gros rafraîchissement ou salve Copilot) et confirmer la réception

### 2. Back-of-the-envelope d'un scénario

À partir de la fiche 02, remplir pour le scénario visé :

```
CU·h par requête type   = (ex. 0,11 pour 2k in / 500 out)
nb_users cibles         = __
nb requêtes/jour/user   = __
Coût IA jour            = __ CU·h   →  part de la capacité = __ % (SKU × 24)
```

Si > X % de réserve (ex. > 15-20 % de la capacité pour l'IA), reconsidérer le scénario, le nombre d'utilisateurs, ou la capacité.

### 3. Matrice d'arbitrage (synthèse avec [docs/05](../../../docs/05-matrice-arbitrage-globale/))

Pour un besoin donné, croiser **coût CU** et **compte utilisateur** :

| Besoin | Feature | Coût CU |
|---|---|---|
| Créer/modifier un rapport en masse | Skills (module 05, local) | **0 CU** (service standard seulement) |
| Auditer/documenter un modèle | MCP (module 04, local) | **0 CU** |
| Questionner l'équipe en langage naturel | Data Agent (module 03) | Tokens (AI Query) + requêtes générées |
| Génération dans des rapports/dashboards grand public | Copilot (module 02) | Tokens (Copilot in Fabric) |

## Limites et pièges

- **La FCC ne change pas la consommation**, elle la **concentre** : utile à la visibilité/au pilotage, pas un palliatif au throttling
- Une FCC **par utilisateur max** et **région home** : vérifier l'adéquation avant de convaincre le client de la mettre en place
- **Ne pas sur-alerter** : des seuils trop bas créent un bruit qui tue le dispositif — commencer par les événements de throttling, ajuster ensuite
- **Décision documentée** pour l'ouverture (tenant settings tenant-à-tenant, région, groupe) — voir [docs/01](../../../docs/01-prerequis-activation/) et [docs/02](../../../docs/02-securite/)
- **L'équipe BI ne pilote pas la capacité seule** : les remèdes coûteux (overage 3×, pause/resume) sont des décisions d'admin — le module forme à **signaler et chiffrer**, pas à trancher la facture

## Sources

- [Fabric Copilot capacity for usage billing](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)
- [Monitor capacity threshold — tutoriel Real-Time Hub](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold)
- [Copilot settings in the admin portal](https://learn.microsoft.com/en-us/fabric/admin/service-admin-portal-copilot)
- [Doc 04 — Consommation des CUs par les features IA](../../../docs/04-consommation-cus-ia/)
