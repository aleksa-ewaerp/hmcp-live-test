# Service targets; the root Makefile and CI call these. Tooling runs in the dev image.
# The anonymous /app/node_modules volume keeps the image's dependencies visible over the mounted source.
NAME := $(notdir $(CURDIR))
DEV := docker run --rm -v $(CURDIR):/app -v /app/node_modules -w /app $(NAME)-dev

dev-image:
	docker build --target dev -t $(NAME)-dev .

lint: dev-image
	$(DEV) pnpm run lint

test: dev-image
	$(DEV) pnpm test

format: dev-image
	$(DEV) pnpm run format

docs: dev-image
	$(DEV) pnpm run docs

build:
	docker build --target runtime -t $(NAME) .

.PHONY: dev-image lint test format docs build
