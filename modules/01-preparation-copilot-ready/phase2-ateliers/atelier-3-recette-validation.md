# Atelier 3 — Recette et validation

## Objectif

Valider le modèle configuré **avant mise en production** : plan de recette des réponses, audit du raisonnement (HCAAT), marquage *Approved for Copilot* et communication aux utilisateurs.

## Plan de recette

### 1. Recette des réponses vérifiées (45 min)

Pour chaque réponse vérifiée, documenter dans un tableau :

| # | Question testée (formulation utilisateur) | Résultat attendu | Résultat obtenu | Verdict |
|---|---|---|---|---|
| 1 | (phrase déclencheuse exacte) | Visuel vérifié | … | OK / KO |
| 2 | (reformulation sémantique) | Visuel vérifié | … | OK / KO |
| 3 | (question proche mais hors périmètre) | Pas de déclenchement abusif | … | OK / KO |

Points de contrôle : coche « vérifié » affichée, phrase déclencheuse matched correcte, filtres appliqués conformes.

### 2. Recette des questions de données (45 min)

- Reprendre la liste des questions métier fréquentes : vérifier que le schéma IA couvre les besoins sans réponse manquante.
- Pour chaque réponse surprenante : ouvrir **How Copilot arrived at this**, identifier le champ/mesure/filtre utilisé, corriger (schéma IA, instruction ou description) et retester.
- Si besoin, télécharger les **diagnostics** (menu ... du volet Copilot) et vérifier l'absence de warning (`AgentSchemaReduced` notamment).

### 3. Critères d'acceptation

Valider avant marquage :

- [ ] Toutes les questions critiques de la liste client reçoivent une réponse correcte
- [ ] Les réponses vérifiées se déclenchent sur les formulations réelles (taux > 90 % des tests)
- [ ] Aucune réponse vérifiée n'expose de données sensibles (RLS/OLS — voir [docs/02-securite](../../../docs/02-securite/))
- [ ] Le volet Copilot a été testé avec le skill picker en configuration « mode Lecture » (ce que voient les consommateurs)
- [ ] Les diagnostics ne montrent pas de réduction du schéma

### 4. Marquage *Approved for Copilot* (15 min)

1. Service Power BI > modèle sémantique > **Paramètres**.
2. Section **Approved for Copilot** > cocher > **Apply**.
3. Noter la propagation : < 1 h en général, jusqu'à 24 h si de nombreux rapports ; forcer via une petite sauvegarde de rapport si nécessaire.

### 5. Communication et gouvernance (15 min)

- Qui valide les évolutions futures du modèle (instructions, réponses vérifiées) ? Nommer un référent.
- Process léger de changement : modification > mini-recette (tableau ci-dessus sur les points impactés) > republication.
- Informer les utilisateurs : le modèle est approuvé, exemples de questions qu'ils peuvent poser.

## Livrables

- Plan de recette complété (tableaux de tests)
- Modèle marqué *Approved for Copilot*
- Note de gouvernance (référent, process de changement)

## Après l'atelier

- Surveiller les questions sans réponse remontées par les utilisateurs : matière première pour de nouvelles réponses vérifiées / instructions
- Réutiliser la grille d'audit (atelier 1) sur les autres modèles du client, manuellement ou via MCP (module 04)
