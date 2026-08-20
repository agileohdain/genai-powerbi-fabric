# Quiz — Module 06 · Gouvernance & CUs

> À passer en fin de phase 1. 5 questions, ~10 min, sans notation : l'objectif est d'ancrer les acquis avant les ateliers. Les réponses sont pliées en bas de page.

## Questions

**1. Parmi les 4 leviers IA de la formation, lesquels consomment des CUs pour leur génération ?**

- a) Tous : Copilot, Data Agents, MCP, Skills
- b) Copilot et Data Agents uniquement — MCP et Skills génèrent en local (0 CU, coût côté abonnement GitHub Copilot)
- c) MCP et Skills uniquement
- d) Aucun : la génération IA est incluse dans la licence

**2. Les 4 paliers de throttling, dans l'ordre croissant de gravité :**

- a) rejet total → rejet interactif → délai 20 s → protection 10 min
- b) protection 10 min → délai 20 s → rejet interactif → rejet total
- c) avertissement → ralentissement → facturation majorée → coupure
- d) délai 20 s → protection 10 min → rejet interactif → rejet total

**3. La Metrics App montre un pic de consommation lissé sur 24 h. Est-ce un problème ?**

- a) Oui — tout pic doit déclencher une alerte
- b) Non — un pic n'est pas un problème : les opérations IA sont en background, lissées sur 24 h ; on ne parle de throttling que si les bornes des paliers sont franchies

**4. À quoi sert une Fabric Copilot capacity (FCC) ?**

- a) à accélérer les réponses de Copilot
- b) à regrouper la facturation et le pilotage de la consommation Copilot (dont utilisateurs Pro/PPU) de façon centralisée
- c) à réserver des CUs exclusivement aux data agents
- d) à désactiver Copilot pour certains utilisateurs

**5. La bonne posture de gouvernance face à la consommation IA est…**

- a) désactiver Copilot « par précaution » jusqu'à la fin de l'audit
- b) mesurer puis réguler : tenant settings par groupe, FCC, seuils d'alerte, adoption incrémentale
- c) ignorer la consommation : elle est toujours négligeable

## Réponses

<details>
<summary>Corrigé — déplier après avoir répondu</summary>

**1. b** — Seuls Copilot et Data Agents consomment des CUs pour la génération ; MCP et Skills sont 0 CU (coût d'infrastructure dev). → [fiche 02](02-consommation-features-ia.md)

**2. b** — Protection 10 min → délai 20 s → rejet interactif → rejet total : les détecter et savoir les lever fait partie du module. → [fiche 01](01-capacites-et-throttling.md)

**3. b** — « Un pic n'est pas un problème » : le lissage 24 h protège ; seules les courbes franchissant les bornes des paliers throttlent. → [fiche 01](01-capacites-et-throttling.md)

**4. b** — La FCC est un groupement de facturation : consommation Copilot centralisée et pilotable, y compris pour Pro/PPU/Desktop. → [fiche 03](03-gouvernance-et-alertes.md)

**5. b** — Gouvernance ≠ blocage : mesurer, alerter, réguler — pas désactiver par précaution. → [fiche 03](03-gouvernance-et-alertes.md)

</details>

---

**Score indicatif** : 5/5 ou 4/5 → passez aux ateliers. ≤ 3/5 → relire les fiches citées dans le corrigé avant les ateliers.
