@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
      dock.run('truffle', '-i')
  }
  dockerExec(name: 'truffle', titleExec: 'Smart-contract compilation', dockerCmd: 'truffle compile')
  dockerExec(name: 'truffle', titleExec: 'Running tests', dockerCmd: 'ganache-cli & && truffle test')
  stage('Junit publish') {
      dock.unitTest('truffle', 'test-results.xml')
  }
  stage('Clean') {
      dock.rm('truffle')
  }
}
