#!/bin/bash

set -e

exec bash -c \
  "exec varnishd -F \
  -a :80 \
  -T localhost:6082 \
  -S /etc/varnish/secret \
  -p vcc_err_unref=off \
  -f $VCL_CONFIG \
  -s malloc,$CACHE_SIZE \
  $VARNISHD_PARAMS" 2>&1
