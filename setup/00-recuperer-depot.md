# Setup 00 — Récupérer le dépôt

Clonage de la copie client du dépôt sur le poste. À faire une fois par poste, **avant les autres guides setup** (~5 minutes).

## 1. Prérequis

- Invitation GitHub à la copie client du dépôt, envoyée par le formateur ou l'IT — à accepter avant de continuer
- Git installé ([git-scm.com](https://git-scm.com)) ; sinon, alternative ZIP de la section 3

## 2. Cloner (recommandé)

```powershell
New-Item -ItemType Directory -Force C:\dev
git clone https://github.com/<organisation>/client-xyz.git C:\dev\genai-powerbi-fabric
```

> **Pourquoi ce chemin exact** : les 3 projets PBIP (`altisport-v1`, `altisport-v2`, `altisport-rapport-legacy`) lisent leurs CSV via le paramètre Power Query `DossierData`, dont la valeur par défaut est `C:\dev\genai-powerbi-fabric\assets\data\brut` ([guide des modèles](../assets/modeles/guide-modeles.md)). Cloné à cet emplacement, chaque modèle s'ouvre sans aucune configuration ; ailleurs, il faut adapter `DossierData` dans chaque modèle.

## 3. Alternative sans git (profils non-dev, modules 01-03)

1. Sur la page GitHub du dépôt : bouton **Code > Download ZIP**
2. Extraire, puis **renommer** le dossier extrait (`client-xyz-main`) en `C:\dev\genai-powerbi-fabric`

> Limite : pas de `git pull` pour récupérer les mises à jour du dépôt en cours de formation. Les modules 04 et 05 exigent de toute façon VS Code et la CLI — le clonage reste préférable pour ces profils.

## 4. Vérifier

Ouvrir `assets/modeles/altisport-v2/altisport-v2.pbip` dans Power BI Desktop (prérequis : [setup/01](01-powerbi-desktop.md)) : les 6 tables se chargent sans erreur.

En cas d'échec : vérifier le chemin des CSV — `Transformer les données > Gérer les paramètres > DossierData` (voir [guide des modèles](../assets/modeles/guide-modeles.md)).

## 5. Mettre à jour en cours de formation

Si le formateur annonce une mise à jour du dépôt :

```powershell
git pull
```

(Équivalent ZIP : re-télécharger et re-extraire.)

## 6. Devenir indépendant du dépôt d'origine

Git est **décentralisé** : dès qu'ils ont cloné, les participants possèdent une copie complète (historique, branches) et n'ont plus besoin du dépôt d'origine. Ce dépôt n'utilise **aucun submodule ni LFS**, donc aucune dépendance cachée. Pour basculer vers un nouveau repo :

```powershell
git remote set-url origin <url-du-nouveau-repo>
git push -u origin --all
git push --tags
```

## Checklist finale

- [ ] Dépôt présent dans `C:\dev\genai-powerbi-fabric`
- [ ] `assets/modeles/altisport-v2/altisport-v2.pbip` s'ouvre et charge les 6 tables
