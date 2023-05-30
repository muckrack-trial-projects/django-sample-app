variable "db_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  sensitive   = true
}


variable "region" {
  description = "Aws Region"
  default     = "us-east-1"
  type        = string
  sensitive   = false
}
