output "alb_sg_id" {
    description = "Security Group ID for the Application Load Balancer"
    value = aws_security_group.alb_sg.id
}

output "client_sg_id" {
    description = "Security Group ID for the Client"
    value = aws_security_group.client_sg.id
}

output "db_sg_id" {
    description = "Security Group ID for the DB Instance"
    value = aws_security_group.db_sg.id
}
