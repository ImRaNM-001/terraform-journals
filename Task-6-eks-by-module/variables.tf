variable "kubernetes_version" {
  description = "Kubernetes version to be installed on the EKS cluster"
  type = string
}

variable "node_group_ami_type" {
  description = "AMI Type of the EC2 node groups"
  type = string
}

variable "node_group_instance_type" {
  description = "EC2 Instance types for each instance in the node group"
  type = string
}

variable "security_group_cidr_blocks" {
  description = "CIDR blocks used in the security group"
  type = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block range in the VPC"
  type = string
}

variable "aws_region" {
  description = "AWS region in which the cluster and other configurations are created"
  type = string
}

variable "iam_user_arn" {
  description = "Amazon Resource Name (ARN) for the IAM user responsible to create the cluster"
  type = string
}