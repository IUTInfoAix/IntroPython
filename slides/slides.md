---
theme: default
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Python pour Informaticiens
  Séance pratique de 4h pour le BUT Informatique

  Apprendre à écrire du code pythonique
drawings:
  persist: false
transition: slide-left
title: Python pour Informaticiens
mdc: true
---

# Python pour Informaticiens
## BUT Informatique : séance pratique (4 h)

---

# Objectif de la séance

## 🎯 Apprendre à écrire du code **pythonique**

**Pas juste traduire du Java/C en Python**

### Au programme :
- ✅ Choisir la bonne structure de données
- ✅ Annoter les types, et laisser l'éditeur les vérifier
- ✅ Utiliser les idiomes Python, dont les fonctions d'ordre supérieur
- ✅ Écrire du code lisible et élégant
- ✅ Coder à partir des tests, et refactoriser sous leur protection

<v-click>

**Philosophie** : "There should be one obvious way to do it"

</v-click>

---
layout: two-cols-header
---

# Python dans le monde réel

::left::

### 🌐 Web Backend
- Instagram
- Spotify
- Dropbox
- Reddit

### 🤖 Data Science & IA
- NumPy, Pandas
- TensorFlow
- scikit-learn

### ⚙️ DevOps
- Ansible
- Scripts système
- CI/CD

::right::

### 💰 Finance
- Trading algorithmique
- Analyse de risques

### 🎮 Jeux Vidéo
- Scripting
- Civilization
- Battlefield

### 🔬 Sciences
- Recherche
- Simulations
- Traitement de données

<v-click>

**→ Python est un outil professionnel**

</v-click>


---

# Le Zen de Python

```python
import this
```
<v-click>

### Les principes fondamentaux

- **Beautiful is better than ugly**
- **Explicit is better than implicit**
- **Simple is better than complex**
- **Readability counts**
- **There should be one obvious way to do it**
</v-click>
<v-click>

**→ Python privilégie la clarté sur la concision à tout prix**
</v-click>

---

# Les 4 structures natives essentielles


1. LIST : séquence ordonnée et modifiable
```python
courses = ["pain", "lait", "œufs"]
```
2. DICT : associations clé-valeur
```python
etudiant = {"nom": "Dupont", "age": 19}
```
3. SET : éléments uniques, test rapide
```python
participants = {"Alice", "Bob", "Charlie"}
```
4. TUPLE : séquence immutable
```python
position = (48.8566, 2.3522)  # Paris
```
---

# Le bon outil pour le bon usage !

| Besoin | Structure |
|--------|-----------|
| Ordre + modification | **list** |
| Associations | **dict** |
| Unicité + test rapide | **set** |
| Données immutables | **tuple** |

---

# Performances moyennes des opérations
| Opération | list | dict | set | tuple |
|-----------|------|------|-----|-------|
| Accès | <span class="text-green-500">**O(1)**</span> `[i]` | <span class="text-green-500">**O(1)**</span> accès par clé | - | <span class="text-green-500">**O(1)**</span> `[i]` |
| Recherche `in` | <span class="text-orange-500">O(n)</span> | <span class="text-green-500">**O(1)**</span> | <span class="text-green-500">**O(1)**</span> | <span class="text-orange-500">O(n)</span> |
| Ajout | <span class="text-green-500">**O(1)**</span> amorti (`append`) | <span class="text-green-500">**O(1)**</span> | <span class="text-green-500">**O(1)**</span> | - |
| Insertion au milieu | <span class="text-orange-500">O(n)</span> | - | - | - |
| Suppression | <span class="text-orange-500">O(n)</span> | <span class="text-green-500">**O(1)**</span> | <span class="text-green-500">**O(1)**</span> | - |

<v-click>

### 💡 Règle d'or

**Pour tester l'appartenance → dict ou set**

</v-click>

---

# Mesurer plutôt que croire

- Le module `timeit` chronomètre un bout de code
```python
import timeit

liste = list(range(100_000))
ensemble = set(liste)
x = 99_999  # Pire cas pour la liste : le dernier élément

timeit.timeit(lambda: x in liste, number=200)
timeit.timeit(lambda: x in ensemble, number=200)
```
<v-click>

