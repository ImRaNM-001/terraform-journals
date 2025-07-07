resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.priv_sub_5a_id, var.priv_sub_6b_id]             # Replaced with private subnet IDs
}

resource "aws_db_instance" "db" {
  identifier              = "bookdb-instance"
  engine                  = "mysql"
  engine_version          = "8.0.42"
  instance_class          = "db.t3.medium"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  storage_type            = "gp3"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id]               # Replace with the desired security group ID
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  tags = {
    Name = var.db_name
  }
}
