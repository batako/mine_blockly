#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
APP_PATH=${APP_PATH:-$(cd $__DIR__/../../blockly; pwd)}
BLOCKLY_USER=${BLOCKLY_USER:-$USER}
RUN_SCRIPT=$__DIR__/run.sh
SOCKETS_PATH=${SOCKETS_PATH:-/var/run/blockly}

echo Creating socket directory...
sudo mkdir -p $SOCKETS_PATH
sudo chown $BLOCKLY_USER.$BLOCKLY_USER $SOCKETS_PATH

echo Adding blockly service...
cp $__DIR__/blockly.service.template $__DIR__/blockly.service
grep -l 'BLOCKLY_USER' $__DIR__/blockly.service | xargs sed -i -e 's/BLOCKLY_USER/'$BLOCKLY_USER'/g'
grep -l 'APP_PATH' $__DIR__/blockly.service | xargs sed -i -e 's/APP_PATH/'${APP_PATH////\\/}'/g'
grep -l 'RUN_SCRIPT' $__DIR__/blockly.service | xargs sed -i -e 's/RUN_SCRIPT/'${RUN_SCRIPT////\\/}'/g'
sudo cp $__DIR__/blockly.service /etc/systemd/system/.
sudo systemctl enable blockly
sudo systemctl restart blockly
