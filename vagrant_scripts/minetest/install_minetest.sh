#!/usr/bin/env bash

__DIR__=$(cd $(dirname $0); pwd)
MINETEST_PATH=${MINETEST_PATH:-$(cd $__DIR__/../../minetest; pwd)}
MINETEST_USER=${MINETEST_USER:-$USER}
MINETEST_HOME=/home/$MINETEST_USER/.minetest
SAMPLE_WORLD_CONFIG=$__DIR__/../../minetest/worlds/world.mt.example
WORLD_PATH=${WORLD_PATH:-$(cd $__DIR__/../../minetest/worlds; pwd)/world}

echo Adding repository for minetest...
curl -O http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7.noarch.rpm
rm epel-release-latest-7.noarch.rpm

echo Installing minetest...
sudo yum install -y minetest

echo Creating symbolic link to $MINETEST_HOME...
if [ -L $MINETEST_HOME ]; then
  sudo unlink $MINETEST_HOME
elif [ -e $MINETEST_HOME ]; then
  sudo mv $MINETEST_HOME $MINETEST_HOME.$(date +%Y%m%d%H%M%S%3N)
fi
sudo -u $MINETEST_USER ln -s $MINETEST_PATH $MINETEST_HOME

echo Changing owner of $MINETEST_PATH...
sudo chown -R $MINETEST_USER.$MINETEST_USER $MINETEST_PATH

echo Copying world.mt.example to $WORLD_PATH/world.mt...
sudo -u $MINETEST_USER mkdir -p $WORLD_PATH
if [ -e $WORLD_PATH/world.mt ]; then
  echo "$WORLD_PATH/world.mt: File exists"
  read -p "overwrite? (y/N): " INPUT
  case $INPUT in
    [yY]*)
      sudo rm $WORLD_PATH/world.mt
      sudo -u $MINETEST_USER cp $SAMPLE_WORLD_CONFIG $WORLD_PATH/world.mt
    ;;
  esac
else
  sudo -u $MINETEST_USER cp $SAMPLE_WORLD_CONFIG $WORLD_PATH/world.mt
fi

echo Adding minetest-server service...
cp $__DIR__/minetest-server.service.template $__DIR__/minetest-server.service
grep -l 'MINETEST_USER' $__DIR__/minetest-server.service | xargs sed -i -e 's/MINETEST_USER/'$MINETEST_USER'/g'
sudo cp $__DIR__/minetest-server.service /etc/systemd/system/.
sudo systemctl enable minetest-server
sudo systemctl restart minetest-server

echo Setting up firewall rule for minetest-server...
sudo cp $__DIR__/minetest-server.xml /etc/firewalld/services/.
sudo firewall-cmd --add-service=minetest-server --permanent
sudo firewall-cmd --reload
