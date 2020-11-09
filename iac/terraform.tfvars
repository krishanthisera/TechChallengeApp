##################################################################################
# AWS Access 
##################################################################################

#Not Recommended
#aws_access_key = "<YOUR_ACCESS_KEY>"
#aws_secret_key = "<YOUR_SECRET_KEY>"

#export AWS_ACCESS_KEY_ID=<YOU_ACCESS_KEY>
#export AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_KEY>


##################################################################################
# Terraform Variables 
##################################################################################
#---Aws
k8s_version          = "1.18"
region               = "ap-southeast-2"
bucket               = "d3v0ps-iac"
key                  = "tf-state.json"
workspace_key_prefix = "environment"


#---VPC Variables 
cluster_name            = "tech-challenge"
iac_environment_tag     = "dev"
name_prefix             = "challenge"
main_network_block      = "10.0.0.0/16"
subnet_prefix_extension = 4
zone_offset             = 8

#---eks-cluster Variables
admin_users                              = ["challenge-admin"]
developer_users                          = ["challenge-developer"]
asg_instance_types                       = ["t3.small", "t2.small"]
autoscaling_minimum_size_by_az           = 1
autoscaling_maximum_size_by_az           = 10
autoscaling_average_cpu                  = 30
spot_termination_handler_chart_name      = "aws-node-termination-handler"
spot_termination_handler_chart_repo      = "https://aws.github.io/eks-charts"
spot_termination_handler_chart_version   = "0.9.1"
spot_termination_handler_chart_namespace = "kube-system"

#---load-balancer Variables
dns_base_domain               = "d3v0ps.com.au"
ingress_gateway_chart_name    = "nginx-ingress"
ingress_gateway_chart_repo    = "https://helm.nginx.com/stable"
ingress_gateway_chart_version = "0.5.2"
ingress_gateway_annotations = {
  "controller.service.httpPort.targetPort"                                                                    = "http",
  "controller.service.httpsPort.targetPort"                                                                   = "http",
  "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"        = "http",
  "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"               = "https",
  "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout" = "60",
  "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                    = "elb"
}

#---dns variables
deployments_subdomains = ["challenge"] 