/* This file defines local variables for the EKS cluster deployment using Terraform.
Locals allow us to assign a name to an expression, so we can use it multiple times without repeating it. They help improve readability and maintainability by centralizing common values and computed expressions used across the configuration.

Local variables defined here may include:
- Computed tags
- Normalized resource names
- Conditional expressions
- Other reusable values for the EKS configuration       */

locals {
  cluster_name = "task-6-eks-by-module-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}