#!/usr/bin/env bash

APP_PATH=${APP_PATH:-/vagrant/blockly}
APP_ABSOLUTE_PATH=$(cd $APP_PATH; pwd)
SCRIPTS_PATH=${SCRIPTS_PATH:-/vagrant/vagrant_scripts}

echo Adding repository for both nodejs and minetest...
curl -O http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7.noarch.rpm
rm epel-release-latest-7.noarch.rpm

echo Updating system...
sudo yum -y update

echo Installing ruby...
$SCRIPTS_PATH/install_ruby.sh

echo Installing rails...
APP_PATH=$APP_ABSOLUTE_PATH $SCRIPTS_PATH/install_rails.sh

echo Installing minetest...
sudo yum install -y minetest

echo Setting Up Nginx...
cp $SCRIPTS_PATH/nginx/nginx.conf.template $SCRIPTS_PATH/nginx/nginx.conf
grep -l 'APP_PATH' $SCRIPTS_PATH/nginx/nginx.conf | xargs sed -i -e 's/APP_PATH/'${APP_ABSOLUTE_PATH////\\/}'/g'
$SCRIPTS_PATH/nginx/setup_nginx.sh
