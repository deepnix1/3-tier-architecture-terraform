#!/bin/bash

# Check if environment is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <environment> [plan|apply|destroy]"
    exit 1
fi

ENVIRONMENT=$1
ACTION=${2:-plan}

# Validate environment
if [ ! -d "environments/$ENVIRONMENT" ]; then
    echo "Error: Environment '$ENVIRONMENT' does not exist"
    exit 1
fi

# Change to environment directory
cd "environments/$ENVIRONMENT"

# Initialize Terraform
terraform init -backend-config="../../backend.tf"

# Format and validate
terraform fmt -recursive
terraform validate

# Execute the requested action
case $ACTION in
    plan)
        terraform plan
        ;;
    apply)
        terraform apply -auto-approve
        ;;
    destroy)
        terraform destroy -auto-approve
        ;;
    *)
        echo "Error: Invalid action '$ACTION'"
        exit 1
        ;;
esac 