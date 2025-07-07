output "key_name" {
  value = aws_key_pair.client_key.key_name        # calling from resource block: Task-7-deploy-app-ALB/modules/key-pair/main.tf
}
