resource "aws_security_group" "alb_sg" {
  name        = "alb security group"
  description = "Enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}

# Create Security Group for the Client
resource "aws_security_group" "client_sg" {
  name        = "client_sg"
  description = "Enable http/https access on port 80 for elb security group"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]        # Allow incoming traffic (ingress) FROM the alb security group TO this client. This ensures only traffic that passed through the alb can reach the instance
  }
  /**
    - The client instances (EC2s) are in private subnets & alb is in public subnets
    - This security group rule says "only accept HTTP traffic if it's coming from the alb"
    - This is a common security pattern to ensure all traffic is filtered through the alb first
  */

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Client_sg"
  }
}

# Create Security Group for the Database
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Enable mysql access on port 3305 from client-sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "mysql access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.client_sg.id]         # Allow incoming traffic (ingress) FROM the client security group TO this db. This ensures only traffic that passed through the client can reach the db
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database_sg"
  }
}
