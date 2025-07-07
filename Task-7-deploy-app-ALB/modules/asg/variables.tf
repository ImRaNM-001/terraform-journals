variable "project_name"{
    description = "Project name for resource naming"
    type = string
}

variable "ami_id" {
    description = "AMI ID value for EC2 Instance"
    type = string
    default = "ami-0f918f7e67a3323f0"
}

variable "instance_type" {
    description = "EC2 Instance instance type"
    type = string
    default = "t2.micro"
}

variable "key_name" {
    description = "key name of the key pair"
    type = string
}

variable "client_sg_id" {
    description = "Client Security Group ID"
    type = string
}

variable "asg_max_size" {
    description = "Max size of the Auto Scaling Group"
    type = string
    default = 6
}

variable "asg_min_size" {
    description = "Min size of the Auto Scaling Group"
    type = string
    default = 2
}

variable "asg_desired_cap" {
    description = "Desired size of the Auto Scaling Group"
    type = string
    default = 3
}

variable "asg_health_check_type" {
    description = "Health Check type of the Auto Scaling Group"
    type = string
    default = "ELB"
}

variable "priv_sub_3a_id" {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    type = string
}

variable "priv_sub_4b_id" {
    description = "Private Subnet hosting the Web-Server EC2 Instance"
    type = string
}

variable "target_grp_arn" {
    description = "Target Group ARN for the Auto Scaling Group"
    type = string
}
