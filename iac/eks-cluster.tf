##################################################################################
# VARIABLES
##################################################################################
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "k8s_version" {}
variable "common_tags" {}


##################################################################################
# DATA
##################################################################################
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

##################################################################################
# EKS
##################################################################################
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = var.k8s_version
  subnets         = module.vpc.private_subnets
  tags            = merge(var.common_tags)
  vpc_id          = module.vpc.vpc_id

  ##################################################################################
  # EKS - K8s WORKER GROUPS
  ##################################################################################
  worker_groups = [
    { name                 = "k8s-worker-group-1"
      instance_type        = "t2.small"
      asg_desired_capacity = 2
    additional_security_group_ids = "${aws_security_group.K8s_worker_group_1.id}" },
    { name                 = "k8s-worker-group-2"
      instance_type        = "t2.small"
      asg_desired_capacity = 2
    additional_security_group_ids = "${aws_security_group.K8s_worker_group_2.id}" }
  ]
}
