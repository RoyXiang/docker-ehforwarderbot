FROM ghcr.io/linuxserver/baseimage-alpine:3.16

LABEL \
    "traefik.enable"="true" \
    "traefik.http.routers.efb.rule"="Host(`efb.royxiang.me`)" \
    "traefik.http.services.efb.loadbalancer.server.port"="5000"

ENV \
    LANG=zh_CN.UTF-8 \
    FFMPEG_BINARY=/usr/bin/ffmpeg

RUN set -ex \
        && apk add --virtual .run-deps \
                ca-certificates \
                ffmpeg \
                mailcap \
                python3 \
                py3-aiohttp \
                py3-cryptography \
                py3-flask \
                py3-future \
                py3-jaraco-classes \
                py3-jaraco-functools \
                py3-magic \
                py3-peewee \
                py3-pillow \
                py3-requests \
                py3-retrying \
                py3-ruamel.yaml \
                py3-setuptools \
                py3-tempora \
                py3-tornado \
                py3-ujson \
                py3-yaml \
        && rm -rf /tmp/* /var/cache/apk/*

COPY app/ /app/

RUN set -ex \
        && apk add --virtual .build-deps \
                build-base \
                git \
                py3-pip \
                py3-wheel \
                python3-dev \
        && /app/install.sh \
        && apk del .build-deps \
        && rm -rf /tmp/* /var/cache/apk/*

COPY etc/ /etc/

WORKDIR /app

ENTRYPOINT []

CMD ["/init"]
