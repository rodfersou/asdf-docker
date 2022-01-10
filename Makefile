SHELL := /bin/bash

CURRENT_OS := $(shell uname -s)
ifeq ($(CURRENT_OS), Linux)
	CURRENT_OS := $(shell lsb_release -si)
endif

ifeq ($(CURRENT_OS), Darwin)
	PATH  := /opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
	SHELL := env PATH=$(PATH) /bin/bash
endif

TAG='rodfersou/asdf'
NAME='rodfersou_asdf'

all: start

build:
	make clean
	docker buildx build -t $(TAG) .

start:
	docker run --rm -it $(TAG) bash

restart:
	make stop
	make start

stop:
	-docker container stop $(NAME)

stop-all:
	-docker stop $$(docker ps -aq)
	-docker rm $$(docker ps -aq)

export:
	-rm $(NAME)_$(CURRENT_OS).tar.gz
	docker save $(TAG) | gzip > $(NAME)_$(CURRENT_OS).tar.gz
	du -sh $(NAME)_$(CURRENT_OS).tar.gz

import:
	make clean
	docker load < $(NAME)_$(CURRENT_OS).tar.gz

clean:
	make stop
	-docker image rm $(TAG)

clean-cache-nix:
	-docker volume rm cache nix

clean-srv:
	-docker volume rm srv

clean-all:
	-docker stop $$(docker ps -aq)
	-docker rm $$(docker ps -aq)
	-docker rmi $$(docker images -q)
	# -docker volume rm $$(docker volume ls -q)

rebuild:
	make clean-all
	make build
	make export


.PHONY: all clean
