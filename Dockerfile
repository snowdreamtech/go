FROM snowdreamtech/alpine:3.20.0

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV GO111MODULE=on \
    GOPROXY=https://proxy.golang.org,https://goproxy.io,direct
    
RUN apk add --no-cache go=1.22.5-r0

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]