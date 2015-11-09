#!/bin/sh

apt-get -y install apt-transport-https
curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list
apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
apt-get -y install varnish
apt-get -y install munin-node
