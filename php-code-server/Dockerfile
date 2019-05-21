FROM codercom/code-server as cs

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

ENV PATH ~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENTRYPOINT ["dumb-init", "code-server"]

EXPOSE 8443

CMD []
