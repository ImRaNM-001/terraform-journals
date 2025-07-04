# [OPTIONAL] terraform block
/**
  unless Terraform version & provider not installed locally
  helps ensure version consistency across teams & environments
*/
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 1.12"     # Use compatible version for Terraform v1.12.x
    }
  }

  required_version = ">= 1.12.0"
}

# setting the cloud provider
provider "aws" {
  region = "ap-south-1"            # Set the desired AWS region
}

# creating an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0f918f7e67a3323f0"    # Specify an appropriate AMI ID
  instance_type = "t2.nano"
  key_name = "test-key"
  subnet_id = "subnet-0e6ba2b5e28daaa1c"    # Optional field
}




