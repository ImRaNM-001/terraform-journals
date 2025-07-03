# 1. Create a VPC
resource "aws_vpc" "task4-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "task4-vpc"
  }
}

# 2. Create 2 Subnets in 2 A-Z's
resource "aws_subnet" "task4-subnet" {
  count = var.subnet_count
  vpc_id                  = aws_vpc.task4-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "task4-subnet-${count.index}"
  }
}

# 3. Create Internet Gateway
    /* Assigns the VPC ID (not the Internet Gateway ID) to the aws_internet_gateway resource. This tells Terraform which VPC to attach the new Internet Gateway to.
    After creation, the actual Internet Gateway’s ID will be available as aws_internet_gateway.igw.id.
    */
resource "aws_internet_gateway" "task4-igw" {
  vpc_id = aws_vpc.task4-vpc.id

  tags = {
    Name = "task4-igw"
  }
}


# 4. Create Route Table
resource "aws_route_table" "task4-rTable" {
  vpc_id = aws_vpc.task4-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task4-igw.id
  }

  tags = {
    Name = "task4-rTable"
  }
}

# 5. Create Route Table Association
resource "aws_route_table_association" "task4-rTable-association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.task4-subnet[count.index].id
  route_table_id = aws_route_table.task4-rTable.id
}


# 6. Create Security Group to expose the EC2 Instance to a public IP
resource "aws_security_group" "task4-instance-sg" {
  name = var.security_group_name
  vpc_id = aws_vpc.task4-vpc.id

  # Inbound configuration
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound configuration
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.security_group_name}"
  }
}


# 7. Create AWS Key Pair
resource "aws_key_pair" "task4-key-pair" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")        # path to the public key file
}