# Swift-Microservice
Provides a common baseline for building Swift (Kitura) microservices on linux, 
that run anywhere.

## Important
The `master` branch of this repository only contains the Swift package artifacts. All of
the Docker related artifacts are in the `docker` branch. So if you are looking for how to
enable your Swift microservice on Docker please checkout to the `docker` branch.
```
$ git checkout docker
```
Otherwise, continue on to build/run your microservice locally.

## Build
```
$ swift build
```

## Run
Simply run the executable that built. Note that by default this microservice requires port 80
```
$ ./build/debug/Swift-Microservice
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
