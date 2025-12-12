pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }
    environment {
        TERRAFORM_VERSION = '1.5.0'
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out repositories..."
            }
        }
        stage('Validate') {
            steps {
                echo "Validating Terraform..."
            }
        }
        stage('Plan') {
            steps {
                echo "Planning Terraform changes..."
            }
        }
        stage('Apply') {
            steps {
                echo "Applying Terraform..."
            }
        }
    }
}
