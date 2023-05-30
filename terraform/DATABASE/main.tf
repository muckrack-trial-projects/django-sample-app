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


# Create a VPC 
resource "aws_vpc" "ecs_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired VPC CIDR block
}

# MySQL db
resource "aws_db_instance" "mysql_instance" {
  identifier             = "my-mysql-instance"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  publicly_accessible    = true
  skip_final_snapshot    = true
}


# Creating a AWS Secret for mysql username for the django app
resource "aws_secretsmanager_secret" "db_username" {
  name                    = "db_username"
  description             = "mysql username for the django app"
  recovery_window_in_days = 0
  tags = {
    Name = "db_username"
  }
}

resource "aws_secretsmanager_secret_version" "db_username_version" {
  secret_id     = aws_secretsmanager_secret.db_username.id
  secret_string = var.db_username
}

# Creating a AWS Secret for Password username for the django app
resource "aws_secretsmanager_secret" "db_password" {
  name                    = "db_password"
  description             = "mysql Password for the django app"
  recovery_window_in_days = 0
  tags = {
    Name = "db_password"
  }
}
resource "aws_secretsmanager_secret_version" "db_password_version" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}


## reating a AWS Secret for Password mysql_url for the django app
resource "aws_secretsmanager_secret" "mysql_url" {
  name                    = "db_host"
  description             = "mysql Password for the django app"
  recovery_window_in_days = 0
  tags = {
    Name = "mysql_url"
  }
}

# Use the split function to get the first part of the 
# the url without the port number
resource "aws_secretsmanager_secret_version" "mysql_url_version" {
  secret_id     = aws_secretsmanager_secret.mysql_url.id
  secret_string = split(":", aws_db_instance.mysql_instance.endpoint)[0]
}


## Creating a AWS Secret for DB name for the django app
resource "aws_secretsmanager_secret" "db_name" {
  name                    = "db_name_dev"
  description             = "mysql host for the django app"
  recovery_window_in_days = 0
  tags = {
    Name = "db_name"
  }
}
resource "aws_secretsmanager_secret_version" "db_host_version" {
  secret_id     = aws_secretsmanager_secret.db_name.id
  secret_string = var.db_name
}