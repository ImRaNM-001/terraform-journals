# 1. Create VPC
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support =  true

  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}

# 2. Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.project_name}-igw"
  }
}

# 3. use `data source` to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}         # ex: ["ap-south-1a", "ap-south-1b", "ap-south-1c"]


# 4(a). Create Public Subnet `pub_sub_1a`
resource "aws_subnet" "pub_sub_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_1a_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Pub_sub_1a"
  }
}

# 4(b). Create Public Subnet `pub_sub_2b`
resource "aws_subnet" "pub_sub_2b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_sub_2b_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Pub_sub_2b"
  }
}

# 5(a). Create Route Table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "Public-RT"
  }
}

# 5(b). Associate Public Subnet `pub-sub-1a` to public route table
resource "aws_route_table_association" "pub-sub-1a_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_1a.id
  route_table_id      = aws_route_table.public_route_table.id
}

# 5(c). Associate Public Subnet `pub-sub-2b` to public route table
resource "aws_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id           = aws_subnet.pub_sub_2b.id
  route_table_id      = aws_route_table.public_route_table.id
}


# 6(a). Create Private app subnet `priv-sub-3a`
resource "aws_subnet" "priv_sub_3a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_3a_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Priv-sub-3a"
  }
}

# 6(b). Create Private app subnet `priv-sub-4b`
resource "aws_subnet" "priv_sub_4b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_4b_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Priv-sub-4b"
  }
}

# 7(a). Create Private data subnet `priv-sub-5a`
resource "aws_subnet" "priv_sub_5a" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_5a_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Priv-sub-5a"
  }
}

# 7(b). Create Private data subnet `priv-sub-6b`
resource "aws_subnet" "priv_sub_6b" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.priv_sub_6b_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Priv-sub-6b"
  }
}
