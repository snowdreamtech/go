# Feature Specification: Build Golang From Source

**Feature Branch**: `001-build-golang-source`

**Created**: 2026-07-02

**Status**: Draft

**Input**: User description: "1. 简单一句话，基于编辑环境镜像<https://github.com/snowdreamtech/build-essential，从源码构建最新的golang> docker镜像。 2. 分别以下面的镜像位基础镜像： ghcr.io/snowdreamtech/build-essential:3.24.0-alpine ghcr.io/snowdreamtech/build-essential:13.5.0-debian ghcr.io/snowdreamtech/build-essential:10.2.0-rocky 3. 严格参考golang官方镜像dockerfile，通过上面的基础镜像，来构建我们的最新版本golang <https://raw.githubusercontent.com/docker-library/golang/refs/heads/master/Dockerfile-linux.template> 4. 官方镜像的设置ARG，ENV，一个也不能丢，要保留。 官方镜像对于Debian中Arm64的构建， binutils-gold 操作也要保留 5. WORKDIR $GOPATH 也改到$GOPATH去。"

## Clarifications

### Session 2026-07-02

- Q: 现有Dockerfile结构如何处理？ → A: 要尊重我们现在的dockerfile结构和现状。在现有基础上进行修改。

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Build Golang Alpine Image (Priority: P1)

As a developer, I want to build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:3.24.0-alpine` from source, so that I can use a consistent Alpine base with the latest Golang.

**Why this priority**: Alpine is commonly used for minimal Docker images and is a core target.

**Independent Test**: Can be independently tested by building the Dockerfile in the `docker/alpine` directory and verifying the Golang version and environment variables.

**Acceptance Scenarios**:

1. **Given** the `build-essential:3.24.0-alpine` base, **When** the Dockerfile is built, **Then** it successfully compiles Golang from source and results in a usable `go` binary.
2. **Given** the built image, **When** running `go version`, **Then** it returns the expected latest Golang version.

---

### User Story 2 - Build Golang Debian Image (Priority: P1)

As a developer, I want to build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:13.5.0-debian` from source, ensuring specific platform hacks like `binutils-gold` for ARM64 are preserved.

**Why this priority**: Debian is a standard robust base for containerized applications.

**Independent Test**: Can be tested by building the `docker/debian` Dockerfile on an ARM64 architecture to verify `binutils-gold` handling and general compilation.

**Acceptance Scenarios**:

1. **Given** the `build-essential:13.5.0-debian` base on ARM64, **When** the Dockerfile is built, **Then** `binutils-gold` is correctly applied during the build process.
2. **Given** the built Debian image, **When** inspecting the environment, **Then** all standard Golang ENV and ARG variables are present.

---

### User Story 3 - Build Golang Rocky Image (Priority: P1)

As a developer, I want to build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:10.2.0-rocky` from source.

**Why this priority**: Rocky Linux provides enterprise-grade stability and is required for certain deployments.

**Independent Test**: Can be independently tested by building the Dockerfile in the `docker/rocky` directory.

**Acceptance Scenarios**:

1. **Given** the `build-essential:10.2.0-rocky` base, **When** the Dockerfile is built, **Then** it successfully compiles Golang from source and creates a functional image.

### Edge Cases

- What happens when a specific architecture (like `s390x` or `ppc64le`) lacks support in the base `build-essential` image?
- How does the build process handle network failures while fetching the Golang source code?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST use `ghcr.io/snowdreamtech/build-essential:3.24.0-alpine`, `13.5.0-debian`, and `10.2.0-rocky` as the respective base images.
- **FR-002**: The Dockerfiles MUST strictly reference the official Golang `Dockerfile-linux.template` logic for building from source.
- **FR-003**: The Dockerfiles MUST preserve all `ARG` and `ENV` variables defined in the official Golang Dockerfile template.
- **FR-004**: The Dockerfiles MUST preserve the `binutils-gold` operation specifically for Debian on ARM64 architectures.
- **FR-005**: The Dockerfiles MUST set `WORKDIR $GOPATH`.
- **FR-006**: The Dockerfiles MUST respect and preserve the current repository's existing Dockerfile structure, metadata (`LABEL`), and build arguments (`ARG BUILDTIME`, `VERSION`, `REVISION`, etc.), applying the new build-from-source logic on top of the existing foundation.

### Key Entities

- **Dockerfile**: The recipe to build the Golang images.
- **Base Image**: The `build-essential` image which provides the compiler toolchain.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Docker images for Alpine, Debian, and Rocky can be built successfully from source within the CI pipeline.
- **SC-002**: The resulting images correctly execute `go build` and `go run` for a standard "Hello World" application.
- **SC-003**: `docker inspect` reveals all required `ENV` and `ARG` variables match the official Golang equivalents.
- **SC-004**: The working directory inside the container defaults to the evaluated path of `$GOPATH`.

## Assumptions

- The `ghcr.io/snowdreamtech/build-essential` images already contain necessary build tools (like `gcc`, `make`, `git`, `bash`) required to compile Golang from source.
- Network connectivity allows fetching the Golang source tarball.
