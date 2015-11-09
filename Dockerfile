FROM phusion/baseimage
MAINTAINER Adrian Gschwend <adrian.gschwend@zazuko.com>

ADD install.sh /tmp/install.sh
RUN /tmp/install.sh

RUN mkdir /etc/service/varnishd
ADD run.sh /etc/service/varnishd/run

# TODO munin

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      256m
ENV VARNISHD_PARAMS ""

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
EXPOSE 80 4949

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*