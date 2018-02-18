#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo Installing Nginx...
sudo yum install -y nginx

echo Backing up nginx.conf...
if [ ! -e /etc/nginx/nginx.conf.original ] ; then
  sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
fi

echo Replacing nginx.conf...
sudo cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf

echo Enabling Nginx...
sudo systemctl enable nginx

echo Running Nginx...
sudo systemctl start nginx

echo Installing packages for Nginx...
sudo yum install -y policycoreutils-python

echo Installing SELinux policy for Nginx...
# sudo cat /var/log/audit/audit.log | grep nginx | audit2allow -m nginx
# sudo cat /var/log/audit/audit.log | audit2allow -M nginx
sudo semodule -i $SCRIPT_DIR/nginx.pp
