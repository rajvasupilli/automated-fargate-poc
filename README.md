Automated ECS Fargate PoC
=========================

## Build & Local Run Dependencies
* JDK 8
* sbt `brew install sbt` for macOS, `choco install sbt` for win

## Prod Run Dependencies
* JDK 8

## Testing
This will run automated tests
```shell
sbt test
```

## Running Locally
This will print out a message to STDOUT.
```shell
sbt "runMain example.Hello"
```

## Packaging Up For Docker
Directory containing app is `target/universal/stage/`
```shell
sbt stage
```
`bin/` contains the start script, `lib/` contains the libraries, and `resources` contains config files.

## Running in Prod
```shell
bin/automated-fargate-poc
```
