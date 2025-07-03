# Root module calls ec2_instance module
module "ec2_instance" {
  source = "./modules/ec2_instance"
  instance_type = "t2.nano"
  ami_id        = "ami-0f918f7e67a3323f0"
  ssh_key_name  = "test-key"
  project_name = "terraform-journals"
  region = "ap-south-1"
  
  # Common tags
  # common_tags = {
  #   Environment = "development"
  #   Project     = "terraform-journals"
  #   ManagedBy   = "terraform"
  # }

}