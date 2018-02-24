#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
ROOT=$__DIR__/../..
MINETEST_PATH=$(cd $ROOT/minetest; pwd)

echo Adding repository for minetest...
curl -O http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7.noarch.rpm
rm epel-release-latest-7.noarch.rpm

echo Installing minetest...
sudo yum install -y minetest

echo Creating symbolic link to /var/lib/minetest/.minetest
sudo -u minetest ln -s $MINETEST_PATH /var/lib/minetest/.minetest

echo Changing owner of .minetest...
sudo chown -R minetest.minetest $MINETEST_PATH

echo Adding minetest-server service...
sudo cp $__DIR__/minetest-server.service /etc/systemd/system/.
sudo systemctl enable minetest-server
sudo systemctl restart minetest-server
