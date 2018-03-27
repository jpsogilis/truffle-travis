@Library('flowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
      dock.run('truffle', null)
  }
  dockerExec(name: 'truffle', titleExec: 'Smart-contract compilation', dockerCmd: 'truffle compile')
  dockerExec(name: 'truffle', titleExec: 'Running tests', dockerCmd: 'truffle test')
  stage('Junit publish') {
      dock.unitTest('truffle', 'test-results.xml')
  }
}
