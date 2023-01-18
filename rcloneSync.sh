#!/usr/bin/env sh

rclone --config="/config/rclone/rclone.conf" sync /usr/nextcloud-files/files OneBlarvis:ServerBackup/nextcloud-files/files --log-file /usr/rclone-logs.txt
