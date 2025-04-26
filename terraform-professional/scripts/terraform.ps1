param(
    [Parameter(Mandatory=$true)]
    [string]$Environment,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("plan", "apply", "destroy")]
    [string]$Action = "plan"
)

# Validate environment
if (-not (Test-Path "environments\$Environment")) {
    Write-Error "Error: Environment '$Environment' does not exist"
    exit 1
}

# Change to environment directory
Set-Location "environments\$Environment"

# Initialize Terraform
terraform init -backend-config="..\..\backend.tf"

# Format and validate
terraform fmt -recursive
terraform validate

# Execute the requested action
switch ($Action) {
    "plan" {
        terraform plan
    }
    "apply" {
        terraform apply -auto-approve
    }
    "destroy" {
        terraform destroy -auto-approve
    }
    default {
        Write-Error "Error: Invalid action '$Action'"
        exit 1
    }
} 