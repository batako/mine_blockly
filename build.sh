cd $TRAVIS_BUILD_DIR/blockly
gem install bundler
bundle install -j$(getconf _NPROCESSORS_ONLN) --without development production --path vendor/bundle
bin/rails db:migrate RAILS_ENV=test
bundle exec rspec
