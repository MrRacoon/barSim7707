SRC_DIR  = ./client
DIST_DIR = ./dist
DIST_FILE = index.html

build:
	elm make --output=$(DIST_DIR)/$(DIST_FILE) $(SRC_DIR)/Main.elm

reactor:
	elm reactor

clean:
	-rm -rf $(DIST_DIR)
