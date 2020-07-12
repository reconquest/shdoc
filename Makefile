.PHONY: examples
examples:
	$(MAKE) -C examples/ -B

vendor/%/Makefile:
	bash -c 'source vendor/github.com/reconquest/import.bash/import.bash && \
		import:use "$*"'

include vendor/github.com/reconquest/test-runner.bash/Makefile

install:
	cp shdoc /usr/local/bin/
