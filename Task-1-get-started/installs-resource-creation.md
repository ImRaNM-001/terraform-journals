(created an `alias`)
```bash
echo 'alias tf="terraform"' >> ~/.zshrc
source ~/.zshrc
```

(check `terraform version`)
```bash
tf --version

    Terraform v1.12.2
    on linux_amd64
```

(initialize terraform in current repo / working directory)
```bash
tf init

    Initializing the backend...
    Initializing provider plugins...
    - Finding latest version of hashicorp/aws...
    - Installing hashicorp/aws v6.0.0...
    - Installed hashicorp/aws v6.0.0 (signed by HashiCorp)
    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.

    Terraform has been successfully initialized!

    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.

    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
```

(perform a DRY run)
```bash
tf plan

    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # aws_instance.example will be created
    + resource "aws_instance" "example" {
        + ami                                  = "ami-0f918f7e67a3323f0"
        + arn                                  = (known after apply)
        + associate_public_ip_address          = (known after apply)
        + availability_zone                    = (known after apply)
        + disable_api_stop                     = (known after apply)
        + disable_api_termination              = (known after apply)
        + ebs_optimized                        = (known after apply)
        + enable_primary_ipv6                  = (known after apply)
        + get_password_data                    = false
        + host_id                              = (known after apply)
        + host_resource_group_arn              = (known after apply)
        + iam_instance_profile                 = (known after apply)
        + id                                   = (known after apply)
        + instance_initiated_shutdown_behavior = (known after apply)
        + instance_lifecycle                   = (known after apply)
        + instance_state                       = (known after apply)
        + instance_type                        = "t2.nano"
        + ipv6_address_count                   = (known after apply)
        + ipv6_addresses                       = (known after apply)
        + key_name                             = "xxxx-key"
        + monitoring                           = (known after apply)
        + outpost_arn                          = (known after apply)
        + password_data                        = (known after apply)
        + placement_group                      = (known after apply)
        + placement_partition_number           = (known after apply)
        + primary_network_interface_id         = (known after apply)
        + private_dns                          = (known after apply)
        + private_ip                           = (known after apply)
        + public_dns                           = (known after apply)
        + public_ip                            = (known after apply)
        + region                               = "ap-south-1"
        + secondary_private_ips                = (known after apply)
        + security_groups                      = (known after apply)
        + source_dest_check                    = true
        + spot_instance_request_id             = (known after apply)
        + subnet_id                            = (known after apply)
        + tags_all                             = (known after apply)
        + tenancy                              = (known after apply)
        + user_data_base64                     = (known after apply)
        + user_data_replace_on_change          = false
        + vpc_security_group_ids               = (known after apply)

        + capacity_reservation_specification (known after apply)

        + cpu_options (known after apply)

        + ebs_block_device (known after apply)

        + enclave_options (known after apply)

        + ephemeral_block_device (known after apply)

        + instance_market_options (known after apply)

        + maintenance_options (known after apply)

        + metadata_options (known after apply)

        + network_interface (known after apply)

        + private_dns_name_options (known after apply)

        + root_block_device (known after apply)
        }

    Plan: 1 to add, 0 to change, 0 to destroy.
```

(provision the resource)
```bash
tf apply

        Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # module.ec2_instance.aws_instance.iac_instance will be created
        + resource "aws_instance" "iac_instance" {
            + ami                                  = "ami-0f918f7e67a3323f0"
            + arn                                  = (known after apply)
            + associate_public_ip_address          = (known after apply)
            + availability_zone                    = (known after apply)
            + disable_api_stop                     = (known after apply)
            + disable_api_termination              = (known after apply)
            + ebs_optimized                        = (known after apply)
            + enable_primary_ipv6                  = (known after apply)
            + get_password_data                    = false
            + host_id                              = (known after apply)
            + host_resource_group_arn              = (known after apply)
            + iam_instance_profile                 = (known after apply)
            + id                                   = (known after apply)
            + instance_initiated_shutdown_behavior = (known after apply)
            + instance_lifecycle                   = (known after apply)
            + instance_state                       = (known after apply)
            + instance_type                        = "t2.nano"
            + ipv6_address_count                   = (known after apply)
            + ipv6_addresses                       = (known after apply)
            + key_name                             = "xxxx-key"
            + monitoring                           = (known after apply)
            + outpost_arn                          = (known after apply)
            + password_data                        = (known after apply)
            + placement_group                      = (known after apply)
            + placement_partition_number           = (known after apply)
            + primary_network_interface_id         = (known after apply)
            + private_dns                          = (known after apply)
            + private_ip                           = (known after apply)
            + public_dns                           = (known after apply)
            + public_ip                            = (known after apply)
            + region                               = "ap-south-1"
            + secondary_private_ips                = (known after apply)
            + security_groups                      = (known after apply)
            + source_dest_check                    = true
            + spot_instance_request_id             = (known after apply)
            + subnet_id                            = (known after apply)
            + tags                                 = {
                + "Name"    = "terraform-journals-task2-ec2-instance"
                + "Project" = "terraform-journals"
                }
            + tags_all                             = {
                + "Name"    = "terraform-journals-task2-ec2-instance"
                + "Project" = "terraform-journals"
                }
            + tenancy                              = (known after apply)
            + user_data_base64                     = (known after apply)
            + user_data_replace_on_change          = false
            + vpc_security_group_ids               = (known after apply)

            + capacity_reservation_specification (known after apply)

            + cpu_options (known after apply)

            + ebs_block_device (known after apply)

            + enclave_options (known after apply)

            + ephemeral_block_device (known after apply)

            + instance_market_options (known after apply)

            + maintenance_options (known after apply)

            + metadata_options (known after apply)

            + network_interface (known after apply)

            + private_dns_name_options (known after apply)

            + root_block_device (known after apply)
            }

        Plan: 1 to add, 0 to change, 0 to destroy.
        module.ec2_instance.aws_instance.iac_instance: Creating...
        module.ec2_instance.aws_instance.iac_instance: Still creating... [00m10s elapsed]
        module.ec2_instance.aws_instance.iac_instance: Creation complete after 12s [id=i-0ad76495bf1721b55]
```

## about (.terraform.lock.hcl) file:

**The .terraform.lock.hcl file should NOT be gitignored.** It should be committed to version control.

### Why we should commit this file:

1. **Provider version consistency**: This file locks the exact provider versions and hashes, ensuring all team members and CI/CD pipelines use the same provider versions.

2. **Reproducible deployments**: It prevents unexpected behavior due to provider version differences between environments.

3. **HashiCorp recommends it**: The official Terraform documentation explicitly states this file should be committed to version control.

### What to gitignore instead:

You should add the following to your .gitignore:

```
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*


(destroy the created resources)
```bash
tf destroy
```


