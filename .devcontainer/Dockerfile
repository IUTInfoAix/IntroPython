# Image du Codespace : tout ce qui s'installe l'est ici, à la construction, et
# non dans une commande de cycle de vie relancée à chaque création de conteneur.

# Image Python officielle, épinglée sur la version exacte de Python et sur la
# distribution : un tag flottant (`3`, `latest`, `3.15-rc`) change de contenu
# sans prévenir. À la sortie de Python 3.15.0, passer à `3.15-slim-trixie`.
#
# Variante `slim` plutôt que l'image complète, pour deux raisons :
#   - elle ne contient que Python 3.15, alors que l'image complète embarque
#     aussi le Python 3.13 de Debian (/usr/bin/python3). Avec un seul
#     interpréteur, VS Code n'a qu'un noyau à proposer et le présélectionne ;
#   - elle est bien plus légère : pas de compilateurs, dont le notebook n'a
#     pas besoin (il n'utilise que la bibliothèque standard).
FROM python:3.15.0rc3-slim-trixie

# make : absent de l'image slim, nécessaire à `make lint` et `make format`.
# git, curl et sudo sont apportés par la feature common-utils.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Dépendances de la séance (noyau Jupyter et ruff). Seul ce fichier est copié :
# la couche n'est reconstruite que s'il change.
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --root-user-action=ignore -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt
