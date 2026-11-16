
# AWS Cloud Infrastructure Automation with Terraform

A modular Infrastructure as Code (IaC) project that provisions and manages AWS cloud infrastructure using Terraform.

This project demonstrates practical skills in AWS networking, EC2 compute, infrastructure automation, security, monitoring, and Git version control.

## Architecture

```text
                  AWS Cloud (us-east-1)
                           |
                    VPC (10.0.0.0/16)
                           |
                  Public Subnet
                    10.0.1.0/24
                           |
                 EC2 (Amazon Linux 2023)
                           |
                   CloudWatch Alarm
                           |
                       SNS Topic
                           |
                   Email Notification

Internet Gateway --> Public Route Table
                           |
                      Public Subnet
```

## AWS Services

- Amazon VPC — Isolated virtual network
- Amazon EC2 — Linux virtual machine
- Internet Gateway — Internet connectivity
- Security Groups — Network access controls
- Amazon CloudWatch — CPU monitoring and alarms
- Amazon SNS — Email alert notifications
- AWS IAM Identity Center — SSO-based AWS authentication

## Terraform Modules

The infrastructure is organised into three reusable modules:

| Module | Purpose |
|--------|---------|
| Networking | VPC, subnet, internet gateway, route table, security group |
| Compute | EC2 instance and SSH key pair |
| Monitoring | CloudWatch CPU alarm, SNS topic and email subscription |

## Project Structure

```text
terraform-aws-infrastructure/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── .terraform.lock.hcl
├── .gitignore
├── README.md
└── modules/
    ├── networking/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── compute/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── monitoring/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Prerequisites

- Terraform CLI
- AWS CLI
- AWS account with appropriate permissions
- Configured AWS CLI profile

## Deployment

Authenticate with AWS:

```powershell
aws sso login --profile terraform-sso
```

Initialise Terraform:

```powershell
terraform init
```

Format and validate:

```powershell
terraform fmt -recursive
terraform validate
```

Review infrastructure changes:

```powershell
terraform plan
```

Deploy:

```powershell
terraform apply
```

Review managed resources:

```powershell
terraform state list
```

> Note: Deployment requires valid AWS credentials and appropriate IAM permissions. Review the configuration, access rules, and AWS costs before applying.

## Security Considerations

- AWS authentication uses SSO rather than hardcoded credentials.
- SSH access is restricted using a specific source IP.
- Terraform state files and private keys are excluded from Git.
- Security groups control inbound and outbound access.
- Terraform resource lifecycle protection helps prevent accidental EC2 destruction.

## Current Status

- Modular Terraform infrastructure deployed successfully
- 13 AWS resources managed in Terraform state
- EC2 instance stopped to reduce running costs
- CloudWatch CPU alarm and SNS email notification configured
- Infrastructure migrated into reusable modules without resource replacement
- Project tracked using Git and hosted on GitHub

## Future Improvements

- Automate Nginx installation and configuration
- Add EC2 user-data bootstrap scripts
- Improve monitoring and logging
- Add automated Terraform validation with GitHub Actions
- Expand documentation and architecture diagrams

## Author

Sai Tharun Puli

[LinkedIn](https://www.linkedin.com/in/pulisaitharun/)
