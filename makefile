init:
	@echo "Initializing finances app"
	make -C finances-flask init
	@echo "Initializing portfolio"
	make -C portfolio init
	@echo "Creating devops pipe"
	init-pipe

init-pipe:
	mkfifo /home/pi/server-setup/bind-mounts/devops/pipe
	(crontab -l ; echo "@reboot /home/pi/server-setup/devops-listen-to-pipe.sh") | sort - | uniq - | crontab -
	
files-scan:
	docker exec -ti --user www-data server-setup-nextcloud-1 /var/www/html/occ files:scan --all

update-images:
	docker-compose pull && docker-compose up -d

deploy:
	@echo "Deploying..."
	git pull --recurse-submodules
	docker-compose up -d --remove-orphans

deploy-finances:
	@echo "Pulling image..."
	docker-compose pull finances-app
	@echo "Deploying..."
	docker-compose up -d finances-app

deploy-portfolio:
	@echo "Updating..."
	git pull
	git submodule update portfolio
	@echo "Building..."
	npm run --prefix portfolio build
	@echo "Deploying..."
	docker-compose up -d --force-recreate caddy

restore:
	@echo "Restoring files from OneDrive..."
	@echo "This will take a while"
	docker run --rm \
	--volume $(PWD):/usr/ServerBackup
	--volume $(PWD)/rclone:/config/rclone \
	rclone/rclone:1 \
	copy OneBlarvis:ServerBackup /usr/ServerBackup \
	--config="/config/rclone/rclone.conf" \
	--progress

from-scratch: restore init deploy
	@echo "   ____        _      __                        __    __     "
	@echo "  / __/_______(_)__  / /_  _______  __ _  ___  / /__ / /____ "
	@echo " _\ \/ __/ __/ / _ \/ __/ / __/ _ \/  ' \/ _ \/ / -_) __/ -_)"
	@echo "/___/\__/_/ /_/ .__/\__/  \__/\___/_/_/_/ .__/_/\__/\__/\__/ "
	@echo "             /_/                       /_/                   "
	@echo "Check for errors above!!"
	@echo "Updating dns records and generating TLS certificates takes a minute"
	@echo "Try to visit the websites after a few minutes"
