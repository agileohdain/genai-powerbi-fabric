# Quiz — Module 03 · Fabric Data Agents

> À passer en fin de phase 1. 5 questions, ~10 min, sans notation : l'objectif est d'ancrer les acquis avant les ateliers. Les réponses sont pliées en bas de page.

## Questions

**1. Un data agent Fabric peut…**

- a) exécuter des workflows d'écriture (mettre à jour des données, déclencher des pipelines)
- b) uniquement générer des requêtes de lecture (SQL, DAX, KQL) — il est read-only
- c) écrire dans les lakehouses mais pas dans les modèles sémantiques
- d) modifier les rapports Power BI connectés

**2. Les réponses d'un data agent sont limitées à 25 lignes × 25 colonnes. L'agent convient donc…**

- a) au téléchargement de données en volume
- b) à l'analyse conversationnelle, pas à l'extraction massive

**3. Depuis le 26 août 2026, comment consomme-t-on un data agent ?**

- a) Uniquement via Copilot in Power BI
- b) Via l'expérience directe, Microsoft 365 Copilot, Copilot Studio, Microsoft Foundry ou un endpoint MCP — plus via Copilot in Power BI (intégration retirée)
- c) Uniquement dans Power BI Desktop

**4. Sur un modèle sémantique, les exemples question/requête sont…**

- a) supportés et recommandés
- b) non supportés : la qualité des réponses repose alors entièrement sur la préparation du modèle (module 01)
- c) supportés uniquement en anglais

**5. De quelle permission l'utilisateur final a-t-il besoin pour interroger via un data agent ?**

- a) Build + écriture sur le workspace
- b) Read sur la source — c'est suffisant
- c) Admin sur la capacité

## Réponses

<details>
<summary>Corrigé — déplier après avoir répondu</summary>

**1. b** — Un data agent est **read-only** : il ne génère que des requêtes de lecture et ne déclenche aucun workflow d'écriture. → [fiche 01](01-panorama-et-cas-usage.md)

**2. b** — Limite produit 25×25 : l'agent est fait pour la conversation analytique. → [README du module](../README.md)

**3. b** — Le retrait de l'intégration Copilot in Power BI (26/08/2026) laisse l'agent inchangé, consommable par les autres canaux. → [fiche 04](04-publier-partager-gouverner.md)

**4. b** — Spécificité clé pour les modèles sémantiques : tout repose sur la préparation (schéma IA, descriptions, instructions IA). → [README du module](../README.md)

**5. b** — Read sur la source suffit ; les droits d'écriture (Build, workspace) ne sont pas requis — à intégrer dans les habitudes de partage. → [fiche 04](04-publier-partager-gouverner.md)

</details>

---

**Score indicatif** : 5/5 ou 4/5 → badge en vue, passez aux ateliers. ≤ 3/5 → relire les fiches citées dans le corrigé avant les ateliers. Reportez votre résultat dans le [passeport IA](../../../docs/passeport/).
