# Quiz — Module 02 · Copilot dans Power BI

> À passer en fin de phase 1. 5 questions, ~10 min, sans notation : l'objectif est d'ancrer les acquis avant les ateliers. Les réponses sont pliées en bas de page.

## Questions

**1. Quand vous posez une question de données, Copilot résout dans cet ordre :**

- a) connaissances générales du LLM → visuels du rapport → modèle sémantique
- b) visuels du rapport ouvert → modèle sémantique → connaissances générales du LLM
- c) modèle sémantique → visuels du rapport → connaissances générales du LLM
- d) il interroge toujours le modèle sémantique en premier

**2. Vrai ou faux : le volet Copilot tient compte des segments et filtres appliqués à la page du rapport.**

- a) Vrai — le contexte visuel est automatiquement transmis
- b) Faux — le volet n'hérite pas des filtres : il faut les préciser dans le prompt (`in 2025`, `excluding cancelled orders`…)

**3. `units in Australia` filtre sur `Customer[Country]` au lieu de `Sales region[Country]`. Pourquoi, et que faire ?**

- a) Bug produit à signaler ; attendre un correctif
- b) Colonnes homonymes entre tables : renommer/masquer la colonne ambiguë (module 01) ou préciser la table dans le prompt
- c) La question était en français : la repasser en anglais
- d) Le modèle n'a pas de table de dates marquée

**4. Vous reposez la même question et obtenez la même réponse alors que vous avez corrigé le modèle. Pourquoi ?**

- a) Le modèle ne s'est pas actualisé — relancer l'actualisation
- b) Le même prompt sur un modèle inchangé peut être servi depuis un cache pendant 24 h : effacer la conversation (clear chat) ou reformuler

**5. Peut-on activer Copilot uniquement pour les résumés par e-mail, sans ouvrir les autres expériences ?**

- a) Oui — chaque expérience s'active séparément
- b) Non — le réglage couvre tous les workloads d'un coup

## Réponses

<details>
<summary>Corrigé — déplier après avoir répondu</summary>

**1. b** — Visuels d'abord, puis construction d'un visuel depuis le modèle sémantique, et connaissances générales seulement pour les questions hors données (à détecter). → [fiche 03](03-questions-de-donnees.md)

**2. b** — Piège documenté : une réponse peut différer du contexte visuel de la page. → [fiche 03](03-questions-de-donnees.md)

**3. b** — Exemple Microsoft : les colonnes homonymes créent l'ambiguïté ; la préparation (module 01) ou un prompt précis la lève. → [fiche 03](03-questions-de-donnees.md)

**4. b** — Cache de 24 h documenté : clear chat ou reformulation. → [README du module](../README.md)

**5. b** — Impossible d'activer Copilot expérience par expérience : le réglage est global. → [README du module](../README.md)

</details>

---

**Score indicatif** : 5/5 ou 4/5 → badge en vue, passez aux ateliers. ≤ 3/5 → relire les fiches citées dans le corrigé avant les ateliers. Reportez votre résultat dans le [passeport IA](../../../docs/passeport/).
