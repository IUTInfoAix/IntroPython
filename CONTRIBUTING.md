# Guide de contribution

## 🛠️ Configuration de l'environnement de développement

### Prérequis

- Python 3.8 ou supérieur
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
pip install -r requirements.txt
pre-commit install
```

## 📋 Standards de qualité du code

### Formatage

Nous utilisons **Black** pour le formatage automatique du code Python et des notebooks Jupyter :

```bash
# Formater tout le code (fichiers .py et .ipynb)
make format

# Vérifier le formatage sans modifier
make format-check
```

**Note** : Le formatage fonctionne sur :
- Les fichiers Python (`.py`) avec `black`
- Les notebooks Jupyter (`.ipynb`) avec `nbqa black`

Configuration : voir [pyproject.toml](pyproject.toml)

### Imports

Les imports sont triés automatiquement avec **isort** :

```bash
# Trier les imports
isort .
```

Configuration : voir section `[tool.isort]` dans [pyproject.toml](pyproject.toml)

### Style PEP 8

Nous utilisons **flake8** pour vérifier la conformité PEP 8 des fichiers Python et des notebooks :

```bash
# Vérifier le style (fichiers .py et .ipynb)
make lint
```

**Note** : La vérification s'applique à :
- Les fichiers Python (`.py`) avec `flake8`
- Les notebooks Jupyter (`.ipynb`) avec `nbqa flake8`

Configuration : voir [.flake8](.flake8)

### Analyse statique

**Pylint** est utilisé pour une analyse plus approfondie :

```bash
# Analyser le code
make pylint
```

Configuration : voir [.pylintrc](.pylintrc)

### Type hints (optionnel)

**mypy** peut être utilisé pour vérifier les annotations de types dans les fichiers Python et notebooks :

```bash
# Vérifier les types (fichiers .py et .ipynb)
make mypy
```

**Note** : La vérification de types s'applique également aux notebooks Jupyter avec `nbqa mypy`.

Configuration : voir [mypy.ini](mypy.ini)

### Outils de qualité pour notebooks Jupyter

Tous les outils de qualité du code fonctionnent sur les notebooks Jupyter grâce à **nbqa** :

- `make format` : Formate le code dans les notebooks avec Black et isort
- `make lint` : Vérifie le style PEP 8 dans les notebooks avec flake8
- `make mypy` : Vérifie les types dans les notebooks

**nbqa** extrait automatiquement le code des cellules, applique les outils, puis réintègre les modifications.

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

# Lancer les tests
make test
```

### 3. Commit

Les hooks pre-commit vont automatiquement :
- Formater le code (black, isort)
- Vérifier PEP 8 (flake8)
- Vérifier les types (mypy)

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

Placez vos tests dans le dossier `tests/` :

```python
# tests/test_exemple.py
import pytest

def test_ma_fonction():
    """Test de ma_fonction"""
    assert ma_fonction(2, 3) == 5
```

### Lancer les tests

```bash
# Tous les tests
make test

# Avec couverture
make test-cov

# Un test spécifique
pytest tests/test_exemple.py::test_ma_fonction
```

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
make lint        # Vérifie PEP 8
make test        # Lance les tests
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

Si vous utilisez VS Code, les paramètres sont pré-configurés dans [.vscode/settings.json](.vscode/settings.json).

Extensions recommandées (voir [.vscode/extensions.json](.vscode/extensions.json)) :
- Python (Microsoft)
- Pylance
- Black Formatter
- isort
- Flake8
- Jupyter

## 📚 Structure du projet

```
IntroPython/
├── notebook_seance.ipynb      # Notebook principal
├── slides/                     # Présentation Slidev
│   └── slides.md
├── ressources/                 # Ressources pédagogiques
│   └── cheatsheet.md
├── data/                       # Données pour les exercices
├── tests/                      # Tests unitaires
├── .vscode/                    # Configuration VS Code
├── pyproject.toml             # Configuration Python
├── .flake8                    # Configuration flake8
├── .pylintrc                  # Configuration pylint
├── mypy.ini                   # Configuration mypy
├── .pre-commit-config.yaml    # Configuration pre-commit
├── .editorconfig              # Configuration éditeur
├── Makefile                   # Commandes make
└── requirements.txt           # Dépendances Python
```

## 🤝 Processus de revue

Les Pull Requests doivent :
1. ✅ Passer tous les checks CI/CD
2. ✅ Avoir une couverture de tests ≥ 80%
3. ✅ Être revues par au moins un mainteneur
4. ✅ Respecter les conventions de code
5. ✅ Inclure de la documentation si nécessaire

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
