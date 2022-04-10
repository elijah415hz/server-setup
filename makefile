files-scan:
	docker exec -ti --user www-data server-setup-nextcloud-1 /var/www/html/occ files:scan --all

update_images:
	docker-compose pull && docker-compose up -d