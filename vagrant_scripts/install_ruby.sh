#!/usr/bin/env bash

echo Installing packages for rbenv...
sudo yum install -y git openssl-devel readline-devel zlib-devel

echo Installing rbenv...
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
if [ -z "`grep 'rbenv' ~/.bash_profile`" ] ; then
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  source ~/.bash_profile
fi

echo Installing ruby 2.5.0...
rbenv install 2.5.0
rbenv global 2.5.0
