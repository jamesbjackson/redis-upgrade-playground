
.PHONY: build server sentinel

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


build: ## Build all the containers for this version of Redis
	cd ${PWD}/server && $(MAKE) build
	cd ${PWD}/sentinel && $(MAKE) build

server: ## Build the docker container for Redis Server
	cd ${PWD}/server && $(MAKE) build

sentinel: server ## Build the docker container for Redis Sentinel
	cd ${PWD}/sentinel && $(MAKE) build

# ------------------------------------------------------------------------------
# Docker Common Operations
# ------------------------------------------------------------------------------

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



