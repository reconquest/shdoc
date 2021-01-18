all: dist

examples:
	$(MAKE) -C examples/ -B

vendor/%/Makefile:
	bash -c 'source vendor/github.com/reconquest/import.bash/import.bash && \
		import:use "$*"'

include vendor/github.com/reconquest/test-runner.bash/Makefile

build:
	mkdir build

dist: build
	cd build && cmake .. && cpack

install: dist
	sudo dpkg -i build/*.deb

clean:
	rm -rf build

.PHONY: all clean dist install examples
