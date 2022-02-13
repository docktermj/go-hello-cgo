# go-hello-cgo

Show how to use go's `cgo`.

## Contents

1. [Usage](#usage)
    1. [Invocation](#invocation)
1. [Usage](#usage)
    1. [Invocation](#invocation)
1. [Prerequisites](#prerequisites)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
1. [Development](#development)
    1. [Build](#build)
    1. [Run linux static file](#run-linux-static-file)
    1. [Run linux dynamic file](#run-linux-dynamic-file)
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
    export GIT_ACCOUNT_DIR=${GOPATH}/src/github.com/${GIT_ACCOUNT}
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/docktermj/KnowledgeBase/blob/master/HowTo/clone-repository.md)
   to install the Git repository.

## Development

### Build

1. Build.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build
    ```

   The results will be in the `${GIT_REPOSITORY_DIR}/target` directory.
   There will be binaries for the linux, macOS (darwin), and windows platforms.

### Run linux static file

1. Verify file is static.
   Example:

    ```console
    file ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-static
    ```

    Response (formatted):

    ```console
    /home/senzing/docktermj.git/go-hello-cgo/target/linux/go-hello-cgo-static:
    ELF 64-bit LSB executable,
    x86-64,
    version 1 (GNU/Linux),
    statically linked,
    for GNU/Linux 3.2.0,
    BuildID[sha1]=53a6e1c8f414b71a90f049bd7abc26e7e820389f,
    not stripped
    ```

    ```console
    $ ldd ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-static
    not a dynamic executable
    ```

1. Run.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make run-linux-static
    ```

    or

    ```console
    ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-static
    ```

### Run linux dynamic file

1. Set Go environment variables.
   Example:

    ```console
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GIT_REPOSITORY_DIR}/lib"
    ```

1. Verify file is dynamic.
   Example:

    ```console
    $ file ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-dynamic
    /home/senzing/docktermj.git/go-hello-cgo/target/linux/go-hello-cgo-dynamic: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/l, for GNU/Linux 3.2.0, BuildID[sha1]=161c513fec653ec60361fab0881c4a02034abdfc, not stripped
    ```

    ```console
    $ ldd ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-dynamic
    linux-vdso.so.1 (0x00007fffa2bd5000)
    libgreeter.so => /home/username/docktermj.git/go-hello-cgo/lib/libgreeter.so (0x00007f41961d0000)
    libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f4195fb1000)
    libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f4195bc0000)
    /lib64/ld-linux-x86-64.so.2 (0x00007f41963d2000)
    ```

1. Run.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make run-linux-dynamic
    ```

    or

    ```console
    ${GIT_REPOSITORY_DIR}/target/linux/go-hello-cgo-dynamic
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
    export CGO_CFLAGS="-I${GIT_REPOSITORY_DIR}/lib"
    export CGO_LDFLAGS="-L${GIT_REPOSITORY_DIR}/lib -lgreeter"
    cd ${GIT_REPOSITORY_DIR}
    go test github.com/docktermj/go-hello-cgo/...
    ```

### Cleanup

1. Delete.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
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

1. Determine if `go-hello-cgo` is installed.
   Example:

    ```console
    apt list --installed | grep go-hello-cgo
    ```

1. :pencil2: Install `go-hello-cgo`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target/linux
    sudo apt install ./go-hello-cgo_0.0.0_amd64.deb
    ```

1. Run command.
   Example:

    ```console
    go-hello-cgo-static
    ```

    ```console
    go-hello-cgo-dynamic
    ```

1. Remove `go-hello-cgo` from system.
   Example:

    ```console
    sudo apt-get remove go-hello-cgo
    ```

### Test RPM package on Centos

1. Determine if `go-hello-cgo` is installed.
   Example:

    ```console
    yum list installed | grep go-hello-cgo
    ```

1. :pencil2: Install `go-hello-cgo`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target/linux
    sudo yum install ./go-hello-cgo_0.0.0_amd64.rpm
    ```

1. Run command.
   Example:

    ```console
    go-hello-cgo-static
    ```

    ```console
    go-hello-cgo-dynamic
    ```

1. Remove `go-hello-cgo` from system.
   Example:

    ```console
    sudo yum remove go-hello-cgo
    ```

## References

1. [Example cgo (Golang) app that calls a native library with a C structure](http://www.mischiefblog.com/2014/06/26/example-cgo-golang-app-that-calls-a-native-library-with-a-c-structure/) - example doesn't work.
1. [An Overview of Go's Tooling](https://www.alexedwards.net/blog/an-overview-of-go-tooling)
    1. The reason for using `go build -a` is to avoid caching c binary files.
1. [Exploring shared objects in Go](https://blog.ksub.org/bytes/2017/02/12/exploring-shared-objects-in-go/)
1. [Linking golang statically](https://blog.hashbangbash.com/2014/04/linking-golang-statically/)
