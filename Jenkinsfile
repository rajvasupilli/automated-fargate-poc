pipeline {
    agent any 
    stages {
        stage('Install Pre-requisites') {
            steps {
                echo 'Installling the prerequisites!!!'
                sh '''
                      bash prereq.sh
                      aws cloudformation delete-stack --stack-name ecs-stack --template-body file://create-ecs.yml --capabilities CAPABILITY_NAMED_IAM
                      sleep 30
                      aws cloudformation create-stack --stack-name ecs-stack --template-body file://create-ecr.yml --capabilities CAPABILITY_NAMED_IAM
                   '''
            }
        }
        stage('SBT Build') {
            steps {
                echo 'Build steps are in progress!!!'
                sh '''
                      SBT_VERSION=1.3.13
                      sbt test
                      #sbt "runMain example.Hello"
                      sbt stage
                   '''
            }
        }
        stage('Build and Push into Dev ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 239875208417.dkr.ecr.us-east-1.amazonaws.com
                       docker build -t dev-scala-image-repo .
                       docker tag dev-scala-image-repo:latest 239875208417.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
                       docker push 239875208417.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest    
                   '''
            }
        }
        
       stage('Push image from Dev to Staging ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 239875208417.dkr.ecr.us-east-1.amazonaws.com
                       docker pull 239875208417.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
                       #docker build -t staging-scala-image-repo .
                       docker tag staging-scala-image-repo:latest 239875208417.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
                       docker push 239875208417.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest    
                   '''
            }
        }
    }
}
