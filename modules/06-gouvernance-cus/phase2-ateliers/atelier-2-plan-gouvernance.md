# Atelier 2 — Seuils & plan de gouvernance IA

## Objectif

À partir du relevé de l'atelier 1, **mettre en place la gouvernance** chez le client : alertes sur seuils, activation ciblée, éventuellement une **Fabric Copilot capacity** (option guidée), et surtout **rédiger la charte de gouvernance IA** — qui peut déclencher quoi, qui surveille, qui décide (et facture).

> L'atelier est **piloté par un `[rôle admin]`** pour les étapes de configuration. L'équipe BI apporte le relevé (atelier 1) et valide les choix opérationnels ; la décision finale (seuils, FCC, ouverture tenant) appartient au client.

## Durée

~2 h (en binôme formateur / équipe + admin client).

## Étape 0 — Cadrage (15 min)

1. Reprendre le relevé de l'atelier 1 (postes IA, marge, éventuel throttling passé)
2. Confirmer qui détient les droits : admin Fabric (paramètres tenant), admin(s) de capacité (paramètres capacité, Metrics App)
3. Décider le **périmètre de départ** : un workspace/groupe pilote (cohérent avec « pilote → mesurer → scaler »)

## Étape 1 — Alertes sur seuils (40 min) `[rôle admin]`

1. Activer les **Capacity Overview Events** dans **Real-Time Hub**, pointer la capacité surveillée
2. Poser les seuils : **événement de throttling** (alerte immédiate) + seuil d'utilisation secondaire (à calibrer sur le relevé de l'atelier 1)
3. Destinataires : liste restreinte d'admins ; **test volontaire** (salve de charge) pour prouver la réception
4. Noter les seuils et leur justification dans la charte

## Étape 2 — Activation ciblée (20 min) `[rôle admin]` (option si non déjà fait)

Cibler le réglage Copilot/IA sur le **groupe pilote** (tenant settings) au lieu de tout le tenant ; documenter la montée en charge (docs/01).

## Étape 3 — Fabric Copilot capacity — option guidée (30 min) `[rôle admin]`

**Décider d'abord** (tableau des critères, avec l'équipe) :

| Question | Si oui → FCC utile | Si non → passer |
|---|---|---|
| La facturation IA est-elle dispersée sur plusieurs capacités ? | ✅ regrouper | — |
| Y a-t-il du Copilot **Desktop** ou sur espaces **Pro/PPU** à suivre ? | ✅ | — |
| La capacité cible est-elle dans la **région home** du tenant ? (sinon impossible) | ✅ | — |
| Un seul utilisateur = 1 FCC (priorité à la plus récente) — acceptable ? | ✅ | — |

**Si la décision est « oui »** (admin Fabric présent et accord) :

1. Admin Fabric : autoriser la désignation de FCC dans les paramètres Copilot
2. Admin capacité : désigner la capacité comme **Fabric Copilot capacity** et **assigner le groupe** d'utilisateurs
3. Vérifier : l'opération **Copilot in Fabric / AI Query** de ce groupe s'affiche désormais sur la FCC (Metrics App)

**Si non / pas d'admin** : documenter comme **suite possible** dans la charte (conditions, acteurs, coût de mise en place).

## Étape 4 — Rédiger la charte de gouvernance IA (40 min)

Livrable structuré dans le dépôt client (`gouvernance/charte-gouvernance-ia.md`), sections minimales :

1. **Périmètre** : capacités, workspaces, groupe pilote puis cibles
2. **Qui peut quoi** : utilisateurs (features IA permises), admins (règles de capacité, remèdes coûteux)
3. **Seuils & alertes** : opérations surveillées (Copilot in Fabric, AI Query), seuils, destinataires, fréquence de revue
4. **Procédure incident (throttling)** : qui détecte (alerte) → qui confirme (Metrics App) → qui décide (attente / régulation / upscale / overage) → traçabilité
5. **Processus d'adoption incrémentale** : règle « un nouveau scénario passe par pilote → mesure → feu vert » et critères de feu vert (marge, coût/requête)
6. **Arbitrage des features** : quand Copilot / Data Agent / MCP / Skills (matrice docs/05, rappel MCP/Skills = 0 CU)
7. **Responsabilités & sécurité** : FCC = exposition des métadonnées, accord utilisateurs (renvoi docs/02)

## Étape 5 — Bilan et suite (15 min)

- Relire la charte en collégial, attribuer les relectures/validations (Décision : validée par qui, quand ?)
- Fixer la première **revue** (ex. 1 mois après : comparaison du relevé atelier 1 vs nouveau relevé)
- Lister les « suite possibles » (FCC non posée, extension du groupe, nouveaux scénarios à éprouver)

## Livrables

- **Alerte(s) sur seuil actives** (testées) pour la capacité du client
- **Charte de gouvernance IA** rédigée et versionnée dans le dépôt client
- (Option) **Fabric Copilot capacity** mise en place, avec le groupe assigné et la vérification Metrics App

## Critères de succès

- Alertes **testées** (une salve de charge a déclenché l'email) et documentées
- Charte **validée** (signatures/validation) et intégrée au dépôt client
- Si FCC : le groupe assigné, et l'usage IA **visible sur la FCC** (Metrics App)
- Feuille de route **adoption incrémentale** écrite, avec critères de feu vert explicites

## Antidotes aux dérives d'atelier

| Dérive | Antidote |
|---|---|
| On configure tout sans charte (ni pérenne ni documenté) | Écrire la charte **d'abord** (ébauche en étape 3-4), configurer ensuite sur sa base |
| L'équipe veut décider seule des seuils/remèdes coûteux | Séparer nettement mesures d'équipe (étapes lecture) et décisions admin ; les remèdes coûteux (overage 3×, pause) = décision du client |
| On « sur-gouverne » et bloque l'adoption | Rappeler l'objectif : mesurer puis élargir — tout seuil trop contraignant se révise sous 30 j |
| FCC posée « pour voir » sans décision | Passer par le tableau de décision (étape 3) : pas de FCC sans critère rempli |

## Sources

- [Monitor capacity threshold — tutoriel Real-Time Hub](https://learn.microsoft.com/en-us/fabric/real-time-hub/tutorial-monitor-capacity-threshold)
- [Fabric Copilot capacity for usage billing](https://learn.microsoft.com/en-us/fabric/enterprise/fabric-copilot-capacity)
- [Doc 04 — Consommation des CUs par les features IA](../../../docs/04-consommation-cus-ia/)
- [Setup 04 — Capacité & gouvernance](../../../setup/04-capacite-gouvernance.md)
