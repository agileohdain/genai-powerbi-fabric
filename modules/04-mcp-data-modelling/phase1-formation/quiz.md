# Quiz — Module 04 · MCP Data Modelling

> À passer en fin de phase 1. 5 questions, ~10 min, sans notation : l'objectif est d'ancrer les acquis avant les ateliers. Les réponses sont pliées en bas de page.

## Questions

**1. Le Power BI Modeling MCP Server peut modifier…**

- a) le modèle sémantique et les pages de rapport
- b) uniquement le modèle sémantique — ni pages de rapport, ni layout de diagramme
- c) le modèle, les rapports et les flux de données
- d) rien : il est strictement en lecture seule

**2. Avant de laisser l'agent écrire sur le modèle, le réflexe obligatoire est…**

- a) fermer Power BI Desktop
- b) committer / taguer le modèle PBIP (baseline Git) pour pouvoir revenir en arrière
- c) exporter le modèle en .pbix de secours
- d) passer le modèle en lecture seule dans le service

**3. Quels fichiers ne faut-il **jamais** ouvrir dans le chat Copilot ?**

- a) les fichiers TMDL des tables
- b) `.pbi/`, `cache.abf`, `localSettings.json`, credentials
- c) les fichiers de thème JSON
- d) le README du projet

**4. Le rapport d'audit produit par l'agent gradue les constats en…**

- a) Mineur / Majeur / Bloquant
- b) Faible / Moyen / Élevé
- c) CRITIQUE / IMPORTANT / RECOMMANDÉ
- d) Rouge / Orange / Vert

**5. Vrai ou faux : utiliser le MCP élargit vos droits sur le modèle.**

- a) Vrai — l'agent hérite des droits admin de la capacité
- b) Faux — MCP n'élargit pas les droits, mais métadonnées et résultats consultés transitent vers le fournisseur LLM

## Réponses

<details>
<summary>Corrigé — déplier après avoir répondu</summary>

**1. b** — Le MCP ne modifie que le **modèle sémantique** ; la couche rapport relève des Skills (module 05). → [fiche 01](01-mcp-et-vscode.md)

**2. b** — Le LLM peut produire des changements inattendus : la baseline Git est la sauvegarde. → [fiche 02](02-audit-existant.md)

**3. b** — Sécurité des données : jamais de cache, paramètres locaux ni credentials dans le chat (voir [docs/02](../../../docs/02-securite/)). → [README du module](../README.md)

**4. c** — Analyse graduée CRITIQUE / IMPORTANT / RECOMMANDÉ, qui sert ensuite à choisir le niveau de correction. → [fiche 02](02-audit-existant.md)

**5. b** — MCP respecte vos droits ; la vigilance porte sur le transit des métadonnées vers le LLM. → [README du module](../README.md)

</details>

---

**Score indicatif** : 5/5 ou 4/5 → badge en vue, passez aux ateliers. ≤ 3/5 → relire les fiches citées dans le corrigé avant les ateliers. Reportez votre résultat dans le [passeport IA](../../../docs/passeport/).
