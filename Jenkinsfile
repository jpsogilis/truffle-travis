@Library('workflowlib') _

sqscDockerNode() {
  stage('tests') {
    dockerStep(name: 'truffle', junitFile: '/src/test-results.xml')
  }
}
