terraform {
  backend "s3" {
    bucket = "hf-samsum-data"
    key    = "task3-remote-be/terraform.tfstate.backup"
    region = "ap-south-1"
    encrypt = true    
    use_lockfile = true       # using native S3 locking mechanism
  }
}

