#!/usr/bin/env bash

BREW_ROOT=${BREW_ROOT:-$HOME/.rbenv}

echo Installing packages for rbenv...
sudo yum install -y git openssl-devel readline-devel zlib-devel gcc gcc-c++

echo Installing rbenv...
git clone https://github.com/rbenv/rbenv.git $BREW_ROOT
git clone https://github.com/rbenv/ruby-build.git $BREW_ROOT/plugins/ruby-build
if [ -z "`grep 'rbenv' ~/.bash_profile`" ] ; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  source ~/.bash_profile
fi

echo Installing ruby 2.6.2...
rbenv install 2.6.2
rbenv global 2.6.2
