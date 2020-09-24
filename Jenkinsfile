pipeline {
    agent any 
    stages {
        stage('Install Pre-requisites') {
            steps {
                echo 'Installling the prerequisites!!!'
                sh '''
                      bash prereq.sh
                      aws cloudformation delete-stack --stack-name ecs-stack
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
                sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 205376115077.dkr.ecr.us-east-1.amazonaws.com
                       sudo docker build -t dev-scala-image-repo .
                       sudo docker tag dev-scala-image-repo:latest 205376115077.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
                       sudo docker push 205376115077.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest    
                   '''
            }
        }
        
       //stage('Push image from Dev to Staging ECR') {
       //     steps {
       //         echo 'Build,Tag and Push the Docker Image into the ECR'
       //         sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 514474256068.dkr.ecr.us-east-1.amazonaws.com
       //                sudo docker pull 514474256068.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
       //                sudo docker tag dev-scala-image-repo:latest 514474256068.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest
       //                sudo docker push 514474256068.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest    
       //            '''
       //     }
       //}
        
        //stage('Push image from Staging to Production ECR') {
        //    steps {
        //        withAWS(credentials: 'pavan', region: 'us-east-1') {
        //        echo 'Build,Tag and Push the Docker Image into the ECR'
        //        sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 249147895833.ecr.us-east-1.amazonaws.com
        //               sudo docker pull 249147895833.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest
        //               sudo docker tag staging-scala-image-repo:latest 667333752349.dkr.ecr.us-east-1.amazonaws.com/prod-scala-image-repo:latest
        //               sudo docker push 667333752349.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest    
        //           '''
        //        }    
        //    }
        //}
       
    }
}
