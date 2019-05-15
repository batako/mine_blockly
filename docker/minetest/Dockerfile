FROM centos:7

ENV MINETEST_PATH /minetest
ENV MINETEST_HOME /var/lib/minetest/.minetest
ENV EPEL_FILE_NAME epel-release-latest-7.noarch.rpm
ENV EPEL_URL http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV MINETEST_DOWNLOAD_SHA256 33b8b8250960874014d7c66d04ef12df3a71277b9eb6f2146bba7553daeaf910

COPY minetest $MINETEST_PATH

WORKDIR /tmp
RUN yum -y update \
    && yum install -y sudo \
    && curl -o epel.rpm $EPEL_URL \
    && echo "${MINETEST_DOWNLOAD_SHA256} epel.rpm" | sha256sum -c - \
    && rpm -Uvh epel.rpm \
    && /bin/rm -f epel.rpm \
    && yum install -y minetest \
    && yum clean all \
    && chown -R minetest.minetest $MINETEST_PATH \
    && sudo -u minetest ln -s $MINETEST_PATH $MINETEST_HOME

WORKDIR $MINETEST_PATH
USER minetest

ENTRYPOINT ["minetestserver"]
CMD ["--quiet"]

EXPOSE 30000/udp