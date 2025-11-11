pipeline {
    agent any

    environment {
        APP_DIR = "/tmp/my-node-app"
        EMAIL_RECIPIENTS = "nikhilmali5633@gmail.com"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Nrm33/jenkins', branch: 'main'
            }
        }

        stage('Build App') {
            steps {
                sh '''
                echo "Installing dependencies..."
                npm install
                '''
            }
        }

        stage('Deploy to Server') {
            steps {
                sh '''
                echo "Deploying app..."
                rm -rf ${APP_DIR:?}/*
                mkdir -p ${APP_DIR}
                cp -r * ${APP_DIR}
                bash deploy/restart_service.sh ${APP_DIR}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deploy succeeded!"
            mail to: "${EMAIL_RECIPIENTS}",
                 subject: "✅ SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build succeeded. View details at ${env.BUILD_URL}"
        }
        failure {
            echo "❌ Build failed!"
            mail to: "${EMAIL_RECIPIENTS}",
                 subject: "❌ FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "The build failed. See logs at ${env.BUILD_URL}console"
        }
    }
}
