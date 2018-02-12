#!/usr/bin/env bash

echo Installing packages for rails...
sudo yum install -y libffi-devel sqlite-devel nodejs

echo Installing rails...
~/.rbenv/shims/gem install bundler
cd ~/blockly
~/.rbenv/shims/bundle install
