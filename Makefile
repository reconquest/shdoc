.PHONY: examples
examples:
	$(MAKE) -C examples/ -B

vendor/%/Makefile:
	bash -c 'source vendor/github.com/reconquest/import.bash/import.bash && \
		import:use "$*"'

include vendor/github.com/reconquest/test-runner.bash/Makefile

DST = /usr/local/bin/
install:
	case $$OSTYPE in \
	darwin*) sed 's/\/usr\/bin\/gawk/\/usr\/bin\/env gawk/' shdoc > $(DST)/shdoc;; \
	*) cp shdoc $(DST);; \
	esac
	chmod +x $(DST)shdoc