| Recherche | Temps moyen |
|-----------|-------------|
| `x in liste` | <span class="text-orange-500">≈ 500 µs</span> |
| `x in ensemble` | <span class="text-green-500">**≈ 0,1 µs**</span> |

</v-click>
<v-click>

**→ Plusieurs milliers de fois plus rapide : O(n) contre O(1)**
</v-click>

---

# Mutabilité et références

## Une variable est un nom posé sur un objet

- `=` ne copie jamais l'objet
```python
a = [1, 2, 3]
b = a
b.append(4)  # a vaut aussi [1, 2, 3, 4]
```
<v-click>

- Un argument par défaut est créé une seule fois
```python
def ajouter_fruit(fruit, panier=[]):    # ❌ Liste partagée entre les appels
def ajouter_fruit(fruit, panier=None):  # ✅ Puis panier = [] dans la fonction
```
</v-click>
<v-click>

- `*` répète la même référence
```python
grille = [[0] * 3] * 3                # ❌ Trois fois la même rangée
grille = [[0] * 3 for _ in range(3)]  # ✅ Trois rangées distinctes
```
</v-click>
<v-click>

**→ Immutables (int, str, tuple) : sans danger. Mutables (list, dict, set) : attention au partage**
</v-click>

---

# Annoter les types

- Python est typé dynamiquement, mais on peut annoter
```python
def moyenne(notes: list[float]) -> float:
    return sum(notes) / len(notes)

def inscrire(nom: str, inscrits: list[str] | None = None) -> list[str]: ...
```
<v-click>

- Python ignore les annotations à l'exécution ; l'éditeur, lui, les vérifie
    - `moyenne(["12", "15"])` est souligné avant même d'être exécuté
    - Typage graduel : on annote ce qu'on veut, l'outil vérifie ce qui est annoté
</v-click>
<v-click>

- Python 3.15 : une sentinelle, quand `None` est une valeur possible
```python
ABSENT = sentinel("ABSENT")
def premier(elements: list[int], defaut: int | None | ABSENT = ABSENT) -> int | None: ...
```
</v-click>
<v-click>

**→ Comme en Java, la signature documente le contrat, et un outil le vérifie**
</v-click>

---

# List Comprehensions

- Style Java/C (verbeux)
```python
carres = []
for x in range(10):
    carres.append(x ** 2)
```
<v-click>

- Style Python (lisible et concis)
```python
carres = [x**2 for x in range(10)]
```
</v-click>

<v-click>

- Avec condition
```python
pairs = [x for x in range(20) if x % 2 == 0]
```
</v-click>

<v-click>

- Aplatir une liste de listes, réunir des dictionnaires (Python 3.15, PEP 798)
```python
plat = [elem for ligne in matrice for elem in ligne]  # avant 3.15
plat = [*ligne for ligne in matrice]                  # 3.15 : [[1, 2], [3]] → [1, 2, 3]
fusion = {**d for d in dicos}                         # 3.15 : [{"a": 1}, {"b": 2}] → {"a": 1, "b": 2}
```
</v-click>

<v-click>

**→ Plus lisible, et aussi rapide**
</v-click>

---

# EAFP : la philosophie Python

## "Easier to Ask Forgiveness than Permission"
<v-click>

- LBYL (Look Before You Leap) : style Java/C
```python
if "email" in donnees:
    email = donnees["email"]
else:
    email = "inconnu@example.com"
```
</v-click>
<v-click>

- EAFP : style Python
```python
try:
    email = donnees["email"]
except KeyError:
    email = "inconnu@example.com"
```
</v-click>
<v-click>

- Encore mieux : méthodes natives
```python
email = donnees.get("email", "inconnu@example.com")
```
</v-click>
<v-click>

**→ Exploiter les outils que Python vous offre !**
</v-click>

---

# Context Managers

## Gestion automatique des ressources

- Dangereux
```python
f = open('data.txt')
contenu = f.read()
f.close()  # Si erreur avant, jamais exécuté !
```
<v-click>

