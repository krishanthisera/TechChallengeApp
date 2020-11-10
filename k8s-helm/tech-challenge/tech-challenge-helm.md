# Tech-Challenge-Helm

The **recommended** way of deploying the application


![Helm](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQyA_iUoPksLXi6PmNkCHm_frDELgYbIVHmb0VADyoYRPl1NhP2QmBE_Hjv1CgCPm2AV6ztTxfa6Byi7mGHNOAPlBAkhoxwU4iUmz5TReI&usqp=CAU&ec=45722099)


Using the Helm Charts provided, the application can be deployed independently on any Kubernetes environment. 
Helm chart contains the following templates which describe K8s resources:
| Template | Description |
| ------ | ------ |
|[app-config.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/app-config.yaml)| The template contains application configuration. The environment variables which define <br>here may override the default environment variables which has been provided during the build.  [TechChallengeApp - Configuration](https://github.com/krishanthisera/TechChallengeApp/blob/master/doc/config.md) |
| [db-secrets.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-secrets.yaml) | Contains DB credentials. |
| [challenge-db.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/challenge-db.yaml) | Manifest file for postgres database deployment. |
| [ingress.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/ingress.yaml) | Manifest file for the ingress resource. |
| [seed-job.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/seed-job.yaml) | A Kubernetes Job to execute database seeding. |
| [challenge-app.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/challenge-app.yaml) |  Manifest file for the application. |
| [services.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/services.yaml) | Manifest file for all the Kubernetes service (NodePort, ClusteIP). |
| [db-pvc.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-pvc.yaml) | Manifest file for the Persistence Volume Claim that will be consumed by a database. |
| [hpa.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/hpa.yaml) | Manifest file for Horizontal Pod Autoscaler. |
| [metric-server.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/metric-server.yaml) | If the HPA has been used, the metric server will be deployed using this manifest file. |

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
You may customise the deployment of the application using the [value.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/values.yaml) file. 
The values in the files are straightforward, especially if you should use an external database, 
```sh
db:
    config:
        enabled: true
```
and the database connection deatils must be provided.
Finally release can be upgraded.

```sh
$ helm upgrade <release-name>
```
Application and Database PODs can be configured to autoscale by enabling,
```sh
autoscaling:
    enabled: true
```
More importantly, the [metric server](https://github.com/kubernetes-sigs/metrics-server) will be deployed in kube-system namespace to facilitate [HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) if,
```sh
metricServer:
  enabled: false
```
A **NodePort** configuration can be applied to access the application instead of the ingress. (Port range 30000-32767)

**Sleep timers** have been used to maintain the flow of the execution. For example, the application won’t be accessible until the seeding complete.
```sh
jobs:
  ...
  sleep: 160
 ```
**Data persistency** of the Database can be achieved by,
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
The [db-sc.yaml](https://github.com/krishanthisera/TechChallengeApp/blob/master/k8s-helm/tech-challenge/templates/db-sc.yaml) creates a storage class using the configuration under `storageClass: ` and the Persistence Volume will be created by referring configuration under `persistenceVolume:`.

_Note that, in a scenario where an automatic storage provisioner is unavailable to maintain the data persistence, the user may manually provision the Persistence Volume Claim (PVC)._
