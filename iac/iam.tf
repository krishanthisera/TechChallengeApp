##################################################################################
# IAM Role for the workernodes
##################################################################################
resource "aws_iam_role" "eks_worknode" {
  name = "${var.cluster_name}-worknode"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
