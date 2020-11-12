# Servian DevOps Tech Challenge - Tech Challenge App
[![Build Status](https://ci.bizkt.com.au/buildStatus/icon?job=TechChallengeApp%2Fmaster)](https://ci.bizkt.com.au/job/TechChallengeApp/job/master/)
[![Release][release-badge]][release]
[![GoReportCard][report-badge]][report]
[![License][license-badge]][license]

[circleci-badge]: https://circleci.com/gh/servian/TechChallengeApp.svg?style=shield&circle-token=8dfd03c6c2a5dc5555e2f1a84c36e33bc58ad0aa
[circleci]: https://circleci.com/gh/servian/TechChallengeApp
[release-badge]: http://img.shields.io/github/release/servian/TechChallengeApp/all.svg?style=flat
[release]:https://github.com/Servian/TechChallengeApp/releases
[report-badge]: https://goreportcard.com/badge/github.com/Servian/TechChallengeApp
[report]: https://goreportcard.com/report/github.com/Servian/TechChallengeApp
[license-badge]: https://img.shields.io/github/license/Servian/TechChallengeApp.svg?style=flat
[license]: https://github.com/Servian/TechChallengeApp/license

## Overview

This is the Servian DevOps Tech challenge. It uses a simple application to help measure a candidate's technical capability and fit with Servian. The application itself is a simple GTD Golang application that is backed by a Postgres database.

Servian provides the Tech Challenge to potential candidates, which focuses on deploying this application into a cloud environment of choice.

More details about the application can be found in the [document folder](doc/readme.md)

## Taking the challenge

For more information about taking the challenge and joining Servians's amazing team, please head over to our [recruitment page](https://www.servian.com/careers/) and apply there. Our recruitment team will reach out to you about the details of the test and be able to answer any questions you have about Servian or the test itself.

Information about the assessment is available in the [assessment.md file](ASSESSMENT.md)

## Found an issue?

If you've found an issue with the application, the documentation, or anything else, we are happy to take contributions. Please raise an issue in the [github repository](https://github.com/Servian/TechChallengeApp/issues) and read through the contribution rules found the [CONTRIBUTING.md](CONTRIBUTING.md) file for the details.

# Servian DevOps Tech Challenge - Tech Challenge App
[![Build Status](https://ci.bizkt.com.au/buildStatus/icon?job=TechChallengeApp%2Fmaster)](https://ci.bizkt.com.au/job/TechChallengeApp/job/master/)
[![Release][release-badge]][release]
[![GoReportCard][report-badge]][report]
[![License][license-badge]][license]

[circleci-badge]: https://circleci.com/gh/servian/TechChallengeApp.svg?style=shield&circle-token=8dfd03c6c2a5dc5555e2f1a84c36e33bc58ad0aa
[circleci]: https://circleci.com/gh/servian/TechChallengeApp
[release-badge]: http://img.shields.io/github/release/servian/TechChallengeApp/all.svg?style=flat
[release]:https://github.com/Servian/TechChallengeApp/releases
[report-badge]: https://goreportcard.com/badge/github.com/Servian/TechChallengeApp
[report]: https://goreportcard.com/report/github.com/Servian/TechChallengeApp
[license-badge]: https://img.shields.io/github/license/Servian/TechChallengeApp.svg?style=flat
[license]: https://github.com/Servian/TechChallengeApp/license

## Overview

This is the Servian DevOps Tech challenge. It uses a simple application to help measure a candidate's technical capability and fit with Servian. The application itself is a simple GTD Golang application that is backed by a Postgres database.

Servian provides the Tech Challenge to potential candidates, which focuses on deploying this application into a cloud environment of choice.

More details about the application can be found in the [document folder](doc/readme.md)

## Taking the challenge

For more information about taking the challenge and joining Servians's amazing team, please head over to our [recruitment page](https://www.servian.com/careers/) and apply there. Our recruitment team will reach out to you about the details of the test and be able to answer any questions you have about Servian or the test itself.

Information about the assessment is available in the [assessment.md file](ASSESSMENT.md)

## Found an issue?

If you've found an issue with the application, the documentation, or anything else, we are happy to take contributions. Please raise an issue in the [github repository](https://github.com/Servian/TechChallengeApp/issues) and read through the contribution rules found the [CONTRIBUTING.md](CONTRIBUTING.md) file for the details.

# Solution Implementation

[![Build Status](https://ci.bizkt.com.au/buildStatus/icon?job=TechChallengeApp%2Fmaster)](https://ci.bizkt.com.au/job/TechChallengeApp/job/master/)

The following section summarises the solution architecture and instructions to deploy the application. The following list of the files was introduced/manipulated during the implementation process (to the master branch).
```sh
├── Dockerfile 
├── Jenkinsfile
├── iac
│   ├── auto-scaling.tf
│   ├── development.tfplan
│   ├── ebs-volumes.tf
│   ├── eks-cluster.tf
│   ├── iam.tf
│   ├── load-balancer.tf_exclude
│   ├── outputs.tf
│   ├── provider.tf
│   ├── rbac.tf
│   ├── readme.md
│   ├── terraform.tfvars
│   ├── variables.tf
│   ├── versions.tf
│   └── vpc.tf
├── jenkins-build.yaml
├── k8s
│   ├── app-deployment.yaml
│   ├── db-deployment.yaml
│   ├── db-pvc.yaml
│   ├── db-sc.yaml
│   ├── k8s-namespace.yaml
│   ├── k8s-services.yaml
│   ├── k8s-volumes.yaml
│   ├── readme.md
│   └── seed-job.yaml
├── k8s-helm
│   └── tech-challenge
│       ├── Chart.yaml
│       ├── charts
│       ├── readme.md
│       ├── templates
│       │   ├── NOTES.txt
│       │   ├── _helpers.tpl
│       │   ├── app-config.yaml
│       │   ├── challenge-app.yaml
│       │   ├── challenge-db.yaml
│       │   ├── db-pvc.yaml
│       │   ├── db-sc.yaml
│       │   ├── db-secrets.yaml
│       │   ├── hpa.yaml
│       │   ├── ingress.yaml
│       │   ├── metric-server.yaml
│       │   ├── seed-job.yaml
│       │   ├── services.yaml
│       │   └── tests
│       │       └── _test-connection.yaml
│       └── values.yaml
├── readme.md
```
## Terminology
Following technologies has been associated to finalise the solution.

![stack](https://www.hatboysoftware.com/blog/images/docker-kubernetes-helm-terraform.png)
| Technology | Purpose | Reference |
| ------ | ------ | ------ |
| Docker | To containerise the application | [Dockerfile](https://github.com/krishanthisera/TechChallengeApp/blob/master/Dockerfile) |
| Kubernetes | To orchestrate the containers | [k8s-helm/tech-challenge](https://github.com/krishanthisera/TechChallengeApp/tree/master/k8s-helm/tech-challenge) <br> [k8s](https://github.com/krishanthisera/TechChallengeApp/tree/master/k8s)|
| Helm | To manage the application releases | [k8s-helm/tech-challenge](https://github.com/krishanthisera/TechChallengeApp/tree/master/k8s-helm/tech-challenge) |
|Terraform| As the tool of IaC (Infructure as Code) | [iac](https://github.com/krishanthisera/TechChallengeApp/tree/master/iac)|
| Jenkins | To implement the CI Pipeline | [Jenkinsfile](https://github.com/krishanthisera/TechChallengeApp/blob/master/Jenkinsfile) <br> [jenkins-build.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/jenkins-build.yaml)|

## Application Infrastructure

![Kubernetes](https://i.ibb.co/kHCFRLN/Servian-infra.png)

## Networking and Load Balacing

As shown above, the Ingress components may or may not be presented on the Kubernetes environment depending on the installation.
The Application and the Database are running as two separate deployments. Even though the connection between those two pods were not explicitly defined in the diagram. A ClusterIP service has been used  _(Please refer [k8s/k8s-services.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s/k8s-services.yaml) and [k8s-helm/tech-challenge/templates/services.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/services.yaml))_.

In a scenario where there is no such a requirement for an ingress to be deployed, a NodePort service can be enabled by using the Helm value file or by setting the parameter at the Helm installation
```sh
$ helm upgrade --install --force --set nodePort.enabled=true --set nodePort.port=<NODE_PORT> <RELEASE_NAME_ ./k8s-helm/tech-challenge
```
Optionally, as the easiest way to expose the application to external networks, a Kubernetes LoadBancer service can be used. This can be enable by setting `--set loadBalancer.enabled=true`
<br> or after the deployement,
```sh
$ kubectl expose deploy servian-tech-challenge-app --type=LoadBalancer --port=80 --target-port=80
```
To retrieve the external IP which was configured as a result of the Kuberenetes Load Balancer service
```sh
$ kubectl get services  --output jsonpath="{.items[*].status.loadBalancer.ingress[*].hostname}{'\n'}"
```
_Note that, it has been assumed that the application has been deployed on the default namespace_
### Jobs
To update the Databases with seed data, a Kubernetes Job has been used. The same image which has been used in the application container has been used by overriding the Entrypoint.
```sh
# Kubernetes Job
...
template:
    spec:
      containers:
      - name: app
        image: krishees/techchallengeapp
        command: ["/bin/sh"]
        args: ["-c", "echo 'Sleep time initiated - waiting on db to install'; sleep 180; ./TechChallengeApp updatedb"]
        ...
```
### How to Run
The application can be deployed either manually or by using the Jenkins pipeline. 
#### Manual Deployment
Dependencies:
1. Terraform
2. kubectl
3. Helm
<br> Verify whether above componenets are installed in the system,
    ```sh
    $ # terraform
    $ terraform version
    Terraform v0.13.5
    $ # kubectl
    $ kubectl version
    Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.3", GitCommit:"1e11e4a2108024935ecfcb2912226cedeafd99df", GitTreeState:"clean", BuildDate:"2020-10-14T12:50:19Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"darwin/amd64"}
    Server Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.10", GitCommit:"62876fc6d93e891aa7fbe19771e6a6c03773b0f7", GitTreeState:"clean", BuildDate:"2020-10-15T01:43:56Z", GoVersion:"go1.13.15", Compiler:"gc", Platform:"linux/amd64"}
    $ # helm
    $ helm version
    version.BuildInfo{Version:"v3.4.0", GitCommit:"7090a89efc8a18f3d8178bf47d2462450349a004", GitTreeState:"dirty", GoVersion:"go1.15.3"}
    ```
##### Deploy EKS cluster using Terraform
1. Define the all the required vaiable using [terraform.tfvars](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/terraform.tfvars) <br> It is reccomended that  **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY** provide as enviorement variables,
      ```sh
        $ export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
        $ export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>
      ```
      Or even better to use [HashiCorp Vault](https://www.hashicorp.com/resources/managing-vault-with-terraform)
      optionally ingress can be enabled by using allowing [load-balancer.tf_exclude](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/load-balancer.tf_exclude) to execute.
2. Create terraform workspace and initialise terraform
      ```sh
        $ # cd into the Terraform directory 
        $ terraform workspace new challenge
        $ terraform init 
      ```
      It is recomended to maintain a centrlised directory to mange `.tfstate` file where Terraform stores its status of the deployment
3. Create the Terraform plan
     ```sh
        # cd into the Terraform directory 
        $ terraform plan -out=plan.tfplan -var-file=terraform.tfvars
      ```
4. Apply the changes 
     ```sh
        # cd into the Terraform directory 
        $ terraform apply plan.tfplan
      ```
5. Configure `kubectl`
     ```sh
        # cd into the Terraform directory 
        $ terraform output kubectl_config > ~/.kube/config
      ```
6. Verify 
     ```sh
        # cd into the Terraform directory 
        $ kubectl cluster-info
      ```  
##### Deploy the Application using Helm
- Install the application using the Helm chart,
   ```sh
      $ helm install <release-name> <path to the chart>
      $ helm ls
    ```
_Note that, to ingress to be installed it is required to configure AWS Route53 in this case. It is assumed that base domain has already been configured_
- Verify the release
    ```sh
    $ helm ls
    NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
    servian default         1               2020-11-11 11:06:03.751677 +1030 ACDT   deployed        tech-challenge-0.1.0    1.16.0     
    ```
- Upgrade the release
   ```sh
      $ helm upgrade --install --force --set <key>=<value>  <RELEASE_NAME_ ./k8s-helm/tech-challeng
     ```
- Uninstall the release
   ```sh
    helm uninstall <release-name>
   ```
##### Helm Values
Helm chart's default values are available on the [tech-challenge/values.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/values.yaml). These values can be override by `--set <key>=<value>` directive
| Parameter | Description | Default |
| ------ | ------ | ------ |
|app.replicaCount | To manage the number of the replicas | 3  |
|app.config.enabled| To be enabled, if the application should connect to an external database <br> other than the default database| false|
|app.sleep| The grace period, which application should wait to serve|160|
|db.persistData.enabled| If the application should maintain it data persistency |false|
|db.persistData.storageClass.| Configure persistence storage class|N/A|
|db.persistData.persistenceVolume.| Configure the volume. Note that this is **not** a reflection of the <br> Persistence Volumes (PV) of Kubernetes|N/A|
|job.sleep| The Grace period, wait to initialise the Database|120|
|metricServer.enabled| If the Metric Server should be installed. <br> Even though this is not explicitly enabled, enabling autoscaling may install the Metric Server|false|
|nodePort.enabled| Configure a `NodePort` Kubernetes Service for external communication |true|
|loadBalancer.enabled| Configure a `LoadBalncer` Kubernetes Service for external communication |true|

_Note that, default configuration values for the application which feeds at the image build overriddes by [k8s-helm/tech-challenge/templates/app-config.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/app-config.yaml)_
#### With Jenkins
Configuration to the Jenkins pipeline,
1. [Jenkinsfile](https://github.com/krishanthisera/TechChallengeApp/blob/master/Jenkinsfile)
2. [jenkins-build.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/jenkins-build.yaml)
![Pipeline](https://i.ibb.co/ZShf60K/Servian-pipe.png)

##### Jenkins Dependencies
Required plugins for Jenkins:
- [Kubernetes plugin for Jenkins](https://github.com/jenkinsci/kubernetes-plugin)
- [Docker plugin for Jenkins](https://github.com/jenkinsci/docker-plugin)
- [Blue Ocean [Optional for better visualisation]](https://github.com/jenkinsci/blueocean-plugin)

Apart from that, the Kubernetes Plugin for Jenkins should be configured. In most cases, Kubernetes cluster config file should be provided to Jenkins to create and manage Kubernetes resources. Note that, this can be also done via a Kubernetes Service Account and Role Binding. <br>
<br>To retrieve the kube-config file,
```sh
$ # cd into the Terraform directory
$ cd iac
$ terraform output kubectl_config
```
Further, credential for the docker repository should be configured in both the [Jenkinsfile ](https://github.com/krishanthisera/TechChallengeApp/blob/master/Jenkinsfile) and the Jenkins itself.
##### Pipeline Specification
- The BUILD_NUMBER environment variable is used as the image tag
- Customisation to the deployment can be done by setting the helm values
    ```sh
    steps {
             container('helm') {
                    sh "helm upgrade --install --force --set app.image.repository=${DOCKER_REGISTRY} --set app.image.tag=${BUILD_NUMBER} ${RELEASE_NAME} ./k8s-helm/tech-challenge"
                }
            }
    ```
- The [jenkins-build.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/jenkins-build.yaml) describes a pod with required tools which may associate during the pipeline execution,
    - docker: To run the docker commands (build and push)
    - helm: To execute the Helm charts
         ```sh
        ...
        containers:
        - name: docker
          image: docker:19.03
          securityContext:
              #Not recommended - Demonstration purposes only
              allowPrivilegeEscalation: true
              runAsUser: 0
          tty: true
          volumeMounts:
            - name: dockersock
              mountPath: /var/run/docker.sock
        - name: helm
          image: lachlanevenson/k8s-helm:v3.1.1
          tty: true
      volumes:
        - name: dockersock
          hostPath:
            path: /var/run/docker.sock
        ...
         ```
- Depending on the requirement, the Jenkins file should be manipulated manually. For example, it is mandatory to explicitly state whether it is a new release or a release upgrade.
    ```sh
        pipeline {
          parameters {
            //Helm will treat this as a new release
            booleanParam(name: "NEW_RELEASE", defaultValue: true)
            //Helm will purge the old release and redeploy the release
            //booleanParam(name: "PURGE_RELEASE", defaultValue: false)
          }
          ...
    ```
  This may result in which pipeline stage to be used. 
      ```sh
      ...
      parallel {
                stage ('Brand New Release'){
                    when { expression { params.NEW_RELEASE } }
                    steps {
                        container('helm') {
                            sh "helm install --set app.image.repository='${DOCKER_REGISTRY}' --set app.image.tag='${APP_VERSION}.${BUILD_NUMBER}' '${RELEASE_NAME}' ./k8s-helm/tech-challenge --namespace '${RELEASE_NAMESPACE}'"
                        }
                    }
                }
                stage ('Updating the Release'){
                    when { expression { !params.NEW_RELEASE } }
                    steps {
                        container('helm') {
                            sh "helm upgrade --install '${RELEASE_NAME}' --set app.image.repository='${DOCKER_REGISTRY}' --set app.image.tag='${APP_VERSION}.${BUILD_NUMBER}' --namespace '${RELEASE_NAMESPACE}' ./k8s-helm/tech-challenge"
                        }
            ...
      ```
        Especially, the `docker container`'s privilage has been escalated to root (which is not recommended to run on production environments) and it leverages the docker socket from the Host Machine to execute docker commands.
