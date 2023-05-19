.PHONY: all build run debug clean help

NAME = amavis
IMAGE = simonrupf/$(NAME)

all: build run ## Equivalent to "make build run" (default).

build: ## Build the container image.
	docker build -t $(IMAGE) .

run: ## Run a container from the image.
	docker run -d --init --name $(NAME) --read-only --restart=always --hostname=mail.example.com $(IMAGE)

debug: ## Run a shell instead of the service for inspection, deletes the container when you leave it.
	docker run -ti --rm --init --name $(NAME) --read-only --hostname=mail.example.com $(IMAGE) /bin/ash

clean: ## Stops and removes the running container.
	docker stop $(NAME)
	docker rm $(NAME)

help: ## Displays these usage instructions.
	@echo "Usage: make <target(s)>"
	@echo
	@echo "Specify one or multiple of the following targets and they will be processed in the given order:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-16s%s\n", $$1, $$2}' $(MAKEFILE_LIST)

