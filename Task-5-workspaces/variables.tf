variable "region" {
  description = "AWS region for resources"
}

variable "ami_id" {
    description = "AMI ID value for EC2 Instance"
}

variable "instance_type" {
    description = "This is the EC2 Instance type, for ex: t2.micro"
    type = string
 /* type = map(string)
    default = {
      "dev" = "t2.micro"
      "test" = "t2.medium"
      "stage" = "t2.xlarge"
    } */
}

