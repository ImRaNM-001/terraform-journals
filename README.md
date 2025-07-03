# terraform-journals



## Task4
- command to generate an ssh key pair
```bash
ssh-keygen -t rsa
```

- ssh login to ec2 instance to run the application
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<EC2-PUBLIC-IP>
```


## Task5
(creates & auto-switches to workspace)
tf workspace new <workspace-env>
ex: tf workspace new dev

(switch to workspace manually)
tf workspace select <workspace-env>
ex: tf workspace select dev

(see `current workspace`)
tf workspace show
        --> dev

(list `all workspaces`)
tf workspace list
        -->  default
            dev
            * stage
            test

(plan with a specific `env tfvar` file)
tf plan -var-file=<workspace-env>.tfvars
ex: tf plan -var-file=dev.tfvars

(apply with a specific `env tfvar` file)
tf apply -var-file=<workspace-env>.tfvars
ex: tf apply -var-file=dev.tfvars


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






