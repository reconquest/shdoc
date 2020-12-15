# vim: ft=make
# vim: st=8

.PHONY: 	help examples deps test

DST		:= "/usr/local/bin"
OS 		:= $(shell uname -s | tr '[:upper:]' '[:lower:]')

help:		## Prints help message auto-generated from the comments.
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


deps:	 	# Install pre-requisites on OSX and download dependent git submodule
		@bash bin/setup
		@git submodule update --recursive --init


examples: 	deps ## Generate documentation for scripts in examples folder
		$(MAKE) -C examples/ -B


test: 		deps ## Run tests
		@bash -c 'source vendor/github.com/reconquest/import.bash/import.bash && import:use "$*"'
		@./*/run_tests*


install: 	deps ## Install shdoc into /usr/local/bin
		cp shdoc $(DST)


