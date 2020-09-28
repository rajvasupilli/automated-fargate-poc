pipeline {
    agent any
    
    parameters {
          text(name: 'DEV_ACCOUNT_ID', defaultValue: '406370147020', description: 'Enter the AWS Account ID of Dev Environment')
        string(name: 'REGION', defaultValue: 'us-east-1', description: 'Enter the Region')
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Enter the tag pertaining to the ECR Image')
        string(name: 'DEV_REPO_NAME', defaultValue: 'dev-scala-image-repo', description: 'Enter the AWS ECR Repo name pertaining to Dev Environment')
    }
    
    stages {
        stage('Install Pre-requisites') {
            steps {
                echo 'Installing the prerequisites!!!'
                sh '''
                       bash prereq_ubuntu.sh
                   '''
            }
        }
        stage('Create Dev and Staging ECR') {
            steps {
                echo 'Dev and Staging Repository creation is underway!!!'
                sh '''
                      aws cloudformation create-stack --stack-name dev-ecr --template-body file://create-ecr.yml --capabilities CAPABILITY_NAMED_IAM
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
        stage('Build and Push Image into Dev ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh ''' aws ecr get-login-password --region "\${params.REGION}" | sudo docker login --username AWS --password-stdin "\${params.DEV_ACCOUNT_ID}".dkr.ecr."\${params.REGION}".amazonaws.com
                       sudo docker build -t "\${params.DEV_REPO_NAME}" .
                       sudo docker tag "\${params.DEV_REPO_NAME}":"\${params.IMAGE_TAG}" "\${params.DEV_ACCOUNT_ID}".dkr.ecr."\${params.REGION}".amazonaws.com/"\${params.DEV_REPO_NAME}":"\${params.IMAGE_TAG}"
                       sudo docker push "\${params.DEV_ACCOUNT_ID}".dkr.ecr."\${params.REGION}".amazonaws.com/"\${params.DEV_REPO_NAME}":"\${params.IMAGE_TAG}"    
                   '''
               }
        }
        
       //stage('Push image from Dev to Staging ECR') {
       //     steps {
       //         echo 'Build,Tag and Push the Docker Image into the ECR'
       //         sh ''' aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 514474256068.dkr.ecr.us-east-1.amazonaws.com
       //                sudo docker pull 514474256068.dkr.ecr.us-east-1.amazonaws.com/dev-scala-image-repo:latest
       //                sudo docker tag dev-scala-image-repo:latest 514474256068.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest
       //                  sudo docker push 514474256068.dkr.ecr.us-east-1.amazonaws.com/staging-scala-image-repo:latest    
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
        //               sudo docker push 667333752349.dkr.ecr.us-east-1.amazonaws.com/prod-scala-image-repo:latest    
        //           '''
        //        }    
        //    }
        //}
       
    }
}
