.PHONY: all build run debug clean

NAME = amavis
IMAGE = simonrupf/$(NAME)

all: build run

build:
	docker build -t $(IMAGE) .

run:
	docker run -d --init --name $(NAME) --read-only --restart=always --hostname=mail.example.com $(IMAGE)

debug:
	docker run -ti --rm --init --name $(NAME) --read-only --hostname=mail.example.com $(IMAGE) /bin/ash

clean:
	docker stop $(NAME)
	docker rm $(NAME)
