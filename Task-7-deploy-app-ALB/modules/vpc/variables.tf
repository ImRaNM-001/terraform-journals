variable region {
  description = "AWS region in which the cluster and other configurations are created"
  type = string
}

variable project_name {
    description = "Project name for resource naming"
    type = string
}

variable vpc_cidr {
    description = "Range of the CIDR for the VPC"
    type = string
}       

variable pub_sub_1a_cidr {
    description = "Public Subnet for the NAT Gateway"
    type = string
}

variable pub_sub_2b_cidr {
    description = "Public Subnet for the NAT Gateway"
    type = string
}

variable priv_sub_3a_cidr {
    description = "Private Subnet for the Web Servers"
    type = string
}

variable priv_sub_4b_cidr {
    description = "Private Subnet for the Web Servers"
    type = string
}

variable priv_sub_5a_cidr {
    description = "Private Subnet for the DB Servers"
    type = string
}

variable priv_sub_6b_cidr {
    description = "Private Subnet for the DB Servers"
    type = string
}

