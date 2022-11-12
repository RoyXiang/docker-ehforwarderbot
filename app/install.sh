#!/usr/bin/env bash

pushd $(dirname "${0}") > /dev/null

APPDIR=$(pwd -L)
VIRTUALENV=".venv"

# create virtual environment
virtualenv --system-site-packages $VIRTUALENV
source $VIRTUALENV/bin/activate
pip3 install -U pip
# install basic packages
pip3 install -r $APPDIR/requirements.txt
# install forked version of efb-wechat-slave
pip3 install --no-deps -e git+https://github.com/RoyXiang/efb-wechat-slave.git@v2.0.7.post3#egg=efb-wechat-slave
# install latest version of efb-qq-slave
pip3 install --no-deps -e git+https://github.com/ehForwarderBot/efb-qq-slave.git@0df5ddc#egg=efb-qq-slave
pip3 uninstall -y cqhttp
sed -i '/^cqhttp/d' $VIRTUALENV/src/efb-qq-slave/efb_qq_slave.egg-info/requires.txt
echo "__version__ = '2.0.1'" > $VIRTUALENV/src/efb-qq-slave/efb_qq_slave/__version__.py
# install latest version of efb-qq-plugin-go-cqhttp
pip3 install "aiocqhttp~=1.4.3" "quart~=0.17.0" "pilk~=0.0.2"
pip3 install --no-deps -e git+https://github.com/ehForwarderBot/efb-qq-plugin-go-cqhttp.git@39f628a#egg=efb-qq-plugin-go-cqhttp
sed -i '/^Requires-Dist/d' $VIRTUALENV/lib/python3*/site-packages/efb_qq_plugin_go_cqhttp-*.dist-info/METADATA
# deactivate virtual environment
pip3 uninstall -y pip wheel
deactivate

popd > /dev/null

rm -rf /root/.cache /root/.local
