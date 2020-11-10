pipeline {
    environment {
        DOCKER_REGISTRY = 'krishees/techchallengeapp'
        DOCKER_REGISTRY_CREDENTIAL = 'docker_hub'
        RELEASE_NAME = 'servian'
    }
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'jenkinsBuild.yaml'
        }
    }
    
    stages {
        stage("Checkout Source") {
            steps {
                git credentialsId: 'git-fcc', url: 'https://github.com/krishanthisera/TechChallengeApp.git'
             }
        }
        stage('Docker Build') {
            steps {
                container('docker') {
                    sh "docker build -t ${DOCKER_REGISTRY}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Docker Publish') {
            steps {
                container('docker') {
                    withDockerRegistry([credentialsId: "${DOCKER_REGISTRY_CREDENTIAL}", url: ""]) {
                        sh "docker push ${DOCKER_REGISTRY}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Kubernetes Deploy') {
            steps {
                container('helm') {
                    sh "helm upgrade --install --force --set app.image.repository=${DOCKER_REGISTRY} --set app.image.tag=${BUILD_NUMBER} ${RELEASE_NAME} ./k8s-helm/tech-challenge"
                }
            }
        }
    }
}