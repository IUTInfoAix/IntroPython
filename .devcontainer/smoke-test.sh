#!/bin/sh
# Smoke-test du devcontainer : prouve qu'un étudiant peut travailler dans le
# conteneur tel qu'il est distribué. Lancé par .github/workflows/devcontainer.yml
# et, à la main, par :
#   devcontainer exec --workspace-folder . .devcontainer/smoke-test.sh
set -eu

etape() { printf '\n→ %s\n' "$1"; }
echec() { printf '✗ %s\n' "$1" >&2; exit 1; }

etape "Le conteneur tourne avec l'utilisateur vscode"
[ "$(id -un)" = "vscode" ] || echec "utilisateur courant : $(id -un)"

# VS Code ne présélectionne un noyau que s'il n'en trouve qu'un. Un second
# interpréteur (le python3 de Debian, tiré par un paquet ou une feature) ferait
# réapparaître la question « Sélectionner un noyau » à l'ouverture du notebook.
etape "Python 3.15 est le seul interpréteur"
python --version
python -c 'import sys; sys.exit(sys.version_info[:2] != (3, 15))' \
    || echec "la séance attend Python 3.15"
[ ! -e /usr/bin/python3 ] || echec "second interpréteur trouvé : /usr/bin/python3"

# Vérifié avant toute installation : c'est l'image distribuée qui doit fournir
# le noyau, pas ce que le test ajoute ensuite.
etape "Le noyau Jupyter est installé"
python -c 'import ipykernel; print("ipykernel", ipykernel.__version__)'
jupyter kernelspec list | grep -q python3 || echec "noyau python3 introuvable"

etape "make lint"
make lint

etape "make format-check"
make format-check

# nbconvert pilote l'exécution, il n'est pas dans l'image : un étudiant n'en a
# pas besoin, VS Code exécute les cellules lui-même. Il est installé pour
# l'utilisateur, à côté de l'image, et c'est bien le noyau de l'image qui
# exécute les cellules.
etape "Le notebook distribué s'exécute de bout en bout"
python -m pip install --quiet --user nbconvert
PATH="$HOME/.local/bin:$PATH" make test

printf '\n✓ Le conteneur est prêt pour la séance\n'
