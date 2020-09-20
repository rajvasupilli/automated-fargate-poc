pipeline {
    agent any 
    stages {
        stage('Install Pre-requisites') {
            steps {
                echo 'Installling the prerequisites!!!'
                sh '''
                      bash shell.sh
                   '''
            }
        }
        stage('SBT Build') {
            steps {
                echo 'Build steps are in progress!!!'
                sh '''
                      SBT_VERSION=1.3.13
                      sbt test
                      sbt "runMain example.Hello"
                      sbt stage
                   '''
            }
        }
        stage('ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 230604829846.dkr.ecr.us-east-1.amazonaws.com
                       sudo docker build -t scala-image-repo .
                       sudo docker tag scala-image-repo:latest 230604829846.dkr.ecr.us-east-1.amazonaws.com/scala-image-repo:latest
                       sudo docker push 230604829846.dkr.ecr.us-east-1.amazonaws.com/scala-image-repo:latest    
                   '''
            }
        }
    }
}
