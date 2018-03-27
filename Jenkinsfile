@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
      dock.run('truffle', '-id')
  }
  dockerExec(name: 'truffle', titleExec: 'Smart-contract compilation', dockerCmd: 'truffle compile', dockerArgs: '-i')
  dockerExec(name: 'truffle', titleExec: 'Running tests', dockerCmd: 'truffle test', dockerArgs: '-i')
  stage('Junit publish') {
      dock.unitTest('truffle', '/src/test-results.xml')
  }
  stage('Clean') {
      dock.rm('truffle')
  }
}
