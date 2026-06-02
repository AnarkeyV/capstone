pipeline {
    agent any 

    environment {
        ACR_REGISTRY = 'capstonereg047af007.azurecr.io'
        IMAGE_NAME   = 'ecommerce-app'
        VERSION_TAG  = "v${BUILD_NUMBER}" 
    }
    
    stages {
        // 🛠️ NEW STAGE: Installs the modern Docker CLI directly into the runner environment
        stage('Install Modern Docker CLI') {
            steps {
                sh 'apt-get update && apt-get install -y docker.io'
            }
        }
        
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/AnarkeyV/capstone.git']]])
                sh 'ls -a'
                sh 'git status'
            }
        }
        
        stage('Docker Login & Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    sh 'docker login ${ACR_REGISTRY} -u ${ACR_USER} -p ${ACR_PASS}'
                    sh 'docker build --platform linux/amd64 -t ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG} -f app/Dockerfile app'
                    sh 'docker push ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}'
                }
            }
        }
        
        stage('Deploy to AKS') {
            steps {
                withCredentials([string(credentialsId: 'kubeconfig-secret', variable: 'KUBECONFIG_DATA')]) {
                    sh 'echo "$KUBECONFIG_DATA" > kubeconfig.yaml'
                    sh 'sed -i "s|image: ${ACR_REGISTRY}/${IMAGE_NAME}:v1|image: ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}|g" kubernetes/deployment.yaml'

                    // Downloads the official, tiny Linux-compatible kubectl application file
                    sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'

                    // Changes permissions so Jenkins can execute it
                    sh 'chmod +x ./kubectl'

                    sh './kubectl apply --kubeconfig=kubeconfig.yaml -f kubernetes/deployment.yaml'
                    sh './kubectl apply --kubeconfig=kubeconfig.yaml -f kubernetes/service.yaml'

                    // Safely deletes temporary files
                    sh 'rm kubeconfig.yaml ./kubectl'
                }
            }
        }
    }
}
