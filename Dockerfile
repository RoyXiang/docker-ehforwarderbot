FROM alpine:latest
MAINTAINER Roy Xiang <developer@royxiang.me>

ENV LANG C.UTF-8
ENV PUID 1000
ENV PGID 1000
ENV HOME /home/dokku
ENV FFMPEG_BINARY /usr/bin/ffmpeg

RUN set -ex \
        && apk add --no-cache \
                ffmpeg \
                libmagic \
                mailcap \
                python3 \
                py3-cryptography \
                py3-pillow \
                py3-pip \
                py3-yaml \
        && addgroup -g $PGID dokku \
        && adduser -D -u $PUID -G dokku dokku \
        && mkdir /app

WORKDIR /home/dokku

COPY app/ /home/dokku/

RUN pip3 install -r requirements.txt

USER dokku
