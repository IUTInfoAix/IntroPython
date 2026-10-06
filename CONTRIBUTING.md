# Guide de contribution

## 🛠️ Configuration de l'environnement de développement

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

## 📋 Standards de qualité du code

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

- **Contraintes d'un notebook de TP** (imports fournis d'avance, fonctions à compléter, lignes d'affichage longues) : `per-file-ignores` sur `*.ipynb` dans [pyproject.toml](pyproject.toml). La règle est alors coupée dans tout le notebook.
- **Contre-exemples pédagogiques** (cellules « ❌ Style classique », set avec doublon, argument par défaut mutable) : `# noqa: CODE` sur la ligne concernée. La règle reste active sur le code que l'étudiant écrit dans le même fichier.

Tel que distribué, le notebook doit passer `make check-all` sans aucune remarque, et `make lint-fix` ne doit rien y modifier. La règle `RUF100` signale tout `# noqa` devenu inutile, par exemple après la modification d'un contre-exemple.

Dans VS Code, les remarques de ruff s'affichent sous le code, dans les cellules. Les corrections automatiques à l'enregistrement sont désactivées (`ruff.fixAll` dans [.devcontainer/source/devcontainer.json](.devcontainer/source/devcontainer.json)) : c'est à l'étudiant de réécrire son code.

## 🔄 Workflow de développement

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

## 🧪 Tests

### Écrire des tests

Les tests vivent dans le notebook, avec `unittest`. Chaque exercice suit le même ordre de cellules : énoncé, code à compléter, tests, solution dans un `<details>`.

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

## 📝 Convention de commits

Nous suivons la convention [Conventional Commits](https://www.conventionalcommits.org/) :

- `feat:` - Nouvelle fonctionnalité
- `fix:` - Correction de bug
- `docs:` - Documentation
- `style:` - Formatage (sans changement de code)
- `refactor:` - Refactoring
- `test:` - Ajout/modification de tests
- `chore:` - Tâches de maintenance

Exemples :
```bash
git commit -m "feat: ajoute exercice sur les générateurs"
git commit -m "fix: corrige erreur dans le notebook"
git commit -m "docs: améliore le README"
```

## 🔧 Outils utiles

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

Extensions recommandées (voir [.vscode/extensions.json](.vscode/extensions.json)) :
- Python (Microsoft)
- Pylance
- Ruff
- Jupyter

## 📚 Structure du projet

```
IntroPython/
├── notebook_seance.ipynb      # Notebook principal (exercices et tests unitaires)
├── README.md                   # Présentation de la séance
├── slides/                     # Présentation Slidev
│   └── slides.md
├── ressources/                 # Ressources pédagogiques
│   ├── cheatsheet.md
│   └── cheatsheet.pdf          # Généré avec pandoc depuis cheatsheet.md
├── .devcontainer/              # Configuration du Codespace
├── .vscode/                    # Extensions VS Code recommandées
├── pyproject.toml             # Configuration de ruff
├── .pre-commit-config.yaml    # Configuration pre-commit
├── .editorconfig              # Configuration éditeur
├── Makefile                   # Commandes make
├── requirements.txt           # Dépendances de la séance (installées dans le Codespace)
└── requirements-dev.txt       # Dépendances pour le travail en local et la maintenance
```

## 🤝 Processus de revue

Les Pull Requests doivent :
1. ✅ Passer `make check-all` et `make test`
2. ✅ Être revues par au moins un mainteneur
3. ✅ Respecter les conventions de code
4. ✅ Inclure de la documentation si nécessaire

## 💡 Conseils

- **Petits commits** : Faites des commits atomiques et fréquents
- **Tests first** : Écrivez les tests avant le code (TDD)
- **Documentation** : Documentez votre code avec des docstrings
- **Lisibilité** : Le code est lu plus souvent qu'il n'est écrit
- **Communication** : N'hésitez pas à poser des questions dans les issues

## 🐛 Signaler un bug

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

## 📞 Contact

Pour toute question, contactez :
- Email : sebastien.nedjar@univ-amu.fr
- Issues GitHub : https://github.com/IUTInfoAix/IntroPython/issues

## 📄 Licence

Ce projet est sous licence Creative Commons BY-SA 4.0.

---

Merci de contribuer à améliorer ce matériel pédagogique ! 🐍
