\*Install list for host raspberry pi:

Install Docker, Git, Docker-Compose

https://dev.to/elalemanyo/how-to-install-docker-and-docker-compose-on-raspberry-pi-1mo

`sudo crontab -e`
`0 1 * * * rclone sync /home/pi/server-setup/bind-mounts/nextcloud/data/blarvis CryptBlarvis:ServerBackup/nextcloud-files`

Example restore for mariadb:
docker exec -i some-mariadb sh -c 'exec mysql -uroot -p"$MARIADB_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql
