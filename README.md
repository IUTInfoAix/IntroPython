<img src="https://github.com/IUTInfoAix/Syllabus/blob/main/logo.png?raw=true" alt="class logo" class="logo"/>

# Python pour Informaticiens

## IUT d'Aix-Marseille, Département Informatique Aix-en-Provence
- **Responsables :**
  - [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr)
- **Besoin d'aide ?**
  - Consulter et/ou créer des [issues](https://github.com/IUTInfoAix/IntroPython/issues).
  - [Email](mailto:sebastien.nedjar@univ-amu.fr) pour une question d'ordre privée, ou pour convenir d'un rendez-vous physique.

# Séance pratique d'introduction (4 heures)

## Vue d'ensemble

Cette séance fait découvrir la façon Python de programmer aux étudiants de BUT Informatique. La syntaxe de base est supposée connue : on y apprend à écrire du code **pythonique**, c'est-à-dire idiomatique et lisible.

### Objectifs pédagogiques

À l'issue de cette séance, les étudiants doivent être capables de :

- Choisir la structure de données appropriée (list, dict, set, tuple)
- Mesurer les performances d'un code avec `timeit`
- Expliquer les références et la mutabilité, et éviter leurs pièges
- Utiliser les idiomes Python (comprehensions, EAFP, context managers)
- Transformer du code « traduit de C++ ou Java » en code pythonique
- Exploiter les outils natifs de Python plutôt que réinventer la roue
- Lire et comprendre du code Python professionnel

## Création de votre dépôt de TP

Commencez par créer votre copie du dépôt du TP, dans votre compte GitHub personnel :

1. Rendez-vous sur le dépôt <https://github.com/IUTInfoAix/IntroPython>
2. Cliquez sur le bouton vert **Use this template**, puis sur **Create a new repository**
3. Dans **Owner**, choisissez votre compte personnel et gardez `IntroPython` comme nom de dépôt
4. Cliquez sur **Create repository**

GitHub crée un dépôt `votreUsername/IntroPython` qui contient une copie du TP. Ce dépôt vous appartient : vous pouvez y pousser votre travail librement.

## Ouverture de GitHub Codespace

Une fois votre dépôt créé, ouvrez-le dans GitHub Codespace :

1. Rendez-vous sur votre dépôt GitHub (`votreUsername/IntroPython`)
2. Cliquez sur le bouton vert **Code**
3. Sélectionnez l'onglet **Codespaces**
4. Cliquez sur **Create codespace on main**

GitHub télécharge un environnement déjà prêt (environ 190 Mo), puis installe les extensions de VS Code. Vous n'avez rien à installer vous-même. Vous obtenez VS Code dans votre navigateur avec :
- Python 3.15, le noyau Jupyter qui exécute les cellules du notebook, et ruff
- Les extensions Python, Jupyter et Ruff déjà configurées
- Un terminal

Pour ouvrir le notebook de TP :
- Dans l'explorateur de fichiers (à gauche), cliquez sur le fichier `notebook_seance.ipynb`
- Le noyau Python 3.15 est normalement déjà sélectionné : son nom s'affiche en haut à droite du notebook, et vous pouvez exécuter les cellules tout de suite
- Si VS Code affiche **Sélectionner un noyau** à la place, cliquez dessus, choisissez **Environnements Python**, puis Python 3.15

### Si la création du codespace échoue

Si VS Code s'ouvre avec un message parlant de *recovery mode*, l'environnement n'a pas pu être téléchargé. Vous pouvez le faire reconstruire sur place :

1. Retournez sur la page de votre dépôt et supprimez ce codespace (bouton **Code**, onglet **Codespaces**, menu **…** du codespace, **Delete**)
2. Dans le même onglet, ouvrez le menu **…** à côté du bouton **+**, puis choisissez **New with options…**
3. Dans **Dev container configuration**, sélectionnez **IntroPython (construction sur place, secours)**
4. Cliquez sur **Create codespace**

La création est alors plus longue, car tout l'environnement est reconstruit. Prévenez votre enseignant : c'est le signe d'un problème à corriger pour tout le groupe.

### Quota gratuit

Un compte GitHub personnel gratuit dispose chaque mois de 120 heures de calcul et de 15 Go de stockage pour Codespaces. Les heures sont comptées selon la machine choisie : sur une machine à 2 cœurs, largement suffisante pour cette séance, une heure d'utilisation en consomme 2, ce qui laisse **60 heures par mois**. Sur une machine à 4 cœurs, il n'en reste que 30. Les chiffres à jour sont dans la [documentation de GitHub](https://docs.github.com/fr/billing/concepts/product-billing/github-codespaces).

Pensez à arrêter votre codespace quand vous avez terminé (bouton **Code**, onglet **Codespaces**, menu **…**, **Stop codespace**) : un codespace arrêté ne consomme plus d'heures, et votre travail y est conservé.

## Installation et prérequis (alternative locale)

### Prérequis

- **Python 3.15+** installé sur votre machine
- Un éditeur de code (VS Code, PyCharm, ou autre)
- *Optionnel* : Jupyter Notebook ou JupyterLab

### Installation des dépendances

```bash
# Cloner le dépôt (ou télécharger les fichiers)
git clone https://github.com/IUTInfoAix/IntroPython.git
cd IntroPython

# Créer un environnement virtuel (recommandé)
python3 -m venv ~/venv

# Activer l'environnement virtuel
source ~/venv/bin/activate

# Installer les dépendances
pip install -r requirements-dev.txt
```

### Les deux fichiers de dépendances

- [requirements.txt](requirements.txt) : le nécessaire pour faire la séance dans VS Code, c'est-à-dire le noyau Jupyter (`ipykernel`) et `ruff`. C'est tout ce que le Codespace installe.
- [requirements-dev.txt](requirements-dev.txt) : le même contenu, plus ce qui sert en local (`jupyterlab` pour `make notebook`, `nbconvert` pour `make test`) et à la maintenance du dépôt (`pre-commit`).

### Utilisation du Makefile

Le Makefile du projet regroupe les commandes courantes :

```bash
# Afficher toutes les commandes disponibles
make help
```

**Commandes principales** :

```bash
# Lancer Jupyter Lab (pour ouvrir le notebook de TP)
make notebook

# Lancer la présentation Slidev (nécessite Node.js)
make slides

# Formater automatiquement votre code et trier les imports
make format

# Afficher les remarques de ruff : PEP 8 et tournures non pythoniques
make lint

# Appliquer les corrections que ruff sait faire sans risque
make lint-fix

# Vérifier le formatage + linting (sans modifier les fichiers)
make check-all

# Nettoyer les fichiers temporaires
make clean
```

**Pour les étudiants** : `make format` et `make lint` s'appuient sur [ruff](https://docs.astral.sh/ruff/), le formateur et linter du projet. Dans le Codespace, ses remarques s'affichent aussi sous votre code, dans les cellules du notebook. Chacune porte un code (par exemple `PERF401`) et propose une tournure plus pythonique : essayez de réécrire vous-même avant de recourir à `make lint-fix`.

Quelques lignes du notebook se terminent par `# noqa: CODE` : ce sont des contre-exemples volontaires (les « ❌ Style classique »), sur lesquels ruff a reçu la consigne de se taire. N'en ajoutez pas dans votre propre code. Si vous corrigez l'une de ces lignes, ruff vous signale que le `# noqa` ne sert plus (`RUF100`) : supprimez-le.

### Lancer les slides de présentation

Les slides sont au format Slidev :

```bash
# Lancer la présentation Slidev (nécessite Node.js)
make slides

# Ou directement avec npx
cd slides
npx slidev slides.md
```

La présentation s'ouvre dans votre navigateur à l'adresse `http://localhost:3030`.

**Note** : sans Node.js, vous pouvez lire les slides directement dans le fichier `slides/slides.md`.

## Structure de la séance

### Durée : 4 heures

| Horaire | Partie | Durée | Contenu |
|---------|--------|-------|---------|
| 00:00 | Mise en route | 20 min | Création du dépôt, Codespace, Zen de Python, échauffement |
| 00:20 | **Partie 1** | 65 min | Structures de données natives, mesure de performances, mutabilité |
| 01:25 | **Partie 2** | 55 min | Compréhensions, EAFP, context managers |
| 02:20 | Pause | 15 min | |
| 02:35 | **Partie 3** | 45 min | Refactoring de l'analyseur CSV |
| 03:20 | **Partie 4** | 30 min | Exercices pilotés par les tests |
| 03:50 | Conclusion | 10 min | Bilan et défi Exercism |

La partie 4 sert de marge : le détecteur de palindromes est pour tout le monde, le compresseur RLE et le validateur de mots de passe sont des bonus, à finir chez vous.

---

## Comment utiliser ce matériel

### Pour les étudiants

1. **Pendant la séance** :
   - Ouvrir le notebook Jupyter
   - Exécuter et modifier les exemples
   - Poser des questions
   - Travailler en binôme sur les exercices

2. **Après la séance** :
   - Refaire les exercices à tête reposée
   - Consulter le cheat sheet régulièrement
   - Relever le défi Exercism présenté ci-dessous
   - Explorer les ressources recommandées

---

## Pour les enseignants

### Intention pédagogique

La séance présente Python comme l'outil d'un informaticien professionnel, à rebours de sa réputation de « langage pour débutants ». Les étudiants doivent en retenir que Python est un langage de production, très utilisé dans l'industrie, et qu'on ne le maîtrise pas sans comprendre les concepts informatiques sous-jacents.

Elle relie leurs connaissances théoriques en algorithmique et en programmation à l'usage concret de Python : le langage applique certains des paradigmes qu'ils étudient par ailleurs, et en remet d'autres en question. Sa syntaxe est simple, mais elle cache des concepts qu'il faut comprendre, en informaticien, pour bien s'en servir.

### Approche pédagogique

La séance repose sur une pédagogie active. Chaque notion est comparée aux langages que les étudiants pratiqueront (C/C++, Java), puis suivie d'un exercice court qui la vérifie. Les exercices sont posés comme des problèmes d'optimisation ou de refactoring, et tous les exemples viennent de cas d'usage réels qu'ils rencontreront probablement un jour.

L'évaluation est formative : l'enseignant observe les solutions proposées aux exercices, écoute les questions et les discussions, puis ajuste le rythme et le niveau d'approfondissement pendant la séance.

---

## Défi : devenez un Pythonista en 10 semaines !

### Mission jusqu'au début du semestre 2

**Résolvez 1 exercice [Exercism](https://exercism.org/tracks/python) par semaine.**

#### Ce que vous y gagnez

Pour progresser en programmation, la régularité bat l'intensité. À ce rythme, les réflexes pythoniques s'installent et les bonnes pratiques deviennent automatiques. Vous apprenez aussi des solutions de la communauté, vous recevez ses retours, et vous suivez votre évolution avec les badges et votre profil public Exercism.

#### Les règles du jeu

1. S'inscrire sur Exercism : [exercism.org/tracks/python](https://exercism.org/tracks/python)
2. Résoudre 1 exercice par semaine pendant 10 semaines (jusqu'au début du semestre 2)
3. Appliquer les idiomes Python appris pendant la séance
4. Demander un retour aux mentors Exercism après chaque exercice
5. Partager vos solutions avec vos camarades pour échanger des astuces
6. Montrer votre progression : profil public, badges collectés

#### Exercices recommandés pour débuter

Les exercices Exercism sont classés par difficulté. Une progression possible :

1. Hello World : prise en main
2. Two Fer : fonctions et paramètres par défaut
3. Raindrops : conditions et modulos
4. Leap : logique booléenne
5. Pangram : sets et manipulation de chaînes
6. Isogram : algorithmes sur les chaînes
7. Scrabble Score : dictionnaires
8. Word Count : collections et parsing
9. Run Length Encoding : algorithmes de compression
10. Robot Simulator : POO et états

#### Conseils pour réussir

- Bloquez 30 à 60 minutes par semaine dans votre agenda
- Soumettez une première solution, puis améliorez-la avec les retours reçus
- Lisez les solutions des autres après avoir terminé
- Créez un groupe de discussion avec vos camarades

_"The only way to learn a new programming language is by writing programs in it."_ (Brian Kernighan et Dennis Ritchie, _The C Programming Language_)

---

## Ressources complémentaires

### Documentation officielle
- [Python.org - Tutorial](https://docs.python.org/3/tutorial/)
- [PEP 8 - Style Guide](https://pep8.org/)
- [Python Standard Library](https://docs.python.org/3/library/)

### Tutoriels et cours
- [Real Python](https://realpython.com/) : tutoriels
- [Python Tricks](https://realpython.com/products/python-tricks-book/) : livre d'idiomes
- [Fluent Python](https://www.oreilly.com/library/view/fluent-python-2nd/9781492056348/) : livre avancé

### Pratique
- [Exercism - Python Track](https://exercism.org/tracks/python)
- [LeetCode](https://leetcode.com/) : problèmes algorithmiques
- [CodinGame](https://www.codingame.com/) : apprendre en jouant
- [Python Koans](https://github.com/gregmalcolm/python_koans) : apprentissage par TDD

### Bibliothèques par domaine

**Calcul scientifique et data science** :
- [NumPy](https://numpy.org/) : calcul numérique
- [Pandas](https://pandas.pydata.org/) : manipulation de données
- [Matplotlib](https://matplotlib.org/) : visualisation
- [SciPy](https://scipy.org/) : algorithmes scientifiques
- [Scikit-learn](https://scikit-learn.org/) : machine learning

**Développement web** :
- [Flask](https://flask.palletsprojects.com/) : micro-framework
- [Django](https://www.djangoproject.com/) : framework complet
- [FastAPI](https://fastapi.tiangolo.com/) : API modernes

**Automatisation et scripts** :
- [Requests](https://requests.readthedocs.io/) : requêtes HTTP
- [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) : web scraping
- [Click](https://click.palletsprojects.com/) : interfaces en ligne de commande

**Tests et qualité** :
- [pytest](https://pytest.org/) : framework de tests
- [ruff](https://docs.astral.sh/ruff/) : formatage, tri des imports et analyse statique. C'est l'outil de ce projet
- [black](https://black.readthedocs.io/), [isort](https://pycqa.github.io/isort/) et [flake8](https://flake8.pycqa.org/) : les trois outils que ruff remplace, encore présents dans beaucoup de projets
- [mypy](http://mypy-lang.org/) : vérification des types

**Python embarqué** :
- [MicroPython](https://micropython.org/) : Python pour microcontrôleurs
- [CircuitPython](https://circuitpython.org/) : variante maintenue par Adafruit
- [Documentation STeaMi](https://www.steami.cc/) : pour vos cartes

---

## Outils recommandés

### Éditeurs et IDE

- **VS Code** + extensions Python
  - Python (Microsoft)
  - Pylance
  - Ruff (Astral)
  - autoDocstring (Python Docstring Generator)

- **PyCharm** (Community ou Professional)
  - IDE complet avec débogueur intégré
  - Outils de refactoring
  - Support Django/Flask

- **Jupyter Lab**
  - Pour l'exploration interactive
  - Notebooks intégrés

### Outils en ligne de commande

```bash
# Ruff : l'outil de ce projet (déjà installé dans le Codespace)
pip install ruff

# Formater automatiquement
ruff format mon_fichier.py

# Vérifier le style PEP 8 et repérer les tournures non pythoniques
ruff check mon_fichier.py

# Appliquer les corrections sûres
ruff check --fix mon_fichier.py

# Lire l'explication d'une règle à partir de son code
ruff rule PERF401
```

Ruff remplace à lui seul trois outils que vous croiserez encore dans beaucoup de projets : **black** (formatage), **isort** (tri des imports) et **flake8** (style PEP 8). Ils s'utilisent de la même façon, par exemple `black mon_fichier.py`. Ruff ne vérifie pas les annotations de types : pour cela, l'outil de référence reste **mypy**, qui n'est pas utilisé dans ce projet.

### Configuration recommandée (`.vscode/settings.json`)

```json
{
  "[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "charliermarsh.ruff"
  },
  "notebook.formatOnSave.enabled": true,
  "ruff.fixAll": false,
  "editor.rulers": [88],
  "editor.insertSpaces": true,
  "editor.tabSize": 4,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "jupyter.askForKernelRestart": false
}
```

Ces réglages demandent l'extension **Ruff** (`charliermarsh.ruff`). Dans le Codespace, elle est déjà installée et configurée. Le code est formaté à chaque enregistrement, y compris dans les cellules du notebook. Les corrections automatiques à l'enregistrement sont volontairement désactivées (`ruff.fixAll`) : ruff vous montre la tournure à reprendre, à vous de la réécrire.

---

## FAQ

### Q : J'ai déjà fait du Python, cette séance m'apprendra quelque chose ?

**R :** Oui. Cette séance ne porte pas sur la syntaxe de base mais sur les idiomes pythoniques. Même les développeurs expérimentés y découvrent souvent des façons d'écrire du code plus élégant et plus efficace.

### Q : Pourquoi pas de pandas/requests/autres bibliothèques populaires ?

**R :** Cette séance se concentre sur les fondamentaux du langage et la bibliothèque standard. Les bibliothèques tierces seront vues dans d'autres cours spécialisés (data science, web, etc.).

### Q : Le code « pythonique » est-il vraiment plus rapide ?

**R :** Souvent oui (list comprehensions, fonctions built-in optimisées en C), mais le principal avantage est la lisibilité et la maintenabilité. "Premature optimization is the root of all evil." (Donald Knuth, 1974)

### Q : Dois-je toujours suivre PEP 8 strictement ?

**R :** PEP 8 est un guide, pas une loi. L'important est la cohérence dans un projet. Cela dit, la plupart des projets Python professionnels suivent PEP 8.

### Q : Quand utiliser une list comprehension vs une boucle normale ?

**R :** Si la comprehension tient sur 1 ou 2 lignes et reste lisible, utilisez-la. Sinon, préférez une boucle explicite avec un bon nom de variable.

### Q : Python est lent, pourquoi l'utiliser ?

**R :** Python est lent pour du calcul pur, mais :
- Les bibliothèques (NumPy, etc.) sont écrites en C/Fortran
- Le temps de développement est souvent plus important que le temps d'exécution
- Pour les goulots, on peut optimiser (Cython, Numba, PyPy)
- Python excelle en temps de prototypage

---

## Problèmes courants et solutions

### Le notebook ne s'ouvre pas

```bash
# Vérifier que Jupyter est installé
pip install jupyter

# Lancer Jupyter
jupyter notebook

# Ou JupyterLab (interface moderne)
pip install jupyterlab
jupyter lab
```

### ModuleNotFoundError: No module named '...'

```bash
# Vérifier que vous êtes dans l'environnement virtuel
# Réinstaller les dépendances
pip install -r requirements-dev.txt
```

### Les accents s'affichent mal dans le fichier CSV

```python
# Utiliser l'encodage UTF-8 explicitement
with open('mon_fichier.csv', encoding='utf-8') as f:
    contenu = f.read()
```

### Le code ne suit pas PEP 8

```bash
# Formater automatiquement avec ruff
make format

# Puis lire les remarques de ruff et reprendre votre code
make lint
```

### Ruff affiche « Support for Python 3.15 is under development »

C'est un simple avertissement, pas une erreur : la prise en charge de Python 3.15 par ruff n'est pas encore déclarée stable. Vos résultats sont valables, vous pouvez l'ignorer.

### Ruff signale « Unused `noqa` directive » (RUF100)

Vous avez corrigé un contre-exemple du notebook : le commentaire `# noqa` qui demandait à ruff de se taire sur cette ligne ne sert plus. Supprimez-le, ou lancez `make lint-fix`.

---

## Contribution et retours

### Enseignants

Pour proposer une amélioration de ce matériel :
- Ouvrez une issue sur GitHub
- Proposez une pull request
- Contactez sebastien.nedjar@univ-amu.fr

### Étudiants

Pour une question, un bug ou une suggestion :
- Posez la question en cours
- Consultez la FAQ ci-dessus
- Cherchez sur Stack Overflow (tag `[python]`)

---

## Licence

Ce matériel pédagogique est mis à disposition sous licence **Creative Commons BY-SA 4.0**.

Vous êtes libre de :
- **Partager** : copier et redistribuer
- **Adapter** : remixer, transformer et créer à partir du matériel

Selon les conditions suivantes :
- **Attribution** : créditer l'auteur original
- **Partage dans les mêmes conditions** : même licence pour les dérivés

---

## Remerciements

Inspiré par :
- [The Zen of Python](https://www.python.org/dev/peps/pep-0020/) (PEP 20)
- [PEP 8 - Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
- La communauté Python

---

## Contact

**Enseignant** : Sébastien NEDJAR
**Email** : sebastien.nedjar@univ-amu.fr

---

Bon apprentissage !
