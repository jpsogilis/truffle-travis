@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
    dock.run('truffle', '-itd')
  }
  stage('Starting Ganache') {
    dock.exec('truffle', './launch-ganache.sh', '-itd')
  }
  stage('Smart-contract compilation') {
    dock.exec('truffle', 'truffle compile', '-itd')
  }
  stage('Running tests') {
    dock.exec('truffle', 'truffle test', '-itd')
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
