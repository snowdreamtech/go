# Go Image (Rocky Variant)
# Extends snowdreamtech/rocky with additional tooling and configuration.

FROM ghcr.io/snowdreamtech/build-essential:10.2.0-rocky AS build

ENV PATH=/usr/local/go/bin:$PATH
COPY --from=golang:trixie /usr/local/go /usr/local/goroot-bootstrap

ARG VERSION
ARG GOLANG_COMMIT=master
ENV GOLANG_COMMIT=$GOLANG_COMMIT

RUN set -eux; \
	now="$(date '+%s')"; \
	arch="$(uname -m)"; \
	case "$arch" in \
		'x86_64') \
			export GOOS='linux' GOARCH='amd64' GOAMD64='v1'; \
			;; \
		'aarch64') \
			export GOOS='linux' GOARCH='arm64' GOARM64='v8.0'; \
			;; \
		'ppc64le') \
			export GOOS='linux' GOARCH='ppc64le'; \
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
	if [ -n "${VERSION:-}" ] && echo "${VERSION}" | grep -Eq '^[0-9]'; then \
		fetch_commit="go${VERSION}"; \
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
	go version; \
	epoch="$(stat -c '%Y' /target/usr/local/go)"; \
	[ "$SOURCE_DATE_EPOCH" = "$epoch" ]; \
	find /target -newer /target/usr/local/go -exec sh -c 'ls -ld "$@" && exit "$#"' -- '{}' +; \
	rm -rf /usr/local/goroot-bootstrap

FROM ghcr.io/snowdreamtech/rocky:10.2.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
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
    org.opencontainers.image.title="Go Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for Go on Rocky. (amd64, arm64, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
    org.opencontainers.image.base.name="snowdreamtech/go:rocky" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${VERSION:-1.25.11}" \
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

ENV GOLANG_VERSION=${VERSION} \
    GOTOOLCHAIN=local \
    GOPATH=/go \
    GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,direct \
    GOSUMDB=sum.golang.org \
    CGO_ENABLED=0
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Use the official Rocky baseurl so CI egress allowlists do not depend on
# third-party mirrors returned by the dynamic mirrorlist.
RUN set -eux; \
    for repo_file in /etc/yum.repos.d/rocky*.repo; do \
        [ -f "$repo_file" ] || continue; \
        sed -ri "s!^(mirrorlist|metalink)=!#&!g; s!^#baseurl=http://dl\\.rockylinux\\.org/\\\$contentdir/!baseurl=https://dl.rockylinux.org/pub/rocky/!g" "$repo_file"; \
    done; \
    dnf install -y ca-certificates gcc gcc-c++ make glibc-devel pkgconfig; \
    dnf clean all; \
    rm -rf /var/cache/dnf

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
