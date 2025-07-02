resource "aws_instance" "iac_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.ssh_key_name

    tags = {
    Name    = "${var.project_name}-task2-ec2-instance"
    Project = var.project_name
  }
}
