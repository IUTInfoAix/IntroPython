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
## BUT Informatique - Séance pratique (4h)

---

# Objectif de la séance

## 🎯 Apprendre à écrire du code **pythonique**

**Pas juste traduire du Java/C en Python**

### Au programme :
- ✅ Choisir la bonne structure de données
- ✅ Utiliser les idiomes Python
- ✅ Écrire du code lisible et élégant

<v-click>

**Philosophie** : "There should be one obvious way to do it"

</v-click>

---
layout: two-cols-header
---

# Où trouve-t-on Python dans le monde réel?

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

**→ Python n'est pas un jouet, c'est un outil professionnel**

</v-click>


---

# Les 4 structures natives essentielles


1. LIST - Séquence ordonnée et modifiable
```python
courses = ["pain", "lait", "œufs"]
```
2. DICT - Associations clé-valeur
```python
etudiant = {"nom": "Dupont", "age": 19}
```
3. SET - Éléments uniques, test rapide
```python
participants = {"Alice", "Bob", "Charlie"}
```
4. TUPLE - Séquence immutable
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

- Nested
```python
plat = [elem for ligne in matrice
               for elem in ligne]
```
</v-click>

<v-click>

**→ Plus lisible, souvent plus rapide**
</v-click>

---

# EAFP - La philosophie Python

## "Easier to Ask Forgiveness than Permission"
<v-click>

- LBYL (Look Before You Leap) - Style Java/C
```python
if "email" in donnees:
    email = donnees["email"]
else:
    email = "inconnu@example.com"
```
</v-click>
<v-click>

- EAFP - Style Python
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
for key, value in dict.items():  # ✅
```
</v-click>

---

# PEP 8 - Conventions essentielles

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

**→ "Readability counts" - Zen de Python**
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

# Exercice de refactoring

- Code original (moche mais fonctionnel)
    - ❌ Pas de `with` pour les fichiers
    - ❌ Boucle `while` avec compteur
    - ❌ Boucle manuelle pour sommer
    - ❌ `except:` sans préciser l'erreur
    - ❌ Indexation au lieu de méthodes
<v-click>

- À améliorer
    1. Context managers
    2. Boucles `for` idiomatiques
    3. Fonctions built-in (`sum()`)
    4. Gestion d'erreurs spécifiques
    5. Méthodes de string (`startswith()`)
</v-click>

---

# Points clés à retenir

- ✅ Ce que vous avez appris

    1. **Structures** : Choisir la bonne (list, dict, set, tuple)
    2. **Mesure** : `timeit` avant de choisir
    3. **Mutabilité** : Se méfier des références partagées
    4. **Idiomes** : Comprehensions, EAFP, context managers
    5. **Outils natifs** : Ne pas réinventer la roue
    6. **Lisibilité** : Code clair > code court
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

# 🏆 Défi : Devenez un Pythonista en 10 semaines !

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
- ✅ Demandez du feedback aux mentors Exercism
- ✅ Partagez vos solutions avec vos camarades
- ✅ Montrez votre progression (badges, profil public)

</v-click>

::bottom::

<v-click>

**🚀 Lancez-vous : [exercism.org/tracks/python](https://exercism.org/tracks/python)**

_"The only way to learn a new programming language is by writing programs in it." - Dennis Ritchie_

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
- **pytest** : tests unitaires

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

_"Python is a language where you can focus on the problem, not the syntax"_

</div>
