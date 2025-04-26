module "networking" {
  source = "../../modules/networking"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]

  tags = {
    Environment = "dev"
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

module "security" {
  source = "../../modules/security"

  vpc_id       = module.networking.vpc_id
  environment  = "dev"
  project_name = var.project_name

  tags = {
    Environment = "dev"
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

module "compute" {
  source = "../../modules/compute"

  vpc_id                  = module.networking.vpc_id
  public_subnet_ids       = module.networking.public_subnet_ids
  private_subnet_ids      = module.networking.private_subnet_ids
  alb_security_group_id   = module.security.alb_security_group_id
  ec2_security_group_id   = module.security.ec2_security_group_id
  ec2_instance_profile_name = module.security.ec2_instance_profile_name
  environment             = "dev"
  project_name            = var.project_name
  instance_type           = "t3.micro"
  min_size                = 1
  max_size                = 3
  desired_capacity        = 2

  tags = {
    Environment = "dev"
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

module "database" {
  source = "../../modules/database"

  vpc_id               = module.networking.vpc_id
  private_subnet_ids   = module.networking.private_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id
  environment          = "dev"
  project_name         = var.project_name
  
  db_name              = "myappdb"
  db_username          = "admin"
  db_password          = "your-secure-password"  # In production, use AWS Secrets Manager or SSM Parameter Store
  db_instance_class    = "db.t3.micro"
  db_engine            = "mysql"
  db_engine_version    = "8.0"
  db_allocated_storage = 20
  db_multi_az          = false
  
  tags = {
    Environment = "dev"
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
} 