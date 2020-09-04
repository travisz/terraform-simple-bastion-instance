# Bastion Instance

Terraform for creating a simple Bastion Instance

Create a variable file (vars) and add the following (customized as needed):
```bash
environment = "your-environment-name"
vpc_id = "vpc-0832xxx"
key_name = "existing-key-name"
subnet_id = "subnet-005e1xxx"
allowed_ips = ["127.0.0.1/32", "127.0.0.2/32"]
```

Execute:
```bash
terraform init
terraform plan -var-file=vars
terraform apply -var-file=vars
```
