SUDO=
SRC?=""
DST?=""
DOCKER=$(SUDO) docker
DOCKER_PS_GANACHE=$$($(DOCKER) ps -qa -f ancestor=ganache)

define confirm =
	(\
		remove="";\
		while [ "$$remove" != "Y" ] && [ "$$remove" != "n" ]; do \
			read -p 'Do you want remove it (Y/n)? ' remove; \
		done; \
		if [ $$remove = "Y" ]; then \
			$(MAKE) clean_truffle_i; \
		else \
			echo "Truffle_i container keeped.\nDon't forget remove it with \`make clean_truffle_i\` before launch news tests."; \
		fi \
	)
endef


all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[0m \033[36m%s\033[0m\n", $$1, $$2}'

build_ganache: ## Build ganache image.
	@($(DOCKER) build -t ganache -f docker/ganache/Dockerfile . && echo "Ganache build: success.") || echo "Can't create ganache image." 1>&2

build_truffle_i: ## Build truffle_i image.
	@($(DOCKER) build -t truffle_i -f docker/truffle_i/Dockerfile . && echo "Truffle_i build: success.") || echo "Can't create truffle_i image." 1>&2

build_truffle_iv: ## Build truffle_iv image.
	@($(DOCKER) build -t truffle_iv -f docker/truffle_iv/Dockerfile . && echo "Truffle_iv build: success.") || echo "Can't create truffle_iv image." 1>&2

build: build_ganache build_truffle_i build_truffle_iv ## Build all docker images.
	@echo "Images build: success !"

deploy: install build_ganache build_truffle_iv truffle_iv ## Build images (ganache and truffle_iv) and launch truffle_iv.

deploy_i: build_ganache build_truffle_i truffle_i ## Build images (ganache and truffle_i) and launch truffle_i.

install: ## Install dependencies in clive folder, necessary to launch truffle_iv.
	@echo "Install dependencies..."
	@(npm install --prefix clive clive && echo "Dependencies has been installed.") || echo "Dependencies hasn't been installed." 1>&2

ganache: ## Launch ganache container.
	@$(DOCKER) start ganache 2> /dev/null && echo "Ganache container already exist, resume...\nFor clean ganache use clean_ganache before."\
	|| (echo "Ganache does not exist, starting..." && $(DOCKER) run -d -p 8545:8545 --name ganache ganache\
	|| echo "Ganache container can't be launched" 1>&2)

test: ganache ## Launch ganache and start test container (based on truffle_iv image).
	@$(DOCKER) run --rm -v "${PWD}/clive:/clive" -p 8080:8080 --link ganache --name truffle_iv truffle_iv truffle test --network ganache\
	|| echo "Truffle test container can't be launch." 1>&2

truffle_i: ganache ## Launch ganache and truffle container in interactive mode inside isolate environement.
	@$(DOCKER) start -i truffle_i 2> /dev/null && echo "For clean truffle_i use clean_truffle_i before."\
	|| ($(DOCKER) run -it -p 8080:8080 --link ganache --name truffle_i truffle_i bash\
		&& $(call confirm)) \
	|| echo "Truffle_i container can't be launched." 1>&2

truffle_iv: ganache ## Launch ganache and truffle container in interactive mode, mount clive folder.
	@$(DOCKER) run --rm -it -v "${PWD}/clive:/clive" -p 8080:8080 --link ganache --name truffle_iv truffle_iv bash\
	|| echo "Truffle_iv container can't be launched." 1>&2

cp_to: ## Copy file to project folder truffle_i container, need define SRC, you can redefine DST for specific file or folder.
	@$(DOCKER) cp $(SRC) truffle_i:/clive/$(DST)

cp_from: ## Copy project from truffle_i container, need define DST, you can redefine SRC for specific file or folder.
	@$(DOCKER) cp truffle_i:/clive/$(SRC) $(DST) 

stop_ganache: ## Stop ganache container.
	@($(DOCKER) stop ganache 2> /dev/null && echo "Stopped Ganache container.") || echo "Ganache container is not running." 1>&2

stop_truffle_i: ## Stop truffle_i container.
	@($(DOCKER) stop truffle_i 2> /dev/null && echo "Stopped truffle_i container.") || echo "Truffle_i container not running." 1>&2

stop_truffle_iv: ## Stop truffle_iv container.
	@($(DOCKER) stop truffle_iv 2> /dev/null && echo "Stopped truffle_iv container.") || echo "Truffle_iv container not running." 1>&2

stop: stop_truffle_i stop_truffle_iv stop_ganache ## Stop all containers.

clean_ganache: stop_ganache ## Stop and remove ganache container.
	@($(DOCKER) rm ganache 2>/dev/null && echo "Removed Ganache container.") || echo "No ganache container found." 1>&2

clean_truffle_i: stop_truffle_i ## Stop and remove truffle_i container.
	@($(DOCKER) rm truffle_i 2> /dev/null && echo "Removed truffle_i container.") || echo "No truffle_i container found." 1>&2

clean_truffle_iv: stop_truffle_iv ## Stop and remove truffle_iv container.
	@($(DOCKER) rm truffle_iv 2> /dev/null && echo "Removed truffle_iv container.") || echo "No truffle_iv container found." 1>&2
	
clean: clean_truffle_i clean_truffle_iv clean_ganache ## Stop and remove all containers.

fclean_ganache: clean_ganache ## Remove ganache image.
	@($(DOCKER) rmi ganache 2> /dev/null && echo "Ganache image removed.") || echo "No ganache image found." 1>&2

fclean_truffle_i: clean_truffle_i ## Remove truffle_i image.
	@($(DOCKER) rmi truffle_i 2> /dev/null && echo "Truffle_i image removed.") || echo "No truffle_i image found." 1>&2

fclean_truffle_iv: clean_truffle_iv ## Remove truffle_iv image.
	@($(DOCKER) rmi truffle_iv 2> /dev/null && echo "Truffle_iv image removed.") || echo "No truffle_iv image found." 1>&2

fclean: fclean_truffle_i fclean_truffle_iv fclean_ganache ## Remove all images.

.PHONY: all, build_ganache, build_truffle_i, build_truffle_iv, build, install, ganache, test, deploy, truffle_iv, stop_ganache, stop_truffle_i, stop_truffle_iv, stop, deploy, clean_ganache, clean_truffle_i, clean_truffle_iv, clean, fclean_ganache, fclean_truffle_i, fclean_truffle_iv, fclean
