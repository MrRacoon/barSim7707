SRC_DIR  = ./client
DIST_DIR = ./dist
DIST_FILE = index.js

build: index
	elm make --output=$(DIST_DIR)/$(DIST_FILE) $(SRC_DIR)/Main.elm

index:
	cp $(SRC_DIR)/index.html $(DIST_DIR)

reactor:
	elm reactor

clean:
	-rm -rf $(DIST_DIR)
