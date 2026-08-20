# Setup 04 — Capacité Fabric & gouvernance

Configuration de l'environnement du module 06 (Gouvernance & CUs) : **identifier/avoir une capacité Fabric**, comprendre les rôles, installer la **Microsoft Fabric Capacity Metrics app**, et préparer les prérequis admin (Copilot actif, alertes, option Fabric Copilot capacity). À faire **une fois par capacité concernée** (démo + client), en partie par un `[rôle admin]` (~30 min, étapes admin non incluses).

> Ce guide est le **volet « capacité »** : les prérequis d'entreprise (licences, activation Copilot) restent dans [docs/01-prerequis-admin](../docs/01-prerequis-admin/).

## 1. Prérequis

| Élément | Exigence |
|---|---|
| Capacité Fabric | **F2+ (Fabric capacity) ou P1+ (Premium)** dans une **région supportée** ([régions](https://learn.microsoft.com/en-us/fabric/admin/region-availability)) |
| Rôles | **Admin de capacité** (paramètres capacité, Metrics App) ; **Admin Fabric / tenant** pour les étapes déjà couvertes ou l'option FCC |
| Contenu | Un espace de travail avec historique d'usage (les modules 02-03 créent l'usage IA à observer) |
| Référence | [docs/04 — Consommation des CUs par les features IA](../docs/04-consommation-cus-ia/) lue |

## 2. Vérifier / disposer d'une capacité (`[rôle admin]` si création)

1. Portail Azure ou [app.fabric.microsoft.com](https://app.fabric.microsoft.com) → **Capacités** : liste des capacités du tenant, SKU et région.
2. Si aucune : `[rôle admin]` créer une **capacité Fabric** (SKU à minima, ex. F2/F4 pour la démo − voir volume d'usage attendu) dans une région supportée.
3. **Assigner** l'espace de travail de formation à la capacité (paramètres du workspace > **Informations de licence**) — indispensable : sans capacité, les boutons Copilot/Data Agents n'apparaissent pas.
4. Vérifier l'accès : le compte formateur a droit d'ouvrir les paramètres de capacité et la Metrics App de **cette** capacité.

## 3. Rôles capacité à connaître

| Rôle | Permet | Modèle utilisé par |
|---|---|---|
| Admin capacité | Paramètres de capacité, Metrics App, désigner une FCC, remèdes (upscale, pause/resume, overage) | Module 06 (fiches 01-03, ateliers 1-2) |
| Visiteur/Metrics App viewer | Consulter la Metrics App (lecture du relevé) | Module 06 (fiche 01, atelier 1) |
| Admin Fabric | Paramètres tenant (activation Copilot, autorisation FCC) | docs/01, fiché 03 (option) |

> Selon la taille du tenant, la visibilité Metrics App est restreinte : demander à l'admin de capacité d'**autoriser le lecteur** au besoin avant l'atelier 1.

## 4. Installer la Microsoft Fabric Capacity Metrics app

1. Dans [app.fabric.microsoft.com](https://app.fabric.microsoft.com) → **AppSource** (ou « My apps » → obtenir plus) → rechercher **Microsoft Fabric Capacity Metrics** → **Get it now**.
2. Installer dans **un workspace d'administration dédié** (ex. `gouvernance`) sur la capacité surveillée.
3. Ouvrir l'application → **paramètres du connecteur** : renseigner la/les capacité(s) à surveiller ; laisser le **refresh auto** durée conseillée (5 min pour la page Compute).
4. Vérifier : les données s'affichent (page Compute : Utilization, Throttling, System events, Overages) — voir [page Compute](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-compute-page).

## 5. Prérequis admin pour le module 06

- [ ] **Copilot activé** (tenant settings) — normalement déjà fait pour les modules 02-03 (voir [docs/01](../docs/01-prerequis-admin/))
- [ ] **Historique d'usage IA** sur la capacité (avoir exécuté des requêtes Copilot / Data Agents)
- [ ] `[rôle admin]` **alertes** : prévoir d'activer les **Capacity Overview Events** (Real-Time Hub) lors de l'atelier 2 — tutoriel : [Monitor capacity threshold](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold)
- [ ] (Option atelier 2) **autorisation FCC** : admin Fabric pour autoriser la désignation d'une Fabric Copilot capacity ; capacité F2+/P1+ dans la région home — [Fabric Copilot capacity](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)

## 6. Vérification

1. La Metrics App affiche la capacité avec des données (Utilization + liste d'opérations).
2. Les opérations **Copilot in Fabric** et **AI Query** sont identifiables (après usage Copilot/Data Agent des modules 02-03).
3. L'utilisateur formateur peut ouvrir la Metrics App (lecture) ; l'admin capacité identifié est prêt pour les ateliers.
4. (Option) Le groupe pilote est défini côté docs/01 pour la montée en charge ciblée.

## Checklist finale

- [ ] Capacité F2+/P1+ identifiée (ou créée) et espace de formation assigné
- [ ] Rôles clairs (admin capacité + lecteur Metrics App) ; Metrics App installée et alimentée
- [ ] Opérations Copilot in Fabric / AI Query visibles (historique d'usage IA)
- [ ] Admin le tenant identifié pour les étapes optionnelles (alertes, FCC) de l'atelier 2

En cas de blocage : [Metrics App — problèmes courants](https://learn.microsoft.com/en-us/fabric/enterprise/metrics-app-troubleshoot) et [throttling — comprendre les erreurs](https://learn.microsoft.com/en-us/fabric/enterprise/throttling).
