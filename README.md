# Swift-Microservice
Provides a common baseline for building Swift (Kitura) microservices on linux, 
that run anywhere.

There is a `Makefile` provided that simply wraps Docker commands. You don't have
to use it, I simply find it makes iterating faster. Feel free to use it for
reference.

## Build
```
$ make build
```
or
```
$ # NOTE: the --force-rm flag prevents residual build containers from sticking around.
$ docker build -t swift-microservice --force-rm .
```

## Run
```
$ make run
```
or
```
$ docker rm -fv swift-microservice

$ # NOTE: The -P flag tells Docker to map an ephemeral ports to the ports declared in EXPOSE directives in Dockerfile.
$ docker run --name swift-microservice -d -P -m 128m swift-microservice

$ docker inspect -f '{{.NetworkSettings.Ports}}' swift-microservice
map[80/tcp:[{0.0.0.0 32785}] 443/tcp:[{0.0.0.0 32784}]]

$ # For this example, I can visit http://localhost:32785 in a browser to query my swift-microservice.
```

## Contributing
Please be sure to keep your feature in a separate branch off master. This way it is easy to observe what files/changes are necessary to enable certain features in this repository.

1. Fork it.
2. Create your feature branch from master:
```
$ git checkout -b my-new-feature master
```
3. Commit your changes:
```
$ git commit -am 'Add some feature'
```
4. Push to the branch:
```
$ git push origin my-new-feature
```
5. Submit a pull request.

## License
TODO: Add license
