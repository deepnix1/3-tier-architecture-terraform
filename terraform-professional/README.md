# Terraform AWS 3-Tier Architecture

This project implements a production-grade 3-tier architecture on AWS using Terraform. The architecture includes:

- VPC with public and private subnets
- NAT Gateway for private subnet internet access
- Application Load Balancer
- EC2 instances in private subnets
- RDS database in private subnets
- Security groups and IAM roles

## Directory Structure

```
.
├── environments/           # Environment-specific configurations
│   ├── dev/               # Development environment
│   └── prod/              # Production environment
├── modules/               # Reusable Terraform modules
│   ├── networking/        # VPC, subnets, NAT Gateway
│   ├── compute/          # EC2 instances, ALB
│   ├── database/         # RDS configuration
│   └── security/         # Security groups, IAM roles
└── scripts/              # Automation scripts
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- S3 bucket for Terraform state storage
- DynamoDB table for state locking

## Usage

### Windows (PowerShell)

```powershell
# Initialize and plan
.\scripts\terraform.ps1 -Environment dev -Action plan

# Apply changes
.\scripts\terraform.ps1 -Environment dev -Action apply

# Destroy infrastructure
.\scripts\terraform.ps1 -Environment dev -Action destroy
```

### Linux/Mac (Bash)

```bash
# Initialize and plan
./scripts/terraform.sh dev plan

# Apply changes
./scripts/terraform.sh dev apply

# Destroy infrastructure
./scripts/terraform.sh dev destroy
```

## Backend Configuration

The project uses S3 with DynamoDB locking for state management. Update the `backend.tf` file with your S3 bucket and DynamoDB table names.

## Contributing

1. Create a feature branch
2. Make your changes
3. Run `terraform fmt` and `terraform validate`
4. Commit changes with the format: `[Terraform] <Short description>`
5. Push to the repository

## License

This project is licensed under the MIT License - see the LICENSE file for details. 