pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pull code from Git (Jenkins will use job's SCM config)
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                // If Jenkins agent is Linux; if Windows agent, we’ll switch to 'bat' later
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat '''
                docker build -t yogasrisiva/demo-cicd-app:latest .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                bat '''
                docker push yogasrisiva/demo-cicd-app:latest
                '''
            }
        }

        stage('Deploy to AWS') {
            steps {
                bat 'bash scripts/deploy-to-aws.sh'
            }
        }
    }
}
