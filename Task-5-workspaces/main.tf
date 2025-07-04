# Root module calls ec2_instance module
module "ec2_instance" {
  source = "./modules/ec2_instance"
  instance_type = var.instance_type
  # instance_type = lookup(instance_type, terraform.workspace, "t2.nano")
  ami_id        = var.ami_id
  region        = var.region
}