- Pythonique avec `with`
```python
with open('data.txt') as f:
    contenu = f.read()
# Fermeture automatique garantie
```
</v-click>
<v-click>

- Multiple context managers
```python
with open('in.txt') as f_in, open('out.txt', 'w') as f_out:
    f_out.write(f_in.read())
```
</v-click>
<v-click>

**→ Toujours utiliser `with` pour les fichiers**
</v-click>

---

# Les fonctions sont des valeurs

- Une fonction se passe en argument : les fonctions d'ordre supérieur
```python
sorted(mots, key=len)   # Java : Comparator.comparing(String::length)
max(mots, key=len)      # le mot le plus long
```
<v-click>

- `lambda` : une petite fonction écrite sur place
```python
sorted(resultats.items(), key=lambda paire: paire[1])   # Java : paire -> paire.getValue()
```
</v-click>
<v-click>

- `map` et `filter` existent, mais la comprehension est plus lisible
```python
list(map(lambda n: n * 2, notes))   # ❌ ruff le signale (C417)
[n * 2 for n in notes]              # ✅
```
</v-click>
<v-click>

- Une fonction qui retourne une fonction : une fermeture, la base des décorateurs
```python
def au_moins(seuil: int) -> Callable[[int], bool]:   # Java : Predicate<Integer>
    return lambda note: note >= seuil
```
</v-click>

---

# Idiomes pythoniques courants

- Vérifier si liste vide

```python
if not liste:              # ✅ Pythonique
```

<v-click>

- Enumerate au lieu d'indices

```python
for i, fruit in enumerate(fruits):  # ✅
```
</v-click>
<v-click>

- Swap sans variable temporaire

```python
a, b = b, a                # ✅
```
</v-click>
<v-click>

- Unpacking

```python
premier, *milieu, dernier = [1, 2, 3, 4, 5]
```
</v-click>
<v-click>

- Joindre des strings

```python
", ".join(liste_strings)   # ✅
```
</v-click>
<v-click>

- Parcourir dict

```python
for key, value in dico.items():  # ✅
```
</v-click>

---

# PEP 8 : conventions essentielles

- Nommage
```python
variable_name        # snake_case pour variables/fonctions
ClassName           # PascalCase pour classes
CONSTANTE           # MAJUSCULES pour constantes
```
<v-click>

- Règles de base :
    - **Indentation** : 4 espaces (PAS de tabs)
    - **Longueur ligne** : 79 caractères dans PEP 8, 88 dans ce projet (ruff)
    - **Espaces** : `x = 1` (pas `x=1`)
    - **Imports** : en haut, groupés
</v-click>
<v-click>

- Lisibilité
```python
if condition:
    action()
```
</v-click>
<v-click>

**→ "Readability counts" (Zen de Python)**
</v-click>

---

# Coder à partir des tests

- Les tests sont livrés désactivés

```python
class TestPalindrome(unittest.TestCase):
    @unittest.skip("à activer")
    def test_1_palindrome_simple(self):
        self.assertTrue(est_palindrome("kayak"))
```
<v-click>

- La boucle de travail
    1. Lire le test pour comprendre ce que la fonction doit faire
    2. Retirer son `@unittest.skip`
    3. Écrire le minimum de code qui le fait passer, même une valeur en dur
    4. Passer au test suivant, puis refactorer quand tout est vert
</v-click>
<v-click>

- Les exercices
    - Détecteur de palindromes : pendant la séance
    - Pangram, Scrabble Score et Anagram : bonus, en fin de notebook
</v-click>
<v-click>

**→ Les tests tiennent lieu d'énoncé**
</v-click>

---
layout: two-cols-header
---

# Refactoring : un code moche mais fonctionnel

**Méthode** : des tests verts avant de commencer, une transformation à la fois, et les tests restent verts après chacune

::left::

### Code original

- ❌ Pas de `with` pour le fichier
- ❌ Boucle `while` avec compteur
- ❌ `ligne[0] != "#"`
- ❌ `note >= 0 and note <= 20`
- ❌ `except:` sans préciser l'erreur
- ❌ Boucles manuelles pour sommer et compter
- ❌ Aucune annotation de types
- ❌ Plante sans fichier ou sans note valide

