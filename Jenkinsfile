@Library('workflowlib') _

sqscDockerNode() {
  stage('tests') {
    dockerStep(name: 'truffle', junitFile: 'truffle/test-results.xml')
  }
}
