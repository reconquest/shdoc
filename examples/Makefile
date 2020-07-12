SHDOC   = ../shdoc
OBJECTS = $(patsubst %.sh, %.md, $(wildcard *.sh))

all: $(OBJECTS)

%.md: %.sh
	$(SHDOC) < $^ > $@
