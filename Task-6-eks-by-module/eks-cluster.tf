module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.37.1"       # version parameter in module blocks must be a hardcoded string (variabilizing not allowed by terraform)
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

/* IRSA stands for IAM Roles for Service Accounts. It allows Kubernetes pods to assume AWS IAM roles without storing AWS credentials.
 - When enable_irsa = true, it creates an OpenID Connect (OIDC) identity provider for your EKS cluster, which enables pods to securely access AWS services using IAM roles instead of hardcoded credentials.
 - Essential for secure AWS service integration from within Kubernetes      */

  enable_irsa = true

  # To access worker nodes from other instances i.e, other VPC's (publicly), enable these endpoint configurations (not a production practice)
  # cluster_endpoint_public_access  = true
  # cluster_endpoint_private_access = true
  # cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  
  tags = {
    cluster = "task-6-eks-by-module"
  }  

  eks_managed_node_group_defaults = {
    ami_type               = var.node_group_ami_type
    instance_types         = [var.node_group_instance_type]
    vpc_security_group_ids = [aws_security_group.all_workers.id]
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }
}

/** CLI reference:
eksctl create cluster --name <CLUSTER_NAME> --region <REGION_NAME> --nodegroup-name <NODEGROUP_NAME> --node-type <INSTANCE_TYPE> --nodes <TOTAL_NODES> --nodes-min <MIN_NODES> --nodes-max <MAX_NODES> --managed
*/
