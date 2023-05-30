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


resource "aws_ecrpublic_repository" "container_repository" {
  repository_name = var.repo_name
  catalog_data {
    about_text  = "Django repo"
    description = "Description"
    usage_text  = "Usage Text"
  }

  tags = {
    env  = "production"
    name = "django"
  }
}