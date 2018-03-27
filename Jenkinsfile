@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build('truffle')
  }
  stage('Run environement') {
    dock.run('truffle')
  }
  stage('Smart-contract compilation') {
    dock.exec('truffle', 'compile')
  }
  stage('Running tests') {
    dock.exec('truffle', 'test')
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
