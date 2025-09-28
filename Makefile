# DevOps Project Makefile

.PHONY: help install build test lint clean docker-build docker-run docker-stop docker-logs dev

# Colors for output
GREEN=\033[0;32m
BLUE=\033[0;34m
YELLOW=\033[1;33m
NC=\033[0m # No Color

# Default target
help: ## Show this help message
	@echo "$(BLUE)My DevOps Practice Project$(NC)"
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'

install: ## Install dependencies
	@echo "$(YELLOW)Installing dependencies...$(NC)"
	npm install

build: ## Build the application (placeholder for future build steps)
	@echo "$(YELLOW)Building application...$(NC)"
	npm run lint
	npm test

test: ## Run tests
	@echo "$(YELLOW)Running tests...$(NC)"
	npm test

test-watch: ## Run tests in watch mode
	@echo "$(YELLOW)Running tests in watch mode...$(NC)"
	npm run test:watch

lint: ## Run linting
	@echo "$(YELLOW)Running linter...$(NC)"
	npm run lint

lint-fix: ## Fix linting issues
	@echo "$(YELLOW)Fixing linting issues...$(NC)"
	npm run lint:fix

dev: ## Start development server
	@echo "$(YELLOW)Starting development server...$(NC)"
	npm run dev

start: ## Start production server
	@echo "$(YELLOW)Starting production server...$(NC)"
	npm start

clean: ## Clean node_modules and logs
	@echo "$(YELLOW)Cleaning up...$(NC)"
	rm -rf node_modules
	rm -rf coverage
	rm -f *.log

docker-build: ## Build Docker image
	@echo "$(YELLOW)Building Docker image...$(NC)"
	docker build -t my-devops-project .

docker-run: ## Run Docker container
	@echo "$(YELLOW)Running Docker container...$(NC)"
	docker run -d -p 3000:3000 --name my-devops-app my-devops-project

docker-stop: ## Stop Docker container
	@echo "$(YELLOW)Stopping Docker container...$(NC)"
	-docker stop my-devops-app
	-docker rm my-devops-app

docker-logs: ## Show Docker container logs
	@echo "$(YELLOW)Docker container logs:$(NC)"
	docker logs my-devops-app

docker-compose-up: ## Start services with docker-compose
	@echo "$(YELLOW)Starting services with docker-compose...$(NC)"
	docker-compose up -d

docker-compose-down: ## Stop services with docker-compose
	@echo "$(YELLOW)Stopping services with docker-compose...$(NC)"
	docker-compose down

docker-compose-logs: ## Show docker-compose logs
	@echo "$(YELLOW)Docker-compose logs:$(NC)"
	docker-compose logs

health-check: ## Check application health
	@echo "$(YELLOW)Checking application health...$(NC)"
	curl -f http://localhost:3000/health || echo "$(RED)Health check failed$(NC)"

# Development workflow targets
setup: install ## Full setup for development
	@echo "$(GREEN)Development environment ready!$(NC)"

ci: lint test ## Run CI pipeline locally
	@echo "$(GREEN)CI pipeline completed!$(NC)"

# Security and maintenance
security-audit: ## Run security audit
	@echo "$(YELLOW)Running security audit...$(NC)"
	npm audit

security-fix: ## Fix security vulnerabilities
	@echo "$(YELLOW)Fixing security vulnerabilities...$(NC)"
	npm audit fix

update-deps: ## Update dependencies
	@echo "$(YELLOW)Updating dependencies...$(NC)"
	npm update

# Documentation
docs: ## Generate documentation (placeholder)
	@echo "$(YELLOW)Generating documentation...$(NC)"
	@echo "Documentation available in docs/ directory"