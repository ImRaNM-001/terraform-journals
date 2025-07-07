# Terraform Journals

A progressive journey through infrastructure-as-code using Terraform, from basics to production-ready architectures.

## Task-1: Getting Started
Basic Terraform setup with AWS provider configuration and simple EC2 instance deployment.

## Task-2: Modules
Organizing infrastructure with reusable modules. Created an EC2 module with inputs, outputs, and proper variable handling.

## Task-3: Remote Backend
Implementing S3 as a remote backend for state management, enabling team collaboration and state locking.

## Task-4: Provisioners
Deploying EC2 instances with FastAPI application using file and remote-exec provisioners for configuration management.

## Task-5: Workspaces
Managing multiple environments (dev, test, staging) with Terraform workspaces and environment-specific variable files.

## Task-6: EKS by Module
Deploying Kubernetes clusters on AWS using the EKS module with proper IAM roles, networking, and access configurations.

## Task-7: Deploy App with ALB
Multi-tier architecture with VPC, public/private subnets, NAT gateways, Application Load Balancer, Auto Scaling Group, and RDS database.

> The application can be accessed via elastic load balancer `A record` in web browser as below,
---
<p align="center">
  <img src="./Task-7-deploy-app-ALB/app access via elb A record.png" alt="" width="800"/>
</p>

---