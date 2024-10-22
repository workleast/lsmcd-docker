FROM ubuntu:bionic
LABEL maintainer="workleast.com"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
 git build-essential zlib1g-dev libexpat1-dev openssl libssl-dev \
 libsasl2-dev libpcre3-dev sasl2-bin systemd \
 && git clone https://github.com/litespeedtech/lsmcd.git \
 && cd lsmcd && ./fixtimestamp.sh \
 && ./configure CFLAGS=" -O3" CXXFLAGS=" -O3" \
 && make && make install \
 && rm -R /lsmcd \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get remove -y git build-essential zlib1g-dev libexpat1-dev openssl libssl-dev \
 libsasl2-dev libpcre3-dev sasl2-bin

COPY entrypoint.sh /sbin/entrypoint.sh
COPY conf/node.conf /usr/local/lsmcd/conf/node.conf
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 11211/tcp 11211/udp
ENTRYPOINT ["/sbin/entrypoint.sh"]
