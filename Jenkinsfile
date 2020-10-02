pipeline {
    agent any     
    parameters {
          text(name: 'DEV_ACCOUNT_ID', defaultValue: '097425282359', description: 'Enter the AWS Account ID of Dev Environment')
        string(name: 'REGION', defaultValue: 'us-east-1', description: 'Enter the Region')
        //string(name: 'IMAGE_TAG', defaultValue: '$IMAGE_TAG', description: 'Enter the tag pertaining to the ECR Image')
        string(name: 'DEV_REPO_NAME', defaultValue: 'dev-scala-image-repo', description: 'Enter the AWS ECR Repo name pertaining to Dev Environment')
    }
    stages {
       stage('Checkout SCM') {
            steps {
                echo 'Cloning the GitHub Repo!!!'
                sh '''
                       git clone git@github.com:rajvasupilli/automated-fargate-poc.git                       
                   '''
            }
        }
       stage('Increment the Version') {
            steps {
                echo 'Bumping up the version!!!'                
                sh '''
                       cd automated-fargate-poc
                       bash set_version.sh
                       IMAGE_TAG=`cat version.txt`
                       echo "IMAGE_TAG: $IMAGE_TAG"
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
                      echo "IMAGE_TAG value is: $IMAGE_TAG"
                   '''
            }
        }
         stage('Git Pull') {
            steps {
                echo 'Cloning the GitHub Repo!!!'
                sh '''
                      rm -rf version.txt
                      git branch --set-upstream master origin/master
                      git pull
                   '''
            }
        }
        
        stage('Set the Image Tag') {
            steps {
               script { 
                 cd automated-fargate-poc
                 IMAGE_TAG = sh (script: 'cat version.txt',returnStdout: true) 
               }    
            }
        }
        
        stage('Build and Push Image into Dev ECR') {
            steps {
                echo 'Build,Tag and Push the Docker Image into the ECR'
                sh """ 
                       aws ecr get-login-password --region ${params.REGION} | sudo docker login --username AWS --password-stdin ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com
                       sudo docker build -t ${params.DEV_REPO_NAME}:$IMAGE_TAG .
                       #sudo docker tag ${params.DEV_REPO_NAME}:`cat version.txt` ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com/${params.DEV_REPO_NAME}:`cat version.txt`
                       #sudo docker push ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com/${params.DEV_REPO_NAME}:`cat version.txt`
                   """
               }
        }
        
       //stage('Build and Push Image into Dev ECR') {
       //     steps {
       //         echo 'Build,Tag and Push the Docker Image into the ECR'
       //         sh """ aws ecr get-login-password --region ${params.REGION} | sudo docker login --username AWS --password-stdin ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com
       //                sudo docker build -t ${params.DEV_REPO_NAME} .
       //                sudo docker tag ${params.DEV_REPO_NAME}:${params.IMAGE_TAG} ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com/${params.DEV_REPO_NAME}:${params.IMAGE_TAG}
       //                sudo docker push ${params.DEV_ACCOUNT_ID}.dkr.ecr.${params.REGION}.amazonaws.com/${params.DEV_REPO_NAME}:${params.IMAGE_TAG}    
       //           """
       //        }
       // }       
    }
}
