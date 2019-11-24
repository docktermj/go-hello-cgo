# go-hello-cgo

Show how to use go's `cgo`.

## Contents

1. [Usage](#usage)
    1. [Invocation](#invocation)
1. [Prerequisites](#prerequisites)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Set environment variables](#set-environment-variables)
1. [Development](#development)
    1. [Download dependencies](#download-dependencies)
    1. [Build](#build)
    1. [Run](#run)
    1. [Test](#test)
    1. [Cleanup](#cleanup)
1. [Package](#package)
    1. [Package RPM and DEB files](#package-rpm-and-deb-files)
    1. [Test DEB package on Ubuntu](#test-deb-package-on-ubuntu)
    1. [Test RPM package on Centos](#test-rpm-package-on-centos)
1. [References](#references)

## Usage

### Invocation

## Prerequisites

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/docktermj/KnowledgeBase/blob/master/software/git.md#installation)
1. [docker](https://github.com/docktermj/KnowledgeBase/blob/master/software/docker.md#installation)
1. [go](https://github.com/docktermj/KnowledgeBase/blob/master/software/go.md#installation)

### Clone repository

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=docktermj
    export GIT_REPOSITORY=go-hello-cgo
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/docktermj/KnowledgeBase/blob/master/HowTo/clone-repository.md)
   to install the Git repository.

### Set environment variables

1. :pencil2: Set Go environment variables.
   Example:

    ```console
    export GOPATH="${HOME}/go"
    export PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
    ```

## Development

### Download dependencies

1. Dependencies.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make dependencies
    ```

### Build

1. Set environment variables.
   Example:

    ```console
    export CGO_LDFLAGS="-L${GIT_REPOSITORY_DIR}/lib"

    ```

1. Build.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build
    ```

   The results will be in the `${GIT_REPOSITORY_DIR}/target` directory.
   There will be binaries for the linux, macOS (darwin), and windows platforms.

### Run

1. Run.
   Example:

    ```console
    ${GIT_REPOSITORY_DIR}/target/linux/go-hello-world
    ```

    or

    ```console
    cd ${GIT_REPOSITORY_DIR}
    go run main.go
    ```

### Test

1. Test
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make test
    ```

    or

    ```console
    cd ${GIT_REPOSITORY_DIR}
    go test
    ```

### Cleanup

1. Delete.
   Example:

    ```console
    cd ${REPOSITORY_DIR}
    make clean
    ```

## Package

### Package RPM and DEB files

1. Use make target to run a docker images that builds RPM and DEB files.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make package
    ```

   The results will be in the `${GIT_REPOSITORY_DIR}/target` directory.

### Test DEB package on Ubuntu

1. Determine if `go-hello-world` is installed.
   Example:

    ```console
    apt list --installed | grep go-hello-world
    ```

1. :pencil2: Install `go-hello-world`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target
    sudo apt install ./go-hello-world_0.0.0_amd64.deb
    ```

1. Run command.
   Example:

    ```console
    go-hello-world
    ```

1. Remove `go-hello-world` from system.
   Example:

    ```console
    sudo apt-get remove go-hello-world
    ```

### Test RPM package on Centos

1. Determine if `go-hello-world` is installed.
   Example:

    ```console
    yum list installed | grep go-hello-world
    ```

1. :pencil2: Install `go-hello-world`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target
    sudo yum install ./go-hello-world_0.0.0_amd64.rpm
    ```

1. Run command.
   Example:

    ```console
    go-hello-world
    ```

1. Remove `go-hello-world` from system.
   Example:

    ```console
    sudo yum remove go-hello-world
    ```

## References

1. [Example cgo (Golang) app that calls a native library with a C structure](http://www.mischiefblog.com/2014/06/26/example-cgo-golang-app-that-calls-a-native-library-with-a-c-structure/) - example doesn't work.
1. [An Overview of Go's Tooling](https://www.alexedwards.net/blog/an-overview-of-go-tooling)
    1. The reason for using `go build -a` in
