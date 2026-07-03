# Changelog

## [1.25.11](https://github.com/snowdreamtech/go/compare/alpine-v1.25.11...alpine-v1.25.11) (2026-07-03)


### 🚀 Features

* add CGO-related dependencies to final Alpine and Rocky images ([154bfa9](https://github.com/snowdreamtech/go/commit/154bfa9285264d1276d687cd8fe40446b9370b77))
* **alpine:** build golang from source with exact official template alignment ([5c595ff](https://github.com/snowdreamtech/go/commit/5c595ff35973fc2276883bd5f4bf7c0d8528e64f))
* restore custom Go environment variables in final stage ([9d975e0](https://github.com/snowdreamtech/go/commit/9d975e0a476b98e382b71334a457131b2892869a))


### 🐛 Bug Fixes

* add missing GOPATH directory creation from official template ([059a38a](https://github.com/snowdreamtech/go/commit/059a38a808423bc9c4827a510aa46af48aee6753))
* **alpine:** add empty line to trigger release pipeline test ([6f32fb1](https://github.com/snowdreamtech/go/commit/6f32fb1c9fae9bcd4e86beb2e3013a0138784372))
* bind Go source compilation target to dynamically passed VERSION build-arg ([e76a6b0](https://github.com/snowdreamtech/go/commit/e76a6b0f31f79a531126a16da21aac69a65eac1c))
* refine dynamic version binding to strictly check for numerical semantic versions ([ae0161d](https://github.com/snowdreamtech/go/commit/ae0161d2e1471d92484d64335747469f8aa78fa1))
* remove erroneous GOARM=7 patch block for armv7/armhf when building from source ([1b0ec88](https://github.com/snowdreamtech/go/commit/1b0ec88bc0155d5e15104df8b3b7b25239c50fac))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/go/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### 🛠 Refactoring

* adapt base template configurations for go project ([5337839](https://github.com/snowdreamtech/go/commit/5337839599e2f6fb8ac921afd3180bcd04db083b))
* convert Dockerfiles to multi-stage to drop build dependencies ([a94c987](https://github.com/snowdreamtech/go/commit/a94c987179b21b7d56fb02a6b2ec73b7c35ef064))
* **docker:** align Dockerfiles with base image structure ([232574f](https://github.com/snowdreamtech/go/commit/232574fed8418f8c7f257d001e951361dfa467a0))
* remove redundant docker-entrypoint.sh files ([87c576b](https://github.com/snowdreamtech/go/commit/87c576b27731ad11c5bc0ebc661e07c5a09ff1c1))
* reorganize distribution variants into docker directory ([67a8c91](https://github.com/snowdreamtech/go/commit/67a8c911e21801bf12b3e83d02e22f3b3f59a2ba))
* replace VERSION argument with GOLANG_VERSION for consistent release management ([a1302e5](https://github.com/snowdreamtech/go/commit/a1302e5ed96f4d205791f8490077d0665091c7bd))


### 📖 Documentation

* add detailed comments to entrypoint initialization scripts ([f42cbaa](https://github.com/snowdreamtech/go/commit/f42cbaab6edfbc5c38c2a636dfd8651fea900940))


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([61ec010](https://github.com/snowdreamtech/go/commit/61ec010538763d931e2e1731222359d585f8527d))
* **deps:** bump base images to alpine 3.24.0, debian 13.5.0, rocky 10.2.0 ([1688969](https://github.com/snowdreamtech/go/commit/168896956d2f4c7f91309c4c98ffef36ca7e8546))
* downgrade golang version to 1.25.11 ([e158e33](https://github.com/snowdreamtech/go/commit/e158e338f6f45bbd43ee3e5e795288fb1f1bb398))
* explicitly export GOARM64='v8.0' to align perfectly with official template configuration ([bf966ce](https://github.com/snowdreamtech/go/commit/bf966cecd0c94d45d02d6cc3de3795b8632ca509))
* explicitly export GORISCV64='rva20u64' for riscv64 architecture ([c4fd5da](https://github.com/snowdreamtech/go/commit/c4fd5da406ba74df767823619768a601ffdb6cf5))
* fully align CGO and SSL dependencies across all architectures ([13ae82f](https://github.com/snowdreamtech/go/commit/13ae82fc3a58d375569645dc136b915dc1d0463e))
* merge commit 'd0abd27b15586474e63bc88f00305e5305694f4a' into dev ([3aefeda](https://github.com/snowdreamtech/go/commit/3aefedabb1fbbc161b3432dee73bf7882f7cb266))
* release main ([ff778c2](https://github.com/snowdreamtech/go/commit/ff778c2bb784e9316c99a9734bfd6239c135f9b6))
* release main ([bd8c97c](https://github.com/snowdreamtech/go/commit/bd8c97c88571e04916225ad7e7b5a7e28b25143d))
* release main ([f66597a](https://github.com/snowdreamtech/go/commit/f66597a5feae95e8853f4cc730c81e93e172f6ca))
* release main ([b3a5cc9](https://github.com/snowdreamtech/go/commit/b3a5cc9ef0a64a7bc04ed7c2acf0cca5327c5c26))
* release main ([deb8454](https://github.com/snowdreamtech/go/commit/deb8454df7518d56939ab3851245a4cd7b03d709))
* release main ([d87cb81](https://github.com/snowdreamtech/go/commit/d87cb815685ad9b5b43d4b9a195c68dee2fd8065))
* release main ([78328d2](https://github.com/snowdreamtech/go/commit/78328d20bd3697d48ea90aee8d0eaa6af4ccc09c))
* release main ([b720ad5](https://github.com/snowdreamtech/go/commit/b720ad57dd1691d8ae07dcac7d46d0bd257af3a0))
* release main ([32dd84d](https://github.com/snowdreamtech/go/commit/32dd84de4be973395d0867b5d527d528948a35df))
* release main ([725c69f](https://github.com/snowdreamtech/go/commit/725c69fdcc222b5b83d0690629ce213a68c586ab))
* release main ([070b694](https://github.com/snowdreamtech/go/commit/070b694a702763b60fc6b057a81418320418cafa))
* release main ([36d1211](https://github.com/snowdreamtech/go/commit/36d1211036847a8c6aaa01a21a1c695a47b71d45))
* release main ([9ad4f94](https://github.com/snowdreamtech/go/commit/9ad4f9490832efdc310f2ebbd8c77f3404daf07f))
* release main ([b0684a3](https://github.com/snowdreamtech/go/commit/b0684a32a652e83506451e6056168cfec8b9142c))
* release main ([495e18a](https://github.com/snowdreamtech/go/commit/495e18a4babcb06a12c2f5aec9ea571d97cb32e3))
* release main ([d4a3a34](https://github.com/snowdreamtech/go/commit/d4a3a34b00a6b9f381cd5d556749c257516b2f08))
* release main ([9a64621](https://github.com/snowdreamtech/go/commit/9a646210a42f6795194825b7d1032f18a32cba89))
* release main ([28d9426](https://github.com/snowdreamtech/go/commit/28d94263f4374017274707faef7183917b689be9))
* **release:** deduplicate CHANGELOG headers ([647916e](https://github.com/snowdreamtech/go/commit/647916e8ef0ae255c02e86cd4f486e47ac321e86))
* **release:** deduplicate CHANGELOG headers ([47a29c8](https://github.com/snowdreamtech/go/commit/47a29c8624fd19f88c29fb7474ecadc22b488e98))
* **release:** deduplicate CHANGELOG headers ([82be3d5](https://github.com/snowdreamtech/go/commit/82be3d5576b65b7f69b1a9afb8604f2c8f0e47f7))
* **release:** deduplicate CHANGELOG headers ([d47fb44](https://github.com/snowdreamtech/go/commit/d47fb44cb105b368722d7d0e210a27b525f82d87))
* **release:** deduplicate CHANGELOG headers ([e795177](https://github.com/snowdreamtech/go/commit/e79517795d98b9f8292ef956586a6dc03932d03c))
* **release:** deduplicate CHANGELOG headers ([27919e4](https://github.com/snowdreamtech/go/commit/27919e4baf4aab5b2a2bf32a7d437b05a717c11b))
* **release:** deduplicate CHANGELOG headers ([438190d](https://github.com/snowdreamtech/go/commit/438190d297c151c75eca4912fdc22c285d5ec1ea))
* **release:** deduplicate CHANGELOG headers ([256f043](https://github.com/snowdreamtech/go/commit/256f04311b2344f2648ca5bcf407146f8c690258))
* **release:** deduplicate CHANGELOG headers ([d263aae](https://github.com/snowdreamtech/go/commit/d263aae7b223103a01dd0e114430381c5d863dd7))
* **release:** deduplicate CHANGELOG headers ([133954e](https://github.com/snowdreamtech/go/commit/133954e95cfae85cbba2fb9c1ac5acbc677ca39d))
* **release:** deduplicate CHANGELOG headers ([1d82410](https://github.com/snowdreamtech/go/commit/1d82410d6038be22d7741f1519826f30023b0f3e))
* **release:** deduplicate CHANGELOG headers ([5e1a539](https://github.com/snowdreamtech/go/commit/5e1a5390319933b48d20ad993714587d826c0aa7))
* **release:** implement automatic changelog deduplication step ([282c220](https://github.com/snowdreamtech/go/commit/282c22081e1ad7a1a010a7f297d20bc7c9b416a7))
* remove 10-base-init.sh from docker entrypoint variants ([ae1ce6a](https://github.com/snowdreamtech/go/commit/ae1ce6ad7c0937f41b77016e5c254e206dbfe545))
* reset release configs and changelogs for go repository ([bad2d2b](https://github.com/snowdreamtech/go/commit/bad2d2bc6013d776adba368b1cd442664fdffd52))
* synchronize Go versions with actual distribution packages ([c45ce0b](https://github.com/snowdreamtech/go/commit/c45ce0bf63f15c5e51e4d7253290ccc1f3f78d50))

## [1.26.3](https://github.com/snowdreamtech/go/compare/alpine-v1.26.3...alpine-v1.26.3) (2026-07-03)


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([61ec010](https://github.com/snowdreamtech/go/commit/61ec010538763d931e2e1731222359d585f8527d))
