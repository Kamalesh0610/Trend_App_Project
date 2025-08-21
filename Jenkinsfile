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
                git branch: 'main', url: 'https://github.com/Kamalesh0610/Trend_App_Project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']) {
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-eks-creds']]) {
                    sh '''
                        # Configure kubeconfig for the cluster
                        aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME

                        # Apply base manifests (without hardcoding image)
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml

                        # Update deployment to use the latest Docker image tag
                        kubectl set image deployment/trend-app trend-app=$DOCKER_IMAGE:$BUILD_NUMBER --record

                        # Verify rollout
                        kubectl rollout status deployment/trend-app
                    '''
                }
            }
        }
    }
}
