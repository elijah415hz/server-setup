#!/bin/bash
# Put the following in the crontab
# @reboot /home/pi/server-setup/reload-caddy.sh

sleep 10
cd /home/pi/server-setup
caddy stop
caddy start

