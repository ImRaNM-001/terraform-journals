resource "aws_instance" "task-5-iac-instance" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
    Name    = "task-5-ec2-instance"
  }
}


