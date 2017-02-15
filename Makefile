# Utility functions that will help you manage your Docker container without
# having to remember all the Docker commands.

clean:
	docker rm -fv swift-microservice || true
	docker ps -a | grep swift-microservice || true

build:
	docker build -t swift-microservice --force-rm .

run: clean build
	docker run --name swift-microservice -d -P -m 128m swift-microservice

test: run
	docker exec -it swift-microservice swift test
