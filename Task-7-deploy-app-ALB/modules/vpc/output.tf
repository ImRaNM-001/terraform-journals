output "region" {
    description = "AWS Region name"
    value = var.region
}

output "project_name" {
    description = "Project name for resource naming"
    value = var.project_name
}

output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.vpc.id
}

output "pub_sub_1a_id" {
    description = "Public Subnet ID for the NAT Gateway"
    value = aws_subnet.pub_sub_1a.id
}

output "pub_sub_2b_id" {
    description = "Public Subnet ID for the NAT Gateway"
    value = aws_subnet.pub_sub_2b.id
}

output "priv_sub_3a_id" {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    value = aws_subnet.priv_sub_3a.id
}

output "priv_sub_4b_id" {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    value = aws_subnet.priv_sub_4b.id
}

output "priv_sub_5a_id" {
    description = "Private Subnet hosting the DB Server (RDS) Instance"
    value = aws_subnet.priv_sub_5a.id
}

output "priv_sub_6b_id" {
    description = "Private Subnet hosting the DB Server (RDS) Instance"
    value = aws_subnet.priv_sub_6b.id 
}

output "igw_id" {
    description = "Internet Gateway resource ID"
    value = aws_internet_gateway.internet_gateway.id
    /* 
    - Not to Output the entire IGW resource object but just the string ID 
    - i.e, .id which extracts just the ID string from the IGW resource) to align with `string` type of 
        variable igw_id {} in file: "/modules/nat-gateway/variables.tf"         */
}
