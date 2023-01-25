init:
	@echo "Initializing finances app"
	make -C finances-flask init
	@echo "Initializing portfolio"
	make -C portfolio init

files-scan:
	docker exec -ti --user www-data server-setup-nextcloud-1 /var/www/html/occ files:scan --all

update-images:
	docker-compose pull && docker-compose up -d

deploy-finances:
	@echo "Updating..."
	git submodule update finances-flask
	@echo "Building..."
	npm run --prefix finances-flask build
	@echo "Deploying..."
	docker-compose up -d --force-recreate finances-app

deploy-portfolio:
	@echo "Updating..."
	git submodule update portfolio
	@echo "Building..."
	npm run --prefix portfolio build
	@echo "Deploying..."
	docker-compose up -d --force-recreate caddy

restore:
	@echo "Restoring files from OneDrive..."
	docker run --rm \
	--volume $(PWD):/usr/ServerBackup
	--volume $(PWD)/rclone:/config/rclone \
	rclone/rclone:1 \
	sync OneBlarvis:ServerBackup /usr/ServerBackup \
	--config="/config/rclone/rclone.conf" \
	--progress
