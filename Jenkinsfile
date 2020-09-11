pipeline {
    agent any 
    stages {
        stage('Example Build') {
            steps {
                echo 'Hello, Maven'
                sh '''SBT_VERSION=1.3.13
                      sbt test
                      sbt "runMain example.Hello"
                      sbt stage
                      target/universal/stage/bin/automated-fargate-poc'''
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
