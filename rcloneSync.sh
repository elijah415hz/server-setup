#!/usr/bin/env sh

rclone --config="/etc/rclone.conf" sync /home/pi/server-setup/bind-mounts/nextcloud/data/blarvis/files OneBlarvis:ServerBackup/nextcloud-files/files --log-file /home/pi/rclone-logs.txt
