SRC_DIR  = ./client
DIST_DIR = ./dist
DIST_FILE = ${DIST_DIR}/index.js
INDEX_FILE = ${DIST_DIR}/index.html

build: ${DIST_DIR} ${DIST_FILE} ${INDEX_FILE}

build_full: clean build

${INDEX_FILE}: ${DIST_DIR}
	cp ${SRC_DIR}/index.html ${DIST_DIR}

${DIST_FILE}: ${DIST_DIR}
	elm make --yes --output=${DIST_FILE} ${SRC_DIR}/Main.elm

${DIST_DIR}:
	mkdir ${DIST_DIR}

reactor:
	elm reactor

clean:
	-rm -rf $(DIST_DIR)
