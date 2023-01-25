#!/usr/bin/env sh

rclone --config="/config/rclone/rclone.conf" sync /usr/ServerBackup OneBlarvis:ServerBackup  --include /*.env --include /bind-mounts/** --log-file /usr/rclone-logs.txt
