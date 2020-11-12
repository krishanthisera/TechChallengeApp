pipeline {
    parameters {
        //Helm will treat this as a new release
        booleanParam(name: "NEW_RELEASE", defaultValue: true)
        //Helm will purge the old release and redeploy the release
        booleanParam(name: "PURGE_RELEASE", defaultValue: false)
    }
    environment {
        DOCKER_REGISTRY = 'krishees/techchallengeapp'
        DOCKER_REGISTRY_CREDENTIAL = 'docker_hub'
        RELEASE_NAME = 'servian' 
        RELEASE_NAMESPACE = 'servian'
    }
    agent {
        kubernetes {
            defaultContainer 'jnlp'
            yamlFile 'jenkins-build.yaml'
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
        stage('Image Shipping') {
            steps {
                container('docker') {
                    withDockerRegistry([credentialsId: "${DOCKER_REGISTRY_CREDENTIAL}", url: "https://index.docker.io/v1/"]) {
                        sh "docker push ${DOCKER_REGISTRY}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Kubernetes Deploy') {
            parallel {
                stage ('Deploying A Brand New Release'){
                    when { expression { params.NEW_RELEASE } }
                    steps {
                        container('helm') {
                            sh "helm install --set app.image.repository='${DOCKER_REGISTRY}' --set app.image.tag='${BUILD_NUMBER}' '${RELEASE_NAME}' ./k8s-helm/tech-challenge --namespace '${RELEASE_NAMESPACE}'"
                        }
                    }
                }
                stage ('Updating the Release'){
                    when { expression { !params.NEW_RELEASE } }
                    steps {
                        container('helm') {
                            sh "helm upgrade --install '${RELEASE_NAME}' --set app.image.repository='${DOCKER_REGISTRY}' --set app.image.tag='${BUILD_NUMBER}' --namespace '${RELEASE_NAMESPACE}' ./k8s-helm/tech-challenge"
                        }
                    }
                }
                stage ('Purge and Deploy'){
                    when { expression { params.PURGE_RELEASE } }
                    steps {
                        container('helm') {
                            sh "helm delete --purge '${RELEASE_NAME}' --namespace '${RELEASE_NAMESPACE}'"
                            sh "helm install --set app.image.repository='${DOCKER_REGISTRY}' --set app.image.tag='${BUILD_NUMBER}' '${RELEASE_NAME}' ./k8s-helm/tech-challenge --namespace '${RELEASE_NAMESPACE}'"
                        }
                    }
                }
            }    
        }
    }
}