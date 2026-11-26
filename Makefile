# Language-agnostic entry points (SPEC D13). Every target runs in containers: the host needs only
# Docker, make and git. Services plug in through services/<name>/Makefile.
SERVICES := $(patsubst %/Makefile,%,$(wildcard services/*/Makefile))
HMCP_IMAGE ?= ghcr.io/OWNER/hackathon-mcp:latest

up:        ## start the app and Dozzle (live logs at http://localhost:9999)
	docker compose up -d --build --wait
down:      ## stop everything
	docker compose --profile observability down
logs:      ## follow logs of all services
	docker compose logs -f
observability: ## start Loki, Alloy and Grafana (http://localhost:3000)
	docker compose --profile observability up -d --wait

lint test build docs format:
	@for s in $(SERVICES); do echo "== $$s: $@"; $(MAKE) -C $$s $@ || exit 1; done

demo:      ## seed, run the demo scenario, reset
	sh scripts/demo

docs-check: ## validate docs/ and README.md exactly as CI does
	docker run --rm -v $(CURDIR):/repo $(HMCP_IMAGE) docs-check /repo

help:
	@grep -E '^[a-z-]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*##/\t/'

.PHONY: up down logs observability lint test build docs format demo docs-check help
