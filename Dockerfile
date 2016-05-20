FROM phusion/baseimage
MAINTAINER Adrian Gschwend <adrian.gschwend@zazuko.com>

RUN apt-get install -y apt-transport-https 
RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
RUN echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get -y install varnish

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
