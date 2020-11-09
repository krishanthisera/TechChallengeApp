##################################################################################
# Render Admin & Developer users list with the structure required by EKS module
##################################################################################
locals {
  admin_user_map_users = [
    for admin_user in var.admin_users :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${admin_user}"
      username = admin_user
      groups   = ["system:masters"]
    }
  ]
  developer_user_map_users = [
    for developer_user in var.developer_users :
    {
      userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${developer_user}"
      username = developer_user
      groups   = ["${var.name_prefix}-developers"]
    }
  ]
  worker_groups_launch_template = [
    {
      override_instance_types = var.asg_instance_types
      asg_desired_capacity    = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      asg_min_size            = var.autoscaling_minimum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      asg_max_size            = var.autoscaling_maximum_size_by_az * length(data.aws_availability_zones.available_azs.zone_ids)
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
      public_ip               = true

    },
  ]
}

##################################################################################
# creat EKS cluster
##################################################################################

module "eks" {
  source           = "terraform-aws-modules/eks/aws"
  version          = "12.1.0"
  cluster_name     = "${var.cluster_name}"
  cluster_version  = "1.16"
  write_kubeconfig = false

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  worker_groups_launch_template = local.worker_groups_launch_template

  # Mapping K8s users
  map_users = concat(local.admin_user_map_users, local.developer_user_map_users)
}

