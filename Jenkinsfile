pipeline {
    agent any

    environment {
        DEPLOY_SERVER = "localhost"
        DEPLOY_DIR = "/home/jenkins/app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Nrm33/jenkins.git'
            }
        }

        stage('Build App') {
            steps {
                echo 'Installing dependencies...'
                sh 'npm install'
            }
        }

        stage('Deploy to Server') {
            steps {
                echo 'Deploying application...'
                sh '''
                    mkdir -p $DEPLOY_DIR
                    cp -r * $DEPLOY_DIR/
                '''
            }
        }

        stage('Restart Service') {
            steps {
                sh 'bash deploy/restart_service.sh'
            }
        }
    }

    post {
        success {
            echo '✅ Build and deploy successful!'
            mail to: 'nikhilmali5633@gmail.com',
                 subject: "Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Good news! Your Jenkins pipeline completed successfully."
        }
        failure {
            echo '❌ Build failed!'
            mail to: 'nikhilmali5633@gmail.com',
                 subject: "Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build failed. Please check the Jenkins logs."
        }
    }
}