::right::

<v-click>

### À améliorer

1. Context manager (`with open()`)
2. `for ligne in lignes:`
3. Méthode de string (`startswith()`)
4. Comparaison enchaînée (`0 <= note <= 20`)
5. Erreur précise (`ValueError`)
6. `sum()`, `len()` et comprehension
7. Annotations de types
8. Un test rouge d'abord (TDD)

</v-click>

---

# Points clés à retenir

- ✅ Ce que vous avez appris

    1. **Structures** : Choisir la bonne (list, dict, set, tuple)
    2. **Mesure** : `timeit` avant de choisir
    3. **Mutabilité** : Se méfier des références partagées
    4. **Typage** : Annoter ses fonctions, l'éditeur vérifie les types
    5. **Idiomes** : Comprehensions, EAFP, context managers
    6. **Code pythonique** : Lisible, avec les outils natifs plutôt que la roue réinventée
    7. **Tests** : Coder à partir des tests, refactoriser sous leur protection
<v-click>

- 🎯 Prochaines étapes

    - Pratiquer avec des petits projets
    - Lire du code Python open-source
    - Utiliser les outils de qualité (ruff)
    - Explorer la stdlib (collections, itertools, etc.)
</v-click>

---
layout: two-cols-header
---

# 🏆 Défi : devenez un Pythonista en 10 semaines !

**🎯 Mission jusqu'au début du semestre 2 : 1 exercice Exercism par semaine = 10 exercices au total**

::left::

<v-click>

### 📈 Pourquoi ce défi ?
- 💪 **Pratiquer régulièrement** : la régularité bat l'intensité
- 🧠 **Penser en Python** : développer les réflexes pythoniques
- 👥 **Échanger avec la communauté** : apprendre des solutions des autres
- 🏅 **Progresser visiblement** : suivez votre évolution sur Exercism

</v-click>

::right::

<v-click>

### ✨ Les règles du jeu
- ✅ Inscrivez-vous sur Exercism
- ✅ Résolvez 1 exercice par semaine pendant 10 semaines
- ✅ Appliquez les idiomes Python appris aujourd'hui
- ✅ Demandez un retour aux mentors Exercism
- ✅ Partagez vos solutions avec vos camarades
- ✅ Montrez votre progression (badges, profil public)

</v-click>

::bottom::

<v-click>

**🚀 Lancez-vous : [exercism.org/tracks/python](https://exercism.org/tracks/python)**, en commençant par les trois bonus du notebook

_"The only way to learn a new programming language is by writing programs in it."_ (Brian Kernighan et Dennis Ritchie, _The C Programming Language_)

</v-click>

---
layout: two-cols-header
---
# Ressources pour continuer

::left::

### 📚 Documentation
- [Python.org](https://docs.python.org/3/)
- [PEP 8](https://pep8.org/)
- [Real Python](https://realpython.com/)

### 💻 Pratique
- [Exercism](https://exercism.org/tracks/python)
- [LeetCode](https://leetcode.com/)
- [HackerRank](https://www.hackerrank.com/)

::right::

### 🔧 Outils
- **ruff** : formatage et vérification du style, l'outil de ce projet
- **black**, **isort**, **flake8** : remplacés ici par ruff, encore répandus ailleurs
- **unittest**, **pytest** : tests unitaires (le notebook utilise unittest)

### 🌟 Communauté
- Reddit : r/learnpython
- Stack Overflow : [python]

---
layout: center
class: text-center
---

# 🐍 Merci !

## Questions ?

**Contact :** sebastien.nedjar@univ-amu.fr

**URL :** https://github.com/IUTInfoAix/IntroPython

<div class="pt-12">

**Ressources de la séance :**
#### 📓 Cahier de TP Jupyter
#### 📄 Cheat sheet Python
#### 💾 Cette présentation

</div>

<div class="abs-bottom m-6 text-sm">

_"You will find yourself pleasantly surprised to see how easy it is to concentrate on the solution to the problem rather than the syntax and structure of the language you are programming in."_ (Swaroop C H, _A Byte of Python_)

</div>
