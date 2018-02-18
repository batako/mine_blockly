#!/usr/bin/env bash

echo Installing packages for rails...
sudo yum install -y libffi-devel sqlite-devel nodejs

echo Installing rails...
~/.rbenv/shims/gem install bundler
cd ~/blockly
~/.rbenv/shims/bundle install

echo Setting Up SECRET_KEY_BASE...
if [ -z $(grep 'SECRET_KEY_BASE' ~/.bash_profile) ] ; then
  echo 'export SECRET_KEY_BASE=$(cd ~/blockly; bundle exec rake secret)' >> ~/.bash_profile
fi
