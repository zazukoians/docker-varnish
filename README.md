# Varnish Cache Docker image [![Build Status](https://travis-ci.org/zazukoians/docker-varnish.svg)](https://travis-ci.org/zazukoians/docker-varnish)[![](https://imagelayers.io/badge/zazukoians/varnish:latest.svg)](https://imagelayers.io/?images=zazukoians/varnish:latest)

This Docker image ships [Varnish Cache](https://www.varnish-cache.org/), an HTTP accelerator designed for content-heavy dynamic web sites as well as heavily consumed APIs by Varnish Software. It is based on [Baseimage-docker](https://github.com/phusion/baseimage-docker), which is a Docker optimized version of Ubuntu 16.04.

If you have any problems with this image please report issues on Github. Pull requests are also welcome.

The image includes [varnish-modules](https://github.com/varnish/varnish-modules/tree/0.15.0).

### Varnish environment variables

You can change its behavior by changing the following environment variables:

    ENV VCL_CONFIG      /etc/varnish/default.vcl
    ENV CACHE_SIZE      256m
    ENV VARNISHD_PARAMS ""

Default parameters were taken from the [The Varnish Tutorial](https://www.varnish-cache.org/docs/4.1/index.html). The default configuration file is shipped by Varnish Cache.

### Basing your Varnish image on this project

We do not recommend using this image as-is.

Here is how you should use it instead:

```
FROM zazukoians/varnish:<choose a version>

COPY your-varnish-config-file.vcl /etc/varnish/default.vcl
```

### SSL/TLS termination

Varnish does not support SSL/TLS termination. If you need this consider using something like [traefik](https://traefik.io/) or [hitch](https://github.com/varnish/hitch) in front. For hitch, we provide a Docker image [here](https://hub.docker.com/r/zazukoians/hitch).