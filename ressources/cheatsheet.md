---
header-includes:
   - \usepackage{twemojis}
---

# \twemoji{snake} Python Cheat Sheet - BUT Informatique

---

## \twemoji{package} Structures & Idiomes Essentiels

### Structures de données natives

| Structure | Création | Cas d'usage | Opérations clés |
|-----------|----------|-------------|-----------------|
| **list** | `[1, 2, 3]` | Séquence ordonnée, modifiable | `append()`, `insert()`, `[:]` |
| **dict** | `{"a": 1}` | Associations clé-valeur | `get()`, `keys()`, `values()` |
| **set** | `{1, 2, 3}` | Éléments uniques, test rapide | `add()`, `in`, `|`, `&`, `-` |
| **tuple** | `(1, 2, 3)` | Séquence immutable | Indexation, unpacking |

### Complexité algorithmique (moyenne)

```
Opération          list    dict    set     tuple
─────────────────────────────────────────────────
Accès [i]          O(1)    O(1)    -       O(1)
Recherche (in)     O(n)    O(1)    O(1)    O(n)
Insertion          O(n)    O(1)    O(1)    -
Suppression        O(n)    O(1)    O(1)    -
```

### List Comprehensions

```python
# Basique
[x**2 for x in range(10)]

# Avec condition
[x for x in range(20) if x % 2 == 0]

# Nested
[x*y for x in range(3) for y in range(3)]

# Dict comprehension
{x: x**2 for x in range(5)}

# Set comprehension
{x % 3 for x in range(10)}
```

### Unpacking & Enumerate

```python
# Unpacking
a, b, c = [1, 2, 3]
premier, *milieu, dernier = [1, 2, 3, 4, 5]
a, b = b, a  # Swap

# Enumerate (pas range(len()))
for i, valeur in enumerate(liste):
    print(f"{i}: {valeur}")

# Zip (parcourir plusieurs listes)
for nom, age in zip(noms, ages):
    print(f"{nom} a {age} ans")
```

### Méthodes utiles des structures

```python
# List
liste.append(x)      # Ajouter à la fin
liste.extend([...])  # Ajouter plusieurs
liste.pop()          # Retirer dernier
liste.remove(x)      # Retirer première occurrence
liste.sort()         # Trier sur place
sorted(liste)        # Nouvelle liste triée

# Dict
d.get(key, defaut)   # Accès sécurisé
d.setdefault(k, v)   # Créer si absent
d.update(autre)      # Fusionner
d.pop(key)           # Retirer et retourner

# Set
s.add(x)             # Ajouter élément
s.update([...])      # Ajouter plusieurs
s1 | s2              # Union
s1 & s2              # Intersection
s1 - s2              # Différence
```

### Fonctions built-in essentielles

```python
len(obj)             # Longueur
sum(iterable)        # Somme
min(iterable)        # Minimum
max(iterable)        # Maximum
all(iterable)        # Tous True ?
any(iterable)        # Au moins un True ?
sorted(iterable)     # Trier
reversed(iterable)   # Inverser
zip(iter1, iter2)    # Combiner
map(func, iterable)  # Appliquer fonction
filter(func, iter)   # Filtrer

# Exemples
sum([1, 2, 3])       # 6
max([3, 1, 4])       # 4
all([True, True])    # True
any([False, True])   # True
```

### String formatting

```python
# f-strings (Python 3.6+) - RECOMMANDÉ
nom = "Alice"
age = 25
print(f"{nom} a {age} ans")
print(f"{nom:>10}")      # Alignement droite
print(f"{3.14159:.2f}")  # 2 décimales : 3.14

# format()
"{} a {} ans".format(nom, age)
"{nom} a {age} ans".format(nom=nom, age=age)

# % (ancien, éviter)
"%s a %d ans" % (nom, age)
```

### Slicing

```python
liste = [0, 1, 2, 3, 4, 5]

liste[2:5]    # [2, 3, 4] (indices 2 à 4)
liste[:3]     # [0, 1, 2] (début à 2)
liste[3:]     # [3, 4, 5] (3 à la fin)
liste[::2]    # [0, 2, 4] (pas de 2)
liste[::-1]   # [5, 4, 3, 2, 1, 0] (inverser)
liste[-1]     # 5 (dernier élément)
liste[-3:]    # [3, 4, 5] (3 derniers)
```

---

## 🎯 VERSO : Bonnes Pratiques & Conventions

### EAFP vs LBYL

```python
# ❌ LBYL (Look Before You Leap) - Style Java/C
if key in dictionnaire:
    valeur = dictionnaire[key]
else:
    valeur = default

# ✅ EAFP (Easier to Ask Forgiveness than Permission)
try:
    valeur = dictionnaire[key]
except KeyError:
    valeur = default

# 🎯 MIEUX : Utiliser les méthodes natives
valeur = dictionnaire.get(key, default)
```

### Context Managers

