FROM snowdreamtech/alpine:3.20.3

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
      org.opencontainers.image.title="Go Image Based On Alpine" \
      org.opencontainers.image.description="Docker Images for Go on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
      org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/go" \
      org.opencontainers.image.base.name="snowdreamtech/go:alpine" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/snowdreamtech/go" \
      org.opencontainers.image.vendor="Snowdream Tech" \
      org.opencontainers.image.version="1.23.1" \
      org.opencontainers.image.url="https://github.com/snowdreamtech/go"

ENV GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,https://goproxy.io,direct
    
RUN apk add --no-cache go@community=1.23.1-r0

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]