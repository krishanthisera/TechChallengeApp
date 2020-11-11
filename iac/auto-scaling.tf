##################################################################################
# Get EKS cluster info to configure Kubernetes and Helm providers
##################################################################################

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


##################################################################################
# Deploy spot termination handler
##################################################################################

resource "helm_release" "spot_termination_handler" {
  name       = var.spot_termination_handler_chart_name
  chart      = var.spot_termination_handler_chart_name
  repository = var.spot_termination_handler_chart_repo
  version    = var.spot_termination_handler_chart_version
  namespace  = var.spot_termination_handler_chart_namespace
}
##################################################################################
# Add spot fleet Autoscaling policy
##################################################################################

resource "aws_autoscaling_policy" "eks_autoscaling_policy" {
  count = length(local.worker_groups_launch_template)

  name                   = "${module.eks.workers_asg_names[count.index]}-autoscaling-policy"
  autoscaling_group_name = module.eks.workers_asg_names[count.index]
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}