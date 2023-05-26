variable "container_image" {
  description = "Container default image"
  type        = string
}

variable "cluster_name" {
  description = "cluster_name"
  type        = string
}


variable "cluster_service_name" {
  description = "cluster service name"
  type        = string
}

variable "desired_count" {
  description = "the number of services"
  type        = number
  default = 1
}


variable "launch_type" {
  description = "Service launch type"
  type        = string
  default = "FARGATE"
}


variable "container_name" {
  description = "container name"
  type        = string
  default = "django"
}

variable "container_port" {
  description = "Container / host port"
  type        = number
  default = 80
}