# terraform-journals

## Task-6: EKS Cluster with Terraform

### Useful Commands

- **Get your AWS ARN:**  
  `aws sts get-caller-identity`

- **Check provider constraints:**  
  `terraform providers`

### Example `terraform.tfvars`
```hcl
kubernetes_version         = "1.32"
node_group_ami_type        = "AL2023_x86_64_STANDARD"      # source: https://docs.aws.amazon.com/eks/latest/APIReference/API_CreateNodegroup.html
node_group_instance_type   = "t2.micro"
security_group_cidr_blocks = ["x.0.x.x/8", "x.x.0.0/12", "x.x.x.x/16"]
vpc_cidr                   = "x.x.x.0/16"
aws_region                 = "ap-south-1"
iam_user_arn               = "arn:aws:iam::<USER_ACCOUNT_ID>:user/<USER_NAME>"
```

---

### Common Issues & Solutions

#### 1. Module Version Pinning
```hcl
module "eks" {
  version = "20.37.1"           # Enforced Explicit Hardcoding
}
```

#### 2. AWS Provider Version
```hcl
aws = {
  source  = "hashicorp/aws"
  version = "~> 5.95.0"                 # Changed from 6.2.0 so to be compatible with EKS module
}
```
#### 3. Permission Issues

**Missing permissions initially:**
- logs:CreateLogGroup
- logs:TagResource
- iam:CreateRole
- iam:CreatePolicy
- iam:AttachRolePolicy
- iam:PassRole
- kms:CreateKey
- kms:TagResource
- kms:DescribeKey
- kms:CreateAlias

- eks:CreateCluster
- eks:DescribeCluster
- eks:TagResource

**Required AWS managed policies to the `IAM user`:**
- AmazonEKSClusterPolicy
- AmazonEKSServicePolicy
- AmazonEKSWorkerNodePolicy
- IAMFullAccess                 (removed after setup)
- CloudWatchLogsFullAccess
- AWSKeyManagementServicePowerUser
- EKSDescribeClusterVersionsPolicy  (updated with the last 3 of `eks`)

**Attach these 5 policies via CLI to the `IAM user`:**
**or, or check if present in UI console of `IAM` service:**
```sh
aws iam attach-user-policy --user-name hf-samsum-data-ingest-user --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
aws iam attach-user-policy --user-name hf-samsum-data-ingest-user --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-user-policy --user-name hf-samsum-data-ingest-user --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
aws iam attach-user-policy --user-name hf-samsum-data-ingest-user --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess
aws iam attach-user-policy --user-name hf-samsum-data-ingest-user --policy-arn arn:aws:iam::aws:policy/PowerUserAccess
```

#### 4. Kubernetes Version Error

- Use only supported versions: `1.32`, `1.31`, `1.30`, `1.29`           (v_`1.32.2` was invalid one)
- Check supported versions:
```sh
aws eks describe-addon-versions --query 'addons[0].addonVersions[0].compatibilities[*].clusterVersion' --output table

        DescribeAddonVersions|
        +---------------------+
        |  1.32               |
        |  1.31               |
        |  1.30               |
        |  1.29               |
  ```

#### 5. Debugging

- While working with Codespaces, the Error log (in terminal) gets truncated,

- Solution: Enable Terraform debug logging:
```sh
  export TF_LOG=DEBUG
  export TF_LOG_PATH=terraform-debug.log
  terraform apply
  ```

Then check the detailed logs:
```sh
grep -i "AccessDenied\|403\|error" terraform-debug.log
```

---

### Check `EKS` Cluster Access

- **Get cluster info first using `eksctl` utility:**
```sh
el get cluster --region=<REGION_NAME> --name=<CLUSTER_NAME>
ex: el get cluster --region ap-south-1 --name task-6-eks-by-module-co4yMVQZ

        NAME				VERSION	STATUS		CREATED			VPC			SUBNETS							SECURITYGROUPS		PROVIDER
        task-6-eks-by-module-co4yMVQZ	1.32	UPDATING	2025-07-05T15:43:27Z	vpc-XXXdXXXX159d595cd	subnet-06c4XXX544XX5,subnet-0fXXX1XXX25f7f9	sg-XXXX34935bXXXX19	EKS
  ```

- **Update kubeconfig file so that `kubectl` can interact with the cluster:**
```sh
  aws eks update-kubeconfig --region <REGION_NAME> --name <CLUSTER_NAME>
  ex: aws eks update-kubeconfig --region ap-south-1 --name task-6-eks-by-module-co4yMVQZ

        Added new context arn:aws:eks:ap-south-1:2XXXXQ24XX0:cluster/task-6-eks-by-module-co4yMVQZ to /home/ubuntu/.kube/config
  ```

- **Check current context ie, which cluster you are pointed too:**
```sh
kl config current-context
        
        arn:aws:eks:ap-south-1:2XXXXQ24XX0:cluster/task-6-eks-by-module-co4yMVQZ
  ```

- **Test cluster access (only applies if `nodes` are NOT placed on private subnet which is less likely):**
```sh
kl get nodes
kl get pods --all-namespaces
  ```

---

### View cluster output via `Terraform`

```sh
terraform output     

        cluster_endpoint = "https://71DXXXDXXXX74BFF0BCFXXXX6AXXAF.gr7.ap-south-1.eks.amazonaws.com"
        cluster_security_group_id = "sg-039cXXXX5b2XX19"
        oidc_provider_arn = "arn:aws:iam::2XXXXQ24XX0:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/71DXXXDXXXX74BFF0BCFXXXX6AXXAF"
        region = "ap-south-1"
```

---

### Finally, CLEAN UP all resources

```sh
terraform destroy

        random_string.suffix: Destroying... [id=coXXXQZ]
        random_string.suffix: Destruction complete after 0s

        Destroy complete! Resources: 59 destroyed.
```







