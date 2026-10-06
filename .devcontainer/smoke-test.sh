#!/bin/sh
# Smoke-test du devcontainer : prouve qu'un étudiant peut travailler dans le
# conteneur tel qu'il est distribué. Lancé par les workflows devcontainer.yml
# (vérification) et devcontainer-publish.yml (avant toute publication) et, à la
# main, par :
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
python -c 'import ipykernel; print("ipykernel", ipykernel.__version__)' \
    || echec "ipykernel ne s'importe pas"

# L'image publiée est figée : si requirements.txt change sans nouvelle
# publication, les étudiants gardent l'ancienne version de ruff et ne voient
# plus les mêmes conseils que le dépôt. Sans index (--no-index), pip ne peut
# rien télécharger : il réussit si l'image satisfait déjà le fichier, et
# échoue sinon.
etape "Les paquets de l'image correspondent à requirements.txt"
python -m pip install --dry-run --no-index --no-deps --quiet -r requirements.txt \
    || echec "l'image ne correspond plus à requirements.txt : publiez-en une nouvelle (CONTRIBUTING.md)"

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
