
# Common / Shared Variables
REPOSITORY = "dev/redis-server"
VERSION = "3.0.7"

.PHONY: help build shell clean export 

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


build: ## Build the docker container with caching enabled.
	docker build -t $(REPOSITORY):$(VERSION) .

clean: ## Build the docker container with caching disabled.
	docker build --no-cache -t $(REPOSITORY):$(VERSION) .

shell: clean ## Get interactive shell access to a built container
	docker run --cap-add=NET_ADMIN --rm -it $(REPOSITORY):$(VERSION) /bin/bash

export: ## Produces a tarred repository to the standard output stream.
	docker save $(REPOSITORY):$(VERSION)

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
