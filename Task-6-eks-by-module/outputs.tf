output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint of the EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster Control Plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region in which the cluster is created"
  value       = var.aws_region
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}


