.PHONY: help install install-dev format format-check lint lint-fix test check-all clean notebook slides fix pre-commit-install pre-commit-run

# Commande ruff. Surchargeable pour essayer une autre version sans l'installer :
#   make lint RUFF="uvx ruff@0.16.10"
RUFF ?= ruff

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

format: ## Formate le code et trie les imports avec ruff
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Formatage automatique du code$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Tri des imports (fichiers Python et notebooks)...$(NC)"
	@$(RUFF) check --select I --fix .
	@echo ""
	@echo "$(YELLOW)→ Formatage (fichiers Python et notebooks)...$(NC)"
	@$(RUFF) format .
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Code formaté avec succès !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

format-check: ## Vérifie le formatage sans modifier
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Vérification du formatage du code$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Vérification du formatage (fichiers Python et notebooks)...$(NC)"
	@$(RUFF) format --check . && echo "$(GREEN)  ✓ Tout le code est bien formaté$(NC)" || (echo "$(RED)  ✗ Du code nécessite un formatage : make format$(NC)" && exit 1)
	@echo ""
	@echo "$(YELLOW)→ Vérification du tri des imports (fichiers Python et notebooks)...$(NC)"
	@$(RUFF) check --select I . && echo "$(GREEN)  ✓ Tous les imports sont bien triés$(NC)" || (echo "$(RED)  ✗ Des imports nécessitent un tri : make format$(NC)" && exit 1)
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Toutes les vérifications de formatage sont passées !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

lint: ## Vérifie le code avec ruff
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(BLUE)   Vérification du code (PEP 8 et tournures pythoniques)$(NC)"
	@echo "$(BLUE)═══════════════════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Vérification ruff (fichiers Python et notebooks)...$(NC)"
	@$(RUFF) check . && echo "$(GREEN)  ✓ Ruff n'a aucune remarque$(NC)" || (echo "$(RED)  ✗ Ruff a des remarques : lisez-les ci-dessus et reprenez votre code$(NC)" && exit 1)
	@echo ""
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"
	@echo "$(GREEN)  ✓ Toutes les vérifications ruff sont passées !$(NC)"
	@echo "$(GREEN)═══════════════════════════════════════════════════════$(NC)"

lint-fix: ## Applique les corrections sûres de ruff
	@echo "$(BLUE)Corrections automatiques de ruff...$(NC)"
	@$(RUFF) check --fix .

test: ## Exécute le notebook de bout en bout
	@echo "$(BLUE)Exécution du notebook...$(NC)"
	jupyter nbconvert --to notebook --execute --stdout notebook_seance.ipynb > /dev/null
	@echo "$(GREEN)✓ Le notebook s'exécute sans erreur$(NC)"

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

clean: ## Nettoie les fichiers temporaires
	@echo "$(BLUE)Nettoyage...$(NC)"
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name "*.pyo" -delete 2>/dev/null || true
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
