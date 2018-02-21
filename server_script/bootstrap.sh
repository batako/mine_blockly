#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
SCRIPTS_PATH=$__DIR__/../vagrant_scripts
APP_PATH=$__DIR__/../blockly

echo Running bootstrap...
APP_PATH=$APP_PATH SCRIPTS_PATH=$SCRIPTS_PATH $SCRIPTS_PATH/vagrant.sh
