@Library('workflowlib') _

sqscDockerNode() {
    stage('Build') {
      steps {
        dock.build('truffle')
      }
      steps {
        dock.build('ganache')
      }
    }
    stage('Run environements') {
      steps {
      	dock.run('ganache')
      }
      steps {
      	dock.run('truffle', '-d --link ganache')
      }
    }
    stage('Smart-contract compilation') {
      dock.exec('truffle', 'truffle compile')
    }
    stage('Running tests') {
      dock.exec('truffle', 'truffle test')
    }
    stage('Junit publish') {
      dock.cp('truffle', '/src/test-results.xml', 'tests.xml')
      junit 'tests.xml'
    }
    stage('Clean') {
        dock.stop('truffle')
        dock.stop('ganache')
        dock.rm('truffle')
        dock.rm('ganache')
    }
}
