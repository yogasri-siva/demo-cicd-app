pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yogasrisiva/demo-cicd-app"
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn -B clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE%:latest ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat """
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    docker push %DOCKER_IMAGE%:latest
                    """
                }
            }
        }

        stage('Deploy to AWS') {
            steps {
                sshagent(credentials: ['aws-ec2-key']) {
                    bat '''
                    ssh -o StrictHostKeyChecking=no ec2-user@13.126.236.26 "docker pull yogasrisiva/demo-cicd-app:latest && docker stop demo-cicd-app || true && docker rm demo-cicd-app || true && docker run -d -p 8081:8081 --name demo-cicd-app yogasrisiva/demo-cicd-app:latest"
                    '''
                }
            }
        }

    }
}
