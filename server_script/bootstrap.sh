#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
SCRIPTS_PATH=$__DIR__/../vagrant_scripts
APP_PATH=$__DIR__/../blockly
SOCKETS_PATH=/var/run
MINETEST_PATH=$__DIR__/../minetest

echo Running bootstrap...
APP_PATH=$APP_PATH SOCKETS_PATH=$SOCKETS_PATH SCRIPTS_PATH=$SCRIPTS_PATH MINETEST_PATH=$MINETEST_PATH $SCRIPTS_PATH/vagrant.sh
