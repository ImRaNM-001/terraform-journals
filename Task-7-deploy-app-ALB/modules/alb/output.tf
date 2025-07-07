output "target_grp_arn" {
    description = "Target Group ARN for the Application Load Balancer"
    value = aws_lb_target_group.alb_target_group.arn
}

output "alb_dns_name" {
    description = "DNS name for the Application Load Balancer"
    value = aws_lb.application_load_balancer.dns_name
}
