# vim: ts=8 ft=make
.PHONY: 	help examples deps test install

DST		:= "/usr/local/bin"
OS 		:= $(shell uname -s | tr '[:upper:]' '[:lower:]')
GAWK		:= $(shell command -v gawk)

help:		## Prints help message auto-generated from the comments.
		@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deps:	 	# Install git submodules (and on OS-X, install gawk)
		@git submodule update --recursive --init
		@bash -c \
		'if [[ $(OS) == darwin && -z "$(GAWK)" && -n "$(shell which brew)" ]];    then echo "Installing gawk..."; brew install gawk>/dev/null; fi'
		@bash -c \
		'if [[ $(OS) == linux  && -z "$(GAWK)" && -n "$(shell which apt-get)" ]]; then echo "Installing gawk..."; sudo apt-get install gawk>/dev/null; fi'

vendor/%/Makefile: deps
		@bash -c 'source vendor/github.com/reconquest/import.bash/import.bash && import:use "$*"'

include 	vendor/github.com/reconquest/test-runner.bash/Makefile

examples: 	deps ## Generate documentation for scripts in the examples folder
		@rm -f examples/*.md
		$(MAKE) -C examples/ -B
		@printf "\nGenerated shdoc file: "
		@find examples -type f -name '*.md' -print

install: 	deps ## Install shdoc into /usr/local/bin
		@cp -v shdoc $(DST)

