# Allocate Elastic IP, which will be used for the nat-gateway in the public subnet `pub-sub-1-a`
resource "aws_eip" "eip-nat-a" {
  domain = "vpc"

  tags   = {
    Name = "eip-nat-a"
  }
}

# Allocate Elastic IP, which will be used for the nat-gateway in the public subnet `pub-sub-2-b`
resource "aws_eip" "eip-nat-b" {
  domain = "vpc"

  tags   = {
    Name = "eip-nat-b"
  }
}

# Create NAT Gateway in public subnet `pub-sub-1a`
resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.eip-nat-a.id
  subnet_id     = var.pub_sub_1a_id

  tags   = {
    Name = "nat-a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency on the internet gateway for the vpc
  depends_on = [var.igw_id]
}

# Create NAT Gateway in public subnet `pub-sub-2b`
resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = var.pub_sub_2b_id

  tags   = {
    Name = "nat-b"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.igw_id]
}


# Create Private Route Table `Priv-RT-A` and add route through `nat-a`
resource "aws_route_table" "priv-rt-a" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-a.id
  }

  tags   = {
    Name = "Priv-rt-a"
  }
}

# Associate Private Subnet `priv-sub-3a` with Private Route Table `priv-rt-a`
resource "aws_route_table_association" "priv-sub-3a-with-priv-rt-a" {
  subnet_id         = var.priv_sub_3a_id
  route_table_id    = aws_route_table.priv-rt-a.id
}

# Associate Private Subnet `priv-sub-4b` with Private Route Table `priv-rt-a`
resource "aws_route_table_association" "priv-sub-4b-with-priv-rt-a" {
  subnet_id         = var.priv_sub_4b_id
  route_table_id    = aws_route_table.priv-rt-a.id
}


# Create Private Route Table `priv-rt-b` and add route through `nat-b`
resource "aws_route_table" "priv-rt-b" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-b.id
  }

  tags   = {
    Name = "Priv-rt-b"
  }
}

# Associate Private Subnet `priv-sub-5a` with private route `priv-rt-b'
resource "aws_route_table_association" "priv-sub-5a-with-priv-rt-b" {
  subnet_id         = var.priv_sub_5a_id
  route_table_id    = aws_route_table.priv-rt-b.id
}

# Associate Private Subnet `priv-sub-6b` with private route table 'priv-rt-b`
resource "aws_route_table_association" "priv-sub-6b-with-priv-rt-b" {
  subnet_id         = var.priv_sub_6b_id
  route_table_id    = aws_route_table.priv-rt-b.id
}
