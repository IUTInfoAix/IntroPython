# Guide de contribution

## Configuration de l'environnement de développement

### Prérequis

- Python 3.15 ou supérieur
- Git
- make (optionnel mais recommandé)

### Installation

```bash
# Cloner le dépôt
git clone https://github.com/IUTInfoAix/IntroPython.git
cd IntroPython

# Créer un environnement virtuel
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate  # Windows

# Installer les dépendances
make install-dev
# ou
pip install -r requirements-dev.txt
pre-commit install
```

## Standards de qualité du code

Un seul outil : **[ruff](https://docs.astral.sh/ruff/)**. Il formate le code, trie les imports et signale les tournures non pythoniques. Il remplace black, isort et flake8, que vous croiserez encore dans d'autres projets. Il lit nativement les notebooks, sans passer par nbqa.

Sa configuration se trouve dans les sections `[tool.ruff]` de [pyproject.toml](pyproject.toml). Chaque famille de règles et chaque exception y est justifiée par un commentaire : faites de même si vous en ajoutez.

Sa version est épinglée (`ruff==0.16.10`) dans [requirements.txt](requirements.txt) et dans [.pre-commit-config.yaml](.pre-commit-config.yaml). D'une version à l'autre, ruff ajoute des règles et retouche son formatage : changez la version aux deux endroits en même temps, puis relancez `make check-all`.

### Formatage

```bash
# Formater le code et trier les imports (fichiers .py et .ipynb)
make format

# Vérifier le formatage sans modifier
make format-check
```

Lignes de 88 caractères, guillemets doubles. Les blocs de code des fichiers Markdown sont exclus du formatage : ceux de la cheat sheet sont compactés à la main, et les slides montrent volontairement du code non pythonique.

### Lint

```bash
# Afficher les remarques de ruff (fichiers .py et .ipynb)
make lint

# Appliquer les corrections sûres
make lint-fix
```

Les règles activées couvrent PEP 8 et les tournures que la séance apprend à remplacer : boucle avec `append` au lieu d'une compréhension, `open()` sans `with`, argument par défaut mutable, nom qui masque une fonction native. Pour lire l'explication d'une règle : `ruff rule PERF401`.

### Outils de qualité pour notebooks Jupyter

Le notebook contient volontairement du code imparfait. Deux mécanismes le rendent compatible avec ruff, à ne pas confondre :

- Les contraintes d'un notebook de TP (imports fournis d'avance, fonctions à compléter, lignes d'affichage longues) passent par `per-file-ignores` sur `*.ipynb` dans [pyproject.toml](pyproject.toml). La règle est alors coupée dans tout le notebook.
- Les contre-exemples pédagogiques (cellules « ❌ Style classique », set avec doublon, argument par défaut mutable) portent un `# noqa: CODE` sur la ligne concernée. La règle reste active sur le code que l'étudiant écrit dans le même fichier.

Tel que distribué, le notebook doit passer `make check-all` sans aucune remarque, et `make lint-fix` ne doit rien y modifier. La règle `RUF100` signale tout `# noqa` devenu inutile, par exemple après la modification d'un contre-exemple.

Dans VS Code, les remarques de ruff s'affichent sous le code, dans les cellules. Les corrections automatiques à l'enregistrement sont désactivées (`ruff.fixAll` dans [.devcontainer/source/devcontainer.json](.devcontainer/source/devcontainer.json)) : c'est à l'étudiant de réécrire son code.

## Workflow de développement

### 1. Créer une branche

```bash
git checkout -b feature/ma-fonctionnalite
# ou
git checkout -b fix/mon-correctif
```

### 2. Développer et tester

```bash
# Écrire du code
vim mon_fichier.py

# Formater automatiquement
make format

# Vérifier la qualité
make check-all

# Exécuter le notebook de bout en bout
make test
```

### 3. Commit

Les hooks pre-commit vont automatiquement :
- Trier les imports et formater le code (ruff)
- Signaler les remarques de ruff, sans les corriger à votre place

```bash
git add .
git commit -m "feat: ajoute fonctionnalité X"
```

### 4. Push et Pull Request

```bash
git push origin feature/ma-fonctionnalite
```

Puis créer une Pull Request sur GitHub.

## Tests

### Écrire des tests

Les tests vivent dans le notebook, avec `unittest`. Un exercice suit toujours le même ordre de cellules : énoncé, code à compléter, tests, solution dans un `<details>`. Les questions les plus courtes (celles sur les inscriptions, le filtre sur les notes) n'ont pas de tests.

```python
class TestMaFonction(unittest.TestCase):
    """Tests unitaires pour ma_fonction"""

    @unittest.skip
    def test_1_cas_simple(self):
        """Test 1 : Cas simple"""
        self.assertEqual(ma_fonction(2, 3), 5)
        print("✅ Test 1 réussi : cas simple")
```

Chaque test porte un `@unittest.skip` que les étudiants retirent progressivement. Vérifiez que chaque solution proposée fait passer tous les tests de son exercice.

### Lancer les tests

```bash
# Exécuter le notebook de bout en bout, tel que distribué
make test
```

Tel que distribué, le notebook ne doit lever aucune exception : les tests sont tous ignorés tant que les `@unittest.skip` sont en place.

## Convention de commits

Les messages de commit suivent la convention [Conventional Commits](https://www.conventionalcommits.org/) :

- `feat:` nouvelle fonctionnalité
- `fix:` correction de bug
- `docs:` documentation
- `style:` formatage (sans changement de code)
- `refactor:` refactoring
- `test:` ajout ou modification de tests
- `chore:` tâches de maintenance

Exemples :
```bash
git commit -m "feat: ajoute exercice sur les générateurs"
git commit -m "fix: corrige erreur dans le notebook"
git commit -m "docs: améliore le README"
```

## Outils utiles

### Makefile

Le [Makefile](Makefile) fournit des raccourcis pour toutes les commandes courantes :

```bash
make help        # Affiche l'aide
make install     # Installe les dépendances
make format      # Formate le code
make lint        # Affiche les remarques de ruff
make lint-fix    # Applique les corrections sûres de ruff
make test        # Exécute le notebook
make check-all   # Vérifie tout
make clean       # Nettoie les fichiers temporaires
```

### Pre-commit hooks

Les hooks pre-commit vérifient automatiquement votre code avant chaque commit :

```bash
# Installer les hooks
pre-commit install

# Lancer manuellement sur tous les fichiers
pre-commit run --all-files
```

Configuration : voir [.pre-commit-config.yaml](.pre-commit-config.yaml)

### VS Code

Si vous utilisez VS Code dans un Codespace ou un dev container, les paramètres sont pré-configurés dans [.devcontainer/source/devcontainer.json](.devcontainer/source/devcontainer.json).

Extensions recommandées (voir [.vscode/extensions.json](.vscode/extensions.json)), les mêmes que dans le Codespace :
- Python (Microsoft)
- Pylance
- Ruff
- Jupyter
- EditorConfig
- GitHub Copilot Chat

## Le conteneur du Codespace

### Deux configurations

Les étudiants créent leur dépôt avec « Use this template » dans leur compte personnel. Les prebuilds Codespaces du dépôt enseignant ne s'appliquent pas à leurs copies : sans précaution, chaque étudiant reconstruirait toute l'image au début de la séance. Le dépôt contient donc deux configurations.

| Configuration | Fichiers | Rôle |
|---|---|---|
| Distribuée | [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) | Celle que Codespaces prend par défaut. Elle télécharge une image déjà construite, publiée sur ghcr.io, désignée par un tag épinglé. |
| Source | [.devcontainer/source/](.devcontainer/source/) | Le Dockerfile, les features, les extensions et les réglages VS Code. Elle sert à fabriquer l'image publiée, et de secours si celle-ci est indisponible (« New with options… » dans GitHub). |

Tout se modifie dans la configuration source. Les extensions, les réglages et l'utilisateur `vscode` sont inscrits dans l'image à la construction : la configuration distribuée ne contient que le nom de l'image.

Conséquence : **un changement de la configuration source ou de [requirements.txt](requirements.txt) n'arrive chez les étudiants qu'après la publication d'une nouvelle image.**

### Reconstruire et tester en local

Il faut Docker et la CLI des dev containers (`npm install -g @devcontainers/cli`).

```bash
# Construire l'image depuis la configuration source, sans cache
devcontainer build --workspace-folder . --config .devcontainer/source/devcontainer.json --no-cache

# Démarrer un conteneur neuf à partir de cette image
devcontainer up --workspace-folder . --config .devcontainer/source/devcontainer.json --remove-existing-container

# Lancer le smoke-test dans le conteneur
devcontainer exec --workspace-folder . --config .devcontainer/source/devcontainer.json .devcontainer/smoke-test.sh
```

Pour tester la configuration distribuée, c'est-à-dire l'image publiée telle qu'un étudiant la reçoit, retirez l'option `--config` des deux dernières commandes.

Le smoke-test ([.devcontainer/smoke-test.sh](.devcontainer/smoke-test.sh)) vérifie qu'un étudiant peut travailler :

- le conteneur tourne avec l'utilisateur `vscode` ;
- Python 3.15 est le seul interpréteur (voir « Noyau présélectionné » plus bas) ;
- le noyau Jupyter est installé ;
- les paquets de l'image satisfont `requirements.txt` ;
- `make lint` et `make format-check` passent ;
- le notebook s'exécute de bout en bout.

Dans VS Code, la commande **Dev Containers: Rebuild Container** reconstruit le conteneur, mais ne lance pas le smoke-test.

### Vérification continue

Le workflow [devcontainer.yml](.github/workflows/devcontainer.yml) lance le smoke-test sur les deux configurations : à chaque push ou PR qui touche le conteneur, le notebook, le Makefile ou la configuration de ruff, chaque lundi, et à la main. L'image distribuée y est téléchargée sans authentification, comme chez un étudiant : le job échoue si le paquet a disparu ou n'est plus public.

**Lancez-le à la main la veille d'une séance** (onglet Actions, workflow `devcontainer`, **Run workflow**).

Les workflows portent la garde `if: github.repository == 'IUTInfoAix/IntroPython'` : « Use this template » copie le dossier `.github/` chez chaque étudiant, et aucun job ne doit tourner dans ces copies. Le workflow y apparaît quand même dans l'onglet Actions, avec des exécutions ignorées qui ne consomment aucune minute. Pour la même raison, n'ajoutez ni dependabot ni autre automatisation planifiée.

### Publier une nouvelle image

À faire quand `requirements.txt` ou un fichier de `.devcontainer/source/` change.

1. Choisissez une version au format `AAAA.MM.N`, par exemple `2026.11.1`. Jamais `latest`, et jamais une version déjà publiée : les copies étudiantes existantes pointent dessus.
2. Mettez cette version dans [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) et commitez sur une branche.
3. Publiez l'image depuis cette branche en poussant un tag git :
   ```bash
   git tag devcontainer-2026.11.1
   git push origin devcontainer-2026.11.1
   ```
   Le workflow [devcontainer-publish.yml](.github/workflows/devcontainer-publish.yml) construit l'image, lance le smoke-test et ne publie que s'il réussit.
4. Relancez le workflow `devcontainer` sur la branche : ses deux jobs doivent passer.
5. Fusionnez dans `main`.

L'ordre compte : si la nouvelle version arrive sur `main` avant d'être publiée, les codespaces créés depuis le template échouent.

**À la première publication seulement**, le paquet est créé privé. Rendez-le public avant l'étape 4 : page du paquet `intropython-devcontainer` dans l'organisation, **Package settings**, **Change visibility**. Vérifiez ensuite le téléchargement anonyme :

```bash
docker logout ghcr.io
docker pull ghcr.io/iutinfoaix/intropython-devcontainer:2026.10.1
```

Une fois le workflow présent sur `main`, la publication peut aussi se lancer depuis l'onglet Actions (workflow `devcontainer-publish`, **Run workflow**, en saisissant la version).

Les copies étudiantes déjà créées gardent la version qu'elles référencent : une nouvelle image ne profite qu'aux dépôts créés ensuite.

L'image n'est construite que pour l'architecture amd64, celle de Codespaces. Sur un Mac Apple Silicon, utilisez la configuration source.

### Choix à connaître avant de modifier le conteneur

**Noyau présélectionné.** VS Code ne présélectionne un noyau à l'ouverture d'un notebook que s'il n'en trouve qu'un seul. C'est pourquoi l'image part de la variante `slim` de l'image Python : l'image complète embarque aussi le Python 3.13 de Debian (`/usr/bin/python3`). Un paquet Debian ou une feature qui installerait un second Python ferait réapparaître la question « Sélectionner un noyau » : le smoke-test échoue dans ce cas.

**Image de base épinglée.** Le Dockerfile fixe la version mineure de Python et la version de Debian, jamais un tag plus large comme `3` ou `slim`. Tant que Python 3.15 n'est pas sorti, il désigne une préversion précise. À la sortie de Python 3.15.0, remplacez `3.15.0rc3-slim-trixie` par `3.15-slim-trixie`, qui ne suivra que les correctifs de la série 3.15.

**Extension Jupyter épinglée.** `ms-toolsai.jupyter@2025.7.0` est figée depuis le 8 octobre 2025. La version 2025.9.0, sortie la veille, exige VS Code 1.105 ou plus, ce qui la rendait vraisemblablement inutilisable dans Codespaces à ce moment-là. Pour lever l'épinglage : dans un vrai codespace, installez la version courante de l'extension, ouvrez `notebook_seance.ipynb`, vérifiez que le noyau est présélectionné et qu'une cellule s'exécute. Si c'est le cas, retirez `@2025.7.0` de la configuration source et publiez une nouvelle image.

**Copilot en tuteur.** [.github/copilot-instructions.md](.github/copilot-instructions.md) cadre les réponses de Copilot Chat : explication du concept, puis documentation, puis un minimum de code, sans jamais réciter les solutions repliées du notebook. Ce fichier est adapté de celui des TP de R2.02 et R2.03 ; « Use this template » le copie chez chaque étudiant. [AGENTS.md](AGENTS.md) donne les mêmes consignes aux autres assistants (Codex, Cursor…). Seul leur en-tête diffère. Le bloc délimité par les marqueurs `TDD-PLAYBOOK` doit rester identique dans les deux fichiers : un hook pre-commit refuse le commit s'il diffère. Les sections qui le précèdent (commandes, structure du projet) ne sont pas contrôlées : reportez-y vos modifications à la main. L'extension Copilot Chat et le réglage qui coupe les complétions automatiques (`github.copilot.enable`) sont dans la configuration source : les modifier demande de publier une nouvelle image.

**Rien ne s'installe au démarrage.** Les dépendances sont installées par le Dockerfile, pas par une commande de cycle de vie (`onCreateCommand`, `postCreateCommand`) qui serait rejouée à chaque création de codespace.

### Mesures

Dans un vrai codespace, créé depuis une copie du template dans un compte personnel, la création prend moins d'une minute et le notebook est utilisable aussitôt : le noyau Python 3.15 est présélectionné, et Copilot ne propose aucune complétion pendant la frappe (essai d'octobre 2026, avec l'image `2026.10.2`).

Le tableau ci-dessous compare les configurations entre elles. Il mesure la création à froid d'un conteneur avec la CLI `devcontainer`, sur un poste de 16 cœurs, dans un démon Docker vide (octobre 2026). L'installation des extensions VS Code n'y est pas comptée, et ces durées ne sont pas celles d'un codespace.

| Configuration | Durée | Taille de l'image |
|---|---|---|
| Avant la refonte (`python:3.15.0rc3`, features Node et common-utils, `pip install` au démarrage) | 193,5 s | 2,38 Go |
| Source (construction sur place) | 111,6 s | 781 Mo |
| Distribuée (image tirée d'un registre local, donc hors téléchargement réseau) | 17,8 s | 190 Mo compressés |

## Structure du projet

```
IntroPython/
├── notebook_seance.ipynb      # Notebook principal (exercices et tests unitaires)
├── README.md                   # Présentation de la séance
├── slides/                     # Présentation Slidev
│   └── slides.md
├── ressources/                 # Ressources pédagogiques
│   ├── cheatsheet.md
│   └── cheatsheet.pdf          # Généré avec pandoc depuis cheatsheet.md
├── AGENTS.md                   # Consignes de tuteur pour les assistants IA autres que Copilot
├── .devcontainer/              # Configuration du Codespace (image distribuée, source, smoke-test)
├── .github/
│   ├── copilot-instructions.md # Consignes de tuteur pour Copilot Chat
│   └── workflows/              # Vérification et publication de l'image du Codespace
├── .vscode/                    # Extensions VS Code recommandées
├── pyproject.toml             # Configuration de ruff
├── .pre-commit-config.yaml    # Configuration pre-commit
├── .editorconfig              # Configuration éditeur
├── Makefile                   # Commandes make
├── requirements.txt           # Dépendances de la séance (installées dans le Codespace)
└── requirements-dev.txt       # Dépendances pour le travail en local et la maintenance
```

## Processus de revue

Les Pull Requests doivent :
1. Passer `make check-all` et `make test`
2. Être revues par au moins un mainteneur
3. Respecter les conventions de code
4. Inclure de la documentation si nécessaire

## Conseils

- Faites des commits atomiques et fréquents
- Écrivez les tests avant le code (TDD)
- Documentez votre code avec des docstrings
- Soignez la lisibilité : le code est lu plus souvent qu'il n'est écrit
- Posez vos questions dans les issues

## Signaler un bug

Utilisez les [GitHub Issues](https://github.com/IUTInfoAix/IntroPython/issues) avec le template suivant :

```markdown
## Description
[Description claire du bug]

## Étapes pour reproduire
1. [Première étape]
2. [Deuxième étape]
3. ...

## Comportement attendu
[Ce qui devrait se passer]

## Comportement actuel
[Ce qui se passe réellement]

## Environnement
- OS : [Linux/macOS/Windows]
- Python : [version]
- Version du projet : [commit hash ou tag]
```

## Contact

Pour toute question, contactez :
- Email : sebastien.nedjar@univ-amu.fr
- Issues GitHub : https://github.com/IUTInfoAix/IntroPython/issues

## Licence

Ce projet est sous licence Creative Commons BY-SA 4.0.

---

Merci de contribuer à améliorer ce matériel pédagogique !
