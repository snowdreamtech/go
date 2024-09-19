FROM snowdreamtech/alpine:3.20.3

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
    
RUN apk add --no-cache go=1.22.7-r0

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]