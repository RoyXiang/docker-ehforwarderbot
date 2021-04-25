FROM alpine:latest
MAINTAINER Roy Xiang <developer@royxiang.me>

LABEL \
    "traefik.enable"="true" \
    "traefik.http.routers.efb.rule"="Host(`efb.royxiang.me`)" \
    "traefik.http.services.efb.loadbalancer.server.port"="5000"

ARG PUID=1000
ARG PGID=1000
ARG USER=dokku

ENV LANG zh_CN.UTF-8
ENV HOME /home/$USER
ENV FFMPEG_BINARY /usr/bin/ffmpeg

RUN set -ex \
        && addgroup -g $PGID $USER \
        && adduser -D -u $PUID -G $USER $USER

WORKDIR $HOME

COPY --chown=$USER:$USER app/ $HOME/

RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
                ca-certificates \
                ffmpeg \
                libmagic \
                mailcap \
                python3 \
                py3-beautifulsoup4 \
                py3-cryptography \
                py3-pillow \
                py3-requests \
                py3-retrying \
                py3-yaml \
        && apk add --no-cache --virtual .build-deps \
                git \
                py3-pip \
                py3-wheel \
        && su - $USER -c "pip3 install -r requirements.txt" \
        && apk del .build-deps \
        && rm -rf /tmp/* $HOME/.cache

USER $USER
