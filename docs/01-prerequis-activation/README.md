# Doc 01 — Prérequis & activation de Copilot

Ce que l'admin doit activer **avant** la formation, et comment vérifier que tout est prêt. Toutes les démos Copilot (fiches 02-04, modules 02, 03 et 05) et l'étape *Prep data for AI* du modèle v2 en dépendent.

> Copilot est **activé par défaut** sur les tenants disposant d'une capacité Fabric payante. Les étapes ci-dessous servent à le **vérifier**, le **cibler** (groupe de sécurité) et le rendre **utilisable dans Power BI Desktop**.

## Vue d'ensemble — qui fait quoi

| # | Étape | Qui | Où |
|---|---|---|---|
| 1 | Disposer d'une capacité éligible dans une région supportée | Admin capacité | Portail Azure |
| 2 | Activer les paramètres Copilot du tenant | Admin tenant Fabric | Portail d'administration Fabric |
| 3 | Si les paramètres sont délégués : les réactiver au niveau capacité | Admin capacité | Portail d'administration Fabric |
| 4 | Assigner le workspace de formation à la capacité, donner les rôles | Admin workspace | Paramètres du workspace |
| 5 | Sélectionner un workspace Copilot-enabled comme workspace actif | Chaque participant | Power BI Desktop |

## 1. Capacité requise

| Situation | Copilot ? |
|---|---|
| Capacité Fabric **F2 ou plus** | ✅ directement |
| Capacité Power BI Premium **P1 ou plus** | ✅ directement (inutile d'activer les autres workloads Fabric) |
| Workspace **Pro / PPU** uniquement | ❌ sauf en créant une [Fabric Copilot Capacity](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity) (FCC) et en y assignant le workspace |

- La capacité doit être dans une **région supportée** ([Fabric region availability](https://learn.microsoft.com/en-us/fabric/admin/region-availability)) — France Central convient.
- Tout usage Copilot — y compris depuis Desktop — **consomme des CUs de la capacité** : voir [doc 04](../04-consommation-cus-ia/).

## 2. Paramètres tenant (portail d'administration Fabric)

[app.fabric.microsoft.com/admin-portal](https://app.fabric.microsoft.com/admin-portal) > **Paramètres du tenant** > section *Copilot and Azure OpenAI Service* :

1. ☑ **Users can use Copilot and other features powered by Azure OpenAI**
2. ☑ **Data sent to Azure OpenAI can be processed outside your capacity's geographic region, compliance boundary, or national cloud instance**

> **Cibler un groupe de sécurité** (ex. les participants de la formation) plutôt que tout le tenant : recommandé par Microsoft pour maîtriser la consommation en CUs et les risques. On élargit ensuite, formation faite.

> Le second paramètre a une **implication de conformité** (données traitées hors de la région de la capacité). Selon la région de la capacité, il peut être obligatoire — c'est une décision à documenter côté admin : voir [doc 02](../02-securite/).

Il n'est pas possible d'activer des expériences Copilot isolées (ex. seulement le DAX Query View) : le réglage est par workload.

## 3. Paramètres délégués au niveau capacité

Si les paramètres Copilot du tenant sont [délégués aux administrateurs de capacité](https://learn.microsoft.com/en-us/fabric/admin/delegate-settings) : ouvrir les paramètres de la capacité dans le portail d'administration et activer les **deux mêmes réglages** (éventuellement restreints au même groupe de sécurité). Sinon, cette étape n'existe pas.

## 4. Workspaces

1. Assigner le workspace de formation à la capacité Copilot-enabled (**Paramètres du workspace > Informations de licence**)
2. Donner un rôle aux participants — **Contributeur** minimum pour les ateliers

L'accès Copilot est contrôlé par le **rôle dans le workspace** : pas de licence Copilot spécifique côté utilisateur.

## 5. Power BI Desktop

Le bouton **Copilot** du ruban est toujours visible ; c'est la **sélection d'un workspace éligible** qui l'active :

1. `Fichier > Compte` : être connecté
2. Cliquer sur **Copilot** (ruban Accueil) → le volet invite à choisir un **workspace assigné à une capacité Copilot** (seuls les éligibles s'affichent)
3. Pour revoir ou changer ce workspace : engrenage ⚙️ en bas à droite → **Options > Copilot (préversion)**

> Contrairement au service (contrôle au niveau workspace), Copilot Desktop requiert en plus le **réglage tenant actif** (étape 2) — sinon le bouton reste grisé. Erreur type dans *Options > Copilot (préversion)* : *« Either none of your workspaces have the right capacity to use Copilot, or you don't have the right permission to use them »* → capacité non éligible ou droits insuffisants (retour aux étapes 1-4).

L'usage est imputé à la capacité du workspace sélectionné.

## 6. Vérification (5 minutes, avant la formation)

- [ ] Dans le service : le workspace de formation est sur la bonne capacité et les boutons Copilot apparaissent
- [ ] Dans Desktop (modèle v2 ouvert, workspace actif sélectionné) : bouton **Copilot** visible dans le ruban Accueil
- [ ] `Préparer les données pour l'IA` : les onglets s'ouvrent sans message d'erreur

Message d'erreur fréquent : *« Copilot is not available because its capacity is located outside your tenant's region »* → second paramètre tenant non activé, ou capacité hors région supportée (retour à l'étape 1-2).

Une fois ces prérequis acquis, appliquer la [configuration *Prep data for AI* du modèle v2](../../assets/modeles/guide-modeles.md#9-configuration-copilot-prep-data-for-ai).

## Sources

- [Enable and configure Copilot in Microsoft Fabric](https://learn.microsoft.com/en-us/fabric/fundamentals/copilot-enable-fabric) (maj. 05/2026)
- [Copilot settings in the admin portal](https://learn.microsoft.com/en-us/fabric/admin/service-admin-portal-copilot)
- [Use Copilot in Power BI Desktop](https://learn.microsoft.com/en-us/power-bi/create-reports/copilot-power-bi-desktop)
- [Fabric region availability](https://learn.microsoft.com/en-us/fabric/admin/region-availability)
- [Fabric Copilot capacity](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)
