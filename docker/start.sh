#!/bin/bash

ruby render_template.rb

mkdir -p /tmp/lock
mkdir -p /tmp/cache

exec apache2ctl -f /tmp/httpd.conf -D FOREGROUND
