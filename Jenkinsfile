pipeline {
    agent any

    environment {
        ACR_REGISTRY = 'capstonereg047af007.azurecr.io'
        IMAGE_NAME   = 'ecommerce-app'
        VERSION_TAG  = "v${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/AnarkeyV/capstone.git']]])
                
                // Verify git is working
                sh 'ls -a'
                sh 'git status'
            }
        }

        stage('Docker Login & Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    
                    // Verify docker
                    sh 'docker version'
                    
                    // docker login, build and push to ACR'
                    sh 'docker login ${ACR_REGISTRY} -u ${ACR_USER} -p ${ACR_PASS}'
                    sh 'docker build --platform linux/amd64 -t ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG} -f app/Dockerfile app'
                    sh 'docker push ${ACR_REGISTRY}/${IMAGE_NAME}:${VERSION_TAG}'
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                // Use Secret File credential instead of String
                withCredentials([file(credentialsId: 'kubeconfig-secret', variable: 'KUBECONFIG_FILE')]) {

                    // Download kubectl
                    sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
                    
                    // Make kubectl executable
                    sh 'chmod +x ./kubectl'

                    // Debug: check cluster connectivity
                    sh './kubectl cluster-info --kubeconfig=$KUBECONFIG_FILE'

                    sh './kubectl apply --kubeconfig=$KUBECONFIG_FILE -f kubernetes/deployment.yaml'
                    sh './kubectl apply --kubeconfig=$KUBECONFIG_FILE -f kubernetes/service.yaml'
                    
                    // Show kubectl version and client
                    sh 'kubectl version --client'
                    sh 'which kubectl'

                    // Clean up temporary files
                    sh 'rm ./kubectl'
                }
            }
        }
    }
}
