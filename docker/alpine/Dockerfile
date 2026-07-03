# Go Image (Alpine Variant)
# Extends snowdreamtech/alpine with additional tooling and configuration.

FROM ghcr.io/snowdreamtech/build-essential:3.24.0-alpine AS build

ENV PATH=/usr/local/go/bin:$PATH
COPY --from=golang:alpine /usr/local/go /usr/local/goroot-bootstrap

# x-release-please-start-version
ARG GOLANG_VERSION="1.26.3"
# x-release-please-end
ARG GOLANG_COMMIT=master
ENV GOLANG_COMMIT=$GOLANG_COMMIT

RUN set -eux; \
	now="$(date '+%s')"; \
	apk add --no-cache --virtual .fetch-deps \
		bash \
		git \
	; \
	arch="$(apk --print-arch)"; \
	case "$arch" in \
		'x86_64') \
			export GOOS='linux' GOARCH='amd64' GOAMD64='v1'; \
			;; \
		'armhf') \
			export GOOS='linux' GOARCH='arm' GOARM='6'; \
			;; \
		'armv7') \
			export GOOS='linux' GOARCH='arm' GOARM='7'; \
			;; \
		'aarch64') \
			export GOOS='linux' GOARCH='arm64' GOARM64='v8.0'; \
			;; \
		'x86') \
			export GOOS='linux' GOARCH='386' GO386='softfloat'; \
			;; \
		'ppc64le') \
			export GOOS='linux' GOARCH='ppc64le'; \
			;; \
		'riscv64') \
			export GOOS='linux' GOARCH='riscv64' GORISCV64='rva20u64'; \
			;; \
		's390x') \
			export GOOS='linux' GOARCH='s390x'; \
			;; \
		*) echo >&2 "error: unsupported architecture '$arch' (likely packaging update needed)"; exit 1 ;; \
	esac; \
	\
	export GOROOT_BOOTSTRAP=/usr/local/goroot-bootstrap; \
	"$GOROOT_BOOTSTRAP/bin/go" version; \
	\
	git init --quiet /usr/local/go; \
	fetch_commit="$GOLANG_COMMIT"; \
	if [ -n "${GOLANG_VERSION:-}" ] && echo "${GOLANG_VERSION}" | grep -Eq '^[0-9]'; then \
		fetch_commit="go${GOLANG_VERSION}"; \
	fi; \
	git -C /usr/local/go fetch --depth 1 https://github.com/golang/go.git "$fetch_commit:"; \
	git -C /usr/local/go checkout --quiet FETCH_HEAD; \
	\
	SOURCE_DATE_EPOCH="$(git -C /usr/local/go log -1 --format='format:%ct' HEAD)"; \
	export SOURCE_DATE_EPOCH; \
	touchy="$(date -d "@$SOURCE_DATE_EPOCH" '+%Y%m%d%H%M.%S')"; \
	date --date "@$SOURCE_DATE_EPOCH" --rfc-2822; \
	[ "$SOURCE_DATE_EPOCH" -lt "$now" ]; \
	\
	( \
		export \
			GOCACHE='/tmp/gocache' \
			GOHOSTOS="$GOOS" \
			GOHOSTARCH="$GOARCH" \
		; \
		\
		cd /usr/local/go/src; \
		./make.bash; \
		\
		rm -rf \
			/usr/local/go/.git* \
			/usr/local/go/pkg/*/cmd \
			/usr/local/go/pkg/bootstrap \
			/usr/local/go/pkg/obj \
			/usr/local/go/pkg/tool/*/api \
			/usr/local/go/pkg/tool/*/go_bootstrap \
			/usr/local/go/src/cmd/dist/dist \
			"$GOCACHE" \
		; \
		\
		touch -t "$touchy" /usr/local/.go-date-stamp; \
		find /usr/local/go -depth -newer /usr/local/.go-date-stamp -exec touch -ht "$touchy" '{}' +; \
		rm /usr/local/.go-date-stamp; \
	); \
	\

	mkdir /target /target/usr /target/usr/local; \
	mv -vT /usr/local/go /target/usr/local/go; \
	ln -svfT /target/usr/local/go /usr/local/go; \
	touch -t "$touchy" /target/usr/local /target/usr /target; \
	\
	apk del --no-network .fetch-deps; \
	\
	go version; \
	epoch="$(stat -c '%Y' /target/usr/local/go)"; \
	[ "$SOURCE_DATE_EPOCH" = "$epoch" ]; \
	find /target -newer /target/usr/local/go -exec sh -c 'ls -ld "$@" && exit "$#"' -- '{}' +; \
	rm -rf /usr/local/goroot-bootstrap

FROM ghcr.io/snowdreamtech/alpine:3.24.0

# Build-time Configuration
# x-release-please-start-version
ARG GOLANG_VERSION="1.26.3"
# x-release-please-end
ARG BUILDTIME \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Go Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Go on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
    org.opencontainers.image.base.name="snowdreamtech/go:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${GOLANG_VERSION}" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/go"

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR}

ENV GOLANG_VERSION=${GOLANG_VERSION} \
    GOTOOLCHAIN=local \
    GOPATH=/go \
    GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,direct \
    GOSUMDB=sum.golang.org \
    CGO_ENABLED=0
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# install cgo-related dependencies
RUN set -eux; \
    apk add --no-cache ca-certificates gcc g++ musl-dev make pkgconf

COPY --from=build --link /target/ /
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 1777 "$GOPATH"

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
USER root
WORKDIR $GOPATH
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/sh"]
