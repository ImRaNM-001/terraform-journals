variable "region" {
  description = "AWS region for resources"
}

variable "cidr_block" {
  description = "Default CIDR block for the subnet"
}

variable "key_name" {
  description = "Public key name for ssh authentication"
}

variable "subnet_count" {
  description = "Count of subnet to be created"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "security_group_name" {
  description = "Name of the security group"
}

variable "ami_id" {
    description = "AMI ID value for EC2 Instance"
}

variable "instance_type" {
    description = "EC2 Instance type value"
}

