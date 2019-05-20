# 16.04 xenial
FROM phusion/baseimage:0.10.2
MAINTAINER Adrian Gschwend <adrian.gschwend@zazuko.com>

RUN apt-get install -y apt-transport-https 
RUN curl -L https://packagecloud.io/varnishcache/varnish5/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial main" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get -y install varnish=5.2.1-1~xenial varnish-dev=5.2.1-1~xenial

## compile varnish modules
RUN apt-get install -y make autoconf-archive git libtool m4 automake python-docutils
WORKDIR /tmp
RUN git clone https://github.com/varnish/varnish-modules && cd varnish-modules && git checkout 0.15.0
WORKDIR /tmp/varnish-modules
RUN ./bootstrap && \
  ./configure && \
  make && \
  make install

RUN mkdir /etc/service/varnishd
ADD run.sh /etc/service/varnishd/run

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      256m
ENV VARNISHD_PARAMS ""

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
