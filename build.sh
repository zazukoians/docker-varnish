#!/bin/sh

# build
apk --update add build-base
apk add python2
apk add libev
apk add libev-dev
apk add automake
apk add openssl
apk add openssl-dev
apk add bash
apk add autoconf
apk add curl
apk add byacc
apk add flex
apk add ncurses-dev
apk add pcre-dev
apk add libedit-dev
cd /tmp
curl -L https://repo.varnish-cache.org/source/varnish-5.1.2.tar.gz | tar xz
cd varnish-*
./configure --with-rst2man=/bin/true

# install
make
make install
#mkdir /etc/ssl/hitch
#adduser -h /var/lib/hitch -s /sbin/nologin -u 1000 -D hitch

# cleanup
cd /
rm -rf /tmp/*
apk del git build-base libev-dev automake autoconf openssl-dev flex byacc 
rm -rf /var/cache/apk/*
