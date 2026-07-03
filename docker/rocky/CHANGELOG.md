# Changelog

## [1.26.3](https://github.com/snowdreamtech/go/compare/rocky-v1.26.3...rocky-v1.26.3) (2026-07-03)


### ♻️ Miscellaneous Chores

* add 0-git-keep.sh to prevent empty entrypoint.d directories ([61ec010](https://github.com/snowdreamtech/go/commit/61ec010538763d931e2e1731222359d585f8527d))

## [1.26.3](https://github.com/snowdreamtech/go/compare/rocky-v1.26.3...rocky-v1.26.3) (2026-07-03)


### 🚀 Features

* add CGO-related dependencies to final Alpine and Rocky images ([154bfa9](https://github.com/snowdreamtech/go/commit/154bfa9285264d1276d687cd8fe40446b9370b77))
* restore custom Go environment variables in final stage ([9d975e0](https://github.com/snowdreamtech/go/commit/9d975e0a476b98e382b71334a457131b2892869a))
* **rocky:** build golang from source with exact official template alignment ([f33c5c6](https://github.com/snowdreamtech/go/commit/f33c5c68b7432fcd2471ec87a3a92637ae565c11))


### 🐛 Bug Fixes

* add missing GOPATH directory creation from official template ([059a38a](https://github.com/snowdreamtech/go/commit/059a38a808423bc9c4827a510aa46af48aee6753))
* bind Go source compilation target to dynamically passed VERSION build-arg ([e76a6b0](https://github.com/snowdreamtech/go/commit/e76a6b0f31f79a531126a16da21aac69a65eac1c))
* **docker:** upgrade rocky bootstrap from golang:bookworm to golang:trixie ([cca8a5b](https://github.com/snowdreamtech/go/commit/cca8a5b3185c11a41bfb2e448d016f7ffc6df0cc))
* limit mirrorlist modification to rocky repos to avoid breaking epel ([e2fce45](https://github.com/snowdreamtech/go/commit/e2fce458f7b9f8254a810e358c20c1ff15c1a4e9))
* refine dynamic version binding to strictly check for numerical semantic versions ([ae0161d](https://github.com/snowdreamtech/go/commit/ae0161d2e1471d92484d64335747469f8aa78fa1))
* use ghcr.io for base images to avoid rate limits ([9f1d73a](https://github.com/snowdreamtech/go/commit/9f1d73a75a61f2f368f5572c4bd28f4c92ef8fd5))


### 🛠 Refactoring

* convert Dockerfiles to multi-stage to drop build dependencies ([a94c987](https://github.com/snowdreamtech/go/commit/a94c987179b21b7d56fb02a6b2ec73b7c35ef064))


### ♻️ Miscellaneous Chores

* explicitly export GOARM64='v8.0' to align perfectly with official template configuration ([bf966ce](https://github.com/snowdreamtech/go/commit/bf966cecd0c94d45d02d6cc3de3795b8632ca509))
* fully align CGO and SSL dependencies across all architectures ([13ae82f](https://github.com/snowdreamtech/go/commit/13ae82fc3a58d375569645dc136b915dc1d0463e))
* merge commit 'd0abd27b15586474e63bc88f00305e5305694f4a' into dev ([3aefeda](https://github.com/snowdreamtech/go/commit/3aefedabb1fbbc161b3432dee73bf7882f7cb266))
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
* **speckit:** manual auto-commit trigger ([2512495](https://github.com/snowdreamtech/go/commit/2512495cc6e6af0044e0aaf789c58a871a286009))
