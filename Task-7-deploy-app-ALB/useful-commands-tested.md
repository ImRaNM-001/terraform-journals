# AWS Infrastructure Deployment Guide

## Prerequisites
- SSH Key Generation for EC2 access
```sh
  ssh-keygen -t rsa
  ```
NOTE: The public key from the key pair generated is later used in file [id_rsa.pub](../Task-7-deploy-app-ALB/modules/key-pair/main.tf)

- AWS CLI configuration for authentication

## Architecture Components
- **VPC & Networking**: VPC with public/private subnets, NAT gateways, and route tables
- **Security**: Security groups for ALB, application instances, and RDS
- **Application**: Auto Scaling Group with launch template and EC2 instances
- **Database**: RDS MySQL instance in private subnets
- **Load Balancing**: Application Load Balancer with HTTP/HTTPS listeners

## Infrastructure Verification
- Terraform state management commands
- AWS CLI commands for resource validation
- Drift detection techniques

## Database Configuration
- MySQL engine version compatibility
- RDS instance type considerations
- Subnet group configuration

## Security Group Details
- ALB security group configuration (ports 80/443)
- Instance security groups for application tier
- Database security group for RDS access

## Deployment Variables
- Region and resource naming
- Network CIDR allocations
- Database credentials

## Troubleshooting
- Drift detection and remediation
- Security group rule verification
- RDS configuration compatibility issues


### Example `terraform.tfvars`
```hcl
region = "ap-south-1"
project_name = "sevweeksofcloudops"
vpc_cidr = "10.0.0.0/16"

# public subnet for the NAT Gateway
pub_sub_1a_cidr = "10.0.1x.0/24"
pub_sub_2b_cidr = "10.0.x.0/24"

# private subnet for the Web Servers
priv_sub_3a_cidr = "10.0.x.0/24"
priv_sub_4b_cidr = "10.0.x.0/24"

# private subnet for the DB Servers
priv_sub_5a_cidr = "10.0.x.0/24"
priv_sub_6b_cidr = "10.0.x.0/24"

db_username = "xxxx"
db_password = "xxxx123"

# certificate_domain_name = "TF-cloud-ops-series"
# additional_domain_name = "www.tfcloudopsseriessimplified"
```
---

## Commands tested during the excercise
(check compatible `mysql engine version` for the RDS instance)
```sh
aws rds describe-db-engine-versions --engine mysql --query 'DBEngineVersions[*].[EngineVersion,SupportedEngineModes]' --output table

    ---------------------------------
    |   DescribeDBEngineVersions    |
    +----------------------+--------+
    |  5.7.44              |  None  |
    |  5.7.44-rds.20240408 |  None  |
    |  5.7.44-rds.20240529 |  None  |
    |  5.7.44-rds.20240808 |  None  |
    |  5.7.44-rds.20250103 |  None  |
    |  5.7.44-rds.20250213 |  None  |
    |  5.7.44-rds.20250508 |  None  |
    |  8.0.32              |  None  |
    |  8.0.33              |  None  |
    |  8.0.34              |  None  |
    |  8.0.35              |  None  |
    |  8.0.36              |  None  |
    |  8.0.37              |  None  |
    |  8.0.39              |  None  |
    |  8.0.40              |  None  |
    |  8.0.41              |  None  |
    |  8.0.42              |  None  |
    |  8.4.3               |  None  |
    |  8.4.4               |  None  |
    |  8.4.5               |  None  |
    +----------------------+--------+
```

(check all the resources Terraform is currently tracking in the state file, this command lists everything Terraform has created and is managing — like EC2 instances, S3 buckets, IAM roles, etc.)
```sh
tf state list

        module.alb.aws_lb.application_load_balancer
        module.alb.aws_lb_listener.alb_http_listener
        module.alb.aws_lb_target_group.alb_target_group
        module.asg.aws_autoscaling_group.asg_name
        module.asg.aws_autoscaling_policy.scale_down
        module.asg.aws_autoscaling_policy.scale_up
        module.asg.aws_cloudwatch_metric_alarm.scale_down_alarm
        module.asg.aws_cloudwatch_metric_alarm.scale_up_alarm
        module.asg.aws_launch_template.template_name
        module.key-pair.aws_key_pair.client_key
        module.nat-gateway.aws_eip.eip-nat-a
        module.nat-gateway.aws_eip.eip-nat-b
        module.nat-gateway.aws_nat_gateway.nat-a
        module.nat-gateway.aws_nat_gateway.nat-b
        module.nat-gateway.aws_route_table.priv-rt-a
        module.nat-gateway.aws_route_table.priv-rt-b
        module.nat-gateway.aws_route_table_association.priv-sub-3a-with-priv-rt-a
        module.nat-gateway.aws_route_table_association.priv-sub-4b-with-priv-rt-a
        module.nat-gateway.aws_route_table_association.priv-sub-5a-with-priv-rt-b
        module.nat-gateway.aws_route_table_association.priv-sub-6b-with-priv-rt-b
        module.rds.aws_db_instance.db
        module.rds.aws_db_subnet_group.db_subnet
        module.security-group.aws_security_group.alb_sg
        module.security-group.aws_security_group.client_sg
        module.security-group.aws_security_group.db_sg
        module.vpc.data.aws_availability_zones.available_zones
        module.vpc.aws_internet_gateway.internet_gateway
        module.vpc.aws_route_table.public_route_table
        module.vpc.aws_route_table_association.pub-sub-1a_route_table_association
        module.vpc.aws_route_table_association.pub-sub-2-b_route_table_association
        module.vpc.aws_subnet.priv_sub_3a
        module.vpc.aws_subnet.priv_sub_4b
        module.vpc.aws_subnet.priv_sub_5a
        module.vpc.aws_subnet.priv_sub_6b
        module.vpc.aws_subnet.pub_sub_1a
        module.vpc.aws_subnet.pub_sub_2b
        module.vpc.aws_vpc.vpc
```

