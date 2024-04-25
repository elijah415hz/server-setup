FROM rclone/rclone:1

RUN apk update

RUN apk add mariadb-client postgresql-client

RUN apk add curl
