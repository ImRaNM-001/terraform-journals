# pick all available AZs in current AWS region. ex: ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"            # Changed from 6.0.1 to 5.13.0 (compatible with AWS provider 5.x)

  name                 = "task-6-vpc-${random_string.suffix.result}"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = [cidrsubnet(var.vpc_cidr, 8, 1),
                        cidrsubnet(var.vpc_cidr, 8, 2)]
  
  public_subnets       = [cidrsubnet(var.vpc_cidr, 8, 4),
                        cidrsubnet(var.vpc_cidr, 8, 5)]
  
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