```python
# ❌ Dangereux (peut ne pas fermer)
f = open('fichier.txt')
contenu = f.read()
f.close()

# ✅ Pythonique (fermeture garantie)
with open('fichier.txt') as f:
    contenu = f.read()

# Multiple context managers
with open('in.txt') as f_in, open('out.txt', 'w') as f_out:
    f_out.write(f_in.read())
```

### Gestion des erreurs

```python
# ✅ Erreurs spécifiques (pas except: nu)
try:
    valeur = int(input("Nombre: "))
    resultat = 10 / valeur
except ValueError:
    print("Pas un nombre valide")
except ZeroDivisionError:
    print("Division par zéro")
except Exception as e:
    print(f"Erreur inattendue: {e}")
finally:
    print("Toujours exécuté")

# Lever des exceptions
if age < 0:
    raise ValueError("L'âge ne peut pas être négatif")
```

### Conventions PEP 8 (essentielles)

```python
# Nommage
variable_name        # snake_case pour variables et fonctions
ClassName           # PascalCase pour classes
CONSTANTE           # MAJUSCULES pour constantes
_private            # Underscore pour usage interne
__dunder__          # Double underscore réservé à Python

# Indentation : 4 espaces (PAS de tabs)

# Espaces
x = 1               # ✅ Espaces autour de =
x=1                 # ❌ Pas d'espace
func(x, y)          # ✅ Espace après virgule
func(x,y)           # ❌ Pas d'espace

# Longueur de ligne : max 79 caractères
# Utiliser \ ou () pour découper

# Imports
import os
import sys
from collections import Counter

# ❌ Éviter
from module import *
```

### Docstrings

```python
def calculer_moyenne(notes):
    """
    Calcule la moyenne d'une liste de notes.

    Args:
        notes (list): Liste de notes (float)

    Returns:
        float: La moyenne des notes

    Raises:
        ValueError: Si la liste est vide

    Example:
        >>> calculer_moyenne([10, 15, 12])
        12.33
    """
    if not notes:
        raise ValueError("Liste vide")
    return sum(notes) / len(notes)
```

### Idiomes pythoniques courants

```python
# Vérifier si liste vide
if not liste:        # ✅ Pythonique
if len(liste) == 0:  # ❌ Verbeux

# Valeur par défaut
x = valeur or default  # Si valeur est falsy

# Parcourir dict
for key, value in dictionnaire.items():  # ✅
for key in dictionnaire:                 # Juste les clés

# Joindre strings
", ".join(liste_strings)  # ✅
# Pas de boucle manuelle avec +

# Compter occurrences
from collections import Counter
compteur = Counter(liste)  # ✅ Utiliser Counter

# Aplatir liste de listes
import itertools
plat = list(itertools.chain.from_iterable(nested))
```

### Type Hints (Python 3.5+)

```python
def saluer(nom: str, age: int) -> str:
    return f"{nom} a {age} ans"

# Types complexes
from typing import List, Dict, Optional, Tuple

def analyser(data: List[int]) -> Dict[str, float]:
    return {"moyenne": sum(data) / len(data)}

def trouver(id: int) -> Optional[str]:
    # Retourne str ou None
    return resultats.get(id)

def coordonnees() -> Tuple[float, float]:
    return (48.8566, 2.3522)
```

### Le Zen de Python (principes clés)

```python
import this  # Affiche les 19 aphorismes

# Les plus importants:
# - Beautiful is better than ugly
# - Explicit is better than implicit
# - Simple is better than complex
# - Readability counts
# - There should be one obvious way to do it
```

### Outils de qualité du code

```bash
# Formater automatiquement
pip install black
black mon_fichier.py

# Vérifier le style
pip install flake8
flake8 mon_fichier.py

# Analyse statique
pip install pylint
pylint mon_fichier.py

# Type checking
pip install mypy
mypy mon_fichier.py
```

### Ressources essentielles

**Documentation officielle**
- https://docs.python.org/3/
- https://pep8.org/ (style guide)

**Pratique**
- https://exercism.org/tracks/python
- https://leetcode.com/
- https://www.hackerrank.com/domains/python

**Tutoriels**
- https://realpython.com/
- https://python.plainenglish.io/

**Bibliothèques courantes**
```python
# Data science
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Web
import requests
from flask import Flask

# Utilitaires
import json
import csv
import datetime
from pathlib import Path
from collections import Counter, defaultdict
from itertools import chain, combinations
from functools import reduce
```

---

## 💡 Astuces de dernière minute

```python
# Déboguer rapidement
print(f"{variable=}")  # Python 3.8+, affiche: variable=valeur

# Timer simple
import time
start = time.time()
# ... code ...
print(f"Temps: {time.time() - start:.2f}s")

# Échanger valeurs
a, b = b, a

# Répéter string/liste
"ha" * 3          # "hahaha"
[0] * 5           # [0, 0, 0, 0, 0]

# Opérateur ternaire
x = valeur_si_vrai if condition else valeur_si_faux

# Chaîner comparaisons
if 0 < x < 10:    # ✅ Pythonique
if x > 0 and x < 10:  # ❌ Verbeux
```

---

**📌 Ce cheat sheet couvre l'essentiel pour écrire du code Python idiomatique !**
