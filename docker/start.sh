#!/bin/bash

ruby render_template.rb

exec apache2ctl -D FOREGROUND
