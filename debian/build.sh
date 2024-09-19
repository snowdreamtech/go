#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/go
DOCKER_HUB_PROJECT1=snowdreamtech/golang
GITHUB_PROJECT=ghcr.io/snowdreamtech/go
GITHUB_PROJECT1=ghcr.io/snowdreamtech/golang

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/mips64le,linux/ppc64le,linux/s390x \
    -t ${DOCKER_HUB_PROJECT}:latest \
    -t ${DOCKER_HUB_PROJECT}:1.23.1 \
    -t ${DOCKER_HUB_PROJECT}:1.23 \
    -t ${DOCKER_HUB_PROJECT}:1 \
    -t ${GITHUB_PROJECT}:latest \
    -t ${GITHUB_PROJECT}:1.23.1 \
    -t ${GITHUB_PROJECT}:1.23 \
    -t ${GITHUB_PROJECT}:1 \
    -t ${DOCKER_HUB_PROJECT1}:latest \
    -t ${DOCKER_HUB_PROJECT1}:1.23.1 \
    -t ${DOCKER_HUB_PROJECT1}:1.23 \
    -t ${DOCKER_HUB_PROJECT1}:1 \
    -t ${GITHUB_PROJECT1}:latest \
    -t ${GITHUB_PROJECT1}:1.23.1 \
    -t ${GITHUB_PROJECT1}:1.23 \
    -t ${GITHUB_PROJECT1}:1 \
    . \
    --push
