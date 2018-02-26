#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
BIN_PATH=${BIN_PATH:-$HOME/.rbenv/shims}
SOCKETS_PATH=${SOCKETS_PATH:-/var/run/blockly}

cd $__DIR__/../../blockly

echo Installing gems...
$BIN_PATH/bundle install

echo Migrating database...
$BIN_PATH/rake db:migrate

echo Precompiling assets...
$BIN_PATH/rake assets:clean assets:precompile

echo Creating $SOCKETS_PATH...
/usr/bin/sudo /usr/bin/mkdir $SOCKETS_PATH

echo Creating socket directory...
/usr/bin/sudo mkdir -p $SOCKETS_PATH
/usr/bin/sudo chown $USER.$USER $SOCKETS_PATH

echo Running puma...
RAILS_ENV=${RAILS_ENV:-production} \
  SOCKETS_PATH=$SOCKETS_PATH \
  SECRET_KEY_BASE=$($BIN_PATH/rake secret) \
  BLOCKLY_MOD_HOME=${BLOCKLY_MOD_HOME:-$(cd $__DIR__/../../minetest; pwd)/blockly} \
  $BIN_PATH/pumactl start
