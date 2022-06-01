#!/usr/bin/env bash

pushd $(dirname "${0}") > /dev/null

APPDIR=$(pwd -L)
HOME=$APPDIR

pip3 install -r "$APPDIR/requirements.txt"
pip3 install --no-deps -e git+https://github.com/RoyXiang/efb-wechat-slave.git@v2.0.7.post1#egg=efb-wechat-slave
pip3 install -e git+https://github.com/ehForwarderBot/efb-qq-plugin-go-cqhttp.git#egg=efb-qq-plugin-go-cqhttp

rm -rf .cache Library

popd > /dev/null
