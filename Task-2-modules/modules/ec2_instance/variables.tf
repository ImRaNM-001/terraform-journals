# Module input variables
variable "ssh_key_name" {
  description = "SSH key name for authentication"
  type = string
}

variable "ami_id" {
    description = "AMI ID value for EC2 Instance"
    type = string
}

variable "instance_type" {
    description = "EC2 Instance type value"
    type = string
}

variable "project_name" {
  description = "Project name for resource naming"
   type = string
}

variable "region" {
  description = "AWS region for resources"
  type = string
}