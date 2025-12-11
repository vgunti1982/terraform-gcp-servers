pipeline {
    agent any
    
    environment {
        GCP_PROJECT_ID = 'gcp-splunk-automation'
        GCP_REGION = 'us-central1'
        GCP_KEY_JSON = credentials('gcp-service-account-json')
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh 'echo "Repository cloned successfully"'
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh '''
                    echo "Initializing Terraform..."
                    terraform init
                '''
            }
        }
        
        stage('Terraform Validate') {
            steps {
                sh '''
                    echo "Validating Terraform code..."
                    terraform validate
                '''
            }
        }
        
        stage('Terraform Plan') {
            steps {
                sh '''
                    echo "Planning Terraform deployment..."
                    echo $GCP_KEY_JSON > /tmp/gcp-key.json
                    gcloud auth activate-service-account --key-file=/tmp/gcp-key.json
                    gcloud config set project ${GCP_PROJECT_ID}
                    
                    terraform plan \
                        -var="gcp_project_id=${GCP_PROJECT_ID}" \
                        -var="gcp_region=${GCP_REGION}" \
                        -var="environment=dev" \
                        -var="num_instances=1" \
                        -out=tfplan
                '''
            }
        }
        
        stage('Terraform Apply') {
            steps {
                input message: 'Apply Terraform changes to GCP?', ok: 'Deploy'
                sh '''
                    echo "Applying Terraform..."
                    terraform apply -auto-approve tfplan
                    terraform output
                '''
            }
        }
        
        stage('Cleanup') {
            steps {
                sh 'rm -f /tmp/gcp-key.json'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo "✅ Pipeline executed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
