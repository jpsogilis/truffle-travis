@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dockerStepTest(
      name: 'truffle',
      dockerArgs: '-itd',
      title1: 'Smart-contract compilation',
      title2: 'Running tests', 
      dockerCmd1: 'truffle compile',
      dockerCmd2: 'ganache-cli &;sleep 2s; truffle test',
      junitFile: 'test-results.xml')
  }
}
