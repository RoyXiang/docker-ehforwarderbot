FROM alpine:latest
MAINTAINER Roy Xiang <developer@royxiang.me>

ENV LANG C.UTF-8
ENV PUID 1000
ENV PGID 1000
ENV HOME /home/dokku
ENV FFMPEG_BINARY /usr/bin/ffmpeg

RUN set -ex \
        && addgroup -g $PGID dokku \
        && adduser -D -u $PUID -G dokku dokku

WORKDIR /home/dokku

COPY app/ /home/dokku/

RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
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
        && pip3 install -r requirements.txt \
        && apk del .build-deps \
        && rm -rf /tmp/*

USER dokku
