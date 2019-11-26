# Makefile that builds go-hello-world, a "go" program.

# PROGRAM_NAME is the name of the GIT repository.
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)
TARGET_DIRECTORY := ./target
DOCKER_CONTAINER_NAME := $(PROGRAM_NAME)
DOCKER_IMAGE_NAME := local/$(PROGRAM_NAME)
BUILD_VERSION := $(shell git describe --always --tags --abbrev=0 --dirty)
BUILD_TAG := $(shell git describe --always --tags --abbrev=0)
BUILD_ITERATION := $(shell git log $(BUILD_TAG)..HEAD --oneline | wc -l)
GIT_REMOTE_URL := $(shell git config --get remote.origin.url)
GO_PACKAGE_NAME := $(shell echo $(GIT_REMOTE_URL) | sed -e 's|^git@github.com:|github.com/|' -e 's|\.git$$||')

CC=gcc

# The first "make" target runs as default.

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# C
# -----------------------------------------------------------------------------

lib/greeter.o: lib/greeter.c lib/greeter.h
	@$(CC) \
	  -c \
	  -fPIC \
	  -o lib/greeter.o \
	  lib/greeter.c


lib/greeter2.o: lib/greeter2.c lib/greeter2.h
	@$(CC) \
	  -c \
	  -fPIC \
	  -o lib/greeter2.o \
	  lib/greeter2.c


lib/libgreeter.a: lib/greeter.o lib/greeter2.o
	ar ruv lib/libgreeter.a lib/greeter.o lib/greeter2.o
	ranlib lib/libgreeter.a

lib/libgreeter.so: lib/greeter.o lib/greeter2.o
	@$(CC) \
	  -shared \
	  -o lib/libgreeter.so \
	  lib/greeter.o \
	  lib/greeter2.o

# -----------------------------------------------------------------------------
# Build
#   Notes:
#     "-a" needed to incorporate changes to C files.
# -----------------------------------------------------------------------------

.PHONY: dependencies
dependencies:
	@go get ./...
	@go get -u github.com/jstemmer/go-junit-report


.PHONY: build
build: build-linux

.PHONY: build-static
build-static: build-static-linux


.PHONY: build-linux
build-linux: lib/libgreeter.so
	@go build \
	  -a \
	  -ldflags \
	    "-X main.programName=${PROGRAM_NAME} \
	     -X main.buildVersion=${BUILD_VERSION} \
	     -X main.buildIteration=${BUILD_ITERATION} \
	    " \
	  ${GO_PACKAGE_NAME}
	@mkdir -p $(TARGET_DIRECTORY)/linux || true
	@mv $(PROGRAM_NAME) $(TARGET_DIRECTORY)/linux

.PHONY: build-static-linux
build-static-linux: lib/libgreeter.a
	CGO_ENABLED=0  \
	go build \
	  -a \
	  -ldflags \
	    "-X main.programName=${PROGRAM_NAME} \
	     -X main.buildVersion=${BUILD_VERSION} \
	     -X main.buildIteration=${BUILD_ITERATION} \
	    " \
	  ${GO_PACKAGE_NAME}
	@mkdir -p $(TARGET_DIRECTORY)/linux || true
	@mv $(PROGRAM_NAME) $(TARGET_DIRECTORY)/linux

.PHONY: build-macos
build-macos:
	@GOOS=darwin GOARCH=amd64 go build \
	  -ldflags \
	    "-X main.programName=${PROGRAM_NAME} \
	     -X main.buildVersion=${BUILD_VERSION} \
	     -X main.buildIteration=${BUILD_ITERATION} \
	     -X github.com/docktermj/go-hello-world-module.helloName=${HELLO_NAME} \
	    " \
	  $(GO_PACKAGE_NAME)
	@mkdir -p $(TARGET_DIRECTORY)/darwin || true
	@mv $(PROGRAM_NAME) $(TARGET_DIRECTORY)/darwin


.PHONY: build-windows
build-windows:
	@GOOS=windows GOARCH=amd64 go build \
	  -ldflags \
	    "-X main.programName=${PROGRAM_NAME} \
	     -X main.buildVersion=${BUILD_VERSION} \
	     -X main.buildIteration=${BUILD_ITERATION} \
	     -X github.com/docktermj/go-hello-world-module.helloName=${HELLO_NAME} \
	    " \
	  $(GO_PACKAGE_NAME)
	@mkdir -p $(TARGET_DIRECTORY)/windows || true
	@mv $(PROGRAM_NAME).exe $(TARGET_DIRECTORY)/windows

# -----------------------------------------------------------------------------
# Test
# -----------------------------------------------------------------------------

.PHONY: test
test:
	@go test $(GO_PACKAGE_NAME)/...

# -----------------------------------------------------------------------------
# Package
# -----------------------------------------------------------------------------

.PHONY: package
package: docker-package
	@mkdir -p $(TARGET_DIRECTORY) || true
	@CONTAINER_ID=$$(docker create $(DOCKER_IMAGE_NAME)); \
	docker cp $$CONTAINER_ID:/output/. $(TARGET_DIRECTORY)/; \
	docker rm -v $$CONTAINER_ID


.PHONY: docker-package
docker-package:
	@docker build \
		--build-arg PROGRAM_NAME=$(PROGRAM_NAME) \
		--build-arg BUILD_VERSION=$(BUILD_VERSION) \
		--build-arg BUILD_ITERATION=$(BUILD_ITERATION) \
		--build-arg GO_PACKAGE_NAME=$(GO_PACKAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME) \
		.

# -----------------------------------------------------------------------------
# Run
# -----------------------------------------------------------------------------

run:
	@target/linux/go-hello-cgo

# -----------------------------------------------------------------------------
# Utility targets
# -----------------------------------------------------------------------------

.PHONY: docker-run
docker-run:
	@docker run \
	    --interactive \
	    --tty \
	    --name $(DOCKER_CONTAINER_NAME) \
	    $(DOCKER_IMAGE_NAME)


.PHONY: clean
clean:
	@go clean -cache
	@docker rm --force $(DOCKER_CONTAINER_NAME) || true
	@rm -rf $(TARGET_DIRECTORY) || true
	@find . -type f -name '*.o' -exec rm {} +    # Remove recursively *.o files
	@find . -type f -name '*.so' -exec rm {} +   # Remove recursively *.so files
	@rm -f $(GOPATH)/bin/$(PROGRAM_NAME) || true


.PHONY: print-make-variables
print-make-variables:
	@$(foreach V,$(sort $(.VARIABLES)), \
	   $(if $(filter-out environment% default automatic, \
	   $(origin $V)),$(warning $V=$($V) ($(value $V)))))


.PHONY: help
help:
	@echo "Build $(PROGRAM_NAME) version $(BUILD_VERSION)-$(BUILD_ITERATION)".
	@echo "All targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