---

(for ex: see all outputs from the `VPC module`)
```sh
tf state show module.<resource_name>
ex: tf state show module.vpc.aws_vpc.vpc

    # module.vpc.aws_vpc.vpc:
    resource "aws_vpc" "vpc" {
        arn                                  = "arn:aws:ec2:ap-south-1:xxxxx407444:vpc/vpc-01xx81xx1433"
        assign_generated_ipv6_cidr_block     = false
        cidr_block                           = "10.0.0.0/16"
        default_network_acl_id               = "acl-07xxxxdf08e19"
        default_route_table_id               = "rtb-0f5xxxx99656"
        default_security_group_id            = "sg-05axxxx6cb45"
        dhcp_options_id                      = "dopt-01f02xxxe6xxxxbf"
        enable_dns_hostnames                 = true
        enable_dns_support                   = true
        enable_network_address_usage_metrics = false
        id                                   = "vpc-01xxx411433"
        instance_tenancy                     = "default"
        ipv6_association_id                  = null
        ipv6_cidr_block                      = null
        ipv6_cidr_block_network_border_group = null
        ipv6_ipam_pool_id                    = null
        ipv6_netmask_length                  = 0
        main_route_table_id                  = "rtb-xxxx1003xx656"
        owner_id                             = "xxxxx407444"
        tags                                 = {
            "Name" = "sevweeksofcloudops-vpc"
        }
        tags_all                             = {
            "Name" = "sevweeksofcloudops-vpc"
        }
    }
```

(detected a drift)
```sh
tf plan -detailed-exitcode

         # (3 unchanged blocks hidden)
        }

        # module.security-group.aws_security_group.<SG_GROUP_NAME> will be updated in-place
        ~ resource "aws_security_group" "alb_sg" {
              id                     = "sg-047000xxxx8a6"
            ~ ingress                = [
                - {
                    - cidr_blocks      = [
                        - "0.0.0.0/0",
                      ]
                    - from_port        = 8090
                    - ipv6_cidr_blocks = []
                    - prefix_list_ids  = []
                    - protocol         = "tcp"
                    - security_groups  = []
                    - self             = false
                    - to_port          = 8090               # this was changed in UI console manually & detected
                      # (1 unchanged attribute hidden)
                  },
                  # (2 unchanged elements hidden)
              ]
              name                   = "alb security group"
              tags                   = {
                  "Name" = "alb_sg"
              }
              # (8 unchanged attributes hidden)
          }
      
      Plan: 0 to add, 2 to change, 0 to destroy.
```


(then see full details of the affected resource so to relate what has been `drifted`)
```sh
tf state show module.security-group.aws_security_group.<SG_GROUP_NAME>
ex: tf state show module.security-group.aws_security_group.alb_sg

    # module.security-group.aws_security_group.alb_sg:
    resource "aws_security_group" "alb_sg" {
        arn                    = "arn:aws:ec2:ap-south-1:xxxxx407444:security-group/sg-047f9715b777298a6"
        description            = "Enable http/https access on port 80/443"
        egress                 = [
            {
                cidr_blocks      = [
                    "0.0.0.0/0",
                ]
                description      = null
                from_port        = 0
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                protocol         = "-1"
                security_groups  = []
                self             = false
                to_port          = 0
            },
        ]
        id                     = "sg-047000xxxx8a6"
        ingress                = [
            {
                cidr_blocks      = [
                    "0.0.0.0/0",
                ]
                description      = "HTTP access"
                from_port        = 80
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                protocol         = "tcp"
                security_groups  = []
                self             = false
                to_port          = 80
            },
            {
                cidr_blocks      = [
                    "0.0.0.0/0",
                ]
                description      = "HTTPS access"
                from_port        = 443
                ipv6_cidr_blocks = []
                prefix_list_ids  = []
                protocol         = "tcp"
                security_groups  = []
                self             = false
                to_port          = 443
            },
        ]
        name                   = "alb security group"
        name_prefix            = null
        owner_id               = "xxxxx407444"
        revoke_rules_on_delete = false
        tags                   = {
            "Name" = "alb_sg"
        }
        tags_all               = {
            "Name" = "alb_sg"
        }
        vpc_id                 = "vpc-01xxx141xx33"
}
```


