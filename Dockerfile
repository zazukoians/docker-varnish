FROM phusion/baseimage
MAINTAINER Adrian Gschwend <adrian.gschwend@zazuko.com>

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash
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
