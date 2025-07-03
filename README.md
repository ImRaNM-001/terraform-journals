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