#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
APP_PATH=$__DIR__/../blockly

cd $APP_PATH

echo Installing gems...
bundle install

echo Migrating database...
bundle exec rake db:migrate

echo Precompiling assets...
bundle exec rake assets:clean assets:precompile

echo Running puma...
bundle exec pumactl start
