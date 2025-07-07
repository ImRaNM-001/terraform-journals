resource "aws_eks_access_entry" "task-6-eks-by-module" {
  cluster_name      = module.eks.cluster_name               # referencing the `eks` module
  principal_arn     = var.iam_user_arn      # "existing user ARN" links/binds both the blocks by referencing the same IAM role.
  kubernetes_groups = ["task-6-eks-group-1", "task-6-eks-group-2"]
  type              = "STANDARD"            # other options: EC2 Linux, EC2 Windows, Fargate
}


/** Create Fresh New IAM role (more flexible for production) for `role-based access` instead of user-based access.
resource "aws_iam_role" "task-6-eks-by-module" {
  name = "task-6-eks-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

then,
principal_arn     = aws_iam_role.task-6-eks-by-module.arn
*/