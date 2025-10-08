.PHONY: help install format lint test clean check-all notebook slides fix pre-commit-install pre-commit-run format-check check-verbose

# Couleurs pour l'affichage
BLUE = \033[0;34m
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
NC = \033[0m # No Color

help: ## Affiche cette aide
	@echo "$(BLUE)Python pour Informaticiens - Commandes disponibles :$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

install: ## Installe toutes les dépendances
	@echo "$(BLUE)Installation des dépendances...$(NC)"
	pip install -r requirements.txt
	@echo "$(GREEN)✓ Installation terminée$(NC)"

install-dev: install ## Installe les dépendances + outils de dev
	@echo "$(BLUE)Installation des outils de développement...$(NC)"
	pre-commit install
	@echo "$(GREEN)✓ Environnement de dev configuré$(NC)"

format: ## Formate le code avec black et isort
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Formatage automatique du code$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Formatage Black (fichiers Python)...$(NC)"
	@black .
	@echo ""
	@echo "$(YELLOW)→ Tri des imports (fichiers Python)...$(NC)"
	@isort .
	@echo ""
	@echo "$(YELLOW)→ Formatage Black (notebooks Jupyter)...$(NC)"
	@nbqa black .
	@echo ""
	@echo "$(YELLOW)→ Tri des imports (notebooks Jupyter)...$(NC)"
	@nbqa isort .
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Code formaté avec succès !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

format-check: ## Vérifie le formatage sans modifier
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Vérification du formatage du code$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Vérification Black (fichiers Python)...$(NC)"
	@black --check --quiet . && echo "$(GREEN)  ✓ Tous les fichiers Python sont bien formatés$(NC)" || (echo "$(RED)  ✗ Certains fichiers Python nécessitent un formatage$(NC)" && exit 1)
	@echo ""
	@echo "$(YELLOW)→ Vérification isort (imports Python)...$(NC)"
	@isort --check-only --quiet . && echo "$(GREEN)  ✓ Tous les imports Python sont bien triés$(NC)" || (echo "$(RED)  ✗ Certains imports Python nécessitent un tri$(NC)" && exit 1)
	@echo ""
	@echo "$(YELLOW)→ Vérification Black (notebooks Jupyter)...$(NC)"
	@nbqa black . --check --quiet && echo "$(GREEN)  ✓ Tous les notebooks sont bien formatés$(NC)" || (echo "$(RED)  ✗ Certains notebooks nécessitent un formatage$(NC)" && exit 1)
	@echo ""
	@echo "$(YELLOW)→ Vérification isort (imports notebooks)...$(NC)"
	@nbqa isort . --check-only --quiet && echo "$(GREEN)  ✓ Tous les imports des notebooks sont bien triés$(NC)" || (echo "$(RED)  ✗ Certains imports des notebooks nécessitent un tri$(NC)" && exit 1)
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Toutes les vérifications de formatage sont passées !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

lint: ## Vérifie le code avec flake8
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Vérification PEP 8$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Vérification flake8 (fichiers Python)...$(NC)"
	@flake8 . && echo "$(GREEN)  ✓ Tous les fichiers Python respectent PEP 8$(NC)" || (echo "$(RED)  ✗ Des violations PEP 8 ont été détectées dans les fichiers Python$(NC)" && exit 1)
	@echo ""
	@echo "$(YELLOW)→ Vérification flake8 (notebooks Jupyter)...$(NC)"
	@nbqa flake8 . --extend-ignore=E402,E501,F401,F541,F841 && echo "$(GREEN)  ✓ Tous les notebooks respectent PEP 8$(NC)" || (echo "$(RED)  ✗ Des violations PEP 8 ont été détectées dans les notebooks$(NC)" && exit 1)
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Toutes les vérifications PEP 8 sont passées !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

pylint: ## Analyse statique avec pylint
	@echo "$(BLUE)Analyse statique avec pylint...$(NC)"
	pylint **/*.py || true

mypy: ## Vérification de types avec mypy
	@echo "$(BLUE)Vérification de types des fichiers Python...$(NC)"
	mypy . || true
	@echo "$(BLUE)Vérification de types des notebooks...$(NC)"
	nbqa mypy . || true

test: ## Lance les tests unitaires
	@echo "$(BLUE)Exécution des tests...$(NC)"
	pytest -v

test-cov: ## Lance les tests avec couverture
	@echo "$(BLUE)Exécution des tests avec couverture...$(NC)"
	pytest --cov=. --cov-report=html --cov-report=term

check-all: ## Vérifie tout (format + lint)
	@echo ""
	@echo "$(BLUE)╔═══════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║                                                       ║$(NC)"
	@echo "$(BLUE)║         VÉRIFICATION COMPLÈTE DE LA QUALITÉ           ║$(NC)"
	@echo "$(BLUE)║                                                       ║$(NC)"
	@echo "$(BLUE)╚═══════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@$(MAKE) format-check
	@echo ""
	@$(MAKE) lint
	@echo ""
	@echo "$(GREEN)╔═══════════════════════════════════════════════════════╗$(NC)"
	@echo "$(GREEN)║                                                       ║$(NC)"
	@echo "$(GREEN)║    ✓✓✓  TOUTES LES VÉRIFICATIONS SONT PASSÉES  ✓✓✓    ║$(NC)"
	@echo "$(GREEN)║                                                       ║$(NC)"
	@echo "$(GREEN)╚═══════════════════════════════════════════════════════╝$(NC)"
	@echo ""

check-verbose: ## Vérifie tout avec détails sur les erreurs
	@echo ""
	@echo "$(BLUE)╔═══════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║                                                       ║$(NC)"
	@echo "$(BLUE)║      VÉRIFICATION DÉTAILLÉE DE LA QUALITÉ             ║$(NC)"
	@echo "$(BLUE)║                                                       ║$(NC)"
	@echo "$(BLUE)╚═══════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Détails des fichiers non formatés (Black)...$(NC)"
	@black --check --diff . || true
	@echo ""
	@echo "$(YELLOW)→ Détails des imports mal triés (isort)...$(NC)"
	@isort --check-only --diff . || true
	@echo ""
	@echo "$(YELLOW)→ Détails des notebooks non formatés (Black)...$(NC)"
	@nbqa black . --check --diff || true
	@echo ""
	@echo "$(YELLOW)→ Détails des imports mal triés dans notebooks...$(NC)"
	@nbqa isort . --check-only --diff || true
	@echo ""
	@echo "$(YELLOW)→ Violations PEP 8 détaillées (flake8)...$(NC)"
	@flake8 . || true
	@nbqa flake8 . --extend-ignore=E402,E501,F401,F541,F841 || true
	@echo ""
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)  Pour corriger automatiquement : make format$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"

clean: ## Nettoie les fichiers temporaires
	@echo "$(BLUE)Nettoyage...$(NC)"
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name "*.pyo" -delete 2>/dev/null || true
	rm -rf htmlcov/ .coverage 2>/dev/null || true
	@echo "$(GREEN)✓ Nettoyage terminé$(NC)"

notebook: ## Lance Jupyter Lab
	@echo "$(BLUE)Lancement de Jupyter Lab...$(NC)"
	jupyter lab

slides: ## Lance Slidev pour la présentation
	@echo "$(BLUE)Lancement de la présentation...$(NC)"
	npm install -g @slidev/cli @slidev/theme-default&&cd slides && npx slidev slides.md

fix: format lint ## Formate ET vérifie le code
	@echo "$(GREEN)✓ Code formaté et vérifié !$(NC)"

pre-commit-install: ## Installe les git hooks pre-commit
	@echo "$(BLUE)Installation des hooks pre-commit...$(NC)"
	pre-commit install
	@echo "$(GREEN)✓ Hooks installés$(NC)"

pre-commit-run: ## Lance tous les hooks pre-commit
	@echo "$(BLUE)Exécution des hooks pre-commit...$(NC)"
	pre-commit run --all-files
