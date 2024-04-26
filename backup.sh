#!/usr/bin/env sh

sendMail () {
    sub=$1
    fileName=$2

    if [ -z "$fileName" ]
    then
        fileName="/tmp/hooray"
        echo "Hooray" > /tmp/hooray
    fi

    body=$(cat $fileName)

    curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    --mail-from $GMAIL_ADDRESS \
    --mail-rcpt $GMAIL_ADDRESS \
    --user $GMAIL_ADDRESS:$GMAIL_APP_PASSWORD \
    -H "Subject: $sub" \
    -F "=$body;type=text/plain"
}

mkdir -p nextcloud-db-backup

curl https://hc-ping.com/3c40f149-93ee-4803-94fa-5657d876d734

mysqldump --single-transaction -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE &> /tmp/sqlDumpOrErr.sql
if [ $? -ne 0 ]
then
    sendMail "MysqlDump failed" /tmp/sqlDumpOrErr.sql
else
    mv /tmp/sqlDumpOrErr.sql /usr/ServerBackup/bind-mounts/nextcloud-db-backup/nextcloud-mysql-dump-backup.sql
fi

pg_dumpall -U paperless -h paperless-db  -d paperless -f /tmp/paperlessSqlDumpOrErr.sql 2> /tmp/paperlessSqlDumpOrErr.sql
if [ $? -ne 0 ]
then
    sendMail "Paperless pg-dump failed failed" /tmp/paperlessSqlDumpOrErr.sql
else
    mv /tmp/paperlessSqlDumpOrErr.sql /usr/ServerBackup/bind-mounts/paperless-db-backup/paperless-pg-dump-backup.sql
fi

rclone --config="/config/rclone/rclone.conf" copy /usr/ServerBackup OneBlarvis:ServerBackup  --include /*.env &> /tmp/rclone-env-logs.txt
if [ $? -ne 0 ]
then
    sendMail "Rclone sync of env variables failed" /tmp/rclone-env-logs.txt
fi

rclone --config="/config/rclone/rclone.conf" sync /usr/ServerBackup/bind-mounts OneBlarvis:ServerBackup/bind-mounts  --exclude /caddy/** --exclude /nextcloud_db/** &> /tmp/rclone-bind-mounts-logs.txt
if [ $? -ne 0 ]
then
    sendMail "Rclone sync of bind-mounts failed" /tmp/rclone-bind-mounts-logs.txt
fi
