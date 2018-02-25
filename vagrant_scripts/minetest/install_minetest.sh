#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
MINETEST_PATH=${MINETEST_PATH:-$HOME/.minetest}
MINETEST_USER=${MINETEST_USER:-$USER}

echo Adding repository for minetest...
curl -O http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7.noarch.rpm
rm epel-release-latest-7.noarch.rpm

echo Installing minetest...
sudo yum install -y minetest

echo Adding minetest-server service...
cp $__DIR__/minetest-server.service.template $__DIR__/minetest-server.service
grep -l 'MINETEST_USER' $__DIR__/minetest-server.service | xargs sed -i -e 's/MINETEST_USER/'$MINETEST_USER'/g'
grep -l 'MINETEST_PATH' $__DIR__/minetest-server.service | xargs sed -i -e 's/MINETEST_PATH/'${MINETEST_PATH////\\/}'/g'
sudo cp $__DIR__/minetest-server.service /etc/systemd/system/.
sudo systemctl enable minetest-server
sudo systemctl restart minetest-server
