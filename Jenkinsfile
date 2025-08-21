pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "kamalesh0610/trend-app-repo"
        AWS_REGION   = "ap-south-1"
        CLUSTER_NAME = "trend-app-cluster"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/Kamalesh0610/Trend_App_Project.git',
                    credentialsId: 'github-token'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                    sh 'docker tag $DOCKER_IMAGE:$BUILD_NUMBER $DOCKER_IMAGE:latest'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-eks-creds']]) {
                    sh '''
                        aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml
                        kubectl set image deployment/trend-app-deployment trend-app=$DOCKER_IMAGE:$BUILD_NUMBER
                        kubectl rollout status deployment/trend-app-deployment
                    '''
                }
            }
        }
    }

    post {
        always { cleanWs() }
        success { echo "Build & Deployment Successful!" }
        failure { echo "Build/Deployment Failed!" }
    }
}
