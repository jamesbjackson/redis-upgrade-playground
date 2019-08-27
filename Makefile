
REPOSITORY = "electricimp/agent-http"
VERSION = `git rev-parse --short HEAD`

.PHONY: help deps build shell clean export cleanup-containers stop-all-containers cleanup-images remove-untagged-images remove-all-images remove-all-images prune-images run

# ------------------------------------------------------------------------------
# Make Targets / Help Information
# ------------------------------------------------------------------------------

help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
	printf "\n"; \
	printf "%-40s %s\n" "TARGET" "HELP" ; \
	printf "%-40s %s\n" "------" "----" ; \
	for help_line in $${help_lines[@]}; do \
		IFS=$$':' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf '\033[36m'; \
		printf "%-40s %s" $$help_command ; \
		printf '\033[0m'; \
		printf "%s\n" $$help_info; \
	done; \
	printf "\n";


# ------------------------------------------------------------------------------
# Common Operations
# ------------------------------------------------------------------------------


build: ## Build all the redis version docker images.
	cd ${PWD}/containers/redis/2.8.17 && $(MAKE) build
	cd ${PWD}/containers/redis/3.0.7 && $(MAKE) build
	cd ${PWD}/containers/redis/3.2.13 && $(MAKE) build
	cd ${PWD}/containers/redis/4.0.14 && $(MAKE) build
	cd ${PWD}/containers/redis/5.0.5 && $(MAKE) build


# ------------------------------------------------------------------------------
# Docker Common Operations
# ------------------------------------------------------------------------------

cleanup-containers: ##Stop all running containers
	docker ps -aq --no-trunc | xargs docker stop
	docker ps -aq --no-trunc | xargs docker rm

stop-all-containers: ##Stop all running containers
	docker ps -aq --no-trunc | xargs docker stop

remove-stopped-containers: ##Removes all stopped containers
	docker ps -aq --no-trunc | xargs docker rm

cleanup-images: ##Clean up all images
	docker images -q --filter dangling=true | xargs docker rmi
	docker images -q | xargs docker image rm --force
	docker image prune --force

remove-untagged-images:  ## Remove dangling / untagged docker images
	docker images -q --filter dangling=true | xargs docker rmi

remove-all-images: stop-all-containers ## Remove all docker images locally.
	docker images -q | xargs docker image rm --force

prune-images: remove-stopped-containers ## Prune's docker images
	docker image prune --force

# ------------------------------------------------------------------------------
# Local Development
# ------------------------------------------------------------------------------

run: build ## Run the container via docker compose for local development
	 docker-compose -p dev down && docker-compose -p dev kill && docker-compose -p dev build && docker-compose -p dev up

stop: ## Run the container via docker compose for local development
	 docker-compose -p dev downredis-

