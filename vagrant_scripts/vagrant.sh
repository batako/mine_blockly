#!/usr/bin/env bash

echo Updating system...
sudo yum -y update

echo Installing ruby...
/vagrant/vagrant_scripts/install_ruby.sh
