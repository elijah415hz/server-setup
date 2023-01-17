FROM rclone/rclone:1

ENTRYPOINT []

# This runs cron in the foreground with loglevel 2
CMD [ "crond", "-l", "2", "-f" ]
