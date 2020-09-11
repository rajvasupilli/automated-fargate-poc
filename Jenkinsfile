pipeline {
    agent any 
    stages {
        stage('SBT Build') {
            steps {
                echo 'Build steps are in progress!!!'
                sh '''SBT_VERSION=1.3.13
                      sbt test
                      sbt "runMain example.Hello"
                      sbt stage
                   '''
            }
        }
        stage('ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 167996500928.dkr.ecr.us-east-1.amazonaws.com
                       sudo docker build -t cronbasedfargate .
                       sudo docker tag cronbasedfargate:latest 167996500928.dkr.ecr.us-east-1.amazonaws.com/cronbasedfargate:latest
                       sudo docker push 167996500928.dkr.ecr.us-east-1.amazonaws.com/cronbasedfargate:latest    
                   '''
            }
        }
    }
}
