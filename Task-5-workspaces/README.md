# terraform-journals

## Task-5: Terraform Workspaces

### Workspace Management

**Creating workspaces:**
```sh
# Creates & auto-switches to workspace
tf workspace new <workspace-env>
# Examples:
tf workspace new dev
tf workspace new test
tf workspace new stage
```

**Workspace navigation:**
```sh
# Switch to workspace manually
tf workspace select <workspace-env>
# Examples:
tf workspace select dev

# See current workspace
tf workspace show
# --> dev

# List all workspaces
tf workspace list
# -->  default
#     dev
#     * stage
#     test
```

### Working with environment-specific variables

```sh
# Plan with a specific `env tfvar` file
tf plan -var-file=<workspace-env>.tfvars
# Examples:
tf plan -var-file=dev.tfvars

# Apply with a specific env tfvar file
tf apply -var-file=<workspace-env>.tfvars
# Examples:
tf apply -var-file=dev.tfvars
```

### Project Structure

```sh
tree
.
├── dev.tfvars
├── main.tf
├── modules
│   └── ec2_instance
│       ├── main.tf
│       ├── providers.tf
│       └── variables.tf
├── providers.tf
├── stage.tfvars
├── terraform.tfstate.d
│   ├── dev
│   ├── stage
│   └── test
├── test.tfvars
└── variables.tf

6 directories, 9 files
```