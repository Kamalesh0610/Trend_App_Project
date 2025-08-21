pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "kamalesh0610/trend-app-repo"
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
                 withAWS(region: 'ap-south-1', credentials: 'aws-eks-creds') {
                     sh '''
                          aws eks update-kubeconfig --region ap-south-1 --name trend-app-cluster
                          kubectl apply -f deployment.yaml
                          kubectl apply -f service.yaml
                     '''
                }
            }
        }
    }
}
