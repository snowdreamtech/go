# Tasks: Build Golang From Source

**Input**: Design documents from `/specs/001-build-golang-source/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, quickstart.md

**Tests**: Tests are NOT included as they were not explicitly requested in the feature specification, but the quickstart.md provides manual validation commands.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

*(No shared setup tasks required for this feature since it modifies existing independent Dockerfiles)*

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

*(No foundational tasks required for this feature)*

---

## Phase 3: User Story 1 - Build Golang Alpine Image (Priority: P1) 🎯 MVP

**Goal**: Build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:3.24.0-alpine` from source, so that I can use a consistent Alpine base with the latest Golang.

**Independent Test**: Can be independently tested by building the Dockerfile in the `docker/alpine` directory and verifying the Golang version and environment variables.

### Implementation for User Story 1

- [ ] T001 [P] [US1] Extract Golang source build logic from `Dockerfile-linux.template` and integrate it into `docker/alpine/Dockerfile`.
- [ ] T002 [P] [US1] Preserve all official `ENV` and `ARG` variables (like `GOLANG_VERSION`, `PATH`) in `docker/alpine/Dockerfile`.
- [ ] T003 [P] [US1] Change `WORKDIR` to `$GOPATH` in `docker/alpine/Dockerfile`.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Build Golang Debian Image (Priority: P1)

**Goal**: Build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:13.5.0-debian` from source, ensuring specific platform hacks like `binutils-gold` for ARM64 are preserved.

**Independent Test**: Can be tested by building the `docker/debian` Dockerfile on an ARM64 architecture to verify `binutils-gold` handling and general compilation.

### Implementation for User Story 2

- [ ] T004 [P] [US2] Extract Golang source build logic and integrate it into `docker/debian/Dockerfile`.
- [ ] T005 [P] [US2] Preserve the `binutils-gold` operation specifically for Debian ARM64 in `docker/debian/Dockerfile`.
- [ ] T006 [P] [US2] Preserve all official `ENV` and `ARG` variables in `docker/debian/Dockerfile`.
- [ ] T007 [P] [US2] Change `WORKDIR` to `$GOPATH` in `docker/debian/Dockerfile`.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently.

---

## Phase 5: User Story 3 - Build Golang Rocky Image (Priority: P1)

**Goal**: Build a Golang Docker image based on `ghcr.io/snowdreamtech/build-essential:10.2.0-rocky` from source.

**Independent Test**: Can be independently tested by building the Dockerfile in the `docker/rocky` directory.

### Implementation for User Story 3

- [ ] T008 [P] [US3] Extract Golang source build logic and integrate it into `docker/rocky/Dockerfile`.
- [ ] T009 [P] [US3] Preserve all official `ENV` and `ARG` variables in `docker/rocky/Dockerfile`.
- [ ] T010 [P] [US3] Change `WORKDIR` to `$GOPATH` in `docker/rocky/Dockerfile`.

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T011 Run quickstart.md validation to test Alpine, Debian, and Rocky builds.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: N/A
- **Foundational (Phase 2)**: N/A
- **User Stories (Phase 3-5)**: Since there are no Foundational prerequisites, User Stories 1, 2, and 3 can be started immediately.
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **User Story 1 (P1)**: No dependencies.
- **User Story 2 (P1)**: No dependencies.
- **User Story 3 (P1)**: No dependencies.

### Within Each User Story

- Core implementation before integration.
- Story complete before moving to next priority.

### Parallel Opportunities

- All three User Stories modify different files (`docker/alpine/Dockerfile`, `docker/debian/Dockerfile`, `docker/rocky/Dockerfile`) and can be executed entirely in parallel.

---

## Parallel Example: User Story 1

```bash
# Launch all tasks for User Story 1 together:
Task: "Extract Golang source build logic from Dockerfile-linux.template and integrate it into docker/alpine/Dockerfile."
Task: "Preserve all official ENV and ARG variables in docker/alpine/Dockerfile."
Task: "Change WORKDIR to $GOPATH in docker/alpine/Dockerfile."
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 3: User Story 1 (Alpine Build).
2. **STOP and VALIDATE**: Test User Story 1 independently using the commands in `quickstart.md`.
3. Deploy/demo if ready.

### Incremental Delivery

1. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
2. Add User Story 2 → Test independently → Deploy/Demo
3. Add User Story 3 → Test independently → Deploy/Demo
4. Each story adds value without breaking previous stories.
