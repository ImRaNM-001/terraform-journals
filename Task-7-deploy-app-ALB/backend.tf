terraform {
  backend "s3" {
    bucket = "task-3-remote-backend"
    key    = "Task-7-deploy-app-ALB/terraform.tfstate.backup"
    region = "ap-south-1"
    encrypt = true    
    use_lockfile = true       # using native S3 locking mechanism
  }
}

