FROM alpine:3.11

ENV MINETEST_HOME /minetest

RUN apk update; \
    apk add --update --no-cache --virtual=.build-dependencies \
        build-base \
        bzip2-dev \
        cmake \
        git \
        jpeg-dev \
        jsoncpp-dev \
        libxxf86vm-dev \
        mesa-dev \
        zlib-dev \
    ; \
    apk add --update --no-cache \
        curl-dev \
        freetype-dev \
        gmp-dev \
        irrlicht-dev \
        libogg-dev \
        libpng-dev \
        libvorbis-dev \
        luajit-dev \
        openal-soft-dev \
        sqlite-dev \
    ; \
    git clone --depth 1 -b 0.4.17.1 https://github.com/minetest/minetest.git $MINETEST_HOME; \
    git clone --depth 1 -b 0.4.17.1 https://github.com/minetest/minetest_game.git $MINETEST_HOME/games/minetest_game; \
    cd $MINETEST_HOME; \
    cmake . -DRUN_IN_PLACE=TRUE; \
    make -j$(getconf _NPROCESSORS_ONLN); \
    addgroup -S minetest; \
    adduser -S minetest -G minetest; \
    chown -R minetest:minetest $MINETEST_HOME; \
    apk del --purge .build-dependencies;

COPY --chown=minetest:minetest home $MINETEST_HOME

WORKDIR $MINETEST_HOME

USER minetest

ENTRYPOINT ["bin/minetest"]
CMD ["--server", "--quiet"]

EXPOSE 30000/udp