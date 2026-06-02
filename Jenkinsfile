pipeline {
    agent any 
    
    // 🛠️ Instructs Jenkins to download and provide the standalone Docker CLI tool
    tools {
        dockerTool 'docker-cli'
    }
    
    environment {
        ACR_REGISTRY = 'capstonereg047af007.azurecr.io'
        IMAGE_NAME   = 'ecommerce-app'
        VERSION_TAG  = "v${BUILD_NUMBER}" 
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins automatically pulls our code and creates a healthy .git directory here
                checkout scm
            }
        }
        
        stage('Docker Login & Build') {
            steps {
                // Securely fetches our ACR login keys from the Jenkins credentials vault
                withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    sh 'docker login ${ACR_REGISTRY} -u ${ACR_USER} -p ${ACR_PASS}'
                    sh 'docker build --platform linux/amd64 -t ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG} -f app/Dockerfile app'
                    sh 'docker push ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}'
                }
            }
        }
        
        stage('Deploy to AKS') {
            steps {
                // Securely fetches our raw cloud kubeconfig keys from the vault
                withCredentials([string(credentialsId: 'kubeconfig-secret', variable: 'KUBECONFIG_DATA')]) {
                    // 1. Temporarily write the cloud access key to disk
                    sh 'echo "$KUBECONFIG_DATA" > kubeconfig.yaml'
                    
                    // 2. Automatically update the deployment manifest to target the fresh image tag we just built
                    sh 'sed -i "s|image: ${ACR_REGISTRY}/${IMAGE_NAME}:v1|image: ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}|g" kubernetes/deployment.yaml'
                    
                    // 3. Instruct AKS to roll out the updates
                    sh 'kubectl apply --kubeconfig=kubeconfig.yaml -f kubernetes/deployment.yaml'
                    sh 'kubectl apply --kubeconfig=kubeconfig.yaml -f kubernetes/service.yaml'
                    
                    // 4. Securely erase the temporary keycard file immediately after use
                    sh 'rm kubeconfig.yaml'
                }
            }
        }
    }
}