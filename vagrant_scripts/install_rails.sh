#!/usr/bin/env bash

APP_PATH=${APP_PATH:-/vagrant/blockly}

echo Installing packages for rails...
sudo yum install -y libffi-devel sqlite-devel

echo Installing rails...
~/.rbenv/shims/gem install bundler
cd $APP_PATH
~/.rbenv/shims/bundle install

echo Setting Up SECRET_KEY_BASE...
if [ -z $(grep 'SECRET_KEY_BASE' ~/.bash_profile) ] ; then
  echo 'export SECRET_KEY_BASE=$(cd '$APP_PATH'; bundle exec rake secret)' >> ~/.bash_profile
fi
