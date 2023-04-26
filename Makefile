# BUILD

docker-build:
	docker-compose build

docker-build-no-cache:
	docker-compose build --no-cache

# SETUP
docker-setupdb:
	docker-compose run --rm api bundle exec rake db:drop db:create db:migrate

docker-down:
	docker-compose down