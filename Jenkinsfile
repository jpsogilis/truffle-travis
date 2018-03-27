@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
    dock.run('truffle', '-itd')
  }
  stage('Starting Ganache') {
    dock.exec('truffle', 'bash ls')
  }
  stage('Smart-contract compilation') {
    dock.exec('truffle', 'truffle compile')
  }
  stage('Running tests') {
    dock.exec('truffle', 'truffle test')
  }
  stage('Junit publish') {
    dock.cp('truffle', '/src/test-results.xml', 'tests.xml')
    junit 'tests.xml'
  }
  stage('Clean') {
      dock.stop('truffle')
      dock.rm('truffle')
  }
}
