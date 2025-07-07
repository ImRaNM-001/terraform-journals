module "vpc" {
    source = "./modules/vpc"
    region = var.region
    project_name = var.project_name
    vpc_cidr         = var.vpc_cidr

    pub_sub_1a_cidr = var.pub_sub_1a_cidr               # public subnet for the NAT Gateway
    pub_sub_2b_cidr = var.pub_sub_2b_cidr

    priv_sub_3a_cidr = var.priv_sub_3a_cidr             # private subnet for the Web Servers
    priv_sub_4b_cidr = var.priv_sub_4b_cidr

    priv_sub_5a_cidr = var.priv_sub_5a_cidr             # private subnet for the DB Servers
    priv_sub_6b_cidr = var.priv_sub_6b_cidr
}

module "nat-gateway" {
    source = "./modules/nat-gateway"    
    vpc_id        = module.vpc.vpc_id
    igw_id        = module.vpc.igw_id

    pub_sub_1a_id = module.vpc.pub_sub_1a_id
    pub_sub_2b_id = module.vpc.pub_sub_2b_id
  
    priv_sub_3a_id = module.vpc.priv_sub_3a_id
    priv_sub_4b_id = module.vpc.priv_sub_4b_id

    priv_sub_5a_id = module.vpc.priv_sub_5a_id
    priv_sub_6b_id = module.vpc.priv_sub_6b_id
    }

module "security-group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

# Create Key-Pair for instances
module "key-pair" {
  source = "./modules/key-pair"
}

# Create Application Load balancer
module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id

  project_name   = module.vpc.project_name                  # calling `project_name` from `output.tf` file of vpc module
  alb_sg_id      = module.security-group.alb_sg_id          # calling `alb_sg_id` from `output.tf` file of security-group module

  pub_sub_1a_id = module.vpc.pub_sub_1a_id                  # Application Load Balancer is pointed to both the public subnets
  pub_sub_2b_id = module.vpc.pub_sub_2b_id  
}

# Create Auto Scaling Group
module "asg" {
  source         = "./modules/asg"
  project_name   = module.vpc.project_name

  key_name       = module.key-pair.key_name
  target_grp_arn = module.alb.target_grp_arn                # calling `target group arn` from `output.tf` file of alb module
  client_sg_id   = module.security-group.client_sg_id       # calling `client security group id` from `output.tf` file of security-group module

  priv_sub_3a_id = module.vpc.priv_sub_3a_id                # Both the Web-Server EC2 instances in the private subnets connects to Auto Scaling Group 
  priv_sub_4b_id = module.vpc.priv_sub_4b_id
}

# Create RDS instance
module "rds" {
  source         = "./modules/rds"
  db_sg_id       = module.security-group.db_sg_id           # calling `db security group id` from `output.tf` file of security-group module
  db_username    = var.db_username
  db_password    = var.db_password

  priv_sub_5a_id = module.vpc.priv_sub_5a_id                # The DB Server (RDS) instance is placed in the private subnets
  priv_sub_6b_id = module.vpc.priv_sub_6b_id  
}

# Create Cloudfront distribution for CDN
/*
module "cloudfront" {
    source = "./modules/cdn-cloudfront"
    project_name = module.vpc.project_name

    certificate_domain_name = var.certificate_domain_name
    additional_domain_name = var.additional_domain_name
    
    alb_domain_name = module.alb.alb_dns_name               # calling `alb DNS name` from `output.tf` file of alb module
}

# Add a record in Route53 hosted zone
module "route53" {
  source = "./modules/route53"
  cloudfront_domain_name = module.cdn-cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cdn-cloudfront.cloudfront_hosted_zone_id
}         */
