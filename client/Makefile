SRC_DIR  = ./src
DIST_DIR = ./dist
DIST_FILE = index.js

all: clean prep build index

refresh: all open

open:
	firefox ${DIST_DIR}/index.html

prep:
	mkdir ${DIST_DIR}

build: index
	elm make --output=$(DIST_DIR)/$(DIST_FILE) ${SRC_DIR}/App.elm

index:
	cp ./index.html $(DIST_DIR)/index.html

reactor:
	elm reactor

clean:
	-rm -rf $(DIST_DIR)
