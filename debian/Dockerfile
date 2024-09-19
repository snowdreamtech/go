FROM snowdreamtech/debian:12.7.0

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
      org.opencontainers.image.title="Alpine Base Image" \
      org.opencontainers.image.description="Docker Images for Alpine. (i386,amd64,arm32v5,arm32v7,arm64,mips64le,ppc64le,s390x)" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
      org.opencontainers.image.base.name="snowdreamtech/go:latest" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
      org.opencontainers.image.vendor="Snowdream Tech" \
      org.opencontainers.image.version="1.23.1" \
      org.opencontainers.image.url="https://github.com/snowdreamtech/go"

ENV GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,https://goproxy.io,direct
    
RUN set -eux \
    && apt-get -qqy update  \
    && apt-get -qqy install --no-install-recommends \ 
    golang=2:1.19~1 \
    && apt-get -qqy --purge autoremove \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]