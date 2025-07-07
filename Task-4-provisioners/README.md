# terraform-journals

## Task-4: EC2 Provisioning with FastAPI

### Prerequisites

- Command to generate SSH key pair:
```sh
  ssh-keygen -t rsa
  ```

### Deployment Structure

- VPC with internet gateway
- 2 public subnets across availability zones
- Security group (ports 22, 80)
- EC2 instance with SSH key authentication
- Terraform provisioners (file, remote-exec)

### Connect to EC2 Instance to run the application

```sh
ssh -i ~/.ssh/id_rsa ubuntu@<EC2-PUBLIC-IP>
```

### Application Details

- FastAPI application running on port 80
- Deployed via remote-exec provisioner
- Files provisioned:
  - app.py
  - requirements.txt

### Project Files

- `main.tf` - Core infrastructure (VPC, subnets, etc.)
- `provisioner.tf` - EC2 instance with provisioners
- `variables.tf` - Configuration variables
- `terraform.tfvars` - Variable values
- `app.py` - FastAPI application code