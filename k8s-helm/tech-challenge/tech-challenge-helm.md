# Tech-Challenge-Helm

[![N|Solid](https://www.katacoda.com/sylus/courses/kubernetes-cncf/module-1/assets/helm-logo.png)](https://nodesource.com/products/nsolid)

Using the Helm Charts provided, the application can be deployed independently any Kubernetes enviorment. 
Helm chart contains following templates which describes K8s resources,
- app-config.yaml
   The template contains application configuration. The envioremnt variable wich defines here may overide the default enviorement which has been provided during the build.  [TechChallengeApp - Configuration](https://github.com/krishanthisera/TechChallengeApp/blob/master/doc/config.md)
- db-secrets.yaml
    Contains DB credentials
- challenge-db.yaml
    Manifest file for postgress databse deployement
- ingress.yaml
    Manifest file for the ingress resource.
- seed-job.yaml  
    A kuberentes Job to execute database seeding
- challenge-app.yaml      
    Manifest file for the application
- services.yaml
    Manifest file for all the Kubernetes service (NodePort, ClusteIP)
- db-pvc.yaml 
    Manifest file for the Persistance volume claim which is to consume by database
- hpa.yaml
    Manifest file for Horizontal Pod Autoscaler
- metric-server.yaml  
    In case HPA has been used, metric server will be deployed using this manifest file

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
and the database connection deatils must be provided
finally release can be upgraded.

```sh
$ helm upgrade <release-name>
```


