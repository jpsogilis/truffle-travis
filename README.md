# squarescale-smart-contracts
Smart contracts for SquareScale ICO

## Getting Started

### Prerequisites
This project makes use of Nodejs and Npm in its installation.

Integration with [Truffle](https://github.com/ConsenSys/truffle), as Ethereum development environment, is recommended.
`npm install -g truffle`

Then install OpenZeppelin library in root directory:
`npm install -E zeppelin-solidity`

### Using docker

___

You might have to use `sudo`.

#### Build images:
```
docker build -t ganache -f docker/ganache/Dockerfile .
docker build -t truffle -f docker/truffle/Dockerfile .
```

#### Launch ganache container:
`docker run -d -p 8545:8545 --name ganache ganache`

You need to launch this container before use truffle container except if you launch docker-compose.

This container can be launched alone.

#### Truffle interactivity:
`docker run -it -p 8080:8080 --link ganache --name truffle truffle`

or with docker-compose:

```
docker-compose -f docker/docker-compose.yml up -d
docker attach truffle
```

Inside container, launch truffle with `--network ganache` flag.

For quit container enter exit.

#### Truffle remotly:
`docker run -itd --link ganache --name truffle truffle`

And call exec with your command:

`docker exec truffle truffle [command] --network ganache`

#### Log ganache:
`docker logs ganache`

#### Serve frontend:
```
docker exec truffle truffle compile --network ganache
docker exec truffle npm run build
docker exec truffle truffle serve --network ganache
```

#### Shutdown workspace:
`docker stop ganache`

`docker stop truffle`  Caution ! Not if lanched in interactive.

#### Cleanup workspace:
```
docker rm truffle
docker rm ganache
```

---

#### Truffle one shot commands:
For compile:

`docker run --rm --link ganache --name truffle truffle compile`

For migrate:

`docker run --rm --link ganache --name truffle truffle migrate --network [network]`

For tests:

`docker run --rm --link ganache --name truffle truffle test --network ganache`

### Best practice to local development:

First install dependences:

`cd clive && npm install`

And let's do it:

```
docker run --rm -v "`echo -n $PWD`:/src" -p 8080:8080 --link ganache --name truffle truffle truffle test --network ganache
```

You don't need to rebuild image with this method.

***

### Tips:
Stop all containers:

`docker stop $(docker ps -a -q)`

Delete all containers:

`docker rm $(docker ps -a -q)`

Delete all images:

`docker rmi $(docker images -a -q)`

Caution ! Thoses commands delete all containers/images on your machine.


___

## Authors
* **Jean-Pierre Geslin** - [jpsogilis](https://github.com/jpsogilis)
* **Victor Valladier** - [valladiervictor](https://github.com/valladiervictor)
