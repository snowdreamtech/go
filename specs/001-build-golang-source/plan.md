# Implementation Plan: Build Golang From Source

**Branch**: `001-build-golang-source` | **Date**: 2026-07-02 | **Spec**: [spec.md](file:///Users/snowdream/Workspace/snowdreamtech/go/specs/001-build-golang-source/spec.md)

**Input**: Feature specification from `specs/001-build-golang-source/spec.md`

## Summary

This feature updates the Dockerfiles for Alpine, Debian, and Rocky Linux variants to build the latest Golang versions strictly from source (rather than downloading pre-compiled binaries). The build process will rely on `ghcr.io/snowdreamtech/build-essential` tags (`3.24.0-alpine`, `13.5.0-debian`, `10.2.0-rocky`) as foundational layers. We will strictly adhere to the official Golang `Dockerfile-linux.template`, retaining all `ENV` and `ARG` directives, preserving the `binutils-gold` step for Debian ARM64, and ensuring `WORKDIR $GOPATH` executes properly. The existing structure and metadata labels of the repository will be respected.

## Technical Context

**Language/Version**: Dockerfile / Bash Scripting

**Primary Dependencies**: `ghcr.io/snowdreamtech/build-essential` (`3.24.0-alpine`, `13.5.0-debian`, `10.2.0-rocky`)

**Storage**: N/A

**Testing**: Standard Docker build process combined with checking the compiled version using `go version`.

**Target Platform**: Linux containers (Alpine, Debian, Rocky) mapped to multiple CPU architectures (amd64, arm64, etc.).

**Project Type**: Container Build System / Docker images

**Performance Goals**: N/A

**Constraints**:
- Must preserve existing Dockerfile file structure and metadata/labels.
- Must execute ARM64 `binutils-gold` modifications.
- Must correctly evaluate `WORKDIR $GOPATH`.

**Scale/Scope**: Modifying 3 core Dockerfiles across 3 operating system variants.

## Constitution Check

*GATE: Passed. No new languages or unapproved frameworks are introduced.*
- Strict alignment with existing standards.

## Project Structure

### Documentation (this feature)

```text
specs/001-build-golang-source/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
docker/
├── alpine/
│   └── Dockerfile
├── debian/
│   └── Dockerfile
└── rocky/
    └── Dockerfile
```

**Structure Decision**: We will edit the existing Dockerfiles directly without changing their directory layouts.

## Complexity Tracking

> N/A
