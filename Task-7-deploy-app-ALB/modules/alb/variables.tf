variable project_name {
    description = "Project name for resource naming"
    type = string
}

variable alb_sg_id {
    description = "Security Group ID for the Application Load Balancer"
    type = string
}

variable pub_sub_1a_id {
    description = "Public Subnet ID for the NAT Gateway"
    type = string
}

variable pub_sub_2b_id {
    description = "Public Subnet ID for the NAT Gateway"
    type = string
}

variable vpc_id {
    description = "VPC ID"
    type = string
}
