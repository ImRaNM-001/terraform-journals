# Create EC2 Instance and attach provisioner
resource "aws_instance" "task4-ec2-server" {
  count                  = var.subnet_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.task4-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.task4-instance-sg.id]
  subnet_id              = aws_subnet.task4-subnet[count.index].id

  connection {
    type        = "ssh"
    user        = "ubuntu"              # username of the EC2 instance
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
    /* uses public IP address of this EC2 instance as the SSH host.
    `self` refers to the current resource being defined—in this case, the `aws_instance` resource.
    `public_ip` is an attribute of the EC2 instance resource, representing the public IPv4 address assigned to the instance after creation.
    */
  }

  # File provisioner to copy files from local to remote EC2 instance,
  # Copy app.py
  provisioner "file" {
    source      = "app.py"                              # path to the source application file
    destination = "/home/ubuntu/app.py"                 # path on the remote instance (destination path)
  }

  # Copy requirements.txt
  provisioner "file" {
    source      = "requirements.txt"
    destination = "/home/ubuntu/requirements.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                         # Update package lists (for ubuntu)
      "sudo apt install -y python3-pip",            # Example package installation
      "cd /home/ubuntu",
      "sudo apt install python3-fastapi uvicorn -y",
      "nohup sudo uvicorn app:app --host 0.0.0.0 --port 80 &"
      /* nohup ... & ensures the FastAPI server runs in the background and does not block the provisioner.
      */
    ]
  }
}
