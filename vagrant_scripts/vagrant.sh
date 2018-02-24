#!/usr/bin/env bash

APP_PATH=${APP_PATH:-/vagrant/blockly}
APP_ABSOLUTE_PATH=$(cd $APP_PATH; pwd)
SCRIPTS_PATH=${SCRIPTS_PATH:-/vagrant/vagrant_scripts}
SOCKETS_PATH=${SOCKETS_PATH:-$APP_ABSOLUTE_PATH/tmp/sockets}

echo Updating system...
sudo yum -y update

echo Installing ruby...
$SCRIPTS_PATH/install_ruby.sh

echo Installing rails...
APP_PATH=$APP_ABSOLUTE_PATH $SCRIPTS_PATH/install_rails.sh

echo Installing minetest...
$SCRIPTS_PATH/minetest/install_minetest.sh

echo Setting Up Nginx...
cp $SCRIPTS_PATH/nginx/nginx.conf.template $SCRIPTS_PATH/nginx/nginx.conf
grep -l 'APP_PATH' $SCRIPTS_PATH/nginx/nginx.conf | xargs sed -i -e 's/APP_PATH/'${APP_ABSOLUTE_PATH////\\/}'/g'
grep -l 'SOCKETS_PATH' $SCRIPTS_PATH/nginx/nginx.conf | xargs sed -i -e 's/SOCKETS_PATH/'${SOCKETS_PATH////\\/}'/g'
$SCRIPTS_PATH/nginx/setup_nginx.sh

echo Restarting shell...
exec $SHELL -l
