# Initialize the Terraform configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = var.region
}


# create a public ECR
module "public_ecr" {
  source = "terraform-aws-modules/ecr/aws"
  repository_name = var.repo_name
  repository_type = "public"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

