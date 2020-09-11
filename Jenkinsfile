pipeline {
    agent any 
    stages {
        stage('Build') {
            steps {
                echo 'Build steps are in progress!!!'
                sh '''SBT_VERSION=1.3.13
                      sbt test
                      sbt "runMain example.Hello"
                      sbt stage
                      //target/universal/stage/bin/automated-fargate-poc
                      '''
            }
        }
        stage('Example Test') {
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}
