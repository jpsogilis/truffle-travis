@Library('workflowLibs') _

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
      sh "docker exec ${dock.containerName('truffle_jenkins')} truffle compile"
    }
    stage('Running tests') {
      sh "docker exec ${dock.containerName('truffle_jenkins')} truffle test"
      sh "docker logs ${dock.containerName('ganache')}"
    }
    stage('Junit publish') {
      dock.cp('truffle_jenkins', '/src/test-results.xml', 'tests.xml')
      junit 'tests.xml'
    }
    stage('Clean') {
        sh "docker stop ${dock.containerName('truffle_jenkins')}"
        sh "docker stop ${dock.containerName('ganache')}"
        dock.rm('truffle_jenkins')
        dock.rm('ganache')
    }
}
