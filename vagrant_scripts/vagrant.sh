#!/usr/bin/env bash

echo Adding repository for both nodejs and minetest...
curl -O http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7.noarch.rpm
rm epel-release-latest-7.noarch.rpm

echo Updating system...
sudo yum -y update

echo Installing ruby...
/vagrant/vagrant_scripts/install_ruby.sh

echo Installing rails...
/vagrant/vagrant_scripts/install_rails.sh

echo Installing minetest...
sudo yum install -y minetest
