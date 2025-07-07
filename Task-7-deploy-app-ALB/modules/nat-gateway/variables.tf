variable pub_sub_1a_id {
    description = "Public Subnet ID for the NAT Gateway"
    type = string
}

variable pub_sub_2b_id {
    description = "Public Subnet ID for the NAT Gateway"
    type = string
}

variable priv_sub_3a_id {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    type = string
}

variable priv_sub_4b_id {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    type = string
}

variable priv_sub_5a_id {
    description = "Private Subnet hosting the DB Server (RDS) Instance"
    type = string
}

variable priv_sub_6b_id {
    description = "Private Subnet hosting the DB Server (RDS) Instance"
    type = string
}

variable igw_id {
    description = "Internet Gateway resource ID"
    type = string
}

variable vpc_id {
    description = "VPC ID"
    type = string
}
