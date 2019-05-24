FROM codercom/code-server as cs

FROM    golang:1-alpine AS cli

RUN     apk add -U git bash coreutils gcc musl-dev

RUN mkdir -p /go/src/github.com/docker/ && \
    cd /go/src/github.com/docker/ && \
    git clone https://github.com/docker/cli.git && \
    cd cli && \
    git checkout v18.09.6

ENV     CGO_ENABLED=0 \
        DISABLE_WARN_OUTSIDE_CONTAINER=1

WORKDIR /go/src/github.com/docker/cli
RUN     ./scripts/build/binary && strip ./build/docker

FROM webvariants/php:7.3

RUN apt-get update && apt-get install -y \
    openssl \
    net-tools \
    git \
    locales \
    sudo \
    dumb-init \
    vim \
    curl \
    wget \
    sqlite3 \
    zsh

COPY --from=cs /usr/local/bin/code-server /usr/local/bin/code-server

COPY --from=cli /go/src/github.com/docker/cli/build/docker /usr/local/bin/docker

ENV PATH ~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT ["dumb-init", "code-server"]

EXPOSE 8443

CMD []
