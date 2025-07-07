resource "aws_eks_access_policy_association" "task-6-eks-by-module-policy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"  # this is "predefined" access policy by AWS EKS (not IAM) that gets automatically created when we use EKS.
  
  principal_arn = var.iam_user_arn

  access_scope {
    type = "cluster"
  }
}
