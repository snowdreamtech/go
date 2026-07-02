# Research Findings

## 1. Golang Official Source Build Process

**Decision**: We will replicate the `tip` logic found in the official `Dockerfile-linux.template`.

**Rationale**: The official image template handles version `tip` by fetching from the Git repository (or in our case, downloading a specific release tarball or Git tag). It then runs `./make.bash` in the `src` directory and configures environment variables like `GOCACHE`, `GOHOSTOS`, and `GOHOSTARCH`. We will align our Dockerfiles to do the same but base them on our `build-essential` tags. The user requested we build the latest version from source based on `build-essential`.

**Alternatives considered**: N/A (User specifically requested strict adherence to the official template's build-from-source logic).

## 2. Dockerfile Integration Strategy

**Decision**: The existing `ENV` and `ARG` sections in our current Alpine/Debian/Rocky Dockerfiles will be extended with the specific Golang `ENV` and `ARG` definitions required by the official template (e.g., `GOLANG_VERSION`, `PATH`).

**Rationale**: The user stated: "要尊重我们现在的dockerfile结构和现状。在现有基础上进行修改。" This means we don't start from scratch, but rather weave the Golang installation steps (the `RUN` command that downloads, verifies, and builds from source) into our existing files.

**Alternatives considered**: Overwriting the files entirely with the Golang template (Rejected because it violates the clarification to respect the current structure).
