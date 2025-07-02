# Module output variables
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.iac_instance.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value = aws_instance.iac_instance.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.iac_instance.public_dns
}