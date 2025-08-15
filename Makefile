PHP_CONTAINER=php
MYSQL_CONTAINER=mysql
PHPMYADMIN_CONTAINER=phpmyadmin

up:
	docker compose up -d

down:
	docker compose down

r:
	docker compose restart

p:
	docker exec -it $(PHP_CONTAINER) bash

mysql:
	docker exec -it $(MYSQL_CONTAINER) mysql -u root -p

stop-php:
	docker stop $(PHP_CONTAINER)

rp:
	docker restart $(PHP_CONTAINER)

logs-p:
	docker logs -f $(PHP_CONTAINER)

logs-mysql:
	docker logs -f $(MYSQL_CONTAINER)

clean:
	docker compose down --volumes --rmi all

build:
	docker compose build

fr: down up

all: build up
