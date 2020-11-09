# Tech-Challenge-Helm
The **recommended** way of the deploying the application
[![N|Solid](https://www.katacoda.com/sylus/courses/kubernetes-cncf/module-1/assets/helm-logo.png)](https://nodesource.com/products/nsolid)

Using the Helm Charts provided, the application can be deployed independently on any Kubernetes enviorment. 
Helm chart contains following templates which describes K8s resources,
- [app-config.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/app-config.yaml)
<br> The template contains application configuration. The envioremnt variable wich defines here may overide the default enviorement which has been provided during the build.  [TechChallengeApp - Configuration](https://github.com/krishanthisera/TechChallengeApp/blob/master/doc/config.md)
- [db-secrets.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-secrets.yaml)
<br> Contains DB credentials
- [challenge-db.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/challenge-db.yaml)\
<br> Manifest file for postgress databse deployement
- [ingress.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/ingress.yaml)
<br> Manifest file for the ingress resource.
- [seed-job.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/seed-job.yaml)  
<br> A kuberentes Job to execute database seeding
- [challenge-app.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/challenge-app.yaml)      
<br> Manifest file for the application
- [services.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/services.yaml)
<br> Manifest file for all the Kubernetes service (NodePort, ClusteIP)
- [db-pvc.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-pvc.yaml) 
<br> Manifest file for the Persistance volume claim which is to consume by database
- [hpa.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/hpa.yaml)
<br> Manifest file for Horizontal Pod Autoscaler
- [metric-server.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/metric-server.yaml)  
<br> In case HPA has been used, metric server will be deployed using this manifest file

# How to run
In case if you should execute these Helm chart locally,
```sh
$ helm install <release-name> <path to the chart>
$ helm ls
```
To unistall the release
```sh
$ helm uninstall <release-name>
```
# Helm Values
You may customise the deployment of the application by using the [value.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/values.yaml) file 
The values in the files are straightforward, especially if you should use an external database, 
```sh
db:
    config:
        enabled: true
```
and the database connection deatils must be provided.
finally release can be upgraded.

```sh
$ helm upgrade <release-name>
```
Application and Database PODs can be configured to autoscale by enabeling,
```sh
autoscaling:
    enabled: true
```
More importantly, the [metric server](https://github.com/kubernetes-sigs/metrics-server) will be deployed in kube-system namespace to facilitate [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) if,
```sh
metricServer:
  enabled: false
```
A **NodePort** configuration can be used to access the application instead for the ingress. (Port range 30000-32767)

**Sleep timers** has been used to maintain the flow of the execution. For example, until the seeding complete the application won't be accessable.
```sh
jobs:
  ...
  sleep: 160
 ```
**Data persistency** of the Database can be achived by,
```sh
db:
  ...
  persistData:
    enabled: true
    storageClass:
      provisioner: kubernetes.io/aws-ebs
      type: gp2
      reclaimPolicy: Retain
    persistenceVolume:
      accessModes: ReadWriteOnce
      storage: 1Gi
```
The [db-sc.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-sc.yaml) creates a storage class using the configuration under `storageClass: ` and the persistence volume will be create the by refering configuration under `persistenceVolume:`.

_Note that, in a scenatio where an automatic storage provisioner is unavailable to maintain the data persistency user may manually provision the Persistence Volumes (PV)._
