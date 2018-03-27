@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dokerStep(
      name: 'truffle',
      title1: 'Smart-contract compilation',
      title2: 'Running tests', 
      dockerCmd1: 'truffle compile',
      dockerCmd2: 'truffle test',
      junitFile: 'test-results.xml')
  }
}
