#!/bin/sh

__DIR__=$(cd $(dirname $0); pwd)
APP_PATH=${APP_PATH:-$(cd $__DIR__/..; pwd)}

BLOCKLY_VERSION=0.5.0
BASE_IMAGE=$(cat $APP_PATH/docker/blockly/Dockerfile | grep FROM | tr ':' '\n' | grep -v FROM | tr '-' '\n' | tail -n +2)

if [ -n "$BASE_IMAGE" ]; then
  VERSION=$BLOCKLY_VERSION-$BASE_IMAGE
else
  VERSION=$BLOCKLY_VERSION
fi

git checkout build-docker
git merge develop
cp docker-compose.develop.yml docker-compose.yml
dcbf blockly
docker tag mine_blockly_blockly $USER/blockly:$VERSION
docker push $USER/blockly:$VERSION
drmi $USER/blockly:$VERSION
