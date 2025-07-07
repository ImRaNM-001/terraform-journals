resource "aws_security_group" "all_workers" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "all_workers_ingress" {
  description       = "Allow Inbound Traffic from EKS"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  security_group_id = aws_security_group.all_workers.id
  type              = "ingress"
  cidr_blocks = var.security_group_cidr_blocks
}

resource "aws_security_group_rule" "all_workers_egress" {
  description       = "Allow Outbound Traffic to Anywhere"
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.all_workers.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}



