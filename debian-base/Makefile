BUILD_DIR := build
MKDIR_P = mkdir -p
RM = rm -rf

.PHONY: build clean clobber

all: build

clean:
	${RM} ${CURDIR}/${BUILD_DIR}

clobber: clean
	@${RM} .installed-requirements

.installed-requirements:
	@echo "Installing required packages..."
	@./scripts/pre-build.sh
	@touch $@

build: .installed-requirements
	@echo "Building all supported distros..."
	@./scripts/buildall.sh

%:
	@echo "Building $@..."
	@$(MAKE) .installed-requirements
	@${MKDIR_P} ${CURDIR}/${BUILD_DIR}
	./scripts/makeimage.sh ${CURDIR}/${BUILD_DIR}/$@.tar $@

