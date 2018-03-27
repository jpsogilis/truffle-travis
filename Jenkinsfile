@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
    dock.run('truffle', '-d')
  }
  stage('Smart-contract compilation') {
    dock.exec('truffle', 'truffle compile')
  }
  stage('Running tests') {
    dock.exec('truffle', 'truffle test')
  }
  stage('Junit publish') {
      dock.unitTest('truffle', '/src/test-results.xml')
  }
  stage('Clean') {
      dock.rm('truffle')
  }
}
