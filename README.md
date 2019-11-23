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
