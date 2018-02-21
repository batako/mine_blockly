#!/usr/bin/env bash

cd /vagrant/blockly

echo Installing gems...
bundle install --without test development

echo Migrating database...
bundle exec rake db:migrate RAILS_ENV=production

echo Precompiling assets...
bundle exec rake assets:clean assets:precompile RAILS_ENV=production

echo Running puma...
bundle exec pumactl start
