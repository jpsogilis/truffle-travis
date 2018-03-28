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
You might have to use `sudo`.

___

#### Build images:
```
docker build -t ganache -f docker/ganache/Dockerfile .
docker build -t truffle -f docker/truffle/Dockerfile .
```

#### Launch ganache container:
`docker run --name ganache -d ganache`

This container can be launched alone.

#### Truffle interactivity:
`docker run -it --link ganache --name truffle truffle`

#### Truffle remotly:
`docker run -itd --link ganache --name truffle truffle`

And call exec with your command:

`docker exec truffle [command]`

#### Shutdown workspace:
`docker stop ganache`

`docker stop truffle` WARNING not if lanched in interactive.

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

***

### Tips:
If you want stop all containers:

`docker stop $(docker ps -a -q)`

If you want delete all containers:

`docker rm $(docker ps -a -q)`

If you want delete all images:

`docker rmi $(docker images -a -q)`


## Authors
* **Jean-Pierre Geslin** - [jpsogilis](https://github.com/jpsogilis)
* **Victor Valladier** - [valladiervictor](https://github.com/valladiervictor)
