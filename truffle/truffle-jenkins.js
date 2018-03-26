require('babel-register')

//var HDWalletProvider = require("truffle-hdwallet-provider");
//var mnemonic = "sheriff worth style this curtain alpha hollow bacon provide veteran resist common"

module.exports = {
  networks: {
    development: {
//      provider : function() {
//           return new HDWalletProvider(mnemonic, "http://127.0.0.1:8545");
//      },
      host: 'localhost',
      port: 8545,
      network_id: '*' // Match any network id
    },
    local: {
//      provider : function() {
//           return new HDWalletProvider(mnemonic, "http://127.0.0.1:8545");
//      },
      host: '172.17.0.2',
      port: 8545,
      network_id: '*' // Match any network id
    }
  },
  mocha: {
    reporter: "mocha-junit-reporter"
  }
}
