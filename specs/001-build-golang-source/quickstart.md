# Quickstart Validation Guide

This guide describes how to validate the newly generated Golang Docker images built from source.

## Prerequisites

- Docker Engine installed and running.
- Access to the internet to download Golang source code during the build.

## Build the Images

Run the following commands from the repository root:

### Alpine

```bash
docker build -t snowdreamtech/go:alpine-test -f docker/alpine/Dockerfile .
```

### Debian

```bash
docker build -t snowdreamtech/go:debian-test -f docker/debian/Dockerfile .
```

### Rocky Linux

```bash
docker build -t snowdreamtech/go:rocky-test -f docker/rocky/Dockerfile .
```

## Validate the Images

### 1. Verify Golang Version

Run the container to ensure `go version` returns the expected built version.

```bash
docker run --rm snowdreamtech/go:alpine-test go version
```

### 2. Verify Environment Variables

Inspect the built image to confirm `GOPATH` and other Golang environment variables are correctly set.

```bash
docker inspect snowdreamtech/go:alpine-test --format '{{.Config.Env}}'
docker inspect snowdreamtech/go:alpine-test --format '{{.Config.WorkingDir}}'
```

*Expected Outcome*: The working directory is set to the evaluated value of `$GOPATH`, and all standard Golang env vars are present.

### 3. Compile a "Hello World" Application

Validate that the compiler toolchain works end-to-end.

```bash
docker run --rm -v $(pwd):/app -w /app snowdreamtech/go:alpine-test sh -c "echo 'package main; import \"fmt\"; func main() { fmt.Println(\"Hello, World!\") }' > main.go && go run main.go"
```

*Expected Outcome*: Outputs `Hello, World!`.
