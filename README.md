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
`docker build . -t truffle`
`docker-compose -f docker-compose.yml up`

### Using in local environment
Launch Ganache alone:
`sudo docker run t trufflesuite/ganache-cli --rm`
Launch truffle:
`truffle [command] --network local`

## Authors
* **Jean-Pierre Geslin** - [jpsogilis](https://github.com/jpsogilis)
* **Victor Valladier** - [valladiervictor](https://github.com/valladiervictor)
