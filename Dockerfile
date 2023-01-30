FROM rclone/rclone:1

RUN apk update

RUN apk add mariadb-client
