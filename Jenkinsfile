@Library('workflowlib') _

sqscDockerNode() {
    stage('Build') {
      dock.build('ganache')
      dock.build('truffle_jenkins')
    }
    stage('Run environements') {
      dock.run('ganache', '-d')
      dock.run('truffle_jenkins', "-id --link ${dock.containerName('ganache')} -e 'RPC_HOST=${dock.containerName("ganache")}'")
    }
    stage('Smart-contract compilation') {
      dock.exec('truffle_jenkins', 'truffle compile')
    }
    stage('Running tests') {
      dock.exec('truffle_jenkins', 'truffle test')
    }
    stage('Junit publish') {
      dock.cp('truffle_jenkins', '/src/test-results.xml', 'tests.xml')
      junit 'tests.xml'
    }
    stage('Clean') {
        dock.stop('truffle_jenkins')
        dock.stop('ganache')
        dock.rm('truffle_jenkins')
        dock.rm('ganache')
    }
}
