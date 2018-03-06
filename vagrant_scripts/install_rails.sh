#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
APP_PATH=${APP_PATH:-$(cd $__DIR__/../blockly; pwd)}
BREW_ROOT=${BREW_ROOT:-$HOME/.rbenv}

echo Installing packages for rails...
sudo yum install -y libffi-devel sqlite-devel

echo Installing rails...
$BREW_ROOT/shims/gem install bundler
cd $APP_PATH
$BREW_ROOT/shims/bundle install

echo Setting Up SECRET_KEY_BASE...
if [ -z "$(grep 'SECRET_KEY_BASE' ~/.bash_profile)" ] ; then
  echo 'export SECRET_KEY_BASE=$(cd '$APP_PATH'; bundle exec rake secret)' >> ~/.bash_profile
fi
