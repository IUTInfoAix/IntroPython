<img src="https://github.com/IUTInfoAix/Syllabus/blob/main/logo.png?raw=true" alt="class logo" class="logo"/>

# 🐍 Python pour Informaticiens

## IUT d’Aix-Marseille – Département Informatique Aix-en-Provence
- **Responsables :**
  - [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr)
- **Besoin d'aide ?**
  - Consulter et/ou créer des [issues](https://github.com/IUTInfoAix/IntroPython/issues).
  - [Email](mailto:sebastien.nedjar@univ-amu.fr) pour une question d'ordre privée, ou pour convenir d'un rendez-vous physique.

# Séance pratique d'introduction (4 heures)

## 📋 Vue d'ensemble

Cette séance vise à faire découvrir **la façon Python** de programmer aux étudiants de BUT Informatique. L'objectif n'est pas d'apprendre la syntaxe de base (supposée connue), mais de comprendre comment écrire du code **pythonique** : idiomatique, lisible et professionnel.

### Objectifs pédagogiques

À l'issue de cette séance, les étudiants doivent être capables de :

- ✅ Choisir la structure de données appropriée (list, dict, set, tuple)
- ✅ Utiliser les idiomes Python (comprehensions, EAFP, context managers)
- ✅ Transformer du code "traduit de C++ ou Java" en code pythonique
- ✅ Exploiter les outils natifs de Python plutôt que réinventer la roue
- ✅ Lire et comprendre du code Python professionnel

## Création de votre dépôt de TP

La première chose que vous allez faire est de créer votre propre copie du dépôt du TP, dans votre compte GitHub personnel :

1. Rendez-vous sur le dépôt <https://github.com/IUTInfoAix/IntroPython>
2. Cliquez sur le bouton vert **Use this template**, puis sur **Create a new repository**
3. Dans **Owner**, choisissez votre compte personnel et gardez `IntroPython` comme nom de dépôt
4. Cliquez sur **Create repository**

GitHub va vous créer un dépôt `votreUsername/IntroPython` contenant une copie du TP. Ce dépôt vous appartient : vous pouvez y pousser votre travail librement.

## Ouverture de GitHub Codespace

Une fois votre dépôt créé, vous pouvez ouvrir le projet directement dans GitHub Codespace :

1. Rendez-vous sur votre dépôt GitHub (`votreUsername/IntroPython`)
2. Cliquez sur le bouton vert **Code**
3. Sélectionnez l'onglet **Codespaces**
4. Cliquez sur **Create codespace on main**

GitHub va créer un environnement de développement complet dans le cloud. Après quelques instants, vous aurez accès à VS Code directement dans votre navigateur avec :
- Python et toutes les dépendances déjà installées
- Jupyter Notebook fonctionnel
- Accès au terminal

Pour ouvrir le notebook de TP :
- Dans l'explorateur de fichiers (à gauche), cliquez sur le fichier `notebook_seance.ipynb`
- Le notebook s'ouvrira et vous pourrez exécuter les cellules

**Note** : GitHub offre 60 heures gratuites de Codespace par mois pour les comptes personnels.

## 🚀 Installation et prérequis (alternative locale)

### Prérequis

- **Python 3.8+** installé sur votre machine
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
pip install -r requirements.txt
```

### Contenu de `requirements.txt`

```
jupyter>=1.0.0
jupyterlab>=3.0.0
notebook>=6.4.0
ipython>=8.0.0
black[jupyter]>=22.0.0
flake8>=4.0.0
...
```

### Utilisation du Makefile

Le projet inclut un Makefile avec plusieurs commandes utiles pour faciliter votre travail :

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

# Formater automatiquement votre code Python
make format

# Vérifier que votre code respecte PEP 8
make lint

# Vérifier le formatage + linting (sans modifier les fichiers)
make check-all

# Nettoyer les fichiers temporaires
make clean
```

**Pour les étudiants** : Les commandes `make format` et `make lint` sont particulièrement utiles pour vérifier que votre code suit les conventions pythoniques avant de soumettre vos exercices.

### Lancer les slides de présentation

Les slides de présentation sont disponibles au format Slidev :

```bash
# Lancer la présentation Slidev (nécessite Node.js)
make slides

# Ou directement avec npx
cd slides
npx slidev slides.md
```

La présentation s'ouvrira dans votre navigateur à l'adresse `http://localhost:3030`.

**Note** : Si vous n'avez pas Node.js installé, vous pouvez consulter les slides directement dans le fichier `slides/slides.md`.

## 📚 Structure de la séance

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

## 💻 Comment utiliser ce matériel

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

## 🎓 Pour les enseignants

### Intention pédagogique

Cette séance vise à **repositionner Python dans la perspective d'un informaticien professionnel**, en dépassant la vision "langage pour débutants" souvent véhiculée. L'intention est de faire comprendre aux étudiants que Python n'est pas qu'un outil pédagogique mais un **langage de production** utilisé massivement dans l'industrie, dont la maîtrise nécessite une compréhension des concepts informatiques sous-jacents.

Il s'agit de créer un **pont cognitif** entre leurs connaissances théoriques en algorithmique et programmation et l'utilisation pragmatique de Python, en montrant comment le langage incarne ou questionne constructivement certains paradigmes qu'ils étudient par ailleurs. La séance doit leur faire prendre conscience que la simplicité syntaxique de Python cache une richesse conceptuelle qui demande une réflexion d'informaticien pour être exploitée efficacement.

### Approche pédagogique

La séance adopte une **pédagogie active** basée sur :

- **L'apprentissage par comparaison** : mise en perspective systématique avec les langages qu'ils pratiqueront (C/C++, Java)
- **L'expérimentation immédiate** : chaque concept est accompagné d'un exercice court pour une validation empirique
- **La résolution de problèmes** : les exercices sont formulés comme des défis d'optimisation ou de refactoring
- **L'ancrage professionnel** : tous les exemples sont tirés de cas d'usage réels qu'ils rencontreront probablement un jour

L'évaluation formative se fait par observation des solutions proposées aux exercices et par les questions/discussions suscitées, permettant d'ajuster le rythme et le niveau d'approfondissement en temps réel.

---

## 🏆 Défi : Devenez un Pythonista en 10 semaines !

### 🎯 Mission jusqu'au début du semestre 2

**Relevez le défi : résolvez 1 exercice [Exercism](https://exercism.org/tracks/python) par semaine !**

#### 📈 Pourquoi participer ?

- 💪 **Pratiquer régulièrement** : la régularité bat l'intensité pour progresser en programmation
- 🧠 **Penser en Python** : développer les réflexes pythoniques et automatiser les bonnes pratiques
- 👥 **Échanger avec la communauté** : apprendre des solutions des autres et recevoir des feedbacks constructifs
- 🏅 **Progresser visiblement** : suivez votre évolution avec les badges et votre profil public Exercism

#### ✨ Les règles du jeu

1. **S'inscrire sur Exercism** : [exercism.org/tracks/python](https://exercism.org/tracks/python)
2. **Résoudre 1 exercice par semaine** pendant 10 semaines (jusqu'au début du semestre 2)
3. **Appliquer les idiomes Python** appris pendant la séance
4. **Demander du feedback** aux mentors Exercism après chaque exercice
5. **Partager vos solutions** avec vos camarades pour échanger des astuces
6. **Montrer votre progression** : profil public, badges collectés

#### 🎓 Exercices recommandés pour débuter

Les exercices Exercism sont organisés par difficulté. Voici une progression suggérée :

1. **Hello World** - Prise en main
2. **Two Fer** - Fonctions et paramètres par défaut
3. **Raindrops** - Conditions et modulos
4. **Leap** - Logique booléenne
5. **Pangram** - Sets et manipulation de chaînes
6. **Isogram** - Algorithmes sur les chaînes
7. **Scrabble Score** - Dictionnaires
8. **Word Count** - Collections et parsing
9. **Run Length Encoding** - Algorithmes de compression
10. **Robot Simulator** - POO et états

#### 💡 Conseils pour réussir

- ⏰ **Planifiez** : bloquez 30-60 minutes par semaine dans votre agenda
- 🔄 **Itérez** : soumettez une première solution, puis améliorez-la avec les feedbacks
- 📚 **Apprenez** : lisez les solutions des autres après avoir terminé
- 🤝 **Entraidez-vous** : créez un groupe de discussion avec vos camarades

_"The only way to learn a new programming language is by writing programs in it." - Dennis Ritchie_

---

## 📖 Ressources complémentaires

### Documentation officielle
- [Python.org - Tutorial](https://docs.python.org/3/tutorial/)
- [PEP 8 - Style Guide](https://pep8.org/)
- [Python Standard Library](https://docs.python.org/3/library/)

### Tutoriels et cours
- [Real Python](https://realpython.com/) - Tutoriels de qualité
- [Python Tricks](https://realpython.com/products/python-tricks-book/) - Livre d'idiomes
- [Fluent Python](https://www.oreilly.com/library/view/fluent-python-2nd/9781492056348/) - Livre avancé

### Pratique
- [Exercism - Python Track](https://exercism.org/tracks/python)
- [LeetCode](https://leetcode.com/) - Problèmes algorithmiques
- [CodinGame](https://www.codingame.com/) - Apprendre en jouant
- [Python Koans](https://github.com/gregmalcolm/python_koans) - Apprentissage par TDD

### Bibliothèques essentielles par domaine

**Calcul scientifique et data science** :
- [NumPy](https://numpy.org/) - Calcul numérique
- [Pandas](https://pandas.pydata.org/) - Manipulation de données
- [Matplotlib](https://matplotlib.org/) - Visualisation
- [SciPy](https://scipy.org/) - Algorithmes scientifiques
- [Scikit-learn](https://scikit-learn.org/) - Machine learning

**Développement web** :
- [Flask](https://flask.palletsprojects.com/) - Micro-framework
- [Django](https://www.djangoproject.com/) - Framework complet
- [FastAPI](https://fastapi.tiangolo.com/) - API modernes

**Automatisation et scripts** :
- [Requests](https://requests.readthedocs.io/) - Requêtes HTTP
- [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/) - Web scraping
- [Click](https://click.palletsprojects.com/) - CLI élégantes

**Tests et qualité** :
- [pytest](https://pytest.org/) - Framework de tests
- [black](https://black.readthedocs.io/) - Formatage automatique
- [flake8](https://flake8.pycqa.org/) - Analyse statique
- [mypy](http://mypy-lang.org/) - Type checking

**Python embarqué** :
- [MicroPython](https://micropython.org/) - Python pour microcontrôleurs
- [CircuitPython](https://circuitpython.org/) - Variante maintenue par Adafruit
- [Documentation STeaMi](https://www.steami.cc/) - Pour vos cartes

---

## 🛠️ Outils recommandés

### Éditeurs et IDE

- **VS Code** + extensions Python
  - Python (Microsoft)
  - Pylance
  - Python Docstring Generator
  - autoDocstring

- **PyCharm** (Community ou Professional)
  - IDE complet avec débogueur intégré
  - Refactoring intelligent
  - Support Django/Flask

- **Jupyter Lab**
  - Pour l'exploration interactive
  - Notebooks intégrés

### Outils en ligne de commande

```bash
# Formater automatiquement
pip install black
black mon_fichier.py

# Vérifier le style PEP 8
pip install flake8
flake8 mon_fichier.py

# Analyse statique approfondie
pip install pylint
pylint mon_fichier.py

# Type checking
pip install mypy
mypy mon_fichier.py
```

### Configuration recommandée (`.vscode/settings.json`)

```json
{
  "[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  },
  "isort.args": ["--profile", "black"],
  "editor.rulers": [88],
  "editor.insertSpaces": true,
  "editor.tabSize": 4,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "jupyter.askForKernelRestart": false,
}
```

---

## 🤔 FAQ

### Q : J'ai déjà fait du Python, cette séance m'apprendra quelque chose ?

**R :** Oui ! Cette séance ne porte pas sur la syntaxe de base mais sur les **idiomes pythoniques**. Même les développeurs expérimentés découvrent souvent de nouvelles façons d'écrire du code plus élégant et efficace.

### Q : Pourquoi pas de pandas/requests/autres bibliothèques populaires ?

**R :** Cette séance se concentre sur les **fondamentaux du langage** et la bibliothèque standard. Les bibliothèques tierces seront vues dans d'autres cours spécialisés (data science, web, etc.).

### Q : Le code "pythonique" est-il vraiment plus rapide ?

**R :** Souvent **oui** (list comprehensions, fonctions built-in optimisées en C), mais le principal avantage est la **lisibilité** et la **maintenabilité**. "Premature optimization is the root of all evil."

### Q : Dois-je toujours suivre PEP 8 strictement ?

**R :** PEP 8 est un **guide**, pas une loi. L'important est la cohérence dans un projet. Cela dit, la plupart des projets Python professionnels suivent PEP 8.

### Q : Quand utiliser une list comprehension vs une boucle normale ?

**R :** Règle générale : si la comprehension tient sur **1-2 lignes** et reste **lisible**, utilisez-la. Sinon, préférez une boucle explicite avec un bon nom de variable.

### Q : Python est lent, pourquoi l'utiliser ?

**R :** Python est lent pour du calcul pur, mais :
- Les bibliothèques (NumPy, etc.) sont écrites en C/Fortran
- Le temps de développement est souvent plus important que le temps d'exécution
- Pour les goulots, on peut optimiser (Cython, Numba, PyPy)
- Python excelle en temps de prototypage

---

## 🐛 Problèmes courants et solutions

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
pip install -r requirements.txt
```

### Les accents s'affichent mal dans le fichier CSV

```python
# Utiliser l'encodage UTF-8 explicitement
with open('mon_fichier.csv', encoding='utf-8') as f:
    contenu = f.read()
```

### Le code ne suit pas PEP 8

```bash
# Formater automatiquement avec black
pip install black
black mon_fichier.py

# Ou vérifier avec flake8
pip install flake8
flake8 mon_fichier.py
```

---

## 📝 Contribution et feedback

### Pour les enseignants

Si vous utilisez ce matériel et avez des suggestions d'amélioration :
- Ouvrez une issue sur GitHub
- Proposez une pull request
- Contactez sebastien.nedjar@univ-amu.fr

### Pour les étudiants

Questions, bugs, suggestions ? N'hésitez pas à :
- Poser des questions en cours
- Consulter la FAQ ci-dessus
- Chercher sur Stack Overflow (tag `[python]`)

---

## 📜 Licence

Ce matériel pédagogique est mis à disposition sous licence **Creative Commons BY-SA 4.0**.

Vous êtes libre de :
- **Partager** : copier et redistribuer
- **Adapter** : remixer, transformer et créer à partir du matériel

Selon les conditions suivantes :
- **Attribution** : créditer l'auteur original
- **Partage dans les mêmes conditions** : même licence pour les dérivés

---

## ✨ Remerciements

Inspiré par :
- [The Zen of Python](https://www.python.org/dev/peps/pep-0020/) (PEP 20)
- [PEP 8 - Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
- La communauté Python

---

## 📞 Contact

**Enseignant** : Sébastien NEDJAR
**Email** : sebastien.nedjar@univ-amu.fr

---

**Bon apprentissage ! 🐍**

*"Python is a language where you can focus on the problem, not the syntax"*
