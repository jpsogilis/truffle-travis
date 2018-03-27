require('babel-register')

module.exports = {
  networks: {
    development: {
      },
      host: 'ganache',
      port: 8545,
      network_id: '*' // Match any network id
    },
  },
  mocha: {
	      reporter: "mocha-junit-reporter"
  }
}
