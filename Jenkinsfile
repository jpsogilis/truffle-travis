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
      dock.unitTests('truffle', '/src/test-results.xml')
  }
  stage('Test junit') {
    junit 'test.xml'
  }
  stage('Clean') {
      dock.stop('truffle')
      dock.rm('truffle')
  }
}
