FROM snowdreamtech/debian:12.8.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Go Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Go on Debian. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
    org.opencontainers.image.base.name="snowdreamtech/go:debian" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="1.19.8" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/go"

    ENV GOLANG_VERSION=1.23.3-2~bpo12+1 \ 
    GOROOT=/usr/lib/go-1.23 \
    PATH=$PATH:/usr/lib/go-1.23/bin \
    GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,https://goproxy.io,direct

RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    -t bookworm-backports \
    golang-1.23=${GOLANG_VERSION} \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]