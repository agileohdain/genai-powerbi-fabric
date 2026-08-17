# Quiz — Module 05 · Fabric Skills Authoring

> À passer en fin de phase 1. 5 questions, ~10 min, sans notation : l'objectif est d'ancrer les acquis avant les ateliers. Les réponses sont pliées en bas de page.

## Questions

**1. Un « skill » for Fabric, c'est…**

- a) un serveur d'outils connecté à VS Code
- b) un paquet d'instructions que l'agent Copilot charge à la demande — là où MCP est un outil
- c) une extension Power BI Desktop
- d) un modèle d'IA fine-tuné pour les rapports

**2. Format de projet requis pour travailler avec les skills ?**

- a) .pbix
- b) PBIP avec rapport en PBIR (pas PBIR-Legacy)
- c) .pbit
- d) Excel + Dataflow

**3. Pour les rôles de visuels, le formatage et les énumérations du JSON PBIR, la règle est…**

- a) laisser l'agent les deviner puis corriger à la main
- b) les faire sortir du CLI (`powerbi-report-author catalog/formatting`) et des références du skill — jamais de mémoire
- c) les chercher sur Internet pendant la session

**4. La boucle de vérification après chaque modification est…**

- a) Edit → Publish → Refresh
- b) Edit → Validate → Reload → Screenshot
- c) Edit → Commit → Push
- d) Prompt → Diff → Merge

**5. Le skill Report Authoring peut-il modifier le modèle sémantique ?**

- a) Oui — il couvre modèle et rapport
- b) Non — il ne touche que la couche rapport ; le modèle relève du module 04 (MCP)

## Réponses

<details>
<summary>Corrigé — déplier après avoir répondu</summary>

**1. b** — Skill = instructions chargées à la demande ; MCP = outil appelé par l'agent. → [fiche 01](01-skills-et-agentes.md)

**2. b** — PBIR obligatoire ; et le `getDefinition` depuis Fabric doit demander `format=PBIR`. → [fiche 01](01-skills-et-agentes.md)

**3. b** — Règle absolue : ne jamais laisser deviner le JSON PBIR — le CLI et les références font foi. → [fiche 02](02-charte-et-creation.md)

**4. b** — Edit → Validate → Reload → Screenshot : la vérification du rendu en Desktop local avant toute publication. → [fiche 03](03-refactoring-et-traduction.md)

**5. b** — Répartition claire : modèle = MCP (module 04), rapport = Skills (module 05). → [README du module](../README.md)

</details>

---

**Score indicatif** : 5/5 ou 4/5 → badge en vue, passez aux ateliers. ≤ 3/5 → relire les fiches citées dans le corrigé avant les ateliers. Reportez votre résultat dans le [passeport IA](../../../docs/passeport/).
