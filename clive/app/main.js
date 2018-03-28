import { default as Web3 } from 'web3'
import { default as contract } from 'truffle-contract'
import CliveContract from '../build/contracts/Clive.json'

const TESTRPC_HOST = 'localhost'
const TESTRPC_PORT = '8545'

function component () {
  var element = document.createElement('div')
  let provider = new Web3.providers.HttpProvider(`http://${TESTRPC_HOST}:${TESTRPC_PORT}`)
  let clive = contract(CliveContract)
  clive.setProvider(provider)
  clive.deployed()
    .then((instance) => { element.innerHTML = `Clive address: ${instance.address}` })

  return element
}

document.body.appendChild(component())
