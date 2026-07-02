# Go Image (Debian Variant)
# Extends snowdreamtech/debian with additional tooling and configuration.

FROM ghcr.io/snowdreamtech/build-essential:13.5.0-debian AS build

ENV PATH=/usr/local/go/bin:$PATH
COPY --from=golang:bookworm /usr/local/go /usr/local/goroot-bootstrap

ARG GOLANG_COMMIT=master
ENV GOLANG_COMMIT=$GOLANG_COMMIT

# install cgo-related dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	; \
	dpkgArch="$(dpkg --print-architecture)"; \
	if [ "$dpkgArch" = 'arm64' ]; then \
		apt-get install -y --no-install-recommends binutils-gold; \
	fi; \
	rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	now="$(date '+%s')"; \
	arch="$(dpkg --print-architecture)"; arch="${arch##*-}"; \
	case "$arch" in \
		'amd64') \
			export GOOS='linux' GOARCH='amd64' GOAMD64='v1'; \
			;; \
		'armel') \
			export GOOS='linux' GOARCH='arm' GOARM='5'; \
			;; \
		'armhf') \
			export GOOS='linux' GOARCH='arm' GOARM='7'; \
			;; \
		'arm64') \
			export GOOS='linux' GOARCH='arm64'; \
			;; \
		'i386') \
			export GOOS='linux' GOARCH='386' GO386='softfloat'; \
			;; \
		'mips64el') \
			export GOOS='linux' GOARCH='mips64le'; \
			;; \
		'ppc64el') \
			export GOOS='linux' GOARCH='ppc64le'; \
			;; \
		'riscv64') \
			export GOOS='linux' GOARCH='riscv64'; \
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
	git -C /usr/local/go fetch --depth 1 https://github.com/golang/go.git "$GOLANG_COMMIT:"; \
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
	if [ "$arch" = 'armhf' ]; then \
		[ -s /usr/local/go/go.env ]; \
		before="$(go env GOARM)"; [ "$before" != '7' ]; \
		{ \
			echo; \
			echo '# https://github.com/docker-library/golang/issues/494'; \
			echo 'GOARM=7'; \
		} >> /usr/local/go/go.env; \
		after="$(go env GOARM)"; [ "$after" = '7' ]; \
		touch -t "$touchy" /usr/local/go/go.env /usr/local/go; \
	fi; \
	\
	mkdir /target /target/usr /target/usr/local; \
	mv -vT /usr/local/go /target/usr/local/go; \
	ln -svfT /target/usr/local/go /usr/local/go; \
	touch -t "$touchy" /target/usr/local /target/usr /target; \
	\
	go version; \
	epoch="$(stat -c '%Y' /target/usr/local/go)"; \
	[ "$SOURCE_DATE_EPOCH" = "$epoch" ]; \
	find /target -newer /target/usr/local/go -exec sh -c 'ls -ld "$@" && exit "$#"' -- '{}' +; \
	rm -rf /usr/local/goroot-bootstrap

FROM ghcr.io/snowdreamtech/debian:13.5.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    DEBIAN_FRONTEND=noninteractive \
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
    org.opencontainers.image.title="Go Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Go on Debian. (i386, amd64, arm32v5, arm32v7, arm64, mips64le, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
    org.opencontainers.image.base.name="snowdreamtech/go:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${VERSION:-1.24.2}" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/go"

# Runtime Environment Configuration
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND} \
    KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR}

ENV GOTOOLCHAIN=local \
    GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

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
CMD ["/bin/bash"]
