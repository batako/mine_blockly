#!/bin/sh

APP_ROOT=${APP_ROOT:-~/mine_blockly}

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /bin/docker-compose

sudo chmod +x /bin/docker-compose

sudo yum install -y git
git clone https://github.com/batako/mine_blockly.git $APP_ROOT

cd $APP_ROOT
git checkout develop
cp docker-compose.develop.yml docker-compose.yml
sudo docker-compose up -d
sudo docker-compose exec blockly rails db:migrate
