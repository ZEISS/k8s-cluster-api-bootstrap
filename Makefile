.DEFAULT_GOAL := start

# Load environment variables
include .env

# Export all variables to the environment of each command
all: .EXPORT_ALL_VARIABLES

.PHONY: start
start: minikube-start ## Setup the environment
	@clusterctl init

.PHONY: minikube-start
minikube-start: ## Start minikube
	@minikube start --memory=2048 --cpus=2

.PHONY: minikube-stop
minikube-stop: ## Stop minikube
	@minikube stop

.PHONY: clean
clean: minikube-stop ## Clean up the environment
	@minikube delete

.PHONY: help
help: ## Display this help screen.
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
