variable "repo_name" {
  description = "Aws repo name"
  default     = "django-app"
  type        = string
  sensitive   = false
}

variable "region" {
  description = "Aws Region"
  default     = "us-east-1"
  type        = string
  sensitive   = false
}
