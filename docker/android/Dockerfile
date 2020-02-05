FROM ubuntu:bionic

ENV MINETEST /minetest
ENV SDK_VERSION 4333796
ENV NDK_VERSION r17c
ENV ANDROID_SDK_HOME /opt/android-sdk
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; \
    apt-get install -y \
        build-essential \
        clang \
        expect \
        git \
        lib32z1 \
        libncurses5 \
        m4 \
        make \
        openjdk-8-jdk \
        subversion \
        unzip \
        wget \
    ; \
    cd /tmp; \
    wget -qq https://dl.google.com/android/repository/sdk-tools-linux-$SDK_VERSION.zip; \
    unzip -qq sdk-tools-linux-$SDK_VERSION.zip -d /opt/android-sdk; \
    rm sdk-tools-linux-$SDK_VERSION.zip; \
    echo 'set timeout -1;'                                         >  /tmp/sdk-license.exp; \
    echo 'spawn /opt/android-sdk/tools/bin/sdkmanager --licenses;' >> /tmp/sdk-license.exp; \
    echo 'expect {'                                                >> /tmp/sdk-license.exp; \
    echo '    "y/N" { exp_send "y\r" ; exp_continue }'             >> /tmp/sdk-license.exp; \
    echo '    eof'                                                 >> /tmp/sdk-license.exp; \
    echo '}'                                                       >> /tmp/sdk-license.exp; \
    expect /tmp/sdk-license.exp; \
    rm /tmp/sdk-license.exp; \
    wget -qq https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux-x86_64.zip; \
    unzip -qq android-ndk-$NDK_VERSION-linux-x86_64.zip -d /opt; \
    rm android-ndk-$NDK_VERSION-linux-x86_64.zip; \
    mv /opt/android-ndk-$NDK_VERSION /opt/android-ndk; \
    git clone --depth 1 https://github.com/minetest/minetest.git $MINETEST; \
    git clone --depth 1 https://github.com/minetest/minetest_game.git $MINETEST/games/minetest_game; \
    echo "sdk.dir=$ANDROID_SDK_HOME" > $MINETEST/build/android/local.properties; \
    echo "ndk.dir=$ANDROID_NDK_HOME" >> $MINETEST/build/android/local.properties;

RUN cd $MINETEST/build/android; \
    make -j$(getconf _NPROCESSORS_ONLN);

WORKDIR $MINETEST/build/android
