# Tech-Challenge-IaC
[![Terraform](https://www.terraform.io/assets/images/logo-hashicorp-3f10732f.svg)

An Elastic Kubernetes Cluster will be provisioned as the result of this execution.

## Primary Terraform Modules 
1. [EKS Module](https://github.com/terraform-aws-modules/terraform-aws-eks) 
2. [VPC Module](https://github.com/terraform-aws-modules/terraform-aws-vpc)
## File Structure
| File | Description |
| ------ | ------ |
| [provider.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/provider.tf) | Describes Terraform Providers |
| [eks-cluster.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/eks-cluster.tf) | Describes the EKS cluster and its Worker Nodes |
| [vpc.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/vpc.tf) | Describes AWS VPCs |
| [auto-scaling.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/auto-scaling.tf) | Describes resources, including the policies to facilitate autoscaling |
| [ebs-volumes.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/ebs-volumes.tf) | Describe AWS EBS Volume policies to facilitate the data persistency |
| [iam.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/iam.tf) | Describe essential IAM roles |
| [rbac.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/rbac.tf) | An optional config to create EKS role  |
| [load-balancer.tf_exclude](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/load-balancer.tf_exclude)| An optional configuration if it requires provision K8s ingress _(required to remove "exclude")_|
| [variables.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/variables.tf)| All the Terraform variables are defined here|
|[terraform.tfvars](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/terraform.tfvars)|Holds values for the variables|
|[outputs.tf](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/outputs.tf)|Describes/templates Terraform output data|

## How to Run
Verify whether [Terraform is installed](https://learn.hashicorp.com/tutorials/terraform/install-cli) in your computer,
```sh
$ terraform version
```
1. Define all the required vaiable using [terraform.tfvars](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/terraform.tfvars) <br> It is reccomended that  **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY** provide as enviorement variables,
      ```sh
        $ export AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY>
        $ export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>
      ```
      Or even better to use [HashiCorp Vault](https://www.hashicorp.com/resources/managing-vault-with-terraform)
      optionally Ingress can be enabled by allowing [load-balancer.tf_exclude](https://github.com/krishanthisera/TechChallengeApp/blob/master/iac/load-balancer.tf_exclude) to execute.
2. Create terraform workspace and initialise terraform
      ```sh
        $ # cd into the Terraform directory 
        $ terraform workspace new development
        $ terraform init 
      ```
      It is recommended to maintain a centralised directory to manage `.tfstate` file where Terraform stores its status of the deployment
3. Create the Terraform plan
     ```sh
        # cd into the Terraform directory 
        $ terraform plan -out=plan.tfplan -var-file=terraform.tfvars
      ```
4. Apply the changes 
     ```sh
        # cd into the Terraform directory 
        $ terraform apply development.tfplan
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
_Note that, for the Ingress to be installed, it is required to configure AWS Route53 in this case. It is assumed that the base domain has already been configured_