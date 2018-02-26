#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
APP_PATH=${APP_PATH:-$(cd $__DIR__/../blockly; pwd)}
SCRIPTS_PATH=${SCRIPTS_PATH:-$__DIR__}
SOCKETS_PATH=${SOCKETS_PATH:-/var/run/blockly}

echo Updating system...
sudo yum -y update

echo Installing ruby...
$SCRIPTS_PATH/install_ruby.sh

echo Installing rails...
$SCRIPTS_PATH/install_rails.sh

echo Setting up blockly...
$SCRIPTS_PATH/blockly/setup_blockly.sh

echo Installing minetest...
$SCRIPTS_PATH/minetest/install_minetest.sh

echo Setting Up Nginx...
cp $SCRIPTS_PATH/nginx/nginx.conf.template $SCRIPTS_PATH/nginx/nginx.conf
grep -l 'APP_PATH' $SCRIPTS_PATH/nginx/nginx.conf | xargs sed -i -e 's/APP_PATH/'${APP_PATH////\\/}'/g'
grep -l 'SOCKETS_PATH' $SCRIPTS_PATH/nginx/nginx.conf | xargs sed -i -e 's/SOCKETS_PATH/'${SOCKETS_PATH////\\/}'/g'
$SCRIPTS_PATH/nginx/setup_nginx.sh

echo Restarting shell...
exec $SHELL -l
