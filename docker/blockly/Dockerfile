FROM ruby:2.6.5-alpine3.11

ENV LANG C.UTF-8
ENV APP_HOME /blockly

WORKDIR $APP_HOME
ADD [ \
    "blockly/Gemfile", \
    "blockly/Gemfile.lock", \
    "blockly/package.json", \
    "blockly/yarn.lock", \
    "./" \
]

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
        git \
        nodejs \
        openssh \
        ruby-json \
        sqlite-dev \
        tzdata \
        xz-libs \
        yaml \
        # test environment
        less \
        # deployment environment
        yarn \
    && gem install bundler -v 2.1.4 \
    && bundle install -j4 \
    && yarn install \
    && apk del .build-dependencies \
    && mkdir -p tmp/sockets tmp/pids minetest \
    && addgroup -g 1000 -S blockly \
    && adduser -u 1000 -S blockly -G blockly \
    && chown -R blockly:blockly $APP_HOME

USER blockly

ENTRYPOINT ["pumactl", "start"]
