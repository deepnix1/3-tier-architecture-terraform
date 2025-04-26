terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"  # Replace with your bucket name
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"    # Replace with your DynamoDB table name
    encrypt        = true
  }
} 