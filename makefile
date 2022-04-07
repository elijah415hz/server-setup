scan:
	docker exec -ti --user www-data server-setup-nextcloud-1 /var/www/html/occ files:scan --all