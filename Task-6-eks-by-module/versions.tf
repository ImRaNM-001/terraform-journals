terraform {
  required_version = ">= 1.12.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.37.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"       # Changed from 6.2.0 to match EKS module requirements
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.4"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.7"
    }
  }
}


