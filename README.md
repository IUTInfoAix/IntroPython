<img src="https://github.com/IUTInfoAix/Syllabus/blob/main/logo.png?raw=true" alt="class logo" class="logo"/>

# Python pour Informaticiens

## IUT d'Aix-Marseille, Département Informatique Aix-en-Provence
- **Responsables :**
  - [Sébastien Nedjar](mailto:sebastien.nedjar@univ-amu.fr)
- **Besoin d'aide ?**
  - Consulter et/ou créer des [issues](https://github.com/IUTInfoAix/IntroPython/issues).
  - [Email](mailto:sebastien.nedjar@univ-amu.fr) pour une question d'ordre privée, ou pour convenir d'un rendez-vous physique.

# Séance pratique d'introduction (4 heures)

> **Séance de 4 heures**, à faire dans un GitHub Codespace. Vous travaillez dans un seul fichier, le notebook [notebook_seance.ipynb](notebook_seance.ipynb), qui alterne démonstrations, exercices et tests.

## Objectifs de la séance

### Ce que vous saurez faire à la fin de cette séance

La syntaxe de base de Python est supposée connue. Avec elle, on écrit déjà des programmes qui fonctionnent, mais qui ressemblent souvent à du C++ ou à du Java traduit ligne à ligne : une boucle `for i in range(len(fruits))` pour parcourir une liste, un fichier ouvert puis fermé à la main, un `while` avec un compteur. Cette séance vous apprend à écrire les mêmes programmes à la façon Python, c'est-à-dire du code **pythonique** : idiomatique et lisible.

La séance est découpée en quatre parties, et chacune vise des savoir-faire précis :

| Partie | Vous serez capable de... |
|---|---|
| **1. Structures de données** | Choisir la structure de données appropriée (list, dict, set, tuple). Mesurer les performances d'un code avec `timeit`. Expliquer les références et la mutabilité, et éviter leurs pièges. |
| **2. Idiomes** | Utiliser les idiomes Python : comprehensions, EAFP, context managers. |
| **3. Refactoring** | Transformer du code « traduit de C++ ou Java » en code pythonique. Exploiter les outils natifs de Python plutôt que réinventer la roue. |
| **4. Exercices pilotés par les tests** | Comprendre une spécification à partir de tests, puis écrire le code qui les fait passer. |

À la fin de la séance, vous devez aussi être capables de lire et de comprendre du code Python professionnel.

### Pourquoi cette démarche ?

Python a la réputation d'un « langage pour débutants ». C'est aussi un langage de production, très utilisé dans l'industrie : les slides de la séance en donnent des exemples dans le web, la data science, le DevOps, la finance, le jeu vidéo et la recherche. Sa syntaxe est simple, mais elle cache des concepts qu'il faut comprendre, en informaticien, pour bien s'en servir. La séance est construite pour vous les faire rencontrer un par un.

**Chaque notion est comparée à C++ et à Java**, puis suivie d'un exercice court qui la vérifie. Le notebook vous dit par exemple qu'un test d'appartenance dans une liste se comporte comme une recherche dans un `std::vector` ou une `ArrayList`, et qu'un set se comporte comme un `HashSet`.

**Vous pariez avant d'exécuter.** Le notebook vous demande plusieurs fois de prédire un résultat : l'écart de vitesse entre une liste et un set, ou ce qu'affichent trois petits programmes qui manipulent des références. Notez votre réponse, exécutez la cellule, et si le résultat vous surprend, cherchez pourquoi avant d'ouvrir l'explication.

**Vous mesurez au lieu de croire.** Qu'un test d'appartenance soit « très rapide » sur un set, ne le croyez pas sur parole : le module `timeit` chronomètre un bout de code, et vous vous en servez dès la première partie.

**Les tests servent de cahier des charges.** Les exercices sont accompagnés de tests `unittest`, livrés désactivés par un `@unittest.skip`. Vous les activez un par un en retirant le décorateur, et vous écrivez le code qui fait passer chacun. Dans la quatrième partie, les tests tiennent lieu d'énoncé : c'est l'approche TDD (Test-Driven Development).

**ruff relit votre code pendant que vous l'écrivez.** Ses remarques s'affichent sous votre code, dans les cellules du notebook. Chacune porte un code (par exemple `PERF401`) et propose une tournure plus pythonique. Les corrections automatiques à l'enregistrement sont volontairement désactivées : ruff vous montre la tournure à reprendre, à vous de la réécrire.

### La suite : le défi Exercism

Quatre heures ne suffisent pas à prendre des habitudes. La séance se prolonge par un défi : résoudre un exercice [Exercism](https://exercism.org/tracks/python) par semaine pendant 10 semaines, jusqu'au début du semestre 2. Il est présenté en conclusion de la séance et détaillé plus bas dans ce document.

### Prérequis

#### Connaissances attendues

- **La syntaxe de base de Python**, supposée connue.
- **Un compte GitHub personnel** : vous y créerez votre copie du dépôt.

Le notebook compare souvent Python à C++ et à Java. Ces comparaisons sont des points de repère : appuyez-vous sur le langage que vous connaissez.

#### Environnement technique

Toute la séance se fait dans **GitHub Codespaces** : vous n'avez rien à installer sur votre machine. L'environnement (Python 3.15, le noyau Jupyter qui exécute les cellules du notebook, ruff et les extensions VS Code) est prêt dès l'ouverture du Codespace.

> [!NOTE]
> Pour travailler sur votre propre machine (facultatif), voir la section [Travailler en local](#travailler-en-local-facultatif).

### Documentation de référence

- La [cheat sheet](ressources/cheatsheet.pdf) de la séance : deux pages à garder sous la main pendant les exercices
- Les [slides](slides/slides.md) de la séance
- [Le tutoriel Python](https://docs.python.org/3/tutorial/)
- [La bibliothèque standard](https://docs.python.org/3/library/)
- [PEP 8, le guide de style](https://pep8.org/)

---

## Mise en place

La mise en place se fait en trois étapes : créer votre copie du dépôt, l'ouvrir dans un Codespace (votre environnement de développement dans le navigateur), puis ouvrir le notebook.

### Étape 1 - Créer votre dépôt de TP

1. Rendez-vous sur le dépôt <https://github.com/IUTInfoAix/IntroPython>
2. Cliquez sur le bouton vert **Use this template**, puis sur **Create a new repository**
3. Dans **Owner**, choisissez votre compte personnel et gardez `IntroPython` comme nom de dépôt
4. Cliquez sur **Create repository**

GitHub crée un dépôt `votreUsername/IntroPython` qui contient une copie du TP. Ce dépôt vous appartient : vous pouvez y pousser votre travail librement.

### Étape 2 - Ouvrir le projet dans GitHub Codespaces

Une fois sur la page de votre dépôt (`votreUsername/IntroPython`) :

1. Cliquez sur le bouton vert **Code**
2. Sélectionnez l'onglet **Codespaces**
3. Cliquez sur **Create codespace on main**

GitHub télécharge un environnement déjà prêt (environ 190 Mo), puis installe les extensions de VS Code. VS Code s'ouvre ensuite dans votre navigateur, avec un terminal et les extensions Python, Jupyter et Ruff déjà configurées.

### Étape 3 - Ouvrir le notebook

Dans l'explorateur de fichiers (à gauche), cliquez sur le fichier `notebook_seance.ipynb`.

Le noyau Python 3.15 est normalement déjà sélectionné : son nom s'affiche en haut à droite du notebook, et vous pouvez exécuter les cellules tout de suite. Si VS Code affiche **Sélectionner un noyau** à la place, cliquez dessus, choisissez **Environnements Python**, puis Python 3.15.

### Vérification rapide

Exécutez la première cellule de code du notebook, `import this`, avec le bouton d'exécution à gauche de la cellule ou avec Maj+Entrée. Le Zen de Python doit s'afficher sous la cellule : votre environnement fonctionne, vous pouvez commencer.

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

#### Augmenter ce quota avec le Student Developer Pack

En tant qu'étudiant, vous pouvez demander les avantages **GitHub Education**. Une fois votre statut vérifié, votre quota Codespaces passe à 180 heures de calcul par mois, soit **90 heures** sur une machine à 2 cœurs, avec 20 Go de stockage : c'est le quota d'un compte GitHub Pro. Vous obtenez aussi un accès gratuit à GitHub Copilot et aux offres du [Student Developer Pack](https://education.github.com/pack).

Pour faire la demande :

1. Ajoutez votre adresse e-mail universitaire (en `@etu.univ-amu.fr` pour les étudiants d'AMU) à votre compte GitHub et validez-la ([marche à suivre](https://docs.github.com/fr/account-and-profile/how-tos/email-preferences/adding-an-email-address-to-your-github-account)). GitHub peut l'exiger pour reconnaître votre établissement
2. Ouvrez la page [Education benefits](https://github.com/settings/education/benefits) de vos paramètres
3. Sous **GitHub Education**, cliquez sur **Start an application**
4. Remplissez le formulaire. Si un justificatif de scolarité vous est demandé, GitHub accepte une carte d'étudiant portant la date de l'inscription en cours, un emploi du temps, un relevé de notes ou un certificat de scolarité
5. Cliquez sur **Submit application**

Une fois la demande acceptée, vos avantages sont regroupés sur le [portail GitHub Education](https://github.com/education). Les conditions à jour sont dans la [documentation de GitHub](https://docs.github.com/fr/education/about-github-education/github-education-for-students/apply-to-github-education-as-a-student).

Cette demande n'est pas nécessaire pour la séance : 4 heures sur une machine à 2 cœurs consomment 8 des 120 heures d'un compte gratuit.

---

## Déroulement de la séance

| Horaire | Partie | Durée | Contenu |
|---------|--------|-------|---------|
| 00:00 | Mise en route | 20 min | Création du dépôt, Codespace, Zen de Python, échauffement |
| 00:20 | **Partie 1** | 65 min | Structures de données natives, mesure de performances, mutabilité |
| 01:25 | **Partie 2** | 55 min | Compréhensions, EAFP, context managers |
| 02:20 | Pause | 15 min | |
| 02:35 | **Partie 3** | 45 min | Refactoring de l'analyseur CSV |
| 03:20 | **Partie 4** | 30 min | Exercices pilotés par les tests |
| 03:50 | Conclusion | 10 min | Bilan et défi Exercism |

### Mise en route (20 min)

Vous créez votre dépôt et votre Codespace, puis vous lisez le Zen de Python, les principes du langage. L'échauffement compare deux versions d'une même boucle : l'une écrite comme en C ou en Java, avec `range(len(...))` et un indice, l'autre avec `enumerate()` et une f-string. À vous de dire laquelle est la plus lisible.

### Partie 1 - Structures de données, mesure de performances, mutabilité (65 min)

Python fournit quatre structures de base : la liste, le dictionnaire, le set et le tuple. Vous voyez d'abord à quoi sert chacune, puis vous mesurez avec `timeit` ce que coûte un test d'appartenance (`in`) parmi 100 000 éléments, dans une liste puis dans un set. Avant d'exécuter la cellule, pariez sur l'écart.

L'exercice guidé (25 min) met ces structures au travail sur un cas réel : vous gérez les inscriptions à un événement où certaines personnes se sont inscrites plusieurs fois. Il faut compter les participants uniques, retrouver ceux qui se sont inscrits plusieurs fois, puis refaire ce comptage avec `Counter`.

La partie se termine par la mutabilité et les références (20 min). En C++ ou en Java, vous savez toujours si vous manipulez une valeur ou une référence. En Python, la syntaxe ne le montre pas : il faut connaître la règle. Vous la découvrez sur trois petits programmes dont vous prédisez l'affichage (`b = a`, un argument par défaut, une grille 3 × 3), puis vous réparez une fonction dont l'argument par défaut est mutable.

### Partie 2 - Compréhensions, EAFP, context managers (55 min)

Cette partie présente trois idiomes :

- la **list comprehension** écrit en une ligne une boucle qui remplit une liste. Exercice : filtrer une liste de notes (10 min) ;
- **EAFP**, « Easier to Ask Forgiveness than Permission » : en Python, on préfère essayer puis gérer l'erreur plutôt que vérifier avant. Exercice : une division qui retourne une valeur par défaut au lieu d'échouer (15 min) ;
- le **context manager** `with` ferme un fichier automatiquement, même si une erreur se produit.

### Partie 3 - Refactoring de l'analyseur CSV (45 min)

Vous partez d'un programme écrit par un débutant, qui analyse un fichier de notes d'examen. Il fonctionne, mais il n'est ni pythonique ni très lisible : le fichier est ouvert sans `with`, une boucle `while` avance avec un compteur manuel, les sommes sont calculées à la main et un `except:` attrape toutes les erreurs sans distinction. Vous le réécrivez avec ce que vous venez d'apprendre, et neuf tests vérifient votre version.

### Partie 4 - Exercices pilotés par les tests (30 min)

Ici, vous codez à partir des tests : vous les lisez pour comprendre ce que la fonction doit faire, puis vous les faites passer un par un. Cette partie sert de marge : le détecteur de palindromes est pour tout le monde, le compresseur RLE et le validateur de mots de passe sont des bonus, à finir chez vous.

### Conclusion (10 min)

Bilan de ce que vous avez appris et présentation du défi Exercism.

---

## Comment travailler dans le notebook

Un exercice se présente toujours dans le même ordre : l'énoncé, une cellule de code à compléter et, le plus souvent, des tests puis une solution repliée. Les titres et les commentaires portent des repères qui reviennent tout au long du notebook :

| Repère | Signification |
|---|---|
| 📖 | Démonstration ou explication : des cellules à exécuter et à observer |
| ✏️ | Exercice : du code à écrire |
| 🎯 📝 ⏱️ | Objectif, consignes et durée de l'exercice |
| ⭐ à ⭐⭐⭐ | Difficulté croissante des questions |
| 💡 | Indice |
| 💻 VOTRE CODE ICI | Zone à compléter dans une cellule de code |
| 👁️ | Solution ou explication repliée : cliquez après avoir essayé |
| ❌ et ✅ | Style classique à remplacer, et style Python |

**Les tests.** Ils sont tous désactivés au départ. Retirez le `@unittest.skip` du premier test, exécutez la cellule, écrivez le code qui le fait passer, puis passez au suivant.

**Les solutions.** Ouvrez-les après avoir cherché. Plusieurs proposent une seconde version, plus concise ou mieux découpée, à comparer avec la vôtre.

**Les remarques de ruff.** Quand ruff signale une ligne, lisez sa remarque et essayez de réécrire vous-même avant de recourir à `make lint-fix`. Le code est par ailleurs formaté à chaque enregistrement, y compris dans les cellules du notebook.

**Les `# noqa`.** Quelques lignes du notebook se terminent par `# noqa: CODE` : ce sont des contre-exemples volontaires (les « ❌ Style classique »), sur lesquels ruff a reçu la consigne de se taire. N'en ajoutez pas dans votre propre code. Si vous corrigez l'une de ces lignes, ruff vous signale que le `# noqa` ne sert plus (`RUF100`) : supprimez-le.

Pendant la séance, travaillez en binôme sur les exercices, modifiez les exemples pour voir ce qui change, et posez des questions.

### Après la séance

- Refaites les exercices à tête reposée, et terminez les deux bonus de la partie 4
- Consultez régulièrement la cheat sheet
- Relevez le défi Exercism présenté ci-dessous
- Explorez les ressources recommandées

---

## Assistance IA

Vous avez le droit d'utiliser **Copilot Chat** (panneau latéral dans VS Code) quand vous bloquez sur un exercice. Il est configuré spécifiquement pour cette séance : il ne donnera pas la solution directement, mais vous guidera par étapes : d'abord une explication du concept, puis un pointeur vers la documentation, et seulement en dernier recours un minimum de code.

**Copilot Chat n'est pas un raccourci, c'est un tuteur.** Il vous aide à comprendre, pas à copier-coller. L'objectif est que vous soyez capable d'écrire ce code **en autonomie** à la fin de la séance.

Dans le Codespace, les complétions automatiques de Copilot sont désactivées : c'est vous qui écrivez le code, et Copilot ne répond que dans le panneau de discussion.

Copilot est gratuit pour les étudiants dont le statut est vérifié par GitHub Education : la marche à suivre est dans la section [Augmenter ce quota avec le Student Developer Pack](#augmenter-ce-quota-avec-le-student-developer-pack).

### Essayer Copilot Chat

Ouvrez le panneau **Copilot Chat** (icône dans la barre latérale gauche) et essayez quelques questions simples pour vous familiariser :

- `Qu'est-ce qu'une list comprehension ?`
- `Explique-moi la différence entre une liste et un set`
- `Pourquoi b = a ne copie pas ma liste ?`
- `Pourquoi mon test test_1_palindrome_simple échoue ?`

Observez comment Copilot répond : il explique le concept sans donner directement du code. Si vous insistez, il vous orientera vers la documentation, puis seulement en dernier recours proposera un minimum de code.

Les solutions repliées du notebook restent disponibles : Copilot ne vous les récitera pas, mais il peut vous les expliquer une fois que vous les avez ouvertes.

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

## Travailler en local (facultatif)

Le Codespace suffit pour toute la séance. Cette section s'adresse à ceux qui préfèrent travailler sur leur propre machine.

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

`make format` et `make lint` s'appuient sur [ruff](https://docs.astral.sh/ruff/), le formateur et linter du projet.

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

## Pour les enseignants

### Intention pédagogique

La séance présente Python comme l'outil d'un informaticien professionnel, à rebours de sa réputation de « langage pour débutants ». Les étudiants doivent en retenir que Python est un langage de production, très utilisé dans l'industrie, et qu'on ne le maîtrise pas sans comprendre les concepts informatiques sous-jacents.

Elle relie leurs connaissances théoriques en algorithmique et en programmation à l'usage concret de Python : le langage applique certains des paradigmes qu'ils étudient par ailleurs, et en remet d'autres en question. Sa syntaxe est simple, mais elle cache des concepts qu'il faut comprendre, en informaticien, pour bien s'en servir.

### Approche pédagogique

La séance repose sur une pédagogie active. Chaque notion est comparée aux langages que les étudiants pratiqueront (C/C++, Java), puis suivie d'un exercice court qui la vérifie. Les exercices sont posés comme des problèmes d'optimisation ou de refactoring, et tous les exemples viennent de cas d'usage réels qu'ils rencontreront probablement un jour.

L'évaluation est formative : l'enseignant observe les solutions proposées aux exercices, écoute les questions et les discussions, puis ajuste le rythme et le niveau d'approfondissement pendant la séance.

### Maintenance du dépôt

Le fonctionnement du Codespace, la publication de son image et les conventions du dépôt sont décrits dans [CONTRIBUTING.md](CONTRIBUTING.md).

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

## Dépannage

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

_"You will find yourself pleasantly surprised to see how easy it is to concentrate on the solution to the problem rather than the syntax and structure of the language you are programming in."_ (Swaroop C H, _A Byte of Python_)
