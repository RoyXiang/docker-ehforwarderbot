FROM ghcr.io/linuxserver/baseimage-alpine:3.14

LABEL \
    "traefik.enable"="true" \
    "traefik.http.routers.efb.rule"="Host(`efb.royxiang.me`)" \
    "traefik.http.services.efb.loadbalancer.server.port"="5000"

COPY app/ /app/

ENV \
    LANG=zh_CN.UTF-8 \
    FFMPEG_BINARY=/usr/bin/ffmpeg

RUN set -ex \
        && apk add --no-cache --virtual .run-deps \
                ca-certificates \
                ffmpeg \
                mailcap \
                python3 \
                py3-aiohttp \
                py3-cachetools \
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
                py3-websocket-client \
                py3-yaml \
        && apk add --no-cache --virtual .build-deps \
                git \
                py3-pip \
                py3-wheel \
        && cd /app \
        && pip3 install -r requirements.txt \
        && apk del .build-deps \
        && rm -rf /tmp/* /var/cache/apk/* /root/.cache

COPY etc/ /etc/

WORKDIR /app

ENTRYPOINT []

CMD ["/init"]
