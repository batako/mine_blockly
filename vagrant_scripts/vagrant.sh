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

echo Setting Up Nginx...
cp /vagrant/vagrant_scripts/nginx/nginx.conf.template /vagrant/vagrant_scripts/nginx/nginx.conf
grep -l 'APP_ROOT' /vagrant/vagrant_scripts/nginx/nginx.conf | xargs sed -i -e 's/APP_ROOT/\/vagrant\/blockly/g'
/vagrant/vagrant_scripts/nginx/setup_nginx.sh
