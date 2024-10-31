FROM ghcr.io/linuxserver/baseimage-alpine:3.16

RUN set -ex \
        && apk add --virtual .run-deps \
                ca-certificates \
                ffmpeg \
                libmagic \
                mailcap \
                python3 \
                py3-aiohttp \
                py3-cairocffi \
                py3-cryptography \
                py3-flask \
                py3-future \
                py3-jaraco-classes \
                py3-jaraco-functools \
                py3-peewee \
                py3-pillow \
                py3-requests \
                py3-retrying \
                py3-ruamel.yaml \
                py3-setuptools \
                py3-tempora \
                py3-ujson \
                py3-yaml \
                sqlite \
        && rm -rf /var/cache/apk/*

COPY app/ /app/

RUN set -ex \
        && apk add --virtual .build-deps \
                build-base \
                git \
                py3-pip \
                py3-wheel \
                python3-dev \
        && pip3 install uv \
        && uv pip install --system --override /app/overrides.txt -r /app/requirements.txt \
        && pip3 uninstall -y uv \
        && apk del .build-deps \
        && rm -rf /var/cache/apk/* /root/.cache /root/.local

ENV \
    LANG=zh_CN.UTF-8 \
    EFB_DATA_PATH=/config \
    EFB_PROFILE=default \
    FFMPEG_BINARY=/usr/bin/ffmpeg \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

COPY etc/ /etc/
