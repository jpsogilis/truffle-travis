@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
      dock.run('truffle', '-itd')
  }
  dockerExec(name: 'truffle', titleExec: 'Launch Ganache', dockerCmd: 'ganache-cli &', dockerArgs: '-itd')
  dockerExec(name: 'truffle', titleExec: 'Smart-contract compilation', dockerCmd: 'truffle compile', dockerArgs: '-itd')
  dockerExec(name: 'truffle', titleExec: 'Running tests', dockerCmd: 'truffle test', dockerArgs: '-itd')
  stage('Junit publish') {
      dock.unitTest('truffle', 'test-results.xml')
  }
  stage('Clean') {
      dock.rm('truffle')
  }
}
