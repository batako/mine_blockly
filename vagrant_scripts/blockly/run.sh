#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
BIN_PATH=${BIN_PATH:-$HOME/.rbenv/shims}

cd $__DIR__/../../blockly

echo Installing gems...
$BIN_PATH/bundle install

echo Migrating database...
$BIN_PATH/rake db:migrate

echo Precompiling assets...
$BIN_PATH/rake assets:clean assets:precompile

echo Running puma...
RAILS_ENV=${RAILS_ENV:-production} \
  SOCKETS_PATH=${SOCKETS_PATH:-/var/run/blockly} \
  SECRET_KEY_BASE=$($BIN_PATH/rake secret) \
  BLOCKLY_MOD_HOME=${BLOCKLY_MOD_HOME:-$(cd $__DIR__/../../minetest; pwd)/blockly} \
  $BIN_PATH/pumactl start
