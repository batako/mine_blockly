FROM ruby:2.6.3-alpine3.9

ENV LANG C.UTF-8
ENV APP_HOME /blockly

WORKDIR $APP_HOME
ADD ["blockly/Gemfile", "blockly/Gemfile.lock", "./"]

RUN apk update \
    && apk add --update --no-cache --virtual=.build-dependencies \
        build-base \
        curl-dev \
        libxml2-dev \
        libxslt-dev \
        linux-headers \
        ruby-dev \
        yaml-dev \
        zlib-dev \
    && apk add --update --no-cache \
        nodejs \
        openssh \
        ruby-json \
        sqlite-dev \
        tzdata \
        yaml \
    && gem install bundler -v 2.0.1 \
    && bundle install -j4 \
    && apk del .build-dependencies \
    && mkdir -p $APP_HOME/tmp/sockets $APP_HOME/tmp/pids

ENTRYPOINT ["pumactl", "start"]