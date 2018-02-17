#!/usr/bin/env bash

echo Installing Nginx...
sudo yum install -y nginx

echo Backing up nginx.conf...
if [ ! -e /etc/nginx/nginx.conf.original ] ; then
  sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
fi

echo Replacing nginx.conf...
SCRIPT_DIR=$(cd $(dirname $0); pwd)
sudo cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf

echo Enabling Nginx...
sudo systemctl enable nginx

echo Running Nginx...
sudo systemctl start nginx
