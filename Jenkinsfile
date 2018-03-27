@Library('workflowlib') _

sqscDockerNode() {
  stage('Build image') {
    dock.build(name: 'truffle')
  }
  stage('Run environement') {
    dock.run(name: 'truffle')
  }
  dockExec(title: 'Smart-contract compilation', name: 'truffle', dockerCmd: 'truffle compile')
  dockExec(title: 'Running tests', name: 'truffle', dockerCmd: 'truffle test')
  stage('Junit') {
    dock.uniTests(name: 'truffle', junitFile: 'test-results.xml')
  }
  stage(Clean) {
    dock.rm(name: 'truffle')
  }
}
